Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3868D7A23D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjIOQpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjIOQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:45:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D01AC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694796296; x=1726332296;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=E5rMo783Njs06qdcl2C8oLJgQPG1OhtMhfsPLYQTCVE=;
  b=PkEt6wOEUTmiXDzxvglwt9b73USU+olez/mAcs4y3LbSzF19h2Sg9pzw
   8gqF4qHJIcR9HTL59v1ytQa3+izskR0yByHD3kHnQeFsZ6zfNiYqvaTrd
   /HdBx0kbYb/dQIHZfVkziaIIQoRG3VkFwctfkXVlb0ySFIgBEy5pLvXPc
   P959D5d4egyZutjXfbR5aMMbyvLrks2Vros+5+bQhAJMjotBmcWFEjvWw
   71bxyghIIxhIUydViM1hCWqkxWEKunnhSOk8H3KR7NvGXn+KImcAr7Wgz
   994PQ41TthwFSdEUzH7Paq73gFR8shgY6bK0CZz6bwz4OhwRaQgCemLDf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="376624695"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="376624695"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="748260327"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="748260327"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 09:44:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 09:44:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 09:44:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 09:44:54 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 09:44:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiRElSUbVihrhwM7l80t4f3kneN+SQBdD9JX7uBVcul/jukoi69JGl71TuidFzHffRFkxlF43PNWcdGZRKyxv+/Zfu8pN2w5Hr/b0Njk5MK6LQVWHaGw07rf9ZTz8maZybgccwa9CuSjWpbBBbrtKPxvJ/KMAdMsAJxD4XoEoAxirumqLkKkZMW9MpycuTvctAacsKk17ZxTt3eAxGwQTjMh7CRljgnPkb+pLTUVnmXXluqn9YciGelLGE5Fk789Rl52EoCepNT4j+1HA3jBURDFuL8XukBwBYpWfxEtgdApGlPhZMIRXMX2P2UqV03AOtAqWjyWEtONXLjr85kOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAYxnHY8Bm2s7Hb/dbpi8Shq82Q+bW4aKdEf7iZgA1I=;
 b=lLuIhAqG6wrQn38YLZJ4cbqffsIvYNkJqsHDgNLP8G+OIresALnYprIO7d/9+UMsI99vfTyoN5dXjljmM6rxF/62tnIx/exb5FXgWU1UERtfPyugHbyXZDj5HXRL6Zr3ksyK3kEgs+1vtQQCikg84KMJOL3vDod+Mk8MCn/MOPGFeAmoxCUk03tcpV88m6RReSBT29/y+WG3GrghPjnJ0DAUrBRh4dtoYaAf7tcJ3QBJL1Wvv85V8zjesDoDPpGdnZiXlqpjqaQWaHm3GFNOonzS2U3PnTQpoAEzqM/fULD1B9EfVZ92qzJF+9QWtcvEejYswJJWJLA4YuZ/eob0ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB8566.namprd11.prod.outlook.com (2603:10b6:a03:56e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.32; Fri, 15 Sep
 2023 16:44:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 16:44:47 +0000
Date:   Fri, 15 Sep 2023 09:44:45 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Chen Ni <nichen@iscas.ac.cn>, <oohall@gmail.com>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <aneesh.kumar@linux.ibm.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Chen Ni <nichen@iscas.ac.cn>
Subject: Re: [PATCH v3] libnvdimm/of_pmem: Use devm_kstrdup instead of
 kstrdup and check its return value
Message-ID: <650489fd836d_37804029451@iweiny-mobl.notmuch>
References: <20230914070328.2121-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914070328.2121-1-nichen@iscas.ac.cn>
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f3cb41-15d3-4b4b-5b65-08dbb60b12a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teKQ9Jbo+73Srr8rfohkzPCBYfsL2LG78Spe68a6RfdpPJnJCxtIAF/HQ9A6Q8xSyL1uHlydQddZnbRRGbmOJr++McwZB523tHq5FnDQfcB7jT3FtbttLSuJKjlBal4g0nrEmyWGnvziMoOS5UPRxporMzDHSWOC93Y66FSc3KXeYnzvJPw3RlfZfSEh7Aeh2P/GWAew5x9krl8kRuf90Kb+aUE0PgRIhay6vMpzWSeOhenjIt+1pk7goBaVRv7jkbQYNO62vbdR00eAH1aAqwcnxBNghSBQapVRD30Y+3fCPG4GSOUgpgtOunxr6RCkIKG+NX8iBFr8WG8f5rlx4GHclfL/0ENYs87Kz4UGITM1mKAN7/dFlgjxAW4LPI2QPCoNCjWnr+nDM11I1kfbJjWcyUoA3RTaKl0auuc4GYyXQ+4BvNTysP8atSDUZgDY575QlTOEQPDD6jf9GDgH8+SxxRRzdWD0hKR4hcCJkcoaCS6DCzwC4NU0LAl1em3Sb4hojpahbQIGk6hTU7aza5iU53CTQMGtRGz5uLynM0VvCdoRByxr+ctr4z/GpBJx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(186009)(1800799009)(451199024)(9686003)(316002)(8676002)(66946007)(66556008)(66476007)(478600001)(26005)(6486002)(83380400001)(6512007)(6506007)(86362001)(38100700002)(82960400001)(2906002)(44832011)(41300700001)(5660300002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZSeadA40id4rlQ6ez9iYNEz8IgcSCQGNACTNouYv9s2CvE9tfjTFTExWOI35?=
 =?us-ascii?Q?rW+Gsx72KeYHJmQ3QzoLYgdYmB1CopFPShxE+qnij4VJxnpSZKTWW05tUF8Z?=
 =?us-ascii?Q?kTTNlzxutUbQEb3CC3amtv0lPsb9d3/8us/vK845CqrqBJ3/j/xjzNoojxTq?=
 =?us-ascii?Q?ftASZFJ6d3vnBnuBlj1iRW5jTpXDnw2JOP9iphCS3OSH2gDqOYn2NP4yv4a7?=
 =?us-ascii?Q?VeL8eecBx6+8T/Q9DC+ql9ub6KZYxQsUXZzR4tWLm1o6I+qswyLf0RCPnUXF?=
 =?us-ascii?Q?cd48ELDBnxR7/y3B0SONPgnslXtsorGFtDsEW/w88+0Rms1gnjNGN+ZCv+8d?=
 =?us-ascii?Q?imOL4FxnPc5eHsdpVl4oPCETFkJoZ8QvBeiIxntSfJ7lTTwuQvLAoteMwlZ4?=
 =?us-ascii?Q?fYgx34D+Nt90iH8OGPvY5kUt+zoYZbmddLE6LDX4A0lOGdBkaOpPariNh0PJ?=
 =?us-ascii?Q?3sEupPr8Zs3iutpKH8PpgWzyc4A8T49faL+7H4JAdhXUGljySQg6BL0vQFas?=
 =?us-ascii?Q?8w7ugX0ifa2yIWCJIGSP5y+I/VuP4t0ptXpYdIEI6j3AsmZNLV3y7dgVdgpb?=
 =?us-ascii?Q?pYBP3WoPOHkukf+2f+npJC5IGsisvf3YWyldLyim61csof+wqNyy2oLJQhIb?=
 =?us-ascii?Q?U1lQQqG9iu6xTey08H/pNOuX9mSoNo/VR4bcFMEeqEeu+Tj6uL0ZTf/o0xun?=
 =?us-ascii?Q?3f3oKoBay+nUWH8Pw5O+1UKMToboIEn+3XdxeBAo5E7YfttRBTHiycLOSc6M?=
 =?us-ascii?Q?+HY6GUyI5HNKZOjaJGX3o+l4Kzb+wwWj3PWNjOrPjpfZPO1YEsYRWsxa9wAU?=
 =?us-ascii?Q?CY6V0CABJbB4vEp/Hy5BUyiQsQXptsHNCZdCgODUuPTCljGO4WIbkSNzAkKd?=
 =?us-ascii?Q?6/YGVAdtmFuX0H1ZTP9zgUlzDcdxiJjEdEenSSVwQl0a0LY5pQ/uMqbjFtuv?=
 =?us-ascii?Q?k7fkBwJM6FyfXcnY57JPCHXWpESo9zbt6wiBd+ShCIuy5ejAGCM9KRsscZl0?=
 =?us-ascii?Q?MWQRj9j98914jXgEUvrTFtkuGQKjgYdO+bAbcfTJF248vKTByPFfyDOyanls?=
 =?us-ascii?Q?QbuBu58yV8E3RoKDcZmYO+9fJxJm6jcJJyUKeEVUtYB8vr9s4z3yLXs3clKi?=
 =?us-ascii?Q?/0XA3fovVy88zOnl2ssESg2TWYGac9r3/B6Ca393VRiEKvJ8Ky66VCRmph8c?=
 =?us-ascii?Q?8sYu+5a087WnM2yOGszKqacdiiUN6oXbtlDk41m+OejQB8ZU2gSI/gK4G2HR?=
 =?us-ascii?Q?XClgeHtHWzd3OnYL75kT676Ya35FFm/RLeOiuWxNO2u3qx4nAN81hhW/oSXg?=
 =?us-ascii?Q?O1qhsWsKUfQeAkEL1JX7J7UkkmbA/Vt01RknJBE7x9ly/h+xXw7+wVC4rEho?=
 =?us-ascii?Q?PuFGkc+zncJZ/rTkVd+KgppubZEe3XROsDY0d5YNrq9M/6xkxQHRO3XDr907?=
 =?us-ascii?Q?fcycGSirACymRIwh7Et3DuF+yy9s2cGXJDKY3kG40okPZlUqdHdyS2MDINq7?=
 =?us-ascii?Q?QCXok9HOdqMp0n8CECtFhJA7WLjHWYD1cMIwCLdU+DU+kPjU1CVJTttCS0XI?=
 =?us-ascii?Q?RQFg9cLr8QqNRICxkNmVarpV0eTqx9qu6c8vVWXx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f3cb41-15d3-4b4b-5b65-08dbb60b12a3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:44:47.8219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxvgfUrbDKuQQ43nIhH7oF3H2+bFfHvAabUuI4hGb6ZtaeuioLv4Bn1RBlxlOEEYBt+mQstiD8dSvrWtpdICGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8566
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

Chen Ni wrote:
> Use devm_kstrdup() instead of kstrdup() and check its return value to
> avoid memory leak.
> 
> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> Changelog:
> 
> v2 -> v3:
> 
> 1. Use devm_kstrdup() instead of kstrdup()
> 
> v1 -> v2:
> 
> 1. Add a fixes tag.
> 2. Update commit message.
> ---
>  drivers/nvdimm/of_pmem.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 1b9f5b8a6167..5765674b36f2 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -30,7 +30,13 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
> +	priv->bus_desc.provider_name = devm_kstrdup(&pdev->dev, pdev->name,
> +							GFP_KERNEL);
> +	if (!priv->bus_desc.provider_name) {
> +		kfree(priv);
> +		return -ENOMEM;
> +	}
> +
>  	priv->bus_desc.module = THIS_MODULE;
>  	priv->bus_desc.of_node = np;
>  
> -- 
> 2.25.1
> 


