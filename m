Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B163C773732
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjHHC7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjHHC7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:59:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE3610CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:59:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0+484N6ilrYKaDBQaeEw7mGr+hCBKNS6O2tGpzhuhPEhgWggC4BCAluhni0vN83oulTYcI2HZ7l73pCBoDtxL2vIOVZF/W6pXvHePGDtKl9NtrFKkCWaVgq7bx56KLttbTs1a3j/o4YuirNXAK/NJJ4WipbAZXxdZo7HYJ3qZehEmjTQCvHch413Oy4NymaajXqmAW7Ib3sfXjAWbtdYqxHTup5ubg3HOVA2IOdHRde0+y+yjC1XngUuBQIsFXkgdmkj3jsXAUuNwMvJZc+4dkkR3qtw6MF+rZHyds6dTDfjOzHaoIqyYdEPVjmq0NEHbPdROhrdb6wce5oQEjrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9x3bR3n6+boW60KCmxZvYvCZKvHGReD3y/BnH7hLSQ=;
 b=PpfOsk4TstDdwSOXo6A1VBccnbSyZjxzR0D5e8NpHgyIuU0q+fcZ+bfWxJpiIzYzUNGcfQOvDl8DIou/P3YTAN5Z2RR00C+z5y0/IHxnlp0H6NgU04G+cEj5lrlDIVITvZjJy1k+eq+QpRFlrKc734QdVxaJIb+DpkS9wiotT6QJjLUrQUsiyePOofDYEJuEYAyCavmOioKiF7oxBQKQ9r+xNi0x6QPN9oBeortTj/l/+r4Z29hA+4buOw1MnMErSt7zlVmjjGm/BpwsfzxKD4Hgfz56Y5lFhBIOSnFyKf9u/zMnhKmeiiS3wV5a0J4XIre3FxUfnLbAhDHvrdFApg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9x3bR3n6+boW60KCmxZvYvCZKvHGReD3y/BnH7hLSQ=;
 b=CfBGStY1IF1NkAo/u1bxUREXhaPiDZhJYQSmE1IwKE17+onii7IRe1ZT6m+xHtP+tmxlyatCzdpGF6JR/+RpUK5P1Okk/0G8jVLhzNLWyFJFLkUPVgTXOamD5fGoyNwK92KU/R/O6zs4ghPYvLgqXE2GoA2THhPLXpWHAgtOF58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 02:59:03 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 02:59:03 +0000
Message-ID: <94da0dc0-a30d-33d5-b3d5-784bbd59c549@amd.com>
Date:   Tue, 8 Aug 2023 08:28:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com
References: <20230519001709.2563-1-tj@kernel.org>
 <ZNGYxBCtaMclAl8x@slm.duckdns.org>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZNGYxBCtaMclAl8x@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::8) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 829a2a59-f20c-479d-7f81-08db97bb6c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hD8HKzfnJGmLOvFL/I4hBifkkkfibx8x9Ej1hSThRd7VODw+HZmQkf/e5svaEvu3UTJehDfmtl9TFZwwCA4pg8JEHIvYAFxeTe9ZxG3BMdp1uFRJMPQPCwuuhIEv6WD0L3nbw+M5Gu3ZhojNqIyY2J3TFLmzpHV6sg4Y6UxGPdRztTAZsfphj4RBKdBf0txsTbH7Tm0375Vrou6R8x8GpRxMezwjRYq+yAesVzVtvFQgkiIVfDEjN9/bnxxQ42vSLqdHRV6RGLdPVisjaZT482neEQ98oKahEdc7O9Sv3VMLhgkpwY+ei7BbwK2cOxtkcQbtT0XX1O7BTTS8Bn2gcfuvl3OjW9pv4wIXKefcVg5L+SbHjNzsZJ+l7KuJO1ui5E+pDk/i7snroYDxaPOiuRYA+jcQzlK5JQIEqiZ6cFLDIF/IfZF8L6QokOaBT8+1jTZFaQpN+UeJRd6/j/MMNVJlhyZULVcZu3o3VECr64tFqvNmXJz7mC5vuynXJ5WL6CopxFmlsUo1Di6bxlgdZtNTjyPpsvMY+2DCMWEcQX60vpBSDSFtJEx/2ATh/j6EL9IAJqpeG9VaPIDT07ZV/Q+TDyI9nOvcxzlv1bCpONo6Fz5jvMpYMEJVC3k+2NYWkNS4zNx4bWIzJ0Sk3NzGQeqFjbn1giPApJqBSHjrljjsvwieWTJd2h1V5PsEqkrfu1IgM2ZAJDeQ3C4Ot1n3Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(366004)(136003)(39860400002)(90011799007)(90021799007)(451199021)(1800799003)(186006)(2616005)(6666004)(6486002)(478600001)(86362001)(6512007)(31696002)(26005)(36756003)(6506007)(53546011)(41300700001)(7416002)(316002)(5660300002)(8676002)(8936002)(38100700002)(4326008)(2906002)(66476007)(66556008)(66946007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnlZRWl0cHErL2hZcXVENEtTalJyTmoxb3lLZlBINXdBZTRFbGkyOXRxclFQ?=
 =?utf-8?B?VUpManMxVmthZ2NMVFFJSkd5Q3h3anBSSWd6YTNIOWExUmtIOXFaQ09YUUpi?=
 =?utf-8?B?QlI1U2hxbjAyeFcwQThheUdEM0NvWUFaNUhUQWtkT0NtNlNER0tlNzIyTU9s?=
 =?utf-8?B?cngzQjM4MmZmc1FrL1YxbjVkcmxkSkduUkRkbG81RndNYXI1OUprdStBblNv?=
 =?utf-8?B?UWpHdlg1SWtpbmN0dE9XMjlXdDI0R2Fna1lQUnZoUXpEc3ZSSmNETFpXbmlt?=
 =?utf-8?B?OUlRcWFuUVp5WnQvMUNESGNybVAzLzZFWFR4UHh0UHhSN0ZUZ2ROci8xOElC?=
 =?utf-8?B?Zlc1NmlVZWRKT2FhQ0lPTnBnZ1BsNitPaFJTZyt4TzBLYlcwalFsMXFzalRN?=
 =?utf-8?B?Ukp6czNobUtZNzZLb3lGa1lIY2pFQTRIc29zb3ZQcVpxVkk2Rm9uRk4rNWx6?=
 =?utf-8?B?K0I3Sm1WR0ZzbHE1bjd6MWlkNy9Ka2E5U2xvZ0swRCs0WXZNK2k3QVlPMlBu?=
 =?utf-8?B?VUQ1QTVMZzdyMnpGMU81bWUySFpGWFVOd0hhVVJwbkRhRHZnYzVXa1grUjRZ?=
 =?utf-8?B?RW5RdXByMEJrMnpIS3Z3TDhYK2tQTkh1OEtOdkR5a3NscjE2aEJlSVhwVHNY?=
 =?utf-8?B?R2VBMHFiYXdTOUE2VGtOMGxqRk9oa2QwQXNGcVNuK2t2QkRRVG1ZTTBtR3p4?=
 =?utf-8?B?bG9URVk2R2hJU0dqdTdpUmZIZHlqZ3pxdUxEYTJsVFZVbk1WbHpDazh6dFRH?=
 =?utf-8?B?ei9wOEJXKzhEdzlkVnp4R3U4SkdNdjVZNkVMTlFNQVJVcncrenk0RnBIQkl0?=
 =?utf-8?B?bkQwdmUwenVBa3BrQjRKM1RLblMzZ1g1a2ZEUm1vZGd2WDEvSEVhN0NPV3pz?=
 =?utf-8?B?bkUxUWR1TjhzZE5tdk5MejIxVDh0OFIySUNIb1F5c3lidWZqTDg1amhvSkFJ?=
 =?utf-8?B?K2kxWkhiZkFEWEU1Qk5JbFJ1SDBXbkE1Vm5mRnc5VTJTNWpPb1FzdUNRWGJY?=
 =?utf-8?B?TWRFQ3ZyeWNjS1FoQXV0VnFiQ1RjY3NKZFozbk9IdEhyK2VzRGFzS1NHRUhZ?=
 =?utf-8?B?UXpjMXo1ZVNkMHhPdUgraGJySUYwamoyVlo3SFNnYkVEVUVuR3ZzWkUrZFdL?=
 =?utf-8?B?ZDhxRVM4T0VlYTE4LzVjSFJ5TS94UC9FSmhaRUJGcHZxVmtSS2FsLzI4TkFV?=
 =?utf-8?B?K3VmWkEzYnUwRzFPdXRaVUJCeU1Fb3pJNTEycUdZUW0wT0tPK0tieDVCN0hQ?=
 =?utf-8?B?LzI3VmZOVzRCVE9XV2wydWpXc2swaUJWZEN2T3dFSmZKK3ZVTEorUjZsQjF6?=
 =?utf-8?B?STFNWmdua09QYUlSdmd2bjBLNmk1VnBDaE15ZTRqR1RQOEVlR3lRRXF5ci9s?=
 =?utf-8?B?T091QTNSU0plbmpIelJKRlJLY1F3QVoyaGlZYVpScVJyQmswdGoxdnVCMExH?=
 =?utf-8?B?Sm9WUHdiQlpWSE1sdEEyV3FXUG5XVFZ5RDl0NTlqNEtoNDB5Ynl2KytkMW02?=
 =?utf-8?B?anVCdmZkYmRpdm9DVHRpTFVrSzFGc0ZGblVkTkRRYmtHcnhQTWVvY0QvWmR0?=
 =?utf-8?B?UE5NSUpDT1lPQUtEZXdwMjJDUDdiYS9sQVBrTUtZUWtBYVdvNm05Zm55UUxU?=
 =?utf-8?B?c1VVRm9LT1h6b1gvQjF2cCs1T0NSbkhwT29RUGMyU3Rock5Kc0Y3cHduNkty?=
 =?utf-8?B?REdSM3ZIOHY1a0cxTlRLdHF3dExTZjIrM0w2MjZZYkNOTnorQkhMU28yekpw?=
 =?utf-8?B?ZU82NzVJb1AwYzcxZ1B2ekVIaWE4VXlYUE1VNW5ydVhFWGQxUHlSdE5UWVhz?=
 =?utf-8?B?Njh5VitaeFp0M2Q0SmRoNkNNQXljQmxPMmhSL3lpREFkdXNQL3Y0MzNQTTQv?=
 =?utf-8?B?cXhWbWM1VlVYQW5PTzFXL0xLZ1NPclArd0M4WFpPdFZEMHdENnhwWEoyaTU1?=
 =?utf-8?B?WEx3aTVIa2lIbnltSkJkZmR0R2tVYjlEdWs1NnI5OGVKV2xCT05ueVpRdTQx?=
 =?utf-8?B?VEY3RkdTclhmU09lZE82R3U1TkI0SW13RWZQY0xkY0JhOFhScXlKc3lBWlRX?=
 =?utf-8?B?bE1kMzNxRDJKUnphSi85RFJLNVR1T2RDV2JhYzNQc2xTU2piL3BVcVVDSEVj?=
 =?utf-8?Q?V/jY6rmH2gi/7klmjIwWtJ1n5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829a2a59-f20c-479d-7f81-08db97bb6c04
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 02:59:03.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WF8SyN7ZBr2WhUGRVSRLpPBXZG1rTz1aZgh4m6s4onTpyCYM/exacGTsFVdxxOa1IX97i9rnbbzQjoTlIAbxDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

On 8/8/2023 6:52 AM, Tejun Heo wrote:
> Hello,
> 
> On Thu, May 18, 2023 at 02:16:45PM -1000, Tejun Heo wrote:
>> Unbound workqueues used to spray work items inside each NUMA node, which
>> isn't great on CPUs w/ multiple L3 caches. This patchset implements
>> mechanisms to improve and configure execution locality.
> 
> The patchset shows minor perf improvements for some but more importantly
> gives users more control over worker placement which helps working around
> some of the recently reported performance regressions. Prateek reported
> concerning regressions with tbench but I couldn't reproduce it and can't see
> how tbench would be affected at all given the benchmark doesn't involve
> workqueue operations in any noticeable way.
> 
> Assuming that the tbench difference was a testing artifact, I'm applying the
> patchset to wq/for-6.6 so that it can receive wider testing. Prateek, I'd
> really appreciate if you could repeat the test and see whether the
> difference persists.

Sure. I'll retest with for-6.6 branch. Will post the results here once the
tests are done. I'll repeat the same - test with the defaults and the ones
that show any difference in results, I'll rerun them with various affinity
scopes.

Let me know if you have any suggestions.

--
Thanks and Regards,
Prateek
