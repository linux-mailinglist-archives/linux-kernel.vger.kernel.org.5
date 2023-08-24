Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8098F7864BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbjHXBlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbjHXBlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:41:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BC8C7;
        Wed, 23 Aug 2023 18:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692841278; x=1724377278;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rWvhqoCFiwkXcg9kZ6VbH+3TGxgwV+h7u8mIobDZ0Ls=;
  b=G1NOhd1CV/dVGIMcswH1lPLCjoZ4YhkhC7/fjWWefi8t/s5Udwd0Zw72
   TB7doWf+Ne6hl+Shc6aZVN84nC8cW5ln56wHAsTienWYJWTe8cIDRfEt6
   qMUJIYSzWso7YlcBnOVVfrQrcWqq0xpObMsYgC0CRB+e77JXIehMBbNp8
   04pdHJyoSK3lb7/UB1TpyMWZUi4m3t/Uu0JKfCNfw3eAO1Ro2IlDHS/Le
   AWzMltcewwPjR4LsWNpUoCJ/jDAs4aApZpnNu2ixEfBV9VJiTDCggwGQm
   Objbwdm9aRaaJxWImDYliiihkwxJRiFYZhIyFdEXf7+sHRR+q7A26pWl7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="374290967"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374290967"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 18:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="736859506"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="736859506"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2023 18:41:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 18:41:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 18:41:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 18:41:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 18:41:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWP6XLxv/OtHWCdmricVf+PLC2P8+MOUpD3pxGgElydIjX4pSwRCkQ0LSRhp+Vqcehgmmyx5KivX3Of47vDYrGDgb1urtpmxulPoejtyURwOgnJMiswYdx7gM5uO0VS+Uykmy3ynewIxa34HaPRcz71xlZaDAstrDdc681hh6lD9bQmP4Y3ViPMN3njuoHZb1vn/xReJ5PN6Y9gzwISmDMNlJQidRZXdVNc7xNsswKNr6mP3VfFICDHVo33wSPIbYMDJDNqfmw2mayBvbs7GTpKhMZZdGnHUuoGEaW7dR2A0F8XcYEdqYa9jApcakjc4f56oMUIqhzAvIfGcjYqvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SqXV+erY9LNKBupeBSTEswG9txdH/Bk9GhEVHNFPw0=;
 b=Avc/Mq7K/+umb6pT141kXZ+9xJQ9lj2LIizF53iXalgEIJW5knS9CETcr8O+zW0kUVcoon7X2rIP/LHTc2bwrKPMuMY7H0GD9RlPgmh/zKu7HyX18mAk5zBRBN+Q6pC/rljeiFEbE6oRH+WhyWQkd3JLjralp6kiDVsEcx2PPL+k/vRoYfUPEfZ9qhQHYO/hv3LmXM7Y5AtxcgJiEfHbRnUcVi96xj9HBImdR7tT1oLZmSQlVkHUDgjApA52a/oSNbPwBbHQu/JhceoFJmQcKx/9+yfmAoexRJpgxRwqy2LGToorktn4xethj/PxG/aWvZZYIKp5UckTaXIM5u8tLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 01:41:13 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 01:41:13 +0000
Date:   Thu, 24 Aug 2023 09:41:02 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: Re: [perf-tools-next:tmp.perf-tools-next] [perf dlfilter]
 f178a76b05: perf-sanity-tests.dlfilter_C_API.fail
Message-ID: <ZOa1LnnwETWCQ6n5@xsang-OptiPlex-9020>
References: <202308232146.94d82cb4-oliver.sang@intel.com>
 <78a87ed2-3aa8-95ef-28ae-19961f7c4acb@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <78a87ed2-3aa8-95ef-28ae-19961f7c4acb@intel.com>
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b9fd84-8544-4e38-283b-08dba443332c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K6FdlkZxn2tC7lkbJuvwOfVs3wUFX/2uNCfAE8XhXBD4fPfwjuaxdXJ/42E58Y2Q67ZT76CiOyqBtXgGGFiRLkYcNA6lXcFeiCQkMKVy3og2rvKtRqUQ0EfcncLaghRr5IIJ5knp5GcWCR2iJVlqohMWgcPH/4k8m6qjHs/q/BeuyGGivDooX9noPw6g/dLSW0lx0ukiwUXIbqHqg7YVcdGX51bB6X6b53hWcgkW6bSK883vOyH/6ounr1fttyZWQDTRPjVpuIaeLFzePmZyJHaYS4tP7lr34sYnBF/sR2J/iEcCPYVgx5tPpxl5fOIxyT5EhRiOcbKDIeIPZ3m8C+2QVGBsGmXGP4cT7c0AHtojp4XbK28xwKOhUh8ibHudKYMFQnrbYOsYPagp9Imq94/sc9RGGlO4mghLvG0ptRpKsaQkIPrkwQ2D7erGGuitS2mVuo+p+ewTM+J2LVJFdIYcim9qBoDPOPurfSGWZ/mH9J+ITYyTjulL6Wj/cEI+UM8ie0bl23t5z/XtA+zf7jTSD7x28Dc9+ePDXsLtbQ25TjVxsR6ix6B34xD30yiTknltjIFhmOJQx9LIsRN0Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199024)(186009)(1800799009)(33716001)(86362001)(82960400001)(44832011)(5660300002)(107886003)(26005)(8936002)(8676002)(4326008)(6862004)(2906002)(83380400001)(478600001)(966005)(6506007)(6486002)(66946007)(53546011)(54906003)(316002)(66476007)(6636002)(9686003)(6512007)(41300700001)(66556008)(6666004)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GyMPkH9DAfyvxioqOoJwOTDZK/IOv32cCPihTFEgpIynM/yDwNwqZiBR7pw4?=
 =?us-ascii?Q?ZeluwiLXPvIJc7tSx+mft1jVYSa40szJOEK7a55INKKixphG+YCQum2DdmSK?=
 =?us-ascii?Q?ftLfG1fxd6DYqXIbNwMNVn0WhHF0YuuR6EsJF29CLJY1ciOq7b96WFzFnKem?=
 =?us-ascii?Q?voSGmn53AntaloUdCfl5HW5JxtRSgA7WszFX57uDsK2oM+d9Gs1ele5ePixw?=
 =?us-ascii?Q?sUzrRFzDVowOIaCFn8rcm6vBUJQIHvnHbnonMjH8nwgnlr8hj7bTp/ThF7Mf?=
 =?us-ascii?Q?c0foNwpIGpBQB8VMuTQZEkaWHRtnZHIAhwbxZS+BWvsU58+sX3yYY7P7vcZs?=
 =?us-ascii?Q?kaZ7p7JP2DK2HUqmdMKxL4Hn0xoJB9R8jvLyPfxzk1TOo/BUaYP/8U83NwhL?=
 =?us-ascii?Q?nF9Oi4itJieCLBMb+Y7iGKnSWsMKaBQ03J/6miUfm69t/PXP7W/dvbCFjl75?=
 =?us-ascii?Q?JInQ9qG587yxEUOxSYXSu2BMHThO75uzySyOL5Zt/aBE+KPFkgvPFtLKqAB9?=
 =?us-ascii?Q?wPaLw+0yvwy8/3xK4CLHTfO+1Wrl8Su0XVF1yivHlLYuvx4wQkUU9chkU83z?=
 =?us-ascii?Q?LU/m7fO6IeYFEDNoJRSXbdBGEOPfdv85DJo86paxtxOCKU/3urtH/HBIwmmN?=
 =?us-ascii?Q?gZkhAVQCBaxuvkn0wXbFfg/c41rajaGjReIWhU25rlS9fzNnqR5LtIn9O4RR?=
 =?us-ascii?Q?QbbeIzrybRZCNY/CF1/soEnvyhbgKQnINln1M/BE8mBT/z1JXFh70jxwo2EY?=
 =?us-ascii?Q?lTXtvgJyItoT4I/XSHQ4PSIR/5syiMi5vFAPCBcbpkvEwCemRbqO4zeJ3Wpd?=
 =?us-ascii?Q?8ZLpxCiB0JCkKC5YXDE82pHOAxFg23KuHGIsyA/zx2pr4URzRbrcliDbDuxk?=
 =?us-ascii?Q?rA4iEH8zKFm7RITTit+R/mGIlEJD5pDsmbDx8xVJJszNnh+4fke4vo7p7amK?=
 =?us-ascii?Q?dXfc9GFsBcSPT3rL3DKF1xHD6TUh3T8r93fD8/teuu/Atj9scd5LLmwvHBZT?=
 =?us-ascii?Q?3VvW6zdC2aoI+OJlF6Rmow9wh4B8i8UeydZTov4rMOn2SxUFyngaTRxZJkrj?=
 =?us-ascii?Q?gIKoX8sMkNLR2dbPCbNEvxTAAdi1KhMnfss9clvBhsgoMcudoNZDxeE0L0Td?=
 =?us-ascii?Q?ShHJtQrGuMDLWvrScqWF/QK3VSNYHyjci/sx0T38Nv5MKMr/JcLP18GlTlPD?=
 =?us-ascii?Q?jKkOs0NEV/GzBvvyMxqV8CWXPERCwcG6A7EOFEpbiNgAnhu8Sq48LFLe9pCo?=
 =?us-ascii?Q?DMBjftTAxmc+xBlcXo7/5EcLHB1+h+ViJ0aZ7/QFjAu6FN2X292PrggJO8mN?=
 =?us-ascii?Q?BZ5FjLhhn5JyOfwspIYLGfChETCgYoYbAzHOnp/5J2NhZYfd0JCoEeYb46dj?=
 =?us-ascii?Q?ugjzVZszpeu6FvQ8nCgzMgsWnDgWHjqw833XqsGIjZ+qSZ82Y34PTAUrhxgk?=
 =?us-ascii?Q?XMbky+OdpSDJneCeDVUNxDEHDZnJ3ApNWJbz9m2USB4g41eU5c7lBSCDV2Fp?=
 =?us-ascii?Q?ERTgzLhZUE4zJpiYDPeeLLDYnMCm2eR/re1Pz1XCQ+OB/6xlfZi6ZpEBZ39A?=
 =?us-ascii?Q?z+Ay6hSCq6lUVeKrY6vEsawwl+0rB0uWbs4KvNIxj7UTmlsTR5YFYkRpZ28L?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b9fd84-8544-4e38-283b-08dba443332c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 01:41:13.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdSu8GiV2qY1hcBR4N1ViYl2j2BpCdPJbCl/GwmMEV6VCd5zlxg+Hy+ZJedjqDbHSvPVsbdxvHsI0u+DF0asqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
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

hi, Adrian Hunter,

On Wed, Aug 23, 2023 at 06:37:49PM +0300, Adrian Hunter wrote:
> On 23/08/23 17:57, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "perf-sanity-tests.dlfilter_C_API.fail" on:
> > 
> > commit: f178a76b054fd046d212c3c67745146ff191a443 ("perf dlfilter: Add a test for resolve_address()")
> > https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> > 
> > [test failed on linux-next/master 28c736b0e92e11bfe2b9997688213dc43cb22182]
> 
> We sometimes make a test for an issue then fix it, so the new test fails,
> but is fixed in a subsequent patch.  If you read the commit it says as much:
> 
> commit f178a76b054fd046d212c3c67745146ff191a443
> Author: Adrian Hunter <adrian.hunter@intel.com>
> Date:   Mon Jul 31 12:18:55 2023 +0300
> 
>     perf dlfilter: Add a test for resolve_address()
>     
>     Extend the "dlfilter C API" test to test
>     perf_dlfilter_fns.resolve_address(). The test currently fails, but passes
>     after a subsequent patch.
>     
>     Reviewed-by: Ian Rogers <irogers@google.com>
>     Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Link: https://lore.kernel.org/r/20230731091857.10681-1-adrian.hunter@intel.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> The fix is:
> 
> 42c6dd9d23019ff339d0aca80a444eb71087050e perf dlfilter: Initialize addr_location before passing it to thread__find_symbol_fb()

thanks a lot for information!

as above mentioned, when this auto-bisect done, it confirmed the issue still
exists linux-next/master:
[test failed on linux-next/master 28c736b0e92e11bfe2b9997688213dc43cb22182]
which includes 42c6dd9d23019ff339d0aca80a444eb71087050e

we will test again on latest linux-next/master:
e3f80d3eae76c (tag: next-20230823, linux-next/master, broonie-ci/next-master) Add linux-next specific files for 20230823
and 42c6dd9d23019ff339d0aca80a444eb71087050e

Thanks

> > 
> > in testcase: perf-sanity-tests
> > version: perf-x86_64-00c7b5f4ddc5-1_20230402
> > with following parameters:
> > 
> > 	perf_compiler: gcc
> > 
> > 
> > 
> > compiler: gcc-12
> > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202308232146.94d82cb4-oliver.sang@intel.com
> > 
> > 
> > 
> >  66: Convert perf time to TSC                                        :
> >  66.1: TSC support                                                   : Ok
> >  66.2: Perf time to TSC                                              : Ok
> >  67: dlfilter C API                                                  : FAILED!  <---
> >  68: Sigtrap                                                         : Ok
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20230823/202308232146.94d82cb4-oliver.sang@intel.com
> > 
> > 
> > 
> 
