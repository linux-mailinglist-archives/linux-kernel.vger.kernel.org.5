Return-Path: <linux-kernel+bounces-129225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6CD89674E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DDD1F24A92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E816BB2F;
	Wed,  3 Apr 2024 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2XjekIi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DF5C8E6;
	Wed,  3 Apr 2024 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130848; cv=fail; b=dvFJsxLpu+BS8K5XVkFBvk3zQOnunu2n8iHzvAc6TcSo8tU+QgS08TlSvGkT2LIrvlFEugJe50t4ExDeiFbZz2jV+W3u0qplLlasGS8kvG9Cg5xD9+UbxPtgGaUjOqFyrcROL8olUlvHoCht971Qf/KDIHAbTgSjSynZ0aXTgQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130848; c=relaxed/simple;
	bh=wCd97lO2dpF3CjAQL5bmrJb6Z+icDz9OmaVPg9CrnZs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=exAf1bQKep5PJL4WVYIGyW90kjrfUbvZk/dJ7sIhn20vhzEa1GOa/jgjNtt1qWtUOtkLc/MNoqNuTpfl5o4Xy3YrJ4yOe1c10nJ9xmMWKz+waZTabpNaEfevnV04hcSZkLgoXOIxabBALDzsVl1vhwyZcKb02hm3RE07epSp/3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2XjekIi; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712130846; x=1743666846;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=wCd97lO2dpF3CjAQL5bmrJb6Z+icDz9OmaVPg9CrnZs=;
  b=O2XjekIi+irEFBTGQhZGqthBKYI7lTh06M9tNk79cSzlXA7FFD1KugfD
   KvXeZBK4G4lJlznCHx3SnW/WKaDg6qoUpFAOhnStJkDpongQ/m49m90ys
   awgOmDNzchIT6XSzihtMMzbkTljuLtBW3x/2MKd3RqAky+zKP0YFaHS9W
   Zp2nopJXkxZUDco//XptFBUGGNuArf9sXHhw7R+dqHJJ7gsy8hSKr64C2
   NkThtafBQVn8UAiADtUbEKsxHeRGUWHU2Ahig40G4zHVgCj32wTJtM+qW
   GeD2M3X/EwD0jpQR+5hmzDuj//IhXSNn7W4IwA7kjc/wYoF/4o/c20J5p
   g==;
X-CSE-ConnectionGUID: jLtuCMlXRZ69f6lhCJ/gHg==
X-CSE-MsgGUID: Hh6hAMzGTx+lXQRjmGl7jA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="11120451"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="11120451"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 00:54:05 -0700
X-CSE-ConnectionGUID: w7+6E8ozS8GykiND8IdCeg==
X-CSE-MsgGUID: jjiVvTviR4iTcidIV744gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18176519"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 00:54:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 00:54:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 00:54:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 00:54:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 00:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Otz+FGNjZ9D9aX8QpwQDduKKadphhUvJM/GPy/V2pY+hqcVYTP1GZ4dcBIE77sf76JqZXbVauCsxxMgS0Omo++lKQ3SAAryMLzF7aqI0UP7OLVK98vgXFtxAyoh4dXG+gXaoUy8u2H55YDFkk/fMbwD2hJFcp1wdwjVYgxARKjBEboDYr3NJd7cmI7vcIhXbFDJTWYDxQuiblGwBxAJAyuQGL2nRFbOcSG42sWlC/vPklbrrmGJ7YTiDE8RWXx1DoVLwOrQb9kMHm+FMx9bLhXSK/M8P9uyJFoxchXIUgNrtttQBT3ryuyxZ2IhPKWLkmwnArqZqOiFhL77VRe8WwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kO7e4K2vIamFOVv7pAbWAdVEmbjaGgxdfPfsENA8mg=;
 b=JAl4ZsjDdrvQS/Nydy4g91fGMApF/yhmjz9cAxRsVT37X/7T0yUa4J/+GLq4Pucv/8GRDTY09jRkbbGI06v6NZeBEY7ElHfCzb4b4Jo3JNF3jXSrHdEoeKym9zwSpNqKPInOoGqz/yEiPD+d57G2R7jwyWxkkEk+TfDcCJL+Fdk8UgNemooNusWnNBq1OkWdrtEznif1TjP1CnaeCcIpR3SRu4I3/JRoQ2/oamoz33h3lVSD36hkQ2Z08Zr7uNCheTSloVePJIppaGy6L5Pe8L6T6lWO8pf8kHEP6MoXtYdGT9R/VCdd+b1JHHes8E4wDwxTlZgFyd1pFl0OTC/fww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4706.namprd11.prod.outlook.com (2603:10b6:5:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 07:54:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 07:54:02 +0000
Date: Wed, 3 Apr 2024 15:53:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>, <netdev@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [net]  2b0cfa6e49:  stress-ng.sockfd.ops_per_sec 6.9%
 improvement
Message-ID: <202404031530.bbb648b3-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::31)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4706:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2CPL6BMOPkLRKE1tAct5MjQat6oTRClJZ9z5OhIlAhC4A0AZj6EqVkl1NgRyryAc/ZfbcQxv1eYo9LJlO3l/Ns+IDhAzfBOyBKF6eBT4mjK04HO9i2SrS9+MGnBkL2XSDJjYdXdxpzhxY96VMsAJEqWPWWKGe/XuhFPwnZcq2UgKTIZ+ctubIU4JMf3Q17WGwcvWsUa1iqEaMB4mF+5+ZEnylLK5VrBHHlmhCvW0cc3VrDgtjNkkHQ8xlh42EH1O/7saNbqdtVUmODEqSFt7fixDHNaCCUpV1V1eS1aRiMAY6JCNGHfwPEj1W0jxArVP4ufQlLdKlyjJHUO4nubEgVhXVO/iGfJ6Ys6ZJRnIMrePwTE/GJDbaEBdoH8W+LsGynb6MxL16/yBZUm3ekyRNbw3MAlDCNTB6LRVdHA8wEHFcn7ObQo2octXsJxeYMLqhLC9F7fyItjVVisTbxXrdzuKoJeA+hbS5VsyP/VBrALHpOoMqZUHEiVEe+kZ6zobdBwujqgR4OPiVmtfFLiQ1TlrjZP0leKfhAF2TNzuoZ8POiGSRIXOobdMscgXAcnaTf/9BS/8rpADG9LUlT80v76IQvq0UaigVkgSkZcAWQexk+W6/zkFVPVKafx2FoE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OD+FyUV+jbtxtiOSuwrag+M87Cn3+2ctbvUrccgj5iPpBMnpITkvaI1MbC?=
 =?iso-8859-1?Q?xEsL9j/MNWONl7xlNtZWdB6gM9kVFUQPFXUw2xZDty6yMvVH4GCUMC46y0?=
 =?iso-8859-1?Q?0I2WiXvXwRA42nVMUpK95R7cyNBOMzSd7LoBFHvhu4wmp3C1xa1Jq69HaU?=
 =?iso-8859-1?Q?9mEgnfYiY0qzT18IPOnSakyi0XNrb/NwgoTEE9yvbIJXRUjthOuiZgRvCq?=
 =?iso-8859-1?Q?NSFqgBxUpUxcRaqYdh6e6ulof0hmMITG9123LgkbRRo7ScNveTDJ8xMtvF?=
 =?iso-8859-1?Q?pklV2Jq1i4DkCHA9BsWzg0646n00bYlym8pt9rhKAaMcfSHhEjoLmSqj+K?=
 =?iso-8859-1?Q?X17wWoa/zn9HMhHKU+jO+Wbl1vNvN/BidV1afNEqAY2xRosD8LSybS0JKP?=
 =?iso-8859-1?Q?KNHCLHb4afxF9yp9HjGDRwbGaRZ0XTsF8xQtV4L2er4fxuBKGqJkCvI/xg?=
 =?iso-8859-1?Q?TKB3ccZfi1I4evfJZgnhodIiT1edXrd9ZfIbxpVL18Fa++HcqCNlTQLtNb?=
 =?iso-8859-1?Q?uYry7uebWpfWgeP62PzThJzZ/zkFWqqgKfe+Jtzo+U3qPLqY7kr4gLgo7+?=
 =?iso-8859-1?Q?zCdjSqCoprhDUdDlKEqqa9DABdBU9IcKKKUTk4Tz6oVTXuMD0k/9NvfmCJ?=
 =?iso-8859-1?Q?9aUxbVxuOzQ+5mbBs2E7SbM0ywzSX58j8GJaNhtJPeUDmZAWb7OrVZEyPC?=
 =?iso-8859-1?Q?kJ/Lnw+FOadkHHvWGMvVFS+gdsgxwSYCoTWU1kCx52qhS00cSSq6l/P4dI?=
 =?iso-8859-1?Q?oVcQu/eQDAX1SqC7dAGbaBG2ut4EqXUUvfo9sb0IGDIpGQZk0Qx42QHGs8?=
 =?iso-8859-1?Q?kCx+Tk/MAzwoHLjkMF87Qk0J+J3QF1yDF+7mwtuPvxgYRnf3QIdqDWCTlb?=
 =?iso-8859-1?Q?eaXISyZSlEFnFe39Fmx+EWFfmCADwHXWbtKKA6crk4FAQt712nUbZ6JyLd?=
 =?iso-8859-1?Q?Cv6MlgrkE4IF8hbEj/1slzGfb3gnwjaXQSZlUgATm53EDkY3I/APDKNGSI?=
 =?iso-8859-1?Q?8LNx/Ciezuh0xekchqScJae58XeLQAonsthiKrU/j4UefNOp9FeJRDe6Xv?=
 =?iso-8859-1?Q?g84Lw8e60SJ57mg+BdxJZk5Mc0cS888VndUtXpg9LvmGTT2sBV8hjdQGeF?=
 =?iso-8859-1?Q?GwMufgn52C99mm9deHUWnYvUlXhLq2m+K5GdQ2b5qV7cvEonHnVBTSf2bS?=
 =?iso-8859-1?Q?oJD9uGL3F2r3yXE/rrodcswUjCFD3KlHhFbRXRhIsPMa9I/wJhcf46bDwt?=
 =?iso-8859-1?Q?QeDT4ut98N/zFYRoAbLOfdD5Ks0sh5JOgtUGO4z5gP4eIaR9iA6pGuqCLZ?=
 =?iso-8859-1?Q?QdWLyQmwOftRVmQYkoz1dv7dkjoxkv86yusO8ic+P6dKZNPOAg1tKjaPmm?=
 =?iso-8859-1?Q?FXlgyIW+aXnMWc1jQ0VwBImEDumlnL4D8456Myw5vPyxyCc+Ow3e9hZB13?=
 =?iso-8859-1?Q?qS26xvPV24HOeBEScpMzNjwFhPk9YDqqDFbNsiUidhz48lgUUrtEfKVmzh?=
 =?iso-8859-1?Q?0UHIdnaf3JjROZUxq1F1s4eVxZ9ZKwFiu0Qn6RdMn+sFrKDjtGW36EWsr3?=
 =?iso-8859-1?Q?RtNPunT9aRmT2sGBeU52XSJJjjt+OSddtLyGdt3pakUXGpwGnQaTpBISEG?=
 =?iso-8859-1?Q?Mcsp2QQ9lA9aJIHnmjJAd7xdASqV0MVCjsbj/wCdQsMM8o+ZLq4SgKRQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68caeb94-b7dc-4158-24c1-08dc53b33a68
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 07:54:02.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HjTBlJ2wSr3MMHl4usUx2jqH8L2WgLquP/YXlXlTARI0lYog9ihPWtNmJof43IoVijvegPvPG0rfrTO5YmbDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4706
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 6.9% improvement of stress-ng.sockfd.ops_per_sec on:


commit: 2b0cfa6e49566c8fa6759734cf821aa6e8271a9e ("net: add generic percpu page_pool allocator")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sockfd
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240403/202404031530.bbb648b3-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/sockfd/stress-ng/60s

commit: 
  32e4a5447e ("net: dsa: realtek: fix digital interface select macro for EXT0")
  2b0cfa6e49 ("net: add generic percpu page_pool allocator")

32e4a5447ed9fa90 2b0cfa6e49566c8fa6759734cf8 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     64663            +3.5%      66953        vmstat.system.cs
  54271775            +6.9%   58029628        stress-ng.sockfd.ops
    904069            +6.9%     966535        stress-ng.sockfd.ops_per_sec
   2226722            -2.4%    2174212        stress-ng.time.involuntary_context_switches
   1678568 ±  2%     +11.7%    1874352        stress-ng.time.voluntary_context_switches
     48.68            +0.1       48.79        perf-profile.calltrace.cycles-pp.unix_scm_to_skb.unix_stream_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
     48.54            +0.1       48.66        perf-profile.calltrace.cycles-pp._raw_spin_lock.unix_inflight.unix_scm_to_skb.unix_stream_sendmsg.____sys_sendmsg
     48.56            +0.1       48.67        perf-profile.calltrace.cycles-pp.unix_inflight.unix_scm_to_skb.unix_stream_sendmsg.____sys_sendmsg.___sys_sendmsg
     48.46            +0.1       48.58        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.unix_inflight.unix_scm_to_skb.unix_stream_sendmsg
      0.25 ±  3%      +0.0        0.28 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.15 ±  4%      +0.0        0.18 ±  5%  perf-profile.children.cycles-pp.__fput
      0.21 ±  3%      +0.0        0.24 ±  3%  perf-profile.children.cycles-pp.task_work_run
      0.22 ±  4%      +0.0        0.25 ±  4%  perf-profile.children.cycles-pp.syscall
     48.68            +0.1       48.79        perf-profile.children.cycles-pp.unix_scm_to_skb
     48.56            +0.1       48.67        perf-profile.children.cycles-pp.unix_inflight
      0.33            -0.0        0.30        perf-profile.self.cycles-pp._raw_spin_lock
      0.09 ±  4%      +0.0        0.11 ±  6%  perf-profile.self.cycles-pp.lockref_put_return
      0.46            +4.5%       0.48 ±  2%  perf-stat.i.MPKI
  28697474            +6.5%   30562835        perf-stat.i.cache-misses
  96563339            +5.3%  1.017e+08        perf-stat.i.cache-references
     66959            +3.8%      69506        perf-stat.i.context-switches
      9.73            -1.3%       9.60        perf-stat.i.cpi
     23006            -6.2%      21577        perf-stat.i.cycles-between-cache-misses
 6.536e+10            +1.6%  6.643e+10        perf-stat.i.instructions
      0.43            +4.9%       0.46        perf-stat.overall.MPKI
      9.87            -1.4%       9.73        perf-stat.overall.cpi
     22695            -6.0%      21332        perf-stat.overall.cycles-between-cache-misses
      0.10            +1.4%       0.10        perf-stat.overall.ipc
  27236190            +6.2%   28914374        perf-stat.ps.cache-misses
  93594596            +4.9%   98187722        perf-stat.ps.cache-references
     64403            +3.7%      66793        perf-stat.ps.context-switches




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


