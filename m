Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EFA7A4EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjIRQaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjIRQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:29:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2F786B5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695054401; x=1726590401;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K35Kur+yZqdFqjPgUpUMElgetNmWBkVThTXSk67sACs=;
  b=Twf2epSJ+yZ3W7iQe2nIgzQu+kQHx0HE2cb0ZgC923xFTm3SCdjIm0c3
   vSID0H2eDbzhFN/DZpcCL+tqucq8ekr/DEhKlUMc/f5m298Chl+i7Ptz/
   vt6C70bk5TtV3diJp23tMM1J7tesQeANymyzG5pdYdQWv51s/IOuvMk4O
   h4cwfJCncTBTLXDRqamK/Bw0lYhUSIySp6P+YkAFeWHF/St0sk0RV6fqQ
   BpWs862QWmscfXpyKlyrfz1yPcnIacTXyykYA4f8WaxNfH1+NczAjqgRm
   JpzaKoxkxBvUI1Cn1R+0d4IjQm2N0kAYjcRZ9MJOAxm3N/4oh+43/6lIt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383528854"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="383528854"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="919514203"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="919514203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 09:26:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 09:26:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 09:26:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 09:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIuup/zEMX2jRQe6nMfQc9b6ctUmCmPngjbR4dCOShqw7u4qO+J1QeLnNCmbJzK9ZpQcA9oiUVeVYbqqwHblR4fwfipDwGC9zb7kf3Da2b20aY8szlAPgEZdFbL9TemwTrL6jcCGqQtAZbai8QkRC+YHRurdHTvyVHHNkGPGYdWO8r/EYtCzMIxNITXO7XJoc5OUZtIqY61G+51OHkXuHCFuJhK+jBTDEVyCCVERS8lds0iaCDFEDf5esV9s8AOxQXvXrdhCQHo6bYqQIL4Aeu8RpYR1GR4KIHsVsKgyc2+Qa81X7ACkyQ6DlrTjcxvzj3TG8b1Sn2tnIzgvn1ikrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im6nmqV1/K7kVo2T7vhU+yojVso//Cd7LT6+KYhlZcY=;
 b=TpsZLPRu3ERw0AKbguQKadBimYACNOrYEo9MnnIHyETAvfNAggsjK7m42fpg29aP9BGW340/rSMj0mYYAoo+DVrxNbjB6pXCRABzl92Yz9jntZGI1IkRflW3e7BZoHIlemFYYL0S+rh4jJgqxrt4ufZWwov0GUGgEXQf0sWMDSHuyFN9dqyFb/TPIceFw4z/jcsNdNSl7yFag5jGttTTGYxcB6aPTChYqxbp6D/rqS2NB95bvIsU5XyWlUA+FyRLqOFSqdWwhanh4+qDZn7mTYB2FZxwQdSFySu4C11C7byfHMWdInh5YGfHTLn9uQUuAVuYGuefFdhOScpqCHxMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 16:26:32 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 16:26:32 +0000
Date:   Mon, 18 Sep 2023 12:26:27 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Tomas Winkler" <tomas.winkler@intel.com>,
        <intel-xe@lists.freedesktop.org>
Subject: Re: [Intel-xe] [PATCH v2 4/4] mei: gsc: add support for auxiliary
 device created by Xe driver
Message-ID: <ZQh6MzokYiGn0KFK@intel.com>
References: <20230914080138.4178295-1-alexander.usyskin@intel.com>
 <20230914080138.4178295-5-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914080138.4178295-5-alexander.usyskin@intel.com>
X-ClientProxiedBy: SJ0PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:a03:333::6) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|CY8PR11MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 913069f4-6c78-4dd7-44a1-08dbb8640495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwIyDo3YcksVULjqwF4qw0CYEOtY5uvfoXhMKnNCxsWZaTeefZ2ZngLj21FnEDuH64BEkzM5NM0EfwNe37au1WKrXvP/vAW7MMUFaWGMoK/ULFD+G/RGVji6ed/GSj21AMVDixhk9E1caONHf9IGdyDFyltfgMvaFG7sMnCSqTVwya1i3XOz8RyGC3gXd394JyFwRSTDhu/ynN1EZsnvO8YH9uaRMj85sNcboesSsHWsnA/4hI8Sd/9HNNUE0Mxa0f12akq7vrPvTAswE8JVGBmVrDmRHnFGbtp6QrYJ52czsUJ/zaP2wd+3SdkwxTboVQGA09pqt9IyV930eC3uuF0tnaqqaJ6+4AKAX2GLEPrJ367vuAHLg2y1FsquVW9oTH80+mC/zULmOWsCi8RRUX7ajpc2TAjXCdrND4K/TcqBBPkORWTQRJdQWiSNncu1gTz5Shm+wd7hTvG7feKZj0diO1WTFc/eCu/FECRD6HQ+WFYUKbqkxrR1l4orYDhe0I0ggzB2gDaGfTJRFOynCZqf+1fghXUce3d5s22V68XGlkLnXh6gJTtQAsfIc4aW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(4326008)(6862004)(5660300002)(44832011)(6506007)(6486002)(8676002)(8936002)(316002)(41300700001)(6636002)(66946007)(37006003)(54906003)(66476007)(66556008)(478600001)(6666004)(2906002)(6512007)(26005)(2616005)(36756003)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8JPzlPrppCm+a6NiY5+89yMkQBEyC0tSZS4QyVzBWbtcooKYMu/pHeyl7JO?=
 =?us-ascii?Q?o3L5ORwi91fJpXfjFN28Hw7GaVGX26XSij+1+nHy7whM7ltGTm8gI03vutNu?=
 =?us-ascii?Q?NQxfTbclN60TmVGJ9gBnGivUKlrQrvYAbIIe4fkPIl3/oMw4/atyFMMAQ4G7?=
 =?us-ascii?Q?ArMCa8DCQ5BtEmkUdYF+yu2uw286aZge7bHAPPo1kfg3E4viWIzUZ7hljCrS?=
 =?us-ascii?Q?6P/j1N7kggkqHa3BEQ8HSW88ZkV3Bb01bIifCBcHQD1+A75V1B4ozog/YEbx?=
 =?us-ascii?Q?XaMOzkDRTP1+d+xUxtAbOKE8XFMSUPBo6NOfN9yvyLuf+0K4sX5K8tndZPPY?=
 =?us-ascii?Q?1/1kj1Z2LSAJwIGL4pwsYv0JnKwc5zFG+amzqF3iGNpqzPpv/c7lpBZI7DlO?=
 =?us-ascii?Q?WOGH2WSAQKuh5Etgqp6rfvXd8jzXHOOEJeiXyzfNf/IuNj1EhPLUgJ5lwJlA?=
 =?us-ascii?Q?aU1ya7qJKKihMo9xgxc+d6nmOqP9Zeqii3bT/IdxQ/NYz+QBLx1AgSYMaCt2?=
 =?us-ascii?Q?iNgHnzrzoe59r3vQSRHg+ENhGk6i0LjZZTS1jZrd0SSQV0mgEpaqasydVO3I?=
 =?us-ascii?Q?ral7c4/4yO2/cO46kDxSGe4LpcvE2AZrzcnMry5LJ2kj66/4m2qx3re13abA?=
 =?us-ascii?Q?iLX5apdgwO+INaQhPbD25lLOwTy7rQ/ceqFeoC1uDto1m/13goP3xene4U61?=
 =?us-ascii?Q?gB09/ppRnXYvoLtiy51N4Bq3ZWRqJFGs6r44bMwHgloQuLEQchR8E2quV4eQ?=
 =?us-ascii?Q?2FHh51Py2aY/CK48KU7P/4o/3TRCs/MJqZU7uOoXP+bBtLI+UrJufjNLaSoO?=
 =?us-ascii?Q?nTZd2oInIXq3DuEVOvvwm001RS+bP4lWBHOgRzkGPlKoFF4np+WW1KZwnzHv?=
 =?us-ascii?Q?q4eGVI8cCVoke4burqYyzc3nllZY2pcXmJZ96Lr+G/StqGvcDdz22czPeBNU?=
 =?us-ascii?Q?eCgDZTWb1lLOfi6ih46mvgLHv8OAbogdFZtX0j5eo9g3h7Wwe0nw1acnxz6L?=
 =?us-ascii?Q?j/Uzdq1Rm0RvOZ6HFFOWuMS/1f5TrV8GoU5JOJvbsgrK0pBeQVrgxPtBghj4?=
 =?us-ascii?Q?QdB15lKudVUQFHa+MJufPCYdSbJqkOZFQp3ounoNsyDebytuIqx/nhPTpQey?=
 =?us-ascii?Q?4GA1A3NrtKiJ3oJJ0zI7OmS49vzE4X7sbxXtsEyVtcIEmgAJvwIXzp5Nbo23?=
 =?us-ascii?Q?OcH1EjcoFOS4YAPqDkejgoQrM1JqXWGmxaKeUvsEKw6k2+mWi9/Vj54t1lyh?=
 =?us-ascii?Q?cHvP0v7YL9+pTdhG73hreWLuNCX6fTRGABA2XiivyLOjTbOgIk3X0vNYRUpy?=
 =?us-ascii?Q?Y6UCPF7MznYPKC36/TUXDjhiDg1pLppQEsubkJKsoS7CdZzeuCNnCECd3lJG?=
 =?us-ascii?Q?GMCTuq1pKvdSOsLhdhum3CuAMwMZl/p40BrRQOKo2eTidGjVqDH91RNFp6XP?=
 =?us-ascii?Q?R8G1foElUBQxRloLyutV4nWHmmczx8P/USGqlsEH17R2qckucYWsxbRdlRZl?=
 =?us-ascii?Q?6IhPhDf2sK5Iz8uccYKQ3GBnQQL+FAFhpaY4udbtmbQOwap/kJK+QtNAdFYG?=
 =?us-ascii?Q?lOC1fNrIRl9YIjuE4GPizYURDTtBjRWn9oWK9gNo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 913069f4-6c78-4dd7-44a1-08dbb8640495
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:26:32.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/TY9tAMOm8HoCCLK/Gc8qJ8AB9goRRW2tg+l9K/q8OUqv/AUQIjUGRUoPfJqavMYz0525e0YVF+FlaxMAf4Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
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

On Thu, Sep 14, 2023 at 11:01:38AM +0300, Alexander Usyskin wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
> 
> Add support for gsc mei auxiliary device created by Xe driver
> 
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/misc/mei/gsc-me.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> index e63cabd0818d..63525778a4e0 100644
> --- a/drivers/misc/mei/gsc-me.c
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -292,6 +292,10 @@ static const struct auxiliary_device_id mei_gsc_id_table[] = {
>  		.name = "i915.mei-gscfi",
>  		.driver_data = MEI_ME_GSCFI_CFG,
>  	},
> +	{
> +		.name = "xe.mei-gscfi",
> +		.driver_data = MEI_ME_GSCFI_CFG,
> +	},
>  	{
>  		/* sentinel */
>  	}
> @@ -312,4 +316,5 @@ module_auxiliary_driver(mei_gsc_driver);
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_ALIAS("auxiliary:i915.mei-gsc");
>  MODULE_ALIAS("auxiliary:i915.mei-gscfi");
> +MODULE_ALIAS("auxiliary:xe.mei-gscfi");
>  MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 
