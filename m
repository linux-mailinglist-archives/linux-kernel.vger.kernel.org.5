Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5774E7A4EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjIRQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjIRQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:20:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1AA7690
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053522; x=1726589522;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AXpx7UaZdQQIdd9Cq9Y37OPTr66dbkeddoIxzGd+Cic=;
  b=GY8UENxDV2Cu8xr+czQGxFSyU02/FICSnnBdveB+y5HVIMrqNb0ziH50
   6lh+OsDjI2EbNuKhGDdZu/IAXEIncWimUXBXUV0ExLBvVsOvFj1ESrn+0
   JXS6GqeR0dD03dmb/xaV3HAQjWimB0SAWpiV5mbCwbk9Yyas0FUIiDgRG
   D8tk7sUQL4BC0isQI2HdvYtyn36XjcwkEuzTGpfXVVwI8t1ucDcvrpCG8
   Gd1QIDEV8YQ8wYiartYk4zXOMojLuSo2XzoMJO+cs0+tcpGP2d9MSHVeK
   HXbppYr4IpS98/bS26Um7ykT3jgEy5AD16bfPBZXnnOZgGspVEVTdDBmi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="443777405"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="443777405"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="861119103"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861119103"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 09:07:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 09:07:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 09:07:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 09:07:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JU0FwrcYVmz+2TCLLDO+bE/+Tem3s4Caew8dEWeo+NRuuaZxKttcZVb9gXk2v2xqexKO5L8LZMBQFCn52MCtY3Lq7JQ6XowstQuMlz+LablmhyAMl0hLjVh9MJUogT7qbliEv4hVoFJQafSDRYyJlPsz5jdmrpn/cH9bN0vlOiImOoEIsgXmcsMyFl/RlRzw02W0F77ADoMbeOThIc1pqV1NYMcMg3+iQfg6ty7bCfKUnn38jhQJI992MIR+txv+V/hdboxQghFa4XdUapjtJf4eBv2MLH2N+U2u/a6fyR+m6ZdsyvwV/35AUVfCaR5zu+5V1jl1upcG63KsZUS9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFKd2SbO1VABBiO0TxDg/yKzIaac0ggUktoUx+NRM0w=;
 b=WPuWmtKCpogjjvo9Akn3L1haLu1hGjm+hN7RvMonCnk5QQtYQHPCVf1IeLmUC0zYm+lhd+Dh7QJIdiiSOaqPE3cV5YlNDzo9pWaBU93RSC6Zqzql74a7wGCCsYpSNQ2v59bChYhb3xvnu7D1fES7S2Pxg8Z5x/T4suVoiMPUDjCOCaBjzZSNmYDA7JVCybPTCn3yUj4wD4GJmxh2r2F7CPeD09EDpTEI31uQePwb+m2+YESBQWeljdmJ6s/ayJRoQ2CKJkDOQQIlr+zsxZXaXVo/d7TsZvsnfrEVp3daVv3rKdUrhCmGez2GwB74yZk/1ssdtW1ePKUqdRVAIxUFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by SJ0PR11MB6670.namprd11.prod.outlook.com (2603:10b6:a03:44a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 16:07:07 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 16:07:07 +0000
Date:   Mon, 18 Sep 2023 12:07:03 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Tomas Winkler" <tomas.winkler@intel.com>,
        <intel-xe@lists.freedesktop.org>
Subject: Re: [Intel-xe] [PATCH v2 1/4] drm/xe/gsc: add HECI2 register offsets
Message-ID: <ZQh1p5umcz7V4jXG@intel.com>
References: <20230914080138.4178295-1-alexander.usyskin@intel.com>
 <20230914080138.4178295-2-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914080138.4178295-2-alexander.usyskin@intel.com>
X-ClientProxiedBy: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|SJ0PR11MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd28cd4-ef81-4089-2f6a-08dbb8614e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zx5CeINX3lWgqSWQEtE0dTuzFxD5QYX5oycL6OA4VsZlgwj01Ree6RfoaJe81SeAAdfxcsC9QM/mPTrlSUo9HX7Vqs3MDEAgFVOoUiubESeS2X+WXHeLMs6+FqFz51wREYdeiH0KbQASq7aHpmfKhby/mJMZRxJpOFKtvnVUIHXTxGbNHvkI3i3NaG2deSyyJIor0aiqeNDjXzLWifN/QHqwT3b5wchTLB4ckiG+iUCFZjUHS9TEUQGz4IvBX99xLyl8zj3/3MNEffiUlGrTC9xrVjDNYp1EPI8TfMsTJ2hlWR7ayccY/Fkgn66q7ec8Ajy2bGh3+062PYT/3hkHXwD0DQ6fEVAz6ea4QOBGt2OgMVZF/D0iDYVwSKdGshzw8qyQt2E4tTeGyDJteqDcrDQf6repAy9omoFYHSTkedB9mSvVKh0NJYdFKDTUjqEdcSxdGqkuF4Pd2DCNhg+yynRxOJXeHAT/pvEjLWYNHhcXYdzyLEPDMGxA+W7FV3r9Gm4LEnB6jj1pUm0MuV5umNfXppX9w6Us7lQW+Q1CrryEa01iSrsD5mTQlNfC3N+R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(5660300002)(26005)(8936002)(6862004)(4326008)(8676002)(2616005)(2906002)(86362001)(82960400001)(38100700002)(36756003)(44832011)(66476007)(66946007)(6486002)(6506007)(54906003)(66556008)(6666004)(478600001)(37006003)(6512007)(41300700001)(6636002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tpXDh7H1VnIDt9Smy7Pw03Egz4K7ap3YIKVbKhIYEUrUmlIoCuykepTW4Md4?=
 =?us-ascii?Q?oodEfjGBnMygH5qb31KiXCyeyRqCSXBjn2rY7Zv22pblL0hAW9u0oy8fJB8Y?=
 =?us-ascii?Q?qM19ezcvJRfd1A/xIpPBKIfRt1a65jKu7yk4OCzcm1w6Yc5CtgsXiuPmMSlk?=
 =?us-ascii?Q?weD/6Rzs/IRlFdGfqp6YrqnBiDZIvwkb+gBcbBNIFFbc7vrst8eaXbq7iBGB?=
 =?us-ascii?Q?kHhsEV8MMevOO807Fp4GXTOaQqA1UexAAbjdzcwJ3TATv/51owNA8/FFM+5v?=
 =?us-ascii?Q?suKlWdyw5UNTZx3gfjR7VIOEkrLjZ+EdpRXE5E8ERQruTQ0XcYkLxYWe3DVS?=
 =?us-ascii?Q?SqonHey/C/Q7ojg1u0D1dKCfZStjWrpQJ4sv8A/vZDtBEpWvDhMEu/KtT7Cb?=
 =?us-ascii?Q?ZFcAHeNxPMsdd0WTiUuUK8tXvr6V1w5nDsy0c1ukxh5yJVxr76KifiIQwj4t?=
 =?us-ascii?Q?X8SVa3LGNHscyndqRLCkyADeSUso/vQIOXq+YMpDGyy2Btp4NqRhywYMNzX/?=
 =?us-ascii?Q?u95t8E2v6gcXeD61nbLtJ5vLtIOD5v51pF4g+CdH3fKL+DTheIwrtDNkq4ZT?=
 =?us-ascii?Q?WY6ftORY4vYKaDzepeXmzWv7wUMZQYf4qTVP8hVmP695m9FzUeK5Q47balPL?=
 =?us-ascii?Q?mzJUq+0d4MjUsCLc9t+5kSdsJ7Uan+10WYA1SFhyxkLlGUHSInzRTpXhB7mc?=
 =?us-ascii?Q?X5GW34MznTKK78qoyFDA75NiuGFnX65S+sMPZNGhLlGpg49qaKS/tIASUKtX?=
 =?us-ascii?Q?rhFao+5yaf0DqMXQCCK9MOjw0LZGDoNnO3IgUVDiTlfg6oG+lGohmgIHc4Gp?=
 =?us-ascii?Q?ZWwWgb046Q6pSrCLc4OGdNiyoiZ/G+xNTAMjXyLhEZ/7X5lnkA2PEGgL7oEk?=
 =?us-ascii?Q?7li7lIY087gWNXJ1o1OAVHGFI9ln6kwtzHP0IJ8aYmB49vHUeCNP2x47LNyK?=
 =?us-ascii?Q?gk8Yad9wuYDCDDXZXyXMca5RFfGt49d3tVj95bzI3T6/XJ0Z/IZvx+K9tk8P?=
 =?us-ascii?Q?bnfFCQktZk8gp1HL9kbxEMu4M60QRFjhpgJUxks1/AqXck6WqJlpGs0o9pB9?=
 =?us-ascii?Q?l+oPHYH55HmTQr/xbZvQK1i2t513psF4q4leVi6/LY4JZCMDR7Ukew/ZQ1y6?=
 =?us-ascii?Q?xbNte+VrzBYvfDzjlKMeszd+qi/NgbGuxO4Br1bZZrGCWChkfAbxw3mYw8Qn?=
 =?us-ascii?Q?A+lLV29BG6gYzlSj2JcQ1YFX+rfU1OhfETKQ89k8MWkcTyw1hkDCEUTsgvFt?=
 =?us-ascii?Q?Smb9VY2BvFPWwWsQKBmrOP0iqjEmwOB0T4Fc4M7tptXodlPxxlrEEKO06MOv?=
 =?us-ascii?Q?QyqAoEz+7DnW9VmQXkzjMAHCD0rbzMEVU9xPl/QYCbIIBMX9/T5B9LlALeNO?=
 =?us-ascii?Q?nkenpBjKt7lHoBGFZPVV32FsfB6PrA8dSZ5A6yCz7tkZkC2lo5Zbc4rnha7q?=
 =?us-ascii?Q?IJAv6It7ufgD5cvr0/3Y+o25KWLSKYIX6BBKA1XPzbH+eCqiHNQIuSZZw/6m?=
 =?us-ascii?Q?Rhc8YlcAUXUlEl9hIdR3anS9B2anYIMLo4w27TGGNs8bJh2hHa+mxilN0I/q?=
 =?us-ascii?Q?XnQmuxlJN8bjfsASsCLjRCGZXHPM9bSyLhEiwehd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd28cd4-ef81-4089-2f6a-08dbb8614e4d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:07:07.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXgaIqgKFxvftzYU2cnbRfJt9av60FvvCMchNuyUDQGjMCETdVP9YpOzQHg9OMWh/VK7wJzsO1+YzWuIhmB2NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6670
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

On Thu, Sep 14, 2023 at 11:01:35AM +0300, Alexander Usyskin wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
> 
> Add HECI2 register offsets for DG1 and DG2 to regs/xe_regs.h
> 
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/gpu/drm/xe/regs/xe_regs.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/regs/xe_regs.h b/drivers/gpu/drm/xe/regs/xe_regs.h
> index 39d7b0740bf0..4cbc3062cb9a 100644
> --- a/drivers/gpu/drm/xe/regs/xe_regs.h
> +++ b/drivers/gpu/drm/xe/regs/xe_regs.h
> @@ -33,6 +33,10 @@
>  #define XEHPC_BCS6_RING_BASE			0x3ea000
>  #define XEHPC_BCS7_RING_BASE			0x3ec000
>  #define XEHPC_BCS8_RING_BASE			0x3ee000
> +
> +#define DG1_GSC_HECI2_BASE                      0x00259000
> +#define DG2_GSC_HECI2_BASE                      0x00374000

matches the i915 ones, so

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>


> +
>  #define GSCCS_RING_BASE				0x11a000
>  #define   GT_WAIT_SEMAPHORE_INTERRUPT		REG_BIT(11)
>  #define   GT_CONTEXT_SWITCH_INTERRUPT		REG_BIT(8)
> -- 
> 2.34.1
> 
