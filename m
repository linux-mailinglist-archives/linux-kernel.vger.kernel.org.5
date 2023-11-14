Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23C87EAB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjKNICZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjKNICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:02:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0776195
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699948940; x=1731484940;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7Ct0IUQJ4kDacBmev8+9WgTdVuWDgzHuqQ1S1qJ0Gqs=;
  b=EyLPbgl8wUv9Ioa2YQVVuS0//U5PozvS7qb4K2wAmiZE9hWUYDAme7Xi
   nleOZ7VA6vxn1eI32VDnAGrBQHyA70h0vksF2nvXfF4zygEnXNyTc8BoP
   qIQ8j3dv4A1cVhIlsBOwy2WcMW8+pcd+RDHsxVt0D5JUqbBbn7Xm3NIK4
   32yuCyBnZE2Sco9uB2O9G0QaOBq5a8eCynxVbGRHx6DU2lDflcOha8+8k
   bPIfLTwLQGYlIOGqAAUIB+Yb34uEqIck5quTyeNr0ipJC2Xpt2sZg2HGE
   SkEs1S/M/MLJTDBk39eOhNaPjlmSvjzzS9a8D7PWLpgMu9NbBxYxS9B83
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="369947984"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="369947984"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 00:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="881967881"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="881967881"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 00:01:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 00:01:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 00:01:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 00:01:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 00:01:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbRQ5O1lumd2aP5KgKFmGKZMCNqismsD/fxo47RZKTHeFT52vD3eBnwatdXRD6UQtbWLjOr0nTIHEIDc/rwcOwTmqxYDl6uzGKGTrB4LffE0TJ2o1uPZ9wT5BIOA6jncl9o8hr5D7vLFmCmlExX7G5flHXEcFWQa1qcHPxCMGVtSr3gvF77AfMnZQoi27T3kgGk3gQIf076A+hxmfHqw/eauTNWObXe96U6V6MwA0PIquJoI0aC0LIqZXkshU8hCGW0Cs52ge1nR4zKgGL6tQQkOIOiMTE0S4fQyjIxedRUFot1T69ndNS+BKKpQPY7yQcLutTileVjPBwhJrK8vNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HQauXWdrEEz3kqPK4dkf59I39T4huY4oF7V7ug08jA=;
 b=Qw15z2autHjLz0OZ+gvHvbgw/tDeAxj6JMa3u5Ri+wNkSLoaZR/AS7vF5qnv+KSTnejibftOm1LMFgryMKDYGShzL1fSY1wdnCj+A3FPIKGoTOQyf07kCIaiCjA7wi5JRVLC3pJTGHu+MHtPMTpg1MO3nqYt8lhibatQmYV7tpVv986kz+L/NEUW9ddg3qlyvEHGqIEpW7QiP0/tY0phEDfYRV0mOpb4WiXIkdwI0m9bk6AbOLoQyXBsBC2FwMauiZuFxs3DR8SiZkBATrfUeTZUwsTbI+4kKMWmh+oUTKgdJgWcjpCreSJixc8D5DA0gFMupQKJDZF5ysZaF/NiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 08:01:04 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Tue, 14 Nov 2023
 08:01:04 +0000
Date:   Tue, 14 Nov 2023 15:56:22 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Keith Busch" <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>
Subject: tcp.c:undefined reference to `nvme_tls_psk_default'
Message-ID: <202311140426.0eHrTXBr-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW4PR11MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 758e4a48-9bb3-4854-4536-08dbe4e7d961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTJzcEVuE6Wu8ZXsDkqs8vQLa24fMpZ3EYsVY7sZQFuPKL0dBNawkcuWPPqVeQluukOzCpIowMnE4LATM3LfbSZRcJp38YCkx0lDEhw7B94WIXAGDEqUrMFZ1sc7v99RGfgOvs0JdkJxjnPtXX2BzsJckeehV1eAiH/J9Ub3m5ZDKBKaA4rlpals1sC6kAS7bqo+lVhtMIy1cEDKt47T8h8kg8PnP/WznVi6JYpKubYHNXM/46mdaq7b/Q0mko5L6dw38FBL2xXIERZxWJDqoI3Hz8ISJ033R6FgX61y5ZuVUVrQNTv202OfY9/+2xeP6xL6lrvWZsEFyEKDKohSnCYMrr32z7qAh47c/K/ULWYLKR9j/g3r3EyaL4plCV74t3DmwDuySZpLywQniiKLCvB4JecckMQr2l6Kc+kjuyPsEgj+f6tSyWbv/IW/zr3uw0AbwcH/RRg153K73YoelwvYN7FzajTExN803syzTbK1+cM6q+OdsDEMky3IXsxqayEYPdyS4nvMJah6ld8GBuoqm88XoAAIyIwG+y1838GiGkGV9q9Dasa0XvQStIxns1FdGZR/zuL/8IiAw+o9FhAP8wAEiaadpxnCrTxD7Ujp9l9Y8ET1z6FatPCaxrnhz1BS5ryFlI1A/yq345sC+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(316002)(66476007)(66946007)(6916009)(66556008)(54906003)(38100700002)(26005)(86362001)(36756003)(6512007)(83380400001)(82960400001)(1076003)(6666004)(2616005)(6506007)(478600001)(2906002)(966005)(6486002)(41300700001)(4326008)(5660300002)(8676002)(8936002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IilYZ1a9wWsT1MxEbHmZUp2QTLL8IMCUggbmO9CiSkUBr1HdFd3igg+uY9oa?=
 =?us-ascii?Q?a/DgB1qxTp2EpjcvX9nZvNfqZHzkkMdw9z3IqlIIbzSXK/mPR+Y6rG/lcJ/s?=
 =?us-ascii?Q?7bfYpjblqTfDVVZbYSUwDaQPozCy/N7dqnJQmuHYkko/kOM1FNi5aR2rLbyy?=
 =?us-ascii?Q?9+a0rebjTfZM7B8ZNNMMt+1aI/Vbx1aOjos852dMqmS5hK6G+lZIm903qmWC?=
 =?us-ascii?Q?p0Bf7HQ/oLrzJDGuqRfOEJd9VVgYc12Tnbv1FcOD/RwvX7jnjdC73W0ijUSd?=
 =?us-ascii?Q?MnTTt+LgwYJ/G+IESjAKybFpyw9t56uZpjhWZhOYFhwwdUswihBEN48dkKyf?=
 =?us-ascii?Q?jTLYEQDSKDGw3WmuZIa3c1e3Atu0o5Alg76DPuzqYSh5X8KQwGNqBYgQbRzs?=
 =?us-ascii?Q?TEljBc/8XBr4+gYvj5noPyq2Mviv7PJIlICXdv4uPsGmycsF+miRN6FfHBWq?=
 =?us-ascii?Q?pdIewNlLOnOwTDthO9ZIehtAzr1aYP3QmilpYKDpkFlz2aHJ0ovuvSfEu1GA?=
 =?us-ascii?Q?C4tK6yQumZnKeKegg/LywtcqNKl8lSLSWXImmM40K7MSmh3INf6fO/VlZQOs?=
 =?us-ascii?Q?H9bXApqAYS87sX/Loi8Oqy+5uBstGM5UfjIqzD6q5Se5xzh8gm5ul1sIMndL?=
 =?us-ascii?Q?OhpVJeeC7ZvB7npIlEvotEpepvd5grCr4xpykeCzUawtBhbqRwqoDYqIrCoS?=
 =?us-ascii?Q?amiUvY3hIms72STY08aqB6IyFkyI/OAzjLhggZHrNInDR3msTitJUm5BIaL9?=
 =?us-ascii?Q?SjTn6aVCX6ce9J75JDfjGjlHgwn2lndT6moH12BnNd8KsI/rgZktHgxUGeAZ?=
 =?us-ascii?Q?0f0SXQlQoCs8Esn3tp02yYjQPNFrl6w/a/U61Gcr2Z41M0fWVehVSwIq7nWU?=
 =?us-ascii?Q?7YbduWSAOaNhAlvH8+YpTuczkE4VUVslMCq1Q3fJVr7aTRel2m0x7Bflk6rR?=
 =?us-ascii?Q?UCjhRhJ4yGYDWlUQW/Z9yE0knFY5WWSkH8oFMzyUO2zqP+hLM2cCsdGXf/8C?=
 =?us-ascii?Q?QBKxEHaamsHc6bIBMp/AB8BLTid+K5WfQ3f2l9yOA0aQ4i114ioPeb+461SO?=
 =?us-ascii?Q?VO2o1APDKQRzAtowvNnZT1IZppFYlLkQG52fxtPj393PnZkajfLzAQpM/wZQ?=
 =?us-ascii?Q?29jVrP+kyRhL3dwMBL1e/tFQJfF1bRBjehdbx9OQSuWHhAcsr9DIdDlprkmF?=
 =?us-ascii?Q?pB6Zr71IThSL4A7HpK1zIoEYoietZi2QRFhU6SFm6vZCzQkpvwl4fMMeIIJY?=
 =?us-ascii?Q?1k6Ml6PKXdBjMKeskly/OcPlMJPQu10oLgyOFiWl93uoLxNFKCIuWK9rxM2A?=
 =?us-ascii?Q?ttS0KVi8vMg1q8DuvuxB68cLmRa1W666h7KDaGYQQFcRkj3Rn3W5iWcsg4Yq?=
 =?us-ascii?Q?Cwjv4WW5fpybGLhwVkpqXBWjxU1iaqEmYYsN6DKo0rDiRTH2FtPpH0ALbtuA?=
 =?us-ascii?Q?SHHbyytPfVhIWJSW80rnU1zBzh8x0jR21u4oDXo3mxDhtqLUAfD/n+oUxsn5?=
 =?us-ascii?Q?1sX0lQFfpGGpJQ0o/Jn9YbBt9gcbxH6NnEmcaQ49nEmZfaMx6/tXzmNuzFGi?=
 =?us-ascii?Q?8IxeuoEufVUoJHgGNSLdtAyx+0stuo9rEutX2lAz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 758e4a48-9bb3-4854-4536-08dbe4e7d961
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 08:01:03.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUHm1faN3g6EvbNPy0i522ZUrkHgIAaApvm0DDMyxz3O1IWBhS5rW3j6jSoHy1aqBgTjsSd7h9I0JU8wg0oXIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7164
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
head:   9bacdd8996c77c42ca004440be610692275ff9d0
commit: 6affe08aea5f3b630565676e227b41d55a6f009c nvme: common: make keyring and auth separate modules
date:   6 days ago
config: csky-randconfig-002-20231114 (https://download.01.org/0day-ci/archive/20231114/202311140426.0eHrTXBr-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231114/202311140426.0eHrTXBr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311140426.0eHrTXBr-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/nvme/host/core.o: in function `nvme_core_init':
   core.c:(.init.text+0xa0): undefined reference to `nvme_keyring_init'
   csky-linux-ld: core.c:(.init.text+0x130): undefined reference to `nvme_keyring_init'
   csky-linux-ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_configure_admin_queue':
>> tcp.c:(.text+0x2f8a): undefined reference to `nvme_tls_psk_default'
>> csky-linux-ld: tcp.c:(.text+0x3088): undefined reference to `nvme_tls_psk_default'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

