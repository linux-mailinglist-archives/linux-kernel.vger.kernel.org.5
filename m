Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8D17F247E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 04:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjKUDJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 22:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjKUDJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 22:09:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF5BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 19:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700536177; x=1732072177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9X5b+Pk5eRiTJicE7zj7f9b9Yatfsk5dDhy4zhgtkuQ=;
  b=ku5SPnJlh1NQ573Rdo5UUrIefsNV0RKSrqXqUma9V6tjNp7vs0J68cq5
   qo+q8WaL9Uf/wJlQQNvn//t8eElfkb5rGHQORx6GCjq04i67XcdldhuAC
   9con2l5BoSTbEk8hJ4Ncsp/x9g17lUlzZh2BAl1s09E9zpzPjyX6kCz3J
   +vMrg77O063K0wGCAbUGPlS/DSddL685evmqbYdbLFuzizrue8jE2NyT+
   IP1DN2obVK2xBgAYmezN5ruBtRS4kB6o7xkhD8QlL2JtJ3bBQojPatBv5
   vYdOaJNt4gKzH2MmKhcOvdM5q5upDX1dFjaRGiW7XD6hIb/QBRiOeMtHX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395683456"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="395683456"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 19:09:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="7757699"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 19:09:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 19:09:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 19:09:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 19:09:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWPSG+DQaUVHHh/ikAr8miLlBPo+3IbZJ1YydqFeaN5yzhzV7Q8VBWgUIx/HJwciKNEuCGxVEjKhYr7HBrjv5ziBIYl0ML0vI3I4DoeUZnOLJGuVlvjnxOxbFBIsAsruHqkkPa29MiT3hu66RelK2jMtuQ0KInOIA0DXdsp2qZhgbuLO5Wnr5e4J2dQUYLQBbUCCZWT5YrwupKMEmD3H5K6J4WPVXS4Zzqm1Y6c7LWtLdLbCDeywlQj7QgAwk5N+WtLFv1cduHqb34l43g9dLhdbDgClL8Nt0yK99TU1GSEC+L1dxor6xORxVc4PDiki+MmjXNyHWJaVW9f6Egu6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYCIU0y+91fClGn3LTuNHrNNNGyW/doPW7jW3h9Sy9g=;
 b=axWrCyC/wZn05LALt6uU2RVJrKYTmws7Q4zjYYBtGyB3RkJ2oRbDa7mPTmGRYpRz89FEWWbdkmMM3bcG4LKbC9wYHM9MbC5Zl3nrx8Pfr7a8Bf1hW9psmE16cXM7h90dyypX+1Bv68KLqq9omLdVENkDIc7HhpP3t6CypJorE7X0Sf6z0PnemFErfu4S0+z+1RJujo/970bwny2vP/uJmShApUZQ/JzU76gIa/TAlnMFiqDmkNdD3f6HieXhTPX61/Q6SiwCcpwAw2706apsE2+16jxZmDA4JHuW8ckGP/lQYOVG6k4SeAGiV+Sjex8H3xVmU+9+0JiBKIAPqfs3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB6548.namprd11.prod.outlook.com (2603:10b6:510:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 03:09:22 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 03:09:22 +0000
Date:   Tue, 21 Nov 2023 11:04:44 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Makefile:63: warning: overriding recipe for target 'emit_tests'
Message-ID: <202311202026.DPcREfHy-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: f16c1adc-9299-48bc-8ff9-08dbea3f427d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbB+WBo9vRZbytWmvOuYIXsN2ab9ejj/8rUKo0no4EikZEVG9+oQahXa29tdvN7r+8Pn831Zdklcm22mlNaLW9AaVBqGJbzKhvPjX+Lsl7z5cvfx+3hCNmX7DVP74aGoPtsiflAPfsD6UjKLbc3k5AlKPDapTJ643ybrEt0S7wkLjCxfcD99o5yZfqOts8XtH3jsgjMhPmAoOUHt13nPp75B7RqHFCaxZaWircs4DJ2un7lyhh58/IjzpGJWDbvGwSWbhspZ6oj7/xGZX9cn26c3JLcvi7JpOOHc3D52PCVD8x9qBeGvhTiCIIUCSD4uzMJs3VaGInl9ZmZ7Tn8zf6SZId29cTQeVqsHCaUa6LePY1n1zZdic9i4QvY0Wo7xjICHr1vytsCT1j7ipwX9AhC3YApdQaJa00ewMCgq0FaZkbVngKLBCTt3qXxc8ARC92XlXR/Af5FhKl9aNdU5aK66Paoja2KSDCsQeoWATZ0yXmcJHNiKNzYrUJId+cZPGpxjvaufHASgdoVV4z7t5n/z4iuLhGnRng7eqQdbtUhCEWUtwEWxwlGWVFYeyka8oNcM6IRBPA+NtCicEH3OuZnoKs3nHAxBd6mxjfVweTNaH0+NEF1JoRS8c38OFmqpw9koVdBodcy02rURKxHAng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(376002)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(36756003)(86362001)(5660300002)(2906002)(82960400001)(6666004)(83380400001)(6512007)(6506007)(478600001)(6486002)(966005)(26005)(1076003)(2616005)(38100700002)(8676002)(4326008)(8936002)(66556008)(316002)(66476007)(66946007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GjwcmRdsbEZhbS4Rpa79ow2uY3sN5+UIDYTlp6zAzeasIZl4B5MvhrU67esT?=
 =?us-ascii?Q?/qs44fnO81TY2SfuZnPI+7M5rt5LhfAOm32V/NKG6UyzlI6euHMAKDo6b6fj?=
 =?us-ascii?Q?TOJb70hiHMCCa3BV1TrHHF8GkCCqMapZqCJ7OIcU8jUOuTad6VVrBbObrVOr?=
 =?us-ascii?Q?Ql4RiuZSBxBS8rOGbux9PDoEFc1C/6d9rMf2mZRPZRfF1mKT0vZBgNhqZN/k?=
 =?us-ascii?Q?K0Z7jz1Qg+pIksBtrPsxLbcN+I3HTy/gfT72e5nYNNqSMaiqxFiCp77gErCn?=
 =?us-ascii?Q?FhJK0fvwh1Fu/wg0+MOydMBtxztUnimRT57tPu1xaFX4Ne5zGHBbTePzHzSg?=
 =?us-ascii?Q?WVYM5d+mVDlzrBfTXwzgfMwbO80orAaYxkUr2p899KH+6v27l/83t6Mu828v?=
 =?us-ascii?Q?F7cz7uXouTbFoegE/6vWA90tCN6yerW6TmRpn4C/9NDduQwwSmIEHJillzvd?=
 =?us-ascii?Q?BOtlp9nTOetmJ/j3OLTY/PVLQ2BgrLXMHPJcYsR0QjZRO2KG3pTX+AnH3PL8?=
 =?us-ascii?Q?jNlHfL2Tng0Xx91xQzUS1xBvSAsEnMu8tSb7z+l0n18vS0G8r5Z3+OHdaU+C?=
 =?us-ascii?Q?jWySW4z/gg7tkzkgSSkzYwUG/nLU86Q6qG2UsB7oTAP26VRqVeWjy3oAh64v?=
 =?us-ascii?Q?Q0GkN6ul2jlFCzv1QNbjiiT9HgtfAlHcLsFzDqPxH//rkWB0WyV3TUKaC6K2?=
 =?us-ascii?Q?CFzUDOG5MFJqW37RaSOpovKRQImEWsAFZhK8Jm3DHUvVoJXILXvnBmYdvhjY?=
 =?us-ascii?Q?DxGeApDj5EW/gcGxAvd7Jk2rDCpIubXmqDi6yqf1k1OafFpaG9eP4lf8n5Dm?=
 =?us-ascii?Q?C87XW1E9U81bN4HPC5QurQaE8d8HsXFAcEhwqQ6dWcXRS0AW6dEgrK4aYvTX?=
 =?us-ascii?Q?IRl00gWokPrHf0NQsfQ0e2sTxLlDzdAUKpmUWxN850Na6jyjHiXB0lC0vo7+?=
 =?us-ascii?Q?A29A83sjOoNryRiXmt9HLNyvWc1g2EgvmGfy3CjQo2+2ZMNDGCDLmgljIdrY?=
 =?us-ascii?Q?EmGj2axlSO8aFean589wKy+pb/YG1HyoTO+HKhlpepuer3U9OydcwCxMZbwg?=
 =?us-ascii?Q?GouTJ3hdoaYV4NdLxjSDipUiwn82akbFzKIlD6K+5bPjgSquTuAs7PeYOHaD?=
 =?us-ascii?Q?ps9raNrjpVhspkSZk6t34WkZd0+EKDV057TP0h51zJgMGxZksUiue3Ny7uU/?=
 =?us-ascii?Q?YB+XxO7eGjQ4l0eohcexIWXaEbn0LYyzzWF0a0sZJWWgQ0reBsEFmerU+uod?=
 =?us-ascii?Q?hwUSIjpWzLwUXQMMYzX9phIagqLqzvSKacDwFb/MoQMdQokt5DC/XGGaq+wc?=
 =?us-ascii?Q?qrW1BgvmekMl15Pp8KF3XxgC0CM/ASvRVmyfJNsrrza9+Qs6GPrJTR/eAFTC?=
 =?us-ascii?Q?k4lbV/lSOysv9r4Z2xaYvxeeEUyMmurMnT/e1IoMY9u1JbaI4RDsyb39csFN?=
 =?us-ascii?Q?4jlH5eymfY9GbiC0HNls+SZvJEiqLtqE/rUH1uAz5W3esODBdk3dXb/MXsw2?=
 =?us-ascii?Q?lMmT0F07Uj9l+jdIeJRknOmXL14QK9wRUfkrv0N1L98yDESjzGYteaoZKRwc?=
 =?us-ascii?Q?IWVn0oLpUdcYFgLXjR1WqGOOZY6HgwdCf6gtHnys?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f16c1adc-9299-48bc-8ff9-08dbea3f427d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 03:09:22.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /We6gWiV5ZxpudnouGFyJjjpgO1yQRtDzGraFMY0atbDtz/R5jgnpONsXzao3NJcGI4MNZzFm8LUBzv5UkSjmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: 58b33e78a31782ffe25d404d5eba9a45fe636e27 selftests/powerpc: Fix emit_tests to work with run_kselftest.sh
date:   8 weeks ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311202026.DPcREfHy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311202026.DPcREfHy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Makefile:63: warning: overriding recipe for target 'emit_tests'
   ../lib.mk:145: warning: ignoring old recipe for target 'emit_tests'


vim +/emit_tests +63 tools/testing/selftests/powerpc/Makefile

6faeeea44b84c (Michael Ellerman            2015-03-11 15:06:01 +1100 61)
58b33e78a3178 (Michael Ellerman            2023-09-21 17:26:10 +1000 62) emit_tests:
4ecd0868c5138 (Benjamin Gray               2023-02-28 11:07:08 +1100 63)        +@for TARGET in $(SUB_DIRS); do \
2db2c250dd3d1 (Michael Ellerman            2017-03-27 15:11:44 +1100 64)                BUILD_TARGET=$(OUTPUT)/$$TARGET;        \
58b33e78a3178 (Michael Ellerman            2023-09-21 17:26:10 +1000 65)                $(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET $@;\
6faeeea44b84c (Michael Ellerman            2015-03-11 15:06:01 +1100 66)        done;
0e56dacdda499 (Michael Ellerman            2013-08-06 17:42:35 +1000 67)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

