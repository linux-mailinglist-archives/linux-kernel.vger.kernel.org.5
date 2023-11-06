Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BEC7E1835
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjKFAvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFAvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:51:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE731A2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 16:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699231859; x=1730767859;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CikHTYgksEt84QL3kzTwnMMe43Pw+TbTsfyCidbUn2c=;
  b=P/2wjS6AI+D2Cd7H1LABAloUn8NNM3/mGll6ffztz5i01ICy70MRLGJf
   91zyvhnw23UVitHgUjXkKk6yWMBgIYnn+8Nz0VBlYTjY0xwh3bPbQWbB4
   Aat8aAIjwcqcCxBlVPmlTWg/LtzzSm9kmMqg/G9r++gypeIlu0Ow0pjp6
   GYrt4L2r2o1jT7wWcjUPqbl7xi+4mIj8s3bhm0W+vFIAd1yo/fpgJMHT7
   DBwXgXKAD8h/cNL9nMPJ22uc3q1KouAja74CuLSCUso5zWJvDJCptNQr5
   48SeIP1LEbABz3XQaMmhtqnFK/elSL9WxVglOhGj+4zVj+g8+SS+a8/vJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="374220737"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="374220737"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 16:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="935642817"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="935642817"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2023 16:50:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 16:50:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 16:50:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 5 Nov 2023 16:50:57 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 5 Nov 2023 16:50:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTJHp2TIG/bDo5EMH5KHQtK+UYVU1aZLXUoAH/tE7R7X2kBOQMLRy8d6OikjHoX1lDXZfRvK+z9Ntp8DHmp68zv8eMROxFu9UU6hvUrYd4V4w4KRiy8gTd+KtNABv7gaL4BlDCBIkrR/lA3IkliDfQZHbF8OM587MnrEo3DEJ2tdg7VH6/DO9yCSm+e2TOoNYvsZjOCwmYUSlDx8TfScd0eUkxUjWatWSTKARIQ+ngsS8fsJlTlCRCJjnT5pURmjULJ0h1WBRyHA16yUfvd+SZgQXMLT8HIDRjf7qfK3Df7mE7XDlW4geugWGPkadFtAQFMdsvqWrElv2CMcdjcTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0N/TzBnEd1AGzSbM0g61CfsdNMCHQ2yJh72xJL7e1E=;
 b=kxLvknh9YEeBHkXt8H38M7Z9r07mbxA+6Pe/PI0ClZbBRMNtI45dnsr3WpBVNo6hxOIAYl5qHLO2+g/EtYKtugfzTYdzBdO86YE5E6y2n3Ab16ouSABcTEdpQbYcI7JL32Xcx9nlQrpBNfnBVRz4u6PK4GHdXv64VHgK7I2cMajfQSyqFQhKRUwj62xncXcBnSdRtGBp+QKZLVQujkfLrHJmByD0g63lMzuq+R+5DrshcpJY2UTlYWSqtcNCZtTVdYETrtaCvW8DWGUQA6ckph6j118byFhkOhWvu/l3IXXmuw3/EksIG64u8lX0Z6kxMcYSOFkyrLhqWxHmB13RGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
 by DM4PR11MB8228.namprd11.prod.outlook.com (2603:10b6:8:180::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 00:50:49 +0000
Received: from SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7f2d:3448:d474:f74e]) by SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7f2d:3448:d474:f74e%5]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 00:50:48 +0000
Date:   Mon, 6 Nov 2023 08:50:38 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Nathan Chancellor <natechancellor@gmail.com>,
        <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>
Subject: Re: net/ceph/osdmap.c:1246:10: warning: result of comparison of
 constant 4611686018427387891 with expression of type 'u32' (aka 'unsigned
 int') is always false
Message-ID: <ZUg4XjqlRwd/SyPq@rli9-mobl>
References: <202311060731.8P11QmUf-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311060731.8P11QmUf-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3006:EE_|DM4PR11MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaa5c59-ea6b-4f88-3262-08dbde626971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sR58ys+sL2Io+bToSxfpikpBD2BcEiYTilScUw5VQ++RRtOEzdI9sgFtDHGPt4Szy3ZjR3sNXP8fJe2qDqMIOYDjim/dWkijOWOwVTN8B5KWUsE5SlAVBiVUu1OPRfSeC5s/sqEmRWIdDmUiqrhh5G6fzBvJKCx4erMEj0a0m0c0H3m0tGzU7gR4pilzRdLMwOjjonIK3p/7I/C6EPgY97uh8HOlLdiJiHKq7e50EL1gY5N1b2AV+Fi0P9zSTb9l4bUP9VUBu6fjKUAkQn6J5NBKKX4KHSrCKWvUzDq6lKbU/gc7UQq/xN5VfLAAIvMxsFfs+Cmf5iN1U3p69WovIDh7i6o1SSdoTzk3aMNkNwRg7r38VbqQitMV73saE91omNonE9YobuTxBfC+RFHEeA0bmiaaH0q+owPOCV8Le3TngObWBPwY3JK84OhYsfhm+0SynDJ9vo1IuFxopAzEuIspz2Op3mL84EwdDUQOiOPRml6BuA7jFnAkJsny6ViTnIkpqU5nsqsCXOeCV8RDkmK21fVc32l6Pz+OBtbibdL6x+U98++YgAPD75E+uU27K1AaoWGZJbU6km1cjC0jyP24WGt+q+DICCh2ZtNvCWmLjIVR+Z/3nD4A3slQXL1WSlDrDXD/4A4oLevxZeVZvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(1800799009)(451199024)(33716001)(8936002)(83380400001)(8676002)(6862004)(4326008)(26005)(66476007)(66556008)(66946007)(54906003)(316002)(6636002)(5660300002)(2906002)(44832011)(41300700001)(478600001)(9686003)(6512007)(966005)(6486002)(6666004)(6506007)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X6+ueN+MhR2OY0sIsZv3PKb7Wm93ZSyK/IPgQN6mQNeattTG9gu4hvz2spWc?=
 =?us-ascii?Q?vOENXf4X6UWKM0WWUaZUlwyQEG3tEaEmqWcDA8y3bkTI92WzyiBW9De7YPL3?=
 =?us-ascii?Q?pjpp9TDvbp5GW/z/N3hrn26kkE7FVPxc0y64rUJZClI0G4QPJ96fLlkypcEw?=
 =?us-ascii?Q?HkE89iZthowUSO8fOMMKe6zE/5AZuFqNcn4R0FBlmZF69MZpWpyje5FdIjFS?=
 =?us-ascii?Q?P47qJDNy7dEwbETJ+KFydaNb16A93Gx7IQxXoEtqZ/zib7ay2ZWTIgHqUfLh?=
 =?us-ascii?Q?q67DDVt99snhA/Xm/xzp3u5C2gh9UObb18a03Epr37R9/ELkP4k5wRGxg15N?=
 =?us-ascii?Q?4yrxZCku3U4tXXHzzD7LuOL/NFU4jr1eWgKB634DqKnjDTfF/pYyD6WCi6I/?=
 =?us-ascii?Q?+D3+8KcVhYqOY1b+mfnuY4wpeJPzK2pz5kjAmTzZ3kMD/C/9+R/SBcT4wxMK?=
 =?us-ascii?Q?THI31QMDVjNs0o+L9U02y4suDg/Ppe136vaxuVGXpf9PJBqAyEo2GYLSg0nE?=
 =?us-ascii?Q?IaIkQzvnSYLCv+Faa4X0ajz2XACJoklbj8TuB1JCpoGnGDQPNWPxrUuvfO+e?=
 =?us-ascii?Q?z3/a2bPVpXCDPwMQ9WHu7KWXpomPsyLIZHq7Y5+EXAbmJDG4vWvR0B6qNYGb?=
 =?us-ascii?Q?jzkop2OBn9ugalpVte99DDi8GCDOcNnlTar2K827+1Ked5ew54G8ScXJKsfw?=
 =?us-ascii?Q?nyiI08k6eqgNa/CPhj2MZ9n2LJI714fuDBwNvwhOMCFNYw6ppK2kzavFaUOP?=
 =?us-ascii?Q?SYpRzBGjVhjN6XGBrmlzP8q0q/EHUYuoa9EbcNUQ6+AUJGX1emEm+Z/ain+e?=
 =?us-ascii?Q?fYbMTlQwfShULWmxgj3bwHlZJVSYelbvtSKg9cFE8t0eJUGNpXhSM74feVTe?=
 =?us-ascii?Q?zhwijPhiC+GBkr3lasGBX6t5ZL0LEiZjtnRQxp5Ma/EWqtsQ3EZRFBVtgBJ1?=
 =?us-ascii?Q?y3G+lT7NVV3F1yrue8Z4AJ64dCybe5AR0fEOU1Shnf1HUf66Bwdj8FX3kIrJ?=
 =?us-ascii?Q?5q9dXYdhpi6mxrZC1d7MK23Ekelr84GKTLvLsaayZBskzFw9PobO7LUlIFyT?=
 =?us-ascii?Q?Qu6vwdL00WlUpuNrFQE/9CdjUmvnfYC3DD0Dxam7vYUDe4/w33biE3yn/Xt1?=
 =?us-ascii?Q?3nhVxgrW3w/8pfYcV/QLEeroJrZsjrCOoax0DbZKWj+ajAiUSIu31eovkrNF?=
 =?us-ascii?Q?Wy4+V2ti5oJMb0tUqv0MUpaO9d5gJ+ZeUKVJEa2cRsNh9J1DqOvchvMaz//5?=
 =?us-ascii?Q?z57psNfZuigEVvNiaUGQZz+2w4FVmp0/Me7PfpnQAdfFxDYUOXDlErE0WwWO?=
 =?us-ascii?Q?/In6M5SqnEPlssvOPlMwQqu+wiGWntaUDjG2EYTvhlwCvEu+kUwGe0FK/vSJ?=
 =?us-ascii?Q?uui0ptA1rVKaOFm2B7VxJB2ocOcmEf5m2tJsCvtNAeoHz3NHvr34bbXmvj18?=
 =?us-ascii?Q?54rLwR1BKOK6KhgocuTs9QTOIxaBabiHlmANH1z3r7/owRuUgdix9jrUv/a4?=
 =?us-ascii?Q?L46pLyzECiJiOvHFIH2Fwp49Aobk/yxFWYCNkLsVAUPPBAuvnxwYlMuZkaNp?=
 =?us-ascii?Q?teLznMVkqocqRiXVZcvPEEQ0TaWNsr63PJ8KjMSp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaa5c59-ea6b-4f88-3262-08dbde626971
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 00:50:47.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfCgqe/bP/d2At3YHxhkRJitrPiKsLyKlK+5DTG3BLfFDZbtfl8XCWBsZ8HEMCnKvjzJURoH3M0AMZpm3REZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8228
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 07:13:50AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
> commit: afe956c577b2d5a3d9834e4424587c1ebcf90c4c kbuild: Enable -Wtautological-compare
> date:   3 years, 7 months ago
> config: x86_64-randconfig-012-20230909 (https://download.01.org/0day-ci/archive/20231106/202311060731.8P11QmUf-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060731.8P11QmUf-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311060731.8P11QmUf-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

Sorry for wrong report, kindly ignore this, it bisects to wrong commit that is
not the real cause.

> 
>    net/ceph/osdmap.c:176:6: warning: no previous prototype for function 'clear_choose_args' [-Wmissing-prototypes]
>    void clear_choose_args(struct crush_map *c)
>         ^
>    net/ceph/osdmap.c:176:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void clear_choose_args(struct crush_map *c)
>    ^
>    static 
> >> net/ceph/osdmap.c:1246:10: warning: result of comparison of constant 4611686018427387891 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
>            if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
>                ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    net/ceph/osdmap.c:1429:10: warning: result of comparison of constant 2305843009213693945 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
>            if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
>                ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    3 warnings generated.
> --
> >> drivers/block/rbd.c:6190:17: warning: result of comparison of constant 2305843009213693948 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
>            if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
>                ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.
> 
> 
> vim +1246 net/ceph/osdmap.c
> 
> 10db634e2083a2 Ilya Dryomov 2014-03-21  1236  
> a303bb0e58345f Ilya Dryomov 2017-06-21  1237  static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
> a303bb0e58345f Ilya Dryomov 2017-06-21  1238  						bool incremental)
> a303bb0e58345f Ilya Dryomov 2017-06-21  1239  {
> a303bb0e58345f Ilya Dryomov 2017-06-21  1240  	struct ceph_pg_mapping *pg;
> a303bb0e58345f Ilya Dryomov 2017-06-21  1241  	u32 len, i;
> a303bb0e58345f Ilya Dryomov 2017-06-21  1242  
> a303bb0e58345f Ilya Dryomov 2017-06-21  1243  	ceph_decode_32_safe(p, end, len, e_inval);
> a303bb0e58345f Ilya Dryomov 2017-06-21  1244  	if (len == 0 && incremental)
> a303bb0e58345f Ilya Dryomov 2017-06-21  1245  		return NULL;	/* new_pg_temp: [] to remove */
> a303bb0e58345f Ilya Dryomov 2017-06-21 @1246  	if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
> a303bb0e58345f Ilya Dryomov 2017-06-21  1247  		return ERR_PTR(-EINVAL);
> a303bb0e58345f Ilya Dryomov 2017-06-21  1248  
> a303bb0e58345f Ilya Dryomov 2017-06-21  1249  	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
> a303bb0e58345f Ilya Dryomov 2017-06-21  1250  	pg = alloc_pg_mapping(len * sizeof(u32));
> 10db634e2083a2 Ilya Dryomov 2014-03-21  1251  	if (!pg)
> a303bb0e58345f Ilya Dryomov 2017-06-21  1252  		return ERR_PTR(-ENOMEM);
> 10db634e2083a2 Ilya Dryomov 2014-03-21  1253  
> 35a935d75d51ab Ilya Dryomov 2014-03-21  1254  	pg->pg_temp.len = len;
> 10db634e2083a2 Ilya Dryomov 2014-03-21  1255  	for (i = 0; i < len; i++)
> 35a935d75d51ab Ilya Dryomov 2014-03-21  1256  		pg->pg_temp.osds[i] = ceph_decode_32(p);
> 10db634e2083a2 Ilya Dryomov 2014-03-21  1257  
> a303bb0e58345f Ilya Dryomov 2017-06-21  1258  	return pg;
> 10db634e2083a2 Ilya Dryomov 2014-03-21  1259  
> 10db634e2083a2 Ilya Dryomov 2014-03-21  1260  e_inval:
> a303bb0e58345f Ilya Dryomov 2017-06-21  1261  	return ERR_PTR(-EINVAL);
> 10db634e2083a2 Ilya Dryomov 2014-03-21  1262  }
> 10db634e2083a2 Ilya Dryomov 2014-03-21  1263  
> 
> :::::: The code at line 1246 was first introduced by commit
> :::::: a303bb0e58345fe9f7ab2f82b90266f2b5036058 libceph: introduce and switch to decode_pg_mapping()
> 
> :::::: TO: Ilya Dryomov <idryomov@gmail.com>
> :::::: CC: Ilya Dryomov <idryomov@gmail.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
