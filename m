Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0977D6042
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjJYDJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJYDJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:09:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06D013D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698203343; x=1729739343;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cja5BGLP8O+N6ehznAoK2Fha/TMaIOp8+iUbHZP8Y9g=;
  b=UV3qacuV/AUy0+V+iyEGDl5dnw1dFGe9Sc3tB3Md79QqnY9IeOkeCsWA
   pmqDaooCvgTkMEzSw7pVT2hgJCM52yvT6Icnwl6c7+b5si0H/tI+XF55u
   JXmEG4D+xcQGe/M7SOUSdSzNgnyqYXdeb4FoU66zKhYZTI7u1Jm5pOuVU
   N7n/HlQwxBXeCYJONbL4TI7pgeEdQVOJmXevE8FopArrYjg/IyzT9gCt0
   A+e9Ut51Crmw2a18AAdjCUcCE1WObwA9ZX391UNmdZ2IIuS4wgel4DHzk
   +iMme4wbzowf+rSW2PNTtCmHHqdkkfs4uaJWrAdoTTSyfqjfePrEMmUCz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="451451132"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="451451132"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 20:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1090066639"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="1090066639"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 20:09:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 20:09:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 20:09:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 20:09:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 20:09:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhDc/XGhpEz2rOuhOlwlpiTVt67XpC4lhpZqmb0OrIqMWtGENQ2pEvwX41UwQQoDaOCID4h5h0F06/gFtl7+YRuDPIiml9qT933QZSOV9H8KysyliP5NSsK+3S8GSLk3gfFWYxAldqCQnKeZ4TkfiKpw5ZZYsGgxgWJCHq8rrTm9PvEj1fJKwowZU8QRA+NwPteIOUGxdry5CHt8AvxAQz0w/HvgU46mJhIm5m54XSMZ8zLcsSn/Fh07SPQRFvTGC5vNomYXue4Dn+/aEh1GHyZDLiGP6XmdKFV75aWlll6crKY1VMQMaUafJ47HFacOAuXZ0VKAJGRUBCZiT/G+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsW48gP9S6rbN/9GsFlqp0gmcDtpW0OGgj6urtwDsqU=;
 b=RpQ1NUMzIIkh1fGf9PIkzIkyY7hzs/FoEWVFT+AE83BmTZWBBnLnItnuAI8MzpaoIDZS4/g4mLyUekbY2aF2oSNUe/RZpI8ZMn6CxlXH8M/+Ii+oqFM4S+FTNItjZQDAweNHW02Ebn2kinWGff2sPuqe8cxO5pTRVLjh29tuDQxqjqNlJY7W8cdXdmfzuBCd+QihYNAajDv9FA2axeooT4hVDDek8Tl8XBHUTS/hYx8VxMDHtU1IX0Bo1sx3DQ28dGqTtcOg+iTmcYnrCZWL/+jn/p7rwy25yCOBRBlOgAWr1176bexSMGsxg1WbwGsAGNSYlUqtRjeulHgadOwlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB7697.namprd11.prod.outlook.com (2603:10b6:806:33a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 25 Oct
 2023 03:08:58 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::cc11:6433:f346:c503]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::cc11:6433:f346:c503%6]) with mapi id 15.20.6907.028; Wed, 25 Oct 2023
 03:08:58 +0000
Message-ID: <a4ae7473-636b-4ff3-9f66-f47dbe934593@intel.com>
Date:   Wed, 25 Oct 2023 11:08:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Barry Song <21cnbao@gmail.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>, <v-songbaohua@oppo.com>,
        <yuzhao@google.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <44e32b0e-0e41-4055-bdb9-15bc7d47197c@intel.com>
 <f3047412-a53c-f8ba-f8aa-4f46e04c5a31@linux.alibaba.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <f3047412-a53c-f8ba-f8aa-4f46e04c5a31@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: df84aad3-3cf7-48c0-8273-08dbd507baea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQ1UJCBnh2AlXK/OhN9Ei3hyUxBVqR7qzl+JlIKgzvBNE9YOHlAKm86biZZGPGbPIQzLeOyrT8gEJJy86joVoghGY8TZ0fp9jA5iXoe7EJNPdDdzNasiiUxMjPVNh+dTt+U3SV2aa5n68wmT5MK3eY9PhGPoOiA/QMYqSqeF94rKjzr4qeZW/nXJeVaufytgURVPA3h5dWekb9RdPtpu/5uJqk/jx6+lni5dRiciHnmOWhwYOLJQUDmBuduLxuvE/umL3uuN2D5LJpL5HpIS6X9HWc5dJboZrJUboiO+m4cjuEfQ+mDIe9qyqcnuXZzcHo1yFchIVvvyzHA1lK1WtemlgxJ+VnhBvCIazsb2lMlyZV80KobOfHbxwKQwSGd471Vg5IuOknw1ZO1+ClmcD3A9ZIy6ugd0FgnXBvlKCEaVPYA+FLFkiaSD7r5w3mNQCl4lPfXzNE5RWfhiomFqaKSCuc5sZSdD/17ZS+Bo+Vuy1y4LRgHpsvFyiz2NvvprmxgaLwHJcJXuuMqUtngXKxGB9gU35vUvP/ELkLyL5Knus0Cgoj/muD/QW6rO4LFmFVSV2jVfDZEsbEb1A86XZJwkbWPMioAfwPSObBb1voV3nv6xUn9ENDazE7zf0t9ONX2t6YXMJl77/D1lovcdew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(36756003)(66476007)(66946007)(31696002)(38100700002)(6666004)(53546011)(6506007)(316002)(110136005)(31686004)(2616005)(66556008)(41300700001)(2906002)(26005)(83380400001)(82960400001)(6486002)(4326008)(8676002)(478600001)(5660300002)(6512007)(8936002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFZlZzlsK0txNldZMjlmQTlkTmhoZGpRdkVQbEpHSldZR0ttMFpPeWMwc1RK?=
 =?utf-8?B?WFZVMWdncjZvZVdzWUFodG5hank5WnpndGExNi9OTjE0bzVBU3BsNjVUT0pH?=
 =?utf-8?B?NWxUcjY1TXl3Y1J3QWs2OVp5clBvU2xJYVgrSzNKWTFBNXNHdHNlS1RlR05H?=
 =?utf-8?B?TlJaQkdNTGRPSk1PWUlVcXlOSGY5NVBsZTNRR0tEVThmVzl3OTFnMmF1TEtr?=
 =?utf-8?B?SzUzZzJkU2Nsc1RSOGpyb085M0hxbWVTaHFSVngzbS82djJma2F1UFF2VEcw?=
 =?utf-8?B?UGRPWW9VQWlvWUVsN2Rqd1BvUGo2NzBBeEgxekpVQWJLQkpFM2ZFZzIrV2xQ?=
 =?utf-8?B?NFMyMDlaQnhQaGJmMmZWMHRXbFBIalJXQWR5b3ZOYmpJeGR4SmVaT2o3MVZX?=
 =?utf-8?B?QXdFWDNXcC9pb2NXZE5iaFB1MHQrODVUY0JEK2NVcGFiSzlWYkpwSG14TDlr?=
 =?utf-8?B?SERNb2gwSnM4QW4rdENRK2FIeWI1Q2JveDdjcnhuRzNzbWpyWTRBa291elkv?=
 =?utf-8?B?OEZKWWVkTlM3ZncvSmpoQWFBaEsvMURuMkVIMHhlbDdobzhIcmdzTUN3TUp6?=
 =?utf-8?B?QktMOGVQb0JaTU1xMElBY2M3ckViVzBnZDV3MDdxakZQc0QxbVV2VytPd2J1?=
 =?utf-8?B?MXlJNlNOeFRpbzViM1JuVTZURGQ5eTR5dnR0UFUyYkNOYzhoNURlR0QvOXFK?=
 =?utf-8?B?ZjRBUGJxYlcrWis5bHZtZ0xwQXdXR3VKV3l1RGFyTmNvek1xeXIweFlxUXJ4?=
 =?utf-8?B?cjhMeVZwZFZVYXdvbWdwOGtMNW9tZlRBU21uMlh4MTBVVDZKV1JpeEwvMUVM?=
 =?utf-8?B?L2xwbW1BcDhCem1aL3VrZm9lT3Z4RWFTUGVSc0tMZWNLZE5tL08zZmh0L3VZ?=
 =?utf-8?B?bGdlSC9sRnZLY0MwVTk2alQveVJqdEdjZVdsbm54NWxaSlVEVWJyd09wV1FL?=
 =?utf-8?B?dTd4cFU5blZhalNpNm56SlNHZnQ2WGo4c3hza1o3MnNmd2VEbXNoclJDM3Bv?=
 =?utf-8?B?Rk1sTnVNb0VwTS9hZytpa0dtd0NEck43dEE2dUxMNzF4L2svVWlrR2ZPZlp6?=
 =?utf-8?B?UXU5T0NWQ0w0TjNURXZ1T1BNWUYzcy80Qkx1L3d1NmFQSDB4cytaRHFBcG4z?=
 =?utf-8?B?MDBuaEQzK3BsaVN5dVYvTVpyTjIrRzBIbUVKS2JCMVYwdS9YQWtHQ05iZHFk?=
 =?utf-8?B?TUE1SmlNN1RvYlpydTJSZmt5QVRvK3M2TklqSVNmZW9ob2JCTWRydHNWSG0x?=
 =?utf-8?B?ZERSZnM3amJmMlYxL2VwQURWeUFjQ1NmL1hrMHp1Si9aTk9Sakd5Qlc5a2g2?=
 =?utf-8?B?d09WajdMUDY3aGxtNUNDa1BxMHlhSFVuRFFCb2lJa2NhQzRsT1FpV1dIc0FW?=
 =?utf-8?B?REovRllOUWFGNGpZU3JpcFQ3TElQOXEyTXhINWk3V3BsbFE3L0tXVHRNTURo?=
 =?utf-8?B?cVkrOUhWTENqRVJiK1M1dXZ0ZG1tcWZOL0MvUnBCRFc4dWFqcTd0MWpOd2Ja?=
 =?utf-8?B?ZTBIeVVsWFhQNXZFU3JzcXJlYzFuVXBIMkp5MGQ2SDFkdUl0dnNNOHFTM09Q?=
 =?utf-8?B?b1UxNjZ5eU5FSlF1dVY0MndjOTYwRmZ0a3FySExUZmNuQnZUUGd3aVRjWjE1?=
 =?utf-8?B?TFFCZFc5RGhvVlN6YTVqZXFvWWs2cVZqTFVJSFZwUzExb0tJRmlDenFOaGI0?=
 =?utf-8?B?cWprb0RIK0UzKzVwd0ZhcmtDRGVlMU9yMWQ2RFlZeUs4RnBOb2tJNWg2ZmpU?=
 =?utf-8?B?WnFkbnUyYXZiRy9oYWFsQlArdmJJUUZ1ZUU2bFZSWVZZVWNZeStZYkdVa240?=
 =?utf-8?B?UFBnRUppREthRk00a2RQcXBRWXRUWGdka1EvaVZLay9sMjczMGhWdG8rYVpJ?=
 =?utf-8?B?dG9uN3doWGtwMUFFMXVEcXJwY29FMzJIQ3JJMVRxN2NNT0QvUEpZZjVRSnNn?=
 =?utf-8?B?NlZPOVlBbU5lWjhVVkQyV3NIRnFhYlpFTEZLcmM3SisrUXNWMDl3NzNFOWlH?=
 =?utf-8?B?R3drS3pSQXdnbXlnZVVnaVpxWDFNU0tMREp5L1Y5N3JKVERRL2c1UzJ6SDBj?=
 =?utf-8?B?QXJrT3h5U3V2M0psanFUUHVzbnR0Qi9RVWJQcSs0V0JMTkQ5V0VoVHJRMm1o?=
 =?utf-8?Q?eDASaUpVx5RNt/DPHRY16mmUt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df84aad3-3cf7-48c0-8273-08dbd507baea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 03:08:58.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jgUrZZ0g0zdzKh/DXE67A1Zn133GiKaaZ74FMSPuqO05IsvOLANzPeg6t8r3nGfzoFu7qbTE4wBX4U8sZ4oIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7697
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 11:03 AM, Baolin Wang wrote:
>>
>> My understanding is that arm64 doesn't do invalidate the TLB during > context switch. The flush_tlb_page_nosync() here + DSB during context
> 
> Yes, we only perform a TLB flush when the ASID is exhausted during context switch, and I think this is same with x86 IIUC.
If we remove flush_tlb_page_nosync(), can we still claim TLB is flushed during
context switch for ARM64?

> 
>> switch make sure the TLB is invalidated during context switch.
>> So we can't remove flush_tlb_page_nosync() here? Or something was changed
>> for arm64 (I have zero knowledge to TLB on arm64. So some obvious thing
>> may be missed)? Thanks.
> 
> IMHO, the tlb can be easily evicted or flushed if the system is under memory pressure, so like Barry said, the chance of reclaiming hot page is relatively low, at least on X86, we did not see any heavy refault issue.
> 
> For MGLRU, it uses ptep_test_and_clear_young() instead of ptep_clear_flush_young_notify(), and we did not find any problems until now since deploying to ARM servers.
