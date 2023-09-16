Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727DB7A2E4C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 09:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbjIPHES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 03:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjIPHEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 03:04:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA9DB8;
        Sat, 16 Sep 2023 00:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694847843; x=1726383843;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PFXC0kuqaySgX/gh4jv3ZmhRqeuF6FjxS0bI+KGjuOk=;
  b=Pza328GxyOeF4Xa6jmtfZyVWv3VwjHlHAGRbaK7wiELR+AMT8r1fIby/
   Jq0GWlEerZRTufi8XcqB9ePQUfXS8HnXlapkHVm/9mvyqwifmzFWEgi6N
   mKyFdt3qHAiTVJ2g4RUdGV/1EN7iNbs0pB4xtVpgKcbbtHQX4POMvNlk/
   lQe3WNUILbnQ1XllIN3pZA70zRhIkP6L8fO6D7fGVcsbian/JpaKvG1J1
   BGXkZ6egGF30Z+EqoaK4SrHCRkHyzSt26AsDCJKcNQH93VJs6RzveiBA+
   mqU19jHV773Wz5GNBUKtm+LLNaO1G4zTiTYQP4824bfmmDe7gsoGZkIcf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369712710"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="369712710"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 00:04:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="774571383"
X-IronPort-AV: E=Sophos;i="6.02,151,1688454000"; 
   d="scan'208";a="774571383"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2023 00:04:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 16 Sep 2023 00:04:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 16 Sep 2023 00:04:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 16 Sep 2023 00:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2VdaXpQiUvJforvw5Hv342nEsOznsTb/m756DjUw05pxTUJVawzGPOxTCeOwhTZPLLyxQTvPtIUQeOLcHFB+SqYWu0qcZr4vsPhgS4Nbfv4txOCMb6WV9fYFBn3/bUor6Jx2sJ7C0g8f9y/u9JbZS50mo4uKYoOik963878IvD9c9zxeOO2P/RmAMeGEtGrfcb4vFoJc9W4ypud7fgJKXSrwx9x5NFUi+hqRrCAkKNPRth5pj/G41gk/5zErJ26V7n6SaA2a0+kXwpSWb/l4brQD0wyl5pnSLhWKNUcSmddyy7NE0Q+bymF6lR7VqEVab0xG129NN4WlnYfBLEFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3b1b2BsyJQSTxyN9jpF8lXz+wjELlgXsBLssH2fd4E=;
 b=Yyc7hsM5rlIqk/OUF+K6xoQ+/D7PsrKbleldMHigX/+L0XpHCwC5hN6EdiVzZAlX60Iffvw6SDwvkf6g6Bz7VUdGSX8lvqCfgZMuX4zNixbe/zG46A8XxLNvttoPsERQ8H2V6LVB9g9EfRRVm+L621H/JwFmnc559OjdgvwMmwD4ApMj373CYUpeL/ANrlHXqf9Eu2UBuRxLfaoNKOz1U+YylzM0hjb6SBilTTBxU5IBDI3BZeRpVZsZfZedh5kJ/JrUN4HNIdkNOOb/6uID4klTpUm93KxpKXqLTrTEIzxABKDVaraGfkAQvss/4MA5pNMOGQyqoGYedU9vS3uKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 07:03:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6768.029; Sat, 16 Sep 2023
 07:03:52 +0000
Date:   Sat, 16 Sep 2023 00:03:48 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH 3/3] tools/testing/cxl: Document test configurations
Message-ID: <650553545372e_d7cc829461@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
 <20230426-cxl-fixes-v1-3-870c4c8b463a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230426-cxl-fixes-v1-3-870c4c8b463a@intel.com>
X-ClientProxiedBy: MW4PR04CA0185.namprd04.prod.outlook.com
 (2603:10b6:303:86::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4845:EE_
X-MS-Office365-Filtering-Correlation-Id: 194b5bda-2e53-4b6f-f1d3-08dbb6831534
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1E6racT+Z8v+khLrUm7BJ6A/zZWCPXyQDyyfFev++lQa5Sm4UK/5o4xQPhbuAC9rRdeK/4nOW7l43mQICI/SlryUbsZO0ogy8+6M6AEjwwvV/jx0AYdDgDxggJxOAGHvThqBgBBT04FM75oVdK3YgQR2qgIabfN9z6s52Dk3gr92UEPfTncgiQRqxtwghnY61JrUuMO0W6xmoNl7KKFHDQdYOB0P8C3SoEzXmFgLAt082MWglhHikfSBV+3iecMTA6g5/4au714T1ajXmIqga7uyQbGEaff/z7sdd5VYTIGw+3OFiZUdcoWTc72oTJKYTavRlnndEf75/pVwCC/NzyhomT3M0x5a1eQTdx+cAPHWv6/zIeXtxvdvQgbMSYEQ9QTJ37n/RShyFeylxKug5SDvjvlNDVWetpabhK+14G8R22HQBfDaSS4ikC2oTvdyckMRj+PNoz3wN2sNG8VfPTwKvDSw5sHrs/jFqJmmQJPcYZcRJOu5man0n0O8zR+P7mcx51iUi21tVerH9ufUdircm5CG0CdAaswFP6TE9iM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(9686003)(6512007)(966005)(478600001)(83380400001)(26005)(107886003)(2906002)(66476007)(66556008)(66946007)(316002)(110136005)(4326008)(8676002)(5660300002)(8936002)(41300700001)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u7qTQFM3g7uYXTw1W2sW/1RkqcfW37MCzpo67oto+OEah44FZ/UEHRJbIyGX?=
 =?us-ascii?Q?nkIxk3yLmeWcLvs/C3T9vlrtAJUqs00wR3c/GJyF95jbGMKCWnV9NfP4Iat5?=
 =?us-ascii?Q?z2zp/dMVRqlDKcZQOsY6B0+dp8tzFjqoH1fUiGT4nVWzUePMpVak1VqPWquT?=
 =?us-ascii?Q?zK2VtWr69tYIagJ2IaFx61fy9G2tidRhRyislyNrOIgY9xrJsrMWTqhKH5gD?=
 =?us-ascii?Q?yChIOkH4IgtXxAav9xtM3S/bgkufbH+GaEl5ynz0nI2582MrUKZ6M9OiKQSM?=
 =?us-ascii?Q?qQNNEIzBrEvoGIfPqJr0IDNc7mn6UXMEXjrS+V7jrAx101DCdtEfX3Gl5eUr?=
 =?us-ascii?Q?YPxiPemSon4ehm1XHo5eWCBhekXDjAhS3cnyEjDUr7A4EfY1c2IILjYVO2wE?=
 =?us-ascii?Q?4T8wzCyDsoxgb7Vpwmd0SO6AUDABVhvJWHpFhFkII/Sn/PMcEiWRB5WsrQtL?=
 =?us-ascii?Q?3p81QG16zmVUInTqGqShr8saakrM52rQpJLc7XoAvmqVU4atc73CL/2wy5F1?=
 =?us-ascii?Q?ZC4q/ZaxO7MIaFlXkWUVycVFLPkmz89uuz7HkTYWQJL+o3bOlw/KMlF1c6Pr?=
 =?us-ascii?Q?54ARDNuZLXTUceEz2CfopI35HlBOpFZ4tpNvwlLcTi1pkdSkXP/6jONYLqCI?=
 =?us-ascii?Q?x9V+L0b0KlfaOod5rJ8aq9AA8XoP6sjyNpr3E61ewkAWq9bPAtqbtFE28dpU?=
 =?us-ascii?Q?6+Kcz9JDCD2haPMTH5h7Rb3P80NbwV1el950dmqk2pZw9z0TrHL73rox3p/Y?=
 =?us-ascii?Q?e2IQNyVdmYNPolFFflwiC6Ejie3FCW0HjEsOjQeYM3qs6lczj/qTP3vhoka/?=
 =?us-ascii?Q?CkmJPO+jQbgMNP5Kgqk/dmrki4NmhWZohvoohHiOznZb1RUN5hIqf0sLRHpp?=
 =?us-ascii?Q?aIyL+i9fdpN/LiVTgtF7dNoogkGHltYQs5gbXNJfqdj6MNnScg87XyOk/CU2?=
 =?us-ascii?Q?U0YiAF1NBzRw+OoYaqn959bGf/2crPjh8J1KK2MorDI6knvR2ffk6xTBhMRD?=
 =?us-ascii?Q?LLm/vdCh8d3uvLZpiQB+7+72iSVduUEg6iofo+yFD7NuKZU+XVpT1zYNYKjd?=
 =?us-ascii?Q?uD6F3Mr1MdC5wvsMHDnIKHlvVNg5kueupC/yZ8a8jXOEJbsjuH5dnOCp6iH3?=
 =?us-ascii?Q?hWXNGueh69DQ3kLM+98clP/L1+XVZTJCICO9hYIAU3pIlAokpW2Jy9OEOp2l?=
 =?us-ascii?Q?2nZ8yige2SApcuE1N3fxLu2uQTq+qlAh5AB4tRAOLIngBpYGSaDhRZBa1ewB?=
 =?us-ascii?Q?Q9vdpEdiG0gOT3C41tU9WJsTyRxWBzOLleUTCXcJyLC0WJ2Ap7zRYx70y3C4?=
 =?us-ascii?Q?LrgLociIAKO/nYAZQhEXY5QF0UkiUpwPHmlnzKbZWz6IbldIGybHPNuExffk?=
 =?us-ascii?Q?rhdmyFirIYhvUBROhBySreTiAmZxu9DfQGLVOZqNMiKmBeOe9wShoPIVj/PG?=
 =?us-ascii?Q?uTQ8nre9/BJixN+IbEydXeL/vAtlcIL2c16kXXltSFjebMJTt+ne9XciyeUQ?=
 =?us-ascii?Q?fc5lbi/xdXN7TjgFSdW/4K4ntIY9zrPdSHAPFcprXMrlFaa3tEPFiHocqHXW?=
 =?us-ascii?Q?z57TCAITtqqJkxUlLBGibNAG7LQW2N/1w9IHm7m3k19TJH1bebk0UqaOx/7G?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 194b5bda-2e53-4b6f-f1d3-08dbb6831534
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 07:03:51.7682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRRrBdE1sukkeb6X0384cbzU/45J0S9wRqc7FkDoE2PaNC6SR6hOG1DOPHBlmc8bx9wX7pNZXOsB/ndk5DqyyrEljwFqWuAjEYZB5suqnOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4845
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

Ira Weiny wrote:
> The devices created, their relationship, and intended testing purpose is
> not extremely clear, especially for those unfamiliar with cxl-test.
> 
> Document the purpose of each hierarchy.  Add ASCII art to show the
> relationship of devices.  Group the device declarations together based
> on the hierarchies.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index bf00dc52fe96..bd38a5fb60ae 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -23,6 +23,31 @@ static int interleave_arithmetic;
>  #define NR_CXL_PORT_DECODERS 8
>  #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
>  
> +/*
> + * Interleave testing
> + *
> + *             +---------------+                            +---------------+
> + *             | host_bridge[0]|                            | host_bridge[1]|
> + *             +-/---------\---+                            +--/---------\--+
> + *             /-           -\                               /-           -\
> + *           /-               -\                           /-               -\
> + *   +-------------+         +-------------+       +-------------+      +-------------+
> + *   |root_port[0] |         |root_port[1] |       |root_port[2] |      |root_port[3] |
> + *   +------|------+         +------|------+       +------|------+      +------|------+
> + *          |                       |                     |                    |
> + *  +-------|-------+       +-------|-------+     +-------|-------+    +-------|-------+
> + *  |switch_uport[0]|       |switch_uport[1]|     |switch_uport[2]|    |switch_uport[3]|
> + *  +---|-------|---+       +---/-------|---+     +---/-------|---+    +---|-------\---+
> + *      |       \              /        \            /        \            /        \
> + * +----|----++--|------++---------++----|----++---------++----|----++----|----++---------+
> + * |switch   ||switch   ||switch   ||switch   ||switch   ||switch   ||switch   ||switch   |
> + * |_dport[0]||_dport[1]||_dport[2]||_dport[3]||_dport[4]||_dport[5]||_dport[6]||_dport[7]|
> + * +----|----++--|------++----|----++----|----++----|----++----|----++----|----++----|----+
> + *      |        |            |          |          |          |          |          |
> + *  +---|--+   +-|----+   +---|--+   +---|--+    +--|---+  +---|--+   +---|--+   +---|--+
> + *  |mem[0]|   |mem[1]|   |mem[2]|   |mem[3]|    |mem[4]|  |mem[5]|   |mem[6]|   |mem[7]|
> + *  +------+   +------+   +------+   +------+    +------+  +------+   +------+   +------+
> + */

Circling back to merge this I realize that the numbering is off. For
example a snippet from "cxl list -BPT -b cxl_test"

    "ports:root3":[
      {
        "port":"port5",
        "host":"cxl_host_bridge.1",
        "depth":1,
        "nr_dports":2,
        "dports":[
          {
            "dport":"cxl_root_port.1",
            "id":1
          },
          {
            "dport":"cxl_root_port.3",
            "id":3
          }
        ],

This is due to the modulo math at setup time. I only noticed this
because I wanted a diagram to refer to when doing some recent
extensions.

I wonder if we could just use "cxl list" to maintain this diagram, or
maybe circle back and use this to keep an image up to date on a web page
somewhere:

https://lore.kernel.org/linux-cxl/cover.1660895649.git.sunfishho12@gmail.com/
