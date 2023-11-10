Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B177D7E8002
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjKJSD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbjKJSCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:02:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A8E24C1B;
        Fri, 10 Nov 2023 01:38:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOqg+ykAJH/6/y4YbQVH4pF+WnZIeP9b4eHBC1tsS8M3WGEPgFLVLQb4Qlvu5AzsyQUtSc7xxzhZqGu9ex9PMt0qY4niauZj1IBIrWxyGii98ifrFtOxK6qwDRsViJ8PDPAH5Cms3zHgMnYK2orG3eWBSSKuRsb4zV30Xinfa5KMQ1YLrdjZBwmbPq7BcpqhiGEOPotit0EKm2I94lxWB3CyjvlrPkSeqazwbUS9mq71bA46c+JzKswQTER2Ch1fjq4hRupJsbQyMLrR9uiO8syibzMvBrTQl+lYcUrO3nffzUZGYStghma6b/AqpqTuvW3Y3IGw7t+3Wr71VJL5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOTDEBjzDhNzHLXkmEgVTnF2263P4fogsa7MIMeVyOA=;
 b=K4uhNfH7IAdWa4ZOVnQL4qrAnot1br2Iui2zAlGssPloarrYgmSFqviPDymrIbUTIzMLJKxdSIuXjbMPMJl9QkJMvP9h3UoOI/ZHhEi/qWhW0wYssVYGkLc+dxJQryzbYlJ5yaaTEyJOU66FAoiLIiwoZ46JmBOZb31aTnFcFqxCkZr6m8EA/Xremdg8c9YWdDJa4CDY4I3SlrdtJ8z8eeQ3ESBxf39bHWQ697/tfr5gllsB0K+jDi1ps8je7CR+VrF1+SL7CE/rnboMNh4tKlsEARF7FEZWhwIve9J43EEGo5Xb4/Dkd/scKKSnf3upZ5BhbV/Lus0DCNuuq5dqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOTDEBjzDhNzHLXkmEgVTnF2263P4fogsa7MIMeVyOA=;
 b=sua9xHTkauN2Td6MPc68qt5w/E+ZJtQTOL77vTyaHm40Cedo3FK/AkRs1ntnY5n1pb6mB1GbKUWNC32qpEK+6MPQyWwlrHNDsCBefrMJuLFXaZFlGVXYKdCMy+NpVrua3Iygu3z884P3faStTsNlK0O9EDE6du4dSWxw65EYhIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 09:38:17 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ffab:2acc:cf5:1616]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ffab:2acc:cf5:1616%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 09:38:17 +0000
Message-ID: <5a9974ba-1c64-a120-7641-5bd1f12c9caf@amd.com>
Date:   Fri, 10 Nov 2023 15:07:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] perf tool AMD: Use non-precise cycles as default
 event on certain Zen2 processors
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, namhyung@kernel.org, kim.phillips@amd.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        changbin.du@huawei.com, yangjihong1@huawei.com,
        zwisler@chromium.org, wangming01@loongson.cn,
        chenhuacai@kernel.org, kprateek.nayak@amd.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20231107083331.901-1-ravi.bangoria@amd.com>
 <CAP-5=fUkU6OBCEWeaXZ2KqeKDcXF_ZTzwwMVq=uy8CcpK90MyQ@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fUkU6OBCEWeaXZ2KqeKDcXF_ZTzwwMVq=uy8CcpK90MyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: c5776949-50f9-4d62-1a40-08dbe1d0c454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lEvtkmw4KS2bLrMw6xsiQN4bNexdV1uNw4hiKRz00dupZ4kcjmyHjxp5Zwqr38G7h6Ee6MZ/Uxqer3P+O1JkHeSn9AYYdIClCWUk3HOYme0MbRJkwShaQDlXwX4NXONwmYIzzAk6D78oy2AKHRcFuzadB6n+4j2cRttIq/+ydMRrgUdh+PhGvGAW77k+XEVtof/Pl4+THzO3pEQO1H9ZPJTiGgETXyXEW4DIjav3eY5+IVBRxSV5j1VZ6qwfT+ouPkjqpitQ4mk0mNDARJT1lb3y7Zqqur8GsApeuoEzuodUnZrYng6TM8sSBvx0LcSuUvEssEyjDtUhbCmDj4CZbMJ+9sTdTzkkfgktepCZPHPcy2Wu8E5MFkSko3vnzMCaGSCjGv3jpKjX2yUoSFiRAnjKFpHKzIYxucVSMgNFVc0t2/Pb0Xc282HCynBwnYuQyeDFGeNp6NKs3kjt6Y40ByZivZSWyeOkxtGOl4jcaTuDCS12W2pe47hvWsZYlANEPsmA2u846MCMYd2xHaO3Oav1rwwff9bcS2aTIo5c2BqGZUQE4CGrAWnk+gPjPdSn0ZI4Muvz/1T1Vp/f1IuFpWTGoQoFXTVPSBy8y4pSDEoANLwey0ZCyym0SbP+wNFHC912w1WwXZs5gzsMfo1DSk49h4Yh2EUyQRjhcXJxOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31696002)(6486002)(86362001)(2906002)(478600001)(6512007)(966005)(38100700002)(6916009)(41300700001)(6506007)(7416002)(5660300002)(36756003)(31686004)(316002)(44832011)(4326008)(8936002)(2616005)(8676002)(26005)(66556008)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhiOEcxMmN4dEU2T2grVEFFdFZwc2VqNHlIVE94SHlxQzdQSnJ2dGFIM252?=
 =?utf-8?B?WFI0L0FFZk5YeVVrQjhYcmh3TVJFVEsvS3BuNXE0NFpiTEx3QXQzUVJPVlY2?=
 =?utf-8?B?Ynd5TGRobHorRmUzS3dlaGlsZEE0bm9tbm1RVDIrUVU1MStTaGd2VWRVRlVF?=
 =?utf-8?B?Z0ZVTlgvaDR5NWdZY0dYTzZPZDdHV1RqU1hPcHJ5cFZ3RXlHQlVkbVdERHZm?=
 =?utf-8?B?UldlM2xaZERTQTVVOThMOFg5Tk1xL3psWDhGV1pyUVo0dDNKTTFwKzhrRmNs?=
 =?utf-8?B?ZmpRK3ArRklBVjJGdGEvSWJseWNUeUdTL3ErNlUzRkttTGNXWE5RNGNOVUNr?=
 =?utf-8?B?SG9MU3p0UkplZ3FpVTdyOGpCUzB2Zm9nOWJxUllITkwwL3BtRnZBL0phYi9K?=
 =?utf-8?B?YjZHb0VBSHA0N0VQNjlZQmkyTTBJb3ZwVGpJNFJEUk5YKzhnUDhKTk8xM016?=
 =?utf-8?B?QVNhZU95OG5iQkdjTlNlNE4yZlBPamdweUUyOGxuNTZKOGx2NzhhNkRTNXNr?=
 =?utf-8?B?WU5PTnBOUXJGY2xUUHlRTE9ZOURmUFRpNVIvRE5LTi82SWJUUnVPR0cvYXNh?=
 =?utf-8?B?SDIrb1Z6a3N0d0RWZTJ2a21OWGFoTDRJQ3FQZFExK1E5bnNWb1ZJa1VpcGJq?=
 =?utf-8?B?UEovQ0RQbGt3NlRqK2RjRElhVEhSTE8wNzNSMGlCeUcwQ2IraEhlUUNlNGJn?=
 =?utf-8?B?bG9wQXloU1lyYVZrMEMwdnpFSkpYTXhmSDFzMFRGZzlmTVkyVUxJUzJZNUw3?=
 =?utf-8?B?bFE0SzlxeW9zTDZRTFZTRU9KR09tOExpcjlwY1lxRHFubUVjZzJ1TXY2ZWFo?=
 =?utf-8?B?ZlA5WTFUYmJiZk5GeTd6Y1FaSWFDMDFISWpOMjkyUHNlYlorTjM1SEFGVG1U?=
 =?utf-8?B?Nmp5U2plbllISGU3S0x5cW9QUnN6NDAxeDVXL0EzUWtndVVOMHlrcWJVN3py?=
 =?utf-8?B?dWZNZVpibTBFaXlRczJHSENNYUk3TEFlUVBBWm9CYUhlaXlRdWQyRDh5SmRj?=
 =?utf-8?B?QnlMeVdDa2t6STBSdXMxRDYvMzRpeUJWc2ZmV1lqTnZsRGducGhqMEMwOW1u?=
 =?utf-8?B?bjluaUdrdmlTUGJlTUpEeTUrbk4zZnRaU3ZhVk9qWWhXdzdSdXVEc0J3K3Bq?=
 =?utf-8?B?aE9qYzZ0bXZyNmpTL3N0eFFubUxGak01M1NkdGs2NUpsY0RyL0JkK0pwMWRB?=
 =?utf-8?B?VkhvRjZKWGwrdmk4aVMzb1ZIUmVIcjQxL3IxSnlrK0hmSDNnMjIzSmdMWFlF?=
 =?utf-8?B?dVBhN3V6S1Rma0NTeHk0cFo3a0Fway84TkNsU0c0WVBxblZac2YxdHRaSklX?=
 =?utf-8?B?b3A0ZVZNTS9nMFJvTVdFOXNzd0xrUHhJTC9HcXUxckk0eGpjL0JtTkM3N0h4?=
 =?utf-8?B?aVVSSWUzU2xEZ0FEMlBwVkpFSGtGcDIrVHBhN1R1b0xsUlcvZGpIVWx5OGx0?=
 =?utf-8?B?dzd3ZDBpbkF2aVk1d2wxVDNkL1dVa1ZiT2ZrMUxEVS9lOVFWQTkwS3R6UDFU?=
 =?utf-8?B?ZExMbURVdjE2V1pXaWxmZUN4aTFoK2U0MlEwVW9KQVg2UVVYaFowOEYyWWs0?=
 =?utf-8?B?Q0U4Z0xYMCtNQkNEQy9vWmJlc1VIRjFMcERLbDJDeEUxUjc0bXd6SFRtclFz?=
 =?utf-8?B?ZWE3V21ocHlRUWR6N0pGb2hpL0tCNWJ5T3lzSTBLVUFYQkNlZTR1WXozZzF2?=
 =?utf-8?B?bTRYMzRnWGZHTmd1bDNBdERTTEt2SzVRU3BYMEdoQXlnd2k0RWRLT0l6SWlX?=
 =?utf-8?B?MGZicy9iMTNWdXRZVDNkbW43S2FrTEphVW13N0lqc25iVFB4SVBPTFZMZ1pF?=
 =?utf-8?B?Q1NyVVBiclRUaEdPYlFzNHI4TjhDR3B6NEplSC81Y05xR1V6QnR1VmVXNWdV?=
 =?utf-8?B?a3k4T20wV2hLU3M2d0NPUEFHSVpLOFphcjVLSWY4d0tIcWNLdldNYnIwUVcz?=
 =?utf-8?B?MU95MUZYa0lObVZ1cVloa3RLYjdTRlZ3Q2t2cE5OcGdmUmJzeVVoZmVPeVFu?=
 =?utf-8?B?QjlaZmp5dFBHZ1NWQnVCY1YycjRSRjNxaWs0U291Rk5QaVFyWFRDQlE4cFda?=
 =?utf-8?B?cUllazdFbDVLZHdTSHJiNm5JalU4ZXpvTmh4STRpMldFOHlyVzlLcVk2NGR3?=
 =?utf-8?Q?3KYIfsF2/aJ/0tFlHNnqefriK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5776949-50f9-4d62-1a40-08dbe1d0c454
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 09:38:16.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9tCWEP72HwKtAlULExd81q6x8P83wkPm+uQR7DhE/Rinj004z4x8nLmf+KsIuK36gi2GtboWwohKbHuDds0qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

> We read max_precise from sysfs:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n984
> 
> But it appears not to be used:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evsel.c?h=perf-tools-next#n1323
> 
> I think:
> ```
> if (evsel->precise_max)
>     attr->precise_ip = 3;
> ```
> should be:
> ```
> if (evsel->precise_max)
>     attr->precise_ip = evsel->pmu->max_precise;
> ```

This segfaults as evsel->pmu is NULL. But I get your point.

If we go with this change, I'll need to switch to cycles:p as default
event on AMD. Otherwise perf will use non-precise event as default event
on AMD.

> Presumably this is misreporting as some non-zero value on the buggy
> systems - if it doesn't we can declare victory here. If not we can
> modify max_precise's calculation on perf's struct pmu for cpu for AMD
> so that we just hardwire it to zero in arch code.

max_precise for AMD core pmu is 0, which is correct as AMD core pmu does
not support precise mode. However, cycles:p, r76:p and rC1:p are special
cases and allowed via core pmu.

Thanks,
Ravi
