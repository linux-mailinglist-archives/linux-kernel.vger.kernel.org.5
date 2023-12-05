Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE225804A92
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344387AbjLEGsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjLEGsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:48:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91291D3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701758892; x=1733294892;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tdzDwlsgUjSiWim7qluAZborNy7JFNbBKg5h1eOE9fM=;
  b=S+lJwFR04YMmoIB3yqk7/HQK4lQrijLnGwKLPItmIdUPW/uieYBQ+Njd
   BPLC3y3pTUq57epttQeqRHCHTRBCIiFcst422wzuDwZOTJShZJkK6lXVT
   tC3FTsIywDlfbmKAH9qtjQ3Gy8S/Yf8kWrQG24ShGJGo2tBi+olnIZ2hI
   EkuzhDFBSZtRVNbkI6MIRBf2Pe4h5XKokI8fsrZeDYulzmys4WUR1zxKX
   8lUtphzBSGLkX4ycJUVljvqir/aXZrQJlIPDdpXXawH+xPSd839TVi8yt
   XdGP1fAplLlXiNf/1RNZAhkEQf+YRwhAQ1fXZdaaMFJj63ut7oiE8vAZU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="391011975"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="391011975"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 22:47:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="799852300"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="799852300"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 22:47:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 22:47:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 22:47:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 22:47:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 22:47:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8P1i5LSx0PUwEW9L/IpgjWSL486TbqhFmCj+RZerR+p2nYAi+8WSYw6q72Kkw0zodUOnDmUmPY+7INE/dQPOG1104mK956zzQ+CjvLaHyB4yMs5f6T9dtEiq02+PGNM31Q5SSL3EidFtuOEjMeWxHm543WKnybCiYkQQVHUks83wB/yrT5ZtptacGc0X5oy6e9O5oTRjWhjR2V1aaJ+UfQ8Xz9BpK7wuDTSPnmXDjqzsCJWpgP97qSet2GRqD4e0/OLzI8WyMrmn3Hsbt3sFParIyj//+yZX6HP6TBQwLNltD3OkJHYDqv2fXIgZLDNzkaab3LYvUm5gQ9i5iJ50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksiDJMFQR4IGAKZGgbYyqBg2c3MugDkCNuL0vX2N3DI=;
 b=elrLkzGVwRSFIE+x1JvUd+BDYS3JCdbqDRzaYhSglwKxF06smqKr6WlhQC2rbG/aQFuFsHXEVVJXXgF4BFlbWpGjuZMuTCMFr6TitQzbV2INYA1vMyElwJLNoo4FHwMqJKAEo0z/onjLuVV9ycsIevgyIbhh7Q5lBUKRdwaBR0K/KtBdclGmOo2o5ZyQN3pRfruMeac6F9KPDBWtb6z5Qjq3xl2OJv9FfCyTOlirg5XqVwbS8TIc0U7V2RIMTsIxn3+PI+LablsxMzFbOk0oSoFScSNW7jyFSVtIPnwjLPOvzIAjlq3ipdmqjv6gAyAEq+Spy0/EeZQnTURt0P3tZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB6331.namprd11.prod.outlook.com (2603:10b6:510:1fd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 06:47:45 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.022; Tue, 5 Dec 2023
 06:47:45 +0000
Date:   Tue, 5 Dec 2023 14:43:11 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     kernel test robot <lkp@intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: drivers/pinctrl/pinctrl-mcp23s08.c:1: warning: no structured
 comments found
Message-ID: <ZW7Gfyr5UqEnb9An@yujie-X299>
References: <202311220421.xKye7ZRO-lkp@intel.com>
 <6ab5bc0f-3945-43be-ab66-439402ca9a81@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6ab5bc0f-3945-43be-ab66-439402ca9a81@infradead.org>
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 4787e777-b634-461e-b3db-08dbf55e1599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bccY3d50w67xsYiBvwU5tYr/5GplgDGboBXAQNaFe+IJvgDvHwNVF9pQIK/0M1ZxFrM7VmU81o0jD+19+awBwqiyGsJKEj2ZZkQkrsq/1hhb2as9jUekVpRZ7/f4onvdvM7JO2q5IyPdJmBdzCTx11ZFEQmEnAGDVeR8npXRAHaXIQnKWuEGXmwdsdKxTzSJUxrB9dFPjZGjp8m+g2DUpnc6Se57r6aIYIWpwEc+OtWl0Nx8JdOWauUsC1N1n3cfcBHO0ffjY4weZI6foaBL2d3S5SH3u6GObo87t9Sz19i+cD0t/gNwa1RhWwTm3OzUEmDYqXsuib/A37NdXXbeFwT9LHWLPwYS0281Vfj+YmW+iv2XKCGETxRMQ3C6qQfoyV9r9zj/wmI68EcAtTwPkyu9lxEZle1TRHDFRNpXoGcjMtTiF0pu4oubVjsLlWt2OgguG1quvlgmkGiK44jRiZhYFFI0RZTQ0OKs42rDoCZjAOlaE26un9Exkj0wBPugUqGYYn0OHc0AtpTKCoqbYKulgDT1e4IYvqPQP9bARZ8ckD/a4SmDkRN1+1a03haGKZLgvlMgvCQaFz3OJqDIb9frRSUbjDs6A8HtPubLb5s7PUlzW3BZHarBTYyUDI0voZLHIc+XilgfUOblgAHdVKLYUrzutu9LSR9Sl3jPT5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(1800799012)(64100799003)(6666004)(6512007)(6506007)(9686003)(53546011)(316002)(66476007)(66556008)(66946007)(6916009)(54906003)(83380400001)(26005)(8676002)(4326008)(38100700002)(6486002)(478600001)(82960400001)(966005)(8936002)(2906002)(41300700001)(5660300002)(44832011)(86362001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?98cjqT01llAYQYooM3rukf4nNdeb2uaL5dCdFAl3LOspklVtCxcS6pja/Cqv?=
 =?us-ascii?Q?WscSiUkQBSRxIAFtCTE14WtwQuWJP2RXPSWI+Pp9jPf9a9GZvWq/Ko61ZUz6?=
 =?us-ascii?Q?5FyVuZbC43nz5dWuCfGYy2kNpZu0s0wfz9Bs7lXgYXYyYsE9eELswcNYsnEA?=
 =?us-ascii?Q?oCIkGUdJxfYiQmnhzkrxWXPxqMy/4HToD5vNpMPJ8M58FAIva9gmz5Asioof?=
 =?us-ascii?Q?lzcH5xDobP74P0QATE6BvpFjk+5tFVcUEZWfYHcvnRbnepntX1qIiV3CkEVl?=
 =?us-ascii?Q?KB1kmmYfYU6dbedHlXg1PkKXZIZWz7ExA+exvH8ceLO5uaEiboegbreInhmz?=
 =?us-ascii?Q?snkz5H9R5bYvhHTmJVWiFssXTy/7MbHPnzvL8Lb2Ox2pxACslXSrY4qo2KYC?=
 =?us-ascii?Q?TwjsR9nJdjzQ5VwHC69qTkoL+ys4rdlf+42TwG5rNmu7P6N1nWtY5xNAoEGF?=
 =?us-ascii?Q?LttK5KLtRyhm58NawpKoR2QiL+wMGCNIyBlealpadnwUnOzqrC5dHUu2sCjy?=
 =?us-ascii?Q?cXLHUTcTFUexFHlPGPPxxbAic3hcMRmFP4oa3XJhJSqOMlaPlanjKH7OIWjF?=
 =?us-ascii?Q?feA2GC1Fgf+hbnb+PXBcrUs9jjtv+uWa8ogEydJzkruCpqnZzb2ZMZEAla5d?=
 =?us-ascii?Q?yEfz+pj5CXRuXC1f+i6X/ykXs2AdM1KHhIo43BUBX3klrPXuMf5AYf3IvL6w?=
 =?us-ascii?Q?Yu1uU/INlYEz9vnhvyPNMLBXaJh/4yeMoIbeSQWxqP/O16vDtiPBu6KdKs3l?=
 =?us-ascii?Q?kesF4FOFAstEgGJ9bDwq52WP0MHsZN11VH+nndGskdEQt5c05gpjv5H4qAu+?=
 =?us-ascii?Q?du129vdRcoac6mG3r0QR9YkX23rgLVIqGL3xnJB64vAoQ5YXnOIl+/a0E5Hw?=
 =?us-ascii?Q?vKqj0jKZF3+O0goWbbzUha5EvOGO1b4UeuOYoF/yFnObk+TGGNpTwMih2mMu?=
 =?us-ascii?Q?C2oHA74b05DCEZjpPUPj0nQWx6Gy7xcjtvQlFZLV9vBI4uzkgwwr+hYhr+Ii?=
 =?us-ascii?Q?LW2rdY0ARJVlVa1NLeX8VktUNdD/LUi1u2eiZAjCHQMUeJ6XAqf/BIjz73RH?=
 =?us-ascii?Q?vRusPaBxkMqFmEH1WnvtZT+Rg8CcfgWOJQGigmyUHrgxRfcPDV5Yp3vE4tnw?=
 =?us-ascii?Q?bto8aRmjo+W7cXafw3VDhWWxGFplEdDwbUyYOU3Yg5i1U9qKq+vgQbUApRGF?=
 =?us-ascii?Q?HwgAUObY+CxJeHG7qEkqAEzDNkc+3QOq4p1IjlZIqJ/UKH5lHq35tUE66YcF?=
 =?us-ascii?Q?VnBbMBDaxNS1f0SyIcxnlzjeDw2tuC9b6imz5R7kEg3J1+2sLbXGeBmS/PTm?=
 =?us-ascii?Q?ACGOc1k6gaHj2CJrd6OJ4NTZ4fZ6+Hn4FyqHxxAe6Di1mFnFhXfgPXftdPTh?=
 =?us-ascii?Q?YAESsq0e/8Rug+2f/2OfaHy5Tk00sSghEtEyqxvdr95Et3kmZCrWZj6OZZO6?=
 =?us-ascii?Q?RfO1DAo+PvZU7dGtGPmTGAyYRaq32GLC+w+xmx02q47KIYjwtXwSbHdndEnz?=
 =?us-ascii?Q?uKh7SQK752vnOumC555UFQibPd22p5rwvp5yZif/0MzCIkumewaeekA5ojMP?=
 =?us-ascii?Q?vV1moyBHAyFBgf1peFYm77gtfmqSIuImDHsKUdiu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4787e777-b634-461e-b3db-08dbf55e1599
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:47:44.6086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoGiZAMlQ/BVRs9JXaWBvxjXLVj+SoNIR3i6JE0acm8vmqXJ45/1jZ/F4n5mN9eJLKk6AkTlaxDYZRiP0uMi8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6331
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

Hi Randy,

On Fri, Dec 01, 2023 at 04:53:22PM -0800, Randy Dunlap wrote:
> Hi lkp,
> 
> On 11/21/23 13:12, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
> > commit: d8f4494e70ae5fef159719bfbb6abedc53619bf1 pinctrl: mcp23s08: drop comment about missing irq support
> > date:   7 years ago
> > config: i386-randconfig-002-20231120 (https://download.01.org/0day-ci/archive/20231122/202311220421.xKye7ZRO-lkp@intel.com/config)
> > compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220421.xKye7ZRO-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311220421.xKye7ZRO-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/pinctrl/pinctrl-mcp23s08.c: In function 'mcp_pinconf_set':
> >    drivers/pinctrl/pinctrl-mcp23s08.c:282:6: warning: variable 'val' set but not used [-Wunused-but-set-variable]
> >      u16 val;
> >          ^~~
> >    drivers/pinctrl/pinctrl-mcp23s08.c:281:11: warning: variable 'mask' set but not used [-Wunused-but-set-variable]
> >      u32 arg, mask;
> >               ^~~~
> >>> drivers/pinctrl/pinctrl-mcp23s08.c:1: warning: no structured comments found
> > 
> > 
> > vim +1 drivers/pinctrl/pinctrl-mcp23s08.c
> > 
> >    > 1	/* MCP23S08 SPI/I2C GPIO driver */
> >      2	
> 
> 
> What is the issue here?
> I fail to see a problem.
> 
> I cannot reproduce the $Subject warning message.

Please ignore this false report of kernel-doc warning.
Sorry for the noise.

Best Regards,
Yujie
