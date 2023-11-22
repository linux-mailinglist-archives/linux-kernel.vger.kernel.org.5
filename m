Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4361E7F3B95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 03:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343512AbjKVCEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 21:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVCEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 21:04:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0FD191;
        Tue, 21 Nov 2023 18:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700618635; x=1732154635;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1F6xPUcd7XKVNN4kA/2FKti9qUNH8VEuBPeRlzvD7/w=;
  b=X2czTW0eK+MW3OSXqnjC58CDj7gnVUGcckpsqpysngHDPm74OpE4IeV6
   rSuczYQQY7k1NY8ZtxYLwgjwi6iz7uk/yPMrLa/ZGHBJr1pdTWEAk6yKB
   VOGOsEVTEKqrd/R2L9y+hTVKevGLlDDLbmfCgAazMMifpnN5C7Wpj7iMz
   LcsEfBJIBSB9PCsivrc9gRR0WImnBxzaHwrD/pdpUTyz0h1nybUz6RH/g
   9cXEWft9oJEyOo3FY/StrSgx/vLj+9oEz5KU19EYkpa8AwrUZ8h9azz1U
   wybjUqzALV2vVFVjU4NtwuiVqxcJ9+ZpZzkGqw8aNN32bgHcUExn5tXcU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="389114842"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="389114842"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:03:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8069643"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 18:03:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 18:03:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 18:03:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 18:03:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 18:03:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQyTnL84gPZlxVNm01Z75BvB+DdOh2O3/WmC1w5T/CHIeW+yVb988+px/8XDFTBMHq/51BLddyvE592lSWYhHMnuDf5wGGum1YQrlIfDpbR66bGwyMBiQ6v5JO+N1rUbcKPFpqlA8jRnctd7n9QKx93GfZmp0nc66zyIAlaLcOavTCnHYoXisCd3xQS4Lj8sCSVkTenPIlCwPeQQXXTlKceCOJz204qFBScplbJ4JFF61ZE+59DPRrXmcZSA5aXsArjaWoZuMEA3w1uV98iIEUNvhWWt4VsvG1sWVJazG3kgZy2OenARlqS8Qvoa40kF7DYWih4oi0905WmGIrzrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm0zGHCYnUosKFbQrW6Z8pJXsCvzVh1vm9csSeKVzA8=;
 b=j1/cEA3pp8MQ6/GMQtmu5RaV8WeamZGCGswMSQhf2bGcD/EaZlNO+ndlrHBA9pHfids+NOd1Uh3FN/t9YDNCz/m1AZWwZnrspyLrY+OVdHRY+4cDZDrNA2hP5G9muupdidrMo8qrhLzDY3L1d4x6/YF7DsvtzZayff60/X1TYayC3//CcpQSfdc2wxZTOqjWx/WER/nPQGDXvzbFrJCGOWPPr8yUfgiK2Yf8SjJsSFaTuSr16DoStYNga9cRsQuGMmU5wQdvkEihQMZQq5hMJ+7nfBGYVR9Qusv8UZWxteQDndiGssmwkJqVS452s0B1dPB2j49YnmaqfIzGtpErug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Wed, 22 Nov
 2023 02:03:51 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 02:03:51 +0000
Date:   Wed, 22 Nov 2023 09:59:13 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Sean Young <sean@mess.org>
CC:     kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>
Subject: Re: drivers/media/rc/ttusbir.c:1: warning: no structured comments
 found
Message-ID: <ZV1gcXBH7eoPY3TG@yujie-X299>
References: <202311210746.QM5MR14D-lkp@intel.com>
 <ZVxvA58WvjBCRQyP@gofer.mess.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVxvA58WvjBCRQyP@gofer.mess.org>
X-ClientProxiedBy: SG2PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:4:91::15) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA0PR11MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: fda0aed0-9465-4521-e280-08dbeaff45d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXej+hbHiR1F9dU1FF2a0O9HggSrgTsh0eZXKrlhoi/p1e5vKe7ioDl60avA8MhZOg1XQr3X+wSAaRNTJftX2BJ2dOxSWMUc8m3MZUpMe3TO1kpmaUkoYjKr5Jq5j3MLCL+Ns+/IbwrkNx8JfD5TpNq0rg8/I+2iD1UQhMeuXNtPViydR6gZA9XX2qpBJX1G5VbtehgdsR7ONcZTm+reuO+7UYqFdbcwBVrVI+DdXZOXzcKHp8a/Xi5x1nczB0rE/trx4yRGJM6dSPeqAEHMLeMsWz68CIcZz+eqh97pOZbKb6teK28G7UrOQaob1QCpV4RUs+KDjQa5Rrc9xXaELl7+MryipcdgdZB+JrBzSdIoG9oT02O746m05S4Ae6fkITNCSLtyI59FIzQ4JYfJZ31kE6i+FXZ5WxiiOqZgswEp8BGzhs/7FfFFw4b53VSR8tcRF7og1ISUbgTlux74Q6jt15uC1r4QfjMyFnis/IzRwtHYp9LbrNF3ETRYJApmBhrTxzpzR4LhDmqvK2Jbgc+fhAMWs1FMKUPj37Pghs5uacOT471prWfR5e9an8sYY9V07NiJcvpbKB/9OZzxpeX8GiwVlZpKEyTTGaGMUfJ8LM+4J8nil3k0ezcyOIGBK3kSHtEhyLew54kBI0ZuMRYqArT629OgKaxJipKwoDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(26005)(33716001)(83380400001)(6512007)(41300700001)(8936002)(8676002)(38100700002)(2906002)(44832011)(5660300002)(4326008)(966005)(478600001)(6486002)(66946007)(6916009)(316002)(6666004)(54906003)(66556008)(6506007)(9686003)(66476007)(86362001)(82960400001)(2004002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aHMdaFYmzsrsm/KNdnTXtqIH1ZSgCMyw8VF3Kw48BxqS3NKH1+A36HOzXsqo?=
 =?us-ascii?Q?BkA1ABPm0K0kb+0V4wmBN5Zu8UIY6IF84kSUYR4ppyUDEevoavj2v+zG/hX/?=
 =?us-ascii?Q?EPKcn0ORD6l8mX++L/uyom8442wLJApK5mUhGX5VJNamHkVVJu0xg2Fc8p+l?=
 =?us-ascii?Q?GstQLlZ+E4ngs5mJKjTsPqc8eLYQax6KOUQ3JpxleYVRyPUGdf7BC9ZwAjez?=
 =?us-ascii?Q?pskg2JP+KWgMAq5WHzu/2xXhn27m6pzrNFh4JobsR1g/QiGpvcAyntLfNAvE?=
 =?us-ascii?Q?6vptZIm69HRY2YvkVs6uDJwTVkuwhoW4rGkh1NgdEQavbelFBqVznYzQ6VHQ?=
 =?us-ascii?Q?5kYh/oXY0SOgC+kYVO91aNpQr07rh1L4chmnepSplNJ9t+jIH4PZjwhHyjck?=
 =?us-ascii?Q?nqTDL0ZVzTaA2kvRhGTKFKPlE2wqSHGHQEoPX0nS2vlGIlSVlyL5/ChlgnjS?=
 =?us-ascii?Q?/Qi6IHzjqqvGbnsKHtqTAmnTSR656CGE8qunDRl57W9JGmCYgCqAcRrx2RPg?=
 =?us-ascii?Q?HzMLfqEnZUR17b2H2lF87Qt9EO2/8Qal8ydXtpMA2DKs68EANkLpqHdqVW2v?=
 =?us-ascii?Q?HCYBFQU3Ea1OnbHsGztSNZfdQGRhU3Fspk8q/VVuDPFxv9SDhWqu93EmcJOU?=
 =?us-ascii?Q?TF4PNC28V9Lq5YGvgVorTZufpWSd2/nD6XQXd8j5Ow54cE+lBCYfWGaHioh8?=
 =?us-ascii?Q?/rik1s6QSYhygCHNI7yq8AfgzPHd6yyEOuzyoBau5FLITZ+5T2iLenA64YNI?=
 =?us-ascii?Q?MZNXzO+4niMyCLgswpixTxfSXRXEwtkFRONnEOPztd8QxHubHwxnFyXs39UP?=
 =?us-ascii?Q?DBcMbCLOcqlB/9+RWM2mYaGpXowUpw8S7RNZ30F4gbTPVl9Wmf0lOZxiFhON?=
 =?us-ascii?Q?FHPYMSaZQpe2of6ZR6OaTq3kVEuFqIWhEFZ8seNC+43fJnmP188sifVkJRl9?=
 =?us-ascii?Q?DXJNi/oV/xBZEKIrypuoi2eRb42Yzsa7rGpeaVqqBzPH8/snM/lwSBv6Shn9?=
 =?us-ascii?Q?wTzGh9yV48ZZpdOwXC7RngNOYmJt7hBSmC3PPbmJfJ8NYZxY6bcFJgsIW6qL?=
 =?us-ascii?Q?nKs3t9w0rN33pTSoMyKpwUrkpgogoko+xI+7KZqaUvHGqzwuqZrK3Vgc2RlN?=
 =?us-ascii?Q?zRPfYBdLKayn6fvoF2djeSv+1S9Q/yXtdeZEFFfQAd9wCPyVm7yClOYatim1?=
 =?us-ascii?Q?umJBR3plZ72pJecc9M+S/i5t4qbuHVehv5DHqj5sYV2Z7+dxwLwnKc9zg7up?=
 =?us-ascii?Q?gG2C0QRqM06KbJqb/Jox8Uv9CmT5l9q2Mz4d/vvvatfNOs27Sydo5LgaNxpz?=
 =?us-ascii?Q?Vh7mYCdAtU4ZYwLNSCneAFlASS2QjEathApQwCKSZ5GBzkqSz5JGJmd6aBiN?=
 =?us-ascii?Q?y57AWj+WR4MwQgw8umHdo3IfPPz9i7icR8MzWbCJGeGBHwWxcDwmYZSRYzW3?=
 =?us-ascii?Q?NBj/4S5Wt0dDAcbjE5+rWKsfy6Z/xuNqYCw6rlf1ksYwp7WIwpwC5VYBRbO8?=
 =?us-ascii?Q?kTIXbv8D6S2uoPX9xwZhdmsUhMnXi9ksByO2on8ieew3GBmkN3eSFekc64ZK?=
 =?us-ascii?Q?8cQDZCnrKImLSXXWfUBCI7rjmNyINlxBmr9gMFnV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fda0aed0-9465-4521-e280-08dbeaff45d8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 02:03:51.5552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeXHSlvn3sgZ8G9U6DLU0jYLM0Edlnc7scqEZZBWZfKR9ea2Wsg22c6v07B9Al/R1mxuIc79+WjCpbdvFIGubg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7187
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

On Tue, Nov 21, 2023 at 08:49:07AM +0000, Sean Young wrote:
> On Tue, Nov 21, 2023 at 07:39:58AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
> > commit: b9e1486e0e4b5e0fc0cde214ceecec8a5734f620 media: rc-core: do not depend on MEDIA_SUPPORT
> > date:   6 years ago
> 
> A bug report on a 6 year old commit? This is nowhere near current master.
> 
> > config: i386-randconfig-005-20231120 (https://download.01.org/0day-ci/archive/20231121/202311210746.QM5MR14D-lkp@intel.com/config)
> > compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210746.QM5MR14D-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311210746.QM5MR14D-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/media/rc/ttusbir.c:1: warning: no structured comments found
> 
> What does that mean? Not a helpful warning message.

We've configured the bot the ignore this warning. Sorry for the noise.

Thanks,
Yujie

> > vim +1 drivers/media/rc/ttusbir.c
> > 
> > 0938069fa08970 Sean Young 2012-08-13  @1  /*
> > 0938069fa08970 Sean Young 2012-08-13   2   * TechnoTrend USB IR Receiver
> > 0938069fa08970 Sean Young 2012-08-13   3   *
> > 0938069fa08970 Sean Young 2012-08-13   4   * Copyright (C) 2012 Sean Young <sean@mess.org>
> > 0938069fa08970 Sean Young 2012-08-13   5   *
> > 0938069fa08970 Sean Young 2012-08-13   6   * This program is free software; you can redistribute it and/or modify
> > 0938069fa08970 Sean Young 2012-08-13   7   * it under the terms of the GNU General Public License as published by
> > 0938069fa08970 Sean Young 2012-08-13   8   * the Free Software Foundation; either version 2 of the License, or
> > 0938069fa08970 Sean Young 2012-08-13   9   * (at your option) any later version.
> > 0938069fa08970 Sean Young 2012-08-13  10   *
> > 0938069fa08970 Sean Young 2012-08-13  11   * This program is distributed in the hope that it will be useful,
> > 0938069fa08970 Sean Young 2012-08-13  12   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > 0938069fa08970 Sean Young 2012-08-13  13   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > 0938069fa08970 Sean Young 2012-08-13  14   * GNU General Public License for more details.
> > 0938069fa08970 Sean Young 2012-08-13  15   */
> > 0938069fa08970 Sean Young 2012-08-13  16  
> 
> Like I said, that is pretty ancient code.
> 
> 
> Sean
> 
> > 
> > :::::: The code at line 1 was first introduced by commit
> > :::::: 0938069fa08970f1c898970c1331a029efe9a1ce [media] rc: Add support for the TechnoTrend USB IR Receiver
> > 
> > :::::: TO: Sean Young <sean@mess.org>
> > :::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
