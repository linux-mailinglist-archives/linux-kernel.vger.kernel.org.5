Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C71D7FA1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjK0OHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjK0OF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:05:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108C3D41;
        Mon, 27 Nov 2023 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701093574; x=1732629574;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=TgX49Kliq2PZdMHdIbnHg8Dvlkok0hTHpO0YaR0GozI=;
  b=LN4YQlBafrcbq3XTSJtJWHTJVzh9bUn1Cv3Ca3JfcfopjAVvhlA6ib1C
   1Q0AlWWkd77Ba433ZqAgv0Hrx2y31dhbuM60vreW6F13tY6WyF0fCoAii
   nYBxHWM7/8ortzM1qbUVloMuilDCU1ao0HXBoANOuN4tirGMAij4NQvZq
   6CRo+gxTommHryIbUcmgaXY82vpWR8LYNb0LW0jrDfaA0oBMsufMm7LQc
   vfR4Hb8rcDaNUasrUNrwmgKuA7UHo42Ewjxw1Yn3UHVt+wkJ9B0UbrET0
   F3Q/6AKS/co9aTuVuH54B/oRZRGGORYaIgJMmNhpEDvKVjDDl7IcAC/XD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="396610342"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="396610342"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 05:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="838719031"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="838719031"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 05:59:32 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 05:59:31 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 05:59:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 05:59:31 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 05:59:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpFuz+4whmTIoOlXeYiicJKFWK/vjhuraSFKyoFAQCm8zbZs6pma6BCgKRaB0FxdEMjqhJhn4HIxEro1roRDXG5upaBGs1cTuBICHwdTsmI/7vt037CLN2trKZdldO8o6wit3Y7K0gCIgaiThm40OK2+5IrmWZQnvxIjSu8SwkJiVj97TNm1GhtD6vyFjr7yvpXaksBg3g8CCT5D107MJAyNsh74+SpQAe47Jzbc12iaOnCINoWh0zEBpDZo9JqhzxADwaBOmL35NstkFbhw6LohcSb3pwCgiZ2XlhthhfMjBW318qCRIdvkYifPXIi0tx8bZPF+aDVXg/o6J1a1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stTtFR54szEVXzMSoXmz9RQf8l4FWnOY3wU1MiYgnvs=;
 b=WoRsoDTlcVhsMG8oZZz83n8RzBgGC3Qk3wDHgtmNgFIA71Nu/pmNPvPMRjG2nQw3sJujxqH5Sgr3IbnPwUX4xZlGVJ96/gskCfsdujO1Aeq4XushnH+Ol4rmenymViSst1CmjIBQ5YooB4hg/4QMKCNCFDzE+108+4zD6ZqYpFV8kRRh3m6UIxH0jvpR0e1u38Vmckt9pT9TTFF85GDCWcwzv/74s1W1nmUj6TcucG1AxpHOHIGkO2mYsTd4DfJZl+PLmTtem3ORiI+dSqMElaSs8nNORvAiCVYmJIBX4uyBVvdd3azMHy6WZEX9h8luLAo/CiFXFiaUCNEEwMuLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6724.namprd11.prod.outlook.com (2603:10b6:510:1b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 13:59:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7002.027; Mon, 27 Nov 2023
 13:59:27 +0000
Date:   Mon, 27 Nov 2023 21:59:12 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Kunwu Chan <chentao@kylinos.cn>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <netdev@vger.kernel.org>, <aubrey.li@linux.intel.com>,
        <yu.c.chen@intel.com>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <kunwu.chan@hotmail.com>,
        <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
        <oliver.sang@intel.com>
Subject: Re: [PATCH] net: sched: Fix an endian bug in tcf_proto_create
Message-ID: <202311271643.12f713c2-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231117093110.1842011-1-chentao@kylinos.cn>
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: f387da75-28d4-4674-a0c4-08dbef5111e1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CJZj6ym/FfyTaiQ0OyCqfa3PaTu+65RCBiD7YT5Eqj6ZqTqTlxNu6OIngGL1lamcphfsTGMVnIsslWyErGW3RnrEU2pbRxCkw7LNK7+keMAor/XggR1XY4d/juiMkzMdQ0iP/0zCGFqb719HLoDtyQWGB1VvW1UesjCenLf3RslXBAOsAPw4AB+wsQ7K877+vMKv8V5NeeK8PWYcA8i3omXMIGpqL6HEGTLSqyVHjSNPnjLJNRZnhFyQpdLRqSmYxqPV9wgE6a7HAoQdJTbYReRuA+7QfCBSZ7nE52eJIHZwHiaxg7dRG46POg5HsJKtjBR5ArAbJWUZRuygrZ747qGgKUstX2yzPHfGvY78JRnW5kboKfdFfgwoN3SR8DWbdfNcXXW3H+bp9jp0AI60MsB/hoFdxOhS0xP6el4Lz/8asAPQg8+vuaCnQU/gJhF9cLjdgyQjajeZ+bkj+qpy/90r1EjJpYlybUjpsYuIZXbesSViVoRHOC6r5VEUG4bE2C2n3+Fk1mu0RRjKl6cWhvsqjC+OYUwm+hd3eKMSs/Tw1m80xd+6vbG2a0zDa66F0bCVIZTg+te9Q6jQnmZtCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(7416002)(316002)(66476007)(6916009)(66556008)(66946007)(6666004)(6512007)(4326008)(8676002)(8936002)(41300700001)(478600001)(5660300002)(6486002)(966005)(6506007)(1076003)(26005)(2616005)(83380400001)(38100700002)(86362001)(82960400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yv1L2YigF2f0jeixhNr52cwjBgbQIS6nnKq6bPOUGkRWqt8MQweV+bN0/R4v?=
 =?us-ascii?Q?NBYSKFN+OIGX2hI6ZjRqJMjYqRNcfLmAO7lMNjNP34iTEe2AyoNYwC1O+vfp?=
 =?us-ascii?Q?pwCt1fjTSsUK+ilqoA2FMMCQFGs1H5eY7lNBXlWMSdtO2PmWv4VbQGppz8lL?=
 =?us-ascii?Q?qmmNI5P8AwPEH1DicssQJE6nIx23mOJoa6xleydNiJSyhhDLM9Etm5JoMEot?=
 =?us-ascii?Q?bK/mk87/MpOkmWMUVqJjsbutte6sfOPoXoDzauwy936EyDemGyaBsisaSX7T?=
 =?us-ascii?Q?GMdNrdZjYtbCNO0qWmlKyGsIFoc1AWJCHmwC/kk4JMC79yLB3UQdtYYX3dBL?=
 =?us-ascii?Q?Yy0Ya4ViGip3/fsWgNjt8Wb2t8ygr+rhTCLqzUyJXosEdn/FEGmqcbe2Pd+x?=
 =?us-ascii?Q?lxuezz5HSOYD7JO0b1HiB93Wusp4s5RM5KiH0lFOjzszx9F/Hke0c2zeTRlN?=
 =?us-ascii?Q?sIwbXPvjJ8TroTGFcAhZrglwJRVK5SqsvnGCPRI4l0Dw64qLpGVHnQJIxUeq?=
 =?us-ascii?Q?eANFGloqel9KYzjuUCS16CSP6uTSncAQTJgHY/wyiMuI6Qdl38B6Mq6L4DMF?=
 =?us-ascii?Q?cMSo+6MrrTTTLfrJwdjDBqDOM36+0obdkkDgXvAHmHQcWQpJ+YkzJnj2HS0y?=
 =?us-ascii?Q?qFLLqolbNjM2Aty75PsLfNRl8mRjwUb2lFnSynXhMxxuQrvfuDWuQsoDKX7S?=
 =?us-ascii?Q?XUiXrAqadv6uH4IwHi0+LwS71fJM+7CBXOkPTkLYBIdCXSt10f7TYa8t3R6E?=
 =?us-ascii?Q?k1oX/gNwmnhYiDpckDjJJNT4EW+H1SWhVQ4Br9q1is8RgAOXJsT2AuttTSZs?=
 =?us-ascii?Q?DhZVMD2AjB9xQahcq4S13T/BeFc9PKjv4nHOLQhSMNPfbyF2wWfif93Zgwn3?=
 =?us-ascii?Q?TPJes/Mh1yStYRH2EaQlxD1dNtiesemS7sg3sO1tg/V68OcmTiTkz25V9KH2?=
 =?us-ascii?Q?6AIpzmmsPqgdPOPnKqTsmIhzGg9ranlf9r2zyG4ICkcQnot+yAdvmc2OARTr?=
 =?us-ascii?Q?UmK+4oTJh/xmPXjj9pzzVxse7WboWRrn7ufDcXh17/cZhHmbBxF6JdUFiCF+?=
 =?us-ascii?Q?kk5bdmPJFBisrbFZSlEaG+hcEhbkcc23zmsGGhHSveKlMPVsh9cbd0ekaYWd?=
 =?us-ascii?Q?YClW97Yy16bJY0CnpBtlxjiFYu2Od+U5x2H6ei1ePy6S05KyDAHFrzn1SV7s?=
 =?us-ascii?Q?YubgPKFH7blMg6+uOb23qKUXH6t9SwEvCPtRNZmr64+KIwNx0/B3rwQJvozs?=
 =?us-ascii?Q?FY4YlQdPu6VLuvAISV5WZhEjsst7J/PuwaAouewAOpQzp8YMnG18DF5pZNTU?=
 =?us-ascii?Q?ppAyT2fLT1onolmv3PPDBoCzaCPAzsnL0ym2IJiI0NJElXSlyn7P/kjyhvjT?=
 =?us-ascii?Q?/b1aWgS0s/1NRF8nH3JHSwcOcBtODZ6bEyFlfc5yqqnMgM8CLq1uUdAxYWXv?=
 =?us-ascii?Q?S67TCYtt366aqMZRVCrcNE5/3bmxdALkFwIBXQ44dTkgq3JwiH3ROqk7FOl3?=
 =?us-ascii?Q?vG0q3DDnp8o035YF+/CyT/cOdeAcgcOdLr/0Tdz6pMhPU3xqBekQgQXilM8W?=
 =?us-ascii?Q?xNfXsHnLyseS0Ys7GqQ0hT/wIk79w8dOpM6I+dqDSHNj9IOwZE+0orNnxicp?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f387da75-28d4-4674-a0c4-08dbef5111e1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 13:59:27.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWUK2YOJTsREjVuNDJCpgdVnakGq0a6omEnk6IrOzLLo1ymnM2kOLH0L13INGxh07em3CpaCGFmjLkkW4erBcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6724
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



Hello,

kernel test robot noticed "kernel-selftests.net.fib_tests.sh.IPv4_rp_filter_tests.rp_filter_passes_loopback_packets.fail" on:

commit: e706cea62528a99bf2a6ea5e420b9726540dde39 ("[PATCH] net: sched: Fix an endian bug in tcf_proto_create")
url: https://github.com/intel-lab-lkp/linux/commits/Kunwu-Chan/net-sched-Fix-an-endian-bug-in-tcf_proto_create/20231117-173323
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git 18de1e517ed37ebaf33e771e46faf052e966e163
patch link: https://lore.kernel.org/all/20231117093110.1842011-1-chentao@kylinos.cn/
patch subject: [PATCH] net: sched: Fix an endian bug in tcf_proto_create

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: net



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


besides, we also noticed below tests failed upon this patch.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/group:
  lkp-csl-d01/kernel-selftests/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-bpf/gcc-12/net

commit:
  18de1e517ed37 ("gve: add gve_features_check()")
  e706cea62528a ("net: sched: Fix an endian bug in tcf_proto_create")

18de1e517ed37eba e706cea62528a99bf2a6ea5e420
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :10         100%          10:10    kernel-selftests.net.bareudp.sh.IPv4_packets_over_UDPv4.fail
           :10         100%          10:10    kernel-selftests.net.bareudp.sh.IPv4_packets_over_UDPv4_multiproto_mode.fail
           :10         100%          10:10    kernel-selftests.net.bareudp.sh.IPv4_packets_over_UDPv6.fail
           :10         100%          10:10    kernel-selftests.net.bareudp.sh.IPv4_packets_over_UDPv6_multiproto_mode.fail
           :10         100%          10:10    kernel-selftests.net.bareudp.sh.IPv6_packets_over_UDPv4.fail
           :10         100%          10:10    kernel-selftests.net.bareudp.sh.IPv6_packets_over_UDPv4_multiproto_mode.fail
           :10         100%          10:10    kernel-selftests.net.bareudp.sh.IPv6_packets_over_UDPv6.fail
           :10         100%          10:10    kernel-selftests.net.bareudp.sh.IPv6_packets_over_UDPv6_multiproto_mode.fail
           :10         100%          10:10    kernel-selftests.net.bareudp.sh.Unicast_MPLS_packets_over_UDPv4.fail
           :10         100%          10:10    kernel-selftests.net.bareudp.sh.Unicast_MPLS_packets_over_UDPv6.fail
           :10         100%          10:10    kernel-selftests.net.bareudp.sh.fail
           :10         100%          10:10    kernel-selftests.net.drop_monitor_tests.sh..Capturing_active_software_drops.fail
           :10         100%          10:10    kernel-selftests.net.drop_monitor_tests.sh.fail
           :10         100%          10:10    kernel-selftests.net.fib_tests.sh.IPv4_rp_filter_tests.rp_filter_passes_local_packets.fail
           :10         100%          10:10    kernel-selftests.net.fib_tests.sh.IPv4_rp_filter_tests.rp_filter_passes_loopback_packets.fail
           :10         100%          10:10    kernel-selftests.net.rtnetlink.sh.tc_htb_hierarchy.fail
           :10         100%          10:10    kernel-selftests.net.test_ingress_egress_chaining.sh.fail



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311271643.12f713c2-oliver.sang@intel.com



# timeout set to 1500
# selftests: net: bareudp.sh
# TEST: IPv4 packets over UDPv4                                       [FAIL]
# TEST: IPv4 packets over UDPv6                                       [FAIL]
# TEST: IPv6 packets over UDPv4                                       [FAIL]
# TEST: IPv6 packets over UDPv6                                       [FAIL]
# TEST: IPv4 packets over UDPv4 (multiproto mode)                     [FAIL]
# TEST: IPv6 packets over UDPv4 (multiproto mode)                     [FAIL]
# TEST: IPv4 packets over UDPv6 (multiproto mode)                     [FAIL]
# TEST: IPv6 packets over UDPv6 (multiproto mode)                     [FAIL]
# TEST: Unicast MPLS packets over UDPv4                               [FAIL]
# TEST: Unicast MPLS packets over UDPv6                               [FAIL]
# Some tests failed.
not ok 49 selftests: net: bareudp.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231127/202311271643.12f713c2-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

