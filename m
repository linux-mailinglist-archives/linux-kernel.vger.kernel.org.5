Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411CF7AFBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjI0HTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0HTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:19:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C5111D;
        Wed, 27 Sep 2023 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695799154; x=1727335154;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=9JBV6ym+GLfhsm7sbmcDIfNeOUleqTiUrvw6KT8CmeU=;
  b=CNAmycv2QjEGHNTA4v1p8t+wUU5rPrSIe+uNk2omAx8CoV9lkBdf9yyJ
   pIgaRD4Vkaw5B8X9McTmDxCMnLQFLKhGOACrGeZRE35xwtMuT1/ju1OMO
   OFVnMNPIJyDnirC/ROQ+J+06TLkksuxiamBqy2zky+TQEl2ZXok/W0PHn
   uvsGCVV7bQ+am3s+gTxM8VgSLPMTuiOPPbkusFCRndrZAKM5y0zs4zkeW
   iMmU55NI5G5O7Kyw5nXz86Sp3/Rs+WPh76IeneDlbhDsBEtx5AN6yuaMh
   hnSb6xr0keMpD1Xhmb0bDwU5UgyIz6/8YiFiwHVVuAFmAHO2FNyvgE2oa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381652988"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="381652988"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="742611642"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="742611642"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 00:18:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 00:18:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 00:18:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 00:18:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 00:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3vm3nbDGg28fYTdvMV+QpmgpbfKHBgAzGeghQJUhM7MrG1Zc+HEpfqzwDPmOlwR23PV5YCFxdlxNiIGhZ+5B7219viZtMMLMNA065bYA5riFdhv+Erp5kCEt733s3J/gb+W1spxcGTqQvr8l07wI//tV/oR9QFN4pOww4Bi4RbPMZU+4qvtUWUsoQ4uzAHTDxq4Y4b69x0aq/xUvnsGvMmIY6f1sOgycwHzjqqLli1JgGW1XfQBs0tdqkgBZyBP7/ue9hTr0YdYNi8J7Fwl/S9I+5v5rNyNxdCnNRNQl/Jk8QRsOdvHYUl/NR6rqzLvQtV6rJH26ZqYZujpGPMfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BKxL+mH2ZhL3qJIesLEqjQKQbdQ4txwORrGSCUfpg4=;
 b=V89YnTsBeNTcRzBXYInHbNkZcVUEhkydiUZrJkShRLXA8u7mTC/r4JWilCXAPS91va0KBBEAv7/HBMKSoEX8pSyvlhSUZ0HJTBN46aBEMxf/ZtpAhas6BQzPK7iBxe6zmFU1ZgdvNgYyfTK3HCTEsI5T4AZZX4+vRN4Qy3Xvo65WvkiRAAS18UlvJdK4Ue/+32XcmT6fXJboygcUM626k2V6Mb81lSLR3a0ice69jYaAocbCFneihCkGfqrX7L3e+EmTjHNg26nd8LTxiXmgBw5IzAt0uP+aEXXcJ2PKqDFcyJviAamlnct2fP6bvp4hQwTDTBI7qdP6RwFYBgP0IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 07:18:50 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5%7]) with mapi id 15.20.6792.026; Wed, 27 Sep 2023
 07:18:50 +0000
Date:   Wed, 27 Sep 2023 15:13:49 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Robert Richter" <rric@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-media@vger.kernel.org>,
        "Serge Semin" <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 13/18] EDAC/synopsys: Introduce System/SDRAM address
 translation interface
Message-ID: <202309241453.RCKvoFI9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230920192806.29960-14-fancer.lancer@gmail.com>
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DM3PR11MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 3474b445-0c84-4f94-fae0-08dbbf29ff27
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szwWl+cOIOavim9zGynzbVxNMleVxhG8LvK8UVxCHVzqb3HSUUigKSPMYiKbcyHabkZvwDwoq1hX3FYHRX0A5hwMryZAscgXO3s2V8QEOnQwwZ/K8fvwdyac/qENWa+oHDU4FgKVDSQ3ge/i5/ZBjj3CIlQjR2zBlcjTPmHHs9mY6Tx4DWVNyjc9e82z+zK2NrEHaUGLxP5acofiYcUk3QC2E6RR7BhAeUTiYioT0xmMRAYlPGIbVqs8ntKbCtaB4Uv31Lpz6kbGS5cAPf99jGabuyF7pUapQqIaBQnn8d8qsndnHn7GKPwD11gXMpL3dvO/hiUQxyTjRS5JGc1TqqEs0dxpyuAmwW/jtDaOE6pPmyBFPRavPMz9nj6Z9QSCEZy4zLI8Mii630M7MJArG7I7TV5M/TuvYyayP2OCx3jgaJZHq/medhAVXTFDfdKopZftdDaxmSlYuLUL1moLayhl5ykvUETVFqNf72kQY4AVbsIVEuR+b4kC/F1HWJTnyJNENFJT2HDqhWDD4p7Ns7/+oTP3YoBEaH0++0fF5Ma6LLu1018puD4kGInxwQ9flpiLNsYFl8GurPJkOHELfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(83380400001)(26005)(1076003)(2616005)(8936002)(5660300002)(4326008)(8676002)(6486002)(6512007)(82960400001)(478600001)(41300700001)(110136005)(6506007)(316002)(54906003)(66946007)(66476007)(66556008)(36756003)(86362001)(2906002)(38100700002)(966005)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dy+cZZ1zdVgd5/8N+Ie8bhEEuzr0kNHnlJkdnRO22K92l8XWB+Xj/PMogY3k?=
 =?us-ascii?Q?S8X8bSmKkqyRL45QWUBNww8uFtQGK551vkQ6W478ts32yDasvomnZMDOKAGr?=
 =?us-ascii?Q?ESvgKMwzpK91mX+O2erKDd2jqngAGYPJAoCaW7LzsrZQqDlK1kb4HZbOmC8D?=
 =?us-ascii?Q?0aKHwjEj0fYOAsmIW//0TKNdiveIArpfOaJhFO7boM1J503+XGQbXg2Ha/y8?=
 =?us-ascii?Q?cmgsmyPV6oFdP2u7/92hj6x9rU89uNzFaGeHK207uDTpopBM86YLbDOTS2eH?=
 =?us-ascii?Q?gcbwchWRYRVpJ/HEVwO988a2BRlReSzvldU8a4pJCkZUV0JntnXTnhVpZRle?=
 =?us-ascii?Q?Fm7+VIOkzxHgjCo89JEugp2517dSn0pjrwE1smSJGeZ4zJGX7FXLMIgHY2zH?=
 =?us-ascii?Q?AfAMs5Cp6fzYlbqt5Ctvt8Wx7/y6KDPB/uMTW3vDMAtO76aRcvCGoWK34zk4?=
 =?us-ascii?Q?SWf4CtHRiGYCY1Yo6F+4J09BpxQN5R+AXf5IXDydZaqKy6a8iePIPyexkQC/?=
 =?us-ascii?Q?kyTQBarRc47g3411R2JvdJIGnfyF/8nw7l9OZi27i3ecVS/CBxLhK7jVwwiJ?=
 =?us-ascii?Q?sXYVUi19FatVsa3aRzSWmiuUf2f6eLOVY6x1lp6hwiYCRrSn5F7Wj0MnKdbn?=
 =?us-ascii?Q?oGbY4v+WUUS72/4G5svRHp9aKhvo978hgbc2Q38VZ40KeiQQAXJONshVGHrI?=
 =?us-ascii?Q?NJa6wPX3rDRc5alOUnZ1kutiz5nQQfgtIXsYgT3UbQIvaeQMXES0Ta4Tcffq?=
 =?us-ascii?Q?nfcTdRclaccC0Fp/D/Yu00hqkvZ8y8v7ZXHKdg2HjmJFi97P5heUUIa6LGwq?=
 =?us-ascii?Q?zryVgDXD59tna382PyBb22udLJCUBKlIRsD2ZZKwItL0sb0PDxv/eXToQlfv?=
 =?us-ascii?Q?WMrn7Pk7iaibeSy09mE/jbj3fFxkKIgmvj3XDd+3UgzT1NPTuY8wqU8QxODj?=
 =?us-ascii?Q?4BXsNET+hbA3dJBjAkPTB80WX1VzD5w4pZOuEgYdjCx1PuVVDaitskzhSZjp?=
 =?us-ascii?Q?LcVtWjiEliGH0Ohi6anfwRwxn0UkK7u55SPp7YFY1ojUAd36jlewj0FFwdIH?=
 =?us-ascii?Q?Pfu5/3UpTmt9vaanjWi9FuGj5LyJ0g8gWyLDxfonF7TOVj8fgDFJSqVrV1GA?=
 =?us-ascii?Q?B6RsjuKzQRs7lc3N1sbnlbv53KeTReo5ACD32VAfygGsAWzYjHS6kiRorJq7?=
 =?us-ascii?Q?eQB0W0aNZte97G7BDVEPASF6/+pIhrx6qCFUoAKUU1u4Esrh84YhIGAOlUBX?=
 =?us-ascii?Q?oSj8CzKPV9lH59DTGcQ08EYDoMihdaehciNGOGx3tiYcrHGZdqJvf72FzNef?=
 =?us-ascii?Q?HIOUmcDKlopXHebH1lAn5K6dSQEoozxd+7I/BGVReO/GNDzF9kdfE0yPuzNF?=
 =?us-ascii?Q?XT0xv6xIiIjOGQ7nHTIS++wWsUUOCsQz/v1qrI00v7xrdi5BL7TsRB8iXl7S?=
 =?us-ascii?Q?78bxq7TTGV7EHPkkumaoJNkOit1hF4yoT/5JfLaD4WtLKmv0QD7Ow8SFv9nT?=
 =?us-ascii?Q?C/IXHn7xDG7lyX2MtPt9zVjFJTMq44Yas0MXFSUurY672IwD3VYtiCU151hC?=
 =?us-ascii?Q?rQPkBBxxhfnTxDz18HvkHBB/IbKfz4wSvSA9S+vf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3474b445-0c84-4f94-fae0-08dbbf29ff27
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 07:18:50.0326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnY6CM3K+mf8tzGU3lYGxUUdd5HrW+xvPcxJC46h/ZCkOGhaOeZ6TzUv4Gvh/urNQAlzHCw8HYnZnwbeCb/bDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
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

Hi Serge,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on linus/master v6.6-rc2 next-20230921]
[cannot apply to xilinx-xlnx/master bp/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/EDAC-synopsys-Convert-sysfs-nodes-to-debugfs-ones/20230921-035302
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20230920192806.29960-14-fancer.lancer%40gmail.com
patch subject: [PATCH v4 13/18] EDAC/synopsys: Introduce System/SDRAM address translation interface
config: arm64-randconfig-003-20230924 (https://download.01.org/0day-ci/archive/20230924/202309241453.RCKvoFI9-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309241453.RCKvoFI9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202309241453.RCKvoFI9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/edac/synopsys_edac.c:482:13: warning: 'snps_map_sys_to_sdram' defined but not used [-Wunused-function]
     482 | static void snps_map_sys_to_sdram(struct snps_edac_priv *priv,
         |             ^~~~~~~~~~~~~~~~~~~~~


vim +/snps_map_sys_to_sdram +482 drivers/edac/synopsys_edac.c

07abea90e8d373 Serge Semin 2023-09-20  472  
07abea90e8d373 Serge Semin 2023-09-20  473  /**
07abea90e8d373 Serge Semin 2023-09-20  474   * snps_map_sys_to_sdram - Map System address to SDRAM address.
07abea90e8d373 Serge Semin 2023-09-20  475   * @priv:	DDR memory controller private instance data.
07abea90e8d373 Serge Semin 2023-09-20  476   * @sys:	System address (source).
07abea90e8d373 Serge Semin 2023-09-20  477   * @sdram:	SDRAM address (destination).
07abea90e8d373 Serge Semin 2023-09-20  478   *
07abea90e8d373 Serge Semin 2023-09-20  479   * Perform a full mapping of the system address (detected on the controller
07abea90e8d373 Serge Semin 2023-09-20  480   * ports) to the SDRAM address tuple row/column/bank/etc.
07abea90e8d373 Serge Semin 2023-09-20  481   */
07abea90e8d373 Serge Semin 2023-09-20 @482  static void snps_map_sys_to_sdram(struct snps_edac_priv *priv,
07abea90e8d373 Serge Semin 2023-09-20  483  				  dma_addr_t sys, struct snps_sdram_addr *sdram)
07abea90e8d373 Serge Semin 2023-09-20  484  {
07abea90e8d373 Serge Semin 2023-09-20  485  	u64 app, hif;
07abea90e8d373 Serge Semin 2023-09-20  486  
07abea90e8d373 Serge Semin 2023-09-20  487  	app = sys;
07abea90e8d373 Serge Semin 2023-09-20  488  
07abea90e8d373 Serge Semin 2023-09-20  489  	snps_map_app_to_hif(priv, app, &hif);
07abea90e8d373 Serge Semin 2023-09-20  490  
07abea90e8d373 Serge Semin 2023-09-20  491  	snps_map_hif_to_sdram(priv, hif, sdram);
07abea90e8d373 Serge Semin 2023-09-20  492  }
07abea90e8d373 Serge Semin 2023-09-20  493  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

