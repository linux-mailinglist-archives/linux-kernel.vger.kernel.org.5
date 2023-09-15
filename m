Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809467A2369
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjIOQUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjIOQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:20:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D322126;
        Fri, 15 Sep 2023 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694794801; x=1726330801;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DXKMMA9d1iXsI2IHDV/+xj9iQ/k6jiypTOqU6Dfcyqw=;
  b=cv/9Jc1tOX/YJQLpg7zBGAJdhgYhvpXO9umEVdrlOjzZNjbLER1HPzcR
   UrADnEDVY6y+JXhbMcZ9zMO6ArVii+Kkq8KryCQ8FdnYWGhvAaaCkTN4C
   Uk7PUspwwEhKVg/idsKHKf6gtoMFca2etULYe1HQj3NIANr3yihI8gdtW
   7Q23F4MYWIDEHnkRyDNVEGDBnm2Ru2OlZ/H/iVmfuBir5hJZ+n1fnywvM
   pY7KNgBIKQEdfDVIOsK08PN+jur7KU18g6/yccmWRKC19Dc/YRfu7WAap
   nwhK7Kup/iwFhR5rtld08UU/FuUFU/TNAokoClpWPUSIufrgkvMoBzyav
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="383110504"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="383110504"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="721742275"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="721742275"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 09:13:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 09:13:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 09:13:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 09:13:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 09:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7cS+VXBj4uAhXWbmQQMjBk+r2Crzk0OQVQx0Gy7veGLcOy+uKkVioEbZGrNAJ6Q8lK/Z86ggO3ZLnY5284eKtnqG3aJrySzvNrEysZry9FIqLWRKvsiCC+8XEH3CQpIfqj8z846G9dB4/sBluMBq6ycgi43QckWrWqfzn1VSOMAyUurV9Z08PddhVwGFELzYWo1ebGAF3FD4iPcTzHbTzsycD7vW7/iUM2u54l/UXZ1S2Dv2so3yPn3XCfXJn0Bd6kD4fBUlasp9u+mhKtS2SVFxRnXr+l6CjZ52JKYEcEjNyIBXA1QyJEVk8VmyT5a9sZum95bzjUw2tNG8C8AiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUtiM2GHEZY+QYFOlmUAd8Pknz/nvOyAM0cI1fJy5sQ=;
 b=hYAaWztug+eBSH+MeCF0YuT/eSCyCMncRXYv3sjEtwsS2p7SO9idox34S7mu/GdNoorsDvGcCOrXWqX3BLIZw4vuz91wKsqNQJxBI20SRUIJ0U2eF7+5oZxRP4YGAQ1566qHObWEIhuXag8O27EhrB9AfV1dkbtwHwHBTTzT88vplk1cpVIt/3k8Vc4RKvJ7Gor+WM3OqWiL0nnBer7oTNJsu6VFf4aVleUR3EdIlQcrFAWfmxW27+oKt0x4CTHh7wQNw7UadCb8lIKGK7Pu0OZdbG8JeH0/cBHNm7cyCHkpwe2ILl+SMot3+QldlI8rqi4EO2OcJw2sJoWqWV9v9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4548.namprd11.prod.outlook.com (2603:10b6:5:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 16:13:05 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 16:13:05 +0000
Date:   Fri, 15 Sep 2023 09:13:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Yu Liao <liaoyu15@huawei.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <rafael@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>, <lenb@kernel.org>,
        <robert.moore@intel.com>, <linux-acpi@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ACPI: NFIT: Fix incorrect calculation of idt size
Message-ID: <6504828ead258_3777b52948f@iweiny-mobl.notmuch>
References: <20230826071654.564372-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230826071654.564372-1-liaoyu15@huawei.com>
X-ClientProxiedBy: BYAPR06CA0037.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 3946f9ae-f24e-495e-aa54-08dbb606a4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFHq88cT0rrvvWg+ZxO5aaIbOQk+ceJZoPhLUibOIV7+lEC4uJiG64OQ53b98l9HUyiTHyyJOXW1QrjT6XjkGstHq8jJeaWKhVrjPQJ71Ymp8Yu2bxJ5HW5pUOFHxy9PgOHz2ZXhlb+XrfHcYAHY67HmtbcmaGclZ9oQJFvUyqmAjah3Cl9H1ir+kCvjZFubgeD1vKARwBgG2oRjSlPKjNgcIvgtS/i1og1A+woSwItGv53/AGv/AKUYWVaoNJp8iw23KPqk2+b3gBwueUoeVizXvudm8DXmHcbPwb59fkH/4PBGV2wBbfnNqARMndsDsdYSAkJ9y4qXXk6mvXWT70lqWCcXMwi5Wv+2MCAsPxbLG1skLYD1A+5BEp4eJLBjWijNiHdsvebpIieLzYw7+sE4YG/OqhVwHdpWxypSk+rfIxtZLkMcQjwlcBxdHloZ7WG1l+yIF4PfjKVt0zeTp026Ij9zgmvAjY8OxtV0f2V/QqzJh8IRRqc8mVI4LQSaBI5/RXi53iDpPV80EJz2vApzoLamm26tC1M6yC63b6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(186009)(1800799009)(451199024)(6666004)(66476007)(66556008)(66946007)(44832011)(6506007)(6486002)(6512007)(9686003)(316002)(966005)(478600001)(41300700001)(4326008)(8676002)(5660300002)(26005)(8936002)(38100700002)(82960400001)(2906002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/g2LdUmBrSLkDXpSdFOlZhbh4s7zLRmhgUj7wY9QswAT26739nnCwYLK2pS?=
 =?us-ascii?Q?yRDw5UUyvftKTsPKWBYI2troB0U9IG75lR3gmvqOGM3ck33VrnnpYtOcrWxI?=
 =?us-ascii?Q?qwGTYhmYBE51ZNMQgB8TUlwOkUVE+UaahyDvR+0OG4IjSZhQXX0VoMxvvoI8?=
 =?us-ascii?Q?f8zqMcYLVj30x4LFs5TKcXCnP71aItbEHSBqdcO/C8S3fNl/chNuLmKmAsSs?=
 =?us-ascii?Q?OwsVMstli0t7VUGorx2rSZuyplS/j0GgbNKZzR+9UG7l8Jxbqn5sk34KGFGR?=
 =?us-ascii?Q?xWEocmnjzJ4BTIWXSVjtIbjdNS0GQ5ENP3Qk0FnkRYHsvaYJyJeEvaEvlEnP?=
 =?us-ascii?Q?gwP9uCoQgoMCGo38sXJIuwvVoiwhKN5LoYMOt40fBg0dur42CXHAWz6ne5Tp?=
 =?us-ascii?Q?QOkmqkr3NFlmhv7a3nILGH9Fh4RSTSB1k1JI0FKMwymxY7/kzXX/aRGW9D8K?=
 =?us-ascii?Q?pQ1Z297RbMCmyR7/cdoTVUIHd4saLOpzCajnqQ7Vm7PRlwW3i4tpIJ8A6+nW?=
 =?us-ascii?Q?scjGrHAPk595xQl22FUiSAEpIBazGHvFCSdtBmqRj9YaNyV6vZw0UELoR8L/?=
 =?us-ascii?Q?h5iVlW6q287PdqnWFRoVDjjLP8VO1f3seJZWxkfToY+vfUd9mSGBkrtOQcHU?=
 =?us-ascii?Q?XwMjvYKhh0uO7Wq3ygAt+NJOA4HH/wwIGxXr3gGMwNPma8BerjN/6VD+is+v?=
 =?us-ascii?Q?ApxYQ/zuRLH28ZqUbxY8mCGMxehvpe9+cKSOTdtSWDA9smK0IC+MJdAmM/v3?=
 =?us-ascii?Q?f1JHoF8x1G0oQVrHkpxnryASBIf/CIz/sRRw4QKEwler9QU4CwptjnPfRKWC?=
 =?us-ascii?Q?qMDyl7BCJFW3qDqLqJFuUoRgFx4eSwEIPsIWoY9oAhP1tMcMP6F8ZcfNfhOC?=
 =?us-ascii?Q?7xg1rZzWBXtUfFYQnujgQ1vse3oJvCz/c3nq1lnURufkBjOy+jmSOyIGcrf1?=
 =?us-ascii?Q?ShiFt/5kWjjG2qCBEGbyVHCk8aYU695EQhNbvhxME1dUAyvsdAJLVECmzrXu?=
 =?us-ascii?Q?QygxQFcCg4IU0o4eJqhd/T6tA+csGiIoH6HqHCNMtAG0k7wvi4KtOdcQ6JO3?=
 =?us-ascii?Q?qkCoVmINvjWFhshJWS4zo1qrb/IkDp1hExGqMXRyjeyjeUdO8GfOmobo61Gh?=
 =?us-ascii?Q?+zUISrUzDrdY/D1uS1oTZdc+XVTEUXuX1Mx2D+ibVzKuVtqSGT8/r1udoMnS?=
 =?us-ascii?Q?BNYFDgwKwKJgZMVJtsqaJp0DlSfhoL+ks/i40ZyaN/nktBGEuT+c+eGco/Fs?=
 =?us-ascii?Q?3BBaoWhILHpoFU0RUfGY7LgEbduTsTEYPz2qHJ7AGZM0Y5bmS7u8mGIJn4KS?=
 =?us-ascii?Q?ECtsuFDR8g8Y1NPE76ibn5iO/XWQkukQwCW+wc/HcFQgUGUkfmBh5LxvP5Vd?=
 =?us-ascii?Q?FvyYrYcUxcU8zbKsosb8vEitU+f7Vi+/idrYvWlr48y22Lzb8L2r61iWZi6b?=
 =?us-ascii?Q?vaZXLvLoxhGio10qP69wspncwJd0T0pot+OyKDPDeLT//IOav0dDzIDxOCBb?=
 =?us-ascii?Q?vm6qwaeE4E0WsBE1lFjjJ3ZTL9qoH2RxjsrLW0VIfztmQwZso7LcuE49327f?=
 =?us-ascii?Q?aQAu9OOtNyvUIRkgy1sEmSup6JHkLGc+mitphMBr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3946f9ae-f24e-495e-aa54-08dbb606a4da
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:13:05.6879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8GrUS//VekOKvBTv9BDeXhModk5b3y2fMV8oOpmpAzhM364G+tSmzf8QYfWwM7p/bcCwcEhsXd4BMnm/z3DzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4548
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

Yu Liao wrote:
> acpi_nfit_interleave's field 'line_offset' is switched to flexible array [1],
> but sizeof_idt() still calculates the size in the form of 1-element array.
> 
> Therefore, fix incorrect calculation in sizeof_idt().
> 
> [1] https://lore.kernel.org/lkml/2652195.BddDVKsqQX@kreacher/
> 
> Fixes: 2a5ab99847bd ("ACPICA: struct acpi_nfit_interleave: Replace 1-element array with flexible array")
> Cc: stable@vger.kernel.org # v6.4+
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> v1 -> v2: add Dave's review tag and cc nvdimm@lists.linux.dev
> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 07204d482968..305f590c54a8 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -855,7 +855,7 @@ static size_t sizeof_idt(struct acpi_nfit_interleave *idt)
>  {
>  	if (idt->header.length < sizeof(*idt))
>  		return 0;
> -	return sizeof(*idt) + sizeof(u32) * (idt->line_count - 1);
> +	return sizeof(*idt) + sizeof(u32) * idt->line_count;
>  }
>  
>  static bool add_idt(struct acpi_nfit_desc *acpi_desc,
> -- 
> 2.25.1
> 


