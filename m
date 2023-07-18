Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1C7572FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 06:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGRE7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 00:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGRE7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 00:59:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFBEAD;
        Mon, 17 Jul 2023 21:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecwH5F5G0HsJ0GQbtls/lm3gB5+K0dgSKhw+zJvI0kVOwgoH3ypkC9rLhNljKncx8aOMY1HuxWbaU4SdkyoRLvN0XGc8irVlyeKPaWcui5tjXJVtcCln8F8EBEOQ2a5gKtRaOvUfYKjM7xU0fbiD3N+mu9XfF/Bd6kW/gpFjN/ptEiihuaPZi/SU5hem/YhKVpPEP5SwyBwBhnvq+GXXY175HR/h1EkTSt1t2k/SRR0SDBsT6kAckzTXnNF3fZMe1JRpPOztfPtR6n/n4enwJrQ8hDkr0SmggcOULzIx3joGmRy4HWOX/VZv9tMTQQQLkGk4d5ic9BxAHISh45jr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDcQo2uZjqFuFfUjjL+8t6lPX1lggpaJvEf5Ae1RVBY=;
 b=Oh3+IIzqi+ueYRkWHm8j3rAA9tli4ho0yNZbk28XrXjTq+/ftuc3j7HwzTnpks/A0JSKdXlVuIKd3fxzt0oQGuKR58xJvqK3tXhrL97rZ1rwsp3CGa8QCkzb3vhEBpkHseQNb+nTBH7iD6aP7zVZS1NW6I2KOY7e9kouXODJi9K3R0BVB8P8XHumze/WYHuCod11eWiwCHO6SSqH7VyyZGnM/8ZhaVsvv0K+9uWt6PH6MuN5uCR6y1lKUcZIDzKprGtHat7zKnBLoOrX2lGr+pzQBeBiU11K7znTxGooXT5TT6m496Xj8uQPY1ZJjHJafiyR02sTPAk7UWqRgjFADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDcQo2uZjqFuFfUjjL+8t6lPX1lggpaJvEf5Ae1RVBY=;
 b=XX94qIyRcrJ9aVfUW1PjbfuWQKjjgYv+M+O6o9XnKsQ4jEbqcMRXlCpDlZ0SDLCc5WvvaSTOHSURbPJmZy8DX8U+0zY4eM8vIzEWCV7bRhV5vYpraf4sopDHp7YtS2npJIgS3uHtRSRQFiCHzdqrnkBT8wdPaIFQAo6j7yij5bE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by PH7PR12MB6492.namprd12.prod.outlook.com (2603:10b6:510:1f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 04:59:45 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e6:191b:9eb8:e73a]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e6:191b:9eb8:e73a%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 04:59:44 +0000
Message-ID: <8ef1b112-c213-0a2d-6603-e8d4c2a4529f@amd.com>
Date:   Tue, 18 Jul 2023 10:29:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] cdx: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230717150355.1749845-1-robh@kernel.org>
Content-Language: en-US
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20230717150355.1749845-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|PH7PR12MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a319c70-d39a-4534-438c-08db874bcd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOaXcxjI6s0GzappXTXib+bcE2bov3Lamnfc3GaiUkphMFiLp7bJFWlgXF5tT+lTw2u3E1jUi1fQT6rDccWzDZAfYsFVQhODaqlW5b+rnLfw4Om8mwsJPDgXniPdBP74viF0IUqCFl3zs0E6UkDxeJq0WkoDizCHIBwDZfNLoPvMep46Wqk5OcQbknj8njJhNmnrGe1UoG5Gy4Yt+Jynwyb6RnsYPEBT0jZ14Xjqz51fDbjU0LRxxHw4hCW91U/kei2PlMFyAGdwpRjCa9IYHO9aiLR6TWpSjGOOg0jNtAozPsueAjuYZPxC4WTEcRwUT5t0t7AeaJ0JZe48i7LG7aa9kPHG25wcWqt6h1MOJfLiBdC+bTH11M7wywbXpjmueebvoc/xSy/q5In0mi4DHu58/5dbvt9b0VO6Sv8RMkHe6Sd5DNmrRc4UppODt9QN272XOhD77O2jg8R0ZYZ/q7pAKg2nQet004Ivzxm+DUNRTwXzHJb9yQO14lwZx1eKhhPLo7RAVJdCglvwpXoh54ihvqjcm8kPOaWfpy2HCozT9RH6uMeLQzSUWyZrHngMrS6lHdvRqQ/+qhpMXgoLVLpG5EdAyW8+HgISmwqq2rBzS8lKNA+YotQrrdyK23bq2Zz+3RXZ/ukKipWjhv9RsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(31686004)(6486002)(6666004)(478600001)(110136005)(83380400001)(2616005)(31696002)(86362001)(4744005)(2906002)(186003)(6506007)(53546011)(6512007)(26005)(38100700002)(66476007)(41300700001)(66946007)(66556008)(4326008)(316002)(36756003)(8676002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNLa0JmRlFicG53VzN0bjZyUGljQ3Q0YUF4YjdmVUR1NjV6K2xRV25PdXVh?=
 =?utf-8?B?MzdNeWlidWNjUU1KamZjQWxKTmw0YW9BY0lHbzJUWDc5YmNtdzIybVorbDhx?=
 =?utf-8?B?cVFMck45TFJUUE1ZUzZ4aytWbWl0MS9JeWQ1WThOM2VtV1FzZG8zS09wdUJo?=
 =?utf-8?B?SW9SYmlZQitmc2p2RzN2RnBKKzkyZCs1TDh3aTFtMHA0L3pvRk1xUzc0MVNT?=
 =?utf-8?B?LzZ2dVpaalFwY2RBeDhNWFM0T2hDb2l6QytoMlUzVmxOVGEvMEtEOGJsQ1NI?=
 =?utf-8?B?YzFBQmFKTllPQkloTE1TTUxUKzZuM0pkRkl3MnN4TDE2cUplNVpWQXVsNXJr?=
 =?utf-8?B?YThpRFZWNlFNdjFjeDV2cGY5UWRiaWNrb0dUb0xKZVI3WVEyZGg3bTFSek5y?=
 =?utf-8?B?RWxyRWZHQ3l3cnhjdHhIZzU3YzVzQ2dVK0pySXBLUFowNHdUcDVkaCtJWC9m?=
 =?utf-8?B?bzRWa0dReEI2Qnc1OXloT3JZakRaMFBEQ0xRTVFMUElrMVZTZEJKaXNNTllO?=
 =?utf-8?B?amQ0Mytqa29JSzFxQzJVNHhjUTZ4Y0tVVjl3U1VocWh3djFJOG5hUDI0Q09Y?=
 =?utf-8?B?ZWdLNjVJR2QvUFNjTitrRkxHelNpZ1lJSVRNL2FMM0U4TGhpUnhLRVo4dlJT?=
 =?utf-8?B?Q1EyUVJoTU0rOGVlaUUzU3l6TVpBOUxzdUEzTFQ4NklhdUZldmloTk1mQVRt?=
 =?utf-8?B?WmJSMHBJcjBPU2tCT1RibXpaak5iNE5KNXFnb2xTb0I3amx1aDBEL1lucWI3?=
 =?utf-8?B?ZmVJakJMbzBkNmVhdUxzcXlYZnRlcnpEcFE5bURjd2VvUTc5clJVaTNyYVkv?=
 =?utf-8?B?ZjZNVWhINDg2U0szS3BYY1JWSktRZytoeDNaM1V0ZjdsOUZ6OGdjUTZONHJ2?=
 =?utf-8?B?cnI2Z0ZaMm1UMHJlQjh0NzRxdXdsQzFMdGtoVTlLeFVmdXptMjF0TGdMVE9S?=
 =?utf-8?B?T0hEZU5Bb2VLbkUxTHVwT2dsd3ZTblVOeE85cmZBUTBnODV6TE1NdDVpaHF5?=
 =?utf-8?B?QjlraWhNRVVUcVdmUTd4TkVZVE4vbkR3U0VqWXNhSm1GR21HMzJCZVVSSTRk?=
 =?utf-8?B?MGtOT1NDS1dLMlc0VEd1WXpIY2p1SEhpSzNjOUlKRHJxWHZ5Tk9uYVJUN1Zk?=
 =?utf-8?B?ckFDQk02djVIK016QXphbG05SGc3UklkbjFRS0xUM0VGbGEwSENXTWoxMFJL?=
 =?utf-8?B?ZlRybzgxd1VBTnlxUkozRFVJcTJkRmhhYW16QlpOZ2NlU00xd2lpdTZTTVo2?=
 =?utf-8?B?enI0b3Uxd0NjOHB2OG9SNGRhQ1ZodVUvSG1JSy9uRlI2dFdGWDVvRTJaVU1j?=
 =?utf-8?B?WUdEd09CUThuTUFBZm9SMndjRTBWVGxnbmpKUFNsamRuL3BwWTVzejBpb2Nw?=
 =?utf-8?B?UEVhb0VLSDR0YldlT0xja1lPeTc4K2d3T09FOWFRUnEyQWwvaHlBNGR5Qzl5?=
 =?utf-8?B?MzlwWmlybXpSTks5a1RmRlBreG5FNSs3OXhuOTB1dytrb2lXZHI4SSt2UHNM?=
 =?utf-8?B?Q1lqb29IUk9NVFZ5SFoyeDBFd3B1WTNFeDdlVFE4WDQ4cll5enc0R21aK2Nk?=
 =?utf-8?B?YXVNd3phK05tMVEvcit3RHJ3VEFUZkxVbWdVQjRTMW5yUitBakhSZm5mdWJn?=
 =?utf-8?B?U0ovSmg2aTZIYjRsTmZMMnlSSTUwcENBZjhtVXhGWXBrQ3piSTNJMTg1Nmo2?=
 =?utf-8?B?Q0o2cExCSnRuSTJKS1Zoa1gzY013TTNFaGhIQkJ5TVZZUVlPM29vb056RlpT?=
 =?utf-8?B?T0EwaHIwUnB2NU4zbDU4RXFraFFBclVBV0Vwb0hwWS9pK0did0RyN1loc2Rn?=
 =?utf-8?B?dThMNktnWkxYcTBYQmFseS84YnhtMDkvM1I3V2VuTG1aL0VQdTMzUHM1UHU1?=
 =?utf-8?B?c1R6Z1JwMGNKRzNPb1lCdUVmWEtudjFHc3c2ZmlEbGZhQTJ3d2kvb3ZObWNO?=
 =?utf-8?B?bTllWU5CbnJOT0E5djlzQkJyMWlFSXFTUmU1WHJuaVFhS3pGQXdxUkRaaUhv?=
 =?utf-8?B?eGVUMnpQaDF1enYvSEtBeHhjTWwrVlRhUVJUTFgwVThUZThrRHFnMkkwNHRl?=
 =?utf-8?B?TmhjckdoTHBVWHVGVVI0cHRVZTc1SGhYTXR4NUtyZkJKVzh4MmE4R2IzcTJV?=
 =?utf-8?Q?ErH+yLabOY/Y2lIhDyak+x29B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a319c70-d39a-4534-438c-08db874bcd41
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 04:59:44.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kl/bZkMBJCf0JP3x/GA0pcQHerGL9HKQy6WrN5c0LrKZzSjmHznlgq8WvZTi193v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6492
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2023 8:33 PM, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Nipun Gupta <nipun.gupta@amd.com>
