Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967FE7AE799
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjIZINK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjIZINH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:13:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8B4101;
        Tue, 26 Sep 2023 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695715980; x=1727251980;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=hebZiEO3cdXe/HghWeAwE7RJm4D5rz2RuJphGqhRr9o=;
  b=OSiBoBK6FvOoicRsRo/5BuLEIbcLW8qEb/bS8vTY2brHnAB/JCGWTDWt
   t8IL5nTEhS67VavvGpww+nha2Kd9HKVJ/G/P8mVnno/Vrf00qpRJnMGR8
   G1ko2C69oFaDjjhSlpEQpKAV50ElvtKmH3fkwg+0U8jy9rSMQ0HrKQZl/
   jk3nDVTKWnbBeLCwY/I4WQ+M25K8XLsRTiXQw9iKhzHUomMUy7+Thh27N
   Nc3gCnsKVbKV8j43/BOjQKKEKdqwBLiGmuNvNrFS6Kgc+3rPX/svxyvgX
   xEJkdGF/DqhyUNnIeH5xzFrSXSumGPjE9IaL4heoKukb6+Y48P12uRTat
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360892718"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360892718"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 01:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748735805"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="748735805"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 01:12:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 01:12:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 01:12:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 01:12:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 01:12:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRBN3F7A4nscZ5e9/GfSC3d2+4PwTCA0ENkaV+kqjAmcrSkuv+SoWaeXCWXHYfYfnH5eYgcmNxRL17jBfNdbfFzUZBhtPzmT/MQzLr3DIvRhi4QFUQFNAxnc66xmtybvk2F+qYOsq8Jl2BpkS4xj0xn4A2GkcTe8vG7pZOqeSsLaPjaGxV0g6WT6jTimbZ+3q+N3Xu8XEph0Iecq/L+Oqhku4WLj3Sh321XtLigVhJfm2XD/xxmzukc1TWo6CGXpjZJ09v05JqvgAvZW8tDbLxZMRQkQEnloxF2jkI4sZH/lYa6bCCzUw6m5Oo1YQPtfWn/IVmW2pj2JZymmI+16dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HDFKHlNHxxtTFIsSNUlL6cLySLrhaWm8FbcFk8nPKA=;
 b=fh6i3RhSVyQRnAQiQN5wv3wELyF5Wc/qhDogIN4XBARuF2tUNSI7raNkBunUWZfv3xVO6S16nYi0yxjqPLvUJcoL+/OMK+cUp0H6svWA4yHFal/imIPCgKVL2TU043r74r51eQIPA3HEOAzzZP20jCLec3HPSdIGHLGzHODKX58hLbWHhYm60xhDt9TQ2zzcayKf/X/Uf2WebYagf0CYn9UuHxVO0hfXPTe5TCeUgsdWWE86BEh37347OlgLo4HcUG1UqeFhpH/l/Lm+ouxqmZ7sOkBd2M7Uj0kOCzlvMZURC6Xj8gghugScW13MI5RQ6dPagjsuD8ibOZSfgw9/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BY1PR11MB8030.namprd11.prod.outlook.com (2603:10b6:a03:522::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Tue, 26 Sep
 2023 08:12:55 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5%7]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 08:12:55 +0000
Date:   Tue, 26 Sep 2023 16:07:49 +0800
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
Subject: Re: [PATCH v4 05/18] EDAC/synopsys: Add DDRC basic parameters
 infrastructure
Message-ID: <202309241117.1QIu7Ipb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230920192806.29960-6-fancer.lancer@gmail.com>
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|BY1PR11MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3a6a3f-99e6-463d-589e-08dbbe68626e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsQE7BHIin7bG8C951q2RkBM9Q1jyWKSZcH28JjJWlLk9VW7afqRAOE/BkiYwS/X9JX8/vpuagN+rbl8J0GT6O8cj7/RkesUbBq5tvkzQDuXgD7VuCqFOSaMDSu7dEm71PIjtePwe8b+N1KxLMSulbHulokvj/WwnjWa/noCwLbQ3dwbd1pYy7mXIDVq6R3b3i0SPZq2aOZtiDQbxMsZ4HZ7ZJ7FOKXENXszpE/Egv7BLodBl9/AYBJwq5G1cyTa8Uu6kWQIn1PbmMh+0UOY28rJ5tlUv+sBREZIC73YI4WkV9/UvFndaBODfHv9d1Jzq5Yr5tTaVQ7SBoQkvDefV5mTtWEsXZvg5ehrR4jqJ/Dg/sTPk/tAxvRnpQMuHUCB96bDlPmvkIJ9QvRzstBhpZj1dH7w44gtbAdqSk7Hwv1AeIt3kmpljQECC5CdJyGw0k+7F8hB5ckTAXO7oE8N9CRwBdNvkqoI4EZajRrlzDBke2+pnHuJvE8K4O+YeMlKjD6hjEZdAdCcYKFvDZQuK5Qo4B0jCYGlH002ywPJcYeZirop+Ux+Gdw8prpmkSrypM2gXzHeXA2g2S2a3pIl5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(83380400001)(2906002)(36756003)(86362001)(26005)(82960400001)(6512007)(7416002)(1076003)(41300700001)(2616005)(6666004)(38100700002)(6486002)(478600001)(6506007)(966005)(5660300002)(8676002)(4326008)(8936002)(316002)(66946007)(66476007)(66556008)(54906003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mlOQeb8WH+N7733Kqa8RailKLlAtbxmqof7RbHeiRG9I5w01JbximCEqI0po?=
 =?us-ascii?Q?lmaUi9UAabBjZe3p7ZRMcrxwHhTbK4q5x1eZGMKrrRdPujqpgR4bQW2F/LaK?=
 =?us-ascii?Q?yxWZbiaLfmkjj0aoolTrGo7yKAO+ji9H7/wdE4RJEBXpD3ZqQTPb+Siq1pGs?=
 =?us-ascii?Q?nwefgY/tkTLBDxYnRxO/qML7s+8q9HHCtYt7c7wrGewedek99Hv3NdMJr+o1?=
 =?us-ascii?Q?XX3dyummtp5NeJrYbExGpEx3LmeZZAxgBYUTGA5S/1MhE2kHMsieIMJ63Alx?=
 =?us-ascii?Q?eT+N0r8MSQF7zRMAE86l6PXyDr83xaaESLs0bgQa1ypD4wnYO4qmiW/YsnGT?=
 =?us-ascii?Q?j+rQaLAGJaWhNuZov6O2+vkdJ331AxAYkopn1aBf8IkUUs78+/5ADE8rF2fH?=
 =?us-ascii?Q?gi32yAsbdMu6XBdywcv4/DFnxzWTYz4Us89f+5xY/SmerTujsuV1urJemTSX?=
 =?us-ascii?Q?PQ5Ccrg6OiHtU/t2TASPLiURf5r2wf17h54AUN63F3BTwJUlQd5R1JsFdvVG?=
 =?us-ascii?Q?A3iP4VLJo5/0UIktvqE5ENkJUZCgLgi3K1mwLZPT5rZVmR9AyiRyuk7U1VVh?=
 =?us-ascii?Q?WNlWBpL+swqepv5RXnyli1W3yvQhW1Ch+CkefKC+owAV2ll8WfN1rlHvWRqm?=
 =?us-ascii?Q?e3vkH3D7i6zo8OgVwmhda3bS8ZZDd36Rqd5S/zlmhsGThDCyCMnV+OJAQowM?=
 =?us-ascii?Q?qFjGelZ7J/u/hXgoU+HXhLCKs646G9Gjlu61NuuDuONHx2x+Wlqav1mRyJKj?=
 =?us-ascii?Q?xJr7qpl02UwBqpVE43xvbTknlIGHqjBBcMXRyXGey787NTNWWfcAPqnXRCip?=
 =?us-ascii?Q?WxxOI2rpGNowoHfRQLqd0oyNZWRG1q0PILwBgNPAjGKYw+n3ARMDKvadgvNk?=
 =?us-ascii?Q?ASRwXiEBa5b1OhU2BnLx+kPXgbKoOjBw2dU9DseKSvCQYLJWfPIixL3ARMY5?=
 =?us-ascii?Q?A6V7M/S6XpdNBpHegYm9Vdgk/2Mv+dOKb98fy3RYl+hCp6tGgV99kTcOmOtx?=
 =?us-ascii?Q?24LW9oRoc6TTKsb6Bzxft1Eg6+wcO/KvzJe7kIGKfOaAQ5gs8GzDtPzH5AQX?=
 =?us-ascii?Q?AdEKpchxt/5shs3qShZdOE1AE0x3TgmJz5w3Y7PQrNqLs8MCRGpSMqzWQhBD?=
 =?us-ascii?Q?AY1HcQAiLBLawxy28x1+wUarKeZuFomGE9FMxZ5UgCgC1aF0Z/bJDwnchqn5?=
 =?us-ascii?Q?dqRUdakQzh+RNi3MsrFnz3RWxc/jUzavxwfI0qVlGL921HNmQyzsT89x5pA2?=
 =?us-ascii?Q?k9CjVpXszKiv8SrtlXJ4tLqF0nkRKKeA51cNi01ETVGP4WB/g9clXa6rMMy4?=
 =?us-ascii?Q?Ja0tAV5LzKOwj3nOV9zI5WG8cnF8fZ9vDtUHGgQiw0/G0NO7GEzGMK4DnQvq?=
 =?us-ascii?Q?OrIRZj9EnnJxBJN93aYw4qddbm8TVLthIstcHDmYCNTODs94njldinuFpNuZ?=
 =?us-ascii?Q?z6Aplg6wZkhp3Qwb9HduUSeQRxItcXF27mMGDL1FPz/juyBFd950o84r7+MX?=
 =?us-ascii?Q?TXMbaMRStVsTjbe0zJGjXCmMZFkg51aHzYKCRni6M/0vqe8MlSkhOmlcqdl/?=
 =?us-ascii?Q?kChoi3GO/ysG7t06zvQ/BgR5C15j701NI2fbOgkE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3a6a3f-99e6-463d-589e-08dbbe68626e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 08:12:55.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnjxPNxNSoSl4e3pT2nQAg3onip3lOaHkfNqYqq6/OpqHSPZ1PCgLvOtdiv4VIL3lwgQuW/+HBOTws9hbIeFjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8030
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20230920192806.29960-6-fancer.lancer%40gmail.com
patch subject: [PATCH v4 05/18] EDAC/synopsys: Add DDRC basic parameters infrastructure
config: arm64-randconfig-003-20230924 (https://download.01.org/0day-ci/archive/20230924/202309241117.1QIu7Ipb-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309241117.1QIu7Ipb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202309241117.1QIu7Ipb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/edac/synopsys_edac.c:224: warning: Enum value 'SNPS_DQ_32' not described in enum 'snps_dq_width'
>> drivers/edac/synopsys_edac.c:224: warning: Enum value 'SNPS_DQ_64' not described in enum 'snps_dq_width'


vim +224 drivers/edac/synopsys_edac.c

c85ef1323d2330 Serge Semin 2023-09-20  215  
9e617225f1d8ba Serge Semin 2023-09-20  216  /**
9e617225f1d8ba Serge Semin 2023-09-20  217   * enum snps_dq_width - SDRAM DQ bus width (ECC capable).
9e617225f1d8ba Serge Semin 2023-09-20  218   * SNPS_DQ_32:	32-bit memory data width.
9e617225f1d8ba Serge Semin 2023-09-20  219   * SNPS_DQ_64:	64-bit memory data width.

a @ char is required in front of each name

9e617225f1d8ba Serge Semin 2023-09-20  220   */
9e617225f1d8ba Serge Semin 2023-09-20  221  enum snps_dq_width {
9e617225f1d8ba Serge Semin 2023-09-20  222  	SNPS_DQ_32 = 2,
9e617225f1d8ba Serge Semin 2023-09-20  223  	SNPS_DQ_64 = 3,
9e617225f1d8ba Serge Semin 2023-09-20 @224  };
9e617225f1d8ba Serge Semin 2023-09-20  225  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

