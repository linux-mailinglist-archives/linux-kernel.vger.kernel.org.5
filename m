Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1131792736
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbjIEQI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354700AbjIENgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:36:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B0191
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693920988; x=1725456988;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bD9tE0oQc7Z4nz/zcl8v5g3ekn7Mb6oyJtS979lnczs=;
  b=D9AkGEyxbD6NoNKVSOEbnZNrvMulpshkPiIMcCjRmMXk7LrWwaiu5Ffg
   e+aOYXIu39Ei7sqr9kjWQKSe7AmhLCeW2fNq7tjEr0Wlr5/ZLNqwGsHtq
   2e9LnK7hyKCHsltDaRUnJYNYgSs3reuPOgOdUUQCDCc2UGV5MNwJrgXsy
   /uOmHLUXFyjBrkln6LOiZNx2B/flx+GtKrwFedz7ThDXcoCW5FM19A/iD
   IzFs/RU8G1E9UqjLYsbMc0dwG6rLMETABkjtMrf0oOamDvXK+pZ0Rzhyf
   RKyI3f0GaY5H2YbosTTme2/DUHPPzYRe9s5Uu1y0JGh7IeTvp3DGA77O+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="379513102"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="379513102"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 06:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="734654917"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="734654917"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 06:36:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 06:36:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 06:36:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 06:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiJq0W5q80EGp8hxre0omtO610nqaxK7hu5WdKvqIN9cKZAomNYL7znoHqCJSFQqknZVZk6vAhBBtzPpm6/15/YK47OqviZmJcm9AYc2C+NWcbXBSip5LToQV9detvHu8NoHrElz6EC09J4MDfJXfxzfPV6C5+Xf85jmJWyTV/MtdkkuPDPqmBKzn5bLsncqFg1pSgBI0HawBYHT+l7jQrxJbajVqZaOzNiM/EzDvlMlu10YQKCrBu7vStUnJSGcPmGKqeDf34l3tUTT/rP7yYkCJC8/Zpdv35Vo3sBu5SNoTsQDYxLGEKtLm9btTyXsepTkogc26WGbsqUp1T8n4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llQ0dGVDYluwfa62ytxzRFGRVC5XI8sVx2oXeupE7G0=;
 b=L+Rj5rPtXQNhdp+AD/c0lVCvdomMjy2sfFXdapk1XI96nFLe1/zu78afUNyOhKGISDimt4pkp9QpuPqdckWu4wZaqKODJQbaBcjuNFxXhEOSooEsrolpnJlH1EVlFgWfIe9pfFGIFkNN2CHJF3XL9qumoqJH9db23G112YUMRe8PPMqNzNFGkm5XH0umpJQGvQJgayqk8LPEimGvsIajssoUbVV0t1275tshgR44l2OHTh5T+uhuV5HNPsG5X2DTxQ1F1zsCH5P9wW34bx3x28PSE7PLHyq0BnlOtngJnnN/tvUZjhMaX7dM43myDhepcmtQCfTtqE2xOhgWHLVCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 13:36:07 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::b844:be65:8430:f80e]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::b844:be65:8430:f80e%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 13:36:07 +0000
Date:   Tue, 5 Sep 2023 21:35:56 +0800
From:   kernel test robot <philip.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>
Subject: arch/x86/kernel/fpu/xstate.c:1691: warning: Excess function
 parameter 'tsk' description in 'fpu_xstate_prctl'
Message-ID: <ZPcuvEg5Mf5MoM2L@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|MW3PR11MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9c4e20-c9e0-49eb-d006-08dbae150ed8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7SxDF4imRffWUtU37lcL75j/vFjy8CbJn4My7waPNqtvJdfa91CHMXDiSI7e6vPhRHj1aUdf9uBQopYc9FjvkCk8JaCzC2mwQbtRf3k8hj5bqBynSbLWwIki1lLrHxW1uoIfYAPM6WTgvBsSa8jQDFR/vqQCXNH3etmiUHojMFDB9gOc/I8NxGPCNQlMv8aWrG80J39cwnlP/Dkh6iQPC7Ns6nSpns+cjru9SYy2/DItgI4+rpFc5OQaDq4iU+4NLq8ya7kK/5kln62uG39hgnbzgi4hjQINxFX9z/5LEmmUwD8cmBS2xdrnvXV+u/M2u6cGbWZBSAahTZllflcT1k3LQWwPlCrfSCDq3/Kqfgy5bZKhchzn1liQ+2M1pWSoafOfDJ1myxhTehtX6HGwZTAFoX17PB0LrXIjseAts9GIyssL8WqYlD2ZKVKsIDLgM0mL9WuSksX6tQwEQIuFzgx7KlaO/zGkAxZGqk7sxsXSSP29VvZfLCC+o+ES+Hz3cbqVWzdmc5GBOttRSl36h2jenOZY1gvrOgK/zDb9FXuHfMz0W54uwJiKIoA/RqpkJH2Nyo8GLgMwAheGXN4xUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199024)(186009)(1800799009)(966005)(41300700001)(83380400001)(8936002)(4001150100001)(478600001)(6666004)(2906002)(66946007)(5660300002)(8676002)(316002)(6916009)(66476007)(66556008)(4326008)(9686003)(6512007)(26005)(6506007)(6486002)(33716001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c/rQnT40dFv+9LPlYIJyLeJ+gtBNmst0QKWSY22TTQw3AbFC/d/2TghbzPZG?=
 =?us-ascii?Q?2QO929jyhoIdxYEBQuAiOk80BAzLLWs6eQT/jEworEriv1JX43DbB8uNEPGv?=
 =?us-ascii?Q?luoVQE69dOt/sIl9no6ZNgIYYgOEk6hWhNgd1LOQvLPlEdOVRunuCUVK47ld?=
 =?us-ascii?Q?AzpctLDYISEiRQn6bb5zUONXKFpHD2ws78Ny4VcQ1i7X6qjaVXtcE3syG4Pe?=
 =?us-ascii?Q?EluFmmKfVaEabxBO++4PXpELhtP/t/cEl1Do80OYXPJGA3h+T70h0n7/xw5E?=
 =?us-ascii?Q?jWFKv1gFo/u34XhVs24cCy513k0EdN67qqS1RdzJTD/IIRUJf+DIrD+t7ZM4?=
 =?us-ascii?Q?oRkhrHTrkCtfRDR70ttf9+3aO0qfO8ciiqtWjDBW+Sj0ACbs3IBcedwLc9Io?=
 =?us-ascii?Q?EWaSMkvfGer1Ke9Tc7lR6UJeEjMv0PGP2pPz9j2IpJJFIDDwngToWpMU4kDy?=
 =?us-ascii?Q?ykOmF7HFHCkKzhidn6EmIxPe5cV+FG9kWSddMad408+5kF7sd8gvZP5olNXx?=
 =?us-ascii?Q?/1ErdGK6AEnSJobSee/kmPjgkmETE9yCpQRxhYY+iOJfrZWjlkQhJLS+XTlh?=
 =?us-ascii?Q?YPMwFnFNnBLZHQ3qdg71wxL1c6bMWPmrcL30GyQkP56GwfmXAu1fn/+7P6gi?=
 =?us-ascii?Q?16ZlDDreVRdthzs9npERKAaSowIDJWDSgTk/dd4FwVW0j5+8xxf+ndUR9Dyz?=
 =?us-ascii?Q?ypoMOMFymhJjmKiJ310p77NvcnfcBh7xwUzzfrm+VhFxIDnYf7ZM1PVqBhhD?=
 =?us-ascii?Q?dsIYkYa97uVXm0o7+ri6S7YWT+6Yzs+9ofzWA84AsKDIT+gBDRXpXrfO4C2c?=
 =?us-ascii?Q?byAonn/BQTGbrGlPHAA4GulOqRefUVkxrfnAR0S5uwkpBEPhRmvXsGk8g/Uq?=
 =?us-ascii?Q?dSA2jKKxAT6evzpTl6/RPSfKmZveN3ft6juTZrJTza9AIOr2bT0QnfaPOUci?=
 =?us-ascii?Q?YSfJ/pwbhLBO0KuQmlLqKxqgwujwmFyEWoyhVmfxcbbWu31atfeQIMOGwKE7?=
 =?us-ascii?Q?ZYdaFvAudjpi5d2N923mj7MQabHC02eWY221ef99akFiQSzLIKkjcXzTMwHE?=
 =?us-ascii?Q?HDgM+7YaHB4tKPCXFpq5Fkz+yeD6ra4k6vLdkg5362gKuKg1WgZUmb7mRmv7?=
 =?us-ascii?Q?asCODtjmENY34fYnhUMn5KVrOhwq0WTIhzFbFHXr6+Tr0WysuhqhZzDydwyM?=
 =?us-ascii?Q?bwakUOzRURrKzRO3CDHzhNXxbKMEaD89kMvBYG+5gPirkgW6VzDRhM3RdqGG?=
 =?us-ascii?Q?S6QBNU410L4y7y7X9kBq1H7n1P9s6d2bVBLzlrwyXZbrPvU3F9kKFRCt7mf+?=
 =?us-ascii?Q?FPeDmOuGVH3S3hDlmEevGQSqZrgwW4G2dr5/o3FX9oH6cmgCmvkNhv7id+qU?=
 =?us-ascii?Q?4zT4GsfBvEp3W78vC67MwcCqarEp8utBbBDyXgHM4YlOVee6CQlZW8AjnXVB?=
 =?us-ascii?Q?0/fWzCVlUxr3uBMvfXtZghviBIzqFzcOwRj1+HBTi+FHsC99h7LrHhV+JSuV?=
 =?us-ascii?Q?WEWDK+G4GpwrwNJAkifBSvhUwuSCeIAbWQkxHars0KFxNhS39MAi96uM+vgY?=
 =?us-ascii?Q?nVlUZNveXheKpaRtoOsy2wMmhUBstmg45OFLD5/c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9c4e20-c9e0-49eb-d006-08dbae150ed8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 13:36:07.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKECibgH2VH7yvJDq0oPU1IHTtjN15+rzZDVyRkLTUvXAvb+ZPzu9DjIJPZZ3xiWHScFDOtGWgMbMRNqR+MGVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f86ed6ec0b390c033eae7f9c487a3fea268e027
commit: f5c0b4f30416c670408a77be94703d04d22b57df x86/prctl: Remove pointless task argument
date:   1 year, 4 months ago
:::::: branch date: 14 hours ago
:::::: commit date: 1 year, 4 months ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230905/202309052029.TNyqXyIT-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230905/202309052029.TNyqXyIT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202309052029.TNyqXyIT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/fpu/xstate.c:1691: warning: Excess function parameter 'tsk' description in 'fpu_xstate_prctl'


vim +1691 arch/x86/kernel/fpu/xstate.c

980fe2fddcff21 Thomas Gleixner 2022-01-05  1671  
db8268df0983ad Chang S. Bae    2021-10-21  1672  /**
db8268df0983ad Chang S. Bae    2021-10-21  1673   * fpu_xstate_prctl - xstate permission operations
db8268df0983ad Chang S. Bae    2021-10-21  1674   * @tsk:	Redundant pointer to current
db8268df0983ad Chang S. Bae    2021-10-21  1675   * @option:	A subfunction of arch_prctl()
db8268df0983ad Chang S. Bae    2021-10-21  1676   * @arg2:	option argument
db8268df0983ad Chang S. Bae    2021-10-21  1677   * Return:	0 if successful; otherwise, an error code
db8268df0983ad Chang S. Bae    2021-10-21  1678   *
db8268df0983ad Chang S. Bae    2021-10-21  1679   * Option arguments:
db8268df0983ad Chang S. Bae    2021-10-21  1680   *
db8268df0983ad Chang S. Bae    2021-10-21  1681   * ARCH_GET_XCOMP_SUPP: Pointer to user space u64 to store the info
db8268df0983ad Chang S. Bae    2021-10-21  1682   * ARCH_GET_XCOMP_PERM: Pointer to user space u64 to store the info
db8268df0983ad Chang S. Bae    2021-10-21  1683   * ARCH_REQ_XCOMP_PERM: Facility number requested
db8268df0983ad Chang S. Bae    2021-10-21  1684   *
db8268df0983ad Chang S. Bae    2021-10-21  1685   * For facilities which require more than one XSTATE component, the request
db8268df0983ad Chang S. Bae    2021-10-21  1686   * must be the highest state component number related to that facility,
db8268df0983ad Chang S. Bae    2021-10-21  1687   * e.g. for AMX which requires XFEATURE_XTILE_CFG(17) and
db8268df0983ad Chang S. Bae    2021-10-21  1688   * XFEATURE_XTILE_DATA(18) this would be XFEATURE_XTILE_DATA(18).
db8268df0983ad Chang S. Bae    2021-10-21  1689   */
f5c0b4f30416c6 Thomas Gleixner 2022-05-12  1690  long fpu_xstate_prctl(int option, unsigned long arg2)
db8268df0983ad Chang S. Bae    2021-10-21 @1691  {
db8268df0983ad Chang S. Bae    2021-10-21  1692  	u64 __user *uptr = (u64 __user *)arg2;
db8268df0983ad Chang S. Bae    2021-10-21  1693  	u64 permitted, supported;
db8268df0983ad Chang S. Bae    2021-10-21  1694  	unsigned long idx = arg2;
980fe2fddcff21 Thomas Gleixner 2022-01-05  1695  	bool guest = false;
db8268df0983ad Chang S. Bae    2021-10-21  1696  
db8268df0983ad Chang S. Bae    2021-10-21  1697  	switch (option) {
db8268df0983ad Chang S. Bae    2021-10-21  1698  	case ARCH_GET_XCOMP_SUPP:
db8268df0983ad Chang S. Bae    2021-10-21  1699  		supported = fpu_user_cfg.max_features |	fpu_user_cfg.legacy_features;
db8268df0983ad Chang S. Bae    2021-10-21  1700  		return put_user(supported, uptr);
db8268df0983ad Chang S. Bae    2021-10-21  1701  
db8268df0983ad Chang S. Bae    2021-10-21  1702  	case ARCH_GET_XCOMP_PERM:
db8268df0983ad Chang S. Bae    2021-10-21  1703  		/*
db8268df0983ad Chang S. Bae    2021-10-21  1704  		 * Lockless snapshot as it can also change right after the
db8268df0983ad Chang S. Bae    2021-10-21  1705  		 * dropping the lock.
db8268df0983ad Chang S. Bae    2021-10-21  1706  		 */
db8268df0983ad Chang S. Bae    2021-10-21  1707  		permitted = xstate_get_host_group_perm();
db8268df0983ad Chang S. Bae    2021-10-21  1708  		permitted &= XFEATURE_MASK_USER_SUPPORTED;
db8268df0983ad Chang S. Bae    2021-10-21  1709  		return put_user(permitted, uptr);
db8268df0983ad Chang S. Bae    2021-10-21  1710  
980fe2fddcff21 Thomas Gleixner 2022-01-05  1711  	case ARCH_GET_XCOMP_GUEST_PERM:
980fe2fddcff21 Thomas Gleixner 2022-01-05  1712  		permitted = xstate_get_guest_group_perm();
980fe2fddcff21 Thomas Gleixner 2022-01-05  1713  		permitted &= XFEATURE_MASK_USER_SUPPORTED;
980fe2fddcff21 Thomas Gleixner 2022-01-05  1714  		return put_user(permitted, uptr);
980fe2fddcff21 Thomas Gleixner 2022-01-05  1715  
980fe2fddcff21 Thomas Gleixner 2022-01-05  1716  	case ARCH_REQ_XCOMP_GUEST_PERM:
980fe2fddcff21 Thomas Gleixner 2022-01-05  1717  		guest = true;
980fe2fddcff21 Thomas Gleixner 2022-01-05  1718  		fallthrough;
980fe2fddcff21 Thomas Gleixner 2022-01-05  1719  
db8268df0983ad Chang S. Bae    2021-10-21  1720  	case ARCH_REQ_XCOMP_PERM:
db8268df0983ad Chang S. Bae    2021-10-21  1721  		if (!IS_ENABLED(CONFIG_X86_64))
db8268df0983ad Chang S. Bae    2021-10-21  1722  			return -EOPNOTSUPP;
db8268df0983ad Chang S. Bae    2021-10-21  1723  
980fe2fddcff21 Thomas Gleixner 2022-01-05  1724  		return xstate_request_perm(idx, guest);
db8268df0983ad Chang S. Bae    2021-10-21  1725  
db8268df0983ad Chang S. Bae    2021-10-21  1726  	default:
db8268df0983ad Chang S. Bae    2021-10-21  1727  		return -EINVAL;
db8268df0983ad Chang S. Bae    2021-10-21  1728  	}
db8268df0983ad Chang S. Bae    2021-10-21  1729  }
db8268df0983ad Chang S. Bae    2021-10-21  1730  

:::::: The code at line 1691 was first introduced by commit
:::::: db8268df0983adc2bb1fb48c9e5f7bfbb5f617f3 x86/arch_prctl: Add controls for dynamic XSTATE components

:::::: TO: Chang S. Bae <chang.seok.bae@intel.com>
:::::: CC: Borislav Petkov <bp@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

