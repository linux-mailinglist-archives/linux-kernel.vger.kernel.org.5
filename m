Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A27780AD95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574691AbjLHUJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjLHUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:09:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C75093;
        Fri,  8 Dec 2023 12:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702066192; x=1733602192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5KkgRylyAgOh6kFcB+6T0GKo4f6Cv7Z82i7HQ4WoAew=;
  b=UQ+6wDciQZCN2f/f5ZSdgF1fGod7VyNvqmtT3210s8nMZKqUbdgKPmOa
   EovYCnzVXv1Y+wKlI9b/JZfz3UGweOErnwkh/LkaLpjDDm4HtAI13IzL6
   MiRjJnxqa9pY9+r6B/T1MPUXngj6zmShquBpgfF1I8+HljtEtZjZOCorc
   rfk7lg3ylb1LZuN/hbGOfDx9iIohacaKjy8AIXObjsLae9Lv5vQ8uTUEL
   KnNjPtXlE067V3wP+0/SQWujwppkDAEU8ex+c6OzoV+AOICx7+F96fYJX
   4TkLVtv/lJ2leHwablkWhpWg77xV0Lkg6/2t991fLXyD9o36q2hhGg5ny
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="460933556"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="460933556"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 12:09:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="945530220"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="945530220"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 12:09:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 12:09:51 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 12:09:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 12:09:50 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 12:09:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRecY0UZ1Q1XmGgIFfnrwAWjAFXpCh0ycqaVhel/GDvwUNT8DVysiRHTlLylq7LMlDqWAdki1xGZimZWR0cQyC7omuLgi+POAmLwyoBWNyb1Gyp4VXvaXxJBRpxtvfw34eZOBw8lzbkeQR8UxA38rNUfjAgcsEWQGKgq2tjobn/N03iU0QCeFqy10UTtbw63J2lzjLSHKk1axzbyIyPsoTJCp5x/o9/Zf7djm1dhz+fYd9lENx013oI9dBgU8Gqh+8oRThGmkJXPzoovT0iZhzYlp0seFNydggb01/XRJZXim9MeQtZKCW1Bz23hQxhKUMJOv3cmJYur7Pdd+H75DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEh6BcPaAY7whBJVS+JDFBd6nLyHl7MYj3fBexrkMn8=;
 b=czSm7oZxMhuybsBQLap4fwEbGYli9nYZ1BhVPCPHHpo2ajvrsJFsTjdYnOSe2AG5HyvwynSwMGqC5lfFFR3ld96jGgfiLgxcJdeYbmidSlXWeyjxCSSKvhDsijI7TSH9gr/mWlWX9PxMSVehn03z4wGvP7IMl4SpyauGt5+ofnLK6oAdRNwPmhWuYEVyQ3e7wDSzBEn95tClwTBhCsFg3IKWJfNI8Ums6+k+YLCcqNYhUKImtySdb60rL2S2/YOZgw4jkG05Pv5Ag0cJxfC5Cp8StjS8RDEyfif9k7IFe2wVhs4otb7bV1NkjHSsVXGZHRLR+Z6wIxx/ZtWIrFZxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6309.namprd11.prod.outlook.com (2603:10b6:8:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 20:09:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Fri, 8 Dec 2023
 20:09:44 +0000
Message-ID: <d8734783-f310-4f8b-837a-78f838669281@intel.com>
Date:   Fri, 8 Dec 2023 12:09:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning feature
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
        <tj@kernel.org>, <peterz@infradead.org>, <seanjc@google.com>,
        <kim.phillips@amd.com>, <jmattson@google.com>,
        <ilpo.jarvinen@linux.intel.com>, <jithu.joseph@intel.com>,
        <kan.liang@linux.intel.com>, <nikunj@amd.com>,
        <daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
        <rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
        <maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <eranian@google.com>,
        <dhagiani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <d97cbeba-af6d-4b64-b5c8-32dc437a67b6@intel.com>
 <CALPaoCjNgv4rFpbovyayNynuAqYGP0rVLv=djVnDO1LR+zU55g@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCjNgv4rFpbovyayNynuAqYGP0rVLv=djVnDO1LR+zU55g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:303:6b::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: db17fa4f-73e6-4ca0-8ce4-08dbf8299e24
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+QOuX2QH+ca1TCpCJeJZb1W6G3IerY582lmGX1DUNMu68wNumZ/MpP3fHU3T4GPKlknGZ386RtFnbxN6Hu9WZQzptrE+91wOqMPzkPGpULWvyA7ECMZvWyMyx4H+XlLL1DNWDkC6azB1XEUXsqZnmjrLhCD6GDbZzAbNydX95Jmw4VklNxnenPTtqr12Uht9DVZtOlbqcpLTnM2D7owwSRFUuSc1MDQtpjol+H0uxuND+5/ij+8QUSldbEYoFZKkzlPY6+N5BXRjkZU/Gylqrne2+M4LTe7XCxZtIvKHicSUiq3j8w4oyWTksv3iXqjxEs4Z4Y0Ac2XJfXzZzvPHGFG8WHnO6VGjRTwpEGY/WU3PKJmtVec4MRBX4G1Tsq5Pm/fyo84WzVoQg54hvQas08JUMs2ipljb0JKnkzl2U6Q2YnIlttj+CAwTUpFXvNb5Xy50JZu+puQORw/YLj9WrRuaTWONsbSn8/SAhO+ge0CUY721sibxyAvCWjPwPqs0N6lBQ8zCYW4KM2bKUg6YyLe4q1n3TDNy7aJML1BLIzcx4gefe73GfXrHv175n0VUdUE5Vn99BdLMvZl9hDGEbYopPDIzCWrU1E58GQ8zWoorpHhE7LSukbkFGY4lyl6xMcigfVS+spBnZbCJB8W4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(83380400001)(6512007)(26005)(2616005)(6506007)(6666004)(53546011)(478600001)(6486002)(966005)(316002)(6916009)(66476007)(66556008)(66946007)(54906003)(31696002)(38100700002)(8936002)(4326008)(8676002)(86362001)(36756003)(44832011)(5660300002)(2906002)(66899024)(7416002)(82960400001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzQzV1g0bWFhSWRZdkx0dmJZSjNCUWp5alFnV3ZXcXF6bTlIaG01d0lXbzJs?=
 =?utf-8?B?ZWo1SGJ1WE1uNVFPZEkxZ216L2tJV1ozWnBiM21wZUdxSkE0QlE1VDBJRkJm?=
 =?utf-8?B?ZUJYOXBXdzlqTC8va3RhMmpGQlhnc3pkQnp0alAzWk1IMFBGTGp5OTltYitR?=
 =?utf-8?B?WDNqRnorTlBJR1JJMzBKWmIzQXhPTEliMlBWNC9FYS9RdVJCb0V3L2dOMUV6?=
 =?utf-8?B?TkVkSU4wQUkzMFByT090OFRaQ3BoNlU1VTNqMW9RQkt4eUk2YjJvd2hiMloy?=
 =?utf-8?B?VGNTdWIzbm1pK285dWNUcmdEV0NBcldKWVgrVk1ncmdqNnRsUGNKclFxbEJi?=
 =?utf-8?B?bzRwKzhkTHpGVTJQTnZkbVdoam1Sa2c3a3dlOVRDbWFWcmhWRWxMZ3NIM0Fm?=
 =?utf-8?B?aU10K1JRYU1ZR3VmNDIzUEJ4OTI4V2JZdDZDZVcvZGR2bDVMdVVrZERiM3Ns?=
 =?utf-8?B?Z1EwbHF0T0hzaklWQVhMOTIxQm14cWZCdXBwSTJYVk5wTG1QT25OMExxK1RO?=
 =?utf-8?B?eTdTNTlqMWNBR1FlT2VJYWwxcmNURU5ZOFlWZGZtbk5WMCsyQ09OaExFTDFG?=
 =?utf-8?B?WTlBdEloZDBTTjVxbUdobmFtVTFqZFg2K3RoRDhNN09EYml2SnVld3VvOE5L?=
 =?utf-8?B?enhvVDhlcnFsVTRQQkZka3Zqc0Y1c3QraXFTdzVSTGJqdVlXbEZWelN0REtM?=
 =?utf-8?B?SUh3NVQ3Y3UvTkFEUXpIL3NXb0l5MXczdFNHaTdGbXBkU3IyUkI2d1RlU1F2?=
 =?utf-8?B?ejRQcEhCRnJTNWtlQk84eVpJY3JLaDdMdHpuOGhmaGZKcnNWK3JNcEVTTFdz?=
 =?utf-8?B?Q1YvWC9xaVBld1J1cHNyS0Nnb2FqdzA4YnJ4Vkd1QkMrdlJOS0VDNWJTQWJS?=
 =?utf-8?B?dUttNVlZRXNHWFhvRnE2Y3BKUWhsVFQreFM1djBodVZmdzN0bzdHZEpadkdT?=
 =?utf-8?B?M2wrMXo3L2V1SDdxRDhlbWFoMDZFY3VPWCtqc1BLZUhiTDV1THlFLzE0cVh4?=
 =?utf-8?B?YjJhekxMZXRhQ3hra1ZjZW03K1J4aks0N2RkcXRSWE53eEFwUms1RWd3cmlB?=
 =?utf-8?B?NHZLbDN6aDBuSFpGcE5vSGhoUEtwMXFCZmlhbVRTbTdLcGhHN25lNUtyUEtJ?=
 =?utf-8?B?ZGJiRE1SSHFIbmxqZ0JXSktjRWg3NSs1WVlCMEZlYVJjZEtKcU1ub2NXdXNG?=
 =?utf-8?B?Z0NKV1A5VDZVRVk1RzA2bkJEVGZMT1JpRm9jVmZlckNVV0lFeElnc1pPWTEr?=
 =?utf-8?B?dUl2TE9XbzFJOGk5VElvZUJSRXhrSnVuNWFyREdSYkloQUhIZWx3bHJsazBs?=
 =?utf-8?B?S1dpSlJUN21zUTY2dm44bjVSTmc1UmtmakZVWkZRM1VVeW45cmJyQ1FqeC9T?=
 =?utf-8?B?MjNpK0JRKzBaYlZvbUFob3puRVJVcXNkRElrVUNCUVRKOTRjYW5rVlVCcXVy?=
 =?utf-8?B?cjB2dTdINEFxUVhjTnFCektpVTRtSzMyZkFHb000TTRnenF4TlFBcktvR3pQ?=
 =?utf-8?B?Um1FMFJVY1ozcExvRXVQLzBhYU94ZUsyZlJqc2xiOHhFWmVxQUJ1cXNQT0N4?=
 =?utf-8?B?elRqTHEyWS8rNlpDWllMRS94eHdSQTdaSS9LR0dScmNZZFovQnl1WnpBQnRU?=
 =?utf-8?B?amdBVDBiblZoTXdwblFPK2NWYVR3UGdpT3JlRFJrWWxBcExLMTJ2Mi85NUhY?=
 =?utf-8?B?L1gxenRIMVhlVGVWd3RNYnJqODNndXZwVUFmby9hd0xyVHM2bWZoV0RwYTZp?=
 =?utf-8?B?UmpDOExZa05EcTgzbWpjdzZpR1U0aThna0grVlNySUlhdXFlR2tURkRJL2Qw?=
 =?utf-8?B?UUtQd2t6TS83dHJqem1sb1dzQjNaL0oweTU4UkpScjJlTmNDTVZ0am13VWpE?=
 =?utf-8?B?Y1lIb29GUlR1T1VldGhMTUt6ZHg4MnhjenBNZmk5RXRmZXAzM1BrWTVxamRi?=
 =?utf-8?B?andSd2I2SlZQdTJUMjFaTVhxWGxTd2xINU16Z1pNcXNHR1RIbG1kMFQyblJu?=
 =?utf-8?B?d1l0cWc2ZGVIcW9WcEVOYmg4NzZEVXRXYjM0NHNrbU85dE5xeWEwdEZEUTR6?=
 =?utf-8?B?R2tjS0syUUpQdUY0TWI0cGdpeklTa2FGdDU1czRxRndCN1VBV1NOK3RRdm02?=
 =?utf-8?B?YXpWNE1ZYnd4a2FPQWk4YjArU1k3Yks1WTNSK0M4ck1pdEpaRnMzS2xXVEFN?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db17fa4f-73e6-4ca0-8ce4-08dbf8299e24
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 20:09:43.9426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLFJGj1ZV/rkI+xCRPE2uIxqEesU0s1rh0Y/S+nUBsf+IpE0Q9kRnUNUMcuJSdp7BTdMVj9WRjzioUd0ae/wIK5IZGvgAE10xSZEASp25Gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6309
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 12/8/2023 11:45 AM, Peter Newman wrote:
> On Tue, Dec 5, 2023 at 3:17 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 11/30/2023 4:57 PM, Babu Moger wrote:
>>> c. Read the monitor states. There will be new file "monitor_state"
>>>    for each monitor group when ABMC feature is enabled. By default,
>>>    both total and local MBM events are in "unassign" state.
>>>
>>>       #cat /sys/fs/resctrl/monitor_state
>>>       total=unassign;local=unassign
>>>
>>> d. Read the event mbm_total_bytes and mbm_local_bytes. Note that MBA
>>>    events are not available until the user assigns the events explicitly.
>>>    Users need to assign the counters to monitor the events in this mode.
>>>
>>>       #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>>       Unavailable
>>
>> How is the llc_occupancy event impacted when ABMC is enabled? Can all RMIDs
>> still be used to track cache occupancy?
>>
>>>
>>>       #cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>       Unavailable
>>
>> I believe that "Unavailable" already has an accepted meaning within current
>> interface and is associated with temporary failure. Even the AMD spec states "This
>> is generally a temporary condition and subsequent reads may succeed". In the
>> scenario above there is no chance that this counter would produce a value later.
>> I do not think it is ideal to overload existing interface with different meanings
>> associated with a new hardware specific feature ... something like "Disabled" seems
>> more appropriate.
> 
> Could we hide event counter files if they're not enabled? Is there
> value in displaying the value of a non-running counter that will be
> reset the next time it's enabled?

It may be possible to hide the counter file when it is disabled but in this
case it is not clear to me how to communicate to user space that it is
an available counter that can be enabled and by hiding the file one mechanism
to actually enable the counter is lost. It is not required to
display a stale value when a counter is disabled, text like "Disabled"
can be used.

>> Considering this we may even consider using these files themselves as a
>> way to enable the counters if they are disabled. For example, just
>> "echo 1 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes" can be used
>> to enable this counter. No need for a new "monitor_state". Please note that this
>> is not an official proposal since there are two other use cases that still need to
>> be considered as we await James's feedback on how this may work for MPAM and
>> also how this may be useful on AMD hardware that does not support ABMC but
>> users may want to get similar benefits ([1])
> 
> We plan to use the ABMC counters as a window to sample the MB/s rate
> of a very large number of groups, so there's a serious concern about
> the number of write syscalls this will take, as they will add up
> quickly for a large RMID*domain count.
> 
> To that end, the ideal would be the ability to re-assign all ABMC
> counters on all domains in a single system call.

Understood. I've already pointed out that this is a use case needing
to be considered. Please see [1] - search for "global enable/disable".

Reinette

[1] https://lore.kernel.org/lkml/e36699cf-c73e-401b-b770-63eba708df38@intel.com/



