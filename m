Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D805A7A016C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbjINKQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbjINKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:16:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB401BE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694686609; x=1726222609;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZVAuC6HbyvEXdfqtsFu8ykcwX5KtwS5anFVt6XLqwWA=;
  b=bD8yaxXjagG9d3sQRXXhxwa39PyPGN+rI6fKCCLyqmx4Z9V+cIkZ4RbE
   GXDfB8628Uiv2PIW+rHFoStO+QsCgZDyDY+EQcJEXa7pwXjJiWPB7e3tJ
   KnUwCE9qjLtpTKUFSM/F3k9Oox7dJbCzvDFWBGJr/6FeW++YkBFNxIDHf
   Z9CYHZBeJJlZW7nz8Kk60dqxI1Tjzr1YkjLlADBKCD9RK6EbMRKFlnEuY
   3XSgy0r6IIerd3ttrIa1tmQcY0USV5CT83G95zXXUDlwyL7QI6bQNCh0k
   IuE0ptBcBaXYX0wuoQnQWNrZz5anJCKG8DUaiONw6JrL+Scm9WJ4ZFULf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359172152"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="359172152"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 03:16:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="868193031"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="868193031"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 03:16:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 03:16:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 03:16:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 03:16:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 03:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfZRIgyW6jQegSwnsmiq8B/bk2xJ08c+A2FuvzAf1LF+J38vbOuFcTEuDATA90DWQIzD9kwknYciHvVooAYjdcTWX+KeUWVqUKGi9zZHSR3y1QfS9BI8BPfOmpt+40DkfNLE+JzZTM3SRq6yHvikEDu8gYuIkXbQrwmCou+KnogVPNjIKYoKFsj+DTCfUD7gcFpn/UzAxYd6vBuARc0TqE0IByhsJGXDL3KiKhaGdasjwRmAPCPH0EZJYBnUVFTE2MD9RecIeyMvQ7Vsh8XHUqVAffDocdILcm5ATNf1gjbFSL/OqSzJqGWnHiKOF+IIF79rys1PRCl4d/bnxE/t4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbr/E6v7oxZh25sENHdN7gQIBHoKwHLB2uJTzYcFrgM=;
 b=XGFjTKAf/5jzS8WdAXHboEiY+8smG/K2zZ0HrrTFI1AnZ2R76/mDIX/zXHfU2RqjH4zqtaLKwYTyzm/NSdQ2Nri2A9GRrnjGK1ZChayp7oYIoPnYU1TDaxqmOTp+q1le4v2LE00Va19NTxI6QqUJb049IoUJYRY5HgkCIRgf5y8t/ivBpeaY6VKodd/KjTlEa1+CCM6FiFyw74DT2UL23TJiRDZkfJM39urv+EMpUFqwCUI2gepc4zf4809otsk36fFMXQWYg73zVeXDHrnVKBTE9hns45ZLo9PBIfSn3RMQyrYuP7bOA7nGV9xUZzJ1ycUzqq63mShEa6rGTxLoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 10:16:45 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::357b:2c33:35f0:ed0b]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::357b:2c33:35f0:ed0b%5]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 10:16:45 +0000
Date:   Thu, 14 Sep 2023 18:16:31 +0800
From:   Philip Li <philip.li@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in
 final BE8 format
Message-ID: <ZQLdf5hS6j4vtI77@rli9-mobl>
References: <202309141131.pNe5J6HH-lkp@intel.com>
 <5cace191-31f6-4aa5-8b19-aa6c1f2db7e6@app.fastmail.com>
 <ZQLcQARpjBzYzgVF@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZQLcQARpjBzYzgVF@rli9-mobl>
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CY8PR11MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: dc843fef-15fe-4011-2618-08dbb50bb272
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02AWq/9UG/itD/R//LUVar4NWbAqrrMCTgr9jEucZlss1bEGgPRBewrl4ODaNrtj/t07TsaijKEdJxF7FmtJOCSeM/VER4IfIvxjLeyP+pHOjYKydYWLvUX91SH6xRkfjPQPNkyGakHTBPfZbOnYAMfG2+l4BsHtQ7JmIJVr9tksd4XK0O9MznlUa/d5T0ePk8TIc5xcu1TF1euSKkLy5EvRZX7it6rWpagIDE3ZsVk4W32kQZu2EuYoFX9Ncvf+OZfPiBIp/Cadn7Nq49ypGlNLr1wtz+AH+13A6mswRa9Y46xucMRyDh+VpvKNrohgdnAogBpjjAHhDuAKnrwfGk0ajacHQU5pcyogy+7sIhAYg7Iwbz5+Jd65MpEhHdgW6tQY9t3lYLdAIGn+2kaJg2yiVtCAKCW/35tt2IERoiXCRoYhEVsmkaxt0Im9lc/KGRisGy9dVmnNUiGm3ifYBEcjIfnWSUZ7MCXsQGQFrsN2C+mWxM/tiUu2p6Nn7EJ8CenLkjk/nzQ7d0htjL/dgBpcIvvklynCz3spvGQHT3oxat+cqkXY7uHlfn4llfCcEJFjuEais0zxS6XJ+aD/fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(396003)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(316002)(8936002)(41300700001)(8676002)(6486002)(86362001)(33716001)(66556008)(82960400001)(478600001)(54906003)(66946007)(38100700002)(2906002)(66476007)(6916009)(6506007)(966005)(5660300002)(44832011)(6512007)(26005)(83380400001)(6666004)(4326008)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9eHvxO4DjxzpBOqSvuLNOtDBB5gNGBSKUNg24JqgDiYN2Ss4BVBKRKv/12U/?=
 =?us-ascii?Q?Sxzm0/Vuf2OsmCCijli7c/iuD6L6xBAxqyJvqM4eE8xYKcPCGq8wSpDTmvqG?=
 =?us-ascii?Q?l/IjlqSqoE+KDSWCFv2fKZ/+MIl/hReKCueBm2LTka4eAOLSFEVdCg5HxVYj?=
 =?us-ascii?Q?iMyl79yFP5HnWn8kCurNGslJTGgmtX+M8F82S1x6MVHvCjAG1Os3FKMJcZJx?=
 =?us-ascii?Q?owSFciEVcEGmjVjS6RhCzW922Wlao9EW2DAk81CPBRIwSqItAXMpbMuSO5h9?=
 =?us-ascii?Q?m+nR+T9h4Y+apZ/SJ1e7b/nM+zgu0QrDhEYuLUjtyCOYY/WuQM3UxH6ClcWn?=
 =?us-ascii?Q?wdPgMbMmocpR0HxqJsrw/eIzfd2+2g+Ja0d8L4zIsKwl2bZ/dujZQYJGNrkd?=
 =?us-ascii?Q?0AAoVcmwgx3wkRnYuqx0zoqEpLg2+hjyTL0g0b0TLZDwwlJvFTf/F1ty1iAO?=
 =?us-ascii?Q?mikm9/iVPme65AM6DPDCVvNa6JZFOgKQ+iSk9vCy6rKN9+2P4joDRhaUvIsP?=
 =?us-ascii?Q?HUVL5qDes4pmp+cRw7xYQ67xx5bMrosGQAsCP/oH90vrTu3MX77A5vSwcG2K?=
 =?us-ascii?Q?wOZbqCy7MJ9c8d5HXrfUXO7lk80Nlw2OnYxwYRglkE8i7Ojkh6i8Eo6UGLwq?=
 =?us-ascii?Q?fXSvfAexgu0la5goXJkFq030eX+uA7pkziB8KgasBQV3mXLuW1O8WJggol+A?=
 =?us-ascii?Q?XWBK1dERySzsKLelZSbX4hA98t1vGPmJKF8ejOs0Y0dErRS2EBUYJo+pM6pX?=
 =?us-ascii?Q?UC7qgHchiR/XresthUvCyHQiZO+wClZaUHUKywO9xgrPYi6hQ6uurRytz30U?=
 =?us-ascii?Q?J9GHVLeg8/daWewlFYJ5m0k7OCcBO7TBWVAHxwSNHl/U1VhYFQcRUdqiyg58?=
 =?us-ascii?Q?KCDiPI9Sp6FmE7UgXtaBHzcmUJBX5sCDekKY3nHHpGTp0q0GeCDiT5Z+c/gM?=
 =?us-ascii?Q?cabdc04TPgsHCf090rk/PtEHHSBXYq48cxyDJaxG5BvOARXeK67rRdG90n46?=
 =?us-ascii?Q?MRoV1bGffGc8fIrlKMvB2052h0Dh3PRS5b6f9QSXniw8CKM2Pty67gWYeyhd?=
 =?us-ascii?Q?YeSEEtWUEK8u0c2VLRmitbMUNFz94E8wBmN8mTJLJSYdciMg5ScIt3zWPD/V?=
 =?us-ascii?Q?XPg4Dwvsz1Kv8wwJTC9TjrP1Z5ASRsKYc8irXQvqQe2NzAF/tDOrfLXYTF7T?=
 =?us-ascii?Q?SmzeLTkeAZnA+OwDWh74wyhGbFVVcbp8InzjsaNry6WmRalHzsrVSrlKtOzx?=
 =?us-ascii?Q?hXGBsJm9E1G08pUW3yVJVZupJkMG/15/RMsLJ2pGl+3tcgxuYws3myqoA/0n?=
 =?us-ascii?Q?femSJh0ZEGznexazkdQyZm5PmyoN4Iuijr3qbD3HvRMjceXvKYhBWl+MrK/t?=
 =?us-ascii?Q?Jd3ier8GGDajqczu/sG6kphyjOI/Ew6+5MHD+opVHqKkisTck0LTRucSAHk7?=
 =?us-ascii?Q?WodImV3DeGuNsV9wlQFcrPUWcBLcAahj6TUqtvHAwArl59TalXeeQu3qVPk7?=
 =?us-ascii?Q?BxKCRgSxOQXqwIPzxWKOXmAJe/tDAUomluwolpzze6PGpFhNpiYpBKvgW9b8?=
 =?us-ascii?Q?ElGfGx4OGZwJQUYJtoCi+Kz1CBK7llSIvwadoGEq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc843fef-15fe-4011-2618-08dbb50bb272
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:16:45.1888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNsqjgqWvQxfB6bs/GPt7bIrdqOaTxWJYD9wuT8T6yCRG5FfCK9dGBf+eGmredQoG9xY3MezfisIMsyANRw1aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 06:11:12PM +0800, Philip Li wrote:
> On Thu, Sep 14, 2023 at 07:08:14AM +0200, Arnd Bergmann wrote:
> > On Thu, Sep 14, 2023, at 05:45, kernel test robot wrote:
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new 
> > > version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: 
> > > https://lore.kernel.org/oe-kbuild-all/202309141131.pNe5J6HH-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >>> arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in final BE8 format
> > >    arm-linux-gnueabi-ld: failed to merge target specific data of file 
> > > .btf.vmlinux.bin.o
> > 
> > It's a completely unrelated issue at the link stage that gets
> > exposed by fixing the other bug. I don't see this in my
> 
> Thanks Arnd for the info, we will check and avoid wrong bisection
> for this. Sorry for the noise.

BTW: i found this false positive had been reported multiple times in history,
in your previous reply [0], you had mentioned below to add a Kconfig dependency,
is it the workaround you refer to?

	>
	> >> arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in final BE8 format
	>    arm-linux-gnueabi-ld: failed to merge target specific data of file .btf.vmlinux.bin.o

	I had a look at this bug, and found that this is not caused by my commit, but
	rather is the result of CONFIG_CPU_BIG_ENDIAN with BE8 format being
	incompatible with CONFIG_DEBUG_INFO_BTF.

	I'm sure there is an easy fix but I have not found it. Should we just
	add a Kconfig
	dependency to prevent this, or does anyone have an idea for a proper fix?

https://lore.kernel.org/oe-kbuild-all/CAK8P3a3dvzLhAGV8rdCpX__54vkL0=e5pACUY-es3xiJau=uwg@mail.gmail.com/

> 
> > randconfig builds right now, so I probably have a workaround for
> > it somewhere, but I can't find it.
> > 
> >      Arnd
