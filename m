Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2566C802290
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjLCKxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjLCKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:53:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6481F101
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701600837; x=1733136837;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+T4Vxa/xOrggGWF6XLbWW4VfGb3RY3SBDHRmGWyd074=;
  b=B5nBB9ln7OAw63nKW4kBNzR7jB8lDmE5GUHZgktJWYFYo75FAqootw7v
   S9unA/Q/cArIOtgyY5d7u3ephuA7S0q6pPs62AJvDWYgwAJ5ke8iIvhkp
   5nI14zK44He9mH2ftAodgrdzOMZgUB9O+9YcMznDZ/kOpgqJ+3ezmWTO4
   Q6zSwY/IiC4wlSaln3W+9aMPV3qk06w94OSyGbbVOBMRDTJug30ErWJMy
   wcOcPmcrApX3IWGKwt8Cb/R2NqHb36xpiGcJZJDQCWE0LDQL8r4Jhp97Z
   lgEpIX8Lbgfrss09C8VHU5pqmJ5J1h6O2FlsQSfpGGX1jiU51XyIYqWJB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="539486"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="539486"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 02:53:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="893690256"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="893690256"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2023 02:53:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 3 Dec 2023 02:53:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 3 Dec 2023 02:53:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 3 Dec 2023 02:53:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTqe/I2WSE9OQRAlFp3EwJLnqmt6AHbV0ZXrmLpsFswSPVwXh91jyf24pXQLVxIzfpOrTeGgHrkqu1aRt+Xqu6L7QVbbUmTdd0EyokBH/hk3ZMVKnckv9JMaHQecS9nP8o97wxgRgSD/6r40d25e5rMuu/YRAog9yfS9cUjpLNogulGvqfzP46rNLXxx/VbHYaSFlYWRiHTA671e86XKMNWMqPCdOtbn6OAU4yNQk1mBVcG3kGDjIIO5rDm+QApcR53N/cXM0J2lmn9Y54l1n28si34Zul4oX5mXD+T/27IX7Q1EXs4950mB7qIu3XZzKxmS+ywx/KV3Ghf22T9tCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZpF8urVomIv/2IpVhTTGTIaKnWvR1OjK4Mc85F4ggQ=;
 b=i5dlCajWuVJ2wFnctCigw1oMvzojjTqpQB1NXwKq1URePfso7zuEo8f3dzLeve0BIKAxmd6cIpHrQR+HbLxKyXiBkwV1pnBsbZhah9gvlONca5uMnULYY8olzKz4ff1Qr08B6fXS9bI1wWri6hY4YCCuEUJ3/5novBwPUeXBEg+GAUSALGVUBL0weAmCWtMWKZDHGAltT/8boPxYmfQkKjoryDeV3xVivVap3g9695KEvp9YDBjaD9gQJP322DVa8FlZ3sclEpKe4Y+rL00HrEqhvTav3Wz0k9fbdwDFN1NoxZUoQO6W9Epx3Yqbx043j/ZQQJVP1N2F/XXZSXgKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by BL1PR11MB5222.namprd11.prod.outlook.com (2603:10b6:208:313::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 10:53:53 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.7046.032; Sun, 3 Dec 2023
 10:53:53 +0000
Date:   Sun, 3 Dec 2023 18:53:45 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Masahiro Yamada" <masahiroy@kernel.org>
Subject: Re: drivers/video/fbdev/amifb.c:3637:22: sparse: sparse: cast
 truncates bits from constant value (2e90edd000 becomes 90edd000)
Message-ID: <ZWxeORrNLc/NizXG@rli9-mobl>
References: <202312031411.3OnOYJaj-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202312031411.3OnOYJaj-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|BL1PR11MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc09abb-d572-488e-ef5f-08dbf3ee23ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3uK7SssAPimng5C8lUT7Xv/KT+JBhnTiPlDTSEwgSctLqMEL/+49Gop7IvP0Bp9XBnqrB0lncFNPcz5AFiOUupeSRgdjmZSloP4zA4+9mhdqQ/xhbiWUsZ8qxo18nZ1ljyeXYNdTzRkGOGAt72QI0FIxfhEMJdrUyYI7xPieHYOWaaFNQ1ZpEHb403R9VtbqBRH41Bmfb3OzyAxiy9U0k9Q35KhFX1mZgD4/9gio5s308uDcjC/h1/vfuJj0uSO5ONchl5FzE6nozGYAZZLlZxw/BV0oYwtknnEFTG9s66D6Kk4ucwvJFMvi9S8a8sluw3rzJC4qtN/SGSHI+prcA0P/4jX17ydB4olSxB9BBUD3dLl4tpwurcOm+UC+0T1PpnhIMjZIFFJX22U+oRDZ4Kv3ehwtpMrJWdd/LqC8RjpMd7KYGaOhbPltQpsuM9ZYvRlQJWjVi1+IXtpe0mjqZBj3xKkpc00rBOkZ5xk7XN7WsxgYsI2z2FIHJN6uMG6shfvLNjW5g8/uP20VxYjjal+BACbA9PO+yg9MIFWghn9EfPbVQUV05kceSKfwuUcIuyfK+dTPWIm+4VXh1n6ZiAZVDGGAtnZ1InnZVNe0VD12SgwQfnJVcPMdRQOAdndSVcaT4ckY+OL5bO3upZFkPKxYVf513j5to2rI8N/gFXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(8936002)(8676002)(6862004)(4326008)(6512007)(9686003)(6506007)(83380400001)(82960400001)(26005)(6486002)(966005)(478600001)(6666004)(66899024)(66476007)(54906003)(66946007)(66556008)(316002)(6636002)(2906002)(33716001)(41300700001)(38100700002)(44832011)(86362001)(4001150100001)(5660300002)(30864003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E13urhB8NWJ1XQ6qSE8X4xymOKpDhzynN7sq9M0kNgF850pXJY/IbcdAfp1r?=
 =?us-ascii?Q?iWfo8AZEoFdreRTbpUmKPKgWuLEdCHEqXePDrLzkC6x+uRsaZWWGt4hY/aZu?=
 =?us-ascii?Q?i5JbeePl0xyNpt0zeNY7ZzZK7eQ0l5InzsiQs4Ts9lZFolNMZe+vqhQW5wlT?=
 =?us-ascii?Q?6no0f9HS42R7K9oWUKVNLUbgB468YDqPECj/fdgCKdmtZ1eV1R6gtxYZTFeS?=
 =?us-ascii?Q?z3KfF4Va8Gotx/0gDoICZBx2O4dNf63uc20zKTdcE/vGdozGc4QZlRsIrZZo?=
 =?us-ascii?Q?J0hk7UOOPO4VBO1/mAQfB9KK60ebIniO0CRVkFpix5u6GNvKqMdKLRxEaV2g?=
 =?us-ascii?Q?aFwwv75Yo5AD8Mxp7BoPtsXnpJAdhHqZSXvBNcjsVZCNeUP0Zi/rsqNf9a6g?=
 =?us-ascii?Q?HSRfm73NpOoiL9UdGSMoKD8jI6mlaVykY/UeaMhh57L7IKDc7ltJUzxLt6NN?=
 =?us-ascii?Q?mIMcxjcIOqv5xCL+ekSsu7PFRhLHPyN1pscBuoCC7Im74Yz3NLqcPhikzK6A?=
 =?us-ascii?Q?FYJYD7sx+cpS01zuKzhT5ylpb23qUXgzDhrMEA259Sh/MGN1DnDgC/Oz4TJc?=
 =?us-ascii?Q?LAAozhiHBjG+R4X5Z4Oc4YP9GAfdjORHXPUH68qsI8+dLmz0bZBncZUGlBQf?=
 =?us-ascii?Q?+QVYBwBW8bK3qcedHyz2m3X3woLvYl9FAxbHPc6kPFf0opqCHaZUpu+oVGtZ?=
 =?us-ascii?Q?1t9WdEl0OgNQrTijfoHPlLRoUGGnh0wgILyMTuZR3TFgc3ScfH4WcXWUh4Kj?=
 =?us-ascii?Q?nvL7uptch3T99r9lFofDkgRXdk1pXm+lPGWyVKAmWiRGPQ3tX3C5pZBYUQfJ?=
 =?us-ascii?Q?YT49aZr4m8e8CMjZs3TLjDfonhofP8wW8wWchwCmCr90AzSfqS3vgzX+R1VH?=
 =?us-ascii?Q?d6jJAQ168I5Zn7x8WhwuIEmkWW/NSzV0phMSRfz1S+586zkNl8eD444qv3/N?=
 =?us-ascii?Q?oWFo2OPDlxnL5+R0lqqaJxN/fMpCGFQUnHycgtAZ1tkIccStbgQ4OwCClhNR?=
 =?us-ascii?Q?Z77v7MEMp4vPWLqu4DrhzqU0r4qrTlHKE8vX0aiu0LtVZUdy04aCmlrczvV2?=
 =?us-ascii?Q?fxBjFjc9YtHwnv5Y7EeFKiwfc5feyPRw8HcgxFdBoE9R7ckeVKPAIbK2r/Qe?=
 =?us-ascii?Q?qGM6kAYMyuG/IUrjVU9mTCmuM4BjeO2fBLGe7LlAUHHtSHH7TM6D+GCRrxy4?=
 =?us-ascii?Q?Xze6GBTXoedywLNKfPdbzw+z1/1rrih0Frb/FCYMcHXqRa1faYjSAKMn8Kq5?=
 =?us-ascii?Q?mHxfcUenrNRMflMZkAEfE1aIwXfP0yRGB/MKitcWJNoZLbcoUBO1tInjy4Zb?=
 =?us-ascii?Q?GCDjbrAnq6TUAz3d2aurGn1WRP7CldNZDM8mCY5mD5/HFmvoZ+/RvocGqtun?=
 =?us-ascii?Q?karsVHuYqn7ZIsqzy2x/z14tWbzgmoIrYyhZKxIqK7S1gK/JiPIgErCgTOIm?=
 =?us-ascii?Q?IkRt6rcyBmokaPIQRDFQeaBUdG8j21CAxkzvuHw8KAm9Ljgoyew/0VlLFJac?=
 =?us-ascii?Q?eeOck6leymQ1rLx5lWeA16rgXdO6gOFuFbEuGSJcE4j4hCXV5nzbVQyk1huo?=
 =?us-ascii?Q?q2dv4mowhgslugICSnc9mwkMWKols98ye6X59OJR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc09abb-d572-488e-ef5f-08dbf3ee23ad
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 10:53:53.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERhUlpNY5hDraNo19Ugx3Vfqizgp4nuihM5t7PhN/Xww4gtCZsf17GoQXis8eNOrg2YyrcDzeSpyApS3K0GXUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5222
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 03:32:43PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   968f35f4ab1c0966ceb39af3c89f2e24afedf878
> commit: 1f2f01b122d7c78a9e842a126ef168afb279552b kbuild: add machine size to CHECKFLAGS
> date:   6 years ago
> config: m68k-randconfig-r131-20231129 (https://download.01.org/0day-ci/archive/20231203/202312031411.3OnOYJaj-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231203/202312031411.3OnOYJaj-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of

Kindly ignore this report, the identified commit is not the root cause
of the sparse warning. Sorry for the false report.

> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312031411.3OnOYJaj-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    drivers/video/fbdev/amifb.c:3375:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dst @@     got char [noderef] <asn:2> *screen_base @@
>    drivers/video/fbdev/amifb.c:3375:32: sparse:     expected void *dst
>    drivers/video/fbdev/amifb.c:3375:32: sparse:     got char [noderef] <asn:2> *screen_base
>    drivers/video/fbdev/amifb.c:3713:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] <asn:2> *screen_base @@     got char * @@
>    drivers/video/fbdev/amifb.c:3713:35: sparse:     expected char [noderef] <asn:2> *screen_base
>    drivers/video/fbdev/amifb.c:3713:35: sparse:     got char *
>    drivers/video/fbdev/amifb.c:3755:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:2> *addr @@     got void * @@
>    drivers/video/fbdev/amifb.c:3755:26: sparse:     expected void [noderef] <asn:2> *addr
>    drivers/video/fbdev/amifb.c:3755:26: sparse:     got void *
>    drivers/video/fbdev/amifb.c:3772:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] <asn:2> *addr @@     got void * @@
>    drivers/video/fbdev/amifb.c:3772:26: sparse:     expected void [noderef] <asn:2> *addr
>    drivers/video/fbdev/amifb.c:3772:26: sparse:     got void *
> >> drivers/video/fbdev/amifb.c:3637:22: sparse: sparse: cast truncates bits from constant value (2e90edd000 becomes 90edd000)
>    drivers/video/fbdev/amifb.c: In function 'ami_decode_var':
>    drivers/video/fbdev/amifb.c:1127:23: warning: variable 'vtotal' set but not used [-Wunused-but-set-variable]
>     1127 |         u_int htotal, vtotal;
>          |                       ^~~~~~
>    drivers/video/fbdev/amifb.c:1127:15: warning: variable 'htotal' set but not used [-Wunused-but-set-variable]
>     1127 |         u_int htotal, vtotal;
>          |               ^~~~~~
>    drivers/video/fbdev/amifb.c: In function 'ami_get_var_cursorinfo':
>    drivers/video/fbdev/amifb.c:1848:19: warning: variable 'alloc' set but not used [-Wunused-but-set-variable]
>     1848 |         int size, alloc;
>          |                   ^~~~~
>    drivers/video/fbdev/amifb.c: In function 'amifb_pan_display':
>    drivers/video/fbdev/amifb.c:2540:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
>     2540 |                 if (var->yoffset < 0 ||
>          |                                  ^
>    In file included from drivers/video/fbdev/amifb.c:43:
>    drivers/video/fbdev/amifb.c: At top level:
>    include/linux/module.h:132:13: warning: 'init_module' specifies less restrictive attribute than its target 'amifb_driver_init': 'cold' [-Wmissing-attributes]
>      132 |         int init_module(void) __attribute__((alias(#initfn)));
>          |             ^~~~~~~~~~~
>    include/linux/platform_device.h:251:1: note: in expansion of macro 'module_init'
>      251 | module_init(__platform_driver##_init); 36-      | ^~~~~~~~~~~
>    drivers/video/fbdev/amifb.c:3786:1: note: in expansion of macro 'module_platform_driver_probe'
>     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from drivers/video/fbdev/amifb.c:53:
>    drivers/video/fbdev/amifb.c:3786:30: note: 'init_module' target declared here
>     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
>          |                              ^~~~~~~~~~~~
>    include/linux/platform_device.h:246:19: note: in definition of macro 'module_platform_driver_probe'
>      246 | static int __init __platform_driver##_init(void) 46-      |                   ^~~~~~~~~~~~~~~~~
>    include/linux/module.h:138:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'amifb_driver_exit': 'cold' [-Wmissing-attributes]
>      138 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
>          |              ^~~~~~~~~~~~~~
>    include/linux/platform_device.h:256:1: note: in expansion of macro 'module_exit'
>      256 | module_exit(__platform_driver##_exit);
>          | ^~~~~~~~~~~
>    drivers/video/fbdev/amifb.c:3786:1: note: in expansion of macro 'module_platform_driver_probe'
>     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/video/fbdev/amifb.c:3786:30: note: 'cleanup_module' target declared here
>     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
>          |                              ^~~~~~~~~~~~
>    include/linux/platform_device.h:252:20: note: in definition of macro 'module_platform_driver_probe'
>      252 | static void __exit __platform_driver##_exit(void) 61-      |                    ^~~~~~~~~~~~~~~~~
>    drivers/video/fbdev/amifb.c:2344:19: warning: 'amifb_setup' defined but not used [-Wunused-function]
>     2344 | static int __init amifb_setup(char *options)
>          |                   ^~~~~~~~~~~
> 
> vim +3637 drivers/video/fbdev/amifb.c
> 
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3619  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3620  	default:
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3621  #ifdef CONFIG_FB_AMIGA_OCS
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3622  		printk("Unknown graphics chipset, defaulting to OCS\n");
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3623  		strcat(info->fix.id, "Unknown");
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3624  		goto default_chipset;
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3625  #else /* CONFIG_FB_AMIGA_OCS */
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3626  		err = -ENODEV;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3627  		goto release;
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3628  #endif /* CONFIG_FB_AMIGA_OCS */
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3629  		break;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3630  	}
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3631  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3632  	/*
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3633  	 * Calculate the Pixel Clock Values for this Machine
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3634  	 */
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3635  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3636  	{
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21 @3637  	u_long tmp = DIVUL(200000000000ULL, amiga_eclock);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3638  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3639  	pixclock[TAG_SHRES] = (tmp + 4) / 8;	/* SHRES:  35 ns / 28 MHz */
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3640  	pixclock[TAG_HIRES] = (tmp + 2) / 4;	/* HIRES:  70 ns / 14 MHz */
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3641  	pixclock[TAG_LORES] = (tmp + 1) / 2;	/* LORES: 140 ns /  7 MHz */
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3642  	}
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3643  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3644  	/*
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3645  	 * Replace the Tag Values with the Real Pixel Clock Values
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3646  	 */
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3647  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3648  	for (i = 0; i < NUM_TOTAL_MODES; i++) {
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3649  		struct fb_videomode *mode = &ami_modedb[i];
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3650  		tag = mode->pixclock;
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3651  		if (tag == TAG_SHRES || tag == TAG_HIRES || tag == TAG_LORES) {
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3652  			mode->pixclock = pixclock[tag];
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3653  		}
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3654  	}
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3655  
> 03c740a04c8da4 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3656  	if (amifb_hfmin) {
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3657  		info->monspecs.hfmin = amifb_hfmin;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3658  		info->monspecs.hfmax = amifb_hfmax;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3659  		info->monspecs.vfmin = amifb_vfmin;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3660  		info->monspecs.vfmax = amifb_vfmax;
> 03c740a04c8da4 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3661  	} else {
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3662  		/*
> 03c740a04c8da4 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3663  		 *  These are for a typical Amiga monitor (e.g. A1960)
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3664  		 */
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3665  		info->monspecs.hfmin = 15000;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3666  		info->monspecs.hfmax = 38000;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3667  		info->monspecs.vfmin = 49;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3668  		info->monspecs.vfmax = 90;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3669  	}
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3670  
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3671  	info->fbops = &amifb_ops;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3672  	info->flags = FBINFO_DEFAULT;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3673  	info->device = &pdev->dev;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3674  
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3675  	if (!fb_find_mode(&info->var, info, mode_option, ami_modedb,
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3676  			  NUM_TOTAL_MODES, &ami_modedb[defmode], 4)) {
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3677  		err = -EINVAL;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3678  		goto release;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3679  	}
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3680  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3681  	fb_videomode_to_modelist(ami_modedb, NUM_TOTAL_MODES,
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3682  				 &info->modelist);
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3683  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3684  	round_down_bpp = 0;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3685  	chipptr = chipalloc(info->fix.smem_len + SPRITEMEMSIZE +
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3686  			    DUMMYSPRITEMEMSIZE + COPINITSIZE +
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3687  			    4 * COPLISTSIZE);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3688  	if (!chipptr) {
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3689  		err = -ENOMEM;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3690  		goto release;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3691  	}
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3692  
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3693  	assignchunk(videomemory, u_long, chipptr, info->fix.smem_len);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3694  	assignchunk(spritememory, u_long, chipptr, SPRITEMEMSIZE);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3695  	assignchunk(dummysprite, u_short *, chipptr, DUMMYSPRITEMEMSIZE);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3696  	assignchunk(copdisplay.init, copins *, chipptr, COPINITSIZE);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3697  	assignchunk(copdisplay.list[0][0], copins *, chipptr, COPLISTSIZE);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3698  	assignchunk(copdisplay.list[0][1], copins *, chipptr, COPLISTSIZE);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3699  	assignchunk(copdisplay.list[1][0], copins *, chipptr, COPLISTSIZE);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3700  	assignchunk(copdisplay.list[1][1], copins *, chipptr, COPLISTSIZE);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3701  
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3702  	/*
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3703  	 * access the videomem with writethrough cache
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3704  	 */
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3705  	info->fix.smem_start = (u_long)ZTWO_PADDR(videomemory);
> c7c95f19f37976 drivers/video/fbdev/amifb.c Toshi Kani         2015-06-04  3706  	videomemory = (u_long)ioremap_wt(info->fix.smem_start,
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3707  					 info->fix.smem_len);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3708  	if (!videomemory) {
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3709  		dev_warn(&pdev->dev,
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3710  			 "Unable to map videomem cached writethrough\n");
> 6112ea0862faca drivers/video/amifb.c       Geert Uytterhoeven 2011-01-09  3711  		info->screen_base = ZTWO_VADDR(info->fix.smem_start);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3712  	} else
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21 @3713  		info->screen_base = (char *)videomemory;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3714  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3715  	memset(dummysprite, 0, DUMMYSPRITEMEMSIZE);
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3716  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3717  	/*
> af5761d6092903 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3718  	 * Make sure the Copper has something to do
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3719  	 */
> af5761d6092903 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3720  	ami_init_copper();
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3721  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3722  	/*
> af5761d6092903 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3723  	 * Enable Display DMA
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3724  	 */
> af5761d6092903 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3725  	custom.dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER |
> af5761d6092903 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3726  			DMAF_BLITTER | DMAF_SPRITE;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3727  
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3728  	err = request_irq(IRQ_AMIGA_COPPER, amifb_interrupt, 0,
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3729  			  "fb vertb handler", info->par);
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3730  	if (err)
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3731  		goto disable_dma;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3732  
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3733  	err = fb_alloc_cmap(&info->cmap, 1 << info->var.bits_per_pixel, 0);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3734  	if (err)
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3735  		goto free_irq;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3736  
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3737  	dev_set_drvdata(&pdev->dev, info);
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3738  
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3739  	err = register_framebuffer(info);
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3740  	if (err)
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3741  		goto unset_drvdata;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3742  
> 31b6780c15a4e3 drivers/video/amifb.c       Joe Perches        2013-09-19  3743  	fb_info(info, "%s frame buffer device, using %dK of video memory\n",
> 31b6780c15a4e3 drivers/video/amifb.c       Joe Perches        2013-09-19  3744  		info->fix.id, info->fix.smem_len>>10);
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3745  
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3746  	return 0;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3747  
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3748  unset_drvdata:
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3749  	fb_dealloc_cmap(&info->cmap);
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3750  free_irq:
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3751  	free_irq(IRQ_AMIGA_COPPER, info->par);
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3752  disable_dma:
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3753  	custom.dmacon = DMAF_ALL | DMAF_MASTER;
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3754  	if (videomemory)
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3755  		iounmap((void *)videomemory);
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3756  	chipfree();
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3757  release:
> 61640c295bbe8b drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3758  	framebuffer_release(info);
> f1cbb17ac73993 drivers/video/amifb.c       Geert Uytterhoeven 2011-11-21  3759  	return err;
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3760  }
> ^1da177e4c3f41 drivers/video/amifb.c       Linus Torvalds     2005-04-16  3761  
> 
> :::::: The code at line 3637 was first introduced by commit
> :::::: f1cbb17ac73993225402d7e40a0694c502570876 fbdev/amifb: Reorder functions to remove forward declarations
> 
> :::::: TO: Geert Uytterhoeven <geert@linux-m68k.org>
> :::::: CC: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
