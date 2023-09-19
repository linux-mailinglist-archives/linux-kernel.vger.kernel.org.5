Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8850B7A6762
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjISO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjISO4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:56:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623D8C6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695135375; x=1726671375;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mjPky94+PSRKloKMTMIvn153StXyQkKNZ7nfdPDiDFI=;
  b=hfbyKCtBh729x/dTXfEyDaDyZMd7BBSgPjZLVdH4/e1nR+mMOCQMA8mp
   rEfBenRZ19DM6ipkHubk5KiiVCKdDmVZUlHF5Jn5DQRs5fLZvNqmapfIv
   KFZejYB8hNDHyJEKuxxrWQbna+tFw8D2Bp97kGgtBYoxGQ3lMfTx/Ko9M
   r/oQFkzpH05aH6AzxuYgIIgLbDB/MsMTA30HatZ8molL+OKztqK60RaQc
   nXZNst+MZCxEIgB1BI9Q1quvmUvYJOg4idoT5rVxIZjPzVIN69DjtY4v0
   s3L3WrqQHOnwaZYmTvRUxVyCQhiUd2Gy2m11G3scN478At1mnpp/THe+a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="379865918"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="379865918"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 07:56:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="816464522"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="816464522"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 07:56:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 07:56:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 07:56:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 07:56:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lix6sBt+Il6AAwONs6z1q1B5A72RJJgA19Iy5N7pUNf1a5fbTGcORVv4EBEDQTF7/+mrW3UlMWsYYxD0i+WHf6JXGHd3x8mL2sk8NWecSjVxYjNb3CGTDtJsMOxRL0sXQ8O8tow1eGHVdUO2HW48ma5sTbeIv3mbu8iH8BHA9M7ojij1VFHqsgbXVNEBUFixPxNDFI1OuyFXqU4hjvm6rQ4dtUumjdr5TDQKUtBPdyg32OFwXWCEak9wbV3ER2S4Vd/jUsSMB020AzksYUPE/qaWRMXJpTP5YzlXKd6fWfl5EDiVyNpjorAnHUW3/UFAyM1Gt8Nl8rhq6o9vlH3Rng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fwhq1y44CQhd9g3+XToVZg1M/PYFALrUhGFvXa1D4k=;
 b=NuqwhCrfUxdJ0JePOcJNZHxEBlgmunBnqcYb5GHZVSu5q5D5dGa3NVIDTpib+jQ5/CcijPx2IJIBy806drenc0TGTZN59a5zfPX9LXRNt8kde+XFn+bvrNthVym9+0EQurdcDCATFyW/e1FBv7rZePMuWDyCt9uIDMMLHWkL3NoBMJM4lVSBL24P2RSIV8vCFEBvTrqY8kpPrY+i1+ZQ5ei92/OvEIgzztlkwPrnvVBoR7NF9wpw3CUeVm2j3tCTyFBRIqtJRJoIsQfV65ekiWssUaSJlx1AO5jC2qJnFu5k8PZ+y6kSP5Vb4xFyekdXIveAAeACzluMs/xwGvV09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by PH8PR11MB7023.namprd11.prod.outlook.com (2603:10b6:510:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 14:55:34 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::9f60:c09b:128:34bf]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::9f60:c09b:128:34bf%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 14:55:34 +0000
Date:   Tue, 19 Sep 2023 22:55:23 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>
Subject: Re: warning: unknown warning option '-Wrestrict'
Message-ID: <ZQm2W9r2a+cgeaEM@rli9-mobl>
References: <202309192257.IAbw1lnx-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202309192257.IAbw1lnx-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|PH8PR11MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a3d199-cfa3-4b5c-3dac-08dbb9207a2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbVndN9Qz4Hdy8xKUlIlUtznnvzVcR0tkh1HOxdWsnrCzcSZweO1cUa5yJl0Do52RA5y/3RDjBuvciy9EhVshd7N/CeFnbTvPAGlKjq+G1SL0u8dLtdCZItjUXey+9o6xBXM6OLJc6WYG/VX5amPYlV85kpFjhTwwYiL8J07qQ/UyvNfoh7niDtvb+KY36J2UJt7xytxTM32LhKn5Lrawi5i3wfQ/Op/C49sSgPXpAgo1WeJOGsvb09ipO5sIHTKYm+8EquPZXqMVL/Q6SaPbHaiqETgKmqRGHjk9u2rCBgJcHLoN1aAhzMyQcwOJhd9e2xchGSS/JgqijFkUdLGibWdynR3L6X3NnWKKhiXAYcub8Zwy82O1dCUSsAoLZf/RELICpO/dVgY+fNQLzb2DEhSEWgKK1ZIW1NKo+JVhKCerUU1sdFp1WtGbqVr3hcv77iq7PIb0/JEh2MZEoMn4VyzJnl7wvMQEqlgZcr3hXJIosZYMXcvVXRsVWyekw/MwmpqWPx0XucWYKzA+ncx5jv/6HFmT65zjLr78oHQlFFOIXgJxmNVAXsPvELVHWc9iL/ku8N2RGCWgv7NUzu/dL3Nj0Vbe0oVYLyhK61TDGx3gSRjCPabQB1xcdw+/LTcVqUYYTqFV33sRGfy5AdzqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(366004)(39860400002)(376002)(186009)(451199024)(1800799009)(316002)(41300700001)(54906003)(66476007)(66556008)(66946007)(6636002)(8936002)(8676002)(82960400001)(6862004)(4326008)(6486002)(6506007)(966005)(6512007)(9686003)(478600001)(6666004)(83380400001)(26005)(33716001)(86362001)(2906002)(38100700002)(44832011)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mvabf4+Kx/RURyCjk2JygS3PdSq41ZdvyDMmqqtGKXRGVKdya68CgWzLIc0J?=
 =?us-ascii?Q?lB4l4xgRN+Yqs3Xi2tbIqcZPL+t1O4BDljhU5dO18o1Zg8A30COavOR5DdKB?=
 =?us-ascii?Q?+glNn96YITcKKtLNeq88CoG78xr9DCVynujTev3zJbtOOS71BsARdeROB5hw?=
 =?us-ascii?Q?ThoymjulQkEHGg0Kax98FaDjoDt5lOg9U6jnaj2WlekeUMYEmpWmJH85anOc?=
 =?us-ascii?Q?jweffLGaliQKyfY56UTOhqrKJDB4xTMc2A1JtHzAZZnSS/WUah+35C4w9LIU?=
 =?us-ascii?Q?TSZY7nK5UZI/n7oW35itYzvX02S8Erx8ZT8LYQt5n+Qs2uYDsMertEdNFPM7?=
 =?us-ascii?Q?LdTP3JEbCBo4K8JxleDFKBhiKNrPIXfctHRA8FVPdz/ZSYbm3jOwfgTTM/h9?=
 =?us-ascii?Q?zfc5kiUVfRsgRr9LL/bEtkAl/i2iW7v1V9weMTsXH+7W9ezgE90J7qoiZZzO?=
 =?us-ascii?Q?VzWImTmMQZH57OHYi5U4OotgzBteurUE6ew7HKFxZ5LAgfaC9JZEa72Cx0LY?=
 =?us-ascii?Q?byFsMHRO3L84Dol0x1Ruz3GVN1CdquI+q8BKTy1BDXk8w3EkYEUFc8sW/Kou?=
 =?us-ascii?Q?/InHz/zjd4wbhNkygZ/hJnMas+lg4iL92bEl2E084OOcZKitP4azOemEiHaf?=
 =?us-ascii?Q?8adhTTZyCLxe0vXKmB4B5EvRYGP5XCZXfKqKOoLafNtww4z5dAsqe5ka45cS?=
 =?us-ascii?Q?gszxnviArXxseJSUp7xjytf15XG/FaMmyhhFl4w63LIf3N6xAFAwi5PfuSgb?=
 =?us-ascii?Q?zbKebcsUeV/ZzUMiNp3yFw717FCYMxJGTG/i6+prWJPw75FCLpd0kQvY2T+Z?=
 =?us-ascii?Q?F/Tb9DggXeLbNkQJbC/ynhmiHf6qpCC6e5chcNPfbBPG5f48sUQFhK575SSY?=
 =?us-ascii?Q?GNVhTNQxoXCAzfgpzpoU79Q81FsausnxMBrfay6KvJbbcxr2r17tAGWEC7hj?=
 =?us-ascii?Q?MOVPmvNy67BAXr1WXf9T91X/8hdmJWEhM9fIjV1OIDObueroQf/LiemermoU?=
 =?us-ascii?Q?7+nIf0QY2U9joyU4bLhQpWPQ4Pv8+RwT0n5WE/tdKtGu9EvhdhcIptsbAoAk?=
 =?us-ascii?Q?JWFTa/fL3z8++ZAAs8mLO+eP3kZejsVSwXTSVgzkwkrnZBMsnAxHQ0smMzSK?=
 =?us-ascii?Q?LihQWy889VLOQMbWKn+QSqr1NsBzXMN4a49mi8i/pNDoN78U4AJdZc5liAju?=
 =?us-ascii?Q?KHvC0BRTsWfaOsnc+sFb0mPNQcgO0YpkZ9ha4xKxWV7fpH9x5ls8H3P7BqTE?=
 =?us-ascii?Q?Z6UsRnZqe8oiaEiwFWDgaB+8w5tZMrlUpL3oeLFCuC7T254EswlyjzvXwvcv?=
 =?us-ascii?Q?WXn5JGKmjpXvfgCJpWkk/8+efYYIUFSWllC4MhMSjoB6Oa8+pqWPbJ6nIjdo?=
 =?us-ascii?Q?qCKUZpx5lAgYAFMA9+zPPLFGN7CsOIDLNETc2kBuLan1H8PLDqrz3MATek6J?=
 =?us-ascii?Q?lj/dEHTm6P4GOWUb9fp20XIJHCD54ou/zdSdZQj5eo0fcfkwyj8MUgNpwTZa?=
 =?us-ascii?Q?PGViDSczJg+qI0uEv89APKpzeKXEdf1r37OKsL8zMoiPKekcuiLW9i7AfjL3?=
 =?us-ascii?Q?WCeS9nKCF/vvv7m3WG4wkVnPQx6byyf9FqLPoi20?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a3d199-cfa3-4b5c-3dac-08dbb9207a2c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 14:55:34.6420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOvtlHGShti3oY0SH6SaiTg/VFMLrFCH67belyaPXwv26yfCR0ty0n1qPz2QOcM4X+E7AuQBssEi3vpRCuYxzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7023
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:40:57PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2cf0f715623872823a72e451243bbf555d10d032
> commit: feb843a469fb0ab00d2d23cfb9bcc379791011bb kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS
> date:   4 months ago
> config: um-allnoconfig (https://download.01.org/0day-ci/archive/20230919/202309192257.IAbw1lnx-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309192257.IAbw1lnx-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309192257.IAbw1lnx-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

Sorry for the false report. Kindly ignore this.

> 
> >> warning: unknown warning option '-Wrestrict' [-Wunknown-warning-option]
> >> warning: unknown warning option '-Wformat-overflow'; did you mean '-Wshift-overflow'? [-Wunknown-warning-option]
> >> warning: unknown warning option '-Wformat-truncation' [-Wunknown-warning-option]
> >> warning: unknown warning option '-Wstringop-overflow'; did you mean '-Wshift-overflow'? [-Wunknown-warning-option]
>    arch/x86/um/user-offsets.c:17:6: warning: no previous prototype for function 'foo' [-Wmissing-prototypes]
>       17 | void foo(void)
>          |      ^
>    arch/x86/um/user-offsets.c:17:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>       17 | void foo(void)
>          | ^
>          | static 
>    5 warnings generated.
>    error: unknown warning option '-Wrestrict' [-Werror,-Wunknown-warning-option]
>    error: unknown warning option '-Wformat-overflow'; did you mean '-Wshift-overflow'? [-Werror,-Wunknown-warning-option]
>    error: unknown warning option '-Wformat-truncation' [-Werror,-Wunknown-warning-option]
>    error: unknown warning option '-Wstringop-overflow'; did you mean '-Wshift-overflow'? [-Werror,-Wunknown-warning-option]
>    make[2]: *** [scripts/Makefile.build:252: scripts/mod/empty.o] Error 1
>    error: unknown warning option '-Wrestrict' [-Werror,-Wunknown-warning-option]
>    error: unknown warning option '-Wformat-overflow'; did you mean '-Wshift-overflow'? [-Werror,-Wunknown-warning-option]
>    error: unknown warning option '-Wformat-truncation' [-Werror,-Wunknown-warning-option]
>    error: unknown warning option '-Wstringop-overflow'; did you mean '-Wshift-overflow'? [-Werror,-Wunknown-warning-option]
>    make[2]: *** [scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 1
>    make[2]: Target 'scripts/mod/' not remade because of errors.
>    make[1]: *** [Makefile:1286: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:226: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
