Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8EE7DA2AA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346593AbjJ0Vvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0Vvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:51:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0ADE5;
        Fri, 27 Oct 2023 14:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698443506; x=1729979506;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tcMnJVuRhVNF+LO7qtA9I97LVNepV/bORXUUVNU6AfY=;
  b=EpmleVaJ15ro5Mkl6943v+4wQeVs9Dki5bBRL0/0x+3MfiarKLui0VOp
   BeXe7/igGhTAYCcE51WwlJBGocf3ZPVkXUZpAFPWJ2gfz30XBlWpN0lk7
   l4MSbd0hl4pCynF+6aYvq5iqSysvOtNOxmbulzy8Rz64Dxwacmbjah4eg
   BT4kHrirVzv4f/pLGsnEl+78oOsHVcaeBwl8F68Jm7v2YB2rzyJRYwO1h
   1wDao5EwOXo58PR+JwykiXD++oWoYTAONQtJj8IwtbuIHWKnz+dIdur5g
   Mtm5MPVQ/j5OvkbSQ/M6Bz9z+lXfQEuBj8Fb/Bg83c6eqczKKQDQ4mOZ6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="9393100"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="9393100"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 14:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="763346779"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="763346779"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 14:51:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 14:51:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 14:51:45 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 14:51:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2boGpcPc9j+ZKXhKdTg6siuxBXfhzp8HqtgVXfYga9GPKdmn3WUc158PYIaJahyK3onYs3jk1Wz98GP9ipDRwKXmtzHDOmpQqe3JR1tphA4hfr6t9chxTzvmI71XL+Ro8Ebz1DOYFx0BrbuugXiYHUYi78+/9xMeIiROc0GuM4HGwQ+SVRsSTdbE+x717eyywOYj8BWysZYNDgVuxBBeHv/ZBqcZDPdsLTtEcLTLpoXMd/YY/wvB64SwB6uOGg+PAbHZSfw8f+nlb6Ljh022fmPz4TROUXKuSQAYQ4EcZD8h0zwokJQenWf9M5hUlMBZzWTYSRCYrNe69/Cw/B73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VabL5PbJq11dBLQVjVEJ5EhgQpJwHwpO7TbLKAXJdZI=;
 b=NYYNzQ3x+N5YlJIsUEjdGehD7nJHf4v++y5eWztWKCwZaQgk9GS1S0m7lwGOW1CBsxN84A/A+VQRKuhT/1iMrs9vysXXsszyG+09yjp0K4u4yQXiMB+3dDDZU9MHVXICzul2QVYhSiO75KPaA2lS8oLNqbUBHVBI4ZzqWY01RMMupZ8Xizb1sBoxp+/rgZuOowG384ky2BNcheZb+qBY+v13ATv1MX3hCjV2OB4JaQn4qEzAgaz51sBfIRQUVPgd9SWrFENDCOd5w60zO1KqzeI8WSbYFECaIfARbzdUoHztGmqbDjBLwbtkZ65oilVhETG5MYGoFC4PXoxtkTLWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8744.namprd11.prod.outlook.com (2603:10b6:408:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 21:51:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 21:51:37 +0000
Date:   Fri, 27 Oct 2023 14:51:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v12 07/20] cxl/hdm: Use stored Component Register
 mappings to map HDM decoder capability
Message-ID: <653c30e67e848_244c8f29462@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-8-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018171713.1883517-8-rrichter@amd.com>
X-ClientProxiedBy: MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eb232d5-4967-412b-0f5a-08dbd736e4bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJOQRlyA5wXNBCuySGyR64IupwlC84UzFLc+ZiCH2+k7I7Yj3OK/vzkGpUp4Dp16o7aHCwlA84TLeA8lrWZ2OohcsZGq1ei6Suppw8n6qAYomuHGLpTMt63JZ+L0nvY4DNA29L7ceIzu/TVfWyaP5dWPz88Mve2AdMVeAS+riPhokvmDPXF63lKe3M73R+Nthndo/XWmcAEt9uQMM5OwV/nXo177pQ07G9HCj33DwA8Uv7CLyvJkz3DJShYB3cpyKOEYFoniwZ1LDSSmuryjvtg4OWN4D+LgOSclNcQjbyHdn5E+nPNr8lpObSyOwTmmzgUD3rEr5Tudhqd0tdKVJxnxyywm0rR7n99onQ9Wc79iVUvmEjeeQlGMAeQwGeB5GPC4zxHjRelQ5p5qFURYWS4+tKJ342ZFam7A7GczWCQ+eVF4fpOemeh9rGdMCBnnEITvOIJ0LaPq6xXTCSxdn5idMNjjLAqeIuKJ+mYhWH68UcP1ygNJZ+YaHWHgl/j2jyKYFRnuulDqKiChOO0bGRAHc2B/6i9ibc+kTvR4XlcigvTaHuEyruP4iJYJ9Zgd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(41300700001)(5660300002)(8936002)(4326008)(8676002)(2906002)(9686003)(6512007)(83380400001)(26005)(6486002)(6666004)(6506007)(478600001)(66556008)(38100700002)(82960400001)(110136005)(66946007)(66476007)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jkLKGQ53WtAI/kgadHqLUvjUXpkq+UGFHmc5YmSSwHaQXIq6bEE9Ve7uppaQ?=
 =?us-ascii?Q?PQ8NPJt2/JJNOuWBIcdBeDliKO1DXbcPUQJDvAzfWIsaN0l/K4HUXjE5sZrv?=
 =?us-ascii?Q?GUj2oWWfXCgl58x1llbebIJIIrnDNd0PTQ1IJXKSd2r8N4SKwXcC9fbA1qDM?=
 =?us-ascii?Q?Krpt0v4Y6floLsVCIWHTczhs/VXm8rwFM9jFCe5Nvp8UvG/+mtnBQSCvqb1w?=
 =?us-ascii?Q?um6n/kYVqSWesQ9wBksGgm+vhaa6y0Jytk+GSQv6oAOP1JWw8DvZ2z0KEh02?=
 =?us-ascii?Q?kYNK+fkPgYXUhEUdqAAuT1YBGbEl8Nedj7r41tL5pwmKLKdhtazUgr7xdrQx?=
 =?us-ascii?Q?CB7s4/629eD5JP87Kjhjs+zyLOcK3Q5iIvDD6TUUSnR+NUaZYlrF9+7+2SCm?=
 =?us-ascii?Q?fZXcl2uDNn5e2B78VEPlkvAEjZ7M861Wovcu4kEpXBbA9SQEwUdUFDVA1xz5?=
 =?us-ascii?Q?Zma8AXbEA0y44FzdC5gdX7EPTEL2a+A54A/fXGMs0YQohSWuHv45NbKjk8Ac?=
 =?us-ascii?Q?ZEaP0KJ3bYAU9cI2ZwEviOWWMmDYE/amEFf76oNpnIuyQod29f9p2dT+7hth?=
 =?us-ascii?Q?N24l7VmflyIrRxtQ7Pl7l2tLHv8Ez4ow8S/8x1qpbrqzHYwd1f1RIXzMHTxH?=
 =?us-ascii?Q?YVsEDhAm4wsb54UwBOEvQW2P2bhDAHbpAiUZH2GLIjnNCqPPGwYTDQxNlpL6?=
 =?us-ascii?Q?pxmILzzmmF7JKLFVyR6m1JFzGXB4yy0zVl1QQd24rEu2diYdidmPAmKY62pV?=
 =?us-ascii?Q?LPB68WUIbMdJLyx+DBeg8DHdFtUEGcyL0D7yPPDq8V9mmnRCzn7uSgD/ddyF?=
 =?us-ascii?Q?1JJrlh8rZrp5PJa799N/+aNFW8SDZHFW3qaTvSle2cfUb7ZYqqe3qSH/UDop?=
 =?us-ascii?Q?6jGIhVVzZExpADgNqkTqVMmWBu/AHL7mTEjE3DGM6/DEL/08Qvlky/bxsV+m?=
 =?us-ascii?Q?XLgY3wrtoQEGqXpiF3SPQeZVcGr85TDheaKrGWAORjgsuRx2FD+3ykg/brtc?=
 =?us-ascii?Q?VJPrLO3hzdIKHVJ9HVmQzufo1jXyuRHg8ipO97w/KyaJ7wV/RyspbSTbA1vt?=
 =?us-ascii?Q?FAhlYF5uWVtHePCIsYFM9tRbaU3jgSZVWBdp9FARB37rCAwa6wqH67f5oHcO?=
 =?us-ascii?Q?4ijEaKSUbiwjWQBWglgIFI8YDEsdyRPKAEAP3ejWwl9F1SWLWpinkPZt+OwD?=
 =?us-ascii?Q?Pm5bmwGPzDrs4iupW7pCSNEkPWjLCn7OG1TCa8KYbT/GwlnNjNikf7Z5Qm7T?=
 =?us-ascii?Q?CSlLv0/TKyabWrVU5oKBx/Pw+HjMjo7kE8NPjvugPhQ1t1F+KMGsXjmISYrk?=
 =?us-ascii?Q?A2rHm5gAM0o1I0qNLxm0IkkH/ayeDm/kHe9T1+yNrt7G3w519ok7WDahZnt3?=
 =?us-ascii?Q?8aU4hMfCegA43rHJHFbwWxntXKOG56LYyk/o0BhshMQj95vFm/7FDDQIevjx?=
 =?us-ascii?Q?sIz5LEhhAMIX5NK856pBNl6Xi6k1IEDLiVvgoyynNvMds26ttdwJDD+EMvuK?=
 =?us-ascii?Q?hPoCD8KmI7Mva36CNOQBygIriiYB8Yku+zfmLGKO8bybH56XvMLABXW34zUm?=
 =?us-ascii?Q?J/x/4R3GzcIIPy4W9wHUHrkyYatTuoE1QsJ3LpIyI2TvsY3aMJtOeW72IhVE?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb232d5-4967-412b-0f5a-08dbd736e4bf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 21:51:37.0325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d38Ch0Wu7Q0N/0Nv0Xzq8Q6635AR+t2xb2bltUIfTFH2g71oed6/3AsfiGPBPxjklOn55Db81pw8M0GJt5LXC3DqMIanm82abS+kpeEXJPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8744
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> Now, that the Component Register mappings are stored, use them to
> enable and map the HDM decoder capabilities. The Component Registers
> do not need to be probed again for this, remove probing code.
> 
> The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> Endpoint's component register mappings are located in the cxlds and
> else in the port's structure. Duplicate the cxlds->reg_map in
> port->reg_map for endpoint ports.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> [rework to drop cxl_port_get_comp_map()]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> @@ -164,19 +144,30 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  	cxlhdm->port = port;
>  	dev_set_drvdata(dev, cxlhdm);
>  
> -	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
> -	if (!crb && info && info->mem_enabled) {
> +	/* Memory devices can configure device HDM using DVSEC range regs. */
> +	if (reg_map->resource == CXL_RESOURCE_NONE) {
> +		if (!info && !info->mem_enabled) {
> +			WARN_ON(1);

This new WARN() is not documented in the changelog, it needs to be
justified as a valid reason to panic the kernel in case panic_on_warn
conservatism is being applied. Even if it could be justified on those
grounds it should be combined with the following error message as a
dev_WARN(). For now, I'll delete it.

> +			dev_err(dev, "No component registers mapped\n");
> +			return ERR_PTR(-ENXIO);
> +		}
> +
