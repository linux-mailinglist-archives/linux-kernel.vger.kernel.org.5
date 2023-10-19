Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A077CED96
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJSB2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSB2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:28:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED28D9F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697678887; x=1729214887;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=xdarTUSzMjZZI7UcAjk3wzTzTJa008SMfTLc7WQUQrc=;
  b=MNJ0zeu0pxsoX8XuAVWFsHVfIieNiX3UC2O5Fi/YZsnYRrw5yb+OvQsT
   vStfSx59W0ZF6FYnVulEsSVEIJ27V37fYK4CuiNMjN51X4pMGN0AMFJ3G
   zSWcKvi3Nrv7rJbnNcjW2aKsErdLH7w84zCwk9amSKAXo//sQeGTK3shn
   aiVJpL8divw70rJ65Wo3o2oqw6KbGCPzlzONqN8kCFRHlYkvlu12AA+pG
   hjKElDYHIbeqsfwJYzBaA1hD4O+mxRWw4HT1gxvIb+uzWDYuh8CyOOJkg
   OjzT6wejB0iOR0vIqN6OwTmUYhf/h9bS5Pz4kmGjo9XpyKG2XWaOPkyKM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="389010165"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="389010165"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 18:28:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="880450436"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="880450436"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 18:28:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 18:28:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 18:28:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 18:28:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gktscDNm78qHEp2/P2mtwBmKtf5X3jwPL6binLe0ot+mhEauma1zc+0EAH1kC6Ew9Lj6KwLyJxi/zSTsi+877D3MHdaHmfZDT15UWf0geTqcIjPP5BP7LHZpJp23S9AhUvRS/wj3Fp0zEWVYKiHbprou84+K4oOOh6UUM2WCgmu2ixb44IDb3EvhiGBJvItG8tLgRQihHsYQSIbgrDlsqbo6PvYOQlkWVEbIckvSijKVBB5/mg/WOrhSebmHd2dc9DG3T6tlvexHTto0PDqsQ1EOU7TgQSLJuaFYcgk+hzPYxA2cAavJhVOZAwQQs87o6PCmUXQqPg1kxpJtwiT/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bzPyettRcUkEp3ZYCbrnztNalwK6wMXpPSE8fknrzE=;
 b=O1nLubJi1S28eD0zoQdQK3OvElh1CbWS/EG88Ah8GPCDw8zM44n4kRGHADnwEYM3uvqnh98eio8wexyf8tVBhMPu/E9m82MXz6M6qFz9x9aytM/8dLQjUaCpDSeZbVmmSZY82PAFA+BwOPd2H6hUVmbmAD7h6HMf7Vwdv/gxDSHtod5lf2VaZ/GVrwZthMTlf/y2ei6/2R5U5YNWyJRkQbYiiSP6juDfBfjny6kfMAb/0fDeYJw9b+q7JzP8IIB5yXErXcpadiSQx+5uUP21K/W0unPtPIaueGf1zUPUN7BePYUEKAiXBoLX7vDuWE6JuVfsGols2KBDRJ75v9aolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB7514.namprd11.prod.outlook.com (2603:10b6:510:276::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 01:28:04 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 01:28:04 +0000
Date:   Thu, 19 Oct 2023 09:23:13 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, <miquel.raynal@bootlin.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <Frank.Li@nxp.com>,
        <alexandre.belloni@bootlin.com>, <conor.culhane@silvaco.com>,
        <imx@lists.linux.dev>, <joe@perches.com>,
        <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] i3c: master: svc: add hot join support
Message-ID: <202310190611.b14M4mH3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018205929.3435110-3-Frank.Li@nxp.com>
X-ClientProxiedBy: SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdb78da-de38-4dd7-887f-08dbd042a3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qda3HCOq9WPnWqsjKz2TZEj9WAEAnYO/ZszHFSserXOJ5VVE8CgY38edzJDDnfForygQ999T7Y7ChXNs3oijaymFDTTbBze3CST34KxUH5mOcebrW1+295U+5jpKYRiG3GAf5lirHTyjFyqtaqtR3BEZouaPODbUepMUIWiqVbrV0m860lggWzepQnzqK2eQWiRRlpkQ6b9eTJMTyXZRaDDAGs2jb+IUUWK01Ygtc9azxQxTvuUKvUEJKEur0sZW3rsqzjJlc0Zq6Db2DZJyQWYB4KOu6ynKB4MT5SgG1YIlb7xa4Hm0Zj2pcvIoDdRPsxakgG7+9GXlfa+lEVB19eCOhLmjOVLv59/yfVHg6qBhh2m39MtQGVcG5tDnTvFix/OTjj20j6r58vcheSawa/6nnEMRu2rE7f/ovnQxtkUOa8Gcy5fvkDx6NWD79QVdm8rn7jdNzVlCLQaHfwGnkXAQ4CF0IfSv0ytZwuAy8nkoXvSghac3MzoogiFda9MoZ8/fNpfDe9cY61bSfmGOngE1Ht6Wwtwxk1WPLlm4yEY50uWygmWZsLkxjmJbIz20/GcvaN5xukdKcj+Z9xEBKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(1076003)(8936002)(6506007)(6666004)(26005)(2616005)(966005)(478600001)(83380400001)(41300700001)(8676002)(4326008)(2906002)(6486002)(4001150100001)(5660300002)(66476007)(66946007)(66556008)(316002)(86362001)(82960400001)(38100700002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iRepuQAfEnmnoxqL0u+WyCYgx+eDLNUEAGkhzHA+y4/+HHQQilNKMcxnOhp3?=
 =?us-ascii?Q?8pkQt1K0sdGKnhBmQCulwcWRZsk0DpJ4r/gPkv80OA/PFdIqs9B7f8b/kI8h?=
 =?us-ascii?Q?DYu9a0z+ieTjeiMlfI1rANZ3X3fEoPGBMfh0377OsTbYBKcbNmkNwJLAKDlM?=
 =?us-ascii?Q?ggoSBuMm+t73oOkBfMGyCUZMYvgS1sjrilR0A7ukzpC8b0KVDd1z4u60GIu2?=
 =?us-ascii?Q?ua4XBeYDCW/FIIZbQK0toH/WshDwno3s2YXIC9dt1ocL6sD16Wjh5d6WwDwg?=
 =?us-ascii?Q?5PoWAk+ouBrHgKfVLtF64cKn1ZS8REJ4pOsh1Nc6CL4rewq9CXunMN3IqIii?=
 =?us-ascii?Q?oqRi5mbSDNIcF74W3D3bN53yWmh8EtqFN/xDwpkqJ7Vq/Vtlsk03lgT/++xp?=
 =?us-ascii?Q?S02tgLmvhjXNCWCm01j790rGDldDqvhdjEPNAYgBbV78bsEcmo06K4MecTrF?=
 =?us-ascii?Q?UZud1jMbTxLwOG4vip+2ClqVe+4Md9wxhsT4PBtm8o2Xfi4bFYxJqGjhn/36?=
 =?us-ascii?Q?18StJKmlQ6JOySiGuUavkGzGb/p6djlLVMcPUoeFy9hazfzoe2rnLMaXnHCn?=
 =?us-ascii?Q?jXt8pHuilHPgsrPgShB+7/L5VTrJJM3MQykuKnQhwdBLCVbMsfyQ5e7hTIXN?=
 =?us-ascii?Q?6+zaR77rj3jTt0lV5HDOu+VdTU51Crt9O4/A6/9ls9KegUyoDG8hp40aTjtw?=
 =?us-ascii?Q?Mj6spZYYRRuAsNo7sb5sWaT3k20yqioJy1LHezgxEDtbuhdko0d+trJpp+aa?=
 =?us-ascii?Q?RqFH0ZJL4N1L4clUQUNAPsljKVZxJNSNZtWINqnVwf5MxstezoenHVWpTYv6?=
 =?us-ascii?Q?ri8Stv8lwGwi8GCpsai4UeCeWis07fJQRTZkXGesYHuDa1hTevw6vDmc01zu?=
 =?us-ascii?Q?6WOOumoQa17V0dOnuMb0XdhHUgr8QCYNOkLbF4gygdUdRgvQqlgEb9zIDTM0?=
 =?us-ascii?Q?ievEVUdZO/IAz81f/yLBa8z85arqwUK8TWxsFDcdjXPcVd16v9fj+gp49LRk?=
 =?us-ascii?Q?mAtW6xUZ9nEYN/o/UJH4yu0hIp8FYt4XZ45rWBT9vi0K3WrZIklI9JrJyt5h?=
 =?us-ascii?Q?AXfTcJg7mVYNno0zYuk5pBRflu/8o15vXvXrwTyzhG7SSbR9QmbXSkekmSeM?=
 =?us-ascii?Q?4TnvwnJKJvgnf2LL1DfHEG+I2jhVursEtqUHzvcgf4uBZzMOI+FmsZXDc9q0?=
 =?us-ascii?Q?HUMfBm2XAEFMgIJumsqPLAgUFN21VsE3RHrg+f8FD4obrElZLvBhiqfQ8SNV?=
 =?us-ascii?Q?CYMT629jBhd0vEwiS7Cpm8CVTR5UJK9kJibuywJagLIOk/lgBAJOg1vXZzUD?=
 =?us-ascii?Q?uF33yiDYN8S9vmRYbJur7MmLJNU4ODIc01iCFyHQff+6mKPjL5O1bWe9OgML?=
 =?us-ascii?Q?xuvPUAbOKZvfaqzsHe8JsqwEuDNCpDc43aewzb/4OKIx3PMtPm9P0vQznZLc?=
 =?us-ascii?Q?KOmLf9KQ4BFfcolfdkimH83JTiXJPQYOLzyDtHwHiNgrw+QXAXu+FGmqfN6N?=
 =?us-ascii?Q?MEICN7dbkk7nPz4vcrwYH+zdM/g9KsmC1vU41f0Wb/FmRkkyvLEHXapno9HN?=
 =?us-ascii?Q?xJZN2fZJ+t//Q4QHiLbZAzr5YcAV19DUaj0/jkJU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdb78da-de38-4dd7-887f-08dbd042a3f0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 01:28:04.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eg9ByuUwr2qaVE20cKeaRs2YSyqhbYd1z6xIBeq+oQ2yeMl74+jpGu5dBngN3KsSMJsD8kbheqEoJ6qgrJTZhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7514
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc6 next-20231018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-master-add-enable-disable-hot-join-in-sys-entry/20231019-051444
base:   linus/master
patch link:    https://lore.kernel.org/r/20231018205929.3435110-3-Frank.Li%40nxp.com
patch subject: [PATCH v2 2/6] i3c: master: svc: add hot join support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231019/202310190611.b14M4mH3-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310190611.b14M4mH3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202310190611.b14M4mH3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/i3c/master/svc-i3c-master.c:212: warning: Function parameter or member 'lock' not described in 'svc_i3c_master'
>> drivers/i3c/master/svc-i3c-master.c:212: warning: Function parameter or member 'enabled_events' not described in 'svc_i3c_master'
   2 warnings as Errors


vim +212 drivers/i3c/master/svc-i3c-master.c

1c5ee2a77b1bac Clark Wang    2023-05-17  157  
dd3c52846d5954 Miquel Raynal 2021-01-21  158  /**
dd3c52846d5954 Miquel Raynal 2021-01-21  159   * struct svc_i3c_master - Silvaco I3C Master structure
dd3c52846d5954 Miquel Raynal 2021-01-21  160   * @base: I3C master controller
dd3c52846d5954 Miquel Raynal 2021-01-21  161   * @dev: Corresponding device
dd3c52846d5954 Miquel Raynal 2021-01-21  162   * @regs: Memory mapping
5496eac6ad7428 Miquel Raynal 2023-08-17  163   * @saved_regs: Volatile values for PM operations
dd3c52846d5954 Miquel Raynal 2021-01-21  164   * @free_slots: Bit array of available slots
dd3c52846d5954 Miquel Raynal 2021-01-21  165   * @addrs: Array containing the dynamic addresses of each attached device
dd3c52846d5954 Miquel Raynal 2021-01-21  166   * @descs: Array of descriptors, one per attached device
dd3c52846d5954 Miquel Raynal 2021-01-21  167   * @hj_work: Hot-join work
dd3c52846d5954 Miquel Raynal 2021-01-21  168   * @ibi_work: IBI work
dd3c52846d5954 Miquel Raynal 2021-01-21  169   * @irq: Main interrupt
dd3c52846d5954 Miquel Raynal 2021-01-21  170   * @pclk: System clock
dd3c52846d5954 Miquel Raynal 2021-01-21  171   * @fclk: Fast clock (bus)
dd3c52846d5954 Miquel Raynal 2021-01-21  172   * @sclk: Slow clock (other events)
dd3c52846d5954 Miquel Raynal 2021-01-21  173   * @xferqueue: Transfer queue structure
dd3c52846d5954 Miquel Raynal 2021-01-21  174   * @xferqueue.list: List member
dd3c52846d5954 Miquel Raynal 2021-01-21  175   * @xferqueue.cur: Current ongoing transfer
dd3c52846d5954 Miquel Raynal 2021-01-21  176   * @xferqueue.lock: Queue lock
dd3c52846d5954 Miquel Raynal 2021-01-21  177   * @ibi: IBI structure
dd3c52846d5954 Miquel Raynal 2021-01-21  178   * @ibi.num_slots: Number of slots available in @ibi.slots
dd3c52846d5954 Miquel Raynal 2021-01-21  179   * @ibi.slots: Available IBI slots
dd3c52846d5954 Miquel Raynal 2021-01-21  180   * @ibi.tbq_slot: To be queued IBI slot
dd3c52846d5954 Miquel Raynal 2021-01-21  181   * @ibi.lock: IBI lock

* @lock: <description>
* @enabled_events: <description>

dd3c52846d5954 Miquel Raynal 2021-01-21  182   */
dd3c52846d5954 Miquel Raynal 2021-01-21  183  struct svc_i3c_master {
dd3c52846d5954 Miquel Raynal 2021-01-21  184  	struct i3c_master_controller base;
dd3c52846d5954 Miquel Raynal 2021-01-21  185  	struct device *dev;
dd3c52846d5954 Miquel Raynal 2021-01-21  186  	void __iomem *regs;
1c5ee2a77b1bac Clark Wang    2023-05-17  187  	struct svc_i3c_regs_save saved_regs;
dd3c52846d5954 Miquel Raynal 2021-01-21  188  	u32 free_slots;
dd3c52846d5954 Miquel Raynal 2021-01-21  189  	u8 addrs[SVC_I3C_MAX_DEVS];
dd3c52846d5954 Miquel Raynal 2021-01-21  190  	struct i3c_dev_desc *descs[SVC_I3C_MAX_DEVS];
dd3c52846d5954 Miquel Raynal 2021-01-21  191  	struct work_struct hj_work;
dd3c52846d5954 Miquel Raynal 2021-01-21  192  	struct work_struct ibi_work;
dd3c52846d5954 Miquel Raynal 2021-01-21  193  	int irq;
dd3c52846d5954 Miquel Raynal 2021-01-21  194  	struct clk *pclk;
dd3c52846d5954 Miquel Raynal 2021-01-21  195  	struct clk *fclk;
dd3c52846d5954 Miquel Raynal 2021-01-21  196  	struct clk *sclk;
dd3c52846d5954 Miquel Raynal 2021-01-21  197  	struct {
dd3c52846d5954 Miquel Raynal 2021-01-21  198  		struct list_head list;
dd3c52846d5954 Miquel Raynal 2021-01-21  199  		struct svc_i3c_xfer *cur;
dd3c52846d5954 Miquel Raynal 2021-01-21  200  		/* Prevent races between transfers */
dd3c52846d5954 Miquel Raynal 2021-01-21  201  		spinlock_t lock;
dd3c52846d5954 Miquel Raynal 2021-01-21  202  	} xferqueue;
dd3c52846d5954 Miquel Raynal 2021-01-21  203  	struct {
dd3c52846d5954 Miquel Raynal 2021-01-21  204  		unsigned int num_slots;
dd3c52846d5954 Miquel Raynal 2021-01-21  205  		struct i3c_dev_desc **slots;
dd3c52846d5954 Miquel Raynal 2021-01-21  206  		struct i3c_ibi_slot *tbq_slot;
dd3c52846d5954 Miquel Raynal 2021-01-21  207  		/* Prevent races within IBI handlers */
dd3c52846d5954 Miquel Raynal 2021-01-21  208  		spinlock_t lock;
dd3c52846d5954 Miquel Raynal 2021-01-21  209  	} ibi;
85bebb554b09b1 Frank Li      2023-10-16  210  	struct mutex lock;
e00571e38f466c Frank Li      2023-10-18  211  	int enabled_events;
dd3c52846d5954 Miquel Raynal 2021-01-21 @212  };
dd3c52846d5954 Miquel Raynal 2021-01-21  213  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

