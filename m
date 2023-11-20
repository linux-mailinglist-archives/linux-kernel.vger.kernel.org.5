Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E717F0A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjKTC3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjKTC32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:29:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E165E133
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700447364; x=1731983364;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MiG73UU+b1IOAoY8S1436zTPgduktGQDtjKW+CgzvHc=;
  b=CYdFQc311ObiXyZYLJ0fR76GaEHWJk2fcBphqmlYd2LDuNeLe9ZdZuGG
   mH1vapGgH+YDNRHrOvPJ8D7ruPdR2Og1wz/25xVkqmoVoT1X6mjdr8cDV
   neju1Ue+Q3vgIGPnfmIPJkGV1L5U0TM979+DSkjbaE7osnhJmRrh5kbla
   yLh2ZI2JKKv6wk4JmX9GPl6wqTn4eRMhtWLd2d8FEjGQU0k0dzaAlLQVY
   h6/TlcBBle/7zI+7qG/Vof0XYIbQe87xTw4Tq2jp5RmQpAP6UWaFuiZpN
   Dzs+32nrCZN2AfAFvW0iAbbz9XQ/j9XT0n7eSemodG/qmx8LmQLJUMdRz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="381926755"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="381926755"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 18:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="856858866"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="856858866"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2023 18:29:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 18:29:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 18:29:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 18:29:22 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 18:28:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LezLfdevFyzdeqbCGUj5h+J6flBmT13NA3xwvWn9f30CZYng+Zvh33GC7e3fzvdBWDSBvb5tXqQaT4a9Lo+X10/bmBzfdiKefK4OGlbcOSJNVAjI9wRyeW5PGPpYE9imnEBP/K/WnTtQE/CM/hGNKmt2D+adJbQmGYK3PsK3A+e/Ws31JOSOw7osh8F11YgcN8UqSid3CvlPdELu29VBJswSPodc+jearWNqx4pdcDZvl7rd/aJV2CMO2BRxdJpxBe/wDWswYMFBaqnuihCqvwpIf8c4duuY8N2v3dhU3caKwPXT4MToUgyT+MDIiG7+Tp8SHVnI9ZNf6n9ixGfuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTk0jm5iloyLtvqgeoSgEJQAEfpEgr77gHf3QX2PxV8=;
 b=Tjny9QZlcKoQTELM9v06RSl4G59w7KltpW5ke28W1t2bhpWK6BrXHBpA21Sm8FJLnf/Q6bfK4nPDZAhvxMIAAhjTAqT+4qWTMnhT+6JI9X93EBpGWVCWCYJU7FfmUhhXpdlf++qeozK8hHlAgxUZBhPXaPNG6IfPxlmybBX95BwTGB61K0FII6HZMOoJG9VVoiNMPduRYpnDH5LIBMHMZt3mf1+CDdGcqnbe+RvUl6d1/9IfTH61U5qmdmPx7qvuvydOZ5sRfS7S3ZLfvVQw4wNQ8VfLBQR9BznTpdygqzqNfoxBVDZvYaBo95yWbaBdCXYe3jJvdKXmRpJUuKcD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 02:28:51 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 02:28:51 +0000
Date:   Mon, 20 Nov 2023 10:24:11 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>
CC:     Jakub Kicinski <kuba@kernel.org>,
        kernel test robot <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Alexander Duyck" <alexanderduyck@fb.com>
Subject: Re: net/core/page_pool.c:590:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <ZVrDS36X24I1Wkqi@yujie-X299>
References: <202311160339.DbhaH8LX-lkp@intel.com>
 <0c95b547-ed2a-4967-b561-1e6defa4c5f4@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c95b547-ed2a-4967-b561-1e6defa4c5f4@intel.com>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW4PR11MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d14e99-a805-43eb-9cb6-08dbe9706f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MJ47aNZ/bDvEoHRA9B2dpISw7+8cKNJ9e1fIkkbvWfJ4t8wfy+AxZgrWyv2RAF7ZATChU6olV+aX0GjDvgB288IRz3U4ahhQeibFHr6UBNNlSUEiujrU82devhwkQUCgzlzuj5nO8Iuyghh8SLb+hLCrtmw+QDEXcClqY0qfxT0HR7qoanz/c7rCDqYqNw4p5rvbYIMQBJ95kViLsmoRl/d/9g08U9dAWewxRYRo3PKoBe3oXG3TA0OGIOWFHIltwpH3lUaphFJSv/jhkkZboULiWWp9LJoFykA720VZNB/4PWMdKi61y6eTdycZnlUknocYf8igXUD5q5YPkDhsnkXtRIgSEVMk9J1IEAbg6FMLzZs0NUXzg5tCj9lKj7i5LoFryNv/JTf0QP/GR+bg9cwpnmoVmhhrIE2tpHCWWGdV2Sepp1/tRb8lY/wsGXTt9kOibAEk3a06P+1BZ9egWCw5UN93j6vmAvV6O6KhPpndiJPp7aa7U5AWTnaOsl3I//GXHJjlcyEmK1pBH0YJhQ/l7IZYnEpdw/tYIQ0CWfNRCEyGDx/PdL6L29kWMDxZgBVq/kVG4wX/PH3n+/X1WkNQglAnv5enUm5/UmiM6TtLe8V8oUtnZpWAv4gQdsHmczrs+zDp76NloGUCOIOJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(376002)(136003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(6506007)(41300700001)(6512007)(9686003)(83380400001)(33716001)(26005)(82960400001)(44832011)(4326008)(8676002)(8936002)(5660300002)(478600001)(86362001)(6486002)(966005)(6666004)(2906002)(66946007)(38100700002)(66476007)(66556008)(110136005)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VF//Em32KepTmY069LIUGYc22btMVy+GFtNhBZ0i28TZtUfleDwLD8JKOj3J?=
 =?us-ascii?Q?CNSe2YSIs+wRGsjJT/EW4QOT+zet5s+JtOoY0BWHsiZc3NKCPUhhzmSUcla6?=
 =?us-ascii?Q?35glI9rpXkhr3WyA0dpInzMhv6rc8bJUbdfBclXlxp4MTTVjMJLNp+hs7uSx?=
 =?us-ascii?Q?9Ayu9lVuYF1mmVJVZUuB2Kka3plAdjHsk6715HGW9MeAw3EfLVqYW7eIdW/U?=
 =?us-ascii?Q?m9OvPdoMPpHRpQ6+CnoYsU408NPj+0/UEKEt4gXRKtvV/4eWsTI/qm9J0BqT?=
 =?us-ascii?Q?9RVLHZBwVNLFAfBWVlxAGX3uLAAbO8Ax2NgkcEIjyOfm6b1Vw+VS8qjSP8LO?=
 =?us-ascii?Q?W1stBDcoJkK1TmlPSB4pIQs9I0IV8rSYZ81dW50xwRH72r4Fcu/miXDfsGUT?=
 =?us-ascii?Q?nTw+Mx23pS+zBoYCYKve2uJw2SP+FDfyIhPIGNcjr/2hJDrvXhfnS0U/8Cj8?=
 =?us-ascii?Q?QHpHYRkhVv0Zbw382YmfcCO2xbMV/khHM1kTV3VkVJleJK1V+bhyMrzxoSwy?=
 =?us-ascii?Q?8vaL1Z1rP8bwG/07kku/BsFNAFAiAx0CVrX+81O1wED7LwH3h1beUtdVEnS1?=
 =?us-ascii?Q?qj/ml8odi2GV5+sG76GjeIo2Mhm+WEjlskFtQsMmyuEzHN/jteWiF1JiU2YV?=
 =?us-ascii?Q?GrJVrPuacMHiAVSvgT8432ZeOI/ootd42v9lvL8mh1AjHjMfiui2Dl7KHQow?=
 =?us-ascii?Q?y5eY9dHy/SLXTrDgSoUg8pZqEMyvt/xVd2gCjcudxO0MimKSZle0n2HMYO9H?=
 =?us-ascii?Q?Jk5bMxoMCZES7rWV7hKixsrsPSjTN8yvFjF9SCRxa6dtUHQ86TQBNloqjNbH?=
 =?us-ascii?Q?ij4eYFHwSZYE05xxqj04Wf8oeJIyiUsxWFyBFoQPOR6eco0gOBifG7so/Rzn?=
 =?us-ascii?Q?kB1lws8wDtEQNqwkrPJRfB6WYj5qS5/gjr/MGe5uSpa6/lPhRADvQ8wdxIaf?=
 =?us-ascii?Q?L85ervJjxlmYtGhb1fcWUykJ1++n50WbAeMZbrx+eBEDC6JAXdztJAu5MLrE?=
 =?us-ascii?Q?lMtay8Ldh7zk4ncWWrHBCz5g3Ar+Cf25eoc1uTImFrZBFFUMKNF+BKzzD8JL?=
 =?us-ascii?Q?Zt2RrV4Orc+YWde0FxVYcHh56Fsvbhw4YCcZvccyvexICOjkhHLvPtrzAFCV?=
 =?us-ascii?Q?yzPgvkNUl3qcvhWR+ZRJXvtmDqHzpLoskMl5sSabAGh7cXYCyfE9+RjmDS6U?=
 =?us-ascii?Q?f8j50ReRpLD6374MmU+W1JmxrR+ODfvcYvrv/MYGgh+tSrSM5y5T5X8ac9WN?=
 =?us-ascii?Q?F8qMMMIu7CH9TQ179OL4SivYMRInCi3Mo/NrI8SaCypYP4lUkhRwIsWd42Zu?=
 =?us-ascii?Q?/xaayM7gyygHq/GOj9LpAvndeAyw0ct/WEBR9xKGrdyx0mdD+z3ZOdHXi1EK?=
 =?us-ascii?Q?F6xR1NBzMg8yjKAFhO9GQz6a8otjN3p/muLeN6Vito7UxkYcXCYy/J0jZi33?=
 =?us-ascii?Q?QUTrdEB7OhAUVSPfAMX8LjLig9FRwXxrctM54i2iSw1bT4NZP/sZ5/F+nHou?=
 =?us-ascii?Q?6oXUEll6JaFPGtf592zYn2y7XInYcDApr8dXBPSSzusrn6rOQn8weG0AzcCa?=
 =?us-ascii?Q?WmHS3KacXkHwZwf08zAT+Hf5geHOerTFozcoedqM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d14e99-a805-43eb-9cb6-08dbe9706f0a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 02:28:51.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 426nLiiwhjqWKFRsSx3+2ccPyvV6dcWMWZWPwWv+Mn4UUAY2vAwGuK5WCDi8G2QHXFVUjsbPhpYLjerGAX0jAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olek,

On Thu, Nov 16, 2023 at 01:06:46PM +0100, Alexander Lobakin wrote:
> From: Kernel Test Robot <lkp@intel.com>
> Date: Thu, 16 Nov 2023 03:12:24 +0800
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
> > commit: ff4e538c8c3e675a15e1e49509c55951832e0451 page_pool: add a lockdep check for recycling in hardirq
> > date:   3 months ago
> > config: loongarch-randconfig-r133-20231107 (https://download.01.org/0day-ci/archive/20231116/202311160339.DbhaH8LX-lkp@intel.com/config)
> > compiler: loongarch64-linux-gcc (GCC) 13.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20231116/202311160339.DbhaH8LX-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202311160339.DbhaH8LX-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> >>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
> >    net/core/page_pool.c:590:9: sparse:     expected void *ptr
> >    net/core/page_pool.c:590:9: sparse:     got unsigned int [noderef] __percpu *
> 
> Eeehhh... False-positive?

This is a loongarch-specific warning and should be fixed by [1].
We will configure the bot to avoid sending similar duplicate reports.

[1] https://lore.kernel.org/loongarch/20231113032511.860159-1-chenhuacai@loongson.cn/

Thanks,
Yujie
