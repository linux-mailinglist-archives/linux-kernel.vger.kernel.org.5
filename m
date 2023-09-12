Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6B879C746
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjILG5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjILG5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:57:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD76E77
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694501848; x=1726037848;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=C6ltZ8TQhT+vcB3IsxVjEcZYe3k7Qu69xsir+TC+Wb8=;
  b=Ixyxd5L/zMSSMXmSQKc80JwZLSMPMapuvT9b4Zc9eAG/J96TKwQjLpv2
   ClJGZoqFMEeI37L6cdQccOf7Z6NqNEmJwsPJxWsIESk/TZrd+WvJnmGFP
   qEGwBR1zR8oneEcBub4IBQnhLns+x+FyQ/HVhBn/hjKaqlIsGmErqHisG
   6WaT/n2A7B9Bda5FgRJqDfGdSoWadybR/HNtWVAHvBb4xCqnDYX9PyIIj
   GDYZidPXq/HDgIpSCE7AjKFy5+oUtL3xgo+NCPejqYlr3DHGFXNUDksJN
   BPPrsoxrd+XW1hGAdFVa6a3XFauXYo25qYGTXGzW36PEE6qcGWPw1Tbs0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="442305104"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="442305104"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858676633"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="858676633"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 23:57:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 23:57:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 23:57:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 23:57:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/aljEIRluieKCnP+gKvfFwYxTNaX3lKatze/7PtVczeoFqqx9gH4uXz7gefFHeJmaxlTWZnRiBKPmk7dF1tdKfKrfuLJubNKI6OTVSbKbu5qvkFGQHkSmwDPuojuloVPvYSzQ+aI8UbCTKPPdoBM/W0tKrQCfM6LRKJQ3MOvCv9zdqMfIgomTDuVHFwv1qyRiLj/QNFAXaeIKwDQRIazzuWlCtTUoH7ViQbTA32qMA2bYUgtfMDPz4vqVH4sUEuz16O+U0QhdaX/Qd1a5rw7f2CzI1Cd51wHEQFUZT8SOhLyPPFnofxoa8VdYGxAP5L46i4kl75Zw3BSDX/GHv8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3+Q20LU/8spt57OKLKCAqtwh+Ks7B0r6y2sLOmvHKc=;
 b=ju8VASjJw2BLkidHC3WR0LTt0uQAu6Hi9SThMFb1cUn6WImjKyk/GGIY0hHYip7M2xwhDNix6vPythEQJ7ttrMjJDSyzV3xRgd7ctiIFZPGXRbsVJJZSj6SqeJpH2/gt7LpAuxfAdIcuDY6z2ac6AZXy9J5TQVfc9EPOP8oOmfyx3H25VofugEklDZiQ6ePz+fncolUWcJAktehsFyPi5eEqNYADGoWN6VPbvP44jnsr1CmAtIprfAvFKnTiVvUQFFwa8BIFsChC6QRKUfBHOuY+z1fs9jCa+nNAnBTIvJ+wYfr65RtIsd/nM6AkFSmpjCj+2ObJHDJ2MM6UpYAlMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 06:57:24 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:57:24 +0000
Date:   Tue, 12 Sep 2023 08:57:17 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] x86/resctrl: Add sparse_bitmaps file in info
Message-ID: <w73nwlw6q5drlarcah56rhyknzaktu32iwp3bm7x7idgxdbmtt@m5xf44glqkf6>
References: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
 <27fc083358bc215676354818ad5a7abebd00e332.1693557919.git.maciej.wieczor-retman@intel.com>
 <6b172280-7dbd-9d97-4e00-ce231f084904@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b172280-7dbd-9d97-4e00-ce231f084904@intel.com>
X-ClientProxiedBy: BE1P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::8) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ2PR11MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: c59cfb23-a1ef-42d7-b10d-08dbb35d84a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qY5NxLns+tg4csi8FQ2b85kWQanUOfGva1MkNCim/fHnxZNvLKPb3fOvqB2CXG1WkYHXa5RoPAelS+HXzbFuaBoL/N+9hbXd5qzu/53yTXwSEJj+gTlkgAbLfQ2DVqSZBa9WKugSV93tfOWJH1E9EhwZOL9DzktXorA2aIWItlXKALoTJ/BYNtroy7aw/cBCXm8j/O9gPuIZfzjixJY9L5686lHPSbaOTik1OCy6h2jmxVhd8Z45IzngAH1FqPupwSogqWxUgC0idcKnJ5XLK0mbRK1DOE7++nn1HLAC9jrIrrOQNVE8myPSUrq5irKpSCGd/FIKyR4f4tDXUa62zWX4nozQG27Ed+DoiGBBtNj/obz7Z1HWJSWx25bVJWpnWWBryMH4gn5CI5BRuc6/34SfwiDov+ymxt7RjdfuLdidxJq/+WCCCXuW+eCUnupVWLn0aF/JuWgWMBqFnKM8FgBnMvopkiqZ1gVcL6ZJiBhBeD9O2gZBfsIor7hsvmizfPEcaXEUwlrUow6YujnqRrM56pyFZNVH4sSjxlqLnoa9RcJ8g25a9sslh3KhAe75
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199024)(186009)(1800799009)(38100700002)(33716001)(86362001)(66476007)(6666004)(5660300002)(478600001)(26005)(53546011)(66946007)(6486002)(6506007)(6636002)(41300700001)(66556008)(54906003)(316002)(6862004)(9686003)(8676002)(6512007)(4326008)(8936002)(2906002)(66574015)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?G3u/MxBOH4e4Oaynz4z6++LKY8AMnmEKQ6Rkn4TIBWzKK98toowTjgjK+m?=
 =?iso-8859-1?Q?znpe+ByakGi+7V9JKCv+FLKmaAfvfpHLz3w3KL8ayybtxyttM2NzeENkHM?=
 =?iso-8859-1?Q?AbWTDDEBWohWV4xeKf+vK7GDyyX3N3QXJyCkagQUslamySlBu/78MmLvDQ?=
 =?iso-8859-1?Q?FNMv+149qMmdJjCQOD9kg3pA8K+hAci5g8IoJRWNCGLjJRxyZEWqp/rkrg?=
 =?iso-8859-1?Q?6SKbm9ZeDnKGYu8N3ajY31rbFUKLRU8J82q8xuJZwmGKiN9GAHXrSpRTsd?=
 =?iso-8859-1?Q?y6nYdVTVgMSIB576uuOdIS3O5s56lNE4Zu//STHgaJOfHz6zzolwZYm7uF?=
 =?iso-8859-1?Q?Rr3cD5iBCVQ3DjpWu2B2CrB5iL+1GUUU7BsTXZbKCgmK2DLYakzdYrKRG7?=
 =?iso-8859-1?Q?K7dPdOe6Z6of/UQgGSGjaxCZBpfgFvXJxDLLDCVrDpaAygXwYSJ9xydTXY?=
 =?iso-8859-1?Q?oDMgjRnSrMMXmWkFf6xb5F8FMGVTWf99xLJ9J0wH13Twegf111nVwtiK0d?=
 =?iso-8859-1?Q?Xeoj5Ifw94vVAVHKVtfhM3xXu6b73y6o3qv6qShCtYwa489YH9JcoY44Mr?=
 =?iso-8859-1?Q?Sw5TWwUleh3I6ZcbeGh5o89fbESiQCQVoJu0eKr8MsbtC2xMf4qQ9+vb2Y?=
 =?iso-8859-1?Q?bNqp6zRsTS1B4D4mZsEnp7os7Xy5O8CIih8kyg7wQnLoerf+OQVJlAW5Ci?=
 =?iso-8859-1?Q?7RGFhpDrJBgkbb3X7dEN+Q2OkFW6xFRAAGpyF7UntaxdwPTF90M2+LAeg4?=
 =?iso-8859-1?Q?9kVffsVYfJegzKYsSw7a9nSjjufbp/Z/7GipLC8O8MY8S/Qfa7CiJN4wVu?=
 =?iso-8859-1?Q?N1JzWR1iUloQF/RAMmmGTJ0XDkTGCMluHeHwR7kqlmwMAbXcMhpKI4/bPi?=
 =?iso-8859-1?Q?dk5o1ZaWIjrZpTRiGLG3EIUCFIcfGyb+t6Qc1J59+9iiniQpqVpwOuV056?=
 =?iso-8859-1?Q?W6IOpkYwlh1GYQfaWsWaJETldIxQnOb4TRep83Bn+hp/f6cgrNsDTvBSiL?=
 =?iso-8859-1?Q?QGrp61ApRL+P7ZQxt53b6kc3MBl9m3lRLYZsi8odumwsA55ULfl84Gz+xH?=
 =?iso-8859-1?Q?SBhafedU3N2lcv+a8Rk/6xvABCqIrynwJtzZMJbQ4bGguJRwpZtH2lxhpZ?=
 =?iso-8859-1?Q?mm1gWaEaqg4MrdBsuMw/DtrQx1Tnp3YnKNcWG1DdUssiP4rJ1VEcbKhB9l?=
 =?iso-8859-1?Q?RhhGQXn7e4+h9HCw1Z/R/j0WCYUzA02a6EDj0lHTIcJ2x6ydyq/HKtuWTt?=
 =?iso-8859-1?Q?U9hhOSfbGsb2fIC/7u+jbYgLLc/OmI4PyrUxdRPQ9YOhuFROUqwWs2/4YS?=
 =?iso-8859-1?Q?kevkkyqj2795/9oBxqz+xQj7uX1VjfU6vnXe5PU5UEe2gEhNpAdKpLfvKG?=
 =?iso-8859-1?Q?9aL9SuA456tSnWstpuOGXvC+JPLB6HRFmDJL/eHVWEFgApV/wX/vVZvgb8?=
 =?iso-8859-1?Q?uEgM74GeulAZSrHUVziR06dIkJz6ILip0sd+aoyYvr0aO+ECQcQwt6M8t0?=
 =?iso-8859-1?Q?0ACUedJcbafMLCObwTQqjVNc91e5xBs41Mg+JgyjhSz3167+0AK14BIvqO?=
 =?iso-8859-1?Q?u2m8e6WEKjaSTee2Kp5Ru51kANSlznvMpKlhfPAfeym4wxXgcaGUEPqQ4e?=
 =?iso-8859-1?Q?1cniScR1SY9+0YOOl9ZHj1ihpeyFNwJPi/tULZiMUJALJaUPPGudzPQusQ?=
 =?iso-8859-1?Q?t06dqbP6Z+ko5L2mSmQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c59cfb23-a1ef-42d7-b10d-08dbb35d84a1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:57:24.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRderypUq0ygRcXNcz5Ydxw/rd2tjDRFu/q0EwCMoGS3XOMYjqvPju3LyDZMqIF7Nk9VTutX9Q+NRGneJu8g9pCYFrQPtU0B+uaCbnDKSZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023-09-11 at 13:05:30 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 9/1/2023 1:55 AM, Wieczor-Retman, Maciej wrote:
>> From: Fenghua Yu <fenghua.yu@intel.com>
>> 
>> Add the interface in resctrl FS to show if sparse CAT bitmaps are
>
>resctrl is intended to be a generic interface so modifying it
>with a vendor specific change is not ok. This is not what the
>patch is doing though so the changelog can just be modified to
>not create the impression. Perhaps just:
> "sparse CAT bitmaps" -> "sparse cache allocation bit masks"

Okay, I'll change it, thanks.

>> supported on the platform. Reading the file returns either a "1" if
>> non-contiguous 1s are supported and "0" otherwise. The file path is
>> /sys/fs/resctrl/info/{resource}/sparse_bitmaps, where {resource} can be
>> either "L2" or "L3" depending on their support in the CAT feature.
>
>No CAT here. L2 and L3 are the hardcoded cache allocation resources
>so "depending on their support in the CAT feature" can just be removed.

I'll change it.

>> 
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
>> ---
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 725344048f85..4d27354f3f30 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -895,6 +895,17 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static int rdt_has_sparse_bitmaps_show(struct kernfs_open_file *of,
>> +				       struct seq_file *seq, void *v)
>> +{
>> +	struct resctrl_schema *s = of->kn->parent->priv;
>> +	struct rdt_resource *r = s->res;
>> +
>> +	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmaps);
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * rdt_bit_usage_show - Display current usage of resources
>>   *
>> @@ -1839,6 +1850,13 @@ static struct rftype res_common_files[] = {
>>  		.seq_show	= rdtgroup_size_show,
>>  		.fflags		= RF_CTRL_BASE,
>>  	},
>> +	{
>> +		.name		= "sparse_bitmaps",
>> +		.mode		= 0444,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= rdt_has_sparse_bitmaps_show,
>> +		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
>> +	},
>>  
>>  };
>>  
>
>I think it is essential to use consistent terminology. To help with
>this I reviewed the resctrl documentation and found no mention of
>"bitmap" ... yet many instances of bit mask and even a clear official
>term of "Cache Bit Masks (CBM)". The user interface is thus already
>established and using the term "bit mask". Looking through the
>AMD and Intel specs I also only see "bit mask". I think "bitmap"
>sneaked in via an Arm contribution as motivated by their spec's
>use of the term "cache portion bitmap". Since "bit mask" is already
>in the user documentation and also in the interface via "cbm_mask"
>I'd prefer that we stick with "bit mask" in user interface instead
>of creating fragmentation with a new term.
>
>Considering this I'd like to propose "sparse_masks" to match existing
>"cbm_mask".
>
>Please review this series to be consistent in this regard. Note that
>patch 2 refers to "bitmaps" and then patch 3 switches to "bitmasks"
>... patch 3 already uses the term "sparse bitmasks".
>
>I think that it may also help to add a patch to this series that
>renames arch_has_sparse_bitmaps to arch_has_sparse_bitmasks.

Okay, I'll go through the patches and unify the names to "bit mask"
rather than "bitmap" etc.

>Reinette

-- 
Kind regards
Maciej Wieczór-Retman
