Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A897E81BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbjKJSdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345303AbjKJScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:32:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72F37695
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699598052; x=1731134052;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sd/UJln+gigwJ9jdv8J1vCoXFXmfALVzejOh2ZYyNAs=;
  b=gz2eIcpFK3M0YUGwOl4og5oC0dlPpelTwbPqrtlF9qt70qpR8Y8P5P28
   0d3hKLr4px/pZyhZBGSeTdNsWW3y+N9xBWh/hLah0HoA8vNEDM0rRgj+h
   RsX/V0kTpUdP77NgwdzitDGcz6d7cIpFEUiz3SEp7IV+EqxCeabV0LBrE
   DZqdGnMnvEm5Bc5G2xXu0lXQ/PCZymh7/GPlCIh4YEwiqggn+NXqBlTfh
   yIru5e0ikm/E4Zp5GgkrJTPWx5XuMMDsEbb1Ukf58+AlLObyyZ8JCoW7R
   2RZwFAAbebtqxsPlpfyUl9VhxTnjx5dcW5ee0yeKYn/bYwZY3c2ghtRIB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="387298486"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="387298486"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 21:54:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="11389812"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 21:54:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 21:54:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 21:54:29 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 21:54:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2ByZP1K/J6HWL2icFludXhGJBYhF1aBWOEKJFc+vGRqXdoD1ZJAVnWTOUxxp5x+++DG4Vn3UWV6kazl/wk7UR2qk3l2njuUliUck14fcYWmczpZH9k3xBz+YGlf0GjjJiAT59H0vkei9d0eWkjWwbRZrN1OdWENvJXcso7qD6EXRkAxVDq0xYxzbJdGbeKrVcKMrhRl3G0lQipicGgaCMmSweC7CJcAZgHu5YPCNvkr0Qx9bQZXJ1Ef+qa7WFyfoWUZ1hc0/F2pnB//WgGSfdTU3BVrSh/bMQsUe5srFlhQTtFWA34J5eAYj8J8y40OMCWkLrWYFK2e/6qepwVrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1u8sQXL/3f7afYT8X+F+7BQTo2tMLap96lw+oN7QKQ=;
 b=lSkjVLUGtOW1/PNADqcKYA8wMB/JJW6TE4QN2o2uF8AH13ZN5DQRLZT6ieNFewSHdB4ltiJ+PYG7+j5zIKeTguhSF0Py5B23ncTPvvCUOBQzRHmHR5iZVyrjSoEnTc2UWogYKqR6bXvlp0DGCfjzlI1bOWki/yI6kk+ixym6rHb/M/Hh4IaVjCUkkQxb6roaxM1+p3GpDrdI5MO5BOxpt4ieB9Jj55pzgFlnGj/r1bQeKuX6wBn5Sx/CktdAEOlgfuBmzlPemucU502eQ3Tnns/vM7kfRYo9zhSUX2ycXZam9QX2JWg3mikPezMu30Ylq8IWm5AbYKAobjbakQvQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH8PR11MB8062.namprd11.prod.outlook.com (2603:10b6:510:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 05:54:22 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Fri, 10 Nov 2023
 05:54:22 +0000
Date:   Fri, 10 Nov 2023 13:49:41 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Ayush Singh <ayushdevel1325@gmail.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: drivers/greybus/gb-beagleplay.c:173: undefined reference to
 `crc_ccitt'
Message-ID: <202311100836.JBsBIf8t-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: OS7P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26d::8) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH8PR11MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5f9eec-5215-4e85-d606-08dbe1b17cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbBLj63NhBPTBRnNk6kkBLXWQb8mNc97ERFALg9td+r7jG7vi8ygHxPwXi4G/+S/rgsHnGiQ3U6To8CEDvJTVvpsjL5iA7/UwxJDgOjmEuax1Ej5mm53RMkMytuDJYW69MPwBcXinOi31DuFtmbrMpbozeMIplm4phSYKFwRBF0cFSz4vcZ1VkO50qsFQD/Yr3arYd5Z0xlrbeB9j1dmSy5ymTmeya1YT9bYF/aAnf11UOSGkY2I8MB+JI0dpq50mF8zDa7AST8yJrPkGQ8QWJjb5uICclRICjaexorYaRdOPcYamZVZIokHJCcGBZB+x0mgfsnVb24GpaiDlDed3xy4AoUzDLWUAgsiGEsLVZxut1kBewVeo9GiWL7IrHuqmQ7ccd8DxWY0t4jwjK9AWhcGuifk/I9eF0VPWYFvfSHPQMKwagzF/o4PaD+0ASPiuT6NKM1FPiEQt5jKmetx2XVeICzP2g1kKM2Wcz8Fj3Vshee31OLa7LgWGfCGeGUvr4Nr3H7qefwocBtFu07pS/J5dtCGS9KhGdszQY6iHA5Wi5SmQRifcIRnws3ecgYn9C6KJdWNP0Qybt3ZshNC7n+Lq6eYPGmHftxtbHOCAISJ+m2GQ2wVVNGoeL2A5MK5Fz6kbiWTDHBwnlTsNqGEiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(5660300002)(83380400001)(26005)(8676002)(316002)(4326008)(66946007)(66476007)(8936002)(66556008)(6916009)(1076003)(41300700001)(6512007)(6666004)(6506007)(478600001)(966005)(6486002)(2616005)(82960400001)(2906002)(38100700002)(86362001)(4001150100001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F6V74BPEUXJZvE6BuRKKDcjOQhmxguvgn9IHsn25bIfBirh5xUbLQDMjGBtN?=
 =?us-ascii?Q?YW7Z6fFzJ/DqWtbyl423lQkgo/F6i8kJJXD0BmvZrPttoSveODHwfw75djg4?=
 =?us-ascii?Q?FFw7rxSPE63tdXf0sx2avNKPJwMlTOomgcm6YSwXmt4LqmDwDrVxeAf3ZBys?=
 =?us-ascii?Q?Mn4A7lhNXDkDEcNjOnr3+SJ90MPfK7sZcH+hp4/F5Mvxj1YbAEsLG+3CUGWt?=
 =?us-ascii?Q?EhiKofzlRyR4QnrYPCxSmMU505g2DcxYT6ETAZAc2zrsD/UFTU2wjmQXGJfc?=
 =?us-ascii?Q?GLWt1zW1MnPLYPvWveeMPjOhWbAa2TPfs/gOHYpiLhySbZyLu0DcGHQOA+x+?=
 =?us-ascii?Q?yOWmLuroTrhD+C2hrXpHId0xxWJ9PyB5JZl4+9ql6N0nawT40kSW0CKYBNsA?=
 =?us-ascii?Q?r+9BGZtOgE1A9qEW7eLTYA1TGKODaQfogZSVsU+DQKs0K2cbQ6njd0BUTRAB?=
 =?us-ascii?Q?5xJINv2mFdMiNPVt+efnpH0Dv+2x7hAswVvCxdHhrEpivFod6rVBFMsHMZBa?=
 =?us-ascii?Q?U3brWDaueX3ZXumq1ws4lyIDaEh8RLVvFfGrFL2sLnZMPhCF9FqyqsPvjJqC?=
 =?us-ascii?Q?oBkqscRZuTcv05zgaAQ1NDgJZIP8MwKtrLUrHqcZKR/HGcTEj1cfQQY/V/Xd?=
 =?us-ascii?Q?GFn1lm6bKeWeBkA5VCdD01gHUEPbkJC8Vq8IDAKBURUZTmfx1JXLp7j1itta?=
 =?us-ascii?Q?5I4PU0y8Z80+FvjxtZ0cYK680/mmf5/XFaFEi0HWFrUymHeWD/r8WXZBF72X?=
 =?us-ascii?Q?uRkyi4mbfsoQ0/gZxRbDJGmavL2JApRZGcskcLT2xDKn/q9YznCq8B23oXmi?=
 =?us-ascii?Q?VZpuFlD65jWhwGrl51wapvHF3FeLA6BtIG0hahoSasG81aP5bK/0ZpfeoEXn?=
 =?us-ascii?Q?ny2nJp/nNJ6Wu3bRGtSmD2HEjJSpVLhROl4kLTadAhSY2O1TJJOHoDBXIGLc?=
 =?us-ascii?Q?12kjYfQKr/uZbdL2iFPycOvXh3DJq0/SiERXff++MuUMlNbRIKYnpBCkk+Ub?=
 =?us-ascii?Q?SiCPqaAf9BzZzIIM3AXzQGjTO4FoDQk0Ic7Gln0ovvRaM4POnOV9AHhyT/PV?=
 =?us-ascii?Q?4nXSy8uEepymPlx8PKZ6yM4cqXGDS+8llgFRvPXmummKIRZFWGd6gJiiY/1X?=
 =?us-ascii?Q?fX7FF7lRPr4T/gnhJG2EF1VOKMtqWPrfKzOh6IBqxfdel70CNDlgU1ECQ3TF?=
 =?us-ascii?Q?hYzLSdBwZ+tfPCCnA+oK/n4npmQOznPtKWxJXI49wDvic967V/jKrR0rfKYW?=
 =?us-ascii?Q?O2MX9S8RZ4qCujaE+dvhFK6bpkzSjiQ8L5EqgQa9pCulRgVoNsV8yYSiVf9O?=
 =?us-ascii?Q?9SYyy9qHQUJw+IAkkVWgiEcOWKIWjGYZ4wcTt7L6M4nwshISOE5T/Np6mpQU?=
 =?us-ascii?Q?WZUbK5CkZ+k+qVI95MbKXmwqZjcf5CN8YaEa2eoTx9Wb49aqP9dW2p+UzbWq?=
 =?us-ascii?Q?cf16FQvuz3WqhXaRWS//MbZh4VU07lEniRCWf9uSBsmPj+X0vUhOO0SFIjN6?=
 =?us-ascii?Q?dZes6X/cLbeSXqBLs5efgnAp62AL+rG4tS8YRb/za0OJF6mI2vN+kbNKMXwV?=
 =?us-ascii?Q?B5l/4CYDYkbYXC5dEZwCxqwjCuEXfco5RSBc7dzn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5f9eec-5215-4e85-d606-08dbe1b17cc0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 05:54:22.2606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ak3A+p4ZAaZMLm+YNF4Cjirn816X9JpZ8lUaI7cVTPgqdOjRxTxL1JemhonvyzZ6mrNWoQRaxKu/DJFZjGpjvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a12deb44f9734dc25970c266249b272e44d3d1b5
commit: ec558bbfea671ac020a6dc6be8bf8f0ee556cce0 greybus: Add BeaglePlay Linux Driver
date:   2 weeks ago
config: x86_64-randconfig-011-20231110 (https://download.01.org/0day-ci/archive/20231110/202311100836.JBsBIf8t-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311100836.JBsBIf8t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311100836.JBsBIf8t-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `hdlc_append_tx_u8':
>> drivers/greybus/gb-beagleplay.c:173: undefined reference to `crc_ccitt'
>> ld: drivers/greybus/gb-beagleplay.c:173: undefined reference to `crc_ccitt'
>> ld: drivers/greybus/gb-beagleplay.c:173: undefined reference to `crc_ccitt'
   ld: vmlinux.o: in function `hdlc_rx_frame':
   drivers/greybus/gb-beagleplay.c:234: undefined reference to `crc_ccitt'


vim +173 drivers/greybus/gb-beagleplay.c

ec558bbfea671a Ayush Singh 2023-10-17  170  
ec558bbfea671a Ayush Singh 2023-10-17  171  static void hdlc_append_tx_u8(struct gb_beagleplay *bg, u8 value)
ec558bbfea671a Ayush Singh 2023-10-17  172  {
ec558bbfea671a Ayush Singh 2023-10-17 @173  	bg->tx_crc = crc_ccitt(bg->tx_crc, &value, 1);
ec558bbfea671a Ayush Singh 2023-10-17  174  	hdlc_append_escaped(bg, value);
ec558bbfea671a Ayush Singh 2023-10-17  175  }
ec558bbfea671a Ayush Singh 2023-10-17  176  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

