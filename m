Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8827F56C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbjKWDJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKWDJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:09:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3F1B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 19:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700708994; x=1732244994;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6HiWc0Y2Or+HKIYJ1R1mwDL71QlvJXrlLDQQf6jaUKY=;
  b=iWbB+R/6PIDf+M+BZixfr/1hRlTyPhwkZufttW0NdXRirUY3U6AmDTvE
   vShLWaKSdsE5ax2lcnTayof/HLE1LVd/21RwUlTwqoG12XFZFDmrcOmGj
   /bBm8p1DcGVMKv6HuOYjL4Mkzew9psJQRqglhWGivxQuPB7AyqkLN2YIM
   8HtL1EMYn7dG0KI4HL4KJUEWeNft8NE+J/s1sNx50fiPezpifBJcUc4O1
   THepyxGuV2E6X3y9HL+FlYXnMruLjwF9NpYdOxUpV5sX3WICSl8e8MWzp
   KyPwFyXxhjnoVEhckFWtaD5RbjFFEH529A/e+E0sbV//FBYpcz5l3VF73
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396098271"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="396098271"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 19:09:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767081616"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="767081616"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 19:09:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 19:09:43 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 19:09:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 19:09:43 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 19:09:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ai4QZZY6HCz2B6g2lljR0QgoUSxlF3ulwtOqMJm7wfqlfZTVu44+eKXpVUJECpSt7EqDCImoenhg70YnaOz5DK66i/SV6Z3T3pDwA5N2szfadyChNU5m0jp2oOMFJ1/Mkz4g5to/7QNUNZCO8YPmWoPtL6vQJad2WEhH6MqQ1aah1bZltNlsPViH0MS5aslvzIQ5nPwM247UaxKTVzBOc1OKqsfpHEVxxTy9X6xDHKfXi0h87f9UCGMz8tL7BftfkzXSaCa4xvJsl7hRQ9UQYIdY1YCzSi35moq0n9lof0KgrQ2LEGHsyfgAc8k1dRjCX6td0+JsfVVJcLftf4lrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeHlC0uCaBqISTh7BrJ4aTk61wtDIMxyV1Glbd/Zqmc=;
 b=kXYTNMXppmevU/aydB6NtwwxXL0syNhs6kClLDu+W0eBRmbkuV7jQjEJpPzjbjpiGQxq/HYdReGuoBxKkcCwk5Nq6PfiPib+jzpJfYfmoHCzeDHTRGYVzhIMm+JsX+7Cw1KHSJ7sCPOeglYGxCrsDT5mWDEOFoe9bEMlAHZ5EHQmVmAibkyvpWEEPvzEQbutzHYOh1s2fg5UqDG862u3oYIVY3PBLxoV1J3G0cpg2yADQRIKy76ipz5WMj2TEqrtXWPB5OyVFlcxIygypIGa8mbn0dt7c3uD248h2866TEbD6rlJL9w+s2TXLYE75TitWNu/PfL1R1ocWnEFtebClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SN7PR11MB6947.namprd11.prod.outlook.com (2603:10b6:806:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 23 Nov
 2023 03:09:41 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 03:09:40 +0000
Date:   Thu, 23 Nov 2023 11:05:01 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Edward Cree <ecree.xilinx@gmail.com>
CC:     kernel test robot <lkp@intel.com>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Andy Moreton <andy.moreton@amd.com>,
        "Simon Horman" <simon.horman@corigine.com>
Subject: Re: drivers/net/ethernet/sfc/selftest.c:48:16: warning: field ip
 within 'struct efx_loopback_payload::(anonymous at
 drivers/net/ethernet/sfc/selftest.c:46:2)' is less aligned than 'struct
 iphdr' and is usually due to 'struct efx_loopback_payload::(anonymous a...
Message-ID: <ZV7BXZ/CtxzJzBuh@yujie-X299>
References: <202311220537.geMTr31W-lkp@intel.com>
 <3f42dee6-a6e2-1b35-674f-309aae042ae7@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3f42dee6-a6e2-1b35-674f-309aae042ae7@gmail.com>
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SN7PR11MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cbd5d8-3e08-4515-4c60-08dbebd1a232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xIYl9535N9fpf1zbQXKfCfO2ymdh9nbgq9yQKwDwJJiLvU1Nig4MMU78CRNOXp9k+Fm8M91dpF+aofO5Shwr6AGerJNrLxrywl+xgRimdsxnGNlAYAJo5wBp+q5Ij/CTTcWPU6YYTXtX1IkPjMJGhremY8tATLzRzZQVb85tVNU6WU5ZZk2WIgTPfSclFb4vhcA0pydM6g//RMIqbwUtHnYExC3qiwtRS6YoypDPmpgwba3bIhlJZyAyJJLVsuLt34YTstsvnAk/devMQWKoYIPqWgN/LiHM42xmKaLBB34dzEEHzhdYFetP+yGvZ+Swrspt63EosYs9QDVklz3Gqd3VVcv4VwtqlGm0WSEWphScYmU1nck+jINZGH5ZA3gAZPIlWbNaMZJ3NGFiHRExRnbO+0pr830faFYZs96kYDyADyWgi78OBsPz6xY8wpIM0/m7/jlSQdeWkJnw5gmnPJBv7VEAz7wYSOJVStVbUuBsJHMJ2La4SX3QuxPXhMbRkvMlxfvfyd65RwQBZi80ohJzx8huFdDLS5exPbnUs3ItSzS7CzQg1iFj0naX3cyENjjiE/tgXF7QgC0O5+cIEvAqmZ0dM8ifuZ8v1tUfbrCQKYcJz6IDpJnmx1/wodLyYwTaDgYJQI/b49VEB6qDYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(396003)(376002)(136003)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(41300700001)(5660300002)(966005)(86362001)(4326008)(66946007)(8936002)(38100700002)(6916009)(54906003)(316002)(8676002)(44832011)(66556008)(478600001)(66476007)(6486002)(83380400001)(53546011)(26005)(82960400001)(6506007)(6666004)(33716001)(9686003)(6512007)(219693005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n+nKLy06UM+vJCMZubdhEunl4XOsvp6WYvJZ6AoXhr727s3xx3P0vbnAenNX?=
 =?us-ascii?Q?nMhkSi5K5qWuTmDBbOYmEuljSQwB48iYVfdHygN1WTJSQ8HaxXEvfNW7RkAP?=
 =?us-ascii?Q?XRz26GUs9Mri58WSkoYfu13I58EasThiP4cSoDoRRtdEVgM+3CuiDsSmp0m3?=
 =?us-ascii?Q?5GRcfQblgfhrAmEdcN0PcR9ukPYaYWncZSQweV+pWuPQf8BuFyTnG1IJ4REK?=
 =?us-ascii?Q?+uQ2kXuXPvpE9BQDdOFum3Z+O44MtvIGURwky00LH+7HWS/igtPTOf+Qz4Q3?=
 =?us-ascii?Q?8cUTw2xA73dxePqg6nktTn6jSQE3VT9T2gnOMFommGJQmnMzPUqxT9seovlY?=
 =?us-ascii?Q?8gQ3WPwC3DEXNVGEtSpLKZVID27qIBQJB5Oaby+FRzoiLCWZr2x2vtiahC+a?=
 =?us-ascii?Q?hXQTwkyV5WKVD4Of6fYB85dXerPS4RtMQmOYCSgYRQFtwag2ZpfH/2Ufy2x9?=
 =?us-ascii?Q?wRanI+QWL9X/xK/O9nvemWFYsi+ypxeSL9KoCyuTUT/RfhycA6F77ih6dFpw?=
 =?us-ascii?Q?7NK5SUXENOyFQmbT3q7m9k0heLr7pg/DJRciINraPmu2V+OcQMKXBg4Epnsc?=
 =?us-ascii?Q?ecGReDN5O2jBpPs9AC9Y1adT23jlSSymF5aVZ5POZxiMfUpvVWQVFbh1DyhN?=
 =?us-ascii?Q?6dkbLla8wphsDJeE+eo2RSCmaQtiUt+AZPzmCwAjZBDb6FWKtU2YHM8gg17T?=
 =?us-ascii?Q?U3wT5y1NnaqMCPIM/js/8i+tVsJOSd+MJmLoyOGAM5lqPVdeeI87egY3EOwS?=
 =?us-ascii?Q?pW1LHgQCge33NAx+UOaUEHeCUvp5hI8jssJRR9j4jL0whH7Ek+pxHvA9y9ia?=
 =?us-ascii?Q?U+FWmGHd/aZLUSrKFbRGeqv0JYtKDHoRW0h8MKraUiHEAXnE0RNe5tNzSZrV?=
 =?us-ascii?Q?IK6haFW7Ced2XVMQImGsYALzB6HErU8FeNspbMx5q+dTZdNcEf1ULvF1kMvy?=
 =?us-ascii?Q?SieKlGasDSRv1YQdxpDSQaA5N1wPhk0535pdxUZkrceSGrzAyusDA3XDwUzx?=
 =?us-ascii?Q?T51gw6G7VK54nRNL4Ij5HonGIbmVdplvfA4E94IWpWf91dASa05CkhDcZHfl?=
 =?us-ascii?Q?E5zUJbGqBO6AjHjjfK9On9RyPxUNSUSfDgajxjx7YxCp1f8y5eBbtTDKkbDA?=
 =?us-ascii?Q?UJXjzlM9AVWPDD1wIDa6ElkfLGaMJi6x1Uig8LufDKrG6885MH8WYPQo0eDQ?=
 =?us-ascii?Q?ZVeRwP0TcPCJKf6A8AlDqxw6ddm1AjtKWOl8M75/a5vHJAfIYeyV5asyHoQl?=
 =?us-ascii?Q?V+ODQjRCqDJbmCDCgrRu8p2PxJcOUgAb9EZCH+oZc4+BVZukwZcOjrfdlZBB?=
 =?us-ascii?Q?KR/Bl4yAPyY65HY2/yDnDYZa65wHr2dl4sLq7tnmI3OJnfDH66fSNLoFBLk0?=
 =?us-ascii?Q?zJzf36TTaQTFfTP17aRS8fBC9YQ7oQd0xDix9KujOCOYLcHP+OjizOwmafh+?=
 =?us-ascii?Q?ZgeZAOB590GTHVwWPESZxTPNlopROyRe7OZII+9EPU0Die2L5re5tptCpSrD?=
 =?us-ascii?Q?pH5DtpLmpSqC1lzwYjWn8skyMil0Fl8MAykUVXQ6kGdjSBoVi+gmkfiaeXGB?=
 =?us-ascii?Q?r24SjoEaB+W6/pEOXju+ZyDhwXPSJYeF2lbogJaL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cbd5d8-3e08-4515-4c60-08dbebd1a232
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 03:09:40.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaWG0EWgR8ISvRHyu4t9TsgB/4+6ofOCi0fYGOZrQvjELu3ljEFK4orGVB0+msC+sff6FH22DHhFgyw8HMHBrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 04:15:49PM +0000, Edward Cree wrote:
> On 21/11/2023 21:25, kernel test robot wrote:
> > Hi Edward,
> > 
> > FYI, the error/warning still remains.
> 
> As I've argued previously, this is a false positive / compiler bug,
>  and there is no way to resolve it without making the code strictly
>  worse.
> 
> This:
> >>> drivers/net/ethernet/sfc/selftest.c:48:16: warning: field ip within 'struct efx_loopback_payload::(anonymous at drivers/net/ethernet/sfc/selftest.c:46:2)' is less aligned than 'struct iphdr' and is usually due to 'struct efx_loopback_payload::(anonymous at drivers/net/ethernet/sfc/selftest.c:46:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
>  is complaining about alignment within an anonymous struct, which
>  only ever appears embedded within a larger struct in a way which
>  maintains the correct alignment.
> 
> #ifdef RANT
> 
> Indeed, the only way we even *could* create an unaligned access
>  out of this code would be via a declaration like
>     typeof(*(((struct efx_loopback_payload *)0)->packet)) bad;
>  because *the struct is anonymous*.  And if that happened, the
>  bad declaration would be the place to warn, both because it's
>  incredibly ugly and because it's the place that's actually
>  wrong.  The struct definition itself is entirely *fine*.
> The compiler should be able to detect that, and if it's not smart
>  enough to do so then it shouldn't be trying to warn in the first
>  place.  Quoth Linus[1]:
> 
>  "And if the compiler isn't good enough to do it, then the compiler
>   shouldn't be warning about something that it hasn't got a clue about."
> 
> The anonymous struct has to be there so that we can placate the
>  memcpy hardening, and it has to contain a struct iphdr at a
>  4n+2 offset because that's what shape the on-the-wire packet
>  *is*.  To avoid the warning we would need to lose __packed and
>  memcpy all of the members in and out of the buffer individually
>  to explicitly-calculated offsets, which is worse code.
> 
> #endif
> 
> Either fix the compiler to not warn, or fix your automation to
>  ignore this instance of the warning.

Hi Edward,

Thanks a lot for the detailed explanation. We've configured the robot
to ignore the "unaligned access" warning for this specific case.

Best Regards,
Yujie

> -ed
> 
> [1]: https://yarchive.net/comp/linux/gcc.html#13
> 
