Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5807A0152
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbjINKLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbjINKLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:11:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB41BEC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694686299; x=1726222299;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zajzbg3Rb/LlajFeS8qJc17hi5gDEbClDpSPuV9Xhbw=;
  b=FNJ7rMVNHphhWMu0TMzthqKef6Mn9T4vKytu7RPNQLikZrRjgwAnAqHT
   +O5QuYGdo578SA1E3tPEo+ohSKKPfcECN+E11en5iAP4rfzLW/HVtwe5t
   wg9Kpa6BHRZcX9Rze0q+WvaYYDSUou5Bm0sFRtXmHazpol/drRSZHLUQw
   cvIY2UZQWECoX/kNfIXsN9i90ukqLo8nHnoRfXoVj/+TO1lUlU8iXZsas
   HZ3JedQ6AVoOr30XvIokxZiYFSOsWnHxFmg4f47Kv7wI0PS0W9ETVZg8R
   I7Ftwy5xIRbimT57IN13xBi0DI5Ww/3nH78fxIeTblz0+gN5eijDoEY5o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363947722"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="363947722"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 03:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="773837905"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="773837905"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 03:11:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 03:11:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 03:11:28 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 03:11:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPrM2/7cscCFrm08ga80Ne0FUsIpRMwGjYJVdRKC9s8RyUSYGsqd7HOW3zkhQ5+n1C7XH3wpw0G74+OZos/v7FG0zLC+J8pdOYxQcqAjt34RMd7c11gNUbl/BWz/vzLJthV6pxWTRmqeG59j2S+ZVUPIirlLmjuTrSsOKNYGB4XodfqaAgjLIyMbn9tAgz8RM5mOAAcPIMbUZI8rxaHoa2EuVYsoSmS0aCCIjjN3sKsfSYGaoJd/dy5yEtKwKRNA4YhhCWqi19r+kr/1rcKCLripUviMVjK+dGt8Q1XGtPK46HcNAseU7ay/9lRrazZZ2nn9A9ci6cYYO4IWmtmyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F4LcX0OaNPBX/++mwrbgsYdR8mXyGCOfHSBvWjkr+k=;
 b=Q9DAz4rjdTyhz+hDGeevjkLN4ozdSE6FwX3XdLK1ikomKdM3yqWIr3cOtbQc7MIXfq/YcuzWq/Q/4GhBD8Gg5FdSa03GvNP3TFkCOYL2/vMOrtD4I2lDdJEyYUp3wU/uD6cYP0BdauaK96IFkkFOeeprM+3csOwEhKSJdbj0qasQiJ0YOc8w5LH96wUTyjx60ILKp9Mfp2KQjqo8KY30X5LNQyQLN9RSTm+RHVhdGvKrqKD3G5gHtKDkmE7FkjYTC+UEjKasfS+b+p9wFGO/SrPmil4Dhw6NRWMpFTfBcjrIZb+cQDWuMVbIJTnZE4yeInDP7MaXwhM3cBLCnjb0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 10:11:26 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::357b:2c33:35f0:ed0b]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::357b:2c33:35f0:ed0b%5]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 10:11:25 +0000
Date:   Thu, 14 Sep 2023 18:11:12 +0800
From:   Philip Li <philip.li@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in
 final BE8 format
Message-ID: <ZQLcQARpjBzYzgVF@rli9-mobl>
References: <202309141131.pNe5J6HH-lkp@intel.com>
 <5cace191-31f6-4aa5-8b19-aa6c1f2db7e6@app.fastmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5cace191-31f6-4aa5-8b19-aa6c1f2db7e6@app.fastmail.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CY8PR11MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 1015dc9e-84bc-4eaf-c5f7-08dbb50af360
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxSV721ca5reLwP+VcB/AxdcD+4ERtBRnGg+XHOjb2wfC/320FO8CmepDlQEgxp23/XmFvyahPE3gTw/VqFKTVXJpFVtg7rTVJ1XUx/wxCjr48c899p3FtaIas/4K1Rl+C7xEFBG1EutlcA3KcYlrVqyD6lrtuu8qne0CwA0WImGWysbMfjJ98Wh7MAlb/ZKAAYuVtyNzWHWdu0CUFE+/tIYpl3HJTBCZTAf3pdm+TvHK4yVKAvXEkpa9Qm3LuY/+21mrtF6Od3ugdYcmAqqR0f5yZ7q7zy1ppCQYu7sQPGWkpS/6UfnHGH19FlD62y4AXh0tBGufv6CXdmrA4uHLjOVdw68kitftj2NJgVIeLS3MOZYHOBeidoDq3u17LrdAP0tAHSZKcS65+z4el8s5ekfpZK9PVasAeM9DJaj4pPpHjJ4+tPnxYqAQ0BSd5f5XhwhFfs26UASEZcsSABkwTLHlAtHGdb07ImFKCwySu9COn8J4F3MdIVe1VBe06KGzmfQwZ9U7zYwm0eRp6ynOz6jcBAw68/FBa3VZdkln/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(396003)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(316002)(8936002)(41300700001)(8676002)(6486002)(86362001)(33716001)(66556008)(82960400001)(478600001)(54906003)(66946007)(38100700002)(2906002)(66476007)(6916009)(4744005)(6506007)(966005)(5660300002)(44832011)(6512007)(26005)(83380400001)(6666004)(4326008)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9T8xpY1M0otNKtD2RK8GfUesjR4oQTM6uWZSSIYF5NpNvWpqOIUnPnolGFtJ?=
 =?us-ascii?Q?K6/nH3n8mYVW4UjphJouHGh2P+aMndIrsoGB4kEqKv0IgKPtVcSKVnLUn6rd?=
 =?us-ascii?Q?JsZwE4nb5zyVJ5lhYpQbMxPvRgd8I7D7op7BNBQxVXEYU3u9Ab25cSWR1elf?=
 =?us-ascii?Q?fmIyeOQstMcp0973XE31T7eHGOW+S+x19fMrbAbMaLJt3QTr6qezOrZ41wRo?=
 =?us-ascii?Q?IyEW4qahiYQ66vm59+Ydgyp/nqAopDUI1l4MyCwMWIfXJEZvUiFcPa9vKL77?=
 =?us-ascii?Q?5vdO5cqqNddSw5n0qoZg/TUR9FmvKG1K3S5aRMZ4h/PYXtiYP0mmrFM61Qk4?=
 =?us-ascii?Q?qyRJYbV6jtF3UkQOK+1rX+gthyKvq8CqpeTLJCJlaqGThxtcuhqVDhCzRVVE?=
 =?us-ascii?Q?e1xAN8HofB2IkgtMTMYL0Ww//5MozfPdephQgeBxmmuF5IsmdZzdvVQbG9l1?=
 =?us-ascii?Q?nz1axKFzqqpOyD/qpjB0iDnEI8IvMDfIxar5XrrW442ZpQuprJJN92tljoqC?=
 =?us-ascii?Q?7pR5atWzp2wDly6oNMq8LrKsvQYxWE3hlYoBi/br9NiBs/nu4S+P5gf5NxdH?=
 =?us-ascii?Q?Av1Aen21GAl1xHgKYXmnE/HncqZPWzTuB17+CZWOpBIaBzm95F5SCMh38mjJ?=
 =?us-ascii?Q?ZavPjd7bdmj/vjNngZtRlEqbamIkklviRVRFOGUzRDxv5zqvij6gSgS5K+u6?=
 =?us-ascii?Q?F6bMzI2mDRlliF8U8GPm/siay7DTRCmrlNOLu7kNKU1V04GZ9ISDXFnIydy3?=
 =?us-ascii?Q?W10vWYXfsRPxiqIJB1h0tkgGaI0GYQjzI0wzNH3sDG2/bQo0V/UGttQKYxyL?=
 =?us-ascii?Q?jvzcpv/uWkCnZc+266IR3AhfsYzKAbj8u9TU0eQQB2gZ1VFt7a8glS+24AOu?=
 =?us-ascii?Q?u7LUuG/fCeLZ6VzveGlvs1O99LPNZR59DAs11Yl9QkRm//3/uaee8JaXfyEO?=
 =?us-ascii?Q?VJ1BD7auWufjMPPhlf0IS/hFmKD5klLfZPEnsLbiULoY66W084lTtbnVeeKJ?=
 =?us-ascii?Q?7iqpIW7lE1u/CBaOskNHpPzcpdKhRmFM25OvlX38jQ8+XpT4PirGg9Y3yN9x?=
 =?us-ascii?Q?FTImoG0oVQjcOC0J3lg8R7c/zYMTb8qHffZvB47oHx6gxIAXpSBsplmupkVs?=
 =?us-ascii?Q?kpDGs5vweSpZNdQdv2YwYoZD2XgTPzhNhJAEg8r5psLTXQ80qNg44iHv/AQU?=
 =?us-ascii?Q?h7deNGYtLDPlhvnAMgtrG6GNOPmylyrGn1VJa9xBkCg+yJuaWNyGjO9t+6p3?=
 =?us-ascii?Q?RPOaour1FQD1CbjG/pybP4dq9KQlnyJbGZ+s/+JeL6mBV7jk+3esr2z08bB3?=
 =?us-ascii?Q?zNzmEHeNDKDbJKSK/0Sytx96XEqzH3YeMIRSpKa+ObG5dBiqVizgBKFkPkvv?=
 =?us-ascii?Q?93YpBvY5TNDNJx6B4V2NDm8778vSuVEKi1kQdyigFnzzlK/ml9/8jljax5Pf?=
 =?us-ascii?Q?UJO3tLV1MeZCIBwBQJBB4Gu9FV3jTALAc5Ib7TVca1HJHS8pFpdf0BO/OXhS?=
 =?us-ascii?Q?GcGG8h5oE2eiafGdUl2gxiEc7iHQwHccv42PX43rRaN3DQILIRRTbKqxRpYj?=
 =?us-ascii?Q?l3GlSbRkUwqvAgwlEFw7l5B3498AZdjwVJDM0PlB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1015dc9e-84bc-4eaf-c5f7-08dbb50af360
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:11:24.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QJ57tkfCLpBlBzfNIk3/qiDg8yY2R9OVwZlRF01Iv1ZTH5EPva3jwXySWegcZ5P1eC53O03XWRIR4JhzT52hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 07:08:14AM +0200, Arnd Bergmann wrote:
> On Thu, Sep 14, 2023, at 05:45, kernel test robot wrote:
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new 
> > version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: 
> > https://lore.kernel.org/oe-kbuild-all/202309141131.pNe5J6HH-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >>> arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in final BE8 format
> >    arm-linux-gnueabi-ld: failed to merge target specific data of file 
> > .btf.vmlinux.bin.o
> 
> It's a completely unrelated issue at the link stage that gets
> exposed by fixing the other bug. I don't see this in my

Thanks Arnd for the info, we will check and avoid wrong bisection
for this. Sorry for the noise.

> randconfig builds right now, so I probably have a workaround for
> it somewhere, but I can't find it.
> 
>      Arnd
