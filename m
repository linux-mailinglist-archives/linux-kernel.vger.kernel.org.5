Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138997A0507
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbjINNI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbjINNI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:08:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2001A5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694696932; x=1726232932;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1HhbY0gpHf5kbwNQZVpMzK9dLHGRFdq3K/ZSfmaQKqc=;
  b=E3Ssxsl/m60n+VPe7okphlWNoKJRzXkF3RQWYdGU0DLOcQ57wmwUFFHH
   k6jfR08bNINl8Au/aPuz+Y1PpI0liCLygYmECA8umDXrWRYC23P9hHAak
   405gl0o7ukdhA6vucLaaaCmL3lTC+JlEz40lzww0thrwCqqLghS81AWNK
   uyIT5W8BAl/BBYM9XLR+KnQUJnPv/PP+iRbJObmm/IR77Vsl/IaKzSwsS
   UPyQ148Rj9t6e/VXQJLYoHqH5dgLpYro6EPRLtnwvgoTpRRFwBMlO4UXx
   UNhW9MyuQkzWAOg5S6/6GXe9Jrznhm9HfDxsG1+bjNGxAMHudRywdyrZV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="376279300"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="376279300"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 06:07:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="694247435"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="694247435"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 06:07:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 06:07:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 06:07:25 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 06:07:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6DHurnAloRlCQL75axnzI2I+SctW3qrtB/BG5RvTYrZZjtva5A2OHtVix6EkKvOUWYZSmT3Da40GTpMEoFLsM6BjtwSzcNFMNcBD5YIxG4fN59itbwhJXDOZH7biYVqVEfCgYFXYewxWJ40xvtYiDTP7ua5t8OgBNfPVnEtoFymDBJNOMy9uy0QFXd1JeUpQ4sOMmyhkxGZdD62Dkn9c0kP1JKzFDXPxcuhgxxhMvu5uvtPYWqTO1xLqUZkNCgl/hVz8rnJ8+1xH3k1nG2QX/vLgKPbGuwGFRhgRhBoQwNan7g+0b/QwgILR+Iyd8FgTbBUcwQWRZuyIlvHMseFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYWfRer64BfEXiwSY2VjvO/L4ZMjPg0ZYYWAm30GZJk=;
 b=BCWGy53iQLT1+sM6VyCEMTmk/w2t7fimLv0RGw3iizsudz4QvS7eobpsfYGz7dtBmqgL0azruuqsRkWQepnLC6eyDx6KUemXzNTzKTspHwK6xYCJwUehvRwNInS2+IPCW3fT0TCV+ITXiiMYBWn6154k6nOCT7oXf5TqcgBC7HJnhAzwMdbLtwsf45Iya96pwEPB2U+C2jWilOiW/7jYgQ3SrxZ4AvcOXU1eTrggJ2QasL+ac4j7mA6+IlAFZBuUBNFxDzwHmr6ye9Ia34qxQKJkbIdhM+pLtGR73pX0f17HSlgi9M3gYb8SfqVwdPBp2Qj+JNZqD3YDC6jlXzHhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SA3PR11MB7528.namprd11.prod.outlook.com (2603:10b6:806:317::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 13:07:23 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::357b:2c33:35f0:ed0b]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::357b:2c33:35f0:ed0b%5]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 13:07:22 +0000
Date:   Thu, 14 Sep 2023 21:07:12 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: ERROR: start_text address is c000000000000700, should be
 c000000000000100
Message-ID: <ZQMFgGrEzmz+SMO8@rli9-mobl>
References: <202309131336.uIwzjLmq-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202309131336.uIwzjLmq-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SA3PR11MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c6ef70-4a4e-4e73-da5d-08dbb523886f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auYm/M9IvGS/xxp0fxAVsG206t2+syoc4vfiw2Bx0nEMaSmxwL53plLzio9n/rwgihPPlbbmtFLIKPkzAyPaVXc8FpK9eklQG3gpiP7ZSGGiXTji4ah4obPY6PZpJYIbvuH6K9oPEnenkkNlot5ugcerrAFd9VyyJqcg+Uj3nu+LG7sNvmWkNJV+Q5J9iGNQEf/nHd//dcYH2G9v395UJrml3tLX3ZFPdg97ofqMsjjkvW/BEf72Kl5JaOZwJeyTZ91c0nVIHknp42MsonxYaPosr40/n6xITLwehEOZVvjQjxPeK1x4SFWuTI8oxUWoX4HK9pHiI7BuXoyXOsc1r/1x+irG/z0CKOePEAeKDVMWJ6A6oKDteICSSx93OJavwav9GO+Xq7uKeKIpA48ot3FvzNMPNFe33LJsvp+psawHn7HKNw1WCDA0mx6fLhisf02+rvC74gXD20HzAF8ImhM0GVeig1HUvziXbF37AAyhPFmRehnX2n6O8+gtPmXQ1fHEtug3aapRKwJB/JnH4e0We1/+UEi0B44yK4L5NItF8K5H7Xpu5HDw0c1u7qrN257jlXRRMLJN06r2x3snGRm6k2teWjn9aou5MtbidfmmyzMTy7SdAA7BW3HeaLZNmjAbVC0YxEh9I0JmhQqeJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199024)(1800799009)(186009)(82960400001)(6486002)(6666004)(6506007)(38100700002)(86362001)(54906003)(26005)(966005)(5660300002)(2906002)(9686003)(83380400001)(41300700001)(478600001)(66476007)(6512007)(6862004)(66946007)(4326008)(66556008)(8936002)(316002)(33716001)(6636002)(8676002)(44832011)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Svvz2OtVLcpJBNK6R4ijL7LqsFMuYqSeyEoiT7D9EC6fZr/kPgQ6o1Tq2X4D?=
 =?us-ascii?Q?ZOZL/6gVi4jKdugsGbXfb0CxxA/Xm8063E+iSdCnQArAYcHtTbifNLC2p1k9?=
 =?us-ascii?Q?P4RSScIBV/nMsPgOKRdZgxJmBkM/wkEo6MD3sUQuowv6szoWBPNfFNdwwkbw?=
 =?us-ascii?Q?Yumk3DYUuRty3q7jJY+eDBeEu8QzbW8q1gGxOpKCu1NoHY0Q9G3HWXlI7E9F?=
 =?us-ascii?Q?ZIX/S/7kE1kKCSqa66Z3fLzx/qLP5pLZ2HCyezcCv1/oCS7t6NvmyQVBvhSd?=
 =?us-ascii?Q?rRmrdk/hgWP7p00Ya93kZddVLOcelrRVNT4SAFWMQ0qYELrXCNkTF4nRj3FX?=
 =?us-ascii?Q?+A4vzdv9faEXi6IvNgTj2WI6rjRUkgBfVqfTgkbcmD+e1a7hUxESO7VziYcQ?=
 =?us-ascii?Q?MXBQEhXREtNSXm2lehGO1dOELN1tZ0Pdv7W5eGQF40lKUXkuOj+cQ6zpHUp1?=
 =?us-ascii?Q?kToYOkRHXc7TL3ElI+XOPEcqMm+4GX+gGyfE9x8Oo9eE7o9dNxQawYgnBFWw?=
 =?us-ascii?Q?ZhRr0Gl6PkyEMZ8BuOPOEXfL2jrY+hbZCEttyM65pmWvNgHvujvYlhyIoIWe?=
 =?us-ascii?Q?tdnSheuLtT188/N0Zf5sNuSqzA7PF93Bb6izoaU6oN/boLt24evITv8U8b27?=
 =?us-ascii?Q?iL9hf0qG9QZV6M8c0RaP7iF689pwiMclDZaBS7IvpM9RZHGKCxIVSIgHHhlw?=
 =?us-ascii?Q?+KLw4IVyMW+OxF1NOYye5veH7d/oQGZSDE8Va1uvrFQovdzNE+2nY1mXnB5Q?=
 =?us-ascii?Q?syqKVeYKWyf2iXLnRAeX81QSlOxAC12lwrwIOWFL3iayKFREBBAZIXt9AKuz?=
 =?us-ascii?Q?oqRI1IJu0Pg0m3IYiuCZPg9onk/CMi4n40v7icVjuaLf9UFpHnc58YaIYurK?=
 =?us-ascii?Q?JHpgVcK+Y5ezPkVKXNvRFqODG7v0eY7l/SfUcM5q9PTozcK0lIvMOXxhFvnf?=
 =?us-ascii?Q?ckupxfROvuc8POJfqkzXp7D0rjP7xUIbK1rXITardqGmT0gqNsHEGs4Apqij?=
 =?us-ascii?Q?WJ18nTJnPBcYwGUjwzrL9r+dszHlfpEnxa8onYly8Ojil+9E+8pxvTwnpWNp?=
 =?us-ascii?Q?HsiQiY2po/+EQsQcQP9Wd5DPsRBc+gMsCqGZDJeYSF6DTFslXXZ9L2RZrmTa?=
 =?us-ascii?Q?2+D0JlmXFvc1qxyaEhZe6UFDgtD2ed7JyEYLL+VYEYtHCkG0QLhfG+ObFvoQ?=
 =?us-ascii?Q?dDzaU04wY2dXoQAB8IzmlhJrwrIAG0mWjvFY3YSIqspqBe+tI5b21TZ/GRcH?=
 =?us-ascii?Q?la6vkpPq67ISSwKXUqPErs8hiuiIQ8OnYIdjj5HqrLxo+eHPquxdIQoOz5jR?=
 =?us-ascii?Q?7vJPH8IvX2HHGEt3XWNDurQlAl+VG6TSeZGzZbmgzd+Jc8GGHpoN2i4H3ZN8?=
 =?us-ascii?Q?xdIxDLyy9kD6fwPq9QFVIIF0xizSb8R46ycLbubqioLXXIkbM14VAfWtVLhE?=
 =?us-ascii?Q?zenNvbAVtheFZEgRO+Y0lgRh/7Zo1azRquB4fT1icZHTwp+4KtRuGvU7dago?=
 =?us-ascii?Q?Nf/NDOxvAJaMcM9UA9Qr6d/IQuLaAdPYbRylPu3XXDU9h2Ml1kIV5UWoGvYf?=
 =?us-ascii?Q?UyDaEBiSrLHv6iZcAZDnVhPh+FA6TL5cK0bOHhcl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c6ef70-4a4e-4e73-da5d-08dbb523886f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 13:07:22.4542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+j5crwlOym8xlZf7ZTfaPE6u635VIWKr4anGElIfdf2V68bPf5t1RwxHN3FkQz2kpuSRfu54QAnhE5LGuAdWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7528
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 01:49:42PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3669558bdf354cd352be955ef2764cde6a9bf5ec
> commit: 5750121ae7382ebac8d47ce6d68012d6cd1d7926 kbuild: list sub-directories in ./Kbuild
> date:   12 months ago
> config: powerpc64-randconfig-r006-20230913 (https://download.01.org/0day-ci/archive/20230913/202309131336.uIwzjLmq-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131336.uIwzjLmq-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309131336.uIwzjLmq-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Kindly ignore this report, we will enable LD_HEAD_STUB_CATCH for such case.

> 
> >> ERROR: start_text address is c000000000000700, should be c000000000000100
>    ERROR: try to enable LD_HEAD_STUB_CATCH config option
>    ERROR: see comments in arch/powerpc/tools/head_check.sh
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
