Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D457657F0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjG0Pmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjG0Pmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:42:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62322D5E;
        Thu, 27 Jul 2023 08:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2Weh+xQ2rpMZ5NaIe1kCAiriNhK0FdxGwSeymrGgNCy0rEucBvutQzr1Z5mOXgKtJJV8nK8hIseeUDDVkaTApHRb2Fw3GePjVICM9Txozfhq5fFquFoI5P9blP7GR+plr4Ne8R9tJ/srqoDzzmCAhFs7sHZuDPO/u7Du54O9mLD7YhL+Al26mLhAaU1YdtUscOhAlbl34Lvnrn3Uqdoexth391we9xczJf1+NryD1RYwzrFaUEeyK/h6JXMRNwyb/amNfkaB5GdjnRqCGMxMeGEs6Kl/X9UVDciLXca7SbUa5Y3aoD9nzbuRyFIbKrKo2zOQJKGhMLpTI1XMZm63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DCrRUjpWJM5vceKx8n4eGXm28TuOXcuQgGavwUIYFo=;
 b=ZeVt8jcsXPlZ8wLEr8V+V8Xdt1kyJkdE0dQz1PrERMqBxd0ywl8SYcrD1VGuDqDMb5YYWih02Sa0mal7XTqI0xE5XENSTy14Fdfx0KhfSNV2Lbo8/rfCFMd4Vt2Qn3I0DSlluIf8ghCuXOVvrz/8KjW16naCwvViPJ7GzFH15ohq8TwlmP70y2iLkJF3LJ1c2MvsQdssx2Q8FNYlIA2sgItqPeTRNpBgxHrUNQrccTjBCRAizclwIw9a6DnrmteOWib52dAfG62DvGkWAS6w3PPyZMrmWwk0GG1ITpA6tlcEDmjIesGE4CL/UPvVzdK+B0I0NbvfnAUYhqiY2kf/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DCrRUjpWJM5vceKx8n4eGXm28TuOXcuQgGavwUIYFo=;
 b=o7F0/X4nQbzTiqHPmHl5/zQChn/1dky7aeTuykcJJPXiAaIet/0+4y+ofdgt9cNnlOOThIaiiec3D1C6BxZcM3KnX4q48OjtSdhv+438PkCZJL0aEfqVOKssEIqbTTs2Hsd+VdtH0dww4dqe/tv4BAsCHFp4iuFN9LDf96v6l9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4878.namprd12.prod.outlook.com (2603:10b6:5:1b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 15:42:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 15:42:36 +0000
Message-ID: <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
Date:   Thu, 27 Jul 2023 10:42:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     Daniil Stas <daniil.stas@posteo.net>
Cc:     James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org, torvalds@linux-foundation.org
References: <20230727183805.69c36d6e@g14>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230727183805.69c36d6e@g14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0104.namprd12.prod.outlook.com
 (2603:10b6:802:21::39) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f30098-b041-4821-c012-08db8eb819ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UV4iURyVK+iWk/B8tDCb3WUu/2H1sSrCkga2YWR8qmJQNTaHQ6S3MS+Wmj08XJk7cdlsHYbp0Pl0kuPfdz278eAYv/3jwhLTFqyGaOlSLrKXspI+axLCmMixentDfYzlPXvTe44feNbHd64u9z5px44E4KmZT/ddweviGuNtA3nq0MIYBlHOVSu0H534Q+Wlfb9Q2hRzpMp1+qigBUSBhhUuWRNPyAk2z8tL+3Pod/Hg+b+oKeQJR1ls0lsGguM/qQ4+3nM+fNH7DDs2ligE8CY/xuamF8xFys4ru1anbc2BWCWGQRYSg7foT5Ctj3gGtNaTGPGscXNvGXfPA5ZGpH4Fko2sW45YjRwxoxGE9udNkqSV3cxXt+8Ye5iUnwYVwGMvvBgbzOUo63Pfbm0HRN0f7iS+WMRk59gw3yP1hp9ybt+2a9KOTmPguEU+plonrLn8nUp7VO4ErNWeoIKR5Eu2/l10lGNBPpuh65JgNV+zB6y179wKC5lX/jF61U6x00mraW77ml0OmQ+xSFPesfRi6FOayvKRYGzsfubOAxK579SO/go7GBxcCD0fQ+RaFgL4kOmG3YAzyk9+gq0BHIJ/Zi66qnu0HITQJtp2xeJMXtac24XiXXoAKGnXQOMzVNuuZiYnBoTLEvsichucUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(316002)(41300700001)(8676002)(8936002)(26005)(6506007)(53546011)(6916009)(4326008)(66946007)(66476007)(6512007)(478600001)(66556008)(6666004)(6486002)(36756003)(38100700002)(4744005)(2616005)(2906002)(83380400001)(86362001)(31686004)(31696002)(186003)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2NrZ0g0VExRVnlSYVNySVVKQ2twNEZ1ZmlvdUZiaDBiS3BwTElLOFlUUllC?=
 =?utf-8?B?eTY1a1hvVnRPOE85ZEdaWlRJRXRVTUVueHduaTRjcVEzTzl1YUpmQUxHVGo4?=
 =?utf-8?B?VjFUWk9OSnFjcG8wbmdMcEdSY2ljam5MaXlGSTlvTUtyNTY1N3JCa1liaVNK?=
 =?utf-8?B?RmJ0ajBZdHEva3pRMGVsaURCSkdlVG9CSm9VYi9lSU5pRlV0aWYyVGNZdmxN?=
 =?utf-8?B?eCtGRVd0cG1aaVhkQ3JmZHI0dkNvbUJZNzRqSERISjZ5TnUxWS83L2VLSnRP?=
 =?utf-8?B?KzFtRWNrWHR6bFJBdXhIQkd0OWRuc2djeXB3SUtMUWxEM29PVWVrZWpvMTNW?=
 =?utf-8?B?QTl2VklqSFM2M0NiQnRkV21uUUJkMVJzRDRRenR4YU9ZUzVHemtMdlRMQmdC?=
 =?utf-8?B?T1YwSTdtTE5Uc3hMa05WSkVKSGZTSmZyV0dLdERyejllQzgyRjkyNURjdHNY?=
 =?utf-8?B?eVAwTHRkNzArZWkvd0E0dXB3a2N4cnRRUWUzcndLYUZ4WjNCR09saVZubkZw?=
 =?utf-8?B?UUZ3bTdVNGw2QnkzenZVdFZJTHhCU1VtZElLU0RoQURWcHJncjZSY2o1Y2RW?=
 =?utf-8?B?NC9pYyt3UjlrOUpscFlpK21ua1lzZkJrTXNEb1pCUm1YaE1mdWNzTkJXaVhV?=
 =?utf-8?B?clBrbFdMU2pkZUVIQjBRMzR5YWlJMld6NzBTMDd1U0pxeklBQVBaNE5PMHhx?=
 =?utf-8?B?Ti9rQkhMV3VsRWVKdndxZWNLQ1VkRndGRmNDUlFhOGIrRHVqbVl6MVh2Wlph?=
 =?utf-8?B?VEZsU3VDVi9DWnN5SjNpRXlSdk9kaUlyVFgrTGZKMDI3K0tzLzR5ai9HUDAr?=
 =?utf-8?B?NURobnVJRnl4MHYzRmdxa1VLWGpXWk9XdEtrQWo5ZU0rMjRnRHcxRklQSHF5?=
 =?utf-8?B?SnFZdjJMb3FxUVpoTWtKSzNZOWtnVEUxWEYyV2RlZkcwRDhDSXBCTmNFQ2xi?=
 =?utf-8?B?VVllNHBTUm9nSTZjUmpVSUgya1daRUZ4eVhVbzRMODF4YWdXQXk1bWYwQUh0?=
 =?utf-8?B?KytNMmdNemxGMmQ2SDl4NktydkhUeVd5ZHgvR253cm5ZNGFUSGoyN29ZakVv?=
 =?utf-8?B?RW5uRUROd2t1Qm1LUlMzRHBPSDVsak44R2lhYlo3WkdkL2o0RHJLdEFQRXhp?=
 =?utf-8?B?T1FqbXMxbUNWMjFHMmN4VWZJQXNEM1ZlUG9qWGRQVTZUV3dYc1NpQU4xdENF?=
 =?utf-8?B?RnpWVTE0VDFlUXk2ZTJSK3FiUVBLLzZHa1REeVdSbVVjdjlBVkZTaDN6ZjlE?=
 =?utf-8?B?MFlBalpXdkJ0MlFyTWZ3SFNJSEtKU0x2a2ZGcEw2RlY1ZC9YcFBvUWFiTnY4?=
 =?utf-8?B?R1Ewc3BjR0Nna2VYdHlpa3ZUcll2K3hJSHQ4c1duWmNKeXFuZ01BUHFaVVFl?=
 =?utf-8?B?clV2cDNYRCs0dk01dXVGUlROUDRnK0N3VU9lMFVJL3RJY1ZqeWErdHVOME1Q?=
 =?utf-8?B?bmZwcGFWL05zSzdOK1lkUC9MbTdUT09BZ3VKWDdpa09Na1BUS1N5VDFqL2h4?=
 =?utf-8?B?U09vaVQ4cUZjbEJNaDFpNnZvZlBnbG1sZWFlZWc4ZkVTbGFDK2xoUDJaajZD?=
 =?utf-8?B?eFZJMjZlTjZENjJYZ2Zub28vYVRpL2ZZMGZkMFlGTmdrMEF6c3liWGhXMldC?=
 =?utf-8?B?WU1icFY4SWZlZVpla1lCK1h6ZXNHMFBiQmxQSG05N2NCQjlKMWpKekVlNnAz?=
 =?utf-8?B?TTltcHM1a09ucWpadVUyWlRRQWlQY3VDcGYzY1ZmRW1TL1hPQ3AzYWxDYmtI?=
 =?utf-8?B?aFY4OXd2RnJRWGR3STE4bG1XQmJlenlUU0ZnZkt2TFdadUlLNVh2Umt6Q2hl?=
 =?utf-8?B?RVFQOTI2UGw2UFIvVnFCTVlUVmlOZWNoTGhaMFYwbkt2d080NzUrSkR0RjdV?=
 =?utf-8?B?am1JWnAwM29EMitEaGFEZkhscE02RjN5YW1la3hIQy9uTzNmTHpWR0hKdnMv?=
 =?utf-8?B?S1VRNk4zczFqeGRSNkc4anNmeE03dStpcjVBUXpkOGRndUFGcVNtRWpKUTVk?=
 =?utf-8?B?VHdGZDhvMW5KbHpFTUFWdEZJSEg2MVQxQU83RWQvUE5zYitYYUxheVhTdysy?=
 =?utf-8?B?UTFqa3k2YlN2ZG5Jd05sUk5sNkM4TlZwUFliWlBoemt4Skl2ZlRZbGxaUUVv?=
 =?utf-8?Q?Uslg0jgBQVwDRHu79nIgyxpNC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f30098-b041-4821-c012-08db8eb819ba
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 15:42:36.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhFzFYDIhoIN7OwPW27HV/4PpWE77bzARseadAXoUWx+KzkL/Kgg4fdI78M54f4wcf1EDTqJJZqUlCQhdLePlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4878
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2023 10:38, Daniil Stas wrote:
> Hi,
> I am still getting fTPM stutters with 6.4.3 kernel on Asus GA402RJ
> laptop.
> Compiling kernel without TPM support makes the stutters go away.
> The fTPM firmware version is 0x3005700020005 on my machine.

Can you please open up a kernel bugzilla and attach your dmesg to it 
both with TPM enabled and disabled?

You can CC me on it directly.
