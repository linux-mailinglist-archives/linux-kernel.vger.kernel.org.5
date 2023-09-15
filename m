Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9427A236D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjIOQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjIOQUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:20:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941AC19A9;
        Fri, 15 Sep 2023 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694794816; x=1726330816;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F/BWrTMEbbMMqU7vuPO2LTTHt7BAAZiocD6mqBc0hs4=;
  b=WW8IdFNPXjyFzYh9nDo5xQc2yUvKiivklH4/qVvS0dFoSL18vjJDcPAB
   2ZTANXjFQ5OyQlEuIpyRQXJW/jZLI9CW/ao8VTRO3ouK1UT6YgA3Tr0eu
   55JIswbVC+dWrGVu807CbHxFXzqu7C6uRiDn7Q1QyLeSM+Zffq5xlyQlw
   yhL9BRHva8e+G20S+vJ+pDu+sY5vbqahQR8LSqyV5fnDf3oi38IeNvHUY
   1qllmnlcGbT3kkUmUrqSJk8Nk3mnI/0cmbFrvAB9kVBcJPqNzMYg+5KxZ
   7H3KV8kKwASQZEkSXVAKzeK4sWwM88Oqpsnry0R7PRI5IPs92sh+Ij5XA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="369602095"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="369602095"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="835260657"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="835260657"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 09:20:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 09:20:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 09:20:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 09:20:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnkir4XVbJwsaUuyoN7NugqxajWDs48LoZwc/S4H0s+8MyMz8FDTaKwzd+VKe9owlSMwx24GCVG3temdoAH+u2sS5+nlY0fAmvroq1OaF6dyUCxk5ch0KVFmGHgtewF6DP1K1Lb32r4yyuxluoGWyLOtn7asKGGNBwZjAZuZqXXDUuIB6rVwA3AWbOTsyzeLNgMc21UOV4DlPE8LaFfX0M1c9raIIv04YHEmmaWahPFUj+YYhhfMeRWqbj4ojb8cvC+GbDhydSQag52ZxtH9KvhMV/MijsVxpNVCjshaIqrxzaMdRGQ4CD1y1RkuPBn6tpeyjG3MEf9ioCu5jupd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVnJUAdiT7o4ieLOton41yPpk3jNF+v1um5hjMxJ9Q4=;
 b=Ke9b55iFzRakebTKNNw03OKyd5m/cR1JaLCzrEXIfn2O40sCFPWqXBXBo/NAZQajXqGaJEPr+AvpVlaehSuuIN3kdKY9XCwj42HrToxq4O6zCL2YVtKHmSip8mWHwHOqQevDki94Tn4B2PoquBtL+jmAc/8J63Sn8QX0NL1u5x0RlwXTTALgGOSKDvEIq4HapK2hQdOPzBfO4cWlkIcvnDZckKFswpEZ+dxMgXFqP0KOBJuSJRoZ0R7q63sGtDvQbDQYAS55vL11nVBBuDpZWePto/pjjf3i4QMgEQ+h9Amid/IShlBDIgOf8V0aOEcQ/fmM7gljAxa2w1qmEz1+UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB6816.namprd11.prod.outlook.com (2603:10b6:a03:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 16:20:12 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 16:20:12 +0000
Date:   Fri, 15 Sep 2023 09:20:07 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Yu Liao <liaoyu15@huawei.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <rafael@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>, <lenb@kernel.org>,
        <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] ACPI: NFIT: use struct_size() helper
Message-ID: <65048437b07bb_3777b5294c3@iweiny-mobl.notmuch>
References: <20230826071654.564372-1-liaoyu15@huawei.com>
 <20230826071654.564372-2-liaoyu15@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230826071654.564372-2-liaoyu15@huawei.com>
X-ClientProxiedBy: BY5PR17CA0010.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4e60a7-78d7-4d88-7d7e-08dbb607a30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0aoThVYzm8r0vOq+VQowhb+2pRcwTkzMY5tHMihWb4FyzRxOz0Qf6Za8/jj5UZ8w65zgDYAzaKSME+++ntt0bxbiZRKSLbb9O6LjujznuLzEm8RltR63fD/FLTUZdUHrUIEGSr4OCzRCDHLVdX4PQS/AkBpBJ3Be8B8nmd52TnyXRX1A5bkdlMg9sG3CFEmntbVRMvwcELyQ8Bk66nRxKlMBxwtFawiwgNSNVGov3d7Q6biti1Iu+vqc12PZ0gaNnJ/fd4LxkDzn3id4mBG5xIu/6uH0h2SuHh1Yo2urr/ZantmTEk1BUdcvicEfqogdzqHSL0r6rGW9aHEPOfnDqx7Vs9MmmSpA3vp7eWO4tuScAe3rbxnYmPgbaGZ+MYPaeKUylHVj6knUqwgzo/UchFbUjzVPaxiTIlmHE7LRkopTsJNSkXMI0aXNeamBsSNyYMEOvESrKyUL3mJrjwrO2wyA1ZN89bMJWH3VM+AjbJI/whueyZfPZkTPEEA/nhDLMvLLcRv65zhOrNzEHsCqXt6I4PwdDQ+xo0EAcD22OsbAtSe5JLSspGQQCNIF1X0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(1800799009)(451199024)(186009)(6486002)(6506007)(6666004)(6512007)(9686003)(478600001)(26005)(2906002)(44832011)(66476007)(66946007)(66556008)(316002)(4326008)(5660300002)(41300700001)(8676002)(8936002)(86362001)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVGy6SOcNaXoaa1fbzS/v3TLEk2493U2t8PwIbp399cgPRrPLr7YW+cuQqzB?=
 =?us-ascii?Q?3bcyGYnX2USKKWsbYC2A16xHMtLT+nH2EWXngDB+b3Kd0t6EFEvC9s0aWf7K?=
 =?us-ascii?Q?IatlcrCT0QJmLyErUUOLj9J71Foq/UTmpuShuOWUEEa5vj7JeK0h0+UAxVCQ?=
 =?us-ascii?Q?1o1wFrvfYmVs/TG0wW5H4i+mGGgKNcentj4ZuB2Q42674X8MfpvGth/u2wUf?=
 =?us-ascii?Q?NE1dQeBBdnAKNqZUGFRtfUklnvacweHxWR9ypIXHM5VtcB6fJI/TjHmcUtaH?=
 =?us-ascii?Q?lvwdKhvRwq7zGnQFDUxMKMJNpjPfA/zFqe3RT+NtqCfmx5ct/jj4I16TtrrL?=
 =?us-ascii?Q?KyVbDBnFI0TijTvVNPMrkYL4wvDCe8LhcWGKx7dM+Nh0q0sH9/EK2o7y68iQ?=
 =?us-ascii?Q?uBGz0RUX9NLCxFlQ0FbDrOV1iyw3oCJkqXqJrpEJbMs84SwpOH3yioEtvfxW?=
 =?us-ascii?Q?eS/nbss7DjgGd0nikPiywBvlRStdF1wSgRxXUVfswZSa6SaUPtUn6qEgacb8?=
 =?us-ascii?Q?qYqoxYtHd42wStIkNsdwCxeowlPRQOlr1aJyEJXJoskoGXzSIbE0X6UmOrhV?=
 =?us-ascii?Q?zfG8lRZ24qCLyZvpmWTVPlFsPvSLoAAeIhDnN/dNVLnwxnSfzurS5KELMhpc?=
 =?us-ascii?Q?T9lm36ST8r8/bby5KvcLK+MsVquhUNaOdwzJWd7mBNknghudjarIXB+i0K9z?=
 =?us-ascii?Q?ZXLCKgjeN1ZOz13CoXvAdQTvGR0lntTGsUyHO+SkGx6M1YxwmgsoFvSqOa7k?=
 =?us-ascii?Q?gSB5ic01rDrmj4r8Zfyml4M+4Rp+jUcpeLYVgzme+T07mRVO585jA348bKdA?=
 =?us-ascii?Q?1wuu1TIWajfCbf5uCUeO9kuFKGTj3jSxid7S8dJ8QfFyv9TUE8zgqYp1kyBC?=
 =?us-ascii?Q?BtKE3cVJDWuemhn46VeqF3/j9OlVGDhdllZusk5N3eNIz9Hpbn57JGC8tTvo?=
 =?us-ascii?Q?TzAirDhspgf/TNnZngoXsbvnkvdREPypWCfPcQDlEB6g8T5i8CEMVEGT8yi7?=
 =?us-ascii?Q?0OxnwCd5mapbIzMszvRZA/sVXAeowc3yLy44eRoCQUTAsTZSn7TNvD+LV8eI?=
 =?us-ascii?Q?a5dKp/U6PR/rEUdOqTKh6jJBPdetHLuhLzXBapD/qLrRtmgIRQbJBlVEXMBS?=
 =?us-ascii?Q?xp/xGuqeKSYpm/HfgwvB0RPwYGOXROoA65/WZQQISTrZSCW06/cUd7q7yF6V?=
 =?us-ascii?Q?qUstgIBXIHz/EMqjKsJNJIobe/4BZ3VdnovGMKUUxsf4KdvYkVd0vwXh94zK?=
 =?us-ascii?Q?yTIk+HAZbnkMuRrVBEU/5zzN+asF4GMvRxbl2n4vB7w5ZNEnkqP3SAXSktIm?=
 =?us-ascii?Q?pHw1k7Ltj/liLAEE7BFHNcCuia8swopvX1q8GtKqykXrUSSV4yOAwUGTVJgf?=
 =?us-ascii?Q?jMO/NCKiHDDFwufnsHdZDvtcmJseHT12CZlT4O1V+mLKK7nRrDk/bySdviua?=
 =?us-ascii?Q?PsmWj8RblPUpc3JHOogwe0mwSnp62HNhlSOKj0rRnTI2myuoJCvYC0WFmYEe?=
 =?us-ascii?Q?nY3DH/iZtYwvcew7w2GFbx7UwOEkO3OOXq/WjfPdzZ2X+r9HlwjzOTTMAp1C?=
 =?us-ascii?Q?FomSKPcesa6aNl+juOQ/Dx50cl0RU2MGLpOphSO+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4e60a7-78d7-4d88-7d7e-08dbb607a30a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:20:12.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eg9IJbOOE58qx4jGCMRDSkAI42H9tDtw2cGUYIwR9xuxUmg/4uPZwZTpunTE/r0nilOwcca7HcHL1v5GelmKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6816
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Liao wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/acpi/nfit/core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 305f590c54a8..2f7217600307 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -712,8 +712,7 @@ static bool add_spa(struct acpi_nfit_desc *acpi_desc,
>  		}
>  	}
>  
> -	nfit_spa = devm_kzalloc(dev, sizeof(*nfit_spa) + sizeof_spa(spa),
> -			GFP_KERNEL);
> +	nfit_spa = devm_kzalloc(dev, struct_size(nfit_spa, spa, 1), GFP_KERNEL);
>  	if (!nfit_spa)
>  		return false;
>  	INIT_LIST_HEAD(&nfit_spa->list);
> @@ -741,7 +740,7 @@ static bool add_memdev(struct acpi_nfit_desc *acpi_desc,
>  			return true;
>  		}
>  
> -	nfit_memdev = devm_kzalloc(dev, sizeof(*nfit_memdev) + sizeof(*memdev),
> +	nfit_memdev = devm_kzalloc(dev, struct_size(nfit_memdev, memdev, 1),
>  			GFP_KERNEL);
>  	if (!nfit_memdev)
>  		return false;
> @@ -812,8 +811,7 @@ static bool add_dcr(struct acpi_nfit_desc *acpi_desc,
>  			return true;
>  		}
>  
> -	nfit_dcr = devm_kzalloc(dev, sizeof(*nfit_dcr) + sizeof(*dcr),
> -			GFP_KERNEL);
> +	nfit_dcr = devm_kzalloc(dev, struct_size(nfit_dcr, dcr, 1), GFP_KERNEL);
>  	if (!nfit_dcr)
>  		return false;
>  	INIT_LIST_HEAD(&nfit_dcr->list);
> @@ -855,7 +853,7 @@ static size_t sizeof_idt(struct acpi_nfit_interleave *idt)
>  {
>  	if (idt->header.length < sizeof(*idt))
>  		return 0;
> -	return sizeof(*idt) + sizeof(u32) * idt->line_count;
> +	return struct_size(idt, line_offset, idt->line_count);
>  }
>  
>  static bool add_idt(struct acpi_nfit_desc *acpi_desc,
> -- 
> 2.25.1
> 


