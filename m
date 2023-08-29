Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E55C78CF99
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbjH2WqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjH2WqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:46:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5658F1BE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693349159; x=1724885159;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VSstruRzYymKgWEnQPcvU7aJX8eF9G1EzQ/RbgnaZkg=;
  b=BV+SGubF2ediFsBDY4p3UpxwGpOELVjwdnfdB3ukgjTw8DNzfXeAZa3s
   QJZSjwWBVDsqaRJj6YnyHpw8G9VnGDqYz2S3elXqbBlaHPE+kmu1qb88A
   rnRuFRPx6Ifbq4pCuc0NZhWxPW4ks2HW4WCYvRPRBdG+vvmWnzjaSL2M9
   7dTQ7u4iyaGCctpn6H25TMwSERVZVmo12wRCT3rK11CZH9o3KGC3i8C3k
   RTSUGACsH9/CzgAOBRox9b41zirPYokNTpPbTcSixA/jioYPX+db0wed1
   rJmxHvtRBBdSVoyuyCGa+sGaZsyOYxp4Nc0IoRFF2HqYQ5L9hb8FDJGDG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355005441"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="355005441"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 15:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="773889742"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="773889742"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2023 15:45:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 15:45:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 15:45:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 15:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7JaQjuT0iOFgu0pvFy7cT81u6iTi3ITRbPB1rE0pbo8rdKVL+M9Ha5Vx6mdxtz6k3ItPFtGPSPBRHHN3rzrTQMmJpk8K9VXxCLYeXGsxHUA1HRe2MJ3CEl+OwYY4WVgB7nJ00HWqJTS8lHXNKj8mO/XeZaXaYhWhnEZFApEyFWXOePDyvGGoGjrasJsnZbprH3WPpJaiKqn3DYYPX2kYtFtjREpWuGPROlMZy1GBydYmahOBaRjTLJhf0cD4s9CnV3qeMFyaTl5ZikwAiUR4jkt6t+hYOo7kgi2/vdz7qbOpuKa4VKDb1cMGVC4B3+8Zs8yrseDUNN1/xc9wIsZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuXKHrBoDKaXDpNJ4fxxIQ8DkZ25+hyu/xThakKbPwA=;
 b=hrmMOVm7YTtRrJ7IZWxJftS/ZftwdCAYWqliCt1GnzHvAkx0HbgeCoVHJEBJQ4T9aRt4MJvYaTvttusiHmfWATxguYRqR1VCLPXcHtO3Td5F3+DmEkJlgqzA05c6zJ1M9FEAGusYqYkyAQ2SExJ1bd9SOeNYtYZPCUq7i0pFK5yISZt2kUwJ6ANeCU6/jZ0G0e13cELvbOdsrUJwNU5z3GRbD7bK/RRZJ7C01iiQP0fMI6mvsDK+UXVwsz1xJ0Dd+H7bCET7Be3tUPofwLdjwj0B0jxjZQOwycNADyg8Aove/3zoYjcb/SzgcfU0shB16R/O5Jlc49uPkjxnO0Yc6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8156.namprd11.prod.outlook.com (2603:10b6:610:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 22:45:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 22:45:56 +0000
Date:   Tue, 29 Aug 2023 15:45:52 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Chen Ni <nichen@iscas.ac.cn>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <oohall@gmail.com>
CC:     <aneesh.kumar@linux.ibm.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Chen Ni <nichen@iscas.ac.cn>
Subject: Re: [PATCH v2] nvdimm: of_pmem: Check return value and add kfree for
 kstrdup
Message-ID: <64ee75208876f_18d28a2942d@iweiny-mobl.notmuch>
References: <20230829031637.8103-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829031637.8103-1-nichen@iscas.ac.cn>
X-ClientProxiedBy: BYAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::46) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: db221d4e-1757-45e7-d7cb-08dba8e1b4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFsST1OymDX61a2BfHj1/5igCZ8BCb3OVPxJtZQ7MXpKeMLr3aiN9c6zvkGt4I5V7zfbeowK+pT080xwqAWBd0TvpZlCF1JTOQhIXy75xWogFFO8SWnB/W4ed16rj2/MaCArpiKw001NooGN/wTxkWrjp0ZL+kYJ1DolNkmOgNYzDiLjaWSL2j2r9VIwkqrOQ/sTn2Ebiszn8coVSg5Heb0UmugZZtJ8sZOEC6qCRorqwNUdg7MmAQtPPw92ZbEGI8kcDbImlsXdQH09cY2qvCPq+wEVLVL9cnOanrMEfPVGA8g2qpMJvUa3usZEats0/epJE3fKHYmniaTZyo2/4g72Yqi9Hc0LfEWa3W0+1/n9vO/074pjjY4SPVrWNbkJ9iS8t2KfHFNCdZGZTeX9gfeediePH1WlfqqnwdYej+/2SF0L2Mt9Ennl8yrpRwPUWITrbcJXTCyBYYmj5JG5bRffCTO7VKMCZp++EoL4/1EYtYm7ayz1n6J/6K+QQKstvn41+WiJmHr3fdyajJ2DOp9VRQXgqTmIOTeq4g7yeRDK/Xe7s3elZcycrsoj7wGA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(6506007)(6486002)(9686003)(6666004)(6512007)(83380400001)(26005)(478600001)(316002)(41300700001)(66476007)(66556008)(4326008)(66946007)(5660300002)(8936002)(2906002)(44832011)(8676002)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TQzAjU5z756Nzt/GI4JInNCOq9yhfPvG7Krt/8yfFOM0gRYW1cT0PugL5nY1?=
 =?us-ascii?Q?2DFgqI+v4tx1/nrFncK0O86wZzlmk+3KsI7yPt5KeGW5GNGGyAajZ5dtk//x?=
 =?us-ascii?Q?AYdgE6AQ1DxzuYTFL7wYdVxbComxRVhU3dyf6OHQrOvL8bOLEISbIUgae+Yw?=
 =?us-ascii?Q?JruWErO1pUdRKbQCw0RbhPeiy/uMUvVHkl8JJLu0SA4sklkBJWfEQ7+JWRNG?=
 =?us-ascii?Q?YCuvQnkCtl4OuouYfMTStfvNEjtZN/gGeG0od8mZDuf8a5Q+74SSybeqwyvG?=
 =?us-ascii?Q?K7MslJE7G3NebwDdBqBl2YElp1aZwE6T9PkJ2RqPtfrBVah2vNOVt4TupueX?=
 =?us-ascii?Q?nKaIgsvSoKETFgISmlYvwqwRWkrIqJCT6/NdannMdrqVU6W3nT4n1jM0vptZ?=
 =?us-ascii?Q?9vorN7BZJHpM7X8smcCJ9R9m2D1cUBYZg8tUsBU4ueWSO3dBcu2lHbRQs7CU?=
 =?us-ascii?Q?aeVCr+EZlYMkqHnXDlcjqntk82Trz+2tXJjzdMvZXiB27GFLMYlF1bLc++wV?=
 =?us-ascii?Q?MTRwfF3WBm5VtwZVzDeDw9oJ1AKdW7lPPgHP7auprj/y2cfpwnsMp4bKmRr6?=
 =?us-ascii?Q?h3LYVyzRkb25Ngmfd+FWDtD177+h/IjN9vrn5q7C39Qzl/a6UX/yzVYeWLaA?=
 =?us-ascii?Q?bUOmp72spnC7J4x7/V+h9oJ0GnP34Ty43R39Xxrue+MkCdS7qWMwFEfVUTpJ?=
 =?us-ascii?Q?jjPvTECGpZ6PbgAs3OYO0YeCA+rIiw7ja6rzW6zERiOU0Jt5kHtnupCno/yW?=
 =?us-ascii?Q?MaW/1ifF6UBd/Z1v9Pe9RjTLpOtxGyXgkZJy/VeM2gwHSqRzQRezaHv5TXxg?=
 =?us-ascii?Q?kyb17Dsv7kcYZqdKP0ia0x1Gsmck4StXargDNECrU92j29EGKiClFwXJsp1D?=
 =?us-ascii?Q?oFt/gx20i4Mxn++6s+rfh/zoYCsckJIYFksKDv36WITKG8PpSJ+VYgOivaif?=
 =?us-ascii?Q?G37njdB02KVHDE+fue+jif4co7RCGf3N9bCNxMLXuVlwaUGgga1W0CjJlLzl?=
 =?us-ascii?Q?btU69uXWNjIWoUtTJM7FKcvm7dxGLNTFrsFNhz3fJsQVisESq+4FYd5rI7Ax?=
 =?us-ascii?Q?kk2Fo7sie3sddLU+HA1p4tU/1H6fEnHvxQRpdSH+Wmk3i6BogqrMTCG86Xzz?=
 =?us-ascii?Q?lY/Iog4SxoeQXht4WvZPi48e5jiB4lIefyeflqwQmcihBuljl1Iy1l1EmAvV?=
 =?us-ascii?Q?LG0S0UEJgej2e81eBU+WhG2NF9wARIxhgnxZf8TgVeEOeQqcbhdD17cpURhL?=
 =?us-ascii?Q?Pj11viY7rLsKzA8fxW4zojdgkFUiSJ6+DKSb4yIjHWff1fMr5BWS0ACiw283?=
 =?us-ascii?Q?3ILYUvnHnF5+oCZd92qo+82VQcPR66QzhOIGzLNtLSqsZYMfKLl8CzI8MJ/n?=
 =?us-ascii?Q?MMmsckE55cwkwz8bvkolgZ2iEy7iwhYmNB97mSy0Ti34j1onspcWZt/uMHFi?=
 =?us-ascii?Q?nYqo3lJHbhFoCuOHAftMTYs99DD3VAA12YDrDIbY45XOsY30GHsqOOZ1d9mb?=
 =?us-ascii?Q?wDxYIGoqictcZmP2VaMdp0zF74EA9Yitk2fz5EC+tf1UX4LeBJhgqthEuT4x?=
 =?us-ascii?Q?4RxOO4oZIon/9HBklH8CHxo5h9b5ITtAqxIN1wy9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db221d4e-1757-45e7-d7cb-08dba8e1b4f9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 22:45:56.3012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXEseigwp8cG8L4fbvswRUuIdH69ow3JdsVlGhbD3CoJiI94qVtuSzbemNqYPaON6YiAQX0TvMq4szp8fevFPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8156
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Ni wrote:
> Check the return value of kstrdup() and add kfree() for kstrdup() to 
> avoid memory leak.
> 
> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1.Add a fixes tag.
> 2.Update commit message.
> ---
>  drivers/nvdimm/of_pmem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 10dbdcdfb9ce..fe6edb7e6631 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -31,11 +31,17 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);

Could this be done with a devm_kstrdup()?

> +	if (!priv->bus_desc.provider_name) {
> +		kfree(priv);
> +		return -ENOMEM;
> +	}
> +
>  	priv->bus_desc.module = THIS_MODULE;
>  	priv->bus_desc.of_node = np;
>  
>  	priv->bus = bus = nvdimm_bus_register(&pdev->dev, &priv->bus_desc);
>  	if (!bus) {
> +		kfree(priv->bus_desc.provider_name);

If not using devm_kstrdup() don't you need a kfree in
of_pmem_region_remove?

Ira

>  		kfree(priv);
>  		return -ENODEV;
>  	}
> -- 
> 2.25.1
> 


