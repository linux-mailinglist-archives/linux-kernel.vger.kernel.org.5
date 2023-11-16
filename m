Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CDF7EE7B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbjKPTsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKPTsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:48:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29C18D;
        Thu, 16 Nov 2023 11:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700164128; x=1731700128;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x75/xJ8oN9n5+VS3jomMkon/UsNjwnn5Jy9UaOHesg4=;
  b=mp6BYifqyR+6xxsbx4Eqbc2/4oLn2J1dAJNvsuMQImhf76N63isHFMuT
   EjMDoucFoz++kCtyYqpJc/k67p10YRrKEShalr722GlxGdGUxlu82ChPk
   od9sXUmFq3+2234tlGwU72gZUigIjJaddtRTCAeKxjUNQT64ujF+a8iNT
   YRMJMLT8HzKgUCdE56OmNZBgB1RRU3MgH5JbvBRgfQc/8muX+e+mMfCF9
   63iQD1Blm8EsCko4v+n7NTLBg0rcdeB70l+pTf4OUI2RB9jpNlCyPalt1
   okOg5Yiq/Yh8ti2szwwX1jin9gxxhRb97pU99xeVrRZie7R5TcWbfJPt3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4242564"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="4242564"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 11:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="769006716"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="769006716"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 11:48:47 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 11:48:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 11:48:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 11:48:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRYrGbpntaaR5XYoIBCknKGDY/Lv0p8CzFAYHNFP9r51ovhJxa1ks3hncfkzWY+P3pbSHjIINU3hDtzoun8qTmH2dCsBoBfSyCS7SlZj6QvMsXpaMaJtooM/sNYtQsxmVo0dXqCqvX7qZSnTw9CUzunXWj0k9pSFcIRKrrzRiyrHByygQNtrXpMYH3ZWRR+g62RFTGQzFE4QSV/BOf2hxYjsjbl/sfpy89x/u1XBL3pcwed+h4J5zwUhwxQ8AXWmm8D8ksxnHYtwohdYWu30O8ymZOLBAqIyHLT1mS43R8qMlhizYyvVY1h4PMK2Lkaqjv0BVOXBTRURiyuMZyIWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXItT9w5ACQZcEmWWF+ByaJ3radsqR/p7UTC6vFlzWw=;
 b=AXg0YUGdIrnG4swvMrEobDqy2swLl5NCDsQ/97GKnBxKrtKkADR67FWlN2xme+R0PASrrMGvCKd56zy0Ji76ZE6byjSZQ5AOu0FFt5hELRuZOdY7owlCk35PKMdnzSQ1ErWxPl+CkUS97wFNR6/F7e1OaMTpv7HCK8K5tUl6aJPi3OP9WpB7zSXyQyP3o4yegR3lmqCctLp41LuCKYTbO5fYAuVlSNWVDP1WlRgpYl1zcVFnORp016DXFf7hv9PH0EQArktz0NkQgN2W8LCmapvi+aYcsygbMLJ8qsE60gis1ARx44HMhenNKk2D+Oi3qYTgwuXRypK0dw2DANm1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB5124.namprd11.prod.outlook.com (2603:10b6:303:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 19:48:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 19:48:43 +0000
Message-ID: <b2958ef2-15aa-4e07-b09f-e7f67117da2a@intel.com>
Date:   Thu, 16 Nov 2023 11:48:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
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
References: <20231025235046.12940-1-tony.luck@intel.com>
 <20231026200214.16017-1-tony.luck@intel.com>
 <0cee68e9-e188-46e9-83a8-02259a9c081f@intel.com>
 <ZUqo+MsEQi2Xc/pO@agluck-desk3>
 <1a198614-d79e-44c0-b4d4-0e1e0d0c04de@intel.com>
 <SJ1PR11MB6083F3355446B7879177A1FBFCAFA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <b6a6409e-5f13-4f7e-835a-c9e3653a7ad5@intel.com>
 <ZVU+L92LRBbJXgXn@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZVU+L92LRBbJXgXn@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:303:b7::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: e6232f14-ee71-4aa4-bc5a-08dbe6dd09fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpYZ8GnH2D9heHIER0vdJFVj47Ueyu6OI2ayeq5Dkx6mNXcvQZSSiYbC+lE3zu7Nac4bPXVkhjakkpJ/Tal3PPtz4IH7zTLjeT4g9qwUZCly4w7/IwPUrzMECFy4lOoug/Q4o0IyMlZj6DG2N6Yrr3HEpbFjvEpGezV7ULrTfYVyeNROMDtjKctY50+gxk8ijtMekj/iK6oEWlHDyESqrEhSADtMfmnV9N2w7nXuSn4wlU8ohqQroVMF742CKNjZjHHSUPnmAqsKSHTh0XqgK5DjNd+nZHMyRettRhaCFjc+KX4w2NSstosABFD/JIYMs9JVU/jOqs1cxFw8/H652A1MN+NkI7y8QzlAYhxYBF/gidDwZzW/oU5NtfHyWKT++nCVjvNY+E9ck42D6FTyGph/Y3j3n1C8/r8v73/9aQ4OvvZA6tZXmOdyPO2KR3AxRe7Z9BNlS2b4CH5ykVWJ8Bx97Y7/dpcd7GdXsDgVv5v8x8J+NDHhTjMajrw9LlwdfyyTJok5177e6ZEWoRTyWWw6/3p7sFFY9fFgtqdCy5BR+/EoB3F9NmaXIEPISdf/LFc/H3eMtldJ/OKxhiPgUrqvY5CCnyUqqPhA3BV0pKWBTUpYiFvv9e7ps314aLVFUIkfme1/gi1vjUpy5OIFRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(53546011)(6506007)(83380400001)(38100700002)(31686004)(26005)(82960400001)(6512007)(86362001)(41300700001)(7416002)(2906002)(5660300002)(66946007)(31696002)(8936002)(44832011)(6862004)(36756003)(8676002)(54906003)(37006003)(66556008)(6636002)(66476007)(4326008)(316002)(2616005)(6486002)(478600001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFZ4cDlhQm50aUROc0JaVzdJdDlONTF0T2ZMUFpaY3BybXA4dDA0TFoyWjlu?=
 =?utf-8?B?S2c2d0EwTC9nby9rUG10bUpoZ2h0NlpWOUc1ZEFCY3o0WnkzNWZRTGF3dGtv?=
 =?utf-8?B?UnZ1RGpBcHRmM09rSmw5S1JKY3FXYTNHdy96ZG84a1o1RVg1VkQ1VUZ6TVZ2?=
 =?utf-8?B?ZmxzQW85a1ExUHlvZzhQT3NTUU4zUXQ1K3FjWXFoR05SWk02WEZsK0tsV3BJ?=
 =?utf-8?B?bmYzSkloTjlweEY1ZWdNK25QSmp0SUFlOHdXYzNkS1hKQ1A4aHVhNVZHT2tn?=
 =?utf-8?B?bFZMOEx0azNuMm5pdXhLeGtreFJEd3JKTC9MdkNBVWhac2dyYWxnVnpsbVp3?=
 =?utf-8?B?VW5QbTJLQ0RNdG9MQXdyK0FZeXI0ZURLTGJnWjJ5T1hndWNGdnlTaXVMVFpJ?=
 =?utf-8?B?dVRzR3NlSGdtTTQ1VFd6YXZNeFNkYkxHNWZSOHFaeERWdnVNREV2bmd3UWpr?=
 =?utf-8?B?ZndYN1JwdGtJdFpaRzFGM2o0ZGR6cVBPbExZaW9vNk5MSE0zRGZ4cHViUFdY?=
 =?utf-8?B?STBidWtpVDMzeklVcnFxMnhhQnVpNXZrVnY5OUV2UkxDenRDdmdQZ3lCRm1I?=
 =?utf-8?B?b1JDYXpuRkNCRFA2ZDcvR2lBYkhJV1Bib1VzKy80NzdoZkEzZENFV0gwWHBY?=
 =?utf-8?B?TE1hRUh5UGxYRkNTZ2x3Q0lkN2pmQ0ZiY2lTdFFCTXBjcllVSjFaMWpEZTJ5?=
 =?utf-8?B?d3RRSUJoZ3hQODJIWXdGMmllaEg3N0lpbGw0WTVIRkFlU29iWVBRVUhpSW1R?=
 =?utf-8?B?NFZ4dVFQeXVYVTdTUnFiL29qSFBKaEhaaE1WQ3NrN1M0L25FNkk1eFRZRDFP?=
 =?utf-8?B?SGlqcGdoRENVL0x1Q3NBc1JJYTRpdVBjOTltZHVmeWZaSTl1OVRLdngxamVO?=
 =?utf-8?B?THdMdno3a0RBTUI2OXVQRXFRcWVKWThhOXdCM05UbjJQcXg4cnpBaHl1Y2g2?=
 =?utf-8?B?RzV0ZkxPY0hMZllIWEhFWjlvQ0pjaEtTa2UzSjZyckJadEV2N1VqYy9XeWhU?=
 =?utf-8?B?ek85cnphMGpCcWZLczJnaWV3SmVsam5BS2pNUUthd3Q4YVhBS1htbHV3Y09Y?=
 =?utf-8?B?ZFJmTSt2anUrK3FxdVdWbEQwYlE3T21kVk9TMFphcldIaUV3UnRldWhXdFR3?=
 =?utf-8?B?TkE0cHNwSjdPZVFKVE96TkdWYzhOS2JFemdoNUlWU2JWV0t2aTY4cW0wekJ6?=
 =?utf-8?B?ZElxZFdFVFd5dCtHNDIzMHVSNHRXSXN3K3FjMGxrR1VwVkpmeFhQVlgrR2c0?=
 =?utf-8?B?aXB1VktWTVYwdkp3NWJKemtuaTFxYmdoZXRlU0ZWVW5LL3F2VVJrZndnMTJu?=
 =?utf-8?B?emRjclFmSWV3RUsrUHFrSUhTM0ZRc0phTVJjKzNlZXRBNHBqVXYxMk1SM1B4?=
 =?utf-8?B?T3RDWWJUM0NoMi8yZHNma0c0TlJmVFF6TTYxeEw2cC9OajJnOU5xM25peFJk?=
 =?utf-8?B?ZFgrdXR0dmtwV3hoaWc2Z3BxVERJVkU4WEZBaTJsZHNkQkE2R0p0emRKSDEy?=
 =?utf-8?B?NUNpeEd6cld0RlQyazl2bEE1ZzdnMktkUFE2TEpXdVBBdW5nYlcxQllpNFpO?=
 =?utf-8?B?RkdEWXFBTlNEWUs4ejNsTUtCcHNlcnQvb2FFdzJrSlNQS2E1YWtnWURYVHhn?=
 =?utf-8?B?MEY2YThmL09udFVNNjc2U0JRMTF2ekxONUVYZ00zL3V5UVMyZlJHTkY5ZmZX?=
 =?utf-8?B?TGR3M0t1Z2ZwQlVtUG1hcjluc2hNa1JEakl0LzgwaVlML1hjTWV6M0dYS1gw?=
 =?utf-8?B?T3ZraE9RdG9DMXN4UHl2V3NTVkgrRG1mR05GNFhGYlpOeDdrVmlsOHRSWWFD?=
 =?utf-8?B?Q2VzamkxaUduRFNyQ3dSS3NYbWN6MzgrUHRTdFlYd0ViczZuMmRoQ1ZyMmhU?=
 =?utf-8?B?RFNMaS9kY2RxR2xqdUg1clFCOFI0R1lJd0J3MTZYRVJkR3NVK1F6dldDUHFH?=
 =?utf-8?B?aW53NmY2VER3U1M4UVVDVUlMOEQ3T3lGcCtWS3hIS2VrNyswQkM5TTdSNEpD?=
 =?utf-8?B?emRFa0labGxqZndrTW92M1dvdEplSVpoYnVQVUN4bGtUaFFjSGNjc3NwMXZ6?=
 =?utf-8?B?dXRNNURlOUtUQXk5RWt3dnhGM0hPTnlxaGxZS2I1UzJjeDVxTFh2cXpJYWNr?=
 =?utf-8?B?cE9DZDN5MWdoQUg2bnY5UTg5ckVVQi93b0FuU01SZDU5ck5GRmcwL3FITmw3?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6232f14-ee71-4aa4-bc5a-08dbe6dd09fa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 19:48:43.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95NGbVr/UuOgoV1JhO2DYOvCA57qMLsQo4CRzY+SONUxplE03a9eXwgv4bpQR/dGqZxdiyzXsYMPrKQE1bCD5fpkQAtuWJt7UkM/+jxQV0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/15/2023 1:54 PM, Tony Luck wrote:
> On Wed, Nov 15, 2023 at 08:09:13AM -0800, Reinette Chatre wrote:
>> Hi Tony,
>>
>> On 11/9/2023 1:27 PM, Luck, Tony wrote:
>>>>> Maybe additional an mount option "mba_MBps_total" so the user can pick
>>>>> total instead of local?
>>>>
>>>> Is this something for which a remount is required? Can it not perhaps be
>>>> changed at runtime?
>>>
>>> In theory, yes. But I've been playing with a patch that adds a writable info/
>>> file to allow runtime switch:
>>>
>>> # ls -l /sys/fs/resctrl/info/MB/mba_MBps_control
>>> -rw-r--r--. 1 root root 0 Nov  9 10:57 /sys/fs/resctrl/info/MB/mba_MBps_control
>>> ]# cat /sys/fs/resctrl/info/MB/mba_MBps_control
>>> total
>>>
>>> and found that it's a bit tricky to switch out the MBM event from the
>>> state machine driving the feedback loop. I think the problem is in the
>>> code that tries to stop the control loop from switching between two
>>> throttling levels every second:
>>>
>>>         if (cur_msr_val > r_mba->membw.min_bw && user_bw < cur_bw) {
>>>                 new_msr_val = cur_msr_val - r_mba->membw.bw_gran;
>>>         } else if (cur_msr_val < MAX_MBA_BW &&
>>>                    (user_bw > (cur_bw + delta_bw))) {
>>>                 new_msr_val = cur_msr_val + r_mba->membw.bw_gran;
>>>         } else {
>>>                 return;
>>>         }
>>>
>>> The code drops down one percentage step if current bandwidth is above
>>> the desired target. But stepping back up checks to see if "cur_bw + delta_bw"
>>> is below the target.
>>>
>>> Where does "delta_bw" come from? Code uses the Boolean flag "pmbm_data->delta_comp"
>>> to request the once-per-second polling compute the change in bandwidth on the
>>> next poll after adjusting throttling MSRs.
>>>
>>> All of these values are in the "struct mbm_state" which is a per-event-id structure.
>>>
>>> Picking an event at boot time works fine. Likely also fine at mount time. But
>>> switching at run-time seems to frequently end up with a very large value in
>>> "delta_bw" (as it compares current & previous for this event ... and it looks
>>> like things changed from zero).  Net effect is that throttling is increased when
>>> processes go over their target for the resctrl group, but throttling is never decreased.
>>
>> This is not clear to me. Would the state not also start from zero at boot and mount
>> time? From what I understand the state is also reset to zero on monitor group creation.
> 
> Yes. All of boot, mount, mkdir start a group in a well defined state
> with no throttling applied (schemata shows bandwitdh limit as 2^32
> MBytes/sec). If the user sets some realistic limit, and the group
> MBM measurement exceeds that limit, then the MBA MSR for the group
> is dropped from 100% to 90% and the delta_comp flag set to record
> the delta_bw on the next 1-second poll.
> 
> The value of delta_bw is only used when looking to reduce throttling.
> To be in that state this group must have been in a state where
> throttling was increased ... which would result in delta_bw being
> set up.
> 
> Now look at what happens when switching from local to total for the
> first time. delta_bw is zero in the structures recording total bandwidth
> information. But more importanly so is prev_bw. If the code above
> changes throttling value and requests an updated calulation of delta_bw,
> that will be done using a value of prev_bw==0. I.e. delta_bw will be
> set to the current bandwidth. That high value will likely block attempts
> to reduce throttling.

Thank you for the detailed explanation. I think there are ways in which
to make this transition smoother, for example to not compute delta_bw
if there is no history (no "prev_bw_bytes"). But that would just fix
the existing algorithm without addressing the other issues you raised
with this algorithm.

> 
> Maybe when switching MBM source events the prev_bw value should be
> copied from old source structures to new source structures as a rough
> guide to avoid crazy actions. But that could also be wrong when
> switching from total to local for a group that has poor NUMA
> localization and total bandwidth is far higher than local.
> 
>>> The whole heuristic seems a bit fragile. It works well for test processes that have
>>> constant memory bandwidth. But I could see it failing in scenarios like this:
>>>
>>> 1) Process is over MB limit
>>> 2) Linux increases throttling, and sets flag to compute delta_bw on next poll
>>> 3) Process blocks on some event and uses no bandwidth in next one second
>>> 4) Next poll. Linux computes delta_bw as abs(cur_bw - m->prev_bw). cur_bw is zero,
>>>     so delta_bw is set to full value of bandwidth that process used when over budget
>>> 5) Process resumes running
>>> 6) Linux sees process using less than target, but cur_bw + delta_bw is above target,
>>>    so Linux doesn't adjust throttling
>>>
>>> I think the goal was to avoid relaxing throttling and letting a resctrl group go back over
>>> target bandwidth. But that doesn't work either for groups with highly variable bandwidth
>>> requirements.
>>>
>>> 1) Group is over budget
>>> 2) Linux increases throttling, and sets flag to compute delta_bw on next poll
>>> 3) Group forks additional processes. New bandwidth from those offsets the reduction due to throttling
>>> 4) Next poll. Linux sees bandwidth is unchanged. Sets delta_bw = 0.
>>> 5) Next poll. Groups aggregate bandwidth is fractionally below target. Because delta_bw=0, Linux
>>>    reduces throttling.
>>> 6) Group goes over target.
>>>
>>
>> I'll defer to you for the history about this algorithm. I am not familiar with how
>> broadly this feature is used but I have not heard about issues with it. It does
>> seem as though there is some opportunity for investigation here.
> 
> I sure I could construct an artificial test case to force this scenario.
> But maybe:
> 1) It never happens in real life
> 2) It happens, but nobody noticed
> 3) People figured out the workaround (set schemata to a really big
>    MBytes/sec value for a second, and then back to desired value).
> 4) Few people use this option
> 
> I dug again into the lore.kernel.org archives. Thomas complained
> that is wasn't "calibration" (as Vikas had descibed in in V1) but
> seems to have otherwise been OK with it as a heuristic.
> 
> https://lore.kernel.org/all/alpine.DEB.2.21.1804041037090.2056@nanos.tec.linutronix.de/
> 
> 
> I coded up and tested the below patch as a possible replacement heuristic.
> But I also wonder whether just letting the feedback loop flip throttling
> up and down between throttling values above/below the target bandwidth
> would really be so bad. It's just one MSR write that can be done from
> the current CPU and would result in average bandwidth closer to the
> user requested target.

The proposed heuristic seem to assume that the bandwidth used has
a linear relationship to the throttling percentage. It seems to set
aside the reasons that motivated this "delta_bw" in the first place:

> -	 * This is because (1)the increase in bandwidth is not perfectly
> -	 * linear and only "approximately" linear even when the hardware
> -	 * says it is linear.(2)Also since MBA is a core specific
> -	 * mechanism, the delta values vary based on number of cores used
> -	 * by the rdtgrp.

From the above I understand that reducing throttling by 10% does not
imply that bandwidth consumed will increase by 10%. A new heuristic like
this may thus decide not to relax throttling expecting that doing so would
cause bandwidth to go over limit while the non-linear increase may result
in bandwidth consumed not going over limit when throttling is relaxed.

I am also curious if only using target bandwidth would be bad.

I looked through the spec and was not able to find any information
guiding to the cost of adjusting the allocation once per second
(per resource group per domain). The closest I could find was
the discussion of a need of a "fine-grained software controller" where
it is not clear if "once per second" can be considered "fine grained".

Reinette
