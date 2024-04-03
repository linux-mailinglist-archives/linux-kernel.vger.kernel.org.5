Return-Path: <linux-kernel+bounces-129059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D6D89642C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670541C2284D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C442A4CB4E;
	Wed,  3 Apr 2024 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDG65U+e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1A1D69E;
	Wed,  3 Apr 2024 05:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122700; cv=fail; b=iaUcGpQwhwx+g6eP7ZFVySiTnxAjzCvUN/xjMynU/qNYQG6WYCqh6Wh6xgKCYLIaeml0b/SPy6WqxiqYCvPuRD+ZpE14uBSvKK/DwAsw2bTjEQp7lxdPEvRgXj8V+OaU3c5H8/IkIhb1hODb0T/zuq38Ho+LqOYegaBYyGarI30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122700; c=relaxed/simple;
	bh=HNxSCdKd6CZFKI8n7ChwI4pXB1MnGym8VZOieu/PMK4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=W+seWyKxca1RG7zqf25AvP1r5GYulIiHDAVq/l/zaJqVcigWFCcvT7X9WD+7XLxOyNegMTqm1ibHLyAS3RQuCQn1+bK0USiI6Y9CSC7Ggj9Kl/04rPqNTft+bcKQVvyYuGtuRbSK5N/ErRREKISt19aVgCY827ZdluWkmraR/dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDG65U+e; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712122698; x=1743658698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HNxSCdKd6CZFKI8n7ChwI4pXB1MnGym8VZOieu/PMK4=;
  b=KDG65U+e2hrhzogD8FGhtqFVC3k8dObG8S0uqauIgNvxLIMAsp4GZW9B
   j+bEEHwmeofVvwS4AVUqXntMmT1MaSuR9K9Ih0IqbRgpLpK7Wgnf+sqZJ
   XJ1xtmcxibXQpZxQXxI6uVAHJK/E8t4o/o2S1Rd4Sqe8HUvCmlt7grmCa
   FVQlqGAR8n+ORVjUEn+M0Ru6WAgcFIYAGj1P0knB3JC/gBr4AWYkHBMZm
   /uNxPRxrvAJFgNdBxBTYL3Fl/zK9dEKIajaqFxwihmf6BIgqun446FVRJ
   wyfntLoaLMtKXzccOa2Wn7qdqjdIb7IaennMeY+yhK77E6dHRXmjZk33j
   w==;
X-CSE-ConnectionGUID: OZDt7Fz8QOm/XeWP5CkfEw==
X-CSE-MsgGUID: svWczcffQR+y4FbYYHB3Og==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="29807737"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="29807737"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 22:38:17 -0700
X-CSE-ConnectionGUID: 8l2D0HEgTiyR5EZ4FfftRg==
X-CSE-MsgGUID: bjPo10pYRXSn2WZeF2+H8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="49534738"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 22:38:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 22:38:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 22:38:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 22:38:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZXFDlOE08IDApPIXArm4Zp7zCfYg5eAyGL0oOrOq8mk4xPwob0a+5iGzl/s1tVucW86ojdSoGs8VwzR/XR1loccPoSMoN+rbpwvHnMXj4+yHrdxcEZ+O4dDDOHooYu6Dg5wvaWHcvLcf8ns+Nbi/1zgQVL+64lpqRONyo1aetvn5y3TGxTbOGhaD2vHMpGftjzjH1EWkJxUwnJihHer/WSQzkadCFTQOQvbzQr1m8dOqabXuZE7j/EprWtwuf88jB6FCuuBAzz/NNkMDWKXkrVzYI7Cpd3sR0af6o3RZf84NYQrj73/JFdNoGDh9yZUJEs09drrccyfA/AF57mTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxigF9gbm28O529nhi9dhaPXh0WYiM3ImGFlOp+0IX0=;
 b=HyqwANkgJlyYDi1QscMJ0eHX2zibBc4I9PikWG64hLojbAqqybWac5zm7YDX7b0smd3+GoEBI91B838dJtpkXcEwuylTH7coJH9G65DNed928buRIEJ612rVss9ZIWYZOMdCCjQ5b2iGRRtNcY5OGKD/kOt1mKawyF6xNXW8FnlLExfgM9LK3sU/OXLUha3a4KGDkYbfo+BhBmP7wSiMuvX8phKPBeJfh+Nm7BuMllPR1hKyufWQfShiyL7bznVYL1kX1jF/SqHboUGSt5mZmmxbGES0ir1VKhrNlD+oZ7gPiThbcnWL0PNYstfTDn26WS+sxwRV2/4tjTcKzxMQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB5130.namprd11.prod.outlook.com (2603:10b6:806:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Wed, 3 Apr
 2024 05:38:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 05:38:14 +0000
Date: Wed, 3 Apr 2024 13:38:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alexander Wetzel <Alexander@wetzel-home.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Bart Van Assche
	<bvanassche@acm.org>, <linux-scsi@vger.kernel.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: [linus:master] [scsi]  27f58c04a8:
 WARNING:at_drivers/scsi/sg.c:#sg_remove_sfp_usercontext[sg]
Message-ID: <202404031335.2790c0b9-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB5130:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0HG90ZAW8bdgXrTU8Da1R+Q64BHBzkdkfdXBUeyABmoWuu9q8u7xudEa0nQR4PgGyIeaWD6PKioO3iIfFx+jaLaSns2Po2y7SQUE/PDZ4hOOveCrk6LCQZoy2+DImPZNVJ5pVuncVIwj4SaFRkRNpYgguxLtSMTkKJWQXyckmho+EBZ/eDik3vuRkC4Tsyz2XhdSF33iQ3nuV8Dhg40f/ork7lEx5TjLrzEWWifppy69ZUY7aU0cdM5j9XVXHzduj1cbzLJquyRoK4XFV/nZk4b9QUcXolW2prUclRuRuJd4PS/s85UyoMxL0HOrRmOGGHIyI0+UH1iVLtjUe6kK7lgBUlRWH42AmPcBlXU1faFDsGreVZICgPyQaVCVw47tVogfFK4d8PZfX8j6KapoIWzvuCIRAE8JOXOeNPRGs8/zx2EJquY43vEXOTmFt5rbhUQRXHVU8PuABCseQM3IcOFAwHEBD/gb012G+AqfYhgAyac2/sn4DSWcpRpViviyDL7Q3/gvqAcSWwLRpM8LLfFFGCtyiQsFPPXzYk5hXcodqdmzc5SOcQQ31VtV/RssPJh0m56q9hqXm3vUe6ft/OQLlGkyvjBTj/INCNWwhaUlkiZxQf2EODnejoicBqd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BuLKYQMW2rXr37Mj4acGDqRTv2pC0sM3vXgdgH9F06/LIMGIuZsiFwP5mT1u?=
 =?us-ascii?Q?viO8yDgwz7yKOCTZwexmue5eziBKE9FuDqOLzX/dXVqOs9VsS+pRvd5cd8Tx?=
 =?us-ascii?Q?qXCS9tiRfZ0r45Ajd1sUqY/XICPMbahu3cvD3kszlZc32xjeR8PiBGME8m1s?=
 =?us-ascii?Q?G5sUGfelvWTXA4OtJpWK4Q39ocsFaDQlxIWDl9SKsoM1wTuPwLLz6eRJpQP/?=
 =?us-ascii?Q?7mV9r8s+sw8WVfQiAo20bOTpdBgZ93vaQliVj8Yn0VBICjIsEmlYJo5RSFYS?=
 =?us-ascii?Q?kNetwp0hpZ+MUtU7SYrTsPEpF/khh8/Msj8JdhXbyWXzMIgvZAVsHtRQz6SD?=
 =?us-ascii?Q?luzUYFzwOK1MDpG4REBS5SmpOqB0g0CSD3svbzHu40Oz4idC6lKYd5GkeCv3?=
 =?us-ascii?Q?kpr9wJhMA05Q4LcARWGiKTTzURKrLUDIFZknGIPtFMLJ8rxoIvZJ7np1BWW2?=
 =?us-ascii?Q?jcnn5b2+4Qcfv51ycRAQBHL4aBSnVB9jRoSR0G8eIXCw6J9ORLG4q7WdsNue?=
 =?us-ascii?Q?OIYQkz+DsZmny2x7820A1Gis+4UnaKINkYT2oUYv8QnFqnxefSKyu42wTcvC?=
 =?us-ascii?Q?BBOR8QDVkO12PqjOAkWSwAaAd9a/aBFJgiOmzMGMCYNLczuuTW9FHussm106?=
 =?us-ascii?Q?s90KR4oJSoYMQ1Uo+/30UlfHB8m73SdNPA7JNdDppqR8pDF3ycaADvdvX1jJ?=
 =?us-ascii?Q?yGubQveVQTpYS3mY0DFqrMMA7TCQwq0wzn2oDKbyq4U9MzdNdzcUag2Q17S/?=
 =?us-ascii?Q?5msnZOFGXVm2RRAaHNz7qAXoMiL2fL10KKVOJTcjieke23gScOa+X+L8wJ9z?=
 =?us-ascii?Q?KBHi78dDbxqrtl4GTNFncKwdf2/PTTFpjLOeZtKOV/6eZ3BCESR+34X9383v?=
 =?us-ascii?Q?nXIJKh7703lB0vAslEiB3XbPMmiXMEdhRTzSVbupOeeKtRpZ6m6kB495+1nf?=
 =?us-ascii?Q?ELLALDop15QdGtF8Dcf2WfP2NuLBwR5PtVhkxed5iXMo4G/MTHTjmTF2of6J?=
 =?us-ascii?Q?2EJv1Fv4hvKVOJ3VHb1O10zvDs5+xUd2yQITolyGCINRqxHh2AJZvv3o5vYk?=
 =?us-ascii?Q?Csl2MLFPHhLFiOJiN1clwINHo2GJlB3Am5hqKDgEdujusDgYnWsK2NNdtMcV?=
 =?us-ascii?Q?ZZQ8JKVAbVoBeH+AjKKXJEOxVsRjVu9RzoKP8FLxgdbJCFYbHQA89OeNEMll?=
 =?us-ascii?Q?ptTJ/n5099UZxFTeVAptMVOi/8sjP2ldOYlf4YnF7C8qx35RBYwKqQa/qao4?=
 =?us-ascii?Q?BsOK44yO9QDr1In/bl1MCM1VgPuHYbUvRsBzzBDk+Et+GWhRgf4bW6lJvMcT?=
 =?us-ascii?Q?EONJ1FLh6Gn27PHUC18U3dzMj0rX4MGb80pO25PCoIz5Ao/0BL+BiCD+td7c?=
 =?us-ascii?Q?hhzdXtqqIzNqci4tbLBS9hOWAsoyrw7v69WYLKT73Spd4ZKNZqSZZEnIJvpx?=
 =?us-ascii?Q?ZOMT80Icc4muk3k2RuUQyTMxACj7qseHHLbWP1VDEQUliiBVqhnWvtVqbhos?=
 =?us-ascii?Q?rtEcT8L4Eqq3G69MU9bJQJdy32zR6KCubwDTKSzc+ROIXXoxhCWKx74mRteu?=
 =?us-ascii?Q?LkiyTv7Rx4yA0ZYQJJ19a+mcD4OH2E1TQwRKkTSWzGWXijakcRxWyTkr8qo7?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 175fb311-4a6d-4357-abf8-08dc53a041dd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 05:38:14.6515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXtmdTicTQLqGAaOfhFVK2mJerw61ePvx+aNHU913sH8k8fKTYHnSmPBCXpvkZOD96CPc0NpdCVA+87dy3Gu6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5130
X-OriginatorOrg: intel.com



Hello,

we noticed a WARN_ON_ONCE added in this commit was hit in our tests. below
details FYI.


kernel test robot noticed "WARNING:at_drivers/scsi/sg.c:#sg_remove_sfp_usercontext[sg]" on:

commit: 27f58c04a8f438078583041468ec60597841284d ("scsi: sg: Avoid sg device teardown race")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 026e680b0a08a62b1d948e5a8ca78700bfac0e6e]
[test failed on linux-next/master c0b832517f627ead3388c6f0c74e8ac10ad5774b]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240330
with following parameters:

	disk: 1HDD
	fs: ext4
	test: syscalls-00



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404031335.2790c0b9-oliver.sang@intel.com


kern  :warn  : [  306.762148] ------------[ cut here ]------------
kern :warn : [  306.767691] WARNING: CPU: 1 PID: 89 at drivers/scsi/sg.c:2236 sg_remove_sfp_usercontext (drivers/scsi/sg.c:2236 (discriminator 1)) sg
kern  :warn  : [  306.778099] Modules linked in: vfat fat xfs ext2 netconsole btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c ipmi_devintf ipmi_msghandler sd_mod intel_rapl_msr t10_pi intel_rapl_common x86_pkg_temp_thermal crc64_rocksoft_generic intel_powerclamp crc64_rocksoft coretemp crc64 sg kvm_intel i915 kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 drm_buddy intel_gtt rapl drm_display_helper ahci intel_cstate wmi_bmof libahci ttm i2c_i801 intel_uncore i2c_smbus drm_kms_helper libata lpc_ich video mei_me mei binfmt_misc wmi loop fuse drm dm_mod ip_tables
kern  :warn  : [  306.831048] CPU: 1 PID: 89 Comm: kworker/1:2 Tainted: G S                 6.9.0-rc1-00040-g27f58c04a8f4 #1
kern  :warn  : [  306.841615] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
kern  :warn  : [  306.850241] Workqueue: events sg_remove_sfp_usercontext [sg]
kern :warn : [  306.856832] RIP: 0010:sg_remove_sfp_usercontext (drivers/scsi/sg.c:2236 (discriminator 1)) sg
kern :warn : [ 306.863786] Code: 48 c7 c1 80 b8 87 c1 48 c7 c7 e0 a1 87 c1 e8 4e 64 1c c1 e9 a2 fe ff ff be 03 00 00 00 48 89 df e8 4c 6b b2 c0 e9 55 ff ff ff <0f> 0b e9 26 ff ff ff 4c 89 e9 49 8d 55 6d 48 b8 00 00 00 00 00 fc
All code
========
   0:	48 c7 c1 80 b8 87 c1 	mov    $0xffffffffc187b880,%rcx
   7:	48 c7 c7 e0 a1 87 c1 	mov    $0xffffffffc187a1e0,%rdi
   e:	e8 4e 64 1c c1       	callq  0xffffffffc11c6461
  13:	e9 a2 fe ff ff       	jmpq   0xfffffffffffffeba
  18:	be 03 00 00 00       	mov    $0x3,%esi
  1d:	48 89 df             	mov    %rbx,%rdi
  20:	e8 4c 6b b2 c0       	callq  0xffffffffc0b26b71
  25:	e9 55 ff ff ff       	jmpq   0xffffffffffffff7f
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 26 ff ff ff       	jmpq   0xffffffffffffff57
  31:	4c 89 e9             	mov    %r13,%rcx
  34:	49 8d 55 6d          	lea    0x6d(%r13),%rdx
  38:	48                   	rex.W
  39:	b8 00 00 00 00       	mov    $0x0,%eax
  3e:	00 fc                	add    %bh,%ah

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 26 ff ff ff       	jmpq   0xffffffffffffff2d
   7:	4c 89 e9             	mov    %r13,%rcx
   a:	49 8d 55 6d          	lea    0x6d(%r13),%rdx
   e:	48                   	rex.W
   f:	b8 00 00 00 00       	mov    $0x0,%eax
  14:	00 fc                	add    %bh,%ah
kern  :warn  : [  306.883440] RSP: 0018:ffffc900006d7d20 EFLAGS: 00010202
kern  :warn  : [  306.889602] RAX: 0000000000000002 RBX: ffff888215d53798 RCX: ffffffffc186d39c
kern  :warn  : [  306.897706] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff888215d53798
kern  :warn  : [  306.905724] RBP: 0000000000008000 R08: 0000000000000000 R09: ffffed1042baa6f3
kern  :warn  : [  306.913756] R10: ffff888215d5379b R11: ffffffff810057ca R12: ffff8881e3278060
kern  :warn  : [  306.921778] R13: ffff888215d53700 R14: 0000000000000000 R15: ffff8881e3279328
kern  :warn  : [  306.929814] FS:  0000000000000000(0000) GS:ffff88818a880000(0000) knlGS:0000000000000000
kern  :warn  : [  306.938749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  306.945348] CR2: 000055ea9b833000 CR3: 00000001d92b8002 CR4: 00000000001706f0
kern  :warn  : [  306.953330] Call Trace:
kern  :warn  : [  306.956618]  <TASK>
kern :warn : [  306.959550] ? __warn (kernel/panic.c:694) 
kern :warn : [  306.963647] ? sg_remove_sfp_usercontext (drivers/scsi/sg.c:2236 (discriminator 1)) sg
kern :warn : [  306.969896] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
kern :warn : [  306.974403] ? handle_bug (arch/x86/kernel/traps.c:239) 
kern :warn : [  306.978753] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
kern :warn : [  306.983422] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
kern :warn : [  306.988468] ? ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
kern :warn : [  306.993423] ? sg_remove_sfp_usercontext (arch/x86/include/asm/atomic.h:23 (discriminator 3) include/linux/atomic/atomic-arch-fallback.h:457 (discriminator 3) include/linux/atomic/atomic-instrumented.h:33 (discriminator 3) include/linux/refcount.h:136 (discriminator 3) include/linux/kref.h:36 (discriminator 3) drivers/scsi/sg.c:2236 (discriminator 3)) sg
kern :warn : [  306.999688] ? sg_remove_sfp_usercontext (drivers/scsi/sg.c:2236 (discriminator 1)) sg
kern :warn : [  307.005925] process_one_work (kernel/workqueue.c:3259) 
kern :warn : [  307.010868] worker_thread (kernel/workqueue.c:3329 kernel/workqueue.c:3416) 
kern :warn : [  307.015456] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:280) 
kern :warn : [  307.020433] ? schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6824 kernel/sched/core.c:6838) 
kern :warn : [  307.024690] ? __pfx_worker_thread (kernel/workqueue.c:3362) 
kern :warn : [  307.029842] kthread (kernel/kthread.c:388) 
kern :warn : [  307.033903] ? __pfx_kthread (kernel/kthread.c:341) 
kern :warn : [  307.038503] ret_from_fork (arch/x86/kernel/process.c:153) 
kern :warn : [  307.042919] ? __pfx_kthread (kernel/kthread.c:341) 
kern :warn : [  307.047519] ret_from_fork_asm (arch/x86/entry/entry_64.S:256) 
kern  :warn  : [  307.052288]  </TASK>
kern  :warn  : [  307.055298] ---[ end trace 0000000000000000 ]---



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240403/202404031335.2790c0b9-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


