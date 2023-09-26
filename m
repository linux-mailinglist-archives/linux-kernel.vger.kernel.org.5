Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB067AF6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjIZXr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjIZXp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:45:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2D68A6C;
        Tue, 26 Sep 2023 16:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695769594; x=1727305594;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=01UrMEtRzsUVvjY2Pt0092FlLpql0LcZvAs+1DOoK50=;
  b=nF/j5w2xVRDJv0uXwt9htfQHR5VAfupq10iaCfZoZXxrfeTStQoGAnL3
   CykrNRe4MEoQw3ElewWY5mTjweZooR9SK0FWqTNCelUP27VQm1Umo9Ce0
   E7bDCu0PqxEv0/LvxioYcG28bdKpX4R8ik0i4kPMoBtFSrt9qrKgIeW0k
   Z7N/mpI06sfOPILEqFlG5PRYPt9CUVYAPSEMd62Nf7yUPSd7UcYV0W7TC
   i7RuE8ZkJ9bWatggRsgwCUwZAp/CVjn2U31LpTsV7t4awfKVsdTJTreZH
   1RN18gpyuupQI+YN5Bx7hjJP9YmhoTxwq0rMVK8Jvo+ozZc9fVSvAmGDB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385539702"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385539702"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 16:06:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784123494"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="784123494"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 16:06:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 16:06:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 16:06:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 16:06:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAG1RKd26lGDD42oL8gggpXKXAvJ4Epj9imhKuaV0n7runQ0fqt0FdrY5XtKm93K6UltZ1YTYpNWmGHUtRzAp3bF5xB833SehWeBVt+AA+hDgTgjAoDp6Nj5XRx/n0H4hWq7hGHAxGL5hwJy77V7Ret/mk/Oln2bw46N5jXmVB5mKde6n3YU2UHoyTXOTHypIG9SAj3PObG5KLvheztGJlGIW9xzIxHG9uFEOJpYyWjUcbYG7T2Q/CgLFbHW8Nxv3CdmfJ2O3fE2tr3ByTidlKmX8qlPNVUnKFftQopbIEUxeZ98aN0fOqJ/beMMKRgfK0VsaZOYalhF2pkNqrxAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXJ3vXH+1EYD0DO7rGrgo+b5HGQtpk/ec35t3qjN48w=;
 b=B1KlyE9HnexdN0QRrgVZ5a85sGIKbqJK8H1dxwlzm98TUo6LPeOA6sdXXNlL25YicRkqkmAbrV5SpCHUm1hUgjlsyK/kuuiitNgrKOIytSmEkhvjdx3lIR3aNa+doShGE257bMYXNsCGAegsoJywOf0+H0W4vIYHxQLFYrYmMth/7K7mGp1AZ9szIkeNA0y6YBzmnt98In5+6HSxouLMoKZLHNzAGb8Hb8TCPfxDY6GnCREObSHr1Yij8XVlQ//avyrhDFU45LpdmZxED0j5R0iy35Py9gh+qLc6aXgtWFRAhfHq37DSdiaAqeEa56JoRfN27LTj2GW/bl9E2X59Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7639.namprd11.prod.outlook.com (2603:10b6:806:32a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 26 Sep
 2023 23:06:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 23:06:22 +0000
Message-ID: <595d6062-fece-83c0-5d5d-2f9405f6b842@intel.com>
Date:   Tue, 26 Sep 2023 16:06:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/8] x86/resctrl: Split the rdt_domain structure
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-4-tony.luck@intel.com>
 <5f1256d3-737e-a447-abbe-f541767b2c8f@intel.com>
 <ZRMnCFWzcxa6Qa4E@agluck-desk3>
 <5b2fd31e-3cef-3c35-7d17-411cea27502a@intel.com>
 <SJ1PR11MB6083D9AA22033235210BD847FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083D9AA22033235210BD847FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:303:2b::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7765f3-f0fa-416e-a0ce-08dbbee53322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaVRqBSX5hTZg/yMizr6PF/eoZU/3TziEi4Z0E7jLxdtl6bMila3SV67+QwCTWgeE4zr4cipHNhk8dv8qqEFh0OO8pJxnMERYkOLVMFBhtDTfyPmiS5aV0l+HHCCV+iYJrqIr2vP63No+6lR6XdlEWCpvWeMN/XhH2lJYoiPinpK2Xo/qY728k6Sd9aj0n3cbXDTkWUQW+xcFrc9u0OlEa792yxqnJOsPywHXSJiXtSd1rC/6sAmWMFVsVSrPEcjfBbAwPxwoXyUvOWckQJ2TKBnQYh3zuE+gi0vFMMju/SwLxZ/vHaSVis8cZzfGyREIYvyQbxwXokCGwYrwPvaQh5EnmFnXDbtHGUy+X92BHjgtUFkNdeUFXo4UZN5Y3+dReI62DfsEG18fE8Kgbuu7XcPhAOhhcieeRl7WSK/R/VXX+1B8tMSzKjyoRrp7cAXA1vilby/0Pa7VFr/ISHBXbN+guWNva6ybNfRzIaAyyhR1iMLaE28zzTJM2nHfK2nt/lwZqDAayFt7yHZ26dE+/HEfD7eSd37lDTnEftCD07A9YwEO4eln0Yr7sT0twHVhP8VhxR2MdUnWrNx2qoPw4XbOSxt4cp4SJvEMeFKkOYYEXwMIlMCE8QmzGQ713KGtoGoZUWVpok2IvISG3VZPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(451199024)(186009)(6486002)(26005)(31686004)(8936002)(41300700001)(44832011)(5660300002)(8676002)(6862004)(4326008)(53546011)(6512007)(6506007)(6666004)(2616005)(478600001)(6636002)(316002)(37006003)(54906003)(66556008)(66946007)(66476007)(2906002)(86362001)(7416002)(82960400001)(38100700002)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SldycEVFdUVSaG5laFo4MDN1TGJPTWlIaDBjb3R4VHJVQlRYSUVMdGUrRzl1?=
 =?utf-8?B?dXpDS2FqVHZ3NmdQU0txb3dmUTdrR2wwWlB2MmkwazhtaFkxdE5XWkZKMTlr?=
 =?utf-8?B?RTNDR1cwaW12bXZYUXgyZHV1NVlZV0RxZzN5VCtRZFh0Z1ZaSm9CRFJSd0U5?=
 =?utf-8?B?d2dKby90UTdJSXU3SjI5VjcyVzgzNjZ0QlJ3MVBCZ1pITE5nNjdDMkcrUGNK?=
 =?utf-8?B?WkZBMi9YWTFZbndiVWp3ZC9mWUVRdElWSERaZ1pnTEI2M0ROcnVzRmpldGw2?=
 =?utf-8?B?TEg4VEZEckoycEdkb28vNWZ1UmNFd0VJM1ZSb1I2S0FtTTB3TmZRWjVkM3JU?=
 =?utf-8?B?K2xaSWVGS3lGbjBRK1VJdDRmWFhEeGRQQnpvT2hLMEhZZm94bW80K0dhTjh1?=
 =?utf-8?B?Q1pzd1VrTHR3d1BMYUJxeVZ2MmZBYzdWNzNCNytsaWtnN0UzdFdOZWNGQ0FU?=
 =?utf-8?B?RjkyVEdCMEF1VEdiT3gvalBMMGZTakY1WmxpT28rMG1ySStyMnFJanQ4Qy9W?=
 =?utf-8?B?STUwOVVqY3lYbWFJdWIySHRhV0NWMHdyV3N5ZVFDdlJ1dStOUHJBcVc5ZGc2?=
 =?utf-8?B?MFd6eVdHcnpObzFYYko3WnlOdFVZWkxwaEk0VzdWdUQ2VXVudXdSWG5kKzZG?=
 =?utf-8?B?akQ4T1QyamF1aU5Sd1A2Z0JjcE5yWnhhUDI5NVpZbjM0dkIwZy8rdlJTdUYv?=
 =?utf-8?B?SnlEQ3BLeVJOcDg2Zy9lR0dwYWp2M1ZDeUY4YlZZTXE1Q09DQTQzRVdhWGI2?=
 =?utf-8?B?L04vbFVxUXIrV3FXN3FId09neGZvNXpVemN2T1o4TmxhcHorbWFOZkFYd1hD?=
 =?utf-8?B?akUxeUpQblUxcTJJOEcyOTZ6eHY2TDF1NThSZklTdDZJZitPVHordzZ5dWZs?=
 =?utf-8?B?VElYdVRpblN1akNkdkxpcEVsUi9OL0VVK2pPa3ZkYnI3T1lmMmRFZ1pvS3Uw?=
 =?utf-8?B?ekdoc1JGWG14ZkVXLzNKR2tIM3M1T0QxbksybFBQVzA2Rnk0Wk5wTERNbEtQ?=
 =?utf-8?B?TkpOQncvYkVPNjNuOVk0ckRwcGxSR28ybEhhN0xodEpsZjVSVU5DbHNCUGF2?=
 =?utf-8?B?dUJuMldLS0hzOWdaNzdlYXhDRmpyWWxqVjVzMnFlcWtjVysvVHFySXQxT0l0?=
 =?utf-8?B?NkdrRnV6QUZVS0R2bXBTV3R5cDNxNkE3anJjT016am1VRXpSWEMvQWNMUGZE?=
 =?utf-8?B?bnl5U0FGRmNPcHJpWURCbjVyMWpsQ3NHM1BCSzNGaEFmMXVQajlGQ0lQbzZT?=
 =?utf-8?B?QjdxeEl4TWNHZ1ljTzNyNFlWY0NqcmRGMXJFZEFvUkRQRTQ3dFZRY1BCeEpa?=
 =?utf-8?B?VlFwMmVKYlFuRiszejhPVGFOK0dxc2NVb1Vmb0pCN21wa3JTbzAvZGdGNXZj?=
 =?utf-8?B?U01vZURBUEZGcW1HR0k2dXh6bVNhZmdhWkpEcThMZGpQYXVkYmp5RWJBckx4?=
 =?utf-8?B?b3BwYno0aUJBY2lCUU84ajc2ZklmbTljQVdzdHlWZDVCMzYwZDZQN2lkL2NW?=
 =?utf-8?B?S29wNXFQdVlxL3MvZExDVDlNeEYwVUtyRmhmc2gzS21WTEJjUDF0TFZYZjZq?=
 =?utf-8?B?S1NueVNWS2xEaHZaMTU5SEc3SEpwZEJ5d3FMTzUzcjhWUEpFSU45ZFhzZGZ0?=
 =?utf-8?B?LzY1UXlsQjVtOUpCbnF4NXJWOFYzemIrSFY4NnZiMktadlpDbWt3SW1OdlR5?=
 =?utf-8?B?UXVHNTdXcnZkSHc5Ym5KbUw5MUxXTEVhT2lRUjhHVlZ6TzhtSDRsMGRIRUNF?=
 =?utf-8?B?MEVNdUw0MERpVW1rQkp2T2tNdFhDMFkyV2JieDJhSWVxSU5qZ3hoWjlVSFF5?=
 =?utf-8?B?RFhUUnJuNFFqRFVMWG50dUJNakdocnU1Q1FqNmlVZDZFakFlYjdVT0NkQzdy?=
 =?utf-8?B?a3Vsenp6SlkxQW9OWEluZXlSMlNQcVo3Y1dPTzVXVlVtSEp5RTRxZlRWSnR3?=
 =?utf-8?B?Kzg0R1pkWUVoVEFpdFljbWQ0ZzRMU2Fzd1NvMVA4cmdXRmFxS0pEbmtTQjRV?=
 =?utf-8?B?R1JPenRhZTdmRVVmOFRMTEp6WVBjRitpbXVPVEt5U3k0VkJoZSt4QmxGSmxm?=
 =?utf-8?B?V1F4TXd3NXZ1Uk40a3FjL2x5K1Eva3NIMHl3MC9Rd0NSZUhscXdtc04wbi9l?=
 =?utf-8?B?THBsYVZnN0xURmdNaGYvTytmcmlUYnhJVC9oZU1PMzFmeVdMNmlHcktFVVhj?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7765f3-f0fa-416e-a0ce-08dbbee53322
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 23:06:22.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRaQxWa9b3bFFJ2DVBV/ZUjsqPaVuT/op7Cwkf5XhmCO8nnkQp+4M5XFWuQnhKTM2/J8Q3TZF7ke6pCDri2MbgilJJj++0gV9RRvp2Rnf7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7639
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 9/26/2023 3:14 PM, Luck, Tony wrote:
>>> But this seems like it is a lot of churn to avoid having separate
>>> functions to search control and monitor lists. Each a clone of
>>> the existing ~24 line rdt_find_domain() with just the type changed
>>> for the return value and the list travsersal.
>>
>> Yes. Sorry, I did not realize this implication during the earlier
>> discussions.
>>
>>>
>>> What do you think?
>>>
>>
>> It sounds to me as though you are advocating for open coding
>> rdt_find_ctrl_domain() and rdt_find_mon_domain()? That sounds good
>> to me.
> 
> Reinette,
> 
> While there is some churn, it maybe isn't all that bad.  I also ran the open
> coding case and having a pair of 24-line functions one after the other with
> just two trivial lines changed between them is unlikely to get past the x86
> maintainers without running this same conversation again.
> 

I expect you are right and your proposal makes the code cleaner.
Could the list_entry() call within rdt_find_domain() instead
extract a pointer to a struct rdt_domain_hdr? To me that would make
it most generic and avoid using wrong type for a pointer. I do think that
may have been what you intended by moving id in there though ...

Reinette
