Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51179797B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbjIGSA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjIGSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:00:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609B9CE7;
        Thu,  7 Sep 2023 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694109636; x=1725645636;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ZBvrjKkFu99H+xzyZvYNohpQnWfUT4DGFLFK8WAZ2pA=;
  b=QWWl8a88LE6eqqtxlPa1XaLVBNG6qUOBE87FTCLbP9zFa22nojByefTM
   j+9SBZZFJZ7wCLE1yqH6t5tHjL2xpfO+hRmwke04y/ssjQUmmfG3aWSIL
   9fAxHzmwmf2PWDwvAuUo4ot6mhF8MwaO/ljeZ0W5mHS6aASMqXYo5KI+g
   9OnSLLFBKhrOn1hb4OKJr3WQm1aO72G6L9rBmVAUe3G+mWgTGSfReGSTn
   +vLpWUPGJksODYSgxlY2ZJc8mRuilULtq5LQ2fE+0GDhOY8XkQYl299J5
   kfufTDqVDMXvYNZelcHmPoinVz+oA9ZNWFyblKHi5YBLJROqOsSWwNd5+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="443669676"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="443669676"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 00:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="988656437"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="988656437"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 00:43:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 00:43:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 00:43:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 00:43:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnw97aLqMjuuCCzrj17k9ZC1lwcIKGyKO4IozBFpoPHE801v8OpE66z7WNlWFlONTK/LN7eq/EHjn+QiElWpHtAoRzygTsaK+UoeyJZ4XL9N8XTDDT2R05thTfgtTjjip9HTqUTFcwy4OnTt/Ot3Y+pmJl3anKynMqRF2I1lNjKKfU4Xd2ogbsKCbDWYa0Afu5TupMpMdTHDGi1x147NNusyjwZBb+HXJR/sjPgkYwHh/KjpXrB/b2bkgScJ3qr3MVmvbkkuxbWyeO09+/gh0xFTz94shm2biCBhBmSrOXIRrbcQlGkaO5Y+iVmLcB+rltQjNyRI0XiyB6cwGYuiEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJs/8gcqTHZNs9zB896PtPlkvLZiW/+FtUpSRJWBTXs=;
 b=LsBFFURelPmwz09G4kazf3Mo3z1pi5FvIcTGLqDpX+RHaqqRueSpMYfje99FZQt6dSGSfOwkUt9Zan0fGzKoBzX4HYwprP2DtjNGBwL1jIcyzX9bVXKws9/wt6jCfzq/Z5a3XUUo3fK9BroyL2wwmkceTqLTdfeRlz8t4XNmcgHcDAbdxpPRIBEFU7Sapi/nNm9JRVWT071F9B8/LimIb4WZAQ7Tg6yJTyOEb4EKLOL57xcaks8VCPJU9KsklPPsntOImHxPg6dz9ZRXHE8b+ePZRWiVTCE5DyzseWA1c9Si5vdtT92Ir4v9RK1IqHdNQYF7n0nAjAckR1vuVtMeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 07:43:31 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 07:43:31 +0000
Date:   Thu, 7 Sep 2023 15:43:19 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     <linan666@huaweicloud.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        luojian <luojian5@huawei.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        <linux-ide@vger.kernel.org>, <dlemoal@kernel.org>,
        <htejun@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linan122@huawei.com>, <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <houtao1@huawei.com>, <yangerkun@huawei.com>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v4] ata: libata-eh: Honor all EH scheduling requests
Message-ID: <202309071557.3a90e7a8-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230906084212.1016634-1-linan666@huaweicloud.com>
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO1PR11MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ab98f0-b6ed-4f33-fa36-08dbaf762191
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InQb0bQS62FrBIJFMynT2F4wrVf10E3sggvnCvr1ZE+4fEd3kSn5kvE1jcTxg6t9To+Zk+VmNPRNaK4X7oQvkkI9yfQW9lzRxVDS3BQB3NLv/lsE77id1S7VBZ74HJJmpdLxuaft24furXlBuvJaRQNi2Bz+hcg9VulkIfCUGMdxU/MVXt8Mn/BkDVlzKzIG51NbVxQaqivYWI/dpXaZ/U4pcrDrjoM2YieMWFOvbSW+8K61JMuWF2UCkwAXmQlcldKCqwEyKJim/VpD5vRACIe+rf7Q+vAXFp1fjL/e7rWnaV6T7Rc5MVG+U8wnlQPv6RRhfzQZkDugkZzvSuqi5gIFSozB1QyMIw3ua9ZAJYmFA5EQqPrcf+8hlQw/ng9LIu62THmuVpgRtWUmmLWMd0qxV4OpeXzFESgJYHageJJ9bpFtR4OWnEkWgXiuUkZzCxLJ6wYyhD6DpAOkH5a9yJRRYVFCo2SSn7TG517bOCJSajC6P26mfBGs9B7o2apx0YgLVtZbd+S1yNdQHjs8D/U6bTr1R29awMStQV0RreV9Yo0NSLib4dpEPWZlA9EXo3vwaHC+9/SIQZsKKYHpvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(186009)(1800799009)(451199024)(2906002)(966005)(86362001)(26005)(1076003)(2616005)(107886003)(6666004)(6486002)(36756003)(45080400002)(6506007)(6512007)(38100700002)(83380400001)(82960400001)(478600001)(7416002)(41300700001)(8676002)(8936002)(4326008)(5660300002)(6916009)(316002)(66946007)(66476007)(54906003)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6L7xAOVXGhHpHtES3NsOl2QlMuhiF74BWqQ+iasfZq21fE4e9GSOMPRHqAJM?=
 =?us-ascii?Q?sW8fSWEKgDxuBnMaIB+bZEKOiBPmy7K4x0qU3X3fup4pDmdT0apPYSgGvUoJ?=
 =?us-ascii?Q?buM0U5cXtdM1RUP18a3X9e/dQLc+i2hEijMiCvy0hO8jEj9NE8U1OTj/4bqY?=
 =?us-ascii?Q?92xIKgdPG9Y4yjErZvjyPPbNU5vduhG9WkAbH3WCkqKi+Nfwu2B38/IN9bkC?=
 =?us-ascii?Q?OcmUVmSaJ19j406jiSliJIg6wHEkFqvTJHEgYNA/2nILA/fAHSTVhIIa7orY?=
 =?us-ascii?Q?5akUAGUGx35pX+ZLnI9ulBKJRnnJbsQXugQwWUyT9HzXd6hu7Hl+Qlb/ZMv8?=
 =?us-ascii?Q?gOJ3MxMJoqjet9RSbOoH+gpMg97YKEZNoqRUJOHP8UQ7ALSd69MFPLAiTmh9?=
 =?us-ascii?Q?fNKJuI9mkwOFS4DG8vJCfDMfQW+79VcXvasmlgXicTThbIHnWdEeHbDCtK/3?=
 =?us-ascii?Q?KoiouiWbbMrxUnNdd8OMLigo0wW7nJ85RWXSjBSyby9rNpUBudNofqYgRZYF?=
 =?us-ascii?Q?ecjprFmHIydj3i++rny7jxX/V7ZCnTeeA1Ot855wt6Aw7MQ24Mu+tQ3f38gY?=
 =?us-ascii?Q?rUOAi4IpSz9fHFcS2XWmu8MTtha5zJavc40XSLn7/qF/3jIpEaSxHM+Y8PBG?=
 =?us-ascii?Q?/bMBoSpL2VxIdJlUcH9wtTculaw4uFhxtaRvHn4faVCiiTHAwV5rQ9AhZHJE?=
 =?us-ascii?Q?NTFeJOQTXGtVr+XJwI2LH64yXgUpOBggwtx/P3QgcHP7Gv0Hku3bG4XYGD+u?=
 =?us-ascii?Q?cLAAl6w+Hf0603DXOZ1FnjkXARzV4GWl1/ZKeze0PbIw+vSrR4PpltpFT0yx?=
 =?us-ascii?Q?eIyxgJiOHqwjiBwno4M5zieurPRuAllbx14w2wO/nq0qKNtDjVL79HClV8FT?=
 =?us-ascii?Q?6tFftb3pgkUsutWRTYDbLXMSIYwgvuNY3nSGz0NljCwAF6lTYaB8StpN8VSj?=
 =?us-ascii?Q?ve/w/6jTRBVBvtp9OHicm3puTX3mxACQM7Ec9Nec0XJKQC91K1c2ClPGMjt9?=
 =?us-ascii?Q?RH8OUHk7TbGwMmAptEKGq6o7z7JzdTsuRngF3TSKcCmXwePzO6OJmSCwGlF7?=
 =?us-ascii?Q?iA+/SJpL+Tf3rQf7eQBcNfSlgfk/6vktBrghgWs/Z9YnUDc3odtvQJt5/aPV?=
 =?us-ascii?Q?SXwS+JXfHzvCpHp7se6qUbureojcwAy4NpOcRb0dnHOP2lWB/lFI+oHFafHZ?=
 =?us-ascii?Q?fog2a7iHsB+JRkzutl5ciAiaMZqUZmzUZeQbQXwwhV9bPuipjG1wCNTzOpnH?=
 =?us-ascii?Q?iZVfsWatFoDaAjWXADkWxQkUBvS5Jws0QaIiDNGYDWxjlIQCE/Esy0Kjqwg4?=
 =?us-ascii?Q?8SVmpcXsObvfSOw+oJlN5hLXqR4UO2wNHw38eMGTuP8Nwvfvy8iUkDH135Rd?=
 =?us-ascii?Q?qgCBEuKIOqPDVjtl61jFAvBVKBJ6EniS70mxzC3phAbWL3e3RimjNp1diMnT?=
 =?us-ascii?Q?DC3JdbYCx2NOiKhulamk3BW2RGmbCH6Tx4r4JAaf0KqkWF3WTYuKadvoa2lc?=
 =?us-ascii?Q?M8TLrLDfII1eCTApGGOSk34nGAEppqnYkXetvBYl5b7Z/9RbF3ZBlTzLtZrJ?=
 =?us-ascii?Q?40o+IfER3RpIfo5pfXAwA5Er1yjUI3o9cnS3crVYNqa5Rfp/VOfFkSEzUbaP?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ab98f0-b6ed-4f33-fa36-08dbaf762191
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:43:31.1389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoPcRbk8wM1r0m7mGfZe8XU55L6AWKJWj9pTOuZG2azbrwPguRAFBWRm9ClsnUF2B6EmMyIuh+VswXytiCKt0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
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



Hello,

kernel test robot noticed "kernel_BUG_at_drivers/ata/libata-sff.c" on:

commit: d3d099d5c2dd38db84abd96df39f9f0828c16b7b ("[PATCH v4] ata: libata-eh: Honor all EH scheduling requests")
url: https://github.com/intel-lab-lkp/linux/commits/linan666-huaweicloud-com/ata-libata-eh-Honor-all-EH-scheduling-requests/20230906-164907
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 65d6e954e37872fd9afb5ef3fc0481bb3c2f20f4
patch link: https://lore.kernel.org/all/20230906084212.1016634-1-linan666@huaweicloud.com/
patch subject: [PATCH v4] ata: libata-eh: Honor all EH scheduling requests

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------+------------+------------+
|                                          | 65d6e954e3 | d3d099d5c2 |
+------------------------------------------+------------+------------+
| boot_successes                           | 8          | 0          |
| boot_failures                            | 0          | 4          |
| kernel_BUG_at_drivers/ata/libata-sff.c   | 0          | 4          |
| invalid_opcode:#[##]                     | 0          | 4          |
| RIP:ata_sff_pio_task[libata]             | 0          | 4          |
| Kernel_panic-not_syncing:Fatal_exception | 0          | 4          |
+------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309071557.3a90e7a8-oliver.sang@intel.com


[   29.974031][    T8] ------------[ cut here ]------------
[   29.974432][    T8] kernel BUG at drivers/ata/libata-sff.c:1220!
[   29.974866][    T8] invalid opcode: 0000 [#1] SMP PTI
[   29.975228][    T8] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.5.0-11939-gd3d099d5c2dd #1
[   29.975817][    T8] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   29.976529][    T8] Workqueue: ata_sff ata_sff_pio_task [libata]
[ 29.977003][ T8] RIP: 0010:ata_sff_pio_task (drivers/ata/libata-sff.c:1220 (discriminator 1)) libata
[ 29.977518][ T8] Code: 35 a6 0d 01 00 48 8d 90 b8 00 00 00 e8 da a6 fb f4 e9 cc fe ff ff 84 c0 0f 89 e7 fe ff ff e9 4b ff ff ff 0f 0b e9 1c ff ff ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00
All code
========
   0:	35 a6 0d 01 00       	xor    $0x10da6,%eax
   5:	48 8d 90 b8 00 00 00 	lea    0xb8(%rax),%rdx
   c:	e8 da a6 fb f4       	callq  0xfffffffff4fba6eb
  11:	e9 cc fe ff ff       	jmpq   0xfffffffffffffee2
  16:	84 c0                	test   %al,%al
  18:	0f 89 e7 fe ff ff    	jns    0xffffffffffffff05
  1e:	e9 4b ff ff ff       	jmpq   0xffffffffffffff6e
  23:	0f 0b                	ud2    
  25:	e9 1c ff ff ff       	jmpq   0xffffffffffffff46
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  33:	00 00 00 00 
  37:	66                   	data16
  38:	66                   	data16
  39:	2e                   	cs
  3a:	0f                   	.byte 0xf
  3b:	1f                   	(bad)  
  3c:	84 00                	test   %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
   9:	00 00 00 00 
   d:	66                   	data16
   e:	66                   	data16
   f:	2e                   	cs
  10:	0f                   	.byte 0xf
  11:	1f                   	(bad)  
  12:	84 00                	test   %al,(%rax)
	...
[   29.978931][    T8] RSP: 0018:ffffb84cc004be40 EFLAGS: 00010046
[   29.979363][    T8] RAX: 0000000000000000 RBX: ffff88a1d49180b8 RCX: ffff88a4efc2d5e8
[   29.979906][    T8] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff88a1fa6299c0
[   29.980449][    T8] RBP: ffff88a1d49180b8 R08: ff6565725e607360 R09: ffff88a4ea0e32c0
[   29.980994][    T8] R10: 0000000000000008 R11: fefefefefefefeff R12: ffff88a4ea592200
[   29.981559][    T8] R13: 0000000000000000 R14: ffff88a4ea592205 R15: ffff88a1d49180c0
[   29.982108][    T8] FS:  0000000000000000(0000) GS:ffff88a4efc00000(0000) knlGS:0000000000000000
[   29.982720][    T8] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.983173][    T8] CR2: 00007f1549cb1028 CR3: 000000011465a000 CR4: 00000000000406f0
[   29.983726][    T8] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   29.984856][    T8] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   29.986008][    T8] Call Trace:
[   29.987041][    T8]  <TASK>
[ 29.987799][ T8] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 29.988599][ T8] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153) 
[ 29.989418][ T8] ? ata_sff_pio_task (drivers/ata/libata-sff.c:1220 (discriminator 1)) libata
[ 29.990388][ T8] ? do_error_trap (arch/x86/include/asm/traps.h:59 arch/x86/kernel/traps.c:174) 
[ 29.991210][ T8] ? ata_sff_pio_task (drivers/ata/libata-sff.c:1220 (discriminator 1)) libata
[ 29.992148][ T8] ? exc_invalid_op (arch/x86/kernel/traps.c:265) 
[ 29.992972][ T8] ? ata_sff_pio_task (drivers/ata/libata-sff.c:1220 (discriminator 1)) libata
[ 29.993919][ T8] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 29.994748][ T8] ? ata_sff_pio_task (drivers/ata/libata-sff.c:1220 (discriminator 1)) libata
[ 29.995668][ T8] process_one_work (kernel/workqueue.c:2635) 
[ 29.996515][ T8] worker_thread (kernel/workqueue.c:2697 kernel/workqueue.c:2784) 
[ 29.997328][ T8] ? __pfx_worker_thread (kernel/workqueue.c:2730) 
[ 29.998163][ T8] kthread (kernel/kthread.c:388) 
[ 29.998902][ T8] ? __pfx_kthread (kernel/kthread.c:341) 
[ 29.999685][ T8] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 30.000452][ T8] ? __pfx_kthread (kernel/kthread.c:341) 
[ 30.001228][ T8] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[   30.002045][    T8]  </TASK>
[   30.002705][    T8] Modules linked in: intel_rapl_msr sr_mod intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel cdrom bochs ghash_clmulni_intel drm_vram_helper drm_kms_helper drm_ttm_helper sha512_ssse3 ttm ata_generic rapl ppdev drm ata_piix joydev serio_raw libata i2c_piix4 parport_pc parport
[   30.005504][    T8] ---[ end trace 0000000000000000 ]---
[ 30.006390][ T8] RIP: 0010:ata_sff_pio_task (drivers/ata/libata-sff.c:1220 (discriminator 1)) libata
[ 30.007379][ T8] Code: 35 a6 0d 01 00 48 8d 90 b8 00 00 00 e8 da a6 fb f4 e9 cc fe ff ff 84 c0 0f 89 e7 fe ff ff e9 4b ff ff ff 0f 0b e9 1c ff ff ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 2e 0f 1f 84 00 00 00
All code
========
   0:	35 a6 0d 01 00       	xor    $0x10da6,%eax
   5:	48 8d 90 b8 00 00 00 	lea    0xb8(%rax),%rdx
   c:	e8 da a6 fb f4       	callq  0xfffffffff4fba6eb
  11:	e9 cc fe ff ff       	jmpq   0xfffffffffffffee2
  16:	84 c0                	test   %al,%al
  18:	0f 89 e7 fe ff ff    	jns    0xffffffffffffff05
  1e:	e9 4b ff ff ff       	jmpq   0xffffffffffffff6e
  23:	0f 0b                	ud2    
  25:	e9 1c ff ff ff       	jmpq   0xffffffffffffff46
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  33:	00 00 00 00 
  37:	66                   	data16
  38:	66                   	data16
  39:	2e                   	cs
  3a:	0f                   	.byte 0xf
  3b:	1f                   	(bad)  
  3c:	84 00                	test   %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
   9:	00 00 00 00 
   d:	66                   	data16
   e:	66                   	data16
   f:	2e                   	cs
  10:	0f                   	.byte 0xf
  11:	1f                   	(bad)  
  12:	84 00                	test   %al,(%rax)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230907/202309071557.3a90e7a8-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

