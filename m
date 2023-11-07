Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6D87E32C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 03:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjKGCAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 21:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGCAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 21:00:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AAA115;
        Mon,  6 Nov 2023 18:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699322435; x=1730858435;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DNcWFlgWFVNRGva6aSrz0MmPCTB+PaUMaMiPwbUwwyg=;
  b=exYHTHSkNLnOoBAhOV71CZBuiTn59+C5Iu9Zm2AJ5v5FaYIB4E+k6kWK
   Pw6+0VRugBJtdfusz62G1YYJkNHR0jFkHSyiECTQce6J2t1MlK5XOFQN7
   kXE3wg6IQcCxytIud/QSnRygFF04PmqBUuupDJunW23CCA+RR9NUcUiin
   os0T03sN2npcFWbGf62oY0ahQs28yi7bq3LDW/K8N0WUdRv0fsWYISQOk
   je1U3HsArUAZXct3yaoq19uVwLMm6OiP79pTYzu2B49nT5JmXLebk2XY8
   BAZN4PUmmcXKc3qKXbWDIkMNTPtBXuzZBd7Ndn8TTWou4rMkYIVLLIwXa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="393300955"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="393300955"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 18:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="738959725"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="738959725"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 18:00:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 18:00:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 18:00:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 18:00:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8CY88JHak0fSoErQsiDNvxzPP2ZdhsZAFPr+216yWMbb82mEx0j2+Lb8LQs2s5qqgjPoylyljaqWm/iKy7UWOeMZNjuSXwFO9zQQFMneGGYD+vyOmv50d7OJYKYB8d/Og0vhueSftGnRaH62pAeDso+XRaigN+FOVq0VcohvNN8u+hzija3JUEJqcOqsIwgYnpzAIaRawo3jvFShXS9ja3YWez4X0Dmv5WEG5ez5in4SY6Kc2MOk/dAP8ax7aFkN8cqOQSpOP4+GcfPCcNvvHU/5X2cHk+ChZg/NWlbouTXkzV50Cwo6zSgjBB8wVe2Be076dS5dXUDSvgKO796pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3bq91FDhwzU+hIWI/9b0n0Xc1vTKtRHKqLUndSeOD8=;
 b=oBk2icVlwqtEWmD1+NX5+BkFylIbgs+WFZnCl81ZgyV8JaKfC0IdGVrl/IoSt+YSZTo/Lj07R751EsX4u5kyMI5uD0anjzPA2X0zZVC7nj9TGfDC5ByCJGuDtomaESL5jHKuXpBant2wS6RYwwWiQLid8CikY6uI3y6uCl2E3rCKpzLOLiuiDWXLG4H3roktiqy3Hr6ZLos381NTZidw5z9WC+BFfjL4tINf/64vibnHZ0zF9pmBpL5AwIu2Yl+p70owAg0FHMkE1ENek2YDfPGzm2yzPzI+rd7XVkbTkSOXhXGpiVsnlhU+mAWp4EsZlZ5SFjiq4U3P6Wts5+gkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS0PR11MB7902.namprd11.prod.outlook.com (2603:10b6:8:f6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Tue, 7 Nov 2023 02:00:32 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 02:00:32 +0000
Date:   Tue, 7 Nov 2023 10:00:25 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Daniel Mendes <dmendes@redhat.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <oliver.sang@intel.com>
Subject: [linus:master] [kselftest]  9c2a19f715:
 kernel-selftests.net.rtnetlink.sh.gretap.fail
Message-ID: <202311061651.88994df5-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS0PR11MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 840b275a-81ea-40e8-53fc-08dbdf3552f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yneEYO6FIyy9E06+I8KjZqFSJpebuDkn8ibf1kTAKLrdbYHf2L+guUHmSXFCl7bw5jxx062AMzOtm6eu6ZdrX60HLb3BekjHI1kt2iPZdMj4XJiFbMud52gRJixLelKyt+sviyJ9/hL1beG9ghwpTbtCqYTVdvL45OkwEpel8VeuY220mjcxDpd41DNPIyK9zEtoGUR4nWX1Ip2jAirE8ETTUj1ufSgiNYDDDLV4AL17R+Rcs8QI/TT7bLllpFrt52wHYlF7465KfIdToQxVv8vas11XBTEdPgYngB3TWl6enagvbXajBJrpZqS2CaDHnP1ApdzXbowvqPlWMPLR8IsON1DTkWWkQsz6YLPSLF6TSYAjoL2dXctXujDXf+0JjRCoa2tJM1Pre6lmWHkfkpcAHFbPunL6OWWvguVwnvEJOyTNFX3uDnL5g40m/H2M7BuHOO5uQGtuJ0zEahhIgXzZh0Qe7b3H6TpR2AUhek3IIpHPBKXvsOHgnMnA91WzjuZlxYtF+zEm+H6RuvwKAPUxFRvhuH6wJR1ocL0ND3IjNqWpijljnqA0t/2V8R2JoJkfchkLLyIvZ+gi9BCC4L5ihNvYfoo0z5gG7LuzEcWdTnrZtaQKr2lOI17u2JwiMQ2vXRDMGD7Indx/r26Sqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6666004)(6506007)(6512007)(2616005)(966005)(6486002)(478600001)(26005)(107886003)(1076003)(2906002)(41300700001)(5660300002)(66946007)(66556008)(66476007)(6916009)(316002)(4326008)(8676002)(8936002)(83380400001)(38100700002)(36756003)(86362001)(82960400001)(568244002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8mW3zIR+k4nWEby8LeeH6PoUfqKATta0XXQs7xP2GykFqR/zLTaXmVxLiz1R?=
 =?us-ascii?Q?/ZO3zsmULJj+nUGBS9n7ed7Ifu/PWEUrVF9VXcIhsrwZiOqCQEmXHVn4z9+q?=
 =?us-ascii?Q?hyEcAc8cie5lLPyy9p1ZWP9zlsdSn2Fe+AVxEqUTAMlPxFozQ6iaZlwdyWuv?=
 =?us-ascii?Q?GvnkdmSab4jV6D0e1soir2+J5b962pOyjum0l0vzqGWErCn4wIe75GPs0Ppc?=
 =?us-ascii?Q?a8FknC4rck1j1vnTEWnwUOrPu5yR6yR2Ypm6Ni+rEYm/MPODrTsGJZMUpE5x?=
 =?us-ascii?Q?v5OCnxxNAROGcThTxzJ90bsLBL6ZZBPHP2vU8mIgwhGJ5JoY5O2NGn8nGL2l?=
 =?us-ascii?Q?h28nvnG5uq8jevqYi31rRjb0ESpGXft1psjklT1mr05gVu5Maeu3GjUrRfyC?=
 =?us-ascii?Q?QiOerIZD5meJ2cHkofjF1qQzqnv4Oi4WSO2W8DLFVaKpnT66yyByhUri3K8x?=
 =?us-ascii?Q?aq1vz9hOs+BXbitMdZEsXeMzCV7Bo5LFpKJhz/wZ6+9LAl/p85DBqkQU0OLx?=
 =?us-ascii?Q?uib6yG0KvAtc09KOUF5aq58As+AiBOKYO9MApySZ+RG7H6+BE6ez8E+93bVD?=
 =?us-ascii?Q?j1OxqPJs5vLV6ZzwuQOPmbmgMiaku7rWfmLR85qXQAlxhcXiIY+NLTnuV8gt?=
 =?us-ascii?Q?cr8sNtvKLV7l0uWsCFU30mVeKwDZXshtwl//t889dVjAE7jsn4xquN2mqMSX?=
 =?us-ascii?Q?eX6JflYAbJEJkoIbBK5HgJ8VTVMQbQ9/+/G/C00j2/y/vt1yUyN3HozRjLhK?=
 =?us-ascii?Q?XXCJlcYKIU/lx4sNv+HZigf8OwWbSpsr1fX4Z/xH9NdjHS9WTYcGvthGKCaT?=
 =?us-ascii?Q?3buh+Jsz8SWG/A2XtRfjJ3qWG0QLq1zDn0wO3AKOvDyHXHZpkdmzZpILJdzK?=
 =?us-ascii?Q?GwCfZAymnGE+ncSxvKKq8icI1DWHdYTvZiGbHS472La0mU1l9GODA24Bx3Si?=
 =?us-ascii?Q?Eg8YOmNhhaoGcEAhGCxysRmd2y7TPSZTEjJaGmI3hffS9ZtNguyjlCWDuym5?=
 =?us-ascii?Q?vxEtH97klZ0CmMe+UtPDAv5A6bzXIo4R/rSqknrHZTVk3o8IziRneqYZw7so?=
 =?us-ascii?Q?hbD5j3qocUSWX3PYEeVoQ1DbUYf8oc/KK2rNtmfE+dJqrqVSRje2BiFKX28L?=
 =?us-ascii?Q?paUivYXU3f0VIuuFDP5aEjXLWkVuhDTCAuLqfdXU6GbFRfTJxgrIZ4p0CuY4?=
 =?us-ascii?Q?+N/9dLppLdSQEtfAYdt0jB0dcWds00zXAcmz+Q3ZzS55ctQTAzcGi0kltBoW?=
 =?us-ascii?Q?mF3xYEhLXEDbtjsNHm49a4YL0U2R7ArBjaA7kavnIZB8geeMJOhKTH5MQcvJ?=
 =?us-ascii?Q?nQLPW//lvRebvucPOrADvhDEzIEATBEqUxQp/q+zrwGyLk5/CyX2FyofAcih?=
 =?us-ascii?Q?wy0vdCfqj0LXY4bCAgEna6tFcIgmdVEImAcUdhsEQHIOaxrJTAs1wvWvTGYl?=
 =?us-ascii?Q?uyPaqBmpx04vCrWE0dconM/h+QJJguQPEZ61DdAgz9lkvk/ZLNqq5s+81bnd?=
 =?us-ascii?Q?uWaVmzOgdMncDvzkO4zXzslU3OhvmuCkteswCeBIcIvYyKbicB00abbRLZqQ?=
 =?us-ascii?Q?bhmDONFxK5qWRthfAC2++Jwpu4gg7MwCQ4Pa0r1j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 840b275a-81ea-40e8-53fc-08dbdf3552f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 02:00:32.3695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edFT9qJdIczhE2Eld8l5vLoHiDqni1cRTG/UihG/T7DuSstiaQWkv/2lTiGBwXbemgkqjfRR/NTce9leqPwfxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7902
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi, Daniel Mendes,

we reported
"[linux-next:master] [kselftest]  9c2a19f715: kernel-selftests.net.rtnetlink.sh.gretap.fail"
in
https://lore.kernel.org/all/202310112125.c5889283-oliver.sang@intel.com/
when this commit is in linux-next/master

now we noticed the commit was merged into mainline. and we still saw the same
issue in our tests. just FYI.


Hello,

kernel test robot noticed "kernel-selftests.net.rtnetlink.sh.gretap.fail" on:

commit: 9c2a19f71515553a874e2bf31655ac2264a66e37 ("kselftest: rtnetlink.sh: add verbose flag")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 2c40c1c6adab90ee4660caf03722b3a3ec67767b]
[test failed on linux-next/master e27090b1413ff236ca1aec26d6b022149115de2c]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: net



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311061651.88994df5-oliver.sang@intel.com



....

# timeout set to 1500
# selftests: net: rtnetlink.sh
# PASS: policy routing
# PASS: route get
# PASS: preferred_lft addresses have expired
# PASS: promote_secondaries complete
# PASS: tc htb hierarchy
# PASS: gre tunnel endpoint
# FAIL: gretap
# PASS: ip6gretap
# PASS: erspan
# PASS: ip6erspan
# PASS: bridge setup
# PASS: ipv6 addrlabel
# PASS: set ifalias f007c594-8cc4-4bfa-bf82-fef2dfb81ad2 for test-dummy0
# PASS: vrf
# PASS: macsec
# PASS: macsec_offload
# PASS: ipsec
# PASS: ipsec_offload
# PASS: bridge fdb get
# PASS: neigh get
# PASS: bridge_parent_id
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: ipv4: Address not found.
# Error: ipv4: Address not found.
# FAIL: address proto IPv4
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "local" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: either "dev" is duplicate, or "proto" is a garbage.
# Error: ipv6: address not found.
# Error: ipv6: address not found.
# FAIL: address proto IPv6
not ok 15 selftests: net: rtnetlink.sh # exit=1

....



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231106/202311061651.88994df5-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

