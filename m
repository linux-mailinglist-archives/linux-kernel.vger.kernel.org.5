Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64C67AFFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjI0JUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjI0JUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:20:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333C392
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695806436; x=1727342436;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zKbdVrW348vXDKoTG02jiiFv2SQu2YSj/zZGzDkjz24=;
  b=dWy4qOFVZujD+kG1njIhpnqSE52BnBPD7kz59s0mh4wtWrCEzIwcv2LC
   LT0Y/HqpGkLVFWGQnTb/GNMBoAwVBC/B6fQP+wxkvYcwnbIbUx+wflcug
   I8UcAcqroTcddgVFjM0ldKP+lePFtxj2795FBnAogJXC4+00dAGsI62jM
   DOMXKiSVY+yAan227+geLCkwjgDWkSZ3NQ9TrQj1b8N765oHONkBBSj3Y
   wUl5lsBNSFFWC6SvzpLwC3JjPe6kaIPzTX+aEh/v74ZOvUESVj3z2buvk
   ongIfy6PKZi3sP7A+WEP3ThWA6RpOxuWO+YPuNdy133IzOicoaD1OLZ/k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412690861"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="412690861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 02:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778477913"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="778477913"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 02:20:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 02:20:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 02:20:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 02:20:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 02:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECdT2XtN7yf8+9x/G7LYGKCaq/Xw80wJ4TEszhitm3on20JIfgO5LiOeqVWklxpWmVhDOgEmcDbGlfaPuEtMVHuunq4+AodSWAjYFoBJfDrVQL3HD2d3Rco91BTgKrgUvEeUkHRYBNm3CQmQpelzWdytnwtp7kfZuNB7s8zlD/NbVtr+kdbXgKnhbeFSwCQ0FCzTmx3RvDYw731KY4xksbDs0zLfb+Q1yJJu10T+8xDNMjj2AIXQ/vxfZNU8RqoiuWX5V61xq2Jzt2ZMzXJhVNUf+MaUjoEn84A5MVnZkcFXj107rGwkC1EOqnwXY9C9/kWZLhkKmqDMVSj5Jyw2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZJsXjQilRwqHR+M04JGQSfv5AkarB5FlcYQakqHORU=;
 b=Hl78N/FuicaNKsSaN2Da7WJ8AoEO0EkA9/F3tnkOCx+qzDNdOugVHtn/3BRPhMfc5UFPm3CLlzLu+O7S8mkmccPu+pHqM9kmkes4LQq1JBYdonfFoLU2ZitV1rhV5Rd7x4dGJSLH5HYT2nUYpx2ggT4gNRCiVSW1HH0a44OnfnkypxBdabwRCkRvfgMRv2zubCJDmyhD8EkAELhuZZyXOVaWK7f+FdkViASscCMMkCxBhNaNHGtqZzsA0dkPzEI76p+sRzikQzGD+NrTGUkSn6qfl7OTOMV7ON/KLudfaH/e2tzLslIJO94H86U9dysgpimwJ0oJA8ew5+k5pYdrxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 09:20:29 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342%4]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 09:20:29 +0000
Date:   Wed, 27 Sep 2023 11:20:23 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Peter Newman <peternewman@google.com>
CC:     <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <fenghua.yu@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <eranian@google.com>, <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] x86/resctrl: Enable non-contiguous bits in Intel
 CAT
Message-ID: <xnjmmsj5pjskbqeynor2ztha5dmkhxa44j764ohtjhtywy7idb@soobjiql4liy>
References: <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
 <20230922141441.3353077-1-peternewman@google.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922141441.3353077-1-peternewman@google.com>
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 1768f045-7a57-43c9-dbe3-08dbbf3afdbb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +18qdm8/DzKaDOh5SgeOIAvPChxgHzjlFGiK7co1cHmKHWaLZseyefOW1TVNHwuVksotgTb/7+bRaftoadwM1ro4y6Xh6wKq1n7XYhZTV/GmaZsfQUPK/Dfz2gWZoM3lHQO1gpL+VTypxmp2wTiv/YQM1EHP/EQNXYJr/5yC1EjRJ5wpifzVQ7OS++mbBetEIyKu1NWkE41JrCtTPgFt/O1wiPqSgr+WGl9GJYWMzUhNubNKS6qg5Y2snJB/XTBPX6WEFn4ox7hPO6DzPGkQxmFyBpM+xO4MCCVFwuv2m7xP5VzDTe6USFEc8nq5glIk5uDZJdxI2p1KUbLDzilD/ZJ0Bgm7G2ewlyhVZYgpcLDsT6sLxH91aYS+NaJE0QXyOAPlmbg/FqQljNWM0re5Z7wx1tb/aiDjli3ge7oNkqlrxb5QgsLfZ9O68yLygHRF1ZKWviZU/rgs3h37rJiaf8Loh5mrCGZr0Izu6X4nykqb5wA2y+T0tA7ldKVRuC7CtLDdQFpRtqxcgEer+lil2afnlPVcsfgI/GYjhUC6U6YWKlxOyOAHtO32i0ehmMhA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(186009)(1800799009)(33716001)(86362001)(6506007)(6666004)(53546011)(26005)(5660300002)(66574015)(66476007)(9686003)(478600001)(66946007)(6512007)(6916009)(66556008)(41300700001)(4326008)(316002)(8936002)(8676002)(2906002)(82960400001)(38100700002)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Buyu9+ZUkjulSJkFTdt9WyUHbR+zYk7SppYrpO5fnel15BfScKmexRigYZ?=
 =?iso-8859-1?Q?7RytLqjVhg2O3xtw72Feqf4B7MxVR2Dyok8sP9GwGP6ilBDAsPJnEz8niX?=
 =?iso-8859-1?Q?t9KFLBZaiEhr5471Q85dj1Fl9UWIclO28L6W+j8BMMzGqd5DhH/kHCH8SW?=
 =?iso-8859-1?Q?Hk2ZsjcBiBFUTMykZFidsjGb1L1yYNLjmoAsI8nq9CXOJibCyHHpzX0Paz?=
 =?iso-8859-1?Q?p0AckBitnxH3TnHwzQPEZPEtgDllAfMfDHSvHp0WiQpQ8O/+PaaDYlYXTT?=
 =?iso-8859-1?Q?TrcX6UUH0C3RRwB8Dica9fLilp/QLRcqfFHZNwMf3ZYaVHP9AtV7/DzqRW?=
 =?iso-8859-1?Q?myMO9c14ZnVL3mKIRFXZZ358yGB8xa0iCXucXmjsv77M2EYvyXrGhONyW8?=
 =?iso-8859-1?Q?Tpt+cy8MdLoK+JjqXLt+ACpBJOIIf/tlyLPJ41Vzj9VOJEwJMhezy/md1i?=
 =?iso-8859-1?Q?/QmMRP2H/jlsoSjlT7VYi/pws3b3DzHbmSJ+ON0BCkjgb9JiaNk9DWXkZj?=
 =?iso-8859-1?Q?+EvsRABEts/ZlU1DxpbtIxL3h1eYFjtHdH1/mLrkFtalR47tgeEzFEG4+M?=
 =?iso-8859-1?Q?PggZMs1emeAsKNPIY8ppzJWJwQLOxeH6P0fbRF9pNAt4Of8YT4vNInXdui?=
 =?iso-8859-1?Q?TsjbUMDZO+t7N7/i3EUGkaWznfwYXHOK51eFpHLb754uUkiAUTn3+Lb9gh?=
 =?iso-8859-1?Q?MZTmxmsc5aYCMDWkdzVD/G4LxUfnnNmc2k0dkPjmDoeoYGsFRONiorHm6M?=
 =?iso-8859-1?Q?lFDxkwpVVhJvbCNzVnB73JUi3BjpSw0je9J7v8Tpo1DtfiER0x9abWvBwD?=
 =?iso-8859-1?Q?WKXoJzBxvtMIz8hFgYo4XdmxPnfqMIBb1HkULqHyZ5OJbN7Os0lv8kLBAv?=
 =?iso-8859-1?Q?nKut0UBvIyhcUVyZDN+Cxz6blaEdQS9veO1VR9foUuiCVI7uFijiIXshjj?=
 =?iso-8859-1?Q?5g90YyhU8vq5KygPYNFOq09tfQwzdKvU6lVEx4DE0LuHAFAl34myh//SsS?=
 =?iso-8859-1?Q?ErzGhy0gcKhZ1z130BsVVYrNvJORw7NFKctlRYOVc/WDzN8SFQcEQX8pr5?=
 =?iso-8859-1?Q?iDnceKA/QNBYxZegeh0AUKbEDBGThHsYsQJy4mLZwgvjFUMaANOxMzHsmp?=
 =?iso-8859-1?Q?fkmPcDEpFmZYkKQejWyKv0jezfxE8hTvHB/v0xeNMBajKRXMyM+RsAjnuA?=
 =?iso-8859-1?Q?ZT29fiBEjYuh4TvPd0+oQYHOMZV6abfZwJlLzL4/PtP8uhW9NVvQBiuEgS?=
 =?iso-8859-1?Q?qfzzjvVden5iegEEYzCYChsg+xvec4H2tp9zGCOlCUMK137o9DT2jv2xCA?=
 =?iso-8859-1?Q?xoHxbF7+7m3mhLQvswHUndr4fuiDni6MY1nyIaNQS1Dk0rRavcAQX3SRLC?=
 =?iso-8859-1?Q?AUZ8ncZSK8mHOte2PEDQkjTBrB7kbCDS3kLCNhItJmudQtS9UO8+CCL1wm?=
 =?iso-8859-1?Q?3tSLDhtTWxaiMQYKXbDQVkUCytQKBkzVd0zCEJnzdTyy0oeYofrRK7M7MS?=
 =?iso-8859-1?Q?tJmsBmU2OXPO2oI6Wc6MWXeCmEPbwGSdIWgoHwsQxEE7M3cKGQM0N/TVkC?=
 =?iso-8859-1?Q?lFd7DTugw/KyQgzXFFXOH+Od+EF1Yu1ih2Zh90JhSq1/yEzFf+rsOMCEwO?=
 =?iso-8859-1?Q?Gbjx6N43x0jFCDYPbi6/nBwmyeHinqBpBGosoqEHRQEek1z0UB8hct11HU?=
 =?iso-8859-1?Q?vd4AqG9crOIjey1XIvo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1768f045-7a57-43c9-dbe3-08dbbf3afdbb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:20:29.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAY7Vy8nkHgxorzaxFIo431bD254UJ/uHyPnUf2VslKs1Qu/ud2wTIg9w4AuB2w4QZ82FEan/EKHpZd7n398CCPatY5kaI01S8zBNFvei1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, and thanks for the review!

On 2023-09-22 at 16:14:41 +0200, Peter Newman wrote:
>Hi Maciej,
>
>On Fri, Sep 22, 2023 at 10:48:23AM +0200, Maciej Wieczor-Retman wrote:
>> The setting for non-contiguous 1s support in Intel CAT is
>> hardcoded to false. On these systems, writing non-contiguous
>> 1s into the schemata file will fail before resctrl passes
>> the value to the hardware.
>> 
>> In Intel CAT CPUID.0x10.1:ECX[3] and CPUID.0x10.2:ECX[3] stopped
>> being reserved and now carry information about non-contiguous 1s
>> value support for L3 and L2 cache respectively. The CAT
>> capacity bitmask (CBM) supports a non-contiguous 1s value if
>> the bit is set.
>
>How new of an SDM do I need? The June 2023 revision I downloaded today didn't
>list it.

It's not currently in the SDM but in the Intel® Architecture
Instruction Set Extensions and Future Features (which I mentioned in the
second paragraph of the cover letter). My version of the ISA pdf was
from June 2023.

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 030d3b409768..c783a873147c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
>>  	r->cache.cbm_len = 20;
>>  	r->cache.shareable_bits = 0xc0000;
>>  	r->cache.min_cbm_bits = 2;
>> +	r->cache.arch_has_sparse_bitmaps = false;
>>  	r->alloc_capable = true;
>>  
>>  	rdt_alloc_capable = true;
>> @@ -267,15 +268,18 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>>  {
>>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>  	union cpuid_0x10_1_eax eax;
>> +	union cpuid_0x10_x_ecx ecx;
>>  	union cpuid_0x10_x_edx edx;
>> -	u32 ebx, ecx;
>> +	u32 ebx;
>>  
>> -	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
>> +	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
>>  	hw_res->num_closid = edx.split.cos_max + 1;
>>  	r->cache.cbm_len = eax.split.cbm_len + 1;
>>  	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
>>  	r->cache.shareable_bits = ebx & r->default_ctrl;
>>  	r->data_width = (r->cache.cbm_len + 3) / 4;
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>> +		r->cache.arch_has_sparse_bitmaps = ecx.split.noncont;
>
>This seems to be called after the clearing of arch_has_sparse_bitmaps in
>cache_alloc_hsw_probe(). If we can't make use of the CPUID bit on Haswell,
>is it safe to use its value here?

I believe the calls go like this for a haswell system:
resctrl_late_init() -> check_quirks() -> __check_quirks_intel() ->
-> cache_alloc_hsw_probe()

There this line is executed:
	rdt_alloc_capable = true;
where rdt_alloc_capable is global in the file scope.

Then later in:
resctrl_late_init() -> get_rdt_resources() -> get_rdt_alloc_resources()

this is executed at the function beginning:
	if (rdt_alloc_capable)
		return true;

So the rest of the get_rdt_alloc_resources() is skipped and calls to
rdt_get_cache_alloc_cfg() never get executed.

-- 
Kind regards
Maciej Wieczór-Retman
