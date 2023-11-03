Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8091E7E0ADC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 22:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjKCVue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 17:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKCVuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 17:50:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09EBD54;
        Fri,  3 Nov 2023 14:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699048229; x=1730584229;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qr+HEnO2zIp/UXtHx3q/WQvQc/5gxHUCcj6VHSi+9Bo=;
  b=JMdCmS+Oxct2mveZjKYhOVl8R0sk8IfkAooxOO3nw4pv9VaKV+//CQB6
   mzQlS2J1Qr3fbxNs4NyQboKpbvU6uRX0hNCkD+2QWnQojx36qnbbxSmud
   9w6e8A0q7jSru5i/5gG4KOB42YnlTK4RaMcl0+nxKIy7S4xwYmFAEzMS5
   vp41/G9L0RhVUrGVk2Y58nx2El0plxgXPqR1Yh1DgvuRZI9OqJ+wmEKMF
   cbFZc99TkMg6AXyOpW3um6QF79FtSsA/yjapcUrmBsoCy96Svuki9GJk0
   /DuDCb+572e8QKiogjwpMGOhMcfGzi7FOKpueauPjg1izxeUiWOPsCEAt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="388853792"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="388853792"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 14:50:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="9866828"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 14:50:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 14:50:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 14:50:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 14:50:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1rbPfOS8QlYm9MSRFRJmydtfeQxsoiO5P2RvMC6II3QA3vISMFl3VkhDpuyL50prS2M23MI4rViFdXaTmdcIkby/DhAL4jNv8QwjrgLA7viiKeHRZSv6GTsBLdElcVfDOil3RuSPkFXGAcDDF/1h2jDFzBUPh5eBotH2cmOWHQrluxZA6wVlrU1nOmIsCsfbcXEzFyMWtHhGFhLYHDLAq/JayexC7JiEI+3SrHpJH+XtytRfUeBLelKSN5thqbVQcwfitiIUy1+CsdIhXaTat8BjnaEIL99cq/CUrcTehA8e42qstI1WYj+sXHtOj3NY9vYyHCSfDA3XiyF6aCTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7sWIIKKDrBn305PCQgwr3ol8e5pTmHl4BkLRwcM5Z8=;
 b=b+GMOmHFBvrvS/p91mcRoCCfNlDeHkVCQNvaTyODTlvs+wAgi20e/rIDBlIleYykMpGpAIYyeuwBMNMse29Jy3+6LTssVm3yffhzFLs7i1hv2FaWwx1B42Lnq2QQXYYBlk8VnDztxM25sVhKjqnIVvsDp0EyzLWZ3EGwnxei2p6uruGvDWHD+8ahAtSzAvay3/YD/qkI6NN7A15DiOf3jLSr+s9s54VWHJpDq07H65CZQeSulmgLh1x/T+zSRBmqSwAeb2d2zrm48IlvzARwEgQz+YP4oZLieFDYOqlb6d6rZfdPT/NjAYtEl+3NqIEXngUwvNX4kwBXSUfM0rXTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5521.namprd11.prod.outlook.com (2603:10b6:610:d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 21:50:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 21:50:26 +0000
Message-ID: <0b580b8d-415f-4e5c-b042-1b66496de186@intel.com>
Date:   Fri, 3 Nov 2023 14:50:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20231025235046.12940-1-tony.luck@intel.com>
 <20231026200214.16017-1-tony.luck@intel.com>
 <0cee68e9-e188-46e9-83a8-02259a9c081f@intel.com>
In-Reply-To: <0cee68e9-e188-46e9-83a8-02259a9c081f@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:303:16d::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5521:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d834b11-1b11-41db-7d27-08dbdcb6e358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7Ykb2BbGFPhmdPjKbYNERZMIiZ070AfNfRHy9iveUDCQYA6ZLtGKQIq1YXflsqM4GPngpR8RbmSVYA66uqVhwZYnnHlXyePXsLK+9PSvISFvuAL6L6KApx+3FrjtzmSEIxbMlGNMRddC0/Psg2hOhcpcNl7ltwjagBqiBZQr92z73gQwjPcwtPkowpw4GEaeAmQlJ2j1NHnS83su6H9MeizFhPpIf5yKh3QiLC4YL4PInqUqEc/PFU9N01AWbbww6lDpfAUWqi97ckEA17SghDwhHx3cKbc4dUEgjXuWwEPGVynxXknG+dpeMPMdP8qnRvLyAV0o3nJB/uWqts0tmyrGxRp0waDYFyM0xvy1D4d7ukkD8tKVLzMYLRn4nOlNEPqCeUhExFco/jA//eizzpiU8Gu6Ub1stEuPlmMccEkf68Tohb9rmgsiFhSPa0oU56KvXzixI6jsH9SgpV+LACBmzU7MJxsP8laBb3iq7QCURPhHNe2AZEVOEDeBcCbPFeJy1WNB5PA7z1a/7pIaOD+jpw1RBeXAxwqRf9DEpE/Asu1kx3tDg5DDdvRPtDoW+0obr3Zt0Tk93k8dCJY9XuAHtTeRMGVRUQNO6uBg5TLBFu3LVDhl27+8vSD/zHaLxi44pRkYREYlHq3VFk/vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(54906003)(44832011)(8676002)(4326008)(110136005)(316002)(66556008)(66476007)(66946007)(31686004)(7416002)(5660300002)(8936002)(2906002)(4744005)(82960400001)(478600001)(6486002)(41300700001)(86362001)(6666004)(53546011)(2616005)(6506007)(36756003)(26005)(6512007)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFAxNGdybGFmVnlNT3J5MWVIQlNKdXkydHV3blVTZkhVUWdYYUtFZ09lc2Za?=
 =?utf-8?B?WVBYK0JPN3ZXN1MwZkZlbStzQVVCaVd6OWRRRWJUKzZ6TG9VYzJ1YnIrQU5E?=
 =?utf-8?B?UHErNlVLdkVtckNaZyt6VHBUbWNTMGpWMmxWSnNNcUZPb1hoZjZhcmRQc1NZ?=
 =?utf-8?B?QWlRZTc4UzNVbU5tK0dCa1VadWtObVhJQW9rWjdiSjdGV2VYOWJQSHUxUXRE?=
 =?utf-8?B?cURNRnc1UVhTVkx3RVc4Qi9hOEFublBWb2dnTVI4YS9QOWFNR2xJYTZ0OXE2?=
 =?utf-8?B?RzhMdnhsT2lydWR3VG5LTm5zRzVleGFDWlNhQlhwRHdNMklYeXdlaTlYMHVh?=
 =?utf-8?B?M0JrZTBVbUJzWXRBeEVLK011S1BEVWR4REZtNmlJUm9mYVpEaWRiY0dqbzYr?=
 =?utf-8?B?NXhURXV1d0lOMG1rOHhIL1o4cWZQNVlKVGFlZ2N5MVl1b01rdDc5NUpDbGFl?=
 =?utf-8?B?QXozZGpRcStwRlhOQVZXK21aVjVib0dRcHpxUDJvWFZPNW44cEZNaklBMkFW?=
 =?utf-8?B?SWtJaU1mWU4wamZhZGIxaGllcXZ1NUFKVGFRRzBmM0o1ZVQvSGJReGMycUlD?=
 =?utf-8?B?RFdXaVBKNzJRYnBYVlllWlVML3NTQ0FKOEJ3eG1IanRodmxjT0lzWktLak5E?=
 =?utf-8?B?ZkRaSjJXZ0F3ZzErMGM3U3NTOUh4TlZCTDFhSmpPOHMxeVR5VlkvWE9WWU1v?=
 =?utf-8?B?VkdmK1docnFYdTJpSjRHOHZCZ1hHUEk4N2VSbnFJbzE5L3UzV1k4WHRGSjdG?=
 =?utf-8?B?UkJvU0padm9oWGlvUkpHQ3RTVkVWNlBJZG1wYjV4WjRGQkNiWi9rUDJvZE9V?=
 =?utf-8?B?cUNScFVwampkK1g0VnFQT0dRQjRIVXNKaDg5dWVBdmR0dUE5TmVpWjgrNk1O?=
 =?utf-8?B?ai9GMWFNbFhTdFJrbGhYRmxvYkY0K0dxQkExc2ErL2pia3N5MWRhQ0c2U1gx?=
 =?utf-8?B?ZzJqNUJFV1QwaUJ4NDBnK0NDRDBFeDMxeFU3M1dKYVM1MGdSV3pEd2F1ZG1R?=
 =?utf-8?B?Zzh3cWVqWXM3RTJJVldmNUlSemUwSUJndi9Rems5US9xK2p1WXhhUG5vQytL?=
 =?utf-8?B?V20ycnE1bW5WQ3VoeGpJaXpEZHd6eDBFMUtIN1ljL1gwdzhYRDI5QnNTMUMv?=
 =?utf-8?B?Q2k0bGJ6dU1JZ2VGT1dxL09ieTRRR0ZVdzNnNXB5Tng1K3B0enQxeHJleE9r?=
 =?utf-8?B?ZkVwbytPQi9tUmlQUmZmRW1wZjhIQ1pEeEJxZ1FnSlF2VDhSck4wU3FSa0J1?=
 =?utf-8?B?cUQvd0J3aWNoZDZTZ3hsSktOd2ZRNmdENm15dDZtNTdtVkR1S1BWVXFvdG55?=
 =?utf-8?B?K3ZFZlp6WHhwUDh3Y1hIREg1YXB0ZTJrOCtMT0QwYVIvZjNFTlRwWlcwNWg2?=
 =?utf-8?B?QXp3TGVtdHNZYWx4ak1yWkN2U3orV3RacE56VlhJZS8wTS9FVHduZlYwbDlK?=
 =?utf-8?B?Z2NlQlI2VGpIYXlQd3Q4YWtlUHVYdk5KRCtjOG52cFR5eUNBeG9qR2lwV2hI?=
 =?utf-8?B?RVYyaXdGY3dBNEFLd2VNQkxKZEN2YU95MnRkbjVsWkJabTFseVZ1QmhISVdL?=
 =?utf-8?B?S01jdy85Z09BUU1XYmZVU0kvSFlENHJrZVNWYzI2Z3MxK0NCdDdGWlpEYjBa?=
 =?utf-8?B?WEJrd01jeDExb3lRRFFlcWx6YWppbklSM0dDREtPSm02R0QzZDNpRUxhaDlT?=
 =?utf-8?B?NXVDU2Y1ZFpkTDFmUnBSN05GcXBYa2labSt2alhucXZOT1NuMGd4NkIvaEYr?=
 =?utf-8?B?N3d3aVoxZzdOemZqUUdudENVS3M4WmZtWVM5aXRLTFB1b2hQM1J0VHNJWitn?=
 =?utf-8?B?MHJjbjg4UGhJdkpmeUlybEtURlpiL09Hb1lkbE5LQlliT21mdVc0MzkraHVI?=
 =?utf-8?B?Q1A2YXRYUlFJdy9OY25ldGhkNTR1bHNQdHNwa1grL3hJcjFTN2ZqeW9RNTV5?=
 =?utf-8?B?M2RnTGlGUXJYYXFrQU8rSjdTbmxSSVh1cFBLQkhVU0pad1U2UTRWekFFTVhH?=
 =?utf-8?B?b2JlcnM4Sy8rZ3BCVDQ5c0dmbjdQZDFCNWZBQmk5ZjN1T1BkcW9xQ2FOM1ZL?=
 =?utf-8?B?YlZtNzB6L2R2UWVKM2VMc3ZwbFJDay9NdVRlUnpFVnQ1K2RnT1BTbUNRVG1m?=
 =?utf-8?B?ZzVMSG14cjdTTWgzVWRZMkluN3F2OHhENVNzRFpKdExudXRJVFUyWjV6WHYv?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d834b11-1b11-41db-7d27-08dbdcb6e358
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 21:50:26.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ttl9onAsyGMEIe4+4R4EhqmEHExgaR+7tRLvXzsgPLJl4aZxtdvH4KLSJmoG/uc7/steR7MlDPqnbzoZFLPaz/uW5GrDXgrc8vNj/O60reo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5521
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/2023 2:43 PM, Reinette Chatre wrote:
> On 10/26/2023 1:02 PM, Tony Luck wrote:
>> On Intel the various resource director technology (RDT) features are all
>> orthogonal and independently enumerated. Thus it is possible to have
>> a system that  provides "total" memory bandwidth measurements without
>> providing "local" bandwidth measurements.
> 
> This motivation is written in support of Intel systems but from what I
> can tell the changes impact Intel as well as AMD.

No wait. Sorry. AMD does not enable delay_linear.

Reinette
