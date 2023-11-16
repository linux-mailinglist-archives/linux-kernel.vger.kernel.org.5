Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E357ED8D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjKPBOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbjKPBOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:14:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD3197
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700097269; x=1731633269;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w0h1coB24f5X/RO2XFbOSjmbVTL+qRLmxvtOCitX1rw=;
  b=Anh/8zrSIy+I6Tm54+6fY4QXNsStYNH+9hgoRik3qhp+RR7NOnzwe4h5
   sdwli0kbDEPKWCmvQsjWe7m/ThV1E/hz2DgdRD4yaU8DfX80axn7hyjfq
   ryZciwq9hrOUBGW7I5AjR6T8zzDuw6nrqFdOXNS9/6Z05BSMNsde0gktO
   M9V8/5BbCItyktOuK/SHLhZtCByio8zSG4uZxKK+PhxDrd5Vtzp+y5TZh
   BJZrZ06M7qf9D2hUNDfquX6vfjAeAWLjgzHjaQSfDocXZpx6Waip7hhwS
   Y8mhMHAqhj6wPis3ZH7T6GPUGXLQellld6QO2ddn4Qc2Cs10FxP7ckhOx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="477208341"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="477208341"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 17:14:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="765151318"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="765151318"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 17:14:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 17:14:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 17:14:28 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 17:14:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cI9mKy8EVxcymfDhi8rZzmNiZR8HTm39XBFxH4vqhz0S9IwOqS33AxoYxZaPxC3hG/pGn/ARNB4OYsToKdoPtEDHskJxyiXH9+MP+aE5nZhlopYYw1+exr1llo4bcGIC9OZNkPo3CXAEdv1G0//LXCo/hIsBzE7V8TR/aZ7NwrpMZeau1Ga4Xpkpwm2PMCXCw8I7yJKhJtjjpwinVcBYySeYEh4nZqJCgn5osLtqinHZpWu0dYFFU/qChn3RsrsPz99Zv9sgSEXGZAs2TyA3I4DbM5VqI9y1Mf8oioTTptepTulfzCbdDPcR03BodQOmW2+cNde2hEowfcpk22YTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23rsoMV0/0jUTlQyG5w9Uk8IY5Rk15xeVAG6vxAstPc=;
 b=fgrj6Z9X1HD/VX1124ZIVNyuqbgDdSYzzZcVRE9vuq8TFcki9IrvBlCaoQ+l+j2DHrBLyaaYvl+z3fIcqgC5sSI6W5N0A3Bx6toHy7uWPwJkqccph7PJyX1a3u/NYHm62J8L19wCqWropRIdFvQe8npdY5ks7aoesyaCeoyL9KDgKbgC2qxAzQVLxahoOwX/tZH05RRVf8ZHMmBd7vDuENjDHhowS/iJ+TrfDYHa9O7PbEN0ucNRoot3KFZZfeFWAQ8Rhrpjg6BtaG0xTf54BlKXrA7kZvJ+JtvsDCCpCR0KFYwUoSqyHJsFPn1vzJbLml5XjBtjFmcubuiaKMEcHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by IA1PR11MB7776.namprd11.prod.outlook.com (2603:10b6:208:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 01:14:25 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 01:14:25 +0000
Date:   Thu, 16 Nov 2023 09:09:45 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Laurent Fert" <laurent.fert@intel.com>
Subject: drivers/hwtracing/intel_th/msu.c:60: warning: Function parameter or
 member 'msc' not described in 'msc_window'
Message-ID: <202311160709.39OzBNLo-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::23) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|IA1PR11MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 483a8e02-958e-4975-9e2e-08dbe6415f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YsmY682ovp0PzI8+7iNjBOAeMoZrQ76tCC4X+NtsbLarGFCvIQK4eGKKe4VigyxNcx4SGkRuKpDx6cONcZip11ypBn+JZb6DF/HWmbzeV2JE245gjZ4i7q797sLcpfzktHIYYBeDwu1EPQ1AC07Wqj2Jjo2vafYq2U3IYKVuRedfiT3GTjcc8vLhzBWFOfxiKYYDRMBsXx0Jg6y35yGdeXxFi2xmvaT9UUSDHbA/cCYGmNR9WC1N1IYwAMONk6ag1glTgaHoGJGMg+/+cqFZlCUyFRgo/DJmuT7HT0GcVrvSKStVG2bqFXAZ2A+FLmTw0cE8xPpN9ZDahL7L6Tic+QKukobsEtafEVXdZw8uHOO6D8HbloqT7etbfZt6mnYn3pf1+foDMGlRKvdpEN0X2ECMUCr+rL1xMieenapf2oCniCb7u9aiAI8S4dG3RKOukmwXtEc73H6YnYqWXKghPwE/ft9JWuJBcizvuDXI2ruaN8nr3IG1eNwdnme2ojRVxK418JJjOo3Ps2YjY1WURWV3Q7CUkRKGxI/VAiAE5+sXxtIzqTk+34MyH09Ra8JwiHpupYOSTZ1fa0lQ1rAwnk+TqPEiu80Wb04QohmbON4Eggo+fOU/XAlXXOK80+2nq6mCVfePBghMF3NERfjmSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(230173577357003)(230273577357003)(451199024)(64100799003)(1800799009)(186009)(4326008)(2616005)(86362001)(6506007)(5660300002)(8676002)(8936002)(38100700002)(6666004)(2906002)(478600001)(1076003)(82960400001)(6512007)(66556008)(66946007)(316002)(66476007)(6486002)(966005)(26005)(6916009)(41300700001)(36756003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J1b8WSx5G4Wbgg8rrjymiRXHZdWTYjrZr8Jzehq4EMCsd+F99tJF6h1JQMij?=
 =?us-ascii?Q?geyHWsPi6wlt0LEU7eHFq2Z1ayi85X1nUWtO87hNleObreqYHUD59ruZhoUt?=
 =?us-ascii?Q?gjbcPzoGQnxuEDhOj2i49uSlaEUJMf4i5IXZNpu2YEKHCwLYrSTkJTo+MQ1h?=
 =?us-ascii?Q?fz8ajRrF4OYxqlSqc4eMjMkGl9Z/8q+koHPDvB+3B2tiIsqIDepOBEIEqVmT?=
 =?us-ascii?Q?fEKV+/IGp0wfOoYyByyx8A1sAX3CbEO8/o0oNakAliO2cZa26fKGwvX3Fisu?=
 =?us-ascii?Q?VTIqmgn6GGXJqhO4RaqKbAmwuhXu1o1r0J3i4ZaucYKOWvVP7fep/+YBDfOX?=
 =?us-ascii?Q?uv1KtjQE6FdgqJvcDI889uDBcEcFxaoTLwwqTxOzk9Z2Tysm3f2pI1Y1mtcm?=
 =?us-ascii?Q?YEj0M1f9klB3z1F+0gNZGEuF6EmsIF26Ed2Wb2oBi6CoFL3Pa5iatv0W2nIe?=
 =?us-ascii?Q?5+SbBdQbh57Cyo8DsdGtUAokrYFdqhISStA6cXcPZy7ezJIO85hROjncQ+gg?=
 =?us-ascii?Q?k/h8iyW9QPx3D8TP/2HAFwVe7okyg/yDocqLoQSw97NZmGIO6te4Ve8OPiVz?=
 =?us-ascii?Q?ufGtoIjLlmUsBW1tjUN0MK6PGzrgHmwyHthiMby86bA9hOlG09c6zWdkyYor?=
 =?us-ascii?Q?yE3hVfxlPLAgfpr+lhwkNxt8EZLSrwE89Mp7chFKNA0TYPe8CD/UJJ5K9hz3?=
 =?us-ascii?Q?1yoMlmsEGDOHWtSE9G8zlrVcWsqeYvapiU7kZo3J86sBjiUCUuS2Xo0ygsbl?=
 =?us-ascii?Q?WZ6aWTmmRqkc4dH/ePgSjPbaByvvzwUJ9GQLgS+HSjSnCi7/z9hAAGHxT9g3?=
 =?us-ascii?Q?h0BU+jIiH0V3PMsmTNXtyP/f5JFC8Amxfc+V0nxxUQ1pM3iuRheCME2YAyOP?=
 =?us-ascii?Q?4L6tWCM4zlR0QZwu2ym5ZXDFuUJaadPlfHbyvZK2V6oekaXAY1U6Kc/zLXtY?=
 =?us-ascii?Q?+80F57fsn/rbtgZp68FAmVENkXd7sfdV6Zz7FYmRLlZyzP9Tf8R29sulPMrq?=
 =?us-ascii?Q?2gIPUoJszswzGq18xttetJQjMzP6/kO96gtaL7PsUw7ooizpFl0jTRaXCnU7?=
 =?us-ascii?Q?y305Vztwcz2iIbFM0JnCe5FXEpHIpspV6sQkCkC9c//6vc+TnbRcnwm/WQMV?=
 =?us-ascii?Q?tWc1ewaUmZddTkYevUsCb6rlM3w3CIu8goPfVEVCw7DFSjWEY+h/C3Tw7F9S?=
 =?us-ascii?Q?Y+9vdO1IrwBsbS5yDEucEnzIUBKbvHRXqHzRr3U3rgicGqkdLvn36Z6pZ2Zn?=
 =?us-ascii?Q?rk50GY29EVVVi1bQs7S6WF6KOsWbUDK2bK0uiyV948cKwk789f3i8VHIKWD1?=
 =?us-ascii?Q?fStRh8zPXNXWyfIefaomY9fNLHjWtt4lb12pfGnHOg2FMl28pb7gJ5U7YOu+?=
 =?us-ascii?Q?UwsHV975O6F7pa8DqzT5wnM1/2QRGiEW2nbIhQ+SodDMvDrhKoZ4ExdtI8j7?=
 =?us-ascii?Q?j/FyZoLjn8FJS2H4HNswwe0KNqckF+8Y/GHbXU4oLoOCpNXH3N3eA1n2axJh?=
 =?us-ascii?Q?BVwa08i7FLlK+EVrY5SWXbV9t6MSPY11a38tx8z2zn6z/ODtYDdjgOC1nYec?=
 =?us-ascii?Q?9U5fkgh5ddL3wfnVw4Nmcppqy/40gc+h2zfiHOXi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 483a8e02-958e-4975-9e2e-08dbe6415f0b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 01:14:24.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiPNQnwVjb8cmCcjq5I8Cjk6wB0dLOsBGysGtOtZVtr7ka7Qhr5XM3j9e9fHvxDXW26LPpOuZRsZ+Q9vP3mvqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7776
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: ba82664c134ef7ab97808f09a3c5e894b0a4900d intel_th: Add Memory Storage Unit driver
config: x86_64-randconfig-x011-20230813 (https://download.01.org/0day-ci/archive/20231116/202311160709.39OzBNLo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160709.39OzBNLo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311160709.39OzBNLo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/intel_th/msu.c:60: warning: Function parameter or member 'msc' not described in 'msc_window'
>> drivers/hwtracing/intel_th/msu.c:101: warning: bad line: 
   drivers/hwtracing/intel_th/msu.c:134: warning: Function parameter or member 'iter_mutex' not described in 'msc'
>> drivers/hwtracing/intel_th/msu.c:134: warning: Function parameter or member 'iter_list' not described in 'msc'
>> drivers/hwtracing/intel_th/msu.c:894: warning: Function parameter or member 'nr_pages' not described in 'msc_buffer_alloc'
>> drivers/hwtracing/intel_th/msu.c:894: warning: Function parameter or member 'nr_wins' not described in 'msc_buffer_alloc'
>> drivers/hwtracing/intel_th/msu.c:894: warning: Excess function parameter 'size' description in 'msc_buffer_alloc'


vim +60 drivers/hwtracing/intel_th/msu.c

ba82664c134ef7a Alexander Shishkin 2015-09-22   46  
ba82664c134ef7a Alexander Shishkin 2015-09-22   47  /**
ba82664c134ef7a Alexander Shishkin 2015-09-22   48   * struct msc_window - multiblock mode window descriptor
ba82664c134ef7a Alexander Shishkin 2015-09-22   49   * @entry:	window list linkage (msc::win_list)
ba82664c134ef7a Alexander Shishkin 2015-09-22   50   * @pgoff:	page offset into the buffer that this window starts at
ba82664c134ef7a Alexander Shishkin 2015-09-22   51   * @nr_blocks:	number of blocks (pages) in this window
ba82664c134ef7a Alexander Shishkin 2015-09-22   52   * @block:	array of block descriptors
ba82664c134ef7a Alexander Shishkin 2015-09-22   53   */
ba82664c134ef7a Alexander Shishkin 2015-09-22   54  struct msc_window {
ba82664c134ef7a Alexander Shishkin 2015-09-22   55  	struct list_head	entry;
ba82664c134ef7a Alexander Shishkin 2015-09-22   56  	unsigned long		pgoff;
ba82664c134ef7a Alexander Shishkin 2015-09-22   57  	unsigned int		nr_blocks;
ba82664c134ef7a Alexander Shishkin 2015-09-22   58  	struct msc		*msc;
ba82664c134ef7a Alexander Shishkin 2015-09-22   59  	struct msc_block	block[0];
ba82664c134ef7a Alexander Shishkin 2015-09-22  @60  };
ba82664c134ef7a Alexander Shishkin 2015-09-22   61  
ba82664c134ef7a Alexander Shishkin 2015-09-22   62  /**
ba82664c134ef7a Alexander Shishkin 2015-09-22   63   * struct msc_iter - iterator for msc buffer
ba82664c134ef7a Alexander Shishkin 2015-09-22   64   * @entry:		msc::iter_list linkage
ba82664c134ef7a Alexander Shishkin 2015-09-22   65   * @msc:		pointer to the MSC device
ba82664c134ef7a Alexander Shishkin 2015-09-22   66   * @start_win:		oldest window
ba82664c134ef7a Alexander Shishkin 2015-09-22   67   * @win:		current window
ba82664c134ef7a Alexander Shishkin 2015-09-22   68   * @offset:		current logical offset into the buffer
ba82664c134ef7a Alexander Shishkin 2015-09-22   69   * @start_block:	oldest block in the window
ba82664c134ef7a Alexander Shishkin 2015-09-22   70   * @block:		block number in the window
ba82664c134ef7a Alexander Shishkin 2015-09-22   71   * @block_off:		offset into current block
ba82664c134ef7a Alexander Shishkin 2015-09-22   72   * @wrap_count:		block wrapping handling
ba82664c134ef7a Alexander Shishkin 2015-09-22   73   * @eof:		end of buffer reached
ba82664c134ef7a Alexander Shishkin 2015-09-22   74   */
ba82664c134ef7a Alexander Shishkin 2015-09-22   75  struct msc_iter {
ba82664c134ef7a Alexander Shishkin 2015-09-22   76  	struct list_head	entry;
ba82664c134ef7a Alexander Shishkin 2015-09-22   77  	struct msc		*msc;
ba82664c134ef7a Alexander Shishkin 2015-09-22   78  	struct msc_window	*start_win;
ba82664c134ef7a Alexander Shishkin 2015-09-22   79  	struct msc_window	*win;
ba82664c134ef7a Alexander Shishkin 2015-09-22   80  	unsigned long		offset;
ba82664c134ef7a Alexander Shishkin 2015-09-22   81  	int			start_block;
ba82664c134ef7a Alexander Shishkin 2015-09-22   82  	int			block;
ba82664c134ef7a Alexander Shishkin 2015-09-22   83  	unsigned int		block_off;
ba82664c134ef7a Alexander Shishkin 2015-09-22   84  	unsigned int		wrap_count;
ba82664c134ef7a Alexander Shishkin 2015-09-22   85  	unsigned int		eof;
ba82664c134ef7a Alexander Shishkin 2015-09-22   86  };
ba82664c134ef7a Alexander Shishkin 2015-09-22   87  
ba82664c134ef7a Alexander Shishkin 2015-09-22   88  /**
ba82664c134ef7a Alexander Shishkin 2015-09-22   89   * struct msc - MSC device representation
ba82664c134ef7a Alexander Shishkin 2015-09-22   90   * @reg_base:		register window base address
ba82664c134ef7a Alexander Shishkin 2015-09-22   91   * @thdev:		intel_th_device pointer
ba82664c134ef7a Alexander Shishkin 2015-09-22   92   * @win_list:		list of windows in multiblock mode
ba82664c134ef7a Alexander Shishkin 2015-09-22   93   * @nr_pages:		total number of pages allocated for this buffer
ba82664c134ef7a Alexander Shishkin 2015-09-22   94   * @single_sz:		amount of data in single mode
ba82664c134ef7a Alexander Shishkin 2015-09-22   95   * @single_wrap:	single mode wrap occurred
ba82664c134ef7a Alexander Shishkin 2015-09-22   96   * @base:		buffer's base pointer
ba82664c134ef7a Alexander Shishkin 2015-09-22   97   * @base_addr:		buffer's base address
ba82664c134ef7a Alexander Shishkin 2015-09-22   98   * @user_count:		number of users of the buffer
ba82664c134ef7a Alexander Shishkin 2015-09-22   99   * @mmap_count:		number of mappings
ba82664c134ef7a Alexander Shishkin 2015-09-22  100   * @buf_mutex:		mutex to serialize access to buffer-related bits
ba82664c134ef7a Alexander Shishkin 2015-09-22 @101  
ba82664c134ef7a Alexander Shishkin 2015-09-22  102   * @enabled:		MSC is enabled
ba82664c134ef7a Alexander Shishkin 2015-09-22  103   * @wrap:		wrapping is enabled
ba82664c134ef7a Alexander Shishkin 2015-09-22  104   * @mode:		MSC operating mode
ba82664c134ef7a Alexander Shishkin 2015-09-22  105   * @burst_len:		write burst length
ba82664c134ef7a Alexander Shishkin 2015-09-22  106   * @index:		number of this MSC in the MSU
ba82664c134ef7a Alexander Shishkin 2015-09-22  107   */
ba82664c134ef7a Alexander Shishkin 2015-09-22  108  struct msc {
ba82664c134ef7a Alexander Shishkin 2015-09-22  109  	void __iomem		*reg_base;
ba82664c134ef7a Alexander Shishkin 2015-09-22  110  	struct intel_th_device	*thdev;
ba82664c134ef7a Alexander Shishkin 2015-09-22  111  
ba82664c134ef7a Alexander Shishkin 2015-09-22  112  	struct list_head	win_list;
ba82664c134ef7a Alexander Shishkin 2015-09-22  113  	unsigned long		nr_pages;
ba82664c134ef7a Alexander Shishkin 2015-09-22  114  	unsigned long		single_sz;
ba82664c134ef7a Alexander Shishkin 2015-09-22  115  	unsigned int		single_wrap : 1;
ba82664c134ef7a Alexander Shishkin 2015-09-22  116  	void			*base;
ba82664c134ef7a Alexander Shishkin 2015-09-22  117  	dma_addr_t		base_addr;
ba82664c134ef7a Alexander Shishkin 2015-09-22  118  
ba82664c134ef7a Alexander Shishkin 2015-09-22  119  	/* <0: no buffer, 0: no users, >0: active users */
ba82664c134ef7a Alexander Shishkin 2015-09-22  120  	atomic_t		user_count;
ba82664c134ef7a Alexander Shishkin 2015-09-22  121  
ba82664c134ef7a Alexander Shishkin 2015-09-22  122  	atomic_t		mmap_count;
ba82664c134ef7a Alexander Shishkin 2015-09-22  123  	struct mutex		buf_mutex;
ba82664c134ef7a Alexander Shishkin 2015-09-22  124  
ba82664c134ef7a Alexander Shishkin 2015-09-22  125  	struct mutex		iter_mutex;
ba82664c134ef7a Alexander Shishkin 2015-09-22  126  	struct list_head	iter_list;
ba82664c134ef7a Alexander Shishkin 2015-09-22  127  
ba82664c134ef7a Alexander Shishkin 2015-09-22  128  	/* config */
ba82664c134ef7a Alexander Shishkin 2015-09-22  129  	unsigned int		enabled : 1,
ba82664c134ef7a Alexander Shishkin 2015-09-22  130  				wrap	: 1;
ba82664c134ef7a Alexander Shishkin 2015-09-22  131  	unsigned int		mode;
ba82664c134ef7a Alexander Shishkin 2015-09-22  132  	unsigned int		burst_len;
ba82664c134ef7a Alexander Shishkin 2015-09-22  133  	unsigned int		index;
ba82664c134ef7a Alexander Shishkin 2015-09-22 @134  };
ba82664c134ef7a Alexander Shishkin 2015-09-22  135  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

