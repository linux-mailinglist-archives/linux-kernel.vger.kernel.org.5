Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D66B78073E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358638AbjHRIes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358624AbjHRIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:34:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C5C3A94;
        Fri, 18 Aug 2023 01:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692347654; x=1723883654;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=IYrahrD3ps1D4oEcmYLPVJ+iw7TUM3dLhK/d2B5wB4k=;
  b=XvCOJey+h/zSbkXlq/TNXc9a1nDESDCngIuhN6VSUL/M5ZawpXLTj0/f
   TUxlZUTEd3YtGAE4KFKAgO3KjLZ003XzZOmEsWiXA/VpWBAmDKZFTmZci
   AsQ0w1sVh9iT4AthIq0iF/ytGNVMj8pLjymxPVgO1qsjqQcC4EQ7I5VxV
   3H5m8nhMnnXxX+rJEV8PaXXAMKV6wO+Vt27+kcP7ICHLZbXnOl2SNQdA8
   zfbXMM2outb3wKE0JhF2LPePmOJZiSDv4687AyQZpkBdHCoS6wyz5JTCT
   O1231s++loETls4dx8koIn44yY8yxsIbe7umT50VB3J7OoEXvPz01t33c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363208541"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="363208541"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 01:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="735017612"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="735017612"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 18 Aug 2023 01:34:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 01:34:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 01:34:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 01:34:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 01:34:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq/dHujVHFTHHCYL7ZbumOa92XvB5c6lxBD97c01QaHGJFhLcaXOPpboN4O4gVv1ogsO2RoO+kPs2SfAlrb5PBZWUeRxszMTq6EuYkPSdLaf0nP0W1XbcrWunbqrVoFpS77DzLO4O+dl0YL88AjRQmHeQ4WWYCbred65aagLqYhGZQb/7T9FPJd/seATjn6BddQDD+xUMkpJPyBI5JYc+jR3aZNCaUEhy0LXJj5L5Q7MYc5i16rvgVBOV1zfJcup/vvVhU//Rabz2Wr/vqNsB7YdDIsv+8ZW86t2P0FzxJDci6cgoMjLFEuYMX3aG1n00QE/fc9V5Tau0CIq8Gx/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrotsK/VkxbY9n8rBhs3ISkSzHnNiZWJ/OfO2u7d0T4=;
 b=ErJ1dxJpQ2mazS8+5/zVE9/k3ObxnSUf+h6CmYS4jC7Rjb2z/Eh1xmiM+ZXLtqo+6BD0zk0B7giIDZsjMGeYQkCKYll1xM+35Qwxd8uAfcThdwnI/qor9PnxuryUZBVdrdJKuqorNMcjC4fK/f7lPIwF0CRslhoT4aYW4RgE7OA2E2Els/wlx0kB7QwgBm7QodGrarnLdMC/FV9RSfY+KGcKuhXRiAaly4MoMh5U2QK/Vm3HgsvkrHz2YO1pavFfyphktiavN1YRn3lMzrkO57Y1t4+mE5fNnoWWBW107ZFJZACDFZdiSYjexLGhhNpWxznYI1sF2AW9SCHTSrGwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB6099.namprd11.prod.outlook.com (2603:10b6:208:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 08:34:11 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 08:34:10 +0000
Date:   Fri, 18 Aug 2023 16:33:59 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-usb@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/1] usbip: Use platform_device_register_full()
Message-ID: <202308181658.e33ac42a-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230817121300.501637-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7130a3-a889-4506-a0c6-08db9fc5e4a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCiK/RYBpNoiSO3pGlODkQGg97TCcqdt9wv3XCKrkTYFbHbdOWtl/s21vZvbdj8KKOu4C/torGit1qWXeHr6JzwMSc/aEBT/xmArvhxwJFbhqw1uNM/KzNrHIEGnbbEUUOAmerv5wRzJT9yKY8ZytgYdT7FwNuUr22MZUBdv0YCvUuh1fBK7F+oQ2zLfVBTR7YHs39pKPGkTO4wCSVkTEiF8effXk1YXf2ir5GuF7tb28VKNmDeNio3gDpSWFqA2n7bU+hJUJDGBvlnQKF00g34SlqL53/VA2/mUp4I3+R20YglNGWJuBZQZbJkoYP0mc/Kzqxlj2bGiE5qyJ398lGId3phgMoWjoG6DP7PPrP2Ls9NWqblnVTRETKFfQ0HVGsEmZwpie9KwScgJ/Q8cCfx2mQmP47n/vkFRQHgp4GpdlcA/sqWbFus2e/WXpiInWRjufQOyyv4qoswQbqeWHR/dBkmmJY/VIifFx6BU5INYRRYpI8mL3GcW1ylefSnxsKtktnreJ/tLMefx/ryXFtJIkgHQr1veWTnkW5kYYs68hmJQ+NPU1d9dpaTxLmRClnxdMvrL5Bh8tc6lb1HFxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199024)(1800799009)(186009)(86362001)(36756003)(82960400001)(38100700002)(966005)(2616005)(5660300002)(45080400002)(66556008)(478600001)(6506007)(66946007)(66476007)(6666004)(6486002)(54906003)(316002)(6916009)(26005)(1076003)(6512007)(4326008)(8676002)(8936002)(41300700001)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mlOSpO3foJekAfubQAYgW5ZEFi/8+6aaB7dEo0nIlM9UO/GTxX6nMaI7sRLc?=
 =?us-ascii?Q?mZxOAIFRiIOQYX6wXYdmaZTKWXyQSExeU+rn+nu9jpROLD1ok8L+upFROtvn?=
 =?us-ascii?Q?B/7c3aiEMXO2sdcn8YUasn9w4j09iNYvRs9BoB2+jYymTK/aA/gbE6tL1qft?=
 =?us-ascii?Q?OLQcPFFvhUUwCOGwN3BdmIu3kS7yQWUjY9GxnW1FSNanFxkFrjfLkU4ZsBoT?=
 =?us-ascii?Q?dtrdRlUdSM3aDNpCX9rHm67y8b8HGdsfOn1hYd/gYefE/Fa+jAKDR/YvJWoI?=
 =?us-ascii?Q?b0yegHPqiwg7gC1uHkZBVG+Ftwk6EjT9rAb1BDdGQDUHd4lPj2wecOuqqUAQ?=
 =?us-ascii?Q?pA/wCvrvNegqF3PfEeSNR0MSP4Myfccr9YmPF8i0WkgthL0S4pHPLitY+1jq?=
 =?us-ascii?Q?+sWsssKv7srFR0vL23WwCZF4eGeWci5DeSydTM8o0573eMsF5qagQQlzegxn?=
 =?us-ascii?Q?917YTftvAMxEuSO3RQICicietC2StokgG4q8Yux34cctaeEXKnBt7i/N135x?=
 =?us-ascii?Q?rIsHsVq3lZ/hcm/fYhSDdPj5CYcrAFansCKG+w9b/ylLaK5VSxnwlZPveZgM?=
 =?us-ascii?Q?As9NxcNZaBeby3CMqNBbPqXA1ywtLxUPbuj1BuA+OLpEmk/SeyebRqlRo5Av?=
 =?us-ascii?Q?w0mRnADf/Da/zhHS/ee4yjY7Rq2iqI8SB1o6BEXz/hwcR/vN1Peb0wU/6wOl?=
 =?us-ascii?Q?j1fi+2YnFQAzcZuUM6z2TfAutJQUwOi7Wtxf01FaD7nHTfxIPmDU7jORj1tu?=
 =?us-ascii?Q?RiNayOJkwd3PQyS/IxZ1nIaFB04Lj8jgi8SleoyT8knP4GG30P9Eh/1Zcdig?=
 =?us-ascii?Q?jOx9ZsD9pCvrWIwsCNj6ZUK8Om/ktIlzBFEcpgaZuJuHPZdvLVMxw626zdn1?=
 =?us-ascii?Q?FaoMNGeFQtBeYVyW1hKMdlWtpP+XCmboJLbMAIxDcIscUT3pww8WEhQH5zhD?=
 =?us-ascii?Q?SfWMtgbNFAPUi6zeZgXLeH13UxMYlekAvrjw+HzPULo3EkiPR8/3Pz7ZvDf/?=
 =?us-ascii?Q?g1G1N8/gV9oTCHBQD9x3knv13unjoowyY6nAA4B4dr4t9ntIPgdqzHnObWsY?=
 =?us-ascii?Q?hEo3JHwTbPNfhegus03Yk8/ttU42H1Ge5FHYX/dxyFVV0WHSqqcr03G2l3KQ?=
 =?us-ascii?Q?IjLWgslN1YbN5ApBzLFMc3gq7qP3+9Dpon96Yzqr4vB6UqgYUAfFZarZsfcH?=
 =?us-ascii?Q?6D67hkQOGIwwB2sCd45oX46U5kykcUFa9HkLdGefNLs1AF+uh9Y/BrhDtzZ3?=
 =?us-ascii?Q?iakZFDyW6UfMo909icxdgEEfcqQpfJtao+2eVDrnKfc90GzeWT5R2xOGjTb3?=
 =?us-ascii?Q?yqOULpWbqY1UCvGKgIl8c/ncwe6sMMTzK0mAzRzv+D0cdv3Du/WbprENkGZh?=
 =?us-ascii?Q?3YIO/eON6XcfgU5Kfsbw5MpHzg6A9elFh9oJ3vovvXbFH5Hd3yewsG8naVuJ?=
 =?us-ascii?Q?GCyQQDAo38tV/lsOV8sEcrLbdnDljoqwnPTN/wz+Nm2xvcLTAaJMjHvSKhTC?=
 =?us-ascii?Q?i+TWFlo53RbGEJcIg4tciizLd4TlKCZH7BmU8pji35SBGyEYcQJjAd7cJ/Uk?=
 =?us-ascii?Q?TPYK+7GuAWXLlk3PQfu09TUbcobZdnG2fc7jDLeqSDTO7H0ntH3w6dRrI1m5?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7130a3-a889-4506-a0c6-08db9fc5e4a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 08:34:09.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfrQOUaEjZP6gkQKe+qQY/nPjDcrhdHJ4ptCOMKdIcQgKiwamPAcx0radlumVT3DdTGkR17sBUQnXI5N0Dg++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6099
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 86a50b56c5a09f33c75fdd6c1275188b0de61eb3 ("[PATCH v1 1/1] usbip: Use platform_device_register_full()")
url: https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/usbip-Use-platform_device_register_full/20230817-201652
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git usb-testing
patch link: https://lore.kernel.org/all/20230817121300.501637-1-andriy.shevchenko@linux.intel.com/
patch subject: [PATCH v1 1/1] usbip: Use platform_device_register_full()

in testcase: boot

compiler: clang-16
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | bbb9e06d2c | 86a50b56c5 |
+---------------------------------------------+------------+------------+
| boot_successes                              | 20         | 0          |
| boot_failures                               | 0          | 12         |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 12         |
| Oops:#[##]                                  | 0          | 12         |
| EIP:vhci_setup                              | 0          | 12         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 12         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308181658.e33ac42a-oliver.sang@intel.com



[    8.098949][    T1] vhci_hcd: vhci_hcd_probe:1345: name vhci_hcd id 0
[    8.100593][    T1] vhci_hcd vhci_hcd.0: USB/IP Virtual Host Controller
[    8.102740][    T1] vhci_hcd vhci_hcd.0: new USB bus registered, assigned bus number 1
[    8.104945][    T1] BUG: kernel NULL pointer dereference, address: 00000028
[    8.106630][    T1] #PF: supervisor write access in kernel mode
[    8.108111][    T1] #PF: error_code(0x0002) - not-present page
[    8.109638][    T1] *pde = 00000000
[    8.110567][    T1] Oops: 0002 [#1] PREEMPT
[    8.111655][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G S                 6.5.0-rc6-00120-g86a50b56c5a0 #5
[    8.114034][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    8.114778][    T1] EIP: vhci_setup+0x22/0x60
[    8.114778][    T1] Code: 90 90 90 90 90 90 90 90 55 89 e5 57 56 89 c6 8b 00 8b 40 3c 8b 38 89 f0 e8 8b d8 f5 ff 31 c9 85 c0 0f 94 c1 8d 86 18 02 00 00 <89> 44 8f
 28 89 be 18 02 00 00 8d 04 09 83 c0 03 c1 e1 05 83 c1 20
[    8.114778][    T1] EAX: ebb42218 EBX: ffffffea ECX: 00000000 EDX: 00000000
[    8.114778][    T1] ESI: ebb42000 EDI: 00000000 EBP: c55f1a90 ESP: c55f1a88
[    8.114778][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
[    8.114778][    T1] CR0: 80050033 CR2: 00000028 CR3: 04782000 CR4: 00040690
[    8.114778][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    8.114778][    T1] DR6: fffe0ff0 DR7: 00000400
[    8.114778][    T1] Call Trace:
[    8.114778][    T1]  ? __die_body+0x64/0xb0
[    8.114778][    T1]  ? __die+0x6b/0x80
[    8.114778][    T1]  ? page_fault_oops+0x2bd/0x2f0
[    8.114778][    T1]  ? kernelmode_fixup_or_oops+0xab/0xc0
[    8.114778][    T1]  ? __bad_area_nosemaphore+0x40/0x1b0
[    8.114778][    T1]  ? bad_area_nosemaphore+0xd/0x20
[    8.114778][    T1]  ? do_user_addr_fault+0x382/0x410
[    8.114778][    T1]  ? exc_page_fault+0x4f/0xe0
[    8.114778][    T1]  ? pvclock_clocksource_read_nowd+0x170/0x170
[    8.114778][    T1]  ? handle_exception+0x14c/0x14c
[    8.114778][    T1]  ? pvclock_clocksource_read_nowd+0x170/0x170
[    8.114778][    T1]  ? vhci_setup+0x22/0x60
[    8.114778][    T1]  ? pvclock_clocksource_read_nowd+0x170/0x170
[    8.114778][    T1]  ? vhci_setup+0x22/0x60
[    8.114778][    T1]  usb_add_hcd+0x240/0x490
[    8.114778][    T1]  vhci_hcd_probe+0x79/0x1b0
[    8.114778][    T1]  platform_probe+0x5a/0x80
[    8.114778][    T1]  really_probe+0x14d/0x3b0
[    8.114778][    T1]  __driver_probe_device+0x78/0x180
[    8.114778][    T1]  driver_probe_device+0x19/0xf0
[    8.114778][    T1]  __device_attach_driver+0xb5/0x110
[    8.114778][    T1]  bus_for_each_drv+0xe0/0x120
[    8.114778][    T1]  ? __pm_runtime_resume+0x66/0x80
[    8.114778][    T1]  __device_attach+0xae/0x170
[    8.114778][    T1]  ? coredump_store+0x40/0x40
[    8.114778][    T1]  device_initial_probe+0xf/0x20
[    8.114778][    T1]  bus_probe_device+0x7b/0xd0
[    8.114778][    T1]  device_add+0x2a5/0x4b0
[    8.114778][    T1]  ? dev_set_name+0x15/0x20
[    8.114778][    T1]  platform_device_add+0x7b/0x230
[    8.114778][    T1]  platform_device_register_full+0x1a8/0x1f0
[    8.114778][    T1]  vhci_hcd_init+0xce/0x150
[    8.114778][    T1]  do_one_initcall+0x193/0x310
[    8.114778][    T1]  ? usbip_core_init+0x10/0x10
[    8.114778][    T1]  do_initcall_level+0x93/0xc0
[    8.114778][    T1]  ? rest_init+0x170/0x170
[    8.114778][    T1]  do_initcalls+0x36/0x70
[    8.114778][    T1]  ? rest_init+0x170/0x170
[    8.114778][    T1]  do_basic_setup+0x12/0x20
[    8.114778][    T1]  kernel_init_freeable+0x63/0xb0
[    8.114778][    T1]  kernel_init+0x12/0x190
[    8.114778][    T1]  ret_from_fork+0x2c/0x40
[    8.114778][    T1]  ret_from_fork_asm+0x12/0x20
[    8.114778][    T1]  entry_INT80_32+0x10c/0x10c
[    8.114778][    T1] Modules linked in:
[    8.114778][    T1] CR2: 0000000000000028
[    8.114778][    T1] ---[ end trace 0000000000000000 ]---
[    8.114778][    T1] EIP: vhci_setup+0x22/0x60
[    8.114778][    T1] Code: 90 90 90 90 90 90 90 90 55 89 e5 57 56 89 c6 8b 00 8b 40 3c 8b 38 89 f0 e8 8b d8 f5 ff 31 c9 85 c0 0f 94 c1 8d 86 18 02 00 00 <89> 44 8f
 28 89 be 18 02 00 00 8d 04 09 83 c0 03 c1 e1 05 83 c1 20
[    8.114778][    T1] EAX: ebb42218 EBX: ffffffea ECX: 00000000 EDX: 00000000
[    8.114778][    T1] ESI: ebb42000 EDI: 00000000 EBP: c55f1a90 ESP: c55f1a88
[    8.114778][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
[    8.114778][    T1] CR0: 80050033 CR2: 00000028 CR3: 04782000 CR4: 00040690
[    8.114778][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    8.114778][    T1] DR6: fffe0ff0 DR7: 00000400
[    8.114778][    T1] Kernel panic - not syncing: Fatal exception
[    8.114778][    T1] Kernel Offset: disabled



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230818/202308181658.e33ac42a-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

