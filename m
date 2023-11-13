Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441367E96BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 07:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjKMGhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 01:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKMGho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 01:37:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27E10E7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 22:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699857460; x=1731393460;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nvclJTydn7YgEqT3BYQG+DbhLYS57e+ImrGusbSRW0o=;
  b=L1EUgR33Jel0TVisLoTN0sz0TfgHVu22Sdm5Q4dv8b3KVW4ysPLnCz2p
   DcuwSHU8J9XU8cMpmiikmBDm/NXixOa3wGOaiOJlAJ4+NGzE0+c/peYjC
   jjioRvFby64+DD+49cKy9st8JMDbXq9fMMZDbyrLE1UkRntoG3LV/X2Wl
   CGiojBBah/E8CD+Se1/b7JpBukYi2n0HZexmsSa/+Xn1YGVGvxjQ6CIzN
   eVwPbdJGGDwupJ3aaGPPzJ3+8/OwOhmVixw0D6XuiJ894Tg+0yRM+QhWC
   qWjtX8V1y3jkdrK1/ufcWisp2L/6qNbEz9/WQvcyN9H11Ts2qknYrnb9M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="394282263"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="394282263"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 22:37:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="5375576"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2023 22:37:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 22:37:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 22:37:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 22:37:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ml0MHSz9thllBngTJurBeabeHOwwQcOql1SHBkRnVBY5SsD9BQGRW9EiX1mp80eZIzVm3sRMVJQSJZGxVLxwIIzwcbQZkn+EBZyFB8E7SF2Fjv58P7eZzkH9gVfFjlxLSG2JWTlpVvM3K+Clo98EBaavG0zmkEEME5NGpB48PwAQl6hnENJIC9du8juja4/SKoR6kHrut5NjvX7YLFfApWoa4ynz89eyZgWZmWlkxt229xEJtYnxU/+ox2xezZyivrueVebw+QDbWGptKM4EBIbwAc7fh9vYDfqcQBcGmCZ3Y1RfrgPTOxyHVSK/T7ODfIbyNwtLJFupJWvoIZ/Q0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q0ExgpH74pWjiGRDl2TGdqOXOfh5yqtXbdjLLCy0XY=;
 b=j2DACkWzqA1JN3d/D7r5IXbRHLHfSdvowj3g9yqaanRvFfaBZ4R63WAmXzDTUU87xt4AtzzifFZLAf5ddPRmoRvVEzTGgcsUEAUVRm9kY28zBkPdvDOtrlWdp+8Z5ybGfaVyb8KEp7m+UkqQrxmsylwtyU+DYaVnjT3Zfeti6BrCR+V1x+dW/zF6mwXDz5RxYqAG62ekpgkGlbbnG87pDuFiUnPkJQpnxeaoyfcEYqUrx269aI7er379d2EKFmwHk646aftyiQTjVpJHTl77+0IiStZ14YJV/wmxUyKOCuhWZzwC2sNcmWJTYrIg/NZIOsVueWOShxKQ9i3Rnbkb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW6PR11MB8410.namprd11.prod.outlook.com (2603:10b6:303:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 06:37:37 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Mon, 13 Nov 2023
 06:37:37 +0000
Date:   Mon, 13 Nov 2023 14:32:55 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     kernel test robot <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: drivers/power/supply/pmu_battery.c:171:50: warning: '%d'
 directive writing between 1 and 11 bytes into a region of size 4
Message-ID: <ZVHDF2yzthb0D0SS@yujie-X299>
References: <202311100157.2Kn3gHLg-lkp@intel.com>
 <35cd8b05-8687-696a-4b1e-8449616104c1@csgroup.eu>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35cd8b05-8687-696a-4b1e-8449616104c1@csgroup.eu>
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW6PR11MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a30b0f9-cc6d-4b8a-64e8-08dbe413065d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBmdMN7ydJ1hq+YmYzVecN/y5sCJw6xR25GQkphz3+IIO9WWW2Oo6mGzqy93LkBJwWuUISiWZNl9QBPWN78sFY7xGtyJxsZlmeowYVsDvuC5rIlyQVzQ6l8b2VuvuZq0NhazKQr5FeJRnKk613WldYMBSIEiizIbaWponwiYyeUFpLzCLPD+UaaNm7W61+zej1aLfpCeNsiFMVjTT5Joi9PaNNQei89EMqsmrN2pPqj4APNUUjfFwUbh87icnKQibvrfN8rJgwaDnBGQ3geavSK2o4ybEDIhtf4JKBjGJ22kjXyaXhj91gqhyscscUeUioohJRzOumQGHxfIjls66PNNWY/XLOUgmG5XvYW3IWKL5DZ3fb37jFlWtE4Kd1ir8qMOrOqRj/6VGdiukwLkr5hGQP8t60/yztbiON/B/OAA5SH7MW6+hjVr89qnvIm/k+ZJ8Id38mYuEAOaFOyrd5uuPFKq91RKKr3LWUyn6gzq2QM7/fSXSz5M5JcyjNtCqL1zZpLRAa+pJhAhTfdMPnA/f7lcOVl5UFZw0hrOyaKRPBz1MbzYtvjUbUrn5xLhPeE7IhyFFgBy3a1uvgmAR8so/cmiH+QYIXfxWZBI8/n4r29YeocllRDPBZmSyg6am7hYPAprbdsot1/3uIb62g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(346002)(376002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(66574015)(6506007)(33716001)(6666004)(6512007)(9686003)(83380400001)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(966005)(6486002)(478600001)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tttzp2NIpasnsLmtCLheiK4vB2pYGAez0B3xhk1EyfUOzEqWdEG8XBYYNb?=
 =?iso-8859-1?Q?X1+MhGWlXouJXTjImZj9nLF4z9vc6WzZ1uecUjYvuKzwMWh+fWNUtBr6j3?=
 =?iso-8859-1?Q?eKf8pGA1bOSzBcEt68AfnvtpK7A0q6CyTJEEi533pKOiiFTH1xCmLtCtkv?=
 =?iso-8859-1?Q?ipoTxevIdeULdQponDmNNhgc1LLU0Vps2kz7q0Qc9Hx7XZA8cnmbEoy0dB?=
 =?iso-8859-1?Q?u5Au6v89lSoJcTPPBpMkhUNEVzackTKvIBgdoxFuERMTOP921/b/LcpKaw?=
 =?iso-8859-1?Q?6yWYwvTH/Mz4fH/UqV7VFO6i1cOsg+v3A+tiocnn5udCNnPnFakRWjbaC8?=
 =?iso-8859-1?Q?C23PzWq2uzQfGz/QQtUHRyzVhc09dh41x4b6NcZMaGS6VX32CpnVFwwCmQ?=
 =?iso-8859-1?Q?PMDefEfqPU7lwFjHjq4iWBzH2rry+HZW+o6cUCVi8+n17nwHxeXzXmw4ZD?=
 =?iso-8859-1?Q?ukx8A2s4/7giUcPX+o3GQyWtMpCtaIVmyEB0bai6vg/m+OJUnSRzoQuTto?=
 =?iso-8859-1?Q?8sW+lp9LovOwZs0o6KXngP5VHyl2PsebqkEak+45V9QBkfxcL4GSfweeIW?=
 =?iso-8859-1?Q?qMfnil2/T7UkJwld4kmyrMKEl+CvpdKk2v9XLvi2VUJuWIwL5dYGZWUGMt?=
 =?iso-8859-1?Q?tfcTiDISRHlCQmV4VlANHiwe1tDn8/RCbM8DQmlHMs7dof1arglCFkxf9i?=
 =?iso-8859-1?Q?4VN7PYI0CGePfRwIigmggF4mY/mhjcLCsfDU1ftoXt19TJqiw145CM7ssF?=
 =?iso-8859-1?Q?EqhZn0mNlNOqze+RmDtK/0IKn3FmV77QogDOEXtJv6rxOznW4nOR9Sf5pM?=
 =?iso-8859-1?Q?pcH0P1Nq7pgzq1OaXkwsUJxZAYeQkq2Nh0X4mHWOE6qC1BnSLhyAZu7gY0?=
 =?iso-8859-1?Q?QsAI518VhYgm+eGi8kEzRYKe01F7lndKzQzP6SQW98tLYuI2EoRJTUNJSr?=
 =?iso-8859-1?Q?DuQB0emiWH8xqnc6UynJm7gr83SIP8NRB//0J/feVTUpFgce+zJoPUIeIl?=
 =?iso-8859-1?Q?i3JFb8eRqEVeNoVWQcT6+zafsVGMhCHZaE8IRkE3B97xQ4bejjqbm9kcit?=
 =?iso-8859-1?Q?sbqI8xVqqenuXxPooMgVvP41j4b8tcvm0LMcBLEBczgf4SarrGlCygIQM4?=
 =?iso-8859-1?Q?7k7Yps/oamlF6aNOiQcKoGOi2H/qiQtkp6xaLLhB7P5Y6kfob7AObhSYYC?=
 =?iso-8859-1?Q?/sKm4hN/bybQPjQJSS/czAt70MlatbVXr8RkAE2/FLOB8w3TAePJBDb5ZP?=
 =?iso-8859-1?Q?xZaaRb3eb8ztv/05/VWHxEOpogJAo7o4QgIFnwMwSTwk2ARW3u5rH5vQfO?=
 =?iso-8859-1?Q?tQr+J1JjaxdzFEbPU7XU5Yg3424FiM1u5QdaJ5RcaBBRcY7zXRDcNvrl40?=
 =?iso-8859-1?Q?790RvOh5acLRqlLH74IzBNNXT6zVcsz0eByOIwpPx3vWXqegCILzrgMzh0?=
 =?iso-8859-1?Q?xz+MbGCGkQcZvFkb8A8xuYhOMGrwoAfrem6dHRFhr5vzrtk3ibu7jCnzr4?=
 =?iso-8859-1?Q?YpgvhuAd9uRY9QMcxmNsB04DTFMgiWCE16oz9SsYSKfyb0jDgIDArCp0gi?=
 =?iso-8859-1?Q?bFlyLDqrFpWBSWYxog9KM4TU6xsO+1R4gDq/raeFTX/c9cSs/8hFWiyRyb?=
 =?iso-8859-1?Q?SvjxXm/C16G/ggAGojAUXia56fb4hTgyhj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a30b0f9-cc6d-4b8a-64e8-08dbe413065d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 06:37:36.8653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piiBwoH/HbYSDS2X7Sr58Ztc3UZJI+n/K3/KMFrnHil8BR9pTKvD47ti3HcDGfZA6KNC73a7olTVOvNGW8D4pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8410
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

On Thu, Nov 09, 2023 at 06:23:55PM +0000, Christophe Leroy wrote:
> 
> 
> Le 09/11/2023 à 18:27, kernel test robot a écrit :
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   6bc986ab839c844e78a2333a02e55f02c9e57935
> > commit: 2edb16efc899f9c232e2d880930b855e4cf55df4 powerpc/32: Add KASAN support
> > date:   4 years, 6 months ago
> 
> Must be something wrong with the robot, this report is absolutely 
> unrelated to the implementation of KASAN support, I can't see why it 
> would pop-up with that commit.

Hi Christophe,

We are investigating this case to understand what went wrong in the
bisection process of the robot. Sorry for the false alarm and please
kindly ignore this report.

> 
> Christophe
> 
> > config: powerpc-randconfig-r031-20211015 (https://download.01.org/0day-ci/archive/20231110/202311100157.2Kn3gHLg-lkp@intel.com/config)
> > compiler: powerpc-linux-gcc (GCC) 12.3.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311100157.2Kn3gHLg-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311100157.2Kn3gHLg-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >     drivers/power/supply/pmu_battery.c: In function 'pmu_bat_init':
> >>> drivers/power/supply/pmu_battery.c:171:50: warning: '%d' directive writing between 1 and 11 bytes into a region of size 4 [-Wformat-overflow=]
> >       171 |                 sprintf(pbat->name, "PMU_battery_%d", i);
> >           |                                                  ^~
> >     drivers/power/supply/pmu_battery.c:171:37: note: directive argument in the range [-2147483643, 2147483646]
> >       171 |                 sprintf(pbat->name, "PMU_battery_%d", i);
> >           |                                     ^~~~~~~~~~~~~~~~
> >     drivers/power/supply/pmu_battery.c:171:17: note: 'sprintf' output between 14 and 24 bytes into a destination of size 16
> >       171 |                 sprintf(pbat->name, "PMU_battery_%d", i);
> >           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > 
> > vim +171 drivers/power/supply/pmu_battery.c
> > 
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  145
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  146  static int __init pmu_bat_init(void)
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  147  {
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  148  	int ret = 0;
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  149  	int i;
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  150
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  151  	bat_pdev = platform_device_register_simple("pmu-battery",
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  152  						   0, NULL, 0);
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  153  	if (IS_ERR(bat_pdev)) {
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  154  		ret = PTR_ERR(bat_pdev);
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  155  		goto pdev_register_failed;
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  156  	}
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  157
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  158  	pmu_ac = power_supply_register(&bat_pdev->dev, &pmu_ac_desc, NULL);
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  159  	if (IS_ERR(pmu_ac)) {
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  160  		ret = PTR_ERR(pmu_ac);
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  161  		goto ac_register_failed;
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  162  	}
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  163
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  164  	for (i = 0; i < pmu_battery_count; i++) {
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  165  		struct power_supply_config psy_cfg = {};
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  166  		struct pmu_battery_dev *pbat = kzalloc(sizeof(*pbat),
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  167  						       GFP_KERNEL);
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  168  		if (!pbat)
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  169  			break;
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  170
> > 35bf559145b633 drivers/power/pmu_battery.c Christian Kujau     2008-05-02 @171  		sprintf(pbat->name, "PMU_battery_%d", i);
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  172  		pbat->bat_desc.name = pbat->name;
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  173  		pbat->bat_desc.properties = pmu_bat_props;
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  174  		pbat->bat_desc.num_properties = ARRAY_SIZE(pmu_bat_props);
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  175  		pbat->bat_desc.get_property = pmu_bat_get_property;
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  176  		pbat->pbi = &pmu_batteries[i];
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  177  		psy_cfg.drv_data = pbat;
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  178
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  179  		pbat->bat = power_supply_register(&bat_pdev->dev,
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  180  						  &pbat->bat_desc,
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  181  						  &psy_cfg);
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  182  		if (IS_ERR(pbat->bat)) {
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  183  			ret = PTR_ERR(pbat->bat);
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  184  			kfree(pbat);
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  185  			goto battery_register_failed;
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  186  		}
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  187  		pbats[i] = pbat;
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  188  	}
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  189
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  190  	goto success;
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  191
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  192  battery_register_failed:
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  193  	while (i--) {
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  194  		if (!pbats[i])
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  195  			continue;
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  196  		power_supply_unregister(pbats[i]->bat);
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  197  		kfree(pbats[i]);
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  198  	}
> > 297d716f6260cc drivers/power/pmu_battery.c Krzysztof Kozlowski 2015-03-12  199  	power_supply_unregister(pmu_ac);
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  200  ac_register_failed:
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  201  	platform_device_unregister(bat_pdev);
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  202  pdev_register_failed:
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  203  success:
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  204  	return ret;
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  205  }
> > efea58e397dec8 drivers/power/pmu_battery.c David Woodhouse     2007-05-04  206
> > 
> > :::::: The code at line 171 was first introduced by commit
> > :::::: 35bf559145b6332f5465c15a4e5cd7a363985382 PMU battery: filenames in sysfs with spaces
> > 
> > :::::: TO: Christian Kujau <lists@nerdbynature.de>
> > :::::: CC: Anton Vorontsov <cbouatmailru@gmail.com>
> > 
