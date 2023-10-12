Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD06B7C7244
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379202AbjJLQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJLQRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:17:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06B0C6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697127470; x=1728663470;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bONkbJJMcVY5e7g0PT707FXi+E3vD0E5PX49HL8wSaU=;
  b=CQ/rsbQ0BDaXdc3egxSB8KwYwCME/79FuzG5YMERCwWHCjSSWvquEmRh
   FYBlxaCRwcgCpoAbrSoRG1uofkvLtt1Wx8zTAGPMgnjgoyDEp8TCKLqOv
   jaIK9lNH8DlHDb+jDyQn4w3umH93nMHRGsqb84pZpxtLMn4QoPimxrdIW
   Xwhwiny9EnKgbd2tLoZXhToOml5M3qW/V/L9SjW8htIbx784xRootCrbj
   kd+mGaVkLIzrimlW1DY/szZy6i5oJhiPtJwwAg+prVxjshWlgmGuQbuke
   TRS3z0PYHtHs0+HXYN2oFNl3b3XvoNF8aBQNil2abfU+qqiz/L886Lcsw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449154647"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="449154647"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:17:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="783761155"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="783761155"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 09:17:45 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 09:17:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 09:17:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 09:17:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN/a92Ewj/4NEVIfGK+TwmeqEtQ+XIrKEnJbus/h/GTB6uKmbjH0L1cnhnA0v1JQ+RybPYRsEIdGrj5HxB9E9w8u/qTt+IHw/MlZuGpIQ4X2Mr6VPjjnkI5IN12hvwvdNK5sbi+FGRm0qiLnB2K3J3EVI1T98ijZsSMiGUc/3flcoLAsDx8cng2n4McrdHIeD4ZdIU+oJPYDbBaNnuxbONH6K78yZ1Iz5VCRVO/CWCf8l7Zu0LA2AD8CLSrWD0BnqVY6bfpaLIWAXdhK1vQ+KcfQa/+KwkJ6WHEYYVODfyInUNxmQnDsD+f6le374a13neNMtz9ZqJ/nOQWTJvyU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB8VW6rLhnAZ5wy5C9CvPkXVpZmzqDUEBhTXxuZJ3O4=;
 b=ca4adoRrxEP24w21nPLvrcTY0roLzI79HFkYOpdHbZP/wMrtPiI3lUb1yuivMoNBwaMQZkzBJ7+m4pG1DyjsRqVhOsdO8qAYgTdIPgPO3CN3GmF4nBmvaKOLy5QigjVfN956LBADiCn0bVCgx3L/v7hn5it5LxuH68OzciT0T8Zv04h3CRH/XebZY3aY4+0GW280bZq+AxvEk2xpAiS+nMRBYSVap6du7FUw6HLhYOwAhEJsjtF4hGcKTuN8yMm0Td1yu6JI9PR27s/MQKI6HYuJGKu44aJiZkV7cRzk9cmi5TPe/HfoPReh0vgT0eHOAj2vDVIyalBZkh/Yd/FgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA1PR11MB7854.namprd11.prod.outlook.com (2603:10b6:208:3f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 16:17:42 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 16:17:42 +0000
Date:   Fri, 13 Oct 2023 00:12:50 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: {standard input}:1198: Error: value of ffffff6c too large for
 field of 1 byte at 00000533
Message-ID: <ZSgbAoJ9Cd5f8hjm@yujie-X299>
References: <202309222350.hCUFrIQ1-lkp@intel.com>
 <CAMuHMdUn1n47=nV_WMe9Yx1aTzYgsDKoj_AuZUPoAH7gJpCuGw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUn1n47=nV_WMe9Yx1aTzYgsDKoj_AuZUPoAH7gJpCuGw@mail.gmail.com>
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA1PR11MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: d06326df-50af-4d5a-7940-08dbcb3ec2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvAy5VSWdaPN2IHaseb5eKIJxKb3jyqWriWPJEP0HRZR8QfKWmN4H7iNnRi6RZIgGwNfu+tDSU3qPxxBijuWif5Wyppc9wdqcaLQInRRwKxDrGt3W6Gk2wa2g2Qt0UQgzUu5+ZhvBjrVh53sr6LsjKShor/2N4OHEgN/YpfcHvXqvRSYwjx5qlhZ+vCqIezszmpvGoOwXC+tf7EvnPflhyeHG7KYpWPJun1ZJJZFnO7E1ynwJZ5lo/Xmadb/ViAz3LqrMUX9JkYxSMyLI7SO32FyIs6NKoOGM7hJTpJT0juv9VRj4nrQ7dOQBidzX1p5MiJ1aR1DZxIlw7AS56h8bhY1CSjydCAibXQPGMQcUhaHNrTwZZF8k/bNk0I+xCWngroeBJP0P85RXQ52xVOo2sZ3I4xrBjnzibHCfUi3CjKZRFBxzB5LBMPA0HHK2Z5wn2h8gxzpLZsDxm8v4ZP0KsvQsf7guDABA/RMzhfA/1O3GAMTtmlGaYCHsXBxjQrf4Bni7JviNL9FlVSjXUdk0/nqLjlbqjItFDprLy46GWpYwgFgiOe7aylneOJsYJM4ddCNCAhkkHWDXHNWGGDU4auTjHHEsMVb3nCw1VwCRyOa0I1ECAXVYCTfvG4vsJT35PWhgd67tY+EoH43J3SLfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(4326008)(8936002)(8676002)(53546011)(54906003)(66946007)(6512007)(9686003)(66556008)(6666004)(6916009)(6506007)(316002)(66476007)(38100700002)(5660300002)(44832011)(26005)(478600001)(966005)(41300700001)(6486002)(82960400001)(83380400001)(2906002)(86362001)(33716001)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnF5andoNVR1N1hocmF1dDBjV2xIQjdIejJXditBRjFpeU9pMTEwVHFidHc5?=
 =?utf-8?B?NVUrVmh2N2E3dS9UMkRMeUpEZU4rLzNXamJROGVuSWRPTlBEVlZiZU5XcUVJ?=
 =?utf-8?B?bG1uU3RmZ1R2bXFhS3NnbWR6V0JKK2pDbVpaZWJ5SEtQdmZ0Wm90Mi9oTTZ2?=
 =?utf-8?B?RXJIOTJOaWRWd0VxUHEzeFRYRkl2V1ZwWmFWVEpUeisrcGpKNGNGMUZKanZO?=
 =?utf-8?B?T3o1dUtoc0grK2dZL1Bja05nWndxUjdTcEdhK0FTaE5odndiS2hOZk1QZVp3?=
 =?utf-8?B?em1GalpNcVE5aUhwYlBVUitscDJrTXhiTEJyVEZKTHdnMk1ESWVUYTJ1K1Qx?=
 =?utf-8?B?WmlpRHR3QnZEa1pTN2xoM1JtcFErWXNLR3FySDROeUFXQmxTb3B2NVVnYkg5?=
 =?utf-8?B?eVptYU5BUjNiOU1LK2JKemRQamtMY1FFSjhVVVlZVGRMTE42Y3NmVnY0QW5t?=
 =?utf-8?B?Uys2Sm8yckhpMHlsRkFwcUw1Z1lrQ0t5YUg5YjhkN0g0TFc4L3h3NGpHdXlw?=
 =?utf-8?B?WXlYOEVLSlpNV0FEUHdqQ2ttdVhxeXY5MlA1ckYvMGJJc0FabVpjeGppNjdR?=
 =?utf-8?B?b1E4QnYzUG5VRU9sNy9TblorVHBvcVNXVkFDZUY4dUtFY1Y4MmpwNFRhYkdh?=
 =?utf-8?B?ZXpZQzBDcDRNQmNyOTZuQnBaaHBnU0FHZ1RUN1AxUjFaRks4cEJ3amgyWmhG?=
 =?utf-8?B?c01KbjY1clVIYW44aUxwRk5sMXVkTThIcnM4cmJiQm91SG9mODQ1MzJkY0hq?=
 =?utf-8?B?bjlYQXpFZFIzSlZWS3FLaDBGUHBpK0Jram54SzNZMVRsNEt2TDFUTE9WUWZD?=
 =?utf-8?B?NmJtTlJiS3pZOG5vb1VqUXZpRVN2TFI4bUppbXBHRjhJdHNnVWFKM082N2pI?=
 =?utf-8?B?QWFYL0QwZWc2R29wdGRIbTZ4RXBwU0I0RFFocGdzSkxweko1NHUyUnhpczZ3?=
 =?utf-8?B?SDl4MnVOSFdIaWkwWlJHQzhZYkEreWZTT003Z1ZNdXROa0ZuUGx5RzMzKzR6?=
 =?utf-8?B?enNVcFVYUzJoQi96aWxlUkhMTkF6bzIrbVh4REt1cE1YbEhyWnhNSHh1N25v?=
 =?utf-8?B?UlFsbS83dldvNzhTckQxOEl6SE1NYk5NWDhsSGRRaXFwWkFLTTUzK3FMOTFO?=
 =?utf-8?B?ajRIVEFhVVpCeDU4SmMvK2NCaXkrNEVGdi9hY0VFTzUxaTdhMldURllRNjFm?=
 =?utf-8?B?VStxSDdiNnpvRzdoRFpnYytyTWVGZk5xSGdFZUkvWXBlVVBDZEx2OUdKZ2Ix?=
 =?utf-8?B?WFlQYjNVeWlWUkoyek9QakVSbHp6TGtqZ21kcnk3TVRhZlN2SWtRelpOcThU?=
 =?utf-8?B?bk1MMTlnb2hVcm8rWDFDdzhQZHpqbkNMUTFIeW5wdE1aeHN0VlpIaUhUQlg3?=
 =?utf-8?B?cHc5Y1plUEdrWkFYVzNWRFZsV2pQdk9uSGhPN3BEQTVmWDdXSTcveE1LTnNE?=
 =?utf-8?B?Q2pYb0p3QmhQdmtBeEprc1JHSnplRUxjby9tQnF1TjM4NUV1QnAybXhXMVBp?=
 =?utf-8?B?TUFVQ1RMNFhMKy9GUUV1K1lzVnNQME43TFduTTZMVFNNTG1DeUcwV1krdUQx?=
 =?utf-8?B?dk53WC9ySERpT2wvQm9FWE5aSTV6aTBnZzBGdlh0aFkzdW1EWVBDVmhxU1JL?=
 =?utf-8?B?REpwWllMYUR4WnpacktJNnVadHpaOTI0U3F4SDZ6cnZPb0RFZjBSN3FKRmVi?=
 =?utf-8?B?Rm44UXIwNE1qbmhpWUdpd3FjUmFHeGpnN1RhVHFweldsenFXdWNmcWFTU1cy?=
 =?utf-8?B?dVQ0MlZRWjJ5NU03a1YrN2ZKYVV4N2dpMHZKOEtHaStVSzV5V3lDN0ZCOWpr?=
 =?utf-8?B?ZWExOUVQaXFIZXQ2SVJpT3JTL0dDWXIvM2VyV2ZWeDBWdlJjTzdDS1NCYVll?=
 =?utf-8?B?SFBmZjNyL25qUDRMVUllMmtneEwrOXJHNEtjSkhSVGpZOUNVaGIyQy93Q1Jy?=
 =?utf-8?B?eS9EVkVPeEk1bTZLVUl0NjZ4eHlPTEtiTjVMSncvbzgxcEpaUjJyZ0YxWkd2?=
 =?utf-8?B?OHZ3OUtSTi8ycDEyMWJnZDk1US9SMy9odU9GdDhuQ0MvYS93dU9tcjZ2TWdv?=
 =?utf-8?B?ZGFlSUE5amVITzRDaElGQ1N5dVlsZUxTVTFFZ2o4bmIyMkx0MGoxVWdIYVdC?=
 =?utf-8?Q?2sez5O2cZaUk7v4toeORTMRgq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d06326df-50af-4d5a-7940-08dbcb3ec2e8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 16:17:42.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcLlURe7DvqalWQISSO/1FBpquBKIBd21RrMNrXc25Rdpwltzu3RaXxUKmOCDtzSzElyi3MuB8qQxtoLUmSa7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7854
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Sep 25, 2023 at 02:07:07PM +0200, Geert Uytterhoeven wrote:
> Dear robot,
> 
> On Fri, Sep 22, 2023 at 5:23 PM kernel test robot <lkp@intel.com> wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   27bbf45eae9ca98877a2d52a92a188147cd61b07
> > commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
> > date:   9 weeks ago
> > config: m68k-randconfig-r025-20230123 (https://download.01.org/0day-ci/archive/20230922/202309222350.hCUFrIQ1-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309222350.hCUFrIQ1-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202309222350.hCUFrIQ1-lkp@intel.com/
> 
> Thanks for your report!
> 
> > All errors (new ones prefixed by >>):
> >
> >    {standard input}: Assembler messages:
> >    {standard input}:1198: Error: value -148 out of range
> > >> {standard input}:1198: Error: value of ffffff6c too large for field of 1 byte at 00000533
> 
> Do you have more context (e.g. which source file is being compiled)?
> Thanks!

Sorry for our late reply. It is sound/soc/codecs/tas2781-fmwlib.o that
is being compiled.

{standard input}: Assembler messages:
{standard input}:1198: Error: value -148 out of range
{standard input}:1198: Error: value of ffffff6c too large for field of 1 byte at 00000533
make[6]: *** [scripts/Makefile.build:243: sound/soc/codecs/tas2781-fmwlib.o] Error 1

We rechecked the bisection process and found that this was a false
positive report. The error also happens on the parent of this commit.

{standard input}: Assembler messages:
{standard input}:992: Error: value -148 out of range
{standard input}:992: Error: value of ffffff6c too large for field of 1 byte at 0000045f
make[6]: *** [scripts/Makefile.build:243: sound/soc/codecs/tas2781-fmwlib.o] Error 1

The error message has some minor changes that our bot didn't recognize
that it is the same error on both commits. We will fix this soon. Sorry
for making the noise.

Best Regards,
Yujie
