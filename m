Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B2780BEA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 02:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjLKA73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 19:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKA72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 19:59:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F68893;
        Sun, 10 Dec 2023 16:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702256374; x=1733792374;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=DptRpPVENUrsalxTr0LU6isz+htKwFZYAoXTevLgJko=;
  b=BccNz4vPZNQWFh3SktHhr9Or7zX6pWSOQO6SV88w6WXtRTyEbq2RUY15
   TFNfGypr680HYvT339ssV2F+C0HTuh4CHIaLcN3q2FMj966X6xt/cPvmY
   OTuHSyGurCwuwr9GG+7g5vlxAt+R3Ced6dx4JZ2tSJmwDY/6rw73vaYTU
   G4EeaLixyYFdWGWmNVaZB16xq/HJ6cCO6IE14I+F4R7DZkXeLo+JWNkDW
   kiSLdiLk4pcR15A4F8Nxcv6Hom/gWi09TD3p9FWkK24TrCZAT/Hn7MA1F
   0CmErVe5VWEj3ljJFUf3NZDMY1vQ7i/CYUsSkAeRP5hllEvzYyJKzlhsQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="393442685"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="393442685"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 16:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="863572597"
X-IronPort-AV: E=Sophos;i="6.04,266,1695711600"; 
   d="scan'208";a="863572597"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2023 16:59:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 16:59:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 16:59:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 16:59:32 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 16:59:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OS18WYJLWUXozCceiltSpiGaolkg6oVkEUf/fNAqO8q7sTrOBmqOP1C0VkH2OyRMGqX5hDJ4D6p8KfKLRAcea3PQEwbjxtRYp1IJIjnXFO6i2PIT/14bRXqT3ShZqsPiNju9YY0iIRh+vtVTzELhLx9xQnYwPs2ZDif5z8iiNzXh9TDe9aimQRqdjcoHJAs7tMsS24ixXhr8U64A6+i/V03tuXJ/vGshXMqJC+i12xAvsSUWA22EbUbS5hPJtdvM99Eeg/o9V67D7gKaX6/SCc7Psugu9JxY51jGXvYNb2rGb1ehUuDQmSd2L9/P5UIrHJr+bAUee23+ApWMerQs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZdSiQVdb3gXYGU3OTiUArblt3dMS8neOnYep1PXkhI=;
 b=cNSfMkIrF/teeMgOd7lfFyv+6FNCRZ6i9mQUWojp7YnSocUlcANoY5eZ8zPwiomrB4dG3pGVDYKXJ71F1xFKTLMD+Vu/FI7eJ4ywewsZ9WMOVBScpsPkYKwPTbQao7vn+YAWMy7IyuViPUOqdJGEIuWouDzpRKoZ1wDLp94lZwtJs+0vp6VplSrgLAmY0AAC+8Atb16hRgrrG3sLsAW74e96vIruRNXdC2napIutvHlJAEdAJQfKaJUMXMGbEfzoxtxZhwJ+/F05kScOLyf38uSYwvJ25ce8s9bVECCFZ3SOD1NfDsF8aQ/ZFiDYnfkzuIDGGEHBLeA9bIemj+lRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SJ0PR11MB4879.namprd11.prod.outlook.com (2603:10b6:a03:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 00:59:21 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 00:59:21 +0000
Date:   Mon, 11 Dec 2023 08:54:46 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Shinas Rasheed <srasheed@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <hgani@marvell.com>,
        <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <kheib@redhat.com>, <konguyen@redhat.com>,
        Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v1 1/4] octeon_ep: add PF-VF mailbox
 communication
Message-ID: <202312100726.wnsqAU5W-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231208070352.2606192-2-srasheed@marvell.com>
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SJ0PR11MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c205a3-0891-4105-64e4-08dbf9e468cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVQxFag4+qAV5CbjGQgSyotTGMiCDseI8A+Kc2YwQFxa2cK/fqWgkyk2Eb0+ekdUcIC7/m18j4rkogpvg/qTMCEtfekqaNZ+gDBQEWkW0zMt18bi+g9yKYMhUKQP+9oag0x4DUszcKVSin61ZOWR5Dl5M6klPpcyHpw1jMwGqHzofEGwadiAI4wDrAHQ9PP5xGRj42BCH96dw8ByCMJuTUUKFtWk8DIJ9jIqhdMWT96o/Cc0F82amCSSd+W+6x0euKWsrXDz1fhTB1bqkqyQ+WQyrVXM1H+HioehHJf18djxleQpGFsJvvYpppwLO4TgaVKrIjvZResMPJq3+h0Be0iJFJVxVKUrdrVkE+wm9RASQfXLyWEUaYco74/oHj4hOgJTNw7Lq4e/4k1ew3mmzaHhCv6bcIrVkGDgNZ5d+dkEWQbMC6YmrI76MRlU6UVEOMIobh9+dKXgoCk7gyOYRPd/VdA3cLKgYVf/OXScScHOqamfmhD8+7s/tluKYXD13Sptl4FCKyh5YxerJ63PT6UPOx71y3mtv4V5JEgKCL87OC+cRSLdNgHU/ET9d5wlWcS9vyb/vXGvbSsWIvwsxNB16cM00hmXrhPS1AysWgEJvw3y30YbyO+13v5CXzWEgim2XH+kJHwJarnFsQV0zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(6512007)(6506007)(5660300002)(1076003)(26005)(2616005)(36756003)(7416002)(54906003)(66476007)(66556008)(66946007)(6486002)(966005)(2906002)(83380400001)(82960400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(15650500001)(316002)(38100700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vnaxIy+tB3OhBcEVSGnJtZEqw+Wi+bC5CfsLoS5yC0D0cnXlvWhhnejGBQHG?=
 =?us-ascii?Q?wQcFm08KhntWTOnk7RauswNvrXiz49edimG/0veDg1VEzwFatOD6ZRFU2TNC?=
 =?us-ascii?Q?lNMQvvhcAnDE9xTibDNP3Mwe0QPHFUa1/idNZrGPqqJEExM5n7f1r7gZpD68?=
 =?us-ascii?Q?2hoLp5AgfoYZYZZbVNzaWB+J3SmXX2y27ikH3dzLqiWMSiGWO5ict5P6tXtU?=
 =?us-ascii?Q?ij1opEPhsPWqEjaMHYTDmweSKM7dFsRG5xVCJ78q1dpCx8qb8BpE1QX5UkaE?=
 =?us-ascii?Q?hb8a9RPDTF6EIzKzQGU9ny8G+oNktcPsVTQ/CAJN5yWZnF+seTLdXWfozgHd?=
 =?us-ascii?Q?GUtaQUS5MVQXRJ2CoCRrMlwAKC3IU12UjGdXmqNK3Ai23m2ClT+g6hjobHNk?=
 =?us-ascii?Q?EFLQXAaEfhBFytZ5+m7bEzgMuThsKajYjN5ARRVwsVitDLIAbPDKuTsCpK+P?=
 =?us-ascii?Q?KhS8Qo+FkALF7dre4dhGnkN3S+2cDybU0K/BPTYCUBwHf/vt7qY3hpkUKEk2?=
 =?us-ascii?Q?iK2dBGPz0dXQgvfkIqgy+dn7yU08bYK9FneXP2n/QoD2+I1FsINPysnyVYfi?=
 =?us-ascii?Q?qHsl1M1ao+bUqyeESdPgtWaCXv8wFn+af1FEKoZZtPoq/xDRtk67t6zyq0TB?=
 =?us-ascii?Q?x1AQL4I7vZuPqt896Jmc2mrR09uH0FUaXqRL/odegc3gdPuF/RanCJcilEN4?=
 =?us-ascii?Q?JcZIkpJDUZjU13S91ChiPC0kaypvi67pDJ9fFxzfjvXH745sBXbp8GSG+R4Z?=
 =?us-ascii?Q?EBHn/NptjXd4I4AqXmKMIJUpaSFR0BAXZSG+/R2EnEUg8LqN7jvCAWDNgQNh?=
 =?us-ascii?Q?vP69wt2emgDPAWryjjqo4d5y7nga3KrHdS+icfWyDK1hIOUfkBKXG+L3y8Ij?=
 =?us-ascii?Q?sKRNDKuYc9PJce5BbGM2YwnBGMXcdeM5Jvd5eJZ5SkUoplTYx/YbxLSNEuSm?=
 =?us-ascii?Q?Qao3W9/XifcSEfCh/XvltiDEL7rnBLz1gFPp6/uSiu5pbQ9cVlGd/dqldNt2?=
 =?us-ascii?Q?Q643+L48gJQKuBNf7FK7Nbtc2K7maancEEuYbYuWUJg4sZ4zjghgyN/uqHIZ?=
 =?us-ascii?Q?gIbgDK14IlTpZlgXjAPtg9mHiu+1pD85BJ1pkezSYILghKTyda5cnwAOX0AS?=
 =?us-ascii?Q?1MEdMhjLo7d+LCaBJ5tHm/K3fVf6IX0oy+m50lUW4wae118fGWap3SVCDhyP?=
 =?us-ascii?Q?PGdX52ZRmv/x0+ORTD09Y61Zlzb6Aj01VtpnG7dPCXuNiQ/DsMOaxvG8/AwE?=
 =?us-ascii?Q?yWfL3BT8dOv9OzRJ84GRFJzt9w4PYvJ37fpUDOhrooSn6de0Nptl0Da6I509?=
 =?us-ascii?Q?8V6BwiY2Wj2WzG8i8sYJdFhZm3rSoT6smWNtdZI9at8hgygXCUjfA5cm8bu1?=
 =?us-ascii?Q?j64VJYDuIuXIpbX4qaixKr9et/PKQ6EgzAf02WQjLyf8Mlk29mm1zhwOxqhm?=
 =?us-ascii?Q?NDGqOY74pUV0JG0rdxBuqp4u2to52rG7BjNTbrpgUla/IDdgKfLr78By5MwR?=
 =?us-ascii?Q?FKAPSMZqHt+BUt8pcZBYT3vi0AMhZsaQWYT+RSS7IeoNpG/L5IGZV6EVArY0?=
 =?us-ascii?Q?qFki1qP8Hs+Zkbr8nu/mCQ1G/VE3sR/XnOdUX/Z8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c205a3-0891-4105-64e4-08dbf9e468cc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 00:59:21.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFcZgLhcwpYDv+ZfBqGIO+u68YEZIbmIv72MrWKoebzBvFhdZu5v9LdZ55Gm+8YEzB+RBPS5Wr2Hy8vBX3pefw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4879
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

Hi Shinas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Shinas-Rasheed/octeon_ep-add-PF-VF-mailbox-communication/20231208-150756
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231208070352.2606192-2-srasheed%40marvell.com
patch subject: [PATCH net-next v1 1/4] octeon_ep: add PF-VF mailbox communication
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231210/202312100726.wnsqAU5W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202312100726.wnsqAU5W-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c: linux/types.h is included more than once.

vim +8 drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c

   > 8	#include <linux/types.h>
   > 9	#include <linux/types.h>
    10	#include <linux/errno.h>
    11	#include <linux/string.h>
    12	#include <linux/mutex.h>
    13	#include <linux/jiffies.h>
    14	#include <linux/sched.h>
    15	#include <linux/sched/signal.h>
    16	#include <linux/io.h>
    17	#include <linux/pci.h>
    18	#include <linux/etherdevice.h>
    19	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

