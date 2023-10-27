Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A677DA347
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346636AbjJ0WQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJ0WQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:16:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8B3AB;
        Fri, 27 Oct 2023 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698445002; x=1729981002;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S/6jlToaQ6jHH7sK5e3d4N02hVJImJytWM/Zcs04MWk=;
  b=QQsrva4hvJnSmO/jfUOScgeLclU7Ahbsh47m/n9mGaftli3pZlX3kzJa
   n/nt9yB8IlU4e3Ux9JXars5Tx7auhzWfypK9o0Hud2jWH4570sS0L0IQp
   BvdsH6ab7tD0u1L36dnZF/gqJquBR57WgFpKIMOeIRRKAaG9pihPMxmk9
   ceFwkcBjgZ2bSsN7BIHPLdCuM9FSBEgNoQeBh3OOKyiLcBLjW4u4XzdTp
   y6jwVjGKvb4mhuS6AFOxfEPWi2pmj10GSVza2VGcelluAMFV21R77KIB+
   zGbX+u+KvWNYwaID7IEPGZjwevzyNTGr/b8sgEhgs9evdMZyuQzbdtjMV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="454326247"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="454326247"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 15:16:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="794713927"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="794713927"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 15:16:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 15:16:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 15:16:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 15:16:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 15:16:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXsZURVrKc/zXMlci09Li6qO7099r0JqTVK0BLVzMxmG6GfjQDtT9GsfuXtTJEyQO4fcNm0GrrsfS2Fqn6lXjOKlzUZaced+vrEzXE/eQ4c7G/KLqhpSybNIpxGV7hkRSYePOnBAI9YVcxQeTlfmeIDoa1Jhjjebou1lJ91IVW+XcS/Ig6tHDKJ+S/jS/U7H4CFBPuQdCwU/iun02Yo6wVgN/F4icooS6uXPcIXHrDTeVNi8m0oiUXTizEtOFcAobD88gg0zDDOwx4Rjvk0IYP6tfXbClXV5FMh5emkZq5dOQ3pIfLaiF1pL2lT2RcjntY6fPZNY72gdr8lWx8E5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ5qcG3n/85ZeR1OJF5XB2KNqcDR8DLh5C1a5vQtPrc=;
 b=iOYvHKd96Y7IMxlQSB+tLNqsea8cjO+XP3xisQfHiL+CsYBLqmuK1+S8WIAcCKHlOiKLn54yNyDcCb/HJ+UcBQAEoLWsyTUv3PqdA2tUFqYHkAuE8txTc+8bqpcc+ElB8WqI9vLpd8f73h0iLSFnHPuMYXlwKyP+ngGw71GDyPw7pmiFFRivtw4uJWSK6YwMSsgxPWYVczyx0aZV+SDLJ+ZOwl7PoFB+qO/vGXiY0pvSIbPhF1juReKh/Tj3CBIW0xLrMgprqINW0VZ+/sH3qiv4cUZPgn6se4NVCT2sryue353PMwe7hEnz3t4PdUmd3NI0H91jAzmQDOhg6F/xFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4832.namprd11.prod.outlook.com (2603:10b6:a03:2dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 22:16:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 22:16:33 +0000
Date:   Fri, 27 Oct 2023 15:16:30 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v12 14/20] cxl/pci: Map RCH downstream AER registers for
 logging protocol errors
Message-ID: <653c36be4b5bf_244c782942e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231018171713.1883517-1-rrichter@amd.com>
 <20231018171713.1883517-15-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018171713.1883517-15-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:303:8e::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f352df0-95fe-4e6e-9dc2-08dbd73a6082
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFGcYFxTnwlBnTGX/KsKj7FCYcrXE67VSS0IDNYZJyfBP5WhMBSuKlN7pUxvxXJuYFO7mHS/JFS5VwwRH9yGENBoITTmR9QaIyyRz1n46l9i8Ammez5u1g05NFeNEUWi+tQHqYV2hjobO7/t2hMHRwWMtLB6Z7Se6eeNfLiqZFIj6bouCUZRKquIDTZb+EJxRrSK+7fANrpplSijW+KF3Q+ChOvxpioZ1jhXw2X14lPKHS5D7KMDQyu3GoygQbjQiVAbmPifrlgjxnHcf53YwmS09xdlaKLfmNLozcvaw8nvkI1d/zdC0I1VJLuvfk6uku8+X6thl57mXAqJv9SlCYArRJgIIvxg6xA1TnfDdl+RKPmRGVW3VBnBduZl72mhtQPGbb1VdpjRMEFwGVHJP0dxlIRkd2FEvsMt6wumM5XlHYaRPgtmwxYFCSinMJ3tGJKPnYJvCsqdBTEcK2GJiU0/8ljG2hd/92rdvCyEG1ApqETyd3WWD/TcorIitFgy5wo7MLyB8MPKIb0Rh7SmWEfQSiaCBjjAPTRQ5YpMG6J6gymXcK0+QhV/Kg97clE4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(478600001)(6486002)(66476007)(9686003)(6506007)(66556008)(6512007)(316002)(66946007)(54906003)(5660300002)(8676002)(4326008)(8936002)(110136005)(41300700001)(2906002)(82960400001)(38100700002)(83380400001)(26005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wdj1fKGOqYvJzl0KY86WlSmTbdDt79MWl/bnUIwoACLU40MmQ2dQdg5dqtzO?=
 =?us-ascii?Q?JlfH+SRNNcHoGt4RXgXFzthRy7LCnkrItD2Lgr5mhVOm0Qnr1WGgHa9sscz0?=
 =?us-ascii?Q?pedu67G+BU677b0MKfp9imWBLxVnISNd1QwL4nQQo5mEjQ0lr2d566O/wbvV?=
 =?us-ascii?Q?24oQTJMocialuf8xFc3cI8f3EzBrsy3MkPRAP6uPOaCoZuQCgfnTXWUVIoZU?=
 =?us-ascii?Q?MHSIwc9vL/8VCuanA5Hsl7vharJBY2i3Z4xOd8YWj+ez2fu0coEvDGqBi9SL?=
 =?us-ascii?Q?vNWzoTQY9voBk8WBrigbzrmshamExuxLAnrtQ0P07b4yuMqhvnd1mCKFa/jw?=
 =?us-ascii?Q?V0uL/p6ZMvyASDpDWOiGTb/7x+fPV719XxPvZ+8tibuKCxD7J2b8hESMZKFN?=
 =?us-ascii?Q?3EuDzMAwkIu0gaicwbq3VSzgviVRbDYr9B0lizkvXBoYXLOCfx97X4Wc29sx?=
 =?us-ascii?Q?xJM/XraGrPABI5+xJNQi5xn4P0FHyGx5VRaK/Q5RHUhq98MqlNIjpgBuF/9l?=
 =?us-ascii?Q?eD54+AJSGEipU5BqIlfsNGMYYDpapFmkn5CeMmiFPrZKatsR+S+1DmnEt9Pw?=
 =?us-ascii?Q?t4So/zBFBvfOEoFBALPoNluM3vN6hSP/34wQlBmpDPw3dzXYH0E1sb8jPqNA?=
 =?us-ascii?Q?R68NepQhatuJk2AEfzvKYQG4A30cqblGdI1I4cmIlgheOZu7T1xSYtyGzUXW?=
 =?us-ascii?Q?x/ESgKBdNdRydSVrf7C4quMR50scb+6csnet1QeNgzShvvliKkVWOdL1Zytx?=
 =?us-ascii?Q?qOggyWwCOQPq5DSmla4bcXpfh0YLFJXXRGJs2TpyygivKREOJiglkl6hSXTi?=
 =?us-ascii?Q?lrF3uP/d14sMYQsMXQZebmgZF6STbe2jiV666ojRDGUmmF+4pcoEV0XnnT3X?=
 =?us-ascii?Q?Q4WXal1uYy3IaqSzybNh+KYzJ5E+Qm+d2GpUUTfYyD0mSRpRxJwZ6PAzSk1l?=
 =?us-ascii?Q?CQBc9wHZ3K4Fs2lb63g42APe+9l/S2xJCdDDkrPfaNyi2YB9M9zuby0noy9I?=
 =?us-ascii?Q?FIZX+qC9w7tzRxECKj8wDAgQf/33rrb8mfy1/PQrY/utVU4qY8ZT+jzefu1C?=
 =?us-ascii?Q?ihu18bUocD1AUgK/QLnL3xs/lrT1beLdt+PRSpRtEfgGoxIEez2IHbMwcNIp?=
 =?us-ascii?Q?EiaYVa5eLTUMA/CvDf7LR4PYrblFAOi+Pj7lhL3yrsS7ZQcjgcG2IgUr5xQ/?=
 =?us-ascii?Q?nqKgAbuYkdvBpXq/83I8/RrgnrNKVa7b929RPaGWEGbeuhWzYCFbZRE9rRvj?=
 =?us-ascii?Q?aISL4UbWPwDD5ENe+6BBbB1SqSJW0i7+baiXRYZDUIx+xZhpxcsFe3d7MfUb?=
 =?us-ascii?Q?y3isJH7aqIowQIpLP2QyToeLg9UsAqrMvxu5I5DyDpp1UVmUP/FjDR8TJzXU?=
 =?us-ascii?Q?s1MTqh9Kj/5h/ftiFXOTZ/8CnMwxjB4h9j0QiJOn5qd+fJSWru0sI0Qnp4xR?=
 =?us-ascii?Q?QP+6BnAzgxkGtAzK/q/Aolcpq20pdZigJU+pjqmwi/HKS8A8m8DQoDzODqwB?=
 =?us-ascii?Q?5t6lY3LZIFyJvextjtvzIEsH84pLTgV7QVMjrIi/uMJsMa/rnR7YIfnTDk3E?=
 =?us-ascii?Q?tPP10AKlwcINbWXRrVyg1KrKioMVunZDCc0nenZRfXrrNYWq405MexkrKQ1X?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f352df0-95fe-4e6e-9dc2-08dbd73a6082
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 22:16:33.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNeaf9F/FWMa3EsRbEsbcq+XH/U6cIiWG5VGI0R7/hDzZei8XLhlxqgssBQ3GcNSAFhgvjNGsBzKk/DpFRl/k9kPZBOwFNI9cmXtFoG56cE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4832
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
> From: Terry Bowman <terry.bowman@amd.com>
> 
> The restricted CXL host (RCH) error handler will log protocol errors
> using AER and RAS status registers. The AER and RAS registers need to
> be virtually memory mapped before enabling interrupts. Create the
> initializer function devm_cxl_setup_parent_dport() for this when the
> endpoint is connected with the dport. The initialization sets up the
> RCH RAS and AER mappings.
> 
> Add 'struct cxl_regs' to 'struct cxl_dport' for saving a pointer to
> the RCH downstream port's AER and RAS registers.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/pci.c | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      | 10 ++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d101fdafb07c..3b4bb8d05035 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -5,6 +5,7 @@
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
> +#include <linux/aer.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -730,6 +731,38 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  
>  #ifdef CONFIG_PCIEAER_CXL

Here is more code in an ifdef block that has no compile time dependency
on the config symbol. Please do not use ifdef blocks for runtime
dependencies.

Again, this will need to be a post -rc1 cleanup.
