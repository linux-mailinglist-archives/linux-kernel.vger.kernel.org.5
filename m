Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F2578DF44
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjH3TG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbjH3NKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:10:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65647185;
        Wed, 30 Aug 2023 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693401018; x=1724937018;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BkLjbfNddBdA+VTbfcfguIOODYix90vrGRBj42pcbUc=;
  b=cK2ZUAUdp6A2tt1XHW9OXUWS1u41PPrOYFkJvweZwAh6r4iUJQ1+9+oV
   BA7rYhYiK4ewp869RcSc7EPTK1RgxazEUsjapQF8BSin9SJfeCfHcPWn/
   4kp5dgFkttOl/OFxXBtL0wUM+EURf9t0Blac39Ntw8Px3N2dhZu8IjGwD
   NgTE/D62sfd91OVpTFE/rTOG15QBc2BwslQ3hBHXYwheniTTXiTfHxm+U
   gb7nxoDkhs09dYRdMliBlOSUlMLlZ/4LQhY5y4kG0yp8E9v2TkQ0rtHvE
   C4lQOUsizPFvKZnuqjstrluPzqUNbZXCcdqn1HIYOLif3sN0/7g5VdmOu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355951137"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="355951137"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 06:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="1069839674"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="1069839674"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2023 06:08:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 06:08:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 06:08:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 06:08:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 06:08:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctv3R+1VxUGhtI7NuGxqpklemBa3JQ/sYNtcrSvRliEt79nGSE2V+xO1ueSFCWWfebSV8dqqdZdKOCbonLzJ1CzFSXGnJ3pJhy4vQxjGMne+/AiYYL+wNdtGWavO3jEBw9MXyCZ1QBdHN4DdmF1U4FlndiEuhG7oE6Bitte5Uvi7FW1oWPAd3LYkAHO3WedMKUvyDDngLVatHmNUl/sDVeXJ+vj6RP68gX54o3M2g18iSAjijBCn1xJUpDuJAAeF0EwYkvGO/H3lP6V76DppMw3RByIPP5SZQli72ZTZi7FadyghC+sBPvGCf6nGmHFZ8523qjvaONOW7679fEyUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kWwm1qRHKL9yPcki6Ee+cXdXCT1u2SuC5HXAkTax5s=;
 b=En8df4XWnI32vbbTkRahV+yjGx3fKCC5vNT5xJHG0YSvhZPKH+c6H/DuTGGD7tdSrx7arcvF8VTVUOMt7oLwWHk0iJNOQGWuk7vEgqGnxwBru67Q25XYeX7s/4LWkj66OzZI3WEkmIY1CTHXSZKWclCKbqL67OiyqzJmAxEzg6eaT//BDq7XOWKsuZcarYh2IoGrM5I0oYWIjvSd0KU+lVgco19q3pcEMClQfmPzuanYiMjC6j+amWqqGkDxQAb6/d41pPChA5zPag/AD6xrrQlr1jfbOaMHDnA69aV0Mj2GtN+Q1ezVkX36mjIT4qWfCVLL9Z3zt6rrxcH/LFm2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 DM4PR11MB6167.namprd11.prod.outlook.com (2603:10b6:8:ac::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18; Wed, 30 Aug 2023 13:08:49 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::8a29:8895:64:8fd7]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::8a29:8895:64:8fd7%5]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 13:08:48 +0000
Date:   Wed, 30 Aug 2023 15:08:33 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Message-ID: <frfa3olxop3xjnouvvv7y2s36varmto5qwhmkitvslmiawzwkd@zh2jhob4o5qe>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-9-tony.luck@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829234426.64421-9-tony.luck@intel.com>
X-ClientProxiedBy: BE1P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::20) To DM4PR11MB6239.namprd11.prod.outlook.com
 (2603:10b6:8:a7::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6239:EE_|DM4PR11MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb24fd1-3975-40e3-f5d7-08dba95a3fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwu9CNHzoO12Vr+LpHwuewCylmcHysljE8OyLlPevez5AM8nQLYw1uzwgfuKbQmQLAjWNVgOLxZMSoUI8uzg974V7J2KJiv92PSCxPYxbghxjC56/lrrUvu/6z/rMhWKnozEBld901WGuzpHm0P2Jb67photzVzzwMh/Nq/DPhFLBqHCSJA2c+h+0k2OS+cgDYm0N5ERK6kmVtLRBJycx8tWher6z83RSZaBNghDEp2tPO85vgGHrb5RLM2JSOlSzbdcusodlfju5mbdr5RVaNa5uE5wmOf5G1spuJHhjgRcogZHSojZSPWklW5gM2zh61u0zJQxrnR4Cjt+fIWknSTdkmKyxgduAMkUjCOZlG5cBGKAWjvflZrJRcQ/D0l8DqU+eT6sMEwJWBJyzZxm7EQyguhwcWkRykr2WNAsRLAZoHrx+7gME5x52PrTxLiK1gAe0+hMzY9VJdp9AXvYDgIvNoZjiZlLV9XrCgIpftNZJaewd+mfVydsWNb9dTDID9tEeol2V5D383D5QBfrR0CYmVnfq5gpZuDLOauoh53G1dQXJhGyTegYGFy9W1ow
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(136003)(376002)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(53546011)(478600001)(6506007)(66556008)(66946007)(66476007)(54906003)(6486002)(6636002)(316002)(38100700002)(41300700001)(82960400001)(9686003)(6512007)(8676002)(5660300002)(83380400001)(2906002)(33716001)(86362001)(26005)(66574015)(7416002)(4326008)(6862004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+6CZ4zSdZHBeSwDUMb82AK/UQro5tD1CT8pPIYnbZjnKzQDAA+eDHlRTU8?=
 =?iso-8859-1?Q?u6uVouXwV+yX2GJJcmkvlr9lvoPsjqNp36t1/B7Vu2HXkrFRP5A5eHW/pY?=
 =?iso-8859-1?Q?qA15GczFXSYGCeOBCNWAcHpNmYRG8G/tjmydiAw0pXcDvO4LTIHS2ZaQOI?=
 =?iso-8859-1?Q?SWGo3Nnfc16oTNvt6IPrjP82hrbbKwM4JS00dsNhfNa5iNJDiyGtF4rAeW?=
 =?iso-8859-1?Q?SJ22bjCJShXpQaNGh0mogRULvMdsrDbBC2tbst6BgKcTpcWneObETLIz8P?=
 =?iso-8859-1?Q?46kG/FMs8lwiX0wAShVlIfY6SGHlOediDFt9l1JOvdUdEhvFd69fGEXkpa?=
 =?iso-8859-1?Q?2URjznx2WT8Zt+f17lyPC3Zz/m6SSuq5prjQNuRJvRFs9Px/etvjGFu0NK?=
 =?iso-8859-1?Q?bCQplRHsXK9Jl7tkC0nmxjt5DvXkmEVgFgS2whBXAMIFEdi5XGTVKTScmQ?=
 =?iso-8859-1?Q?K8gqh7ro87lcrYKwj6E+mNQqSNeFAHXWZE0U2kK3rRUm/0VNE30fL60Tkb?=
 =?iso-8859-1?Q?0ADAFBM/jAZ+jkr0lc92b7wrfNTN4YksBWORrAW2a+E47xl/ly/G2wunEk?=
 =?iso-8859-1?Q?103kg0SOc9wTXKqPxP+WkOiZUyG4WKS+IquqUNfnU8mxVsWPY5CcfQ8OGu?=
 =?iso-8859-1?Q?Hm+iXPsum5IEVAlpDWXjLkKwIaSzhXC1Qx/MoSN0uXHs5uWjZz+teJ3/jo?=
 =?iso-8859-1?Q?qYixyCNvyKK+KfNzaYZZ/OkD9kDICmUJ+bQt8y9MQlP0G9tQdzrtsZLRjL?=
 =?iso-8859-1?Q?JmZpjg/9TeuMAAzraRjEj2mQOg9pJ7HPhamUxWfOtW3AIsaHwbAEqkSMkY?=
 =?iso-8859-1?Q?aKwrMgGZ+07YdPwxBM2vaDQPkpU/PaOZ9c4qs8rb9aiiSAQ4OJCSrd+rPM?=
 =?iso-8859-1?Q?xBH3POEX95YWeJZUV3+YUCwmde+c4n283NoRnlYL6QhCiwg8Jmvi2g1zEX?=
 =?iso-8859-1?Q?YJ78eSJ+EZ1GdRW77v7zxXvgWZ2aYXnZI2ixWXeBEsd+LJzTknqbokBBto?=
 =?iso-8859-1?Q?xnoW4sjioLzRAs7fnPud/qVkSCudBfxdxnKihq/mpYp0vjgk6wtt0WwCXS?=
 =?iso-8859-1?Q?D03HEgzMYV0uJ3yjETrV6aaZ5Y7uRhoz9iiVMIVS16EWY55xYgQtjqm3JD?=
 =?iso-8859-1?Q?QKwAnI/EKWLlNZqNwaLYyHqXs7VCWo7cmpxGzWa9Prfgb0FFVqWOqr3VpF?=
 =?iso-8859-1?Q?vq1IyXfb0iZN8bMzTHEIW/vTSkk+U9s4kQLPkdHYLfDmh5ZPKwdS7e1ZAt?=
 =?iso-8859-1?Q?vYPk+a15E+4UzeRPT6nLdktWPl1cbv1GIdBExJGi2RZbJWpRP6xCqkAuym?=
 =?iso-8859-1?Q?/qop/PMmJIS0yyyWuNv4EyhLNpNbtIFlc3OvxKvBG+sgiXLWqCBX48uFP/?=
 =?iso-8859-1?Q?G38zB8E5a9P3gJSYOxjgBYKMv9REfPRPe47gWxi5WPQKNWMimq2LQI8AAD?=
 =?iso-8859-1?Q?muT/1s0eKq/6PkzorOURiU4Ob0FwNihUT152yuFc2N3GYFZtWCzCqFHwIi?=
 =?iso-8859-1?Q?FD8WB25SGQnTVqdWHJ2Rjj8NYVSLxMHt4VriJQ9FkMTuLbpCrJM6NHi6+8?=
 =?iso-8859-1?Q?hpgRUt4gecRNOK+HqLgtEDXvvVC/5Z5zv/aFjCSij9DBrqFR95VEcb0kgW?=
 =?iso-8859-1?Q?BJ+GExd674R7ehxroYhCCyGZ7WB/3OgZtNOFxHrwUZ815EAcvh0KdmXeni?=
 =?iso-8859-1?Q?xFxLBvZPO6G3MDungFE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb24fd1-3975-40e3-f5d7-08dba95a3fb1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:08:48.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZs+ymX2hfD5vupYwIfIXlAszhfndTo7oc6bb765nvc0BzKYefgMN7L5ghcJ+Zz5z/CIAzrdRfDq7e5l8nUVesBFoVM/UDXM+9HQye0mjZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6167
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

On 2023-08-29 at 16:44:26 -0700, Tony Luck wrote:
>Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
>nodes. Systems may support splitting into either two or four nodes.
>
>When SNC mode is enabled the effective amount of L3 cache available
>for allocation is divided by the number of nodes per L3.
>
>Detect which SNC mode is active by comparing the number of CPUs
>that share a cache with CPU0, with the number of CPUs on node0.
>
>This gives some hope of tests passing. But additional test
>infrastructure changes are needed to bind tests to nodes and
>guarantee memory allocation from the local node.
>
>Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
>Signed-off-by: Tony Luck <tony.luck@intel.com>
>---
> tools/testing/selftests/resctrl/resctrl.h   |  1 +
> tools/testing/selftests/resctrl/resctrlfs.c | 57 +++++++++++++++++++++
> 2 files changed, 58 insertions(+)
>
>diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>index 87e39456dee0..a8b43210b573 100644
>--- a/tools/testing/selftests/resctrl/resctrl.h
>+++ b/tools/testing/selftests/resctrl/resctrl.h
>@@ -13,6 +13,7 @@
> #include <signal.h>
> #include <dirent.h>
> #include <stdbool.h>
>+#include <ctype.h>
> #include <sys/stat.h>
> #include <sys/ioctl.h>
> #include <sys/mount.h>
>diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>index fb00245dee92..79eecbf9f863 100644
>--- a/tools/testing/selftests/resctrl/resctrlfs.c
>+++ b/tools/testing/selftests/resctrl/resctrlfs.c
>@@ -130,6 +130,61 @@ int get_resource_id(int cpu_no, int *resource_id)
> 	return 0;
> }
> 
>+/*
>+ * Count number of CPUs in a /sys bit map
>+ */
>+static int count_sys_bitmap_bits(char *name)
>+{
>+	FILE *fp = fopen(name, "r");
>+	int count = 0, c;
>+
>+	if (!fp)
>+		return 0;
>+
>+	while ((c = fgetc(fp)) != EOF) {
>+		if (!isxdigit(c))
>+			continue;
>+		switch (c) {
>+		case 'f':
>+			count++;
>+		case '7': case 'b': case 'd': case 'e':
>+			count++;
>+		case '3': case '5': case '6': case '9': case 'a': case 'c':
>+			count++;
>+		case '1': case '2': case '4': case '8':
>+			count++;
>+		}
>+	}
>+	fclose(fp);
>+
>+	return count;
>+}
>+

The resctrl selftest has a function for counting bits, could it be used
here instead of the switch statement like this for example?

count = count_bits(c);

Or is there some reason this wouldn't be a good fit here?

-- 
Kind regards
Maciej Wieczór-Retman
