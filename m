Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96F677F97B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352153AbjHQOoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352220AbjHQOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:43:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC5730DF;
        Thu, 17 Aug 2023 07:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692283407; x=1723819407;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=iUWfFzjNjfhffYcmiFibjpAimsh/cCZNOOLKxvcZqOI=;
  b=LucS6PXf0nJSu7kEei7USEOqx3q+L8zYJ6mI8J5UjuWiI9zinFMgrYHi
   V/HoJpoLNGGdxMsD7piJrKcbTxia2henIguDKg2OVJcJZGkTGWQOsKix5
   hMtWqCOXjpGw6grwHmv3I/X9bF4DlObwpEINsro4KC579c6YzU1hvHwt2
   jzNv9dfYbz7ryFr1OM4ub/Yw9MHjKq40O/LJCdwb7h2BAqDsMP+NluOyA
   gY/Az3wpkkYqgLvoT/cTUQhrS5XOsYWSlMYqR5w0rLKyExlgyz2EBlRHP
   v15AwEYNluC55SMdbbsaoElh1gOyBXSqtJYOeGXqFUQqwE3p5VfK0JuRh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371731946"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="371731946"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 07:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824656170"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="824656170"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 07:41:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 07:41:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 07:41:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 07:41:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 07:41:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkWZmnzo8/dhKhBQkPtTKmCsxuaTu/SifVPIsamD9qE76qdtjcy7lZC3tBDwmSF0vZ/iGSH4MbrPMGqcA8CscN3HFwajGVSMOr4c4gXHEeYL+GrZVQKiSQK2MPsZ+TztnVpshg5oUAxJPUt+OcEHL4O5c9bQs2hOiul4a2GRTJgd7+hqARNzjG85nckbB3Kjua1lZ+vt25I6LAffnJtMMdetFVuGiiuUOOYwNJ+iErLvvHvvsdlLet4dUVNnQ0M+p/yRdN2QFBe8fTtDkpfpmiAbz+A3giXf7U6DrhoN10EbBvfaltDRSv96a3SYLVxlz6n2HjOyw4nh1xOJFITyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGLqK/kII61ek88t20a2JRykIcCXqzn7Sg6PmuJ1YJo=;
 b=hY197xE3LJnbz9TOlolyewu+5yPz5QFTMbLuVv59nNDlTKm9AvvxVYKBwnKyzk/M8c04ZD5y4n/NIsGiZLTh/zt8u9rNjOa1MGzR1wrxFgkTY5sV9W6jUQ6FkGSZ8if7P5Li9K4P7Ebhq7YLq2jAxl1iO4atQqAFV7dJq60+bjCygjQy4vr3szF+WOKLQpPKZmMtEL+1o8TujLN/LjWbIfdo0vDDZWHPs5my5w1xwERKI3lMEHm/3UaaPvs/SHGr7YTY+mrZMRE8KYwPxUB9kmwMb2QRZRCMveX8tv/G9ElP3uXhNthN7R8FP6iUynO9NlmLEBPvDxRlVh0ZdQuYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB8364.namprd11.prod.outlook.com (2603:10b6:610:174::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 14:41:16 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 14:41:16 +0000
Date:   Thu, 17 Aug 2023 22:41:03 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     <chengming.zhou@linux.dev>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <bvanassche@acm.org>, <cel@kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhouchengming@bytedance.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v2] blk-mq: release scheduler resource when request
 complete
Message-ID: <202308172100.8ce4b853-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230813152325.3017343-1-chengming.zhou@linux.dev>
X-ClientProxiedBy: KU1PR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:802:18::13) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d7f6d1-d031-4911-5c00-08db9f3002f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBR9q+gHUe27+Gad18fNnboyvfYP4iG4gw9eJfzrSSaqnZGZSSikmQMIsIpM2NCkDYFKgZ8MtuEoNPXNekJgUa/AIvwyYI/kS4+hdSiSE+lZVx/GyHu5Cf9xwlukJ3pDVTLPLlDXmGfzBkta9BUklyT8bsY8B6kSKzVkx/aKsfDdRa/XwQ4sMA9+f3n0J+e5Nsgqw5O6BBijFhXYs3N1xephaboWcXmn0Gv+WM5Je5+vD2RvK0yLfmgJxDng3WhL83QDK9KHkZRvhwZo+NzRGq4vW3l8UxiNDk+Ji3T16N0yxb2tjly7X937X/Q/NCXp2tMriVxbu0HiehiV1exEKEu2KHlOomnie0B/RbNVpcs17sHEQSmt9bCyOet5iI3lxLNvoqOR8C9ptki2p0mtc2zSarr8xIvVFvHZ5YsM2Pm6XgEJ+dsJ7i0EY57zOQCt/D81hcXOWRQluWVRCOHyup+VwkWovzaw3+jr6IyjyroqpvEKDihNuiw7kh6/fOi3uanweBeSF7az1jVIbMJdpFrsEqaRtopKPQH3xXIuy1j9XGFS9e0Nv3QdldQJLRbWCzB7dflxLUgF07233MriIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(45080400002)(86362001)(7416002)(478600001)(6506007)(36756003)(107886003)(6666004)(2616005)(1076003)(6486002)(6512007)(966005)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(8936002)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oPGc6jG6CTcku5eQdawG5+G3hKmCcnEGqp3/VGDSfq82jdX0QI/w2POlCMt+?=
 =?us-ascii?Q?1xYLyBVLrQZLWVjJSMGR1DBLSmPMQ6lhBvWnKVn9NVQGOHOnY0hBp3OV2BIy?=
 =?us-ascii?Q?IGUl67w74M3ZHANK2ZT2cmQEfyyFTp6hbwg4TVnNsDWuU7AA2DHLc80Xqvkj?=
 =?us-ascii?Q?SlEbHEYAO3IdbLMM8Cpahl2FuWfRfEKoqT3L51YX2I/QKwWi3qA1JdECCObD?=
 =?us-ascii?Q?t9NfyOmTGL/htgnzbmLYQrP+haELxfc4R2UGXJuh32RizLppwR8D3hOl7CVN?=
 =?us-ascii?Q?TDBi6H88/gm336GmlNBpeAFutgTXHk18KLIgfogwZoAFkJmjMW/DBnWsu8Nb?=
 =?us-ascii?Q?uhqwi78NqHNQ/EZry3rTsuCu4llQ8PZ6JEud9E0S/XRi+66qQfpgWzIvV0XH?=
 =?us-ascii?Q?Uh9B1xng0lGa+2wZB5EfW/sNSdqylm+2gZTtEejGmRCCStLruRxImfRMmSoF?=
 =?us-ascii?Q?TXDql7FgqpcEhQfvcVeF+6uxJMNDc3HMRzASszHFgxn6a/ySWXxpqCN4YLiP?=
 =?us-ascii?Q?dXbiXrCeuKMSzAv4RtQeB+He9+7FEZilC2a/pduu/jy+oFSCO6soywg1WePl?=
 =?us-ascii?Q?ucI0HB4xdFFsQnMwzdsd9R+j1nkqc0nChf6mj6McKJuJj7WyorhDPx6Opj6L?=
 =?us-ascii?Q?8+Yt7ynBnjPMhkylS4cbUgoXe0GDlXqEfwY6/jA0zFmpAAQeTRe/Knjtyz3z?=
 =?us-ascii?Q?tfCkcLnUluFGmAk4uq2CM6rruj4hp6KF7g1S4YFrcZlzY/ANIrXN506Qs1jC?=
 =?us-ascii?Q?EUKG7woF4Euw1A5OfWtp7wh3XdUZb5YbZAjOiNp01ViTaCdy9+GMHICodgQj?=
 =?us-ascii?Q?MqcC7hssp7fJLZQdaUTjUyRRQvgmgSDCF9EYkBM1cku01uiTEdFDq2wvb5ra?=
 =?us-ascii?Q?Cvk2KumYd32xqV2UnxwFVTRUov2ulQxRByBlR8fT5b2H7R3SwAs0NqmDMbSN?=
 =?us-ascii?Q?/sALzT22LA46It5UcMn1BB1RikEi+DrTfDCsf7OHoHe83buJT/Z0btWfI0zz?=
 =?us-ascii?Q?ZuPXFshzuKYjq1RnPyw+1KYb58uE9pdxTNmAr55h0xuFZtNXYfsy+bZ63Di3?=
 =?us-ascii?Q?7Em5GicDsNFcBtUkoQZExFTOSfUVaBA6IviT6rVpTfclwig50COpr6h7vNQB?=
 =?us-ascii?Q?FQikHfoOmKU8jmfzaiUtv41CcUfclaeaGlNKRagB8mVWfJf5x/F4NELUiFEv?=
 =?us-ascii?Q?/TOcbX9VxNHJ491s54tNcCsI+U6Lgd2+yWEy3IKinjcnQO6ev1zpevfUK690?=
 =?us-ascii?Q?5A/m+ixwsHf6MClUI5EwXd1XuT7UgQYWGCqS07uylfPVGLeMDqZirNNfkRz8?=
 =?us-ascii?Q?XPMp9/KOmDwXl0t4ANw23b8NMxdDo735erC9w7UQXOnlUWprXBvmmUmBeS4s?=
 =?us-ascii?Q?YW+EfJlMP4rAbx88rfb+ws4tCLifuJVGFpOPQQyFMXwiYnXCnIU2xKVl38p5?=
 =?us-ascii?Q?KaE3KL6z9H9bw1/3DKk1OrzyJEuBvOqkEeGm57GPfsz8G1h1tZJdaC6NyVB8?=
 =?us-ascii?Q?sv3wPE7hr4yYb4Jp2juWL8LX/RJ86lO+sIOA1itkpMf8tIhppLnYNcBuEImv?=
 =?us-ascii?Q?2sbZ7QwHISbJy+KNgBHcnshf08v5mJWa6wWdUNMFhTDB2hufUb28wn6XJWHw?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d7f6d1-d031-4911-5c00-08db9f3002f6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:41:16.3875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+iG+XTY7J6HNoY2Yc0EPBQaEQ6yEehXqIaAvmHUfaUxDXpq3JcyuxvauxfNDxQx8MVLpiXMUsJfW7ZBCiUDqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8364
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_block/mq-deadline.c:#dd_exit_sched" on:

commit: 567b5a4f2f8b9e9fe97d5f8dca266d95c734ae91 ("[PATCH v2] blk-mq: release scheduler resource when request complete")
url: https://github.com/intel-lab-lkp/linux/commits/chengming-zhou-linux-dev/blk-mq-release-scheduler-resource-when-request-complete/20230813-232513
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20230813152325.3017343-1-chengming.zhou@linux.dev/
patch subject: [PATCH v2] blk-mq: release scheduler resource when request complete

this also caused xfstests.generic.704.fail

in testcase: xfstests
version: xfstests-x86_64-bb8af9c-1_20230807
with following parameters:

	disk: 4HDD
	fs: ext4
	test: generic-704



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308172100.8ce4b853-oliver.sang@intel.com


[  222.617396][ T2216] ------------[ cut here ]------------
[  222.622837][ T2216] statistics for priority 1: i 276 m 0 d 276 c 278
[ 222.629307][ T2216] WARNING: CPU: 0 PID: 2216 at block/mq-deadline.c:680 dd_exit_sched (block/mq-deadline.c:680 (discriminator 3)) 
[  222.638218][ T2216] Modules linked in: scsi_debug(-) dm_mod btrfs blake2b_generic xor intel_rapl_msr raid6_pq intel_rapl_common zstd_compress libcrc32c x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sd_mod t10_pi kvm crc64_rocksoft_generic crc64_rocksoft crc64 irqbypass sg crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 ipmi_devintf ipmi_msghandler mei_wdt i915 rapl drm_buddy intel_cstate intel_gtt wmi_bmof drm_display_helper intel_uncore drm_kms_helper ahci libahci mei_me libata intel_pch_thermal ttm mei video wmi intel_pmc_core acpi_pad drm fuse ip_tables
[  222.690679][ T2216] CPU: 0 PID: 2216 Comm: modprobe Tainted: G          I        6.5.0-rc5-00190-g567b5a4f2f8b #1
[  222.700878][ T2216] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[ 222.708919][ T2216] RIP: 0010:dd_exit_sched (block/mq-deadline.c:680 (discriminator 3)) 
[ 222.714130][ T2216] Code: 89 da 8b 4b 04 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e c4 00 00 00 8b 13 44 89 e6 48 c7 c7 20 d3 e2 83 e8 e2 d1 08 ff <0f> 0b e9 f4 fe ff ff 0f 0b e9 78 fe ff ff 48 89 ee 48 c7 c7 20 cb
All code
========
   0:	89 da                	mov    %ebx,%edx
   2:	8b 4b 04             	mov    0x4(%rbx),%ecx
   5:	48 c1 ea 03          	shr    $0x3,%rdx
   9:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
   d:	84 c0                	test   %al,%al
   f:	74 08                	je     0x19
  11:	3c 03                	cmp    $0x3,%al
  13:	0f 8e c4 00 00 00    	jle    0xdd
  19:	8b 13                	mov    (%rbx),%edx
  1b:	44 89 e6             	mov    %r12d,%esi
  1e:	48 c7 c7 20 d3 e2 83 	mov    $0xffffffff83e2d320,%rdi
  25:	e8 e2 d1 08 ff       	callq  0xffffffffff08d20c
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 f4 fe ff ff       	jmpq   0xffffffffffffff25
  31:	0f 0b                	ud2    
  33:	e9 78 fe ff ff       	jmpq   0xfffffffffffffeb0
  38:	48 89 ee             	mov    %rbp,%rsi
  3b:	48                   	rex.W
  3c:	c7                   	.byte 0xc7
  3d:	c7                   	(bad)  
  3e:	20 cb                	and    %cl,%bl

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 f4 fe ff ff       	jmpq   0xfffffffffffffefb
   7:	0f 0b                	ud2    
   9:	e9 78 fe ff ff       	jmpq   0xfffffffffffffe86
   e:	48 89 ee             	mov    %rbp,%rsi
  11:	48                   	rex.W
  12:	c7                   	.byte 0xc7
  13:	c7                   	(bad)  
  14:	20 cb                	and    %cl,%bl
[  222.733468][ T2216] RSP: 0018:ffffc9000092f858 EFLAGS: 00010282
[  222.739367][ T2216] RAX: 0000000000000000 RBX: ffff88819e33e0b0 RCX: ffffffff821fb87e
[  222.747166][ T2216] RDX: 1ffff110fe1c57b8 RSI: 0000000000000008 RDI: ffffc9000092f610
[  222.754975][ T2216] RBP: 0000000000000116 R08: 0000000000000001 R09: fffff52000125ec2
[  222.762782][ T2216] R10: ffffc9000092f617 R11: 0000000000000001 R12: 0000000000000001
[  222.770591][ T2216] R13: dffffc0000000000 R14: ffff88819e33e000 R15: ffff88819e33e0bc
[  222.778386][ T2216] FS:  00007fd9aea5e540(0000) GS:ffff8887f0e00000(0000) knlGS:0000000000000000
[  222.787144][ T2216] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  222.793561][ T2216] CR2: 00007fbe00432bb0 CR3: 0000000126856005 CR4: 00000000003706f0
[  222.801359][ T2216] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  222.809156][ T2216] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  222.816970][ T2216] Call Trace:
[  222.820093][ T2216]  <TASK>
[ 222.822872][ T2216] ? __warn (kernel/panic.c:673) 
[ 222.826794][ T2216] ? dd_exit_sched (block/mq-deadline.c:680 (discriminator 3)) 
[ 222.831403][ T2216] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 222.835752][ T2216] ? handle_bug (arch/x86/kernel/traps.c:324) 
[ 222.839912][ T2216] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator 1)) 
[ 222.844433][ T2216] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 222.849286][ T2216] ? llist_add_batch (lib/llist.c:33 (discriminator 14)) 
[ 222.853980][ T2216] ? dd_exit_sched (block/mq-deadline.c:680 (discriminator 3)) 
[ 222.858586][ T2216] ? dd_exit_sched (block/mq-deadline.c:680 (discriminator 3)) 
[ 222.863193][ T2216] blk_mq_exit_sched (block/blk-mq-sched.c:550) 
[ 222.867973][ T2216] ? blk_mq_sched_free_rqs (block/blk-mq-sched.c:527) 
[ 222.873257][ T2216] ? __mutex_lock_slowpath (kernel/locking/mutex.c:282) 
[ 222.878384][ T2216] ? ioc_clear_queue (include/linux/list.h:292 block/blk-ioc.c:174) 
[ 222.883076][ T2216] ? blk_mq_poll (block/blk-mq.c:4832) 
[ 222.887324][ T2216] elevator_exit (block/elevator.c:168) 
[ 222.891572][ T2216] del_gendisk (block/genhd.c:701) 
[ 222.895834][ T2216] ? diskstats_show (block/genhd.c:631) 
[ 222.900526][ T2216] ? __pm_runtime_resume (drivers/base/power/runtime.c:1174) 
[ 222.905568][ T2216] sd_remove (drivers/scsi/sd.c:3736) sd_mod
[ 222.910436][ T2216] device_release_driver_internal (drivers/base/dd.c:1272 drivers/base/dd.c:1293) 
[ 222.916335][ T2216] bus_remove_device (include/linux/kobject.h:191 drivers/base/base.h:73 drivers/base/bus.c:581) 
[ 222.921225][ T2216] device_del (drivers/base/core.c:3815) 
[ 222.925388][ T2216] ? attribute_container_device_trigger (drivers/base/attribute_container.c:357) 
[ 222.931807][ T2216] ? __device_link_del (drivers/base/core.c:3769) 
[ 222.936760][ T2216] ? attribute_container_device_trigger_safe (drivers/base/attribute_container.c:357) 
[ 222.943612][ T2216] __scsi_remove_device (drivers/scsi/scsi_sysfs.c:1489) 
[ 222.948651][ T2216] scsi_forget_host (drivers/scsi/scsi_scan.c:1988) 
[ 222.953243][ T2216] scsi_remove_host (drivers/scsi/hosts.c:182) 
[ 222.957838][ T2216] sdebug_driver_remove (drivers/scsi/scsi_debug.c:7841) scsi_debug
[ 222.963933][ T2216] ? kernfs_remove_by_name_ns (fs/kernfs/dir.c:1679) 
[ 222.969492][ T2216] device_release_driver_internal (drivers/base/dd.c:1272 drivers/base/dd.c:1293) 
[ 222.975392][ T2216] bus_remove_device (include/linux/kobject.h:191 drivers/base/base.h:73 drivers/base/bus.c:581) 
[ 222.980173][ T2216] device_del (drivers/base/core.c:3815) 
[ 222.984349][ T2216] ? __device_link_del (drivers/base/core.c:3769) 
[ 222.989299][ T2216] ? mutex_unlock (arch/x86/include/asm/atomic64_64.h:109 include/linux/atomic/atomic-arch-fallback.h:4303 include/linux/atomic/atomic-long.h:1499 include/linux/atomic/atomic-instrumented.h:4446 kernel/locking/mutex.c:181 kernel/locking/mutex.c:540) 
[ 222.993645][ T2216] ? __mutex_unlock_slowpath+0x2b0/0x2b0 
[ 223.000160][ T2216] device_unregister (drivers/base/core.c:3732 drivers/base/core.c:3845) 
[ 223.004772][ T2216] sdebug_do_remove_host (drivers/scsi/scsi_debug.c:7299) scsi_debug
[ 223.011039][ T2216] scsi_debug_exit (drivers/scsi/scsi_debug.c:7670) scsi_debug
[ 223.016625][ T2216] __do_sys_delete_module+0x316/0x540 
[ 223.022880][ T2216] ? module_flags (kernel/module/main.c:698) 
[ 223.027401][ T2216] ? task_work_cancel (kernel/task_work.c:147) 
[ 223.032081][ T2216] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2155 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 223.036590][ T2216] ? exit_to_user_mode_loop (include/linux/sched.h:2337 include/linux/resume_user_mode.h:61 kernel/entry/common.c:171) 
[ 223.041890][ T2216] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 223.046154][ T2216] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
[  223.051867][ T2216] RIP: 0033:0x7fd9aeb83417
[ 223.056129][ T2216] Code: 73 01 c3 48 8b 0d 79 1a 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 49 1a 0d 00 f7 d8 64 89 01 48
All code
========
   0:	73 01                	jae    0x3
   2:	c3                   	retq   
   3:	48 8b 0d 79 1a 0d 00 	mov    0xd1a79(%rip),%rcx        # 0xd1a83
   a:	f7 d8                	neg    %eax
   c:	64 89 01             	mov    %eax,%fs:(%rcx)
   f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  13:	c3                   	retq   
  14:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  1b:	00 00 00 
  1e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  23:	b8 b0 00 00 00       	mov    $0xb0,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 49 1a 0d 00 	mov    0xd1a49(%rip),%rcx        # 0xd1a83
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 49 1a 0d 00 	mov    0xd1a49(%rip),%rcx        # 0xd1a59
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230817/202308172100.8ce4b853-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

