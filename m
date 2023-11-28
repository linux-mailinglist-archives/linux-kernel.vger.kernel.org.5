Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DF07FB2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbjK1Hf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343902AbjK1Hfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:35:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B5F1987;
        Mon, 27 Nov 2023 23:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701156923; x=1732692923;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KWN/ysY+oElKEYN6xaisIkC1BjUSzqYDSd3wAedn/24=;
  b=YOZNt4if53kmxGWf6vSbz8Ip9X7jFS1MM3uVcBKd/zzWTpnz190AOTht
   zrtAF078DoIpevftB2p14FFrjk51guBlJHz5jpqRGVo9iBDhTpERYke/O
   Jxmc/mNqL+EZ+JYkVVhkfic/ys0s59re7MFEQUxVL4dxxaTAxX1cYDLe0
   4o1g0F/8y06frtN+XD2DCf21P6fFWN0t1ASAQN2/x1tZZUQDvfQwN0p3E
   kmmGfkwPooyd59+OvvhYJf+km1Sax+AjUPJkXc6BQNz1LB6Whxi+heMr3
   d/IbOVbCz5Q5fUo9vFfSfh4+pO0W1dA0J2YWD8K4Lewj0RJ/brXwLrbJg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="479070762"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="479070762"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 23:35:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="859332659"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="859332659"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 23:35:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 23:35:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 23:35:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 23:35:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHKO1M8k2NQkGWZ+UcH+tEN7AXtVH1Zs2GLXzyh/B6j8C6Hj1jNPJWxZw64XQBjsar7hr+fN67vbv7lezAbmkK7vsQWtEmM1QAL/LDa8USz9K1C6bGBga0HN+sBGYxMRfVJeU8aAtiD+byi0s4aY0JP4LrNy01Dv1Zmr2ueuh/NImUhOTHQ+uVSN2dzDJobwiDCvtKF594f6HviDtQrz5UtkgwqA+9R8jsTMtA6Q/GP2hsUlTApXrDIgoxH64ktk+AnaRq/Uo0KbhQg62uGhy3tSwJ0K48ati3VV5ASQdnDeysZ59kyKtvNpWMR9mdJDr4CyMQMb65bUchtq2GDxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIBoFc2OoorGM50VCz/zEHXF97Hkc8IxK/+IoQJmkVM=;
 b=kOR/2YsyNON/hn5cVhix1XCsrWJP6MPXSngCUI2DG7aqUXZaZXqHHr2kshqqeymGvEg60HvrIZm2j9K02T95lw4oXhm5pS3O+YxqxnQO75HAIkFRjaxhgCZO0erGQZZwgrMQ0nCpfbDGdBq1ueAja0C2luZIN/rC8trDGVgidWRRIOPDGErkM0FG6ZVOYrmJX4cb58U2xBsV7DptAzLSSqWIOwf3ob+2lKk/QkUgF6g/BzWTwJsPxt29SJZqvYI7AjXTk2tE/43vdjNSkn6Vj4OWZ590l4SSKykmT2Wksobphq/BdUmDnSgovYEaJlJJ3tMKhHWwRGEiA8SJrWuhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 07:35:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 07:35:03 +0000
Date:   Tue, 28 Nov 2023 15:34:55 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [jarkko-tpmdd:tpm_buf-v4] [tpm]  5581fa1c8f:
 WARNING:at_drivers/char/tpm/tpm-buf.c:#tpm_buf_reset
Message-ID: <202311272244.dc5dae8e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:4:7c::25) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 769d3783-915e-4150-57ea-08dbefe488cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LB3z8vq0XXSnCB0BHsEsvTW9f7UQZvGzv0X4xblbEDRWie3wQmfukx2cp8H5VJIRERRjTF+jxls6RHqH8vNKCPkVhWXNkQ07EikZP9vSOmixY4W2DmLAC8yY9BlvxShn0iuYAnMTE8TDNmLm2b/GJS66b0hcck3S91c5caE5w/thxkowFFWg1T8a1udHqTDdOHtB5LDA/5g8ev46OGnwmUl0nqsvBlF+8PcTxsjkOEFtv3XxCvXJlIcYDs8q7DLlRqestePqG9eEcAeNdzfkWdNqWtPC8Bv1nxa+uEPTSaYBPPkUnyg3UC+VQYWuc9r0IpHe10z4zS1ZDpkPJ+kZpYItMtFj99gr2SK//cIrkb7jLejXMAOeHv3+FDjvmHjYCeDQfmmC06NJul6VjJQcRwTPD8Cf3MrPXqAWVfbGwO71Bessb3w3T7YLpdvUA66cYSYQksd5+7Ci/oGcnt1ConbEXWley8lx9KaufRlimK58/lo8Kims0ZU0uamzWOYAVJWV0mmZnXnUTZRy1XbWSEAgmKPbQtIecTGMa4wGlsymJYchLmzvxG3SKGRGTmfPWV8GApvYhfrhdiCYobUUofCbYbpFNgj46EcCpTjvGuZ1yoPQ5Uf+OMfd8Log5GXtC1BzgRLPJddxk9Jffs2JVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6666004)(8936002)(8676002)(4326008)(45080400002)(6512007)(6506007)(66556008)(66476007)(66946007)(6916009)(316002)(6486002)(966005)(478600001)(36756003)(38100700002)(41300700001)(1076003)(86362001)(107886003)(26005)(2906002)(2616005)(83380400001)(82960400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FdQcKH8HUxh2XKFXGVBy0tbWLp+Qz7IIifioR7vsqQIPwbrm1gOnrBJNz4IC?=
 =?us-ascii?Q?80oewWMgeVdl34mIiRdSuowbhrioN9/s0ZrusSId90Bt/M2TsucYQttQiPbS?=
 =?us-ascii?Q?33OsinSNm6rjlxYQJTbkrGrp+UmG8RFrOGqjH+/GC0HuowEEtFnP0S74PkIm?=
 =?us-ascii?Q?TxluLXNyOkN9Wfk4HhmE+m4XB9iVIbrWH7eAnAGEtozc2U2EZV03d0t8kh5c?=
 =?us-ascii?Q?O1yrjJ1QaF7VmJvyFX1Sa6JNy/cZP2MxoY93KBoXKk5xU5dP2j0GlFOUN8hH?=
 =?us-ascii?Q?rGISZ7KZEd13yXtXdb00DpWokqJ0EcEGTCR4Vs9NWqKi9W6Xc1lTZsiPm5cG?=
 =?us-ascii?Q?8tXggAXWF66+gmj7KVx9Y8exDGsnUVZOtxhQk7XvqHQk2WgXZA1UH2ILZlxh?=
 =?us-ascii?Q?StJW15GouFpNiSF0ten9y8hImq+kcaW7ZQihvo5tY/8B3XHj2E2/a3a4qCrs?=
 =?us-ascii?Q?B0X6c1aKGBqUfKIDtZ1GabCW0/lN0rSFMLChUd+8PMDo+f6pDxm/u3Tn/cfk?=
 =?us-ascii?Q?Mn+HW/Y06XSDQwhod+c3/NqLd8QmlFcAqT5xAgUnXG9IBY779rf7T7ff3Pr8?=
 =?us-ascii?Q?xqMl36sJAgOiy0J6vl1x9jJLbIM8hmy05a6w0BDsE5KgNegD3azvyJYV0ylf?=
 =?us-ascii?Q?w0OD8FNV5NvVBHQ1zWt3FAywN2tAi7r+94Nhq1dv7NlIJQFuJa+l9XBfS0qT?=
 =?us-ascii?Q?rR3/VcFI+jT5JlS8YuIZafSTaSGHqPIbuKsm2Udme818i2PRSmQgD6nmcRnB?=
 =?us-ascii?Q?7sfg/C8sDtpNZYVccuZ/G971qUYyi8jJbuMYN00vr5dfQTmt+eG2ML8ixdY+?=
 =?us-ascii?Q?3h+HTVZPi1unzqsZfZ6rM8Lt0D0dwCPa21ViMsM9olWLSUShOGP/o+Ay00kS?=
 =?us-ascii?Q?ik3P0pAhz73fJsWs9OhKiYmg4g+zrgPAN3HXZmtc1Ckp4pOnme2bB+QAadBP?=
 =?us-ascii?Q?mYU2fsfzoXwshmV/95mEX8lHutNl0EKdOdC7E6jNZsn65IxlMWJB8xV8zxea?=
 =?us-ascii?Q?4PIgxNQV9V3Q0mnJa9abBzTf6WJo4WlMd/GrNT+r4sbCINDy5ofHr71p8DQo?=
 =?us-ascii?Q?7hiVQm7dgZOT0FpSmZobe4gvoJrMl9nDBpO76EYXr6fXJuylFKTp4umppeI9?=
 =?us-ascii?Q?KgLDsUTGXzNDIHcA/YyRcElHpmAAwTQUu5C7g4YFIOes1lNI3RA1EX1fGbxa?=
 =?us-ascii?Q?O5rHr1yf595uOzkt01iL3YbvbM7hCIkWBJeOwjEnRnxgDeKgXWz+dOCUISov?=
 =?us-ascii?Q?yJ66R9+V374zwfgobZZ9OMnd5Gt0aebPZlf+9XaHSSuXUDcOcenbPma6tnQn?=
 =?us-ascii?Q?JcKKb5fBrAyb9cco+U9CDL6ey9K45m0nPdBmfgEwdYpuF0/rL/e7//uwbiIW?=
 =?us-ascii?Q?TIHDsaqUc5kLqpjXNnndMTC0Mh6rnQZwV5npnlT664mTIOOfyN03kq4Ygln2?=
 =?us-ascii?Q?8u7M5Bo/SQUFPG73DzAWBSh1e0iahta1mqUOegfL+MusosSXs5im8qPmZnbY?=
 =?us-ascii?Q?wf5vcmRpc/Fmlb7xjip70fxhmVASM7tFR3I1KVoP0hy36P7NCZXSFwLk3k6k?=
 =?us-ascii?Q?je2iQ+h3RnSbkZoIENSHo2Q8xGPSn9v7REV+NNZdRMu8lWcVA7uAMRH0TvBv?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 769d3783-915e-4150-57ea-08dbefe488cf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 07:35:03.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyD2jp0/oXd2bZg8RiiSLjKGqniHjY+gIrpYisbnFHAgxwe9+yBNZBfkQ1IEMTdM441T8Hi7YnovDndVfzzNdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_drivers/char/tpm/tpm-buf.c:#tpm_buf_reset" on:

commit: 5581fa1c8fc5f0ecf4a5635fcc2a46d9bfdf3748 ("tpm: Store the length of the tpm_buf data separately.")
git://git.kernel.org/cgit/linux/kernel/git/jarkko/linux-tpmdd.git tpm_buf-v4

in testcase: stress-ng
version: stress-ng-x86_64-0.15.04-1_20231112
with following parameters:

	nr_threads: 100%
	testtime: 60s
	sc_pid_max: 4194304
	class: scheduler
	test: hrtimers
	cpufreq_governor: performance



compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311272244.dc5dae8e-oliver.sang@intel.com


[   12.301011][    T1] ------------[ cut here ]------------
[   12.303782][  T504] tsc: Refined TSC clocksource calibration: 3092.733 MHz
[ 12.306311][ T1] WARNING: CPU: 48 PID: 1 at drivers/char/tpm/tpm-buf.c:39 tpm_buf_reset (drivers/char/tpm/tpm-buf.c:39) 
[   12.313193][  T504] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2c9476b3f97, max_idle_ns: 440795271218 ns
[   12.322271][    T1] Modules linked in:
[   12.336676][    T1] CPU: 48 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1-00347-g5581fa1c8fc5 #1
[   12.345349][    T1] Hardware name: Inspur NF5180M6/NF5180M6, BIOS 06.00.04 04/12/2022
[ 12.353157][ T1] RIP: 0010:tpm_buf_reset (drivers/char/tpm/tpm-buf.c:39) 
[ 12.358197][ T1] Code: fe c1 00 75 25 48 b9 00 00 00 00 0a 00 00 00 66 c1 c6 08 0f ca 48 89 0f 66 89 30 c7 40 02 00 00 00 0a 89 50 06 c3 cc cc cc cc <0f> 0b eb d7 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00
All code
========
   0:	fe c1                	inc    %cl
   2:	00 75 25             	add    %dh,0x25(%rbp)
   5:	48 b9 00 00 00 00 0a 	movabs $0xa00000000,%rcx
   c:	00 00 00 
   f:	66 c1 c6 08          	rol    $0x8,%si
  13:	0f ca                	bswap  %edx
  15:	48 89 0f             	mov    %rcx,(%rdi)
  18:	66 89 30             	mov    %si,(%rax)
  1b:	c7 40 02 00 00 00 0a 	movl   $0xa000000,0x2(%rax)
  22:	89 50 06             	mov    %edx,0x6(%rax)
  25:	c3                   	retq   
  26:	cc                   	int3   
  27:	cc                   	int3   
  28:	cc                   	int3   
  29:	cc                   	int3   
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	eb d7                	jmp    0x5
  2e:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  35:	00 00 00 00 
  39:	66                   	data16
  3a:	66                   	data16
  3b:	2e                   	cs
  3c:	0f                   	.byte 0xf
  3d:	1f                   	(bad)  
  3e:	84 00                	test   %al,(%rax)

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	eb d7                	jmp    0xffffffffffffffdb
   4:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
   b:	00 00 00 00 
   f:	66                   	data16
  10:	66                   	data16
  11:	2e                   	cs
  12:	0f                   	.byte 0xf
  13:	1f                   	(bad)  
  14:	84 00                	test   %al,(%rax)
[   12.377595][    T1] RSP: 0000:ffa00000001cba70 EFLAGS: 00010297
[   12.383495][    T1] RAX: ff1100010d559000 RBX: 0000000000000000 RCX: 0000000000007fff
[   12.391303][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffa00000001cbab0
[   12.399113][    T1] RBP: ffa00000001cbab0 R08: 0000000000000001 R09: ff11003fc2e32a20
[   12.406920][    T1] R10: 0000000000000000 R11: ff11003fc2e2ca64 R12: 0000000000000000
[   12.414727][    T1] R13: ff11002087beaf80 R14: 0000000000000000 R15: 0000000000000020
[   12.422535][    T1] FS:  0000000000000000(0000) GS:ff11003fc2e00000(0000) knlGS:0000000000000000
[   12.431295][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.437717][    T1] CR2: 0000000000000000 CR3: 000000407ea18001 CR4: 0000000000771ef0
[   12.445526][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   12.453333][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   12.461140][    T1] PKRU: 55555554
[   12.464540][    T1] Call Trace:
[   12.467679][    T1]  <TASK>
[ 12.470471][ T1] ? tpm_buf_reset (drivers/char/tpm/tpm-buf.c:39) 
[ 12.474906][ T1] ? __warn (kernel/panic.c:677) 
[ 12.478825][ T1] ? tpm_buf_reset (drivers/char/tpm/tpm-buf.c:39) 
[ 12.483260][ T1] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 12.487609][ T1] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 12.491786][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 12.496308][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 12.501177][ T1] ? tpm_buf_reset (drivers/char/tpm/tpm-buf.c:39) 
[ 12.505609][ T1] tpm_buf_init (drivers/char/tpm/tpm-buf.c:25) 
[ 12.509789][ T1] tpm2_get_random (drivers/char/tpm/tpm2-cmd.c:302) 
[ 12.514308][ T1] tpm_get_random (drivers/char/tpm/tpm-interface.c:442) 
[ 12.518658][ T1] add_early_randomness (drivers/char/hw_random/core.c:196 drivers/char/hw_random/core.c:69) 
[ 12.523526][ T1] hwrng_register (drivers/char/hw_random/core.c:586) 
[ 12.528047][ T1] tpm_chip_register (drivers/char/tpm/tpm-chip.c:549 drivers/char/tpm/tpm-chip.c:630 drivers/char/tpm/tpm-chip.c:616) 
[ 12.532830][ T1] tpm_tis_core_init (drivers/char/tpm/tpm_tis_core.c:1293) 
[ 12.537612][ T1] tpm_tis_plat_probe (drivers/char/tpm/tpm_tis.c:338) 
[ 12.542394][ T1] platform_probe (drivers/base/platform.c:1404) 
[ 12.546741][ T1] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658) 
[ 12.551093][ T1] ? __pfx___driver_attach (drivers/base/dd.c:1157) 
[ 12.556217][ T1] __driver_probe_device (drivers/base/dd.c:800) 
[ 12.561258][ T1] driver_probe_device (drivers/base/dd.c:830) 
[ 12.566041][ T1] __driver_attach (drivers/base/dd.c:1217) 
[ 12.570564][ T1] bus_for_each_dev (drivers/base/bus.c:368) 
[ 12.575085][ T1] bus_add_driver (drivers/base/bus.c:673) 
[ 12.579608][ T1] driver_register (drivers/base/driver.c:246) 
[ 12.584128][ T1] ? __pfx_init_tis (drivers/char/tpm/tpm_tis.c:391) 
[ 12.588651][ T1] init_tis (drivers/char/tpm/tpm_tis.c:399) 
[ 12.592571][ T1] ? __pfx_init_tis (drivers/char/tpm/tpm_tis.c:391) 
[ 12.597089][ T1] do_one_initcall (init/main.c:1236) 
[ 12.601613][ T1] do_initcalls (init/main.c:1297 init/main.c:1314) 
[ 12.605877][ T1] kernel_init_freeable (init/main.c:1555) 
[ 12.610916][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 12.615697][ T1] kernel_init (init/main.c:1443) 
[ 12.619874][ T1] ret_from_fork (arch/x86/kernel/process.c:147) 
[ 12.624136][ T1] ? __pfx_kernel_init (init/main.c:1433) 
[ 12.628919][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250) 
[   12.633526][    T1]  </TASK>
[   12.636406][    T1] ---[ end trace 0000000000000000 ]---
[   12.641784][  T504] clocksource: Switched to clocksource tsc


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231127/202311272244.dc5dae8e-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

