Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50117BA898
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjJESEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjJESEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:04:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D690
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696529076; x=1728065076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wssx7RA1uFWjcwqFDvO1D3Ds5C9Kd4vcRcLkk1fYr6c=;
  b=WX4/UaZqIYnHquRtIrn8zavPZkE3PeNErhk3K/RxtmU+Som9fyrMbAGu
   PQqUmji9vOgRY17JgbXb2LOdxEWd/XyuO+T/HUt5orA13+nJLDoTQe+t6
   8EVGj+O61SKuVFWceak3kXKbB6gl6zGFg7ciZTD06DvELPSh3Zo9XxMNO
   TWdsAEQAfocA64aDgA69DpfVktqZpqlxVfwF37/HAyqVH49P90ZW7wJqO
   96iPrapskie6pp0PwCbZZYhgcHbkPQakz6ysSXEqq8QRX3ZJVImNuVK3C
   U3Hu9H1RSncrS0eKir068yknE6D32yayyVTtcPw/e25m6I7O330czxCMz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="469848825"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="469848825"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="868007309"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="868007309"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 11:04:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:04:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:04:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 11:04:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 11:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kShSRF/92Wmf7Hh4Nr3e23BjvXMb99JiRW4Zq40QpCSGfdzyQqzCV6p3+0Bdjcl5fF05gI/gfcaXQ8ToeH9A5zkDU9zDPf6QD/FBOpojegfr3nx2C3Xn1R6iEtDHM0DLlfz6StzA537RC0ZiAr6LZoVP3cWe6hlINxNMbYrIvXuuoba6yO8J9Pin94+ZuhOTL6NS1gJ3LJzwoH5rbPAhjlz9CO182PtP+By/DSWpBKwyhoQtxMfinpxB1wT7p0ht1yvtno1IYtUovXPRTd2oeC/c+HnQYBRV3YqWiJdR6df0d8LTEvtQcDeR08Lcsfr+fTlLfdUxJhRSGGY7FG31zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfsUoEM+YxRdzYyuBrdvBmFxn7KFD5fyhlCUZPluVx0=;
 b=X9bb5qh38w0/0gC+4lHfHXK7ionx0c5JBVVyn8mr7fvN1V3FSV+1htPHBqi9HABXwOzW0sXTkRX2UAUvsFiEpPLRxoXWsz0+i5s9aAnCSbbYB8Ymvujn1HsO5RvftWUHI+OqOPr7H9iymMg0gYPMAqiqfwfB/C2d/JIwCJ+x9+xLsyScjLsl+htxIAdjN2bToWOZXMDcH3swZU3uV58IqDY9wdvMJQguaQBmszcucRSMChjf6IT7WRb9J4y4zhTEuUSMJQG+xkgojkGwCyahZOJHSDRWnPfSqeU8WZgvwHxk6m1OiETBGl3KMhjYOyVqVHgKVDk6WbabSd3TNPNboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7904.namprd11.prod.outlook.com (2603:10b6:8:f8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.31; Thu, 5 Oct 2023 18:04:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:04:30 +0000
Message-ID: <7b793937-ab79-48be-8f82-4bfcfc464045@intel.com>
Date:   Thu, 5 Oct 2023 11:04:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/24] x86/resctrl: kfree() rmid_ptrs from
 rdtgroup_exit()
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-3-james.morse@arm.com>
 <9606020e-c322-fb6a-a6ca-96ade7aecf17@intel.com>
 <550fe399-8904-c515-f556-3536ebe2e9a3@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <550fe399-8904-c515-f556-3536ebe2e9a3@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:303:86::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f4a58c-6d83-40f5-3135-08dbc5cd85d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rCmUm7ug2px1BE1i0uQBoVCgc1eDGgEe8FPN4qZ7ebgAtBX+SUGDhzvRglCn4f4L2TiU9EjTiBF5iKctaZo8TppWY5iuhmEomabln4/mVl8DlSidiAjIX+yfz/qbZ6A0iDpREfsB3V8fg8QT/WRp5wLc5VMAPZK5s036JT+i/Gz82oWvd1hWwUBxn9D8+OJoMWukDJod0wh2QGKUFZRz5B02EdwXnHkaLO54esCzyP2RD4aSUjjIqffMUPLUUefGMDNCvelz1dnBY3cgJtS5kWCA95iPCkH8qo7M9nAlgk5sDZtldxFUVVW3h5fP7TYgr1jKsXF2hixdIq5l6iMt3m/jQNvuPFpLU14gj9AxHy17EBEJpbb+PCOAJz4wgZNsXu3ZCOji19qT2zWRZSdQ/uV7MYPd9rxFAmRQOhk/0w/aNX4r1ijLoVMzdHqMnG6CeboZOYXQwDZA1USu3JwwFwRkh/nasOF0wGnX07oCq7K372Um3DR0TkpclORfsjciNW4XI+OvFfB6GGMATa07UEpU7Z4pi+gWn0TWh/f7xGehE4W22R4l+cgq+LCn7BbUkn27qisg+pY27Q04krtSU1zEycJ8BgwDCCoIGbZTQhvHptNhiBwmCWtv7aJAzPELirjFon+rsst9KevLJH1t5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(6486002)(6506007)(6666004)(53546011)(478600001)(83380400001)(6512007)(4326008)(2616005)(26005)(7416002)(41300700001)(5660300002)(316002)(8676002)(54906003)(66556008)(66946007)(66476007)(8936002)(44832011)(36756003)(31696002)(82960400001)(38100700002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnFpZmdVaTNCQVl6cStoSzgxWUorZW5ER2N4SklPYjFjOVFzeEtjTHdCTXVK?=
 =?utf-8?B?eFZWazVBTVZWU3lPVWJuQktnR2ZGMWw1dis0bHlqQjhId1RtMlgyUHE3SUtB?=
 =?utf-8?B?bHRFTnNFNDFKVi9nci9NQ0F1ZEVsODdUbzRLYXlYNHI3eVhXWnpyVHh0QUJW?=
 =?utf-8?B?NnAybFJOZVVWNWFXMElQcDR6TDZiUXpaTnVrSjh6cFNHUXFwZ2VDR2k3OW5I?=
 =?utf-8?B?UHdvdHNHbklTQ0szV3lxRmpsUmVVaDhhVk51QXVFQnFqM3lpMkJVZmk4dUFz?=
 =?utf-8?B?VGZFUXQwUWNPU3N4cTFhbnl3Z3RheDd4MGJwYUNhVmVMckpZWlVTTldWcDNx?=
 =?utf-8?B?ek1adGFnUGdNUk9VNzBaSExPWm5VYVRranJWSlVjN1VQaG1MZlRMempEN3E4?=
 =?utf-8?B?ZUlKaTRHeU93SUpDN2pxaUJWbmttUjEwWVhKdDJpRHJHMm1ZUFZZbkNRK2Nl?=
 =?utf-8?B?K0lsMk9ZYWNqOHl4YUxNeWR2TWo3R1JpLzRmNitWRFdIRlY5dGpHTTRpZE8x?=
 =?utf-8?B?cEtNVjZWTlp4MkxhcElMY0xUR0YxWDdPYytsNTRXUEppOU1JQ0hiUzB0RnhS?=
 =?utf-8?B?YkdpUnd4WVZHenYwTzNpUVBuNEF2b3orajgwZE9nUmsrMUZ5S2ZITkdQVmtr?=
 =?utf-8?B?ZXNDRHNUV0ZxaDIyS2NHOHh0QUQrQ3FLemlaZm1sbnFiOWlvalRMUzk3bHZr?=
 =?utf-8?B?MGlETXJWc0UwT0krNXlHV1N2d3dnWXVhNjNyNTV3aHVTbEdYWnhkcjhIdXl5?=
 =?utf-8?B?N0xpdGxNaEVvdDRqai9MVk5DNXFXMG1HazhRK0c3WFpNNDZyYUh2dEZGMGkx?=
 =?utf-8?B?RUZwemorZGR4bG1xcjJZY2dEM0tOU01MUHQ4empMUHVSOEQxbVZ3bmUybmoz?=
 =?utf-8?B?c3dkaU1TaFhYZURCVEdGWWNLNjZnNllXZi9LWkNVVWg1K2xLT0FQZjlLMndL?=
 =?utf-8?B?amlrL1gvNG8xQ1RYQkxXK0xKWVp4QW5tSWZyYmE1Qi9STVBGaGlRVC8xdUND?=
 =?utf-8?B?Q2tseTEvMzdBQmtNQlJWMjJSMHVqOGNzWFFzWkMvbEZCMm51emVmTHlFclZC?=
 =?utf-8?B?VkNseXUzRk8vbC90QzJBY09SdnZDMUcrajNCWE1jN1kxb2VDYTVOWCtUVjNJ?=
 =?utf-8?B?M1lVSWJ0elp5TDBhT0M0cklqcEFPYjBrcEk4dTFoY3pSSDAvWEx5bk8vMG5D?=
 =?utf-8?B?WTBWdjFZUEp4dmVpd3hPSm02aXV5a3hHYm56cWh5Y1dvbHZOdkZodHgvVGIr?=
 =?utf-8?B?ckRJcHZzYndOblZ2Mk9ySkRTeTFuZXNDT28xODVHR0twMXB3TitxeVdhenBY?=
 =?utf-8?B?aUJad3RCcXc3MVdmUUxwQ3RjaHJ1ZGVzbG9OcnlDV1lLdk94Y1FKQ3JRRkY2?=
 =?utf-8?B?V0J3Q1dRZ3Q3bElRUXBjNW1Yem4xVXQ3K0Fva3JXbVNFMEFpUnJpMzBrQWEr?=
 =?utf-8?B?THQ1czFMTGNXekpzMGhHdTdqTHRBbFArZmhBdlQ5NmljbW9jeGt3cGJCVW5P?=
 =?utf-8?B?RUd4L2hjc3lFSGw4RUt4aGswMVVnbXU4c3ByVmx3YXRtQ2Z3VjY5dTI3cGJ0?=
 =?utf-8?B?elFPS1B5U0FzSFRnOVZ6anM5YXNKcnhsRmw2bkJrejR3VDdLeGlsditLcnBI?=
 =?utf-8?B?WnNiWTRsZjQwSFJha1RsZTN0RGdhdjRnVUVVS1B5YWhZSStXbWFwSURvS1hp?=
 =?utf-8?B?V0t3a2NVRWJxUWNHZVhpNlp1VTVFS2hsTCt6MjJXWGVqSzRXem9IVGp2Z1Q4?=
 =?utf-8?B?cGdBaHZIUURWWWY5OWt6L1Buakc4V0ZrU3R4UFg5YlpBbW9JTEhzdDVPYnl3?=
 =?utf-8?B?bmxNNkUyODByZm95UiszbVhrVnBPVmdqODVoZXhHNStqQmtQZVp3N2g4cjJB?=
 =?utf-8?B?RmN5aWQ4T0lMWEl6Yms2NFV1OUJHajd2QkZwUE1ITWpEQnpDRDY4dCszTXJQ?=
 =?utf-8?B?QkIxWmE5T1ZlaithcXgvcUZ3akRGaXNVd2lnd1A0cXMyclJES2ZvdkVIaVFH?=
 =?utf-8?B?NjNyekNjZE1FOWFCSERYUVhLR3dicENVUHB3MFdHby9uazhJcGxhL2lrWlRK?=
 =?utf-8?B?WEQ5U2FDRkJKaDRvUTBjWWdZS3NOekVKRnAvbU15N1ZWSVJCcVNTSlBTVUV6?=
 =?utf-8?B?MzQ2eEpDbURqa1B6NisxSWRMdkhHSGtsc0lweGRYVkUyV1UzZWFLaDNDVDNs?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f4a58c-6d83-40f5-3135-08dbc5cd85d3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:04:30.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXeQSQuN5yuyy+mTyrQAwaby+NpZIl2T6ailgIeBrfPFOhW6QWwxM5CnOT8Ii36rkKvfxNJ9nBXjiOwDU1ki6J01F2rNekGwGcfLi5yQhas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7904
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/5/2023 10:05 AM, James Morse wrote:
> On 02/10/2023 18:00, Reinette Chatre wrote:
>> On 9/14/2023 10:21 AM, James Morse wrote:
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 725344048f85..a2158c266e41 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -3867,6 +3867,11 @@ int __init rdtgroup_init(void)
>>>  
>>>  void __exit rdtgroup_exit(void)
>>>  {
>>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>> +
>>> +	if (r->mon_capable)
>>> +		resctrl_exit_mon_l3_config(r);
>>> +
>>>  	debugfs_remove_recursive(debugfs_resctrl);
>>>  	unregister_filesystem(&rdt_fs_type);
>>>  	sysfs_remove_mount_point(fs_kobj, "resctrl");
>>
>> You did not respond to me when I requested that this be done differently [1].
>> Without a response letting me know the faults of my proposal or following the
>> recommendation I conclude that my feedback was ignored. 
> 
> Not so - I just trimmed the bits that didn't need a response. I can respond 'Yes' to each
> one if you prefer, but I find that adds more noise than signal.

I do not expect a response to every review feedback but no response
is assumed to mean that you agree with the feedback.

> 
> This is my attempt at 'doing the cleanup properly', which is what you said your preference
> was. (no machine on the planet can ever run this code, the __exit section is always
> discarded by the linker).
> 
> Reading through again, I missed that you wanted this called from resctrl_exit(). (The

Right. And not responding to that created expectation that you agreed with the
request.

> naming suggests I did this originally, but it didn't work out).
> I don't think this works as the code in resctrl_exit() remains part of the arch code after
> the move, but allocating rmid_ptrs[] stays part of the fs code.
> 
> resctrl_exit() in core.c gets renamed as resctrl_arch_exit(), and rdtgroup_exit() takes on
> the name resctrl_exit() as its part of the exposed interface.

I expect memory allocation/free to be symmetrical. Doing otherwise
complicates the code. Having this memory freed in rdtgroup_exit() only
seems appropriate if it is allocated from rdtgroup_init().
Neither rmid_ptrs[] nor closid_num_dirty_rmid are allocated in
rdtgroup_init() so freeing it in rdtgroup_exit() is not appropriate.

If you are planning to move resctrl_exit() to be arch code then I expect
resctrl_late_init() to be split with the rmid_ptrs[]/closid_num_dirty_rmid
allocation moving to fs code. Freeing that memory can follow at that time.

Reinette
