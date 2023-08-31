Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24C378F2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbjHaSfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjHaSfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:35:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC779E5F;
        Thu, 31 Aug 2023 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693506936; x=1725042936;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=o6fxA1RUNVERr5Y7OxV+lLu4YAsySOxqABJ5ldt9Qmg=;
  b=iwBI47+68aEk3Erx61CT2FFgOsh8vQxkrqbLwBAqsnViWU/el5EwLmcw
   AmEwOLjsfrtE54Dpfa9VSQEhE4BUxuUfBLrdOxRUhM7m1R5xNDTtgikGS
   DfmJFBgVrjKHOeyuqdHx6UDgY2IHooH1PISszBaLyPpFIjIXZVl6WlboN
   fYSqsBCT+kJFCoXbq+yiGMIuz8QF2jbMR+c19RDGkXpqZLKgBGmwYTmLo
   di4BTswylrFtdMA2ccAAJUiH8igchcYQedoohbTq5+iGBKKcQc09/vCjW
   8PL+o1OhLNDONWbpH+5hlAB68pBeX4Q+7VyOIKeGi4N1gJZ4Oq1afgD9u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356344339"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="356344339"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="829818647"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="829818647"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 11:34:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 11:34:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 11:34:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 11:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU4dMtRyOMfV6QYgciq8OkgQAJGv2e9Ma9nl+2PXxzLPBminyEs2L7+FdvsCS1ce6LFm6i6ykAjJYeymFMKZq7ZhEtkkX7s3xM3k/NloQPMytCrUBYS4nQpNrKlGhRsCOJwjdZFkoLKZAQ9Wb3XcYmM2rTyx7jI72I26CTiZOO0nI34Y7fhxzq6b9pQGilaxFHa9sad6C0KcpysudIiGtFiGhqwo4T/eM5SasQ5QiAVbtAfWGF2e6H4fy1apceKxZRhVJCQFBfpryJtOPmNFY3HO1TL2YKrtgp19nRVaxrY8IAovO0/MuRqVg58dD/GNxPTSR+vn/CvsluGWVgNPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiIw+g7t+r+Th0KMwKtqQwo2UDolDAriEYPjeTN7vJM=;
 b=FFz0GTHQPhiBMgGB+kqwncm8Xt1IuKy5/QUGDfUwexLlOO+79cOYGkDx2Ifkz0mo5ne0eilSmHrAnhXB55NgMZLTe+DZz2JTVTahUMA2eLulBzvvbVWAj5rXUGaPECWb1TpcTyjvHVz6hzTwKIk3ZTzhkRRWm65QuIe9A57/er/2COw/Nd3RDRs0oRMzBR7beoLTEO0wWg02yG2FUqW6HgnsF96h8+hi0Wb46yovNPDzvXn1XlQ4PQOcqYN+L4090coQKHCqBH8Cl8iSXn0lKX9P9QE13TRPlvFvFiJeSZLodP92OS8vkhRSueLkyWiJlB/rO/OY8k6tem3ZrB+R/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8591.namprd11.prod.outlook.com (2603:10b6:610:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 18:34:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 18:34:55 +0000
Date:   Thu, 31 Aug 2023 11:34:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v10 04/15] cxl/hdm: Use stored Component Register
 mappings to map HDM decoder capability
Message-ID: <64f0dd4c8965e_31c2db2940@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230831152031.184295-1-terry.bowman@amd.com>
 <20230831152031.184295-5-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230831152031.184295-5-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:303:b7::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: ddea4492-78ab-41fa-effb-08dbaa50f909
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xgyA41VQKvaX2/PB2FrU9/8ZF3ZYpar792XG4yxnjq7Bn+WqIzuTjZq3FghVcpx2zneh8YWG5bMYO7Xa9m7+ibeJismqcvguEveTQjxW1CE420oRj8pAYnwNSubUAFj6C45zUXMCcHZZCMuQ0d+50oMUEff/yjiPPN/OAA1e/7i98cQ1a85zxAV+ByqI2eWf3rj91BxvclTT0KwlwYI/4KCov6IIOTkw65G/gQ+d7ScViFiKwqKoqQ3kaUPVAORDT4aFqfS4/TA0u/lfkajIu63Px4R+svC8C0L+k0macXapp6JBTBgtHZA3rJBRQVUCQP0C+JW0jKt6O/HGguXQK1QsRT/m7ZUSGk1yjxlNSsZwKvDZX/wa/RNjO5nj9HXVar7sANYXNO7JPzipJGSEU/O8k9ulnVQ3WFvKcMQTCcKplSSktgewALeOjZCMh0WMevwpfUJoa5Bif4D3hOLvInDaUWMgAuxz5awcv5kG/0+BPjGU2XlgvpBb7NoQkQYZQJfa6xPtETuct82Q5paRpF28w1lhJZdnV7Ij0S+ouRpTTcaI3r+UKz+Evzob1EW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199024)(1800799009)(186009)(6666004)(6486002)(6506007)(6512007)(9686003)(478600001)(83380400001)(26005)(2906002)(316002)(66556008)(41300700001)(66946007)(8936002)(5660300002)(4326008)(8676002)(66476007)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CAz1G/3+FK4Bz47SwPRG4e6fzwbnWNZXv4KVuJVg7NdbONXHu8qzqtNQgDTt?=
 =?us-ascii?Q?eXLy1I4+QRbfVLeq5LqEz3m1bRWZipFsYnvcESoQkRsDtzgVVMObjZBw0ywC?=
 =?us-ascii?Q?JtF8EJQaj8irOvIO4Qiq8ALn37hwdh/NU4hVrYVxPOmLK7qCX9UPBbXfo7HB?=
 =?us-ascii?Q?SmXVdzR0aOlvsIh50fQ6Qb6/gqvY0hsmpIWeDoKgpwBg8cxiop/cpg/bzkXI?=
 =?us-ascii?Q?q00OBXRNPeEM9nenWKoe4NM2hx/T2kgmBMIoHo058yeqTeihnxPOjgrzJM1S?=
 =?us-ascii?Q?UiCjb2IbObyxJfunjvVSMnXJwkhSq04qtRcyXKLGgVnJU6UO08V/0ERAeE5+?=
 =?us-ascii?Q?GEA7GZa2dFEIMjs57qepp0xx68yoMnte9hoYCUnOlEuUl5v6nJn1RQoySzva?=
 =?us-ascii?Q?Mqw8A6k00Z4UUEQdUNw2Ih7xJ/QY7+ZaFX1fRmZr1nKNNt5gCJMKMx4EteNj?=
 =?us-ascii?Q?z1fz+Fq+szw8yy5DWdhJQ7tI70pa9LSMxVLIAxkAs1HuENEJ9WU1daCUrbFi?=
 =?us-ascii?Q?KmgcOk2/Itch9KGvibs1wNLjmTWSYv433MKFQaj8MQHxEn1dq8/eeqo/gLG6?=
 =?us-ascii?Q?9l6W4AM+o2PJ3Gcdk2qbvrVC08Mjcp6sIItQTAysCThGlCAnEYN0PQAS9Jab?=
 =?us-ascii?Q?lHyTqFygqKQpyJCOlSn0vYGJrqPtfqOPX5WjGTgu4Xme6c9pSI9a+zE36Aia?=
 =?us-ascii?Q?plyuYf4UaJQUTvANcZJI6rg4/MQoLl2cv7sTrTQJR/FqgVaj68LOu3kAfSR6?=
 =?us-ascii?Q?tTnDW3bh37XaeUvr1W4DfjQLlI8Gd/49M03GTWXHdaSgPCgOesj8sbCKuDHz?=
 =?us-ascii?Q?1azpbDqEwf6rm4gRC7uA3LWXCiSsjNA+to2nn5BaQBOZkHFUjzm+68UbFox2?=
 =?us-ascii?Q?hTDFOmInoYmgn7wY25N7NUGb3nA10rljAFGnqqLIHOF3A1JrIaupJnRupVzj?=
 =?us-ascii?Q?xJC9KFSYFxL08aRPn0B0u0jHy85pIW/elr8wsGPbrkdhGFROusEwqpsOKwDd?=
 =?us-ascii?Q?Vi0XWHTIcbx9vvu2HyCcwkhe6745+XSEy8QGcHKZrSHtf1XV2d2CcRC2mW07?=
 =?us-ascii?Q?aIJOqfRDrgcFCbSKLFh+3b3DQZIeARFY9IdzxUgYk+IK0y43gV0M24y/jYzU?=
 =?us-ascii?Q?UBxqTgirjNpOAW7ti5xENrDgRCgnNP4QJpggRGeeaWNwpzUlNkpK43v9wzW9?=
 =?us-ascii?Q?/70N94XGtA5lOs2zOBdmmhk3D4lTKAUzYNWtNv3Yw12iSTlOLs9dy5NN0sBw?=
 =?us-ascii?Q?MHeanm2QZJanuSJN/ssVV4CMeImLiil4LPvOgZ45hXVbYdSQCZppO3NpG4Sy?=
 =?us-ascii?Q?IkDx6ZBszte2vae/DeMa9hKt0jhUiY9IEHlKOdpD9UFFVdIeYmByfg6YmZxb?=
 =?us-ascii?Q?pLJjX6/jZXdA7IfZgK26AXF+jLHKThu2BNEcPQBhN6t+46j/aUrg3IkZXn9z?=
 =?us-ascii?Q?GnE+i2aj3K62NwcHET8QPpQq9iENoyFu8knqDjpPPjOeGr026G7MO02HPYcf?=
 =?us-ascii?Q?Ef41IPmT4kOGlJU6BoXwRYy/QjJavzMEvuTv6qFjoetZ2we+xHFVQ/U0fIbC?=
 =?us-ascii?Q?CnSqz1VeKUGuvdjNaERJDRKz01/MADJwte/6cBjqr81j6c36OeLc1DAFpc3M?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddea4492-78ab-41fa-effb-08dbaa50f909
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 18:34:55.8355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9PZBcbNNAllSZWIPUftiJeknJlMnh8t19NY2rKQvc5WbLTiYAxzsr0ZvxO/SG/P5uNRluam79/puOnKN4Mue+AfGH0Rh9E5y43rxSkD/ZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8591
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

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Now, that the Component Register mappings are stored, use them to
> enable and map the HDM decoder capabilities. The Component Registers
> do not need to be probed again for this, remove probing code.
> 
> The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> Endpoint's component register mappings are located in the cxlds and
> else in the port's structure. Provide a helper function
> cxl_port_get_comp_map() to locate the mappings depending on the
> component's type.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 65 +++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 17c8ba8c75e0..892a1fb5e4c6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -81,27 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
>  }
>  
> -static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> -				struct cxl_component_regs *regs)
> -{
> -	struct cxl_register_map map = {
> -		.dev = &port->dev,
> -		.resource = port->component_reg_phys,
> -		.base = crb,
> -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> -	};
> -
> -	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> -	if (!map.component_map.hdm_decoder.valid) {
> -		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> -		/* unique error code to indicate no HDM decoder capability */
> -		return -ENODEV;
> -	}
> -
> -	return cxl_map_component_regs(&map, &port->dev, regs,
> -				      BIT(CXL_CM_CAP_CAP_ID_HDM));
> -}
> -
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_hdm *cxlhdm;
> @@ -146,6 +125,22 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  	return true;
>  }
>  
> +static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> +{
> +	/*
> +	 * HDM capability applies to Endpoints, USPs and VH Host
> +	 * Bridges. The Endpoint's component register mappings are
> +	 * located in the cxlds.
> +	 */
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> +
> +		return &memdev->cxlds->comp_map;
> +	}
> +
> +	return &port->comp_map;
> +}

This was the function I was hoping would disappear in the new version.
cxl_pci and cxl_port care about different register blocks and have
different mapping lifetimes. I think that justifies having the
endpoint->comp_map be valid for everything that the cxl_port driver
cares about even though it duplicates some informatiom from
cxlds->comp_map.
