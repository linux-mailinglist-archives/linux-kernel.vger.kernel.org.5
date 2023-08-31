Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7684D78E6C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbjHaGvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbjHaGvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:51:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C52BE;
        Wed, 30 Aug 2023 23:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693464692; x=1725000692;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BuV0/WYKN+hx6/L7/TI61rUqz10RbmRnyT588x+1934=;
  b=dauQ9ZZ6GzA5viwdCcaacXmRRgvKHPAl1TItCOuexW7nFmznTTzlEYzZ
   LtCwOYVcTM66Jj27palaxJnkySVnmVQlus5OlsiEfBNMDI0KJwb9uLPYC
   ihFO+Ulwx06pyzWhokfF8rFo7fyTI6VNQh6ENvQh+2UOnPpEBUCYCP3DD
   rQeKg+/x48mku6dchPaJvOumfi9aLpy+2t3Wq4wI8BbscZnIP4RfCGL+u
   zUM7kQSnPyqnqPJkPjvgfzwsGyIfJnaZYIrZJlkQTnwLv4z8Q5glw2tbu
   yt46d8YvXrx+N706KPWrvm9RoeAb2KGlegTrbGHtKzbN+Hdr2blCdCxMg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360823325"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="360823325"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 23:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="689197163"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="689197163"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2023 23:51:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 23:51:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 23:51:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 23:51:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 23:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avC6OpFcwTQnAC9jSvKUSLCGsVaBsAhtVtEUdwdf40DE3/5peYnFrFL3rXMY9gmSGjtFuNVZrjzHmc9K59T5/uNMo3eVhLH9BNuT9fGuvDq+WYOAVQJT/482TfMrQ5qo+0y3Ct5OjAGJOyXEPpvcFAmH72vl/HKqbIa0EkB2cJ0YR+E3/Yk0b+nupvZoTc2GPk+sytvY6zwPo6pEJPxdqJrUNcLd19JTJLV/8T9xvrEY6m1vFn1uhX7B6q4f32X1j7vOQDSDxhgN3bjrg5ZvEFSHnknnctT0GkZRZ1z+IL3RXgY9oynLvuItceJd3PY0OXCDMANjaEgHeMRdEHswIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQkToH0omcOD0I64rLF+IIiGAx2kAZrKu54lvPMmY7Y=;
 b=N9eoaH6P7FfXug4wt98FqQnlxOH0xeM6rbNAFNiKVgyQvbXKPO3m3psOm2IRoJXwcC6M8t21KWeSJdzRzRZ2TWywS8JIV5H9DA6peCa4hTazHIaP5vyEClqNxDBotVWIUUXhQP8F9P8QZPcwojMamB2T+O/AZ4SDlWv2k0gLwMBGcuos1jJsaeQKO/bRmP/D4ZkOqg+HuWR99+AAaDtlpIA81wF6P4/nakaxDRKU5MwdMgCRgFLLgrRII8hM7UszWdYuyvnnk7x9x0nI/DoUa31C8TV+kcosESV+00LDN3hubQqVVjJIIg+yL1bjmGy3NjgwrgKkl8e/xmkumGU5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MW4PR11MB6885.namprd11.prod.outlook.com (2603:10b6:303:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 06:51:28 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 06:51:27 +0000
Date:   Thu, 31 Aug 2023 08:51:15 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Message-ID: <zulbpqdmui664qflvo3fcw3wnuailsiwkjtfu4xr37kutdoagy@54z7s6hud2vf>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-9-tony.luck@intel.com>
 <frfa3olxop3xjnouvvv7y2s36varmto5qwhmkitvslmiawzwkd@zh2jhob4o5qe>
 <SJ1PR11MB60838CA98A341F59260BDE18FCE6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB60838CA98A341F59260BDE18FCE6A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::11) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MW4PR11MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b413e63-0c46-4675-32df-08dba9eeb29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ulfu+nQsuw5l+tiUeK4gR+SWQm8bVZ1dHq4flKTbieQ6WqgRFOpjOWL5QXFOX/zmiP+deT+3BZUKCNB+/H8ypPB/gWyI7OGh3kiFZOTCY92MjRgNpTocPiurZXDRueoELtbXZADY1lQKpzifJsUlAog/9uNdZecu9ESNb+x95jAYHbhWUpTBBkHSeQSuWsavZu+bZVQtCo4WqxukvRrpOe7Bl9lPpo9q9naBjOetx4ALAg8ZjY8exQK8UC0YmcFTSwDrgpTkGX2C3ewCjkO7WeovDCOCJMMCjROsSqQJIPlncGNAYu5fqKIHhFlm7ki0kRZ1bbGc4zfNaKPbBdzlX6e1EA6BIVwSb9y4NKBP/THqriOlJTrimDtzB9JCV3z+3di5BrznphgWugdTNLT4PbDjl1U9UahKEmTBchX0fIEXSHhtIS0+uV4ECF7Rw/bQuYVMzQc2dX+6ySmtkJzY5vCWKLGpGK3Eu2E8SnMgE/7AYm+l9EEyaaDRlQJn1oTkF2wSi2o/yaneQB9vZ9OHseSUIgXf3+p3UfMnhwUlCA/NO42UwtREayrsaDOM1V7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(376002)(346002)(39860400002)(1800799009)(186009)(451199024)(33716001)(2906002)(86362001)(7416002)(5660300002)(38100700002)(82960400001)(6862004)(4326008)(8676002)(8936002)(83380400001)(41300700001)(6512007)(66556008)(53546011)(316002)(9686003)(6486002)(6506007)(26005)(6636002)(478600001)(66476007)(6666004)(66946007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?o8Y1dBtaj50aGAQFH3BHcQotvrjm+mZo56uvaNr1p5tMKM7/55oUBvA4+Q?=
 =?iso-8859-1?Q?cyqVTrn0XdPBWsEa+slm1uczPA6pqhU7Mw20TQ6GkUD3nx4B+LTN/mLcA6?=
 =?iso-8859-1?Q?XD1bpw0REtW2cjH4SO8RlpinXTFniDqqdI1IW/fXNUEUYa6ufQZrFTTWo2?=
 =?iso-8859-1?Q?MyrX5fCup8+YWJ0iZJnxWdTM+yAkdVADRz372rzied636/oxYFLh/qC/U4?=
 =?iso-8859-1?Q?bmtFRWEeObY9x4W+4zWitsGXWPkSPaFxBnT8jrmVUFiM/QLjjVlGe2kez+?=
 =?iso-8859-1?Q?hbxI8RmRDw6gS9voONv4ehK78IkT8dx7hr+bY/62+zoATZPi/yDZ3MNJKn?=
 =?iso-8859-1?Q?Pdi5zb0MfhFXBTh60Mj24eCdMzmoMp02S63VFiNyl4vRslFu8EyUrJH/82?=
 =?iso-8859-1?Q?50K7GPuCo0vtb3XiJyRG3IndVMOEodK7KwvIYNMbXdN+2wLoGjrq3VlThO?=
 =?iso-8859-1?Q?7KNfKdDxRLoW8EZbvrcJ22khc4yJXwyGVI6b/cYBDwmcIbEWGF3gM2fdvf?=
 =?iso-8859-1?Q?QiZvT6lmke9llGmD1B+0lCVwsSUEKO3jVOIu1+4D/ddVdRiZqRypqJzNa2?=
 =?iso-8859-1?Q?WOR6npMPsw+T7BLozRufZtV8ZYqs1PmxLF5w5cXECAKpZZJ/zFaSJxH1by?=
 =?iso-8859-1?Q?OTGjPjiVpxCzupKLMxe0QKEZpE45NO0F4VQJoU5zuzcLPGgmDU1LUc0Gk7?=
 =?iso-8859-1?Q?BQzZmmuVralrm1MgjusNmvdmCAwDSrikNTWRgv+z/JdiOfhjEDNMEAx6Cr?=
 =?iso-8859-1?Q?yUmVEMuXBGZmOq5wnJavDHZ56IO19FXKJlC+7ocWMm1X4V8ctO3qj3TwrW?=
 =?iso-8859-1?Q?+M/UIVrNdmoRDK/q9BHi9eJqdlnceeOk70U6KaEgmhEQWHarls753IuEIL?=
 =?iso-8859-1?Q?L638TuNgKX/ATYvAsI+vWp2qtwQ5B+fHua3wvmNYmulNao7+mWO71azY3e?=
 =?iso-8859-1?Q?0kXFRRvzmL2cIGhsMUM2HW+OBPv4txNBL1AQpFzTP/Q8Zd8zuNfzpHFrAR?=
 =?iso-8859-1?Q?fAbctsiFVBRzRBltNTSJ2VsRDj4OClxgLBGw+j0/WeAu9boWtzrxcgvbM/?=
 =?iso-8859-1?Q?4Ly1ZlHZNtecE7urbvN4QfXGAJx4XySc/SQNCyeQcEtwSEYHtxKpw6fH92?=
 =?iso-8859-1?Q?WEeJps4tmO9381DCvtCu1SXkhjiCB5Hkb20RkkPpSP874ZVRf+tW8txIuL?=
 =?iso-8859-1?Q?VCP5kMPmNeu40qqDYRHjNk73UAsEGcQvQjFukF3cfkWxCJPTGdtJrYPDjk?=
 =?iso-8859-1?Q?b1lbST176s1/AkQvp45E/EZf+nf08w0/gTc68ToBfnbqYGTvpIlTND31oG?=
 =?iso-8859-1?Q?xfGKQvCO/+lS+Dej4AcN6PiaQFhGRoEM86b3DApgVOm3hS0OZ6Dk6eLNJv?=
 =?iso-8859-1?Q?xj9g2n/7uQXlQzJSGMH8kwG+AloDUMK4uKwGy4t76Fl1EiSLHSw8IHLMis?=
 =?iso-8859-1?Q?rQwGoY2IujkKIfiHxyPqdY4muqfyrZetLSYfgt4ARma+YiZJQ5pAskqQ0p?=
 =?iso-8859-1?Q?dYMXvufBP/8ZqBbB7LnyVbs/FRAoE4SsOF9iEHD7FuSI0s91xoytfN/taK?=
 =?iso-8859-1?Q?oZYu+DWDZIHsjmJ+9L4yU8rm5fykaY/o1Rx/gS414+OpFoYjt4RURlnzR+?=
 =?iso-8859-1?Q?LLcXtMT8p/5fslqXwT8r5ngCe8AVhDAdA4Ht9pd98bILP9Pj88a1osBcfX?=
 =?iso-8859-1?Q?MVhkYB7xmsiNQglVT8I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b413e63-0c46-4675-32df-08dba9eeb29f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 06:51:27.1081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdjRoAE32p1RDMygOVQLktpbZH6MZ49zNDay2DXbanQkv6qpbj37g8+0WN2vnaQI/nm4VWhF6BaD9MgOcpBOlhgUw/YLMDL+Je8gdNDgjBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6885
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-30 at 15:43:05 +0000, Luck, Tony wrote:
>> >+static int count_sys_bitmap_bits(char *name)
>> >+{
>> >+    FILE *fp = fopen(name, "r");
>> >+    int count = 0, c;
>> >+
>> >+    if (!fp)
>> >+            return 0;
>> >+
>> >+    while ((c = fgetc(fp)) != EOF) {
>> >+            if (!isxdigit(c))
>> >+                    continue;
>> >+            switch (c) {
>> >+            case 'f':
>> >+                    count++;
>> >+            case '7': case 'b': case 'd': case 'e':
>> >+                    count++;
>> >+            case '3': case '5': case '6': case '9': case 'a': case 'c':
>> >+                    count++;
>> >+            case '1': case '2': case '4': case '8':
>> >+                    count++;
>> >+            }
>> >+    }
>> >+    fclose(fp);
>> >+
>> >+    return count;
>> >+}
>> >+
>>
>> The resctrl selftest has a function for counting bits, could it be used
>> here instead of the switch statement like this for example?
>>
>> count = count_bits(c);
>>
>> Or is there some reason this wouldn't be a good fit here?
>
>Thanks for looking at my patch.
>
>That count_bits() function is doing so with input from an "unsigned long"
>argument.  My function is parsing the string result from a sysfs file which
>might look like this:
>
>$ cat shared_cpu_map
>0000,00000fff,ffffff00,0000000f,ffffffff
>
>To use count_bits() I'd have to use something like strtol() on each of the
>comma separated fields first to convert from ascii strings to binary
>values to feed into count_bits().

I missed they are being read as characters and not bytes, sorry.

Out of curiosity, what about using fscanf instead of fgetc? With the
format being %x and reading one byte at the time. Then instead of
isxdigit just checking if the read number was bigger than 0xF.

I also remembered there is a gcc (and I think clang has it as well)
builtin function that returns the number of set bits in a number.

So it would look like this:

	while ((fscanf(fp, "%x", c)) != EOF ) {
	    if (c > 0xF)
		    continue;
	    count = __builtin_popcount(c);
	}

Are there some problems with an approach like that?

-- 
Kind regards
Maciej Wieczór-Retman
