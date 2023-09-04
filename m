Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACAA790F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 02:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349864AbjIDAzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 20:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjIDAzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 20:55:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCCE90
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 17:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693788942; x=1725324942;
  h=date:from:to:cc:subject:message-id:reply-to:mime-version;
  bh=EGp11xotKVGFnlCPuUwr12/m3HCfXLocR8HCBFQYwyQ=;
  b=dWou9Sy2ug0l935m/o4zHQN8mUcOj9/w17Z47fNK4C6TrdUmLttc+jVi
   8LRaAAEmjVWpyTS3hZMHLB7WMx9Ug3+0C5wb+U9OS9u/L7E4hO3OeJ3eP
   IG2HDeReJ1DQmaMfa0z7U+LJ2BP+9E+BdfS9qi9bEYa0sedB+DQaI3gl2
   Be9+kJlYTmOwBgn0DzyFWXiPK5bA6DJaWDB6zeLvETtErIYtbCAodmGKz
   oBNhZHy8DTBmH04ktZUDQ38c103Igfa7wFt0bTbDbNeOdYWGxHLAi97eu
   kerj+1GY8fwzrcUHBlHGN71hgi0mzntof1MYp3+QYrUrTSXx7ug6300zi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="442890554"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="gz'50?scan'50,208,50";a="442890554"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 17:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="717392540"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="gz'50?scan'50,208,50";a="717392540"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2023 17:55:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 17:55:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 17:55:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 3 Sep 2023 17:55:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 3 Sep 2023 17:55:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr6tOs1QvriqC8Inj6qdcHAlJym9bFWY4O+shaaBxtd3OT51Y5Yv0XtBOSkqnFl/D7LgP1MlB+OCVJVD7Mgy+qF6YbAeKzlLyy7bIy1/k4JYn3dOK9VXme7hyF1DSGQJoXIi2AjoBilUZL+L7qBOBUU9gmuot+ShYLVeBtxSR6jNxKfoGmsUgz2dcU5CHW7dIpXtABHw67I+15rEt0l//itQBH4OLRlVAeMJ2J3y7znWPYeA3c325giX0NNO6AnRGitbtFAXufCDo7JkbMwmu5wFFTaDhq7VhVrgq+GCZYxPpDxBpWHjylieaaZc6B/0OaSCVbxNvEAqySMi24aQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2grBdr2E9K4DVIA6cN7GhUSXSWMvRiwsB/2J3kSaEU=;
 b=SRGUkxnBNJkPtG6XPrah0k81FETGNesKtDOnQmeP4thJtXBUxeSG2mdPoy1rPLSUzpvcI/bep16jP200M3z5nwgYkyLuBCk5iGoHJPlOR0QJ4J3LSupB32Zm0GnUq2/ih1voK7FwMJFPJyq6ph3PlFOzTPE6R9bRcABc9hgMrEY8XsnBwqZHyVqyQXCW41Mh80PftJtYMWax788hubQHfuqBg386DkBKtcaKzlYk2nmykIMyZEYmFsiWk1W1iFNQLzNaY+S1+BE0rye6/R6u0y757pFVSDZPrIQeslhIc7jIDMNCRke8ncoN8Dm/B+v5Qmb+F+vxFvVuGpxCzr1Ohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
 by PH7PR11MB8550.namprd11.prod.outlook.com (2603:10b6:510:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 00:55:37 +0000
Received: from SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7633:b736:1e61:890e]) by SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7633:b736:1e61:890e%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 00:55:37 +0000
Date:   Mon, 4 Sep 2023 08:55:27 +0800
From:   kernel test robot <philip.li@intel.com>
To:     David Hildenbrand <david@redhat.com>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: kernel/fork.c:1181: warning: Function parameter or member 'mm' not
 described in 'replace_mm_exe_file'
Message-ID: <ZPUq/wZqDBrUvoLe@rli9-mobl>
Reply-To: kernel test robot <lkp@intel.com>
Content-Type: multipart/mixed; boundary="LlDm40wDC7FLpgv8"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3006:EE_|PH7PR11MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fe9e76-79d2-4c9c-b318-08dbace1a6e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWVcmSjrO4l2dfzEpXPfiy9hCE2hagzBg/U5DlQNe4R/pg0M9S1bCzxd7p0YfwmP8hh1BF8rtj7/+eh5Nn0wHcS+IT+40cCZlokJg3/biu9TNzGt0/FPbFUwsZ9nU+F3zeBl+rLig4SIOajcqAh4uTdoYYaz51BVCgmrcff91Xo0E5jTQjVg7GJ6DwwI+6G6L2u+BgHxNm86+Jsbex8pTY/INSPQ9kpEGHzmjFytTEN1t5AQ3Efp/pT0jXqGPxOyFjPFnvxE/ME01wMXHaTwjnFLD99l5Uifk1QaW3//Vqw0rwKcwSjFwYfM/evXwYHMIeSY4VzcaNfN3VJWguswQHzg05z2s3wJF/icKYASe7zpOjFY5yNwqT1ExiXXAhwl8fwa8STjpd8IhPHup0ngMuKfEcfM/aZxXxHNhSNq7ppttnGXwPcSrSsyTpruvljVXomeInPEKb+nx3VWPUtJftCHabpsX3iDv7iouA8uCcH+2cMgv5JGGV1OfLzMC6XaVii2gEVp3kxbiTcUmadXbuZFluPUnAHBhkEoWvvXrh74mjYo56iBrDTG5wSN8IcswEF8pbYGwMbzPA41TYPiSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(396003)(346002)(376002)(1800799009)(451199024)(186009)(8936002)(8676002)(5660300002)(316002)(6916009)(66476007)(66946007)(2906002)(66556008)(4326008)(66899024)(235185007)(41300700001)(44144004)(6486002)(6506007)(26005)(9686003)(6512007)(38100700002)(33716001)(6666004)(82960400001)(478600001)(966005)(83380400001)(86362001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PZ+KRzVevCMzd/NK4G3BpdnKRSFQTE/qLd9HDj3O3C6kGlBYogWc5IFLEWHf?=
 =?us-ascii?Q?lcXDImv6/PfEGm/5BiPlW7PmtYlB9h5Kj1eD/5yjiGf9uMs56yla1lgfkQky?=
 =?us-ascii?Q?eTRxDr2JMWflbDjJlCadfION+Elgbdm1cRlTVlGRvR0w5MbVeFmFW+9RfS9v?=
 =?us-ascii?Q?XnGzVL2Ym/wIgJJBkfHuyZUn42KXmDTO+KNGNO1AZXB7D/C6y0D3M3UE8UrK?=
 =?us-ascii?Q?tqbAJnoLWbHbz4yx1GAEogQ2egsDjm/tcGm2vSsc0SJz7fzDHMCxpEbO6/UA?=
 =?us-ascii?Q?COxhaHBlVn+cOy9PH0W5DM2iTZiUWCdnsKXgPuJYmd3aDZ9YGWvMAWxr4R0/?=
 =?us-ascii?Q?LUZ3DkfI/MCKTbcwda6x3elHgc2X6jRCiYTwjrvcCRWXFjY/2eRQrzxwXnr0?=
 =?us-ascii?Q?YUS30SyUAwabzK4YDCBQcsM/KusADVLuSFP1IYumQjqK0sRHFK7/y8zpUkm/?=
 =?us-ascii?Q?9hVzQJo4dOF4T1HcD4fWZPy8hdb82vAC9ZnjT6JOFDLpdR4Q19ohKMxtmw/j?=
 =?us-ascii?Q?eWvh5ZNCYSIdvBAEGgRt/UGzXU09nHH5YaY6/LOPLuzi2rqf5ieOYOjZ2yFZ?=
 =?us-ascii?Q?XvxMWAc410+m2zKDM9g3hB1HXamD89IqXO/PUvcAIDLbxchNXh2zo/jWqOxy?=
 =?us-ascii?Q?PfNJCWyuWMhEjQhU/2rXZpz+tQlZG15gCG6Ljgbd+9okJGvQZ7but+8cp1/g?=
 =?us-ascii?Q?iQ2+cXXVDTJERCiJgI168KNlfIfVJiR7hcRpPgjIUGeXUs8hknHcjdu3lHbT?=
 =?us-ascii?Q?v980AdFxh1SUQoG2/kZprUiriAXyEQfTQAwwtj8kah/YfGK7jzAEnyb+HOxy?=
 =?us-ascii?Q?e4fvt23LnLTB2sNQaLTmSFi4I3is1wu7cNbPe6Ab3srqRUAB3jMRELqnDBp4?=
 =?us-ascii?Q?pGoS0xQgEmI0iQuoWcnlh+oluxzBrjvX79/LpVL17Vqn3wlHRz/jp/l8R3zx?=
 =?us-ascii?Q?6Rh39jkdtfXdqK+pMcGapehkDtax9tFzC6VC5DF69eoKzQiqir+dVtcAK/kc?=
 =?us-ascii?Q?Aky9kRirG5Y9jzDficANzp+xTU6K5umiI2kJGYyktvbScKPplTgslw5ktlUn?=
 =?us-ascii?Q?KbaNQwGZGzUjD3TMo+om/TQVyMYvmfRNqdgoy5sM4dPG7bCOWKFJqgXsxui1?=
 =?us-ascii?Q?los6U0tXdgUOzQ5ABzTkkb3PUMBy/oPQ0v3EN7ek5+nZxUyL9y0UEkpg6t0J?=
 =?us-ascii?Q?cwcMnHdB+RokIKEw+1YWhtAEexUMvhrzS8tqxWxx74riK/Q3tA4qg2ozVnT2?=
 =?us-ascii?Q?TlQUsC9UcVHQuD5DmgEdLDdiLhaow/CE1UyRGeW6up+5zI0CGaeCKC++hyBu?=
 =?us-ascii?Q?ijQTC3VBrC8kTwEP7cacMyCiG/S3l1Ycylw57LnqvGxHlo85LPr8NZuNqpx5?=
 =?us-ascii?Q?hcURTepMPArnr2lrsj+EHyJ9FRPUexU+IaZLSi1hTfQ7N2p2iW+mqpajbtSQ?=
 =?us-ascii?Q?jZndc70l9iBts1cDGEM7p+UmENt7iP61WQGAxZIBFb1g/DkpGFQTJhfprif1?=
 =?us-ascii?Q?Z+mdvbyTFw/uJjXMY9vQ/quwSZDFBouoDp/zZoeHK8j+HzsYVZpW2/D3+yG/?=
 =?us-ascii?Q?ygvjZZ8DHOEFjQ5lTHSTgIZ5KhH07QYfX2WmbKlY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fe9e76-79d2-4c9c-b318-08dbace1a6e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 00:55:37.3191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHhrP/IPq75TdtDt6EyrDDOHZfYJKujKLfbYUKPCD7urWSVKSKgCHQMVVHB/50hCuiBI8xvv6gOxN/Q7fEGr5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8550
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

--LlDm40wDC7FLpgv8
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   708283abf896dd4853e673cc8cba70acaf9bf4ea
commit: 35d7bdc86031a2c1ae05ac27dfa93b2acdcbaecc kernel/fork: factor out replacing the current MM exe_file
date:   2 years ago
:::::: branch date: 5 hours ago
:::::: commit date: 2 years ago
config: i386-allnoconfig (attached as .config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (attached as reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309040758.TJlCtQvv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/fork.c:1154: warning: Function parameter or member 'mm' not described in 'set_mm_exe_file'
   kernel/fork.c:1154: warning: Function parameter or member 'new_exe_file' not described in 'set_mm_exe_file'
>> kernel/fork.c:1181: warning: Function parameter or member 'mm' not described in 'replace_mm_exe_file'
>> kernel/fork.c:1181: warning: Function parameter or member 'new_exe_file' not described in 'replace_mm_exe_file'
   kernel/fork.c:1218: warning: Function parameter or member 'mm' not described in 'get_mm_exe_file'
   kernel/fork.c:1238: warning: Function parameter or member 'task' not described in 'get_task_exe_file'
   kernel/fork.c:1263: warning: Function parameter or member 'task' not described in 'get_task_mm'
   kernel/fork.c:2807: warning: expecting prototype for clone3(). Prototype was for sys_clone3() instead


vim +1181 kernel/fork.c

3864601387cf419 Jiri Slaby        2011-05-26  1170  
35d7bdc86031a2c David Hildenbrand 2021-04-23  1171  /**
35d7bdc86031a2c David Hildenbrand 2021-04-23  1172   * replace_mm_exe_file - replace a reference to the mm's executable file
35d7bdc86031a2c David Hildenbrand 2021-04-23  1173   *
35d7bdc86031a2c David Hildenbrand 2021-04-23  1174   * This changes mm's executable file (shown as symlink /proc/[pid]/exe),
35d7bdc86031a2c David Hildenbrand 2021-04-23  1175   * dealing with concurrent invocation and without grabbing the mmap lock in
35d7bdc86031a2c David Hildenbrand 2021-04-23  1176   * write mode.
35d7bdc86031a2c David Hildenbrand 2021-04-23  1177   *
35d7bdc86031a2c David Hildenbrand 2021-04-23  1178   * Main user is sys_prctl(PR_SET_MM_MAP/EXE_FILE).
35d7bdc86031a2c David Hildenbrand 2021-04-23  1179   */
35d7bdc86031a2c David Hildenbrand 2021-04-23  1180  int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
35d7bdc86031a2c David Hildenbrand 2021-04-23 @1181  {
35d7bdc86031a2c David Hildenbrand 2021-04-23  1182  	struct vm_area_struct *vma;
35d7bdc86031a2c David Hildenbrand 2021-04-23  1183  	struct file *old_exe_file;
35d7bdc86031a2c David Hildenbrand 2021-04-23  1184  	int ret = 0;
35d7bdc86031a2c David Hildenbrand 2021-04-23  1185  
35d7bdc86031a2c David Hildenbrand 2021-04-23  1186  	/* Forbid mm->exe_file change if old file still mapped. */
35d7bdc86031a2c David Hildenbrand 2021-04-23  1187  	old_exe_file = get_mm_exe_file(mm);
35d7bdc86031a2c David Hildenbrand 2021-04-23  1188  	if (old_exe_file) {
35d7bdc86031a2c David Hildenbrand 2021-04-23  1189  		mmap_read_lock(mm);
35d7bdc86031a2c David Hildenbrand 2021-04-23  1190  		for (vma = mm->mmap; vma && !ret; vma = vma->vm_next) {
35d7bdc86031a2c David Hildenbrand 2021-04-23  1191  			if (!vma->vm_file)
35d7bdc86031a2c David Hildenbrand 2021-04-23  1192  				continue;
35d7bdc86031a2c David Hildenbrand 2021-04-23  1193  			if (path_equal(&vma->vm_file->f_path,
35d7bdc86031a2c David Hildenbrand 2021-04-23  1194  				       &old_exe_file->f_path))
35d7bdc86031a2c David Hildenbrand 2021-04-23  1195  				ret = -EBUSY;
35d7bdc86031a2c David Hildenbrand 2021-04-23  1196  		}
35d7bdc86031a2c David Hildenbrand 2021-04-23  1197  		mmap_read_unlock(mm);
35d7bdc86031a2c David Hildenbrand 2021-04-23  1198  		fput(old_exe_file);
35d7bdc86031a2c David Hildenbrand 2021-04-23  1199  		if (ret)
35d7bdc86031a2c David Hildenbrand 2021-04-23  1200  			return ret;
35d7bdc86031a2c David Hildenbrand 2021-04-23  1201  	}
35d7bdc86031a2c David Hildenbrand 2021-04-23  1202  
35d7bdc86031a2c David Hildenbrand 2021-04-23  1203  	/* set the new file, lockless */
35d7bdc86031a2c David Hildenbrand 2021-04-23  1204  	get_file(new_exe_file);
35d7bdc86031a2c David Hildenbrand 2021-04-23  1205  	old_exe_file = xchg(&mm->exe_file, new_exe_file);
35d7bdc86031a2c David Hildenbrand 2021-04-23  1206  	if (old_exe_file)
35d7bdc86031a2c David Hildenbrand 2021-04-23  1207  		fput(old_exe_file);
35d7bdc86031a2c David Hildenbrand 2021-04-23  1208  	return 0;
35d7bdc86031a2c David Hildenbrand 2021-04-23  1209  }
35d7bdc86031a2c David Hildenbrand 2021-04-23  1210  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--LlDm40wDC7FLpgv8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--LlDm40wDC7FLpgv8
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=35d7bdc86031a2c1ae05ac27dfa93b2acdcbaecc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 35d7bdc86031a2c1ae05ac27dfa93b2acdcbaecc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

--LlDm40wDC7FLpgv8--
