Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953017C7A85
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjJLXlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjJLXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:40:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E119A9;
        Thu, 12 Oct 2023 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697154057; x=1728690057;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cHawmV/vH8ShZu4lAlyMw+gxQmAHaMjDhh3XDQFc8HQ=;
  b=k6NYyfmK6uyl5RcNaO40N7wcRR5025AH+F2rwzTJhgCsc4RG2VFAdO1e
   Tl3TcJhKxZi4+cxmlDxipXyxS3D9a2QLBgUTz6BRyn/cJ1/x1SO1d2ym4
   gVxNCVmivERl2XYy430Yzq3BbBVY+kNH/6Q5E24nv038mvn4PwyWY7HbO
   TSCQzWR8psKGPZxuCgwQzo5GaA953Z3WDBmpGGwnJthRGTRBNIpUP9tAE
   kY6Fq46d2zaL+UmwpUxBPZ8ktsznwA+hBZ3H6VYLySLIbyhtILxFMl1Vr
   144Yac7ELD2Bg8k7mdSxNzUNuKT44hqZM2QnBwMK5jdTR8spuh6IFOEF2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365325254"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="365325254"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 16:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="748108742"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="748108742"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 16:40:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 16:40:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 16:40:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 16:40:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTRUNu0U4AxojDTyGMTrm0mqTVnuk28ZmOdycKQK83ddphHyjuyrVnNGsTCYeYW0AkLCNN1k8nnglWte+1z+hN17PYEL4H+jggMoVITxMEhenE78VqOyaxH4k1IoS1JiB4zir9qbzTY6sn2cx++Y7uZ2ywgmgtgnQAYxS4XKX9gPMtKNibU4Ujd6JPak3LDzSLSOf81n4xr3xFSK60Cs/JI6L2dY1LwN1DOvVeChRQwG7WYY+lcMZiIMbfqU9da1IRPOpD4xBfyFpCYWmC++XYhj9dHTpn4oS3rcwAlzVofReUGcjLlNRKzqmEss5Dz2kT23A07m0qKcfmkpTiaCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHawmV/vH8ShZu4lAlyMw+gxQmAHaMjDhh3XDQFc8HQ=;
 b=oVVb02+zvyjhzAZIbNvm/UY/DBU3BM8JVfnLjer36NdlOp95GPnyBv2vEhZOHD4womzu5DTsruQar3gDZ4p1vcIff6EVf3AraSphvjNmu7e4ovdM63e60YLud56ZGlM5tlThhCuNmHDqgaMXHfN1nfPJP7yuPITDX8QPjSc7r0LRuZ4OC7O7apdu7fu/zW5kD6sPyB20mpJQ320cITMUtS1BgDPeOBGvX3H1GghNmKSBdgG3rnZxlTAUGdMoX1RlDBXnC+fNUv+QA4gjG5T/m8kXiP/tU5R0GWdvwlRBi6lW45IHuA0UP+oUWZ9x2QyeBQdG11dFou87hGN3emHw4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SN7PR11MB7509.namprd11.prod.outlook.com (2603:10b6:806:346::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 23:40:49 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::66b3:c77d:472e:4baa]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::66b3:c77d:472e:4baa%3]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 23:40:49 +0000
Date:   Thu, 12 Oct 2023 16:40:46 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
CC:     <rafael.j.wysocki@intel.com>, <andriy.shevchenko@intel.com>,
        <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>
Subject: RE: [PATCH v1 1/2] ACPI: NFIT: Fix memory leak, and local use of
 devm_*()
Message-ID: <652883fe10d38_780ef29459@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230926184520.2239723-1-michal.wilczynski@intel.com>
 <20230926184520.2239723-2-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230926184520.2239723-2-michal.wilczynski@intel.com>
X-ClientProxiedBy: MW4PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:303:8c::29) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SN7PR11MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c028dd-3602-40a1-9bfe-08dbcb7ca9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +MjBa4dElOSe57KC366jXKmWzR31kc1kKyVq2//DdwsMwQ405Xw6Ys0OuawJz31qpX+kC6arrlItsfpo74aSNN6v71OaFnV86I5LdZAtd95j2XXLJbbQbTWco3o/oN2Aviq7yZD9B6w/c6N9c8Vi1tsmrBpSoZYcR9l5TE3h//ATSqrUzzxMiHTLHqmZNFwqA+9j3jfjdkQ6E3ro2aT2AYYs2N0oLZWUdIqMl9mJsY/a2Yg1iYqjg1BCkOpsjW6PkUKOOxKi/dJ0clhYoK1KJUxCRlUGNoxg3Xqf2+dQ3kE1HFValHyZ47FrvMILMbss5EWBPEE/slr9PgSuKvnK5nnLg8ayBL/F2+L4338Su4pWf487omeel2gif1ewPSRkqZJ7E+6foW7WAHXEPCyCdwZXzkR/cOqqa11rNPxtrMtKU52MvkWXhziy+a/5ydmKLBwvG/JYFsZGK8+5U9ydC22Z0WfUqrbV5rxDKlQapdlCF3RmD8jvqGJj2uWlmGIoq64EG6I4UZdF8BYtM8w+A6E3Gnq8huY+iRr7GywZmpHlclMeP0ECIQfyWNAoUvbX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(54906003)(66556008)(66476007)(66946007)(6506007)(316002)(82960400001)(6666004)(38100700002)(2906002)(8676002)(4744005)(5660300002)(478600001)(4326008)(6486002)(8936002)(86362001)(41300700001)(9686003)(6512007)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+UPtIvrzsGbcrHaT6I2PYfK+Ljw+tLyr4oDw2ETRW1Hkcu663TFtCfgY2JYp?=
 =?us-ascii?Q?Gkc8PDRztpZxotWK4C8ipCaKhtPT4vR8U0wius+ZP8uKNRjfQ95scCozEj/X?=
 =?us-ascii?Q?uEtBFuRWKB4PqPttkLUcYaF0MeG4IPqlVEijxLv8g8aefKMCosHW7GQI/Cv7?=
 =?us-ascii?Q?zMHFG4z92VRAVlGXQQD2jr5MHCk0j0isEWzAJuhbJv/ef984jf+Z+kUWTLuV?=
 =?us-ascii?Q?40pf/zmPBE2fh32eFifkh37Zuk7SnnGqC/tauU4jLQWFVyfYiRN6XUPMjRcK?=
 =?us-ascii?Q?N7FwRI5qN/xM7EWMXbt5TfFh19KbTLMiw9d0CfxI46NWCxhABVdbXov18jrC?=
 =?us-ascii?Q?hSna80EFoqxz+piiXsPPu+4GnquJm7zHY7O2gFdwZbPcUaO0tCImVz7gXXTc?=
 =?us-ascii?Q?wh0Cs+6aMQ2bW0vABYLbafzk8pd84xmpbgEVLfpeRXOCT115B0VrjUPk8t07?=
 =?us-ascii?Q?xxw34W+8XzBg8loJtCInGgl2vOZ8cOc8h8ugXv+eHt6xJMB2db/06qkzvtk4?=
 =?us-ascii?Q?Oa/OH00Vz0FPwURIkehymabEpOk3uovzR/rlWDe9WmkvZUQ1yWcTNf07mhoA?=
 =?us-ascii?Q?kxVqGOMOzLrPHRD0utJgQ3MeHjaYpKvQAgsVgQI9NujgtNbbp0l08Z4mNAc3?=
 =?us-ascii?Q?KkhVJTAbzRxa4EHL1A55MT7Il5kOcKI0ipZJlXPJsKpGXeE8+RaiM2iicNU9?=
 =?us-ascii?Q?ScphirVc1jI1q9SzoDDWk/npFcNTLJwRkFcIqWlhbQGXz14rXvp9neHzwonz?=
 =?us-ascii?Q?Z+f9wyw19GDyCx7HRaKFaTsDp28IjZZy4ttVWfHPb3A3sSt68VpfLgF/JxOt?=
 =?us-ascii?Q?c2x/dCCmyBKhTB8Y2Dk8b7vp985hYexkRTMzAmZ/37UjPbqV7FlId8JbNwM/?=
 =?us-ascii?Q?6HkxyhSM5br+9/glDWxR+OpqqaW4UEWtPHtI8wERyy+YO9zwPF183nBnI+7e?=
 =?us-ascii?Q?XVOwoGxi8J7qv87HP5jdr5SCgZ7HG/GYvS0fxiPB6xPJC/3NkLu+l3ybY6jy?=
 =?us-ascii?Q?KUMKj56GH59pDErZsr7xnmMs90WgxWELFHfp66XzV08g/k/cG99hbOCUIzAi?=
 =?us-ascii?Q?22OIiMWyVVIQGLkc5pAefysLCPpW0SDY33ZIoQaspLpOKf8SVJC4l48S4Rei?=
 =?us-ascii?Q?IL6ySlTQ9aEvxcVfYj6fMcBKhWC/+70qYLPvd4AM9172f1i5OSt+YPPa2cpq?=
 =?us-ascii?Q?wZ/eG+dqSAkZtRJqGeTxS+UvqQTg0NPUInFaJ9BDE08GBQurQ+jrd+mcXtOi?=
 =?us-ascii?Q?fjW0ri5ImTAKsDdysmS+9wseRbmWGjZrrZhbvQA3MVkGWJEffTZxfzA0Ejva?=
 =?us-ascii?Q?fTs/J9CJcZ8YYZK9rgNsj4xaKDvubvLzfX6KowMutvtmNTF3qQOccWzMebtw?=
 =?us-ascii?Q?uKHrTz9qOMgclV+85rfUqJY+1hq63lamPDw86gGXjzCrTGlN4MYECmN9qIDZ?=
 =?us-ascii?Q?/Tv85Ehi01zIWzOeba2Qg2FTz2Nnkhjwz419s8NP29Zv1Qr5dXpuTk1ohbRV?=
 =?us-ascii?Q?REuvkZW7vC/LQLfTRHHY5UXH9lA1UKepATT0gnq8Vv4+LW1HSrvbFHhL1/K/?=
 =?us-ascii?Q?g9g4KKBegQ5QJhDqOQQTX49Cab3LRfoKR8LVYVObLuAhQWYQhQSFV/aAf+IN?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c028dd-3602-40a1-9bfe-08dbcb7ca9e3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:40:49.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8YwX6+qErjZPfJaDPQAHkHJKYvsVPyNq49p26cfemYon+Valh4aRhzzoSjL2oEKy1+XzacLzXmPPatYG/LZkibyAVde1sPDus6pLKdwSow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7509
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

Michal Wilczynski wrote:
> devm_*() family of functions purpose is managing memory attached to a
> device. So in general it should only be used for allocations that should
> last for the whole lifecycle of the device. This is not the case for
> acpi_nfit_init_interleave_set(). There are two allocations that are only
> used locally in this function. What's more - if the function exits on
> error path memory is never freed. It's still attached to dev and would
> be freed on device detach, so this leak could be called a 'local leak'.

This analysis is incorrect devm cleans up on driver ->probe() failure in
addition to ->remove(), and these error returns result in ->probe()
failures. No leak, i.e. this is not a fix.

The conversion to modern probe is ok if you want to resubmit that one
without this intervening change.
