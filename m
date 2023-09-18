Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58057A43CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbjIRIDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbjIRIDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:03:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E139691
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695024156; x=1726560156;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=TyU99xvkXL7C31FDBKtLPW1JGPFYFnkxVIlNURVEAAg=;
  b=Z7uG1QCZIZVSn+ULwAdizEmgf0Y1BI/PvXgL6OpPM7ijzfz+i023UEwY
   iEIYeqLi2M9Y3OJ64uJIUbfwt/GUvvc4SywDkKI/+JBPwz+BXUEDfqXqK
   g7VGmg4Gqdn64MXQJfdXICnoqdvvuiH4vyeLVHO9kxvOF/wwkPDOuSmLc
   wxxVtcnSFa+gk41OgNe7z4aQYGxF015uK2ekjtTTK6y3jM6NwyDJypiBq
   2Sn+1rwgEFT5H4E65XIx+VBV/uRVC5WA+A22yu2Le6Wq3104987mQllOM
   gMlWZRkOETPRsASXeC0Rpuhr2qPt/lJ5JRNUdJzgOOLkn2zh9xIAMdau8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="465936912"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="465936912"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:52:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="888934109"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="888934109"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 00:51:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 00:52:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 00:52:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 00:52:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 00:52:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enk/SAFjLwOhT6KFMoJkWroVpy1AX6NAXyFTnAqLOMNBBeW1wQ4TEzomizzQ+cHgyWJtGXlbLW1mTg/y98tRtfraAySDu05OcWZOHEICq5Z3bECGE5gmF/zyep6QA4tZ9y5a2tkghKQH96oDr2qKqS+aqsSdnxqX0os7Vo6yXK2hB64gevMRCL1DPYVV5X6Fn+o5A5GyWmj9ETaha7Fuj+VudKX8HSAPi6UeafN6FkM9nrXsIb67bXOGmEFlOvMx5YMYqU6jR/bPwwV1C80Lg9fvkwUxSKcOASUvZWQ1e83WoFXt1lUxYECaPCaq5ohOW4h328UjHuogZecWV20d0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVV+CKRyC/m9K5w+X3dlRDnqXYauvEcgHe2XxfFuVdg=;
 b=G0nwBxdSAjlKeT52YDccRFoH14hf1w3fK9e7WAgIDYdVf8UrYXHvS/spHTkvZOudb4dYb97X/KEBrjZxVZArBafiLenOW0BhEQqGHqSPhHKpvYeb+fdFaAb1KDJIxYc9pZwXSVpJYmoAmdvNlPP6ZXCtAq+RBb7AJM0J3HpGwjJpWOaza3L79LQDQLydXA4LBCdzIv8wC9nNJTUxhSaTNvKhH+18uNO4Iq9q9vjqvajwU0RHrTSqkkpjA9E4ZG2QFdw+LOYcnjR5SJXKPPX+bEsvHc7Wn3m23o6grOcK0Wp1UV6HEcgjGq1jCF7undYJz1RWLo4hQzAligJ7+BW6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO6PR11MB5619.namprd11.prod.outlook.com (2603:10b6:5:358::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 07:52:16 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 07:52:16 +0000
Date:   Mon, 18 Sep 2023 15:52:06 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Will Deacon" <will@kernel.org>, Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3] locking/mutex: remove redundant argument from
 __mutex_lock_common()
Message-ID: <202309181501.b44a0030-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <13334f7016362b2031eb65b03cb1a49b6500957f.1694548262.git.mirq-linux@rere.qmqm.pl>
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO6PR11MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cc18e4-1b17-4b22-573a-08dbb81c2d43
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pt3sBM11xFdL2h4LJShwnHHOdZYZ04RvixpxFraRTZUTDcqbCEdtR0eUXKVXsMn7i9eab2DBmcpQCtTvB+Eea4GzTZMoqalRzhyQ4s7L5LvYbhEWBiDmYrogdQi0kXBfgMI+eR/yLUC/AdrpVkLCaeCemLotcDx/8jthzSGEwz0uJxHAh0b1Uwg0JYZ/9uSGzxn0wIzl24ll+xIulySv/4+r4rA6usvxN98JGgOtLxoytpLneDy2DZu6kpeWh9cqwVHS/F0DVBMnWBY9EPK/YLzyrmUgKIdE5u98taMIGpz/13bajk4YOdS4G/sfv0B9dndw2guRd+9oswnVLQ0wGNnqhLRLaCo5Kgo/SQbyIpfkE8NcPGLsC94PHVymXw1uBo3LvZMPHYXE07j9zaPpeYzRopJDGmOFPKb0Hs7MkuFhQQV1aItCQtfFEjoM1eDtWb9XxwPOYzBBoUQSlnXdDUqSLTW2Qs6c9meBxchsZxbyIVIV2ugSB/T1DvyGo/6rHEST6OyCMjYoNgk8iR/M1kGVMynFftkcEMBCL0hLX+N1AmFVE0jzaWjRifjBrZ70dh/OCi4t1jf+Ls3nu0+V4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(186009)(1800799009)(451199024)(8676002)(8936002)(316002)(6916009)(41300700001)(26005)(1076003)(2906002)(478600001)(966005)(4326008)(66556008)(66476007)(66946007)(54906003)(5660300002)(6486002)(6506007)(6512007)(36756003)(107886003)(2616005)(83380400001)(6666004)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHMfGLcHI88oH1ZvIu2Z7ouXILQJKMz00l1xZyCbtQPq3nRsYMRucITeCHFc?=
 =?us-ascii?Q?MNePimyoW1xyJbxvQwJnMhbbe7LJYtP4WUFgPTPpCqFm3ZIc/QXmsiu4D9kU?=
 =?us-ascii?Q?L/11Yw0nAMvUpar/icMp184kpD88COzKycL0IpeVkSF1dEBKpjmU3i073FG4?=
 =?us-ascii?Q?KCkdnVacDcj7OtVhgHxTxy3FOdFvAkYkvLLbQ/9/sBFgmq+zS7EOyEzNBZnj?=
 =?us-ascii?Q?1j3thxWnMzp3ItmEyhm0r91CM6Wp1BUXVwcnct5/VRnWR6c+IuloWQKHB0g3?=
 =?us-ascii?Q?qzimpccl6rZBU/fVja46Fhv7WRQco3AG/oJpEcs0Mp58/6reYlN9DBmyDq1r?=
 =?us-ascii?Q?9hu6GzF45gAl+lxqMEGBacg/zhZ8KgNvLCQQjfLMWPQLY0n4AWDI8r/rg3fc?=
 =?us-ascii?Q?CCTecGJeLWBGoUqy3NvczNcqeIPR/l93cOLh34MjtqOFFk8vqPVf/lUglgVU?=
 =?us-ascii?Q?rxNEz/dZx/bKBrhJqrCqNwv+HcGd7rD2pdxouaaOCC1jJbSyfzTkq5xYEKcc?=
 =?us-ascii?Q?J9yk65NSDQvVaryXSD3lZ8I0uKQn44ev4A08m5hjesQTSjFYtejVaHvbOZFM?=
 =?us-ascii?Q?Wt28KGd9RaVmgRq3tjDnBvX7Deedl1ZDL7+EahjTLz3sIxVmpzq3JNlegezw?=
 =?us-ascii?Q?2PvbSIw8+M0tigFXwVgPAOVfkmfkMmyxRsMXWRrRdK+W4mbrGZCerdRPCcC4?=
 =?us-ascii?Q?XS/LmNiQko9QVGCD5SkO1JZNXQedcm/bqnUP+b9si56uJUFnOAJipdTJeF/8?=
 =?us-ascii?Q?n6Y5nz16kPoHlC+DpPx2clySQriq5e+6J6bzrbBIbwonS4wMeZLLA13/zhI0?=
 =?us-ascii?Q?aNZB2x5Mdtl44Eln6tkqTtFBqjVZKd45ERgwZWniBRDDFQMB/HU7CHFz4xzR?=
 =?us-ascii?Q?+KfCKDHjc+oYlMP3z/XPButWm0jBc2cE37Us02Uli4bn2qPXwlfGS8VSygMM?=
 =?us-ascii?Q?Kpaxv0/8j9O6sTCcASgMnQQJBU7vORvzyn7rslrMLCSMLfICY2t5K8MAmvcH?=
 =?us-ascii?Q?+jsyvx8fFjEmSdeL33Bex4BJq/HdDgKRjOiH/48efZXvnNCkP3gPGrdIJNe7?=
 =?us-ascii?Q?1wLzgwlrWxfw+skubphLCSK35QLkZ9wxFmiq6xkAxLc96pMtVDTOeNhpuRCH?=
 =?us-ascii?Q?6sKcsqUW2pYmSzejiJ6HpyZDzdKSkvmUu46RQeMNtWebrcFpkp/rU3r58a4G?=
 =?us-ascii?Q?TcO9wKHVVHiz6fWFAaqOtOz4bbQV6TUBBeBarba+dlQbq4tFqqEKQ5saS+xI?=
 =?us-ascii?Q?oTYoDGxPm9eIfESjnbmpxjfljG/2hR2NZu73BGSQLzzIZwU+ihNZ9VvMJJ9h?=
 =?us-ascii?Q?yE+9RFLAVAfD9aJTAaXZsgaRH1vYYBw/omIv5vI/CiAH6to5978OC9gf2Nlw?=
 =?us-ascii?Q?DrJBVi/qkHh8gO9deIvwI75IKbG4ZGnQjcwwRzwbWB5BptwafFKZUCnixufM?=
 =?us-ascii?Q?nzYm6yBaWa+XOXv/1sPdK7/QAuVZuyMbh5++trCJrPd+/GhfLyCmj5wOMA1m?=
 =?us-ascii?Q?Zkvvf5FrIMwNfccr+S1/r+8MkPBK2sTadFxxFRPaLk+gO+eyObr2RO7mi382?=
 =?us-ascii?Q?A6QIVRy2Y3CEwP0XqsdT3HMD8yiAsUvVkEN4FlZN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cc18e4-1b17-4b22-573a-08dbb81c2d43
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 07:52:16.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6oKv6FjP93aERNX5TAPDkxVWeps55BOJwdw0Fz9UEiTTC5R2ZQCBE6GQ7ViCSQt4QtZXSeDcSnUMsMxsdFXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5619
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "canonical_address#:#[##]" on:

commit: e51feab54b4cf9e46f5f1c70a95bd783d71bea17 ("[PATCH v3] locking/mutex: remove redundant argument from __mutex_lock_common()")
url: https://github.com/intel-lab-lkp/linux/commits/Micha-Miros-aw/locking-mutex-remove-redundant-argument-from-__mutex_lock_common/20230913-040021
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 68373ebb9d61985e05574313a356f751ef9911ab
patch link: https://lore.kernel.org/all/13334f7016362b2031eb65b03cb1a49b6500957f.1694548262.git.mirq-linux@rere.qmqm.pl/
patch subject: [PATCH v3] locking/mutex: remove redundant argument from __mutex_lock_common()

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309181501.b44a0030-oliver.sang@intel.com


[   32.125787][    T1] AVX2 or AES-NI instructions are not detected.
[   32.126826][    T1] AVX or AES-NI instructions are not detected.
[   32.127952][    T1] AVX2 or AES-NI instructions are not detected.
[   32.131287][    T1] AVX512/GFNI instructions are not detected.
[   32.132975][    T1] Beginning ww mutex selftests
[   36.707495][   T37] general protection fault, probably for non-canonical address 0xfbd59c00000000a2: 0000 [#1] SMP KASAN PTI
[   36.708950][   T37] KASAN: maybe wild-memory-access in range [0xdead000000000510-0xdead000000000517]
[   36.708950][   T37] CPU: 0 PID: 37 Comm: kworker/u4:2 Not tainted 6.5.0-rc3-00003-ge51feab54b4c #1 d00dc367a39745ce3f654e553e9329c6c6efc292
[   36.708950][   T37] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   36.708950][   T37] Workqueue: test-ww_mutex stress_inorder_work
[ 36.708950][ T37] RIP: 0010:__ww_mutex_check_waiters (mutex.c:?) 
[ 36.708950][ T37] Code: 01 38 d0 7c 08 84 d2 0f 85 45 01 00 00 66 41 83 7f 16 00 74 45 48 b8 00 00 00 00 00 fc ff df 48 8d 7e 10 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 30 01 00 00 8b 4e 10 85 c9 75
All code
========
   0:	01 38                	add    %edi,(%rax)
   2:	d0 7c 08 84          	sarb   -0x7c(%rax,%rcx,1)
   6:	d2 0f                	rorb   %cl,(%rdi)
   8:	85 45 01             	test   %eax,0x1(%rbp)
   b:	00 00                	add    %al,(%rax)
   d:	66 41 83 7f 16 00    	cmpw   $0x0,0x16(%r15)
  13:	74 45                	je     0x5a
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df 
  1f:	48 8d 7e 10          	lea    0x10(%rsi),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax		<-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e 30 01 00 00    	jle    0x16a
  3a:	8b 4e 10             	mov    0x10(%rsi),%ecx
  3d:	85 c9                	test   %ecx,%ecx
  3f:	75                   	.byte 0x75

Code starting with the faulting instruction
===========================================
   0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   4:	84 c0                	test   %al,%al
   6:	74 08                	je     0x10
   8:	3c 03                	cmp    $0x3,%al
   a:	0f 8e 30 01 00 00    	jle    0x140
  10:	8b 4e 10             	mov    0x10(%rsi),%ecx
  13:	85 c9                	test   %ecx,%ecx
  15:	75                   	.byte 0x75
[   36.708950][   T37] RSP: 0000:ffff88811273fa38 EFLAGS: 00010a02
[   36.708950][   T37] RAX: dffffc0000000000 RBX: ffff8881108afbf0 RCX: 0000000000000000
[   36.708950][   T37] RDX: 1bd5a000000000a2 RSI: dead000000000500 RDI: dead000000000510
[   36.708950][   T37] RBP: ffff88815a089060 R08: 0000000000000000 R09: 0000000000000000
[   36.708950][   T37] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88815a0890b0
[   36.708950][   T37] R13: ffffed10224e7f90 R14: dffffc0000000000 R15: ffff88811273fc70
[   36.708950][   T37] FS:  0000000000000000(0000) GS:ffff8883af000000(0000) knlGS:0000000000000000
[   36.708950][   T37] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.708950][   T37] CR2: ffff88843ffff000 CR3: 000000000508a000 CR4: 00000000000406f0
[   36.708950][   T37] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   36.708950][   T37] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   36.708950][   T37] Call Trace:
[   36.708950][   T37]  <TASK>
[ 36.708950][ T37] ? die_addr (??:?) 
[ 36.738985][ T37] ? exc_general_protection (??:?) 
[ 36.738985][ T37] ? asm_exc_general_protection (??:?) 
[ 36.738985][ T37] ? __ww_mutex_check_waiters (mutex.c:?) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230918/202309181501.b44a0030-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

