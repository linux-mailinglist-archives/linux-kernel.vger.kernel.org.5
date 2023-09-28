Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121AE7B2587
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjI1SvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjI1SvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:51:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C499219C;
        Thu, 28 Sep 2023 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695927067; x=1727463067;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UZj2Eyco4UYWB9SDQSm1Zkh14YAV6VrPoanYVhMf73c=;
  b=QjLyzzk/GvmW09pxlWiEfwg6ZWDccE6IAD5PsaiII8vndIk9dNxTBwDd
   1n0rwF5ENyaz8Io8EjJbC1O3zJrn/WnQ5Yq0L3rOt3+ZAOaP0qqHuEeZP
   vYUGzKyrIoHiiteZ8HOGffISSPFxiI1yDccPz6HT4CfQKxcPThtQ1G5e3
   /dbrIojcrgHZX2z+DJOz1HIA7n3a3yVwOEYgNtEw2Mru8kURCuFonjEx6
   WbNOtdsO1S9Mlx/uLlEE190vnnVPGGxvdyVzwKtrhcp3QlvXlIN2Os/Jm
   6suNdgDCWatzCL9Oe30yV+TRdrGhkGtzuDuVle8qUfa/hni4/SeD9GtuL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="362393566"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="362393566"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="1080664763"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="1080664763"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 11:42:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 11:42:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 11:42:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 11:42:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 11:42:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdPUzfwBw5Pdw0EtUKWSoY9fX1YMET4c2vTkLFDlCk1R3/wAJOWYETrAlLco9Tnrspmn3khvkCPEWbrGNWYhOMAnQQbzmIK+L1XP8CorbKspkSW/+2meVRlI2FpjfVHSceLdM1PF1x5nFReALCEfeWHYw1ZOJfJI3Y0NeUHcFZuZa1NmdeuXikEGNBC+pshoXmL4cBYRAL4xOCT5JEMMQcfjx38fjhHVFPhex0bu8RZITE8M7xUbWADlPpfy1tDUzxBiMUI9In4Q4msYE3ElGx3NFIj/9EWq/JH6NWr74IvlogGOW/VcbQG2A2RlhlpgmD1hHxUPWu/p6pnMMmCtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88izL3flPAuKEVxRAc7AewVAkYr+qcQC2FFQW2i6h2o=;
 b=Dy/AQkIuZDarViE7NbInUgWA0HkTFjS1MM9uehqhcydDfc4chNcUG2hjuSOvE0Gc8W6iT4tw6Szqyuhn3GOzTxeis4tCH2iqhQZIsyAcQTAB9aF+S2NTnKTw2dD5UYbvp2sc78bNRquVnICdRF0vMQ27tdYmgXKf3yeQ3IczJvntGgZ17U8X14LRRc8o6gt+QkLE4WNsQoHl8BVmbllh+q9sn0lenYhq7fQrsvjDIIAckDGWLILUpgldApjtKR7fx+BOEYcq5KbXj+EvEIf3BuvhTnlR7+WD0JUjx8lBPE7A7Yus52cuEgh/AfNzLFdyfOOI8ayjiVjXlz8H5ES3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 18:42:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 18:42:35 +0000
Message-ID: <4b906b98-b535-e203-ffa7-6f6a34d6c54e@intel.com>
Date:   Thu, 28 Sep 2023 11:42:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/8] x86/resctrl: Split the rdt_domain structure
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-4-tony.luck@intel.com>
 <5f1256d3-737e-a447-abbe-f541767b2c8f@intel.com>
 <ZRW4zRZtgZ0cdzqC@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZRW4zRZtgZ0cdzqC@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0241.namprd04.prod.outlook.com
 (2603:10b6:303:88::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 52357b31-e592-42d2-cb86-08dbc052ae84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ta7XKeE3gp5F03bUvMrUuMBaFBAjqUxpoYqr05/ASw/5lK7HsmCuNvGc3syYfo7zTb4HTDYgBn7CFC+R0ZyayIEoLcl7SKaUMHKITfhGD0u6GV3S40S9zPc9DjGinfMr1nsiMo37+Fh8RwzDH4j2oxd79SgJowLU2gftZMsfGhaRKiS1kd41Vk1QjrVbruwmxd3SgLdkcwgL1w4PPfOUs7XA3MudoIDikPKqDStTCcAcPNM8Hh5S9IfkbHiRxqKrTkWLUJLiJixQOkOCuErpNluvL6IAbGTQtd7Fnid6UJvO+OTYuXfA0X+yNwTX+SxCRJUeSMwf1zaw2737sv3xEmDS6jr4ivemKOjDrOo+LGmy5xppXGuok1G93qdjw3Mn5lBUnA6PiSzwaHU+3Y9qQQZeHztiI0SM2e2LPgTeBUGuOom/9Cj4osKpIqGq35vDQT5h4svE2WFFFmKjsDq+wTKUrE5N2XgGSvoRCThRJzjkWjUQvpbP5sTInYFYq2WtXOem7ym0jnKTfNkycsCGILE4fySFGHLKvwVjZ+QxGfDpZwrNjfSnOwWsWA4aa2nl8MvCtAl/EQ7h8WvA41xRwrSFa3OQrZnrYK0lpDRbHl3rDqI0piKoHlD6Qszk0hid7W9NYUm05zKnoG4FUWgF8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2906002)(82960400001)(53546011)(2616005)(26005)(36756003)(6486002)(6666004)(6506007)(83380400001)(31696002)(6512007)(478600001)(86362001)(7416002)(38100700002)(37006003)(66476007)(5660300002)(66946007)(66556008)(54906003)(6636002)(4326008)(8936002)(316002)(44832011)(31686004)(8676002)(6862004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdXakhZZ3ZYc0lOM2w0R3hTU2RNQU9RWHpkbEtpWEFDT0xDL2k2WlhHaVhm?=
 =?utf-8?B?SVE1NEluSEowV1RVemg0NXZ1TjZrMlRYK2VlSU1GNVo3QlA3eXBKQ2NoQVF4?=
 =?utf-8?B?a2ZXZ3RMUnNVVzhCVUc1TUVGVlJPM0tyTzNVdWpGVGF0NDhBRzhDNDNDN1pM?=
 =?utf-8?B?SHczM0xSRlhlV014SGJScVFnVXRrY01rbnlWV1hLL0tZWXdSdi9YQ3ZRY2xr?=
 =?utf-8?B?UDdueE5IMnBEaktrTG1Yb1lLdEFZdXhtVEU5dTgxVmlaUVo3Tm95ay9RM2dp?=
 =?utf-8?B?WU5iWEZkVFpYWXh6d3k0NkdNdVlMeEptRTNkQWIySW9kSmh1ZEZYWDh2VVlO?=
 =?utf-8?B?Rm1DZkdmOFo1Q3l1QlZ2aXE5RGltczYzY3FDQ2dMRC9WWEJvaFVNK0ZGcXlH?=
 =?utf-8?B?SnlBYmdBR3kxaFZuZitwSTNzNjZTbVBmZDB0ZWk2MHR1V2hqM0QxdG44Qkp0?=
 =?utf-8?B?dWljWm1TUjVXZ1Z5dXRzSG5RbTV4TDBNRUttOXNhcHkyUGxRR04zM3BlZFY0?=
 =?utf-8?B?b1g4Y1hldlRJWVpPbjh0bkFjRWFDMC9BOFovSW5OOEFiWndaL09Ud3BGdEhY?=
 =?utf-8?B?VnVQZTdzelJGZkNKT1YyWTh4UG15dVFXV0Z2aytiU01rOTlVS3A0K3hhNTIr?=
 =?utf-8?B?V1NnUTlCY2VOU3J2TXBpZldWazR6RndVRlNVaTk3RUg5SXE0amZWNmRpRnJD?=
 =?utf-8?B?cldmVmN0MUZtMkRpb0tqVWtEWnVoVG16cHhsL1dwUjJTODdOL05pY0R0ZHNj?=
 =?utf-8?B?U0tLSU9sUWxEbXZpN3RKa0RHNk5HVjZlSFBwME9UUjhRNmFBY25TakZEYUg2?=
 =?utf-8?B?ZFhYUHhLL0xNbTl5aWFpaVZub0JjUmk2bkR6WlF0dUo3MmM4NU01dUN3MkdR?=
 =?utf-8?B?RzdYTDR5bTNuUlYxUlFLOHIySzdjcWowTHlrVUcvSDFvTHBrN053RGMyKzZ4?=
 =?utf-8?B?NXdaWGFIUm4vSk8wakJyazcvUlN2clpFazlQb2s5NGFjY05pb0VkVFlHZkYx?=
 =?utf-8?B?VEViZmRTcXhDbk9pckw2eUh5cDhkS1UrUzVCdWhZTVMrNjhNRi9xaSthU0pz?=
 =?utf-8?B?UVhuc29raHZKUWtLNDZkalRtTEh0S2xBMDduaU1KdEVuSVcrRGlMRTNDRHg5?=
 =?utf-8?B?Q3NXK3ZaVWR4ek92elY2USt2RG51eXU3eENBTFVPOERBZngxdGMwcTRDWHg2?=
 =?utf-8?B?Mm45YkUyNmk0OExDVm1pR1hBeE9hVURWckxZRXFtOVpGV2psRDZsYlNqZnJC?=
 =?utf-8?B?ekxRbDRrODBGUFE0LzIxMmE1Q2lndmdmN2ozSEVSOGRvV3RWamh6bnA2bXE3?=
 =?utf-8?B?eElvS29xaGhtKzdnODNCN0VlTmN0dlAwZzVkUXlMSmttM0p6VmhGYkVVV1V3?=
 =?utf-8?B?T1pxMDZrajRQSUFOOHZZc3hFY3VPVThtVFJpbzJ2NGE4YWdzZzBiRTcvRW9V?=
 =?utf-8?B?MTlWQXRBWERDZjYyaE1lOUhKRmJKYTJJcDBBSytlb3dieGFDTlhuUWt4R1NU?=
 =?utf-8?B?bmtKdTR5UlVLbEVaaTdWOFRiVUNQTTNyUXdTUzRDWHFFa3dJWFhaVFJJb05a?=
 =?utf-8?B?SmdrY01yc1g0UnRmTmRBSkRZYXI3dFlhUmxvYTdUdEFWYmIvK2NTQkY0NTln?=
 =?utf-8?B?bnJzeGxsTUFvbExrTXdabHA4UmFzaWovM3k2SHc2ZDEzaWJiVGlGdHJETlQv?=
 =?utf-8?B?UFFSb2pBOHJsMnhaUEduVWVLZ3ZycGJpd3RhU2x5UlpnWEtRUXYxWWhEdU9h?=
 =?utf-8?B?MW1VTC9uRUQxOFoxVXREbzFMRkd1SEZmQVFSY1Q2c1VodHlwM0ZzdDJSbElB?=
 =?utf-8?B?c1czdEcrdThEZXpLY09iT1JHY3M3OGNLOHBsR01jNkkvQ0N6NUJvT2pqTVVw?=
 =?utf-8?B?SzBuMXhCcm1La2J3TEUyNzQxd0lKVFJHMTJZdzZzMjNaMlBwR2J0eHB2T1JI?=
 =?utf-8?B?S21vVmk5aFdKOWRxWmtna3kvRmpkWXozRXV5TExDMmlDRHM5Yjc4VWg0VFB6?=
 =?utf-8?B?VHdXMkhyM3M5Vjh4bnhCb25IWWFpa0xEaXZxQTdRLzhzZG0xNkYrUjBRZHJ4?=
 =?utf-8?B?dzVoWG5BOGFGcktVU09mcVlXQ2liWFJNaERROGN3WThlZU5WSm41c3UxZUo3?=
 =?utf-8?B?L3lNQy9zZmZha3dWOG05ei9nbUF1R0d6WURmVlJRNHpCNG1Xa0VnTmlZQ0ZK?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52357b31-e592-42d2-cb86-08dbc052ae84
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 18:42:35.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oRJXQ5pJkY82rUqDJ8IvTnYfQfE93YwEhFIQHQ6CcpvSAr5g70Br9VHa4UO2WJTSZTPRT612aT1O+ItV/DfmdFxRGLo2y7bb6oVMf26W4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 9/28/2023 10:33 AM, Tony Luck wrote:
> On Mon, Sep 25, 2023 at 04:25:15PM -0700, Reinette Chatre wrote:
>>
>> On 8/29/2023 4:44 PM, Tony Luck wrote:

>>> Similar breakout of struct rdt_hw_mondomain from struct rdt_hw_domain.
>>
>> rdt_hw_mondomain and rdt_hw_ctrldomain?
> 
> Yes. rdt_hw_domain is split two ways and each gets an appropriate name.
> I added an extra "_" to match shape of other names. So these are now
> "rdt_hw_ctrl_domain" and "rdt_hw_mon_domain"

Thank you for adding the extra "_", it looks good.

...

>>> @@ -641,12 +641,12 @@ void cqm_handle_limbo(struct work_struct *work)
>>>  	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
>>>  	int cpu = smp_processor_id();
>>>  	struct rdt_resource *r;
>>> -	struct rdt_domain *d;
>>> +	struct rdt_mondomain *d;
>>
>> Reverse fir (Please check all code).
> 
> Fixed. (I wrote a simple awk script to find these (as I'm
> obviously bad at noticing them). Included at end of this
> message).

Thank you very much for sharing your script. 


Reinette
