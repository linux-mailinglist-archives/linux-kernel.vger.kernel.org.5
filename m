Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA503805381
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442260AbjLELvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347049AbjLELvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:51:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6E3134
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701777086; x=1733313086;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BVIVnSUHY/l2Gfp2W4AxdXax8wbISbNyAsg1zbQbs4E=;
  b=OCwotuetPVlYRrcH6nDiB06lELNnn9qc0r6dhHrdLv7r5jLh7ymjIbzH
   CLh1XUS9m2pVbCnLc6q0hfM3UXAsn3wNEBYIeo6KVzVX9cx4aBsFgV1PX
   yYTQXvQwx1I62uKU5HqSCPaI2I8lq2AlGMi05DOgtH812xvJ5TQjRZKfu
   xvufHUPfbR55Kxy+Ovo8+eNxctluFmtQ1s7lzX0V9ZgO7ZGf0J02mxs4V
   SlL6+po6dCjr6VYkvajdbX3GY8ro8qDt544dDi+k8TSKmm2R8x54siTDE
   RJn5USOP4iZys+Y9jldZNsSuPQXmp+kA8CQfeJ6vVxIKsGFbM/cr1tiFF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="724845"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="724845"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:51:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1102427351"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1102427351"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 03:51:26 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 03:51:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 03:51:25 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 03:51:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSHjteHcM6b8xvfbqxCWHFmDP+CcACvnWAQeJp8JdzJYxAP0E5e9521cXJ4+XtkrxU0ub0BRv+ntXMXM/o84xnYvxlSa35V9rE5rqTIGRwcByWhs5O9AYzbvn8WQmCwN02MfMKdgneQr2y0QjLU5Ovt4AdncS1W05H/oOL5MRQ0udR3PQ4FTqhEg1KlBgXPY5JKzRzhFpvu04ly37Avzol2WPBQgGMvckuOPheql4/q6Ahng55GLex1rBokMv66Bxf8TX6Lz6SbjmrzVyFTqTxEhdOS17hBmQZV1KSxJgcSjkMggg3cQ+Y34brhvQg2l3Jiht8PR2bEb5wzea/as2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4u1aSmbV224Q62MYPRmhESoq1SOJhU/zXjgwFqSCF4=;
 b=BM+AkuRTBYNeSv7o+lH69aaAevQgw0/cYwtz9/dSpQJH/V7nhdK+YtvM34UQ6e83OD4quk3HAgXPPkuC0bDypazyi+6wbkDjO5Y2+1KmV3GWUCn5jQGEd4st8rIdHQEj/7vgjExLZCdjijxa7IrDJ/w2eiZymug0jVf00EAD97Fj3KrHVFBEbNFkKI5FFxvQ7g/HaFq5IzzzQP1+T7W+zaHtO2C/+HuCI5wvf4EET2w/R8aBW05sdwqHJjkHEWPNwsXGLrSWNaQR2l2uh0arQi2e1k5KfthycFIZBQc6h7I/IcHCWSyB5v1C/xMff3FbaUC63pKGLwH9LnmILX+nBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:51:18 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 11:51:18 +0000
Date:   Tue, 5 Dec 2023 19:51:09 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Jens Axboe <axboe@kernel.dk>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: io_uring/poll.c:164:38: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <ZW8OrZM5B48Mqw4G@rli9-mobl>
References: <202312051944.ErjU79Lr-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202312051944.ErjU79Lr-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CO6PR11MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 246cd131-d833-4e42-da11-08dbf5887d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3H8WmSJtiLp7WVhd8RtiQPUs273/o+FN4yEusS3lBWKUIgHOPq7qJJTW5s3iziLCp3BPXKN6CnJk15ZZEbfjME0ps1L2dLy0+VckFMqM5mdLx11JspMIv99Pc3eprjER06d2ty00v58IYzsafTtNq4GZahMak37CW07mENAnbkKwvKCowkyUKDFvF7XcPlZLRVym7jHZWjk4c/epIpKN+Q4m1Lt2qO7RZWH1TFTAshqgdPX32zWd5nAgdKFSg3dqxrT+nvqxD3Ik3cakjK4MFEf3BZ0SFdm1Gvu9jclPlQfydzO1qkiWyl6+DiDFQipQu9WILxC4+YAKHHmP1z98jM1Lep+GazdAuwm6u9DWsG0TjYVrdLRZgrepDs8d/I1BMK5OxjbFEVYndL3SSZ33fj/gKQ5TUzjwZIXYoRt13U5sTEi9poKWTwwZeqihMJmqkcDgqdwIM7mVVaxskpKmt0roknKGKEiEQnvVYC8UTAemiiA2/IblyySzRodYPh5ktB8V8tT709JWtFXd5TKT8m8mxgofd1xVEFjX7UgIyh8RLOr0RP6jBMnEe4hmzuB7dKG/a02OFsrALU7YQkNNkUUQafv1zSkTF2NzHWkEbQv5eNsL+IgIvjRoiADW1Sh8Et6SZA+Xk1SBFEUzcHLJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(6862004)(4326008)(8936002)(8676002)(9686003)(6512007)(6506007)(83380400001)(82960400001)(26005)(966005)(6486002)(478600001)(6666004)(66556008)(66946007)(66476007)(38100700002)(6636002)(316002)(2906002)(33716001)(41300700001)(44832011)(86362001)(5660300002)(30864003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d69IFRZjXrz1eatKUvH5zxwwzyMEWK80ENmqqLyS6nZqV4sO8WLeIzLbA66M?=
 =?us-ascii?Q?REOn0xPdvI8qufs8h+KKMgALfXQbzWSSyQFdUwa39g6Gzo6IOTZdtQN3ekUX?=
 =?us-ascii?Q?X0FT4f01Jf0pn+N8hrNbwqHKdqzW1Y+X0xdYxKMEwM1myK3HWTipRhvzVCxG?=
 =?us-ascii?Q?T0Fw/bkE5L7TGbBnXWAcHpgD0pIzuFqouykfWBvGIgReBQDkk/7jwIn4N848?=
 =?us-ascii?Q?9BFB9Xl12WALF6GVnMjfglpi/qhLVQH/xmj3FZ+aLfWyBF374D3hOgPYhpfX?=
 =?us-ascii?Q?JHNfqzd++lbd/Ig8KEGYfpYyyeaaIjARFxagcNSmA878S4eCMF8+ZgKbgmBW?=
 =?us-ascii?Q?LO+2f8ivkDdphDisLi7b3TGcRDiquoxV1AcdDUenX2PT/un+yBSdoS9Cf+dW?=
 =?us-ascii?Q?rUgGwpKf8d+vdvZzOMB48lI2/KS+SuciwnwOP1cjsMks2eXqteTRr0AfKCoK?=
 =?us-ascii?Q?7dUKuo8dDo8F0mWJAA7F+7rIiks2jXxbg5k0BxJg8wACX+RRylbW1TDRxHg0?=
 =?us-ascii?Q?hgOZwSgdIPEkWo5hlgzNNCWEVgA+Vk1HTbjqO4WgwycEAjC+yRsx76yIVcRa?=
 =?us-ascii?Q?KRM3rLeiDsXS5CNoD4dxWITQDrgn4Sogo9BuSSieGD6eA/hMUJDUfMIscVAM?=
 =?us-ascii?Q?Mk+VsZn3+7fVJnwka0NTkIc+rZLb7c1kkk43heFeKoeSp8wQ3IDZ0r2SAKD8?=
 =?us-ascii?Q?fkdtuchMY09svkpfACQudEfL8IrD8ioGCpynE7qOVeEPpiPkMfr9qI2uB3Aa?=
 =?us-ascii?Q?KtxUzvXeTHow8Niq2zGr3wNUpLXGbYFcv53oQAhU4z1l/pr6igXaxHYVIbc1?=
 =?us-ascii?Q?MJJ0WuKVv+uwWGIXZjMR5kXetl7ICCWt3HHzWGCq7qW1RMw99tA1gYzWARPr?=
 =?us-ascii?Q?HyW6sgcUkkdjn9f98aMo7K5JK3lo3+MWU/L0LMoKRqzRU8tymhe+hD5ViOjZ?=
 =?us-ascii?Q?YhgmEDYHjN8bYZCOSufdTk7D6Agzhi+Wv3yZic/HnlkeYfCcuwKbWnV18Cp/?=
 =?us-ascii?Q?hlda8RG4Ez/wJFO9qzaqw55NdxlRzOFniJinbQT4+BgdZnu1LUS+0wXaEywi?=
 =?us-ascii?Q?cUhNSSwNGigUNW1R5881I/DHANNJXsICyv1GlSvtBXhoPN0qOUMefWDDP7lL?=
 =?us-ascii?Q?alvi0iG3Ol4nIyNq49D5GmXo9l8wr9LUUUzS3/93o/fAShrwv1CnhA1wOQjN?=
 =?us-ascii?Q?hHdlJKBUIkLpZ6qF7bpOhtaUHAfS5Vp3cB9CMj3puMK04ohfqyQpUNQhbVgp?=
 =?us-ascii?Q?g6GdyG/ikLAg+dprgCLwYUKCrf7Jmeize5agQJSjH1zcHAL7xv4zv89nL4yI?=
 =?us-ascii?Q?sm1SQNV0C44df9ZEVL/ZCVkBlZkU8pAMs2hZVV+6lYN4mNnO5CEQmC7yg1RW?=
 =?us-ascii?Q?SFNdc8tfWeABvf/30+oW9vKUS4Utuz17KbucwecRQEtpUqWk0HChmHurrQ0x?=
 =?us-ascii?Q?VaiRS/R3tX41z7uG+Njl1DjwI8JnEWAHsU/5vdqQB5xLjIdT0iLVgXXkI/R2?=
 =?us-ascii?Q?gKSoK0otEcyiFNoH2snpTajNsqMzvXKc3qFJu840hCEqCcAMUbam+4XILDn+?=
 =?us-ascii?Q?DftkbtaMip51fw74s/FFFFFq+jkRDbWbJglEl1EE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 246cd131-d833-4e42-da11-08dbf5887d8c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:51:17.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUmu7/Bz2lVT3YMOCzJxoYoZKbpvc8Lgk4QhE7mlME8pTSxVnYkTVLi1nhJpfH+FXc2ZDOynUfcnJ9Lnj0Q0+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5602
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

On Tue, Dec 05, 2023 at 07:46:32PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
> commit: 329061d3e2f9a0082a097e9558bd5497098586c6 io_uring: move poll handling into its own file
> date:   1 year, 4 months ago
> config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231205/202312051944.ErjU79Lr-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051944.ErjU79Lr-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of

kindly ignore this report, the commit itself is not the cause of sparse
warnings.

> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312051944.ErjU79Lr-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> io_uring/poll.c:164:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t @@
>    io_uring/poll.c:164:38: sparse:     expected signed int [usertype] res
>    io_uring/poll.c:164:38: sparse:     got restricted __poll_t
> >> io_uring/poll.c:175:56: sparse: sparse: restricted __poll_t degrades to integer
> >> io_uring/poll.c:174:66: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
>    io_uring/poll.c:174:66: sparse:     expected restricted __poll_t [usertype] val
>    io_uring/poll.c:174:66: sparse:     got unsigned int
> >> io_uring/poll.c:174:52: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got unsigned short @@
>    io_uring/poll.c:174:52: sparse:     expected restricted __poll_t [usertype] mask
>    io_uring/poll.c:174:52: sparse:     got unsigned short
> >> io_uring/poll.c:180:50: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected signed int [usertype] res @@     got restricted __poll_t [usertype] mask @@
>    io_uring/poll.c:180:50: sparse:     expected signed int [usertype] res
>    io_uring/poll.c:180:50: sparse:     got restricted __poll_t [usertype] mask
>    io_uring/poll.c:215:63: sparse: sparse: restricted __poll_t degrades to integer
>    io_uring/poll.c:215:57: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __poll_t [usertype] val @@     got unsigned int @@
>    io_uring/poll.c:215:57: sparse:     expected restricted __poll_t [usertype] val
>    io_uring/poll.c:215:57: sparse:     got unsigned int
> >> io_uring/poll.c:333:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [usertype] mask @@
>    io_uring/poll.c:333:40: sparse:     expected int mask
>    io_uring/poll.c:333:40: sparse:     got restricted __poll_t [usertype] mask
>    io_uring/poll.c:428:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __poll_t [assigned] [usertype] mask @@
>    io_uring/poll.c:428:24: sparse:     expected int
>    io_uring/poll.c:428:24: sparse:     got restricted __poll_t [assigned] [usertype] mask
> >> io_uring/poll.c:448:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
>    io_uring/poll.c:448:40: sparse:     expected int mask
>    io_uring/poll.c:448:40: sparse:     got restricted __poll_t [assigned] [usertype] mask
>    io_uring/poll.c:477:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t [usertype] mask @@     got int @@
>    io_uring/poll.c:477:33: sparse:     expected restricted __poll_t [usertype] mask
>    io_uring/poll.c:477:33: sparse:     got int
>    io_uring/poll.c:525:33: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int mask @@     got restricted __poll_t [assigned] [usertype] mask @@
>    io_uring/poll.c:525:33: sparse:     expected int mask
>    io_uring/poll.c:525:33: sparse:     got restricted __poll_t [assigned] [usertype] mask
> >> io_uring/poll.c:525:50: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int events @@     got restricted __poll_t [usertype] events @@
>    io_uring/poll.c:525:50: sparse:     expected int events
>    io_uring/poll.c:525:50: sparse:     got restricted __poll_t [usertype] events
> >> io_uring/poll.c:639:24: sparse: sparse: invalid assignment: |=
> >> io_uring/poll.c:639:24: sparse:    left side has type unsigned int
> >> io_uring/poll.c:639:24: sparse:    right side has type restricted __poll_t
>    io_uring/poll.c:640:65: sparse: sparse: restricted __poll_t degrades to integer
>    io_uring/poll.c:640:29: sparse: sparse: restricted __poll_t degrades to integer
> >> io_uring/poll.c:640:38: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got unsigned int @@
>    io_uring/poll.c:640:38: sparse:     expected restricted __poll_t
>    io_uring/poll.c:640:38: sparse:     got unsigned int
>    io_uring/poll.c:735:38: sparse: sparse: invalid assignment: &=
> >> io_uring/poll.c:735:38: sparse:    left side has type restricted __poll_t
> >> io_uring/poll.c:735:38: sparse:    right side has type int
>    io_uring/poll.c:736:52: sparse: sparse: restricted __poll_t degrades to integer
>    io_uring/poll.c:736:38: sparse: sparse: invalid assignment: |=
>    io_uring/poll.c:736:38: sparse:    left side has type restricted __poll_t
> >> io_uring/poll.c:736:38: sparse:    right side has type unsigned int
>    io_uring/poll.c: note: in included file:
>    io_uring/io_uring_types.h:90:37: sparse: sparse: array of flexible structures
> 
> vim +164 io_uring/poll.c
> 
>    135	
>    136	/*
>    137	 * All poll tw should go through this. Checks for poll events, manages
>    138	 * references, does rewait, etc.
>    139	 *
>    140	 * Returns a negative error on failure. >0 when no action require, which is
>    141	 * either spurious wakeup or multishot CQE is served. 0 when it's done with
>    142	 * the request, then the mask is stored in req->cqe.res.
>    143	 */
>    144	static int io_poll_check_events(struct io_kiocb *req, bool *locked)
>    145	{
>    146		struct io_ring_ctx *ctx = req->ctx;
>    147		int v, ret;
>    148	
>    149		/* req->task == current here, checking PF_EXITING is safe */
>    150		if (unlikely(req->task->flags & PF_EXITING))
>    151			return -ECANCELED;
>    152	
>    153		do {
>    154			v = atomic_read(&req->poll_refs);
>    155	
>    156			/* tw handler should be the owner, and so have some references */
>    157			if (WARN_ON_ONCE(!(v & IO_POLL_REF_MASK)))
>    158				return 0;
>    159			if (v & IO_POLL_CANCEL_FLAG)
>    160				return -ECANCELED;
>    161	
>    162			if (!req->cqe.res) {
>    163				struct poll_table_struct pt = { ._key = req->apoll_events };
>  > 164				req->cqe.res = vfs_poll(req->file, &pt) & req->apoll_events;
>    165			}
>    166	
>    167			if ((unlikely(!req->cqe.res)))
>    168				continue;
>    169			if (req->apoll_events & EPOLLONESHOT)
>    170				return 0;
>    171	
>    172			/* multishot, just fill a CQE and proceed */
>    173			if (!(req->flags & REQ_F_APOLL_MULTISHOT)) {
>  > 174				__poll_t mask = mangle_poll(req->cqe.res &
>  > 175							    req->apoll_events);
>    176				bool filled;
>    177	
>    178				spin_lock(&ctx->completion_lock);
>    179				filled = io_fill_cqe_aux(ctx, req->cqe.user_data,
>  > 180							 mask, IORING_CQE_F_MORE);
>    181				io_commit_cqring(ctx);
>    182				spin_unlock(&ctx->completion_lock);
>    183				if (filled) {
>    184					io_cqring_ev_posted(ctx);
>    185					continue;
>    186				}
>    187				return -ECANCELED;
>    188			}
>    189	
>    190			ret = io_poll_issue(req, locked);
>    191			if (ret)
>    192				return ret;
>    193	
>    194			/*
>    195			 * Release all references, retry if someone tried to restart
>    196			 * task_work while we were executing it.
>    197			 */
>    198		} while (atomic_sub_return(v & IO_POLL_REF_MASK, &req->poll_refs));
>    199	
>    200		return 1;
>    201	}
>    202	
>    203	static void io_poll_task_func(struct io_kiocb *req, bool *locked)
>    204	{
>    205		struct io_ring_ctx *ctx = req->ctx;
>    206		int ret;
>    207	
>    208		ret = io_poll_check_events(req, locked);
>    209		if (ret > 0)
>    210			return;
>    211	
>    212		if (!ret) {
>    213			struct io_poll *poll = io_kiocb_to_cmd(req);
>    214	
>    215			req->cqe.res = mangle_poll(req->cqe.res & poll->events);
>    216		} else {
>    217			req->cqe.res = ret;
>    218			req_set_fail(req);
>    219		}
>    220	
>    221		io_poll_remove_entries(req);
>    222		spin_lock(&ctx->completion_lock);
>    223		hash_del(&req->hash_node);
>    224		req->cqe.flags = 0;
>    225		__io_req_complete_post(req);
>    226		io_commit_cqring(ctx);
>    227		spin_unlock(&ctx->completion_lock);
>    228		io_cqring_ev_posted(ctx);
>    229	}
>    230	
>    231	static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
>    232	{
>    233		struct io_ring_ctx *ctx = req->ctx;
>    234		int ret;
>    235	
>    236		ret = io_poll_check_events(req, locked);
>    237		if (ret > 0)
>    238			return;
>    239	
>    240		io_poll_remove_entries(req);
>    241		spin_lock(&ctx->completion_lock);
>    242		hash_del(&req->hash_node);
>    243		spin_unlock(&ctx->completion_lock);
>    244	
>    245		if (!ret)
>    246			io_req_task_submit(req, locked);
>    247		else
>    248			io_req_complete_failed(req, ret);
>    249	}
>    250	
>    251	static void __io_poll_execute(struct io_kiocb *req, int mask,
>    252				      __poll_t __maybe_unused events)
>    253	{
>    254		io_req_set_res(req, mask, 0);
>    255		/*
>    256		 * This is useful for poll that is armed on behalf of another
>    257		 * request, and where the wakeup path could be on a different
>    258		 * CPU. We want to avoid pulling in req->apoll->events for that
>    259		 * case.
>    260		 */
>    261		if (req->opcode == IORING_OP_POLL_ADD)
>    262			req->io_task_work.func = io_poll_task_func;
>    263		else
>    264			req->io_task_work.func = io_apoll_task_func;
>    265	
>    266		trace_io_uring_task_add(req->ctx, req, req->cqe.user_data, req->opcode, mask);
>    267		io_req_task_work_add(req);
>    268	}
>    269	
>    270	static inline void io_poll_execute(struct io_kiocb *req, int res,
>    271			__poll_t events)
>    272	{
>    273		if (io_poll_get_ownership(req))
>    274			__io_poll_execute(req, res, events);
>    275	}
>    276	
>    277	static void io_poll_cancel_req(struct io_kiocb *req)
>    278	{
>    279		io_poll_mark_cancelled(req);
>    280		/* kick tw, which should complete the request */
>    281		io_poll_execute(req, 0, 0);
>    282	}
>    283	
>    284	#define wqe_to_req(wait)	((void *)((unsigned long) (wait)->private & ~1))
>    285	#define wqe_is_double(wait)	((unsigned long) (wait)->private & 1)
>    286	#define IO_ASYNC_POLL_COMMON	(EPOLLONESHOT | EPOLLPRI)
>    287	
>    288	static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
>    289				void *key)
>    290	{
>    291		struct io_kiocb *req = wqe_to_req(wait);
>    292		struct io_poll *poll = container_of(wait, struct io_poll, wait);
>    293		__poll_t mask = key_to_poll(key);
>    294	
>    295		if (unlikely(mask & POLLFREE)) {
>    296			io_poll_mark_cancelled(req);
>    297			/* we have to kick tw in case it's not already */
>    298			io_poll_execute(req, 0, poll->events);
>    299	
>    300			/*
>    301			 * If the waitqueue is being freed early but someone is already
>    302			 * holds ownership over it, we have to tear down the request as
>    303			 * best we can. That means immediately removing the request from
>    304			 * its waitqueue and preventing all further accesses to the
>    305			 * waitqueue via the request.
>    306			 */
>    307			list_del_init(&poll->wait.entry);
>    308	
>    309			/*
>    310			 * Careful: this *must* be the last step, since as soon
>    311			 * as req->head is NULL'ed out, the request can be
>    312			 * completed and freed, since aio_poll_complete_work()
>    313			 * will no longer need to take the waitqueue lock.
>    314			 */
>    315			smp_store_release(&poll->head, NULL);
>    316			return 1;
>    317		}
>    318	
>    319		/* for instances that support it check for an event match first */
>    320		if (mask && !(mask & (poll->events & ~IO_ASYNC_POLL_COMMON)))
>    321			return 0;
>    322	
>    323		if (io_poll_get_ownership(req)) {
>    324			/* optional, saves extra locking for removal in tw handler */
>    325			if (mask && poll->events & EPOLLONESHOT) {
>    326				list_del_init(&poll->wait.entry);
>    327				poll->head = NULL;
>    328				if (wqe_is_double(wait))
>    329					req->flags &= ~REQ_F_DOUBLE_POLL;
>    330				else
>    331					req->flags &= ~REQ_F_SINGLE_POLL;
>    332			}
>  > 333			__io_poll_execute(req, mask, poll->events);
>    334		}
>    335		return 1;
>    336	}
>    337	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
