Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23E7A0E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 21:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjINTrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjINTru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 15:47:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E0E2698
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 12:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694720866; x=1726256866;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=z1LX5xFPniNvFQN6V3+Eg86A6ZjtT4fiKPoExJjcwss=;
  b=WCAtvrY8xYmoFh6lb7o5lqL1E6CnRzExY/SKdA3CU/4ZdLpb87pGIMXE
   gRi+aztMk75XnUYhjDYExxDZLOhdu5V+yhDvTn8DClC41Dq7T4sGEjrDq
   D/ikqvketc6/HQLlhQCZV1m4JRnEdSeAWApGmygcSXI1mQfoA65q4wQgn
   oHcjkKTMzQxzwwK5fgaxq4PBfVsQhQj+A2/QcjBiMEGFZdJ7+ceIOSU6e
   K8lcYfj6bZPM4/GAHdKwRFhmXqt8xey5mkTa8D5fknG+3RF5U8XHr04NG
   pZB2pss1cBcZKGsl5eYIz64m/rif8nFB7+m3e0ZAQNhbAQrK3280kfuyh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443103788"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="443103788"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 12:47:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="868380659"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="868380659"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 12:47:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 12:47:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 12:47:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 12:47:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 12:47:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f54huq1Arse9uw8MjKoJ3D4mGfMHMQvDRC2EEB62nXhfx3YW8cuScZBc3gYWhRv/FLgBucrIEMdxC3x9+USZAWm85AfBRSIPurey7d1Q8smS9j0DElRMTEh3xg3Piwg8RHMGaohkWgbJ1tF1k3wHSWRa8l66CRmRw8N19OrHxt3x2a5/mytkmg0Fet/Vyaq1J7fUebJbVPQW6AuvOzNubYM2vpBZdUdQ+E1J1lT2WIfrdKzRPLJFkTsVm9/2D9xxJR4v3pDv7jdi75//A3wcDOpTU4D6TnVAdCfybDrT60RBVftY9QCjcKVO6SBsm3jzC/4VlDm5a7cc46dXJ7zhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeTf+i1dMQuJ00UwQANXPJcLOE6cibKDsFxihxfyJL8=;
 b=b90vjT8oZ9t3Tl6vZo2qfZOnypfmxyrFzYcw2Gaa4iWhzGBJO3D+5ZtyJoK1kVSUK4meSCtr1+ZSlhekOsMwr+hBkqXtIxxz+12uL6T56LniwAJo178DLlN3a3RLomFgYGJPCcA1X3Sxh4jbZEJPPfSmpMmZGD0zWClcWrQx6zqz8Wo6Tr0YM8L2EW47J4AI5RW+7DOo69yynN6Yg01dTn8rW58ZmEwKyYLt49zv8D6Lm+hnHWmgWuPyUmCn7tOQuPrnj0Arx8CV68Y1U6LobEPjDM8AINAmxwNJk4X/T8b7s7oZp5GVd+ilkC5EBjYFzW9OPXul21N5TRs4uxevVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 19:47:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 19:47:40 +0000
Date:   Thu, 14 Sep 2023 12:47:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, Chen Ni <nichen@iscas.ac.cn>,
        <oohall@gmail.com>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <aneesh.kumar@linux.ibm.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] libnvdimm/of_pmem: Use devm_kstrdup instead of
 kstrdup and check its return value
Message-ID: <6503634e78f61_35db1029469@iweiny-mobl.notmuch>
References: <20230914070328.2121-1-nichen@iscas.ac.cn>
 <8ff1ddf4-a3b7-2fed-5dfd-041aaaf981d2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8ff1ddf4-a3b7-2fed-5dfd-041aaaf981d2@intel.com>
X-ClientProxiedBy: BYAPR07CA0081.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6d67eb-b556-4a5a-9a15-08dbb55b736b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4C9LHoQKwxGFtgLPls12rYi/YD/xf53hpEwgdL0tBHWvZnJrDmklXdzmlRi5pGL0dftf022dDKkxfD37jn4+E8I39NQFJhxECPcFu0rGRx/mVJ+li5ragG+qpipcTYZtvukYmgJLyVTCjmlL1h1ZVeOscVEKZWCXTN+dNftNeiy9RPp+ghRSSqXCjfG/J+S0va53EzOHe+CO9OCDhh64I2SxGzQeqGKwRcqx+yFCg6Rbi1UfDp3LwVaOXuy9MEqdztVR0BrNLPp2OtVZJuGpSSlD/cvyZaMJA1fuh1px81WLN/lJuLcy/HqCtMAhe9cHq2MRCOcEAGTqKN6Oog1zB78d2JGYifxTLH9fMBYfCw42wVTGXxC1H6I08MYAp3F0gvmTgHdUtVQV+8wkfgkwUEWPCPM4QYeaIaa42NXTGMw6CE0tVBQeGisdxRp0ypQC2glciicYpvupzoZlayeX4vpK8tMPrGcVsqIb3plOrUwmgQvfFa80nGK8xpYmD4sLiQx9smjvGlPBXXQGz/jY8rYGZDxpZpmi+aOCuiXXSm4N4voiiwFhdc7zjusVfee
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(186009)(451199024)(1800799009)(4326008)(44832011)(4744005)(6506007)(6486002)(6666004)(82960400001)(8676002)(8936002)(86362001)(5660300002)(2906002)(26005)(66946007)(66556008)(66476007)(110136005)(6512007)(9686003)(478600001)(53546011)(38100700002)(316002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MizPwh5UiTx+nf9+IcRaBR/iE8usetcp7BGAJozo0N7NMdFxmI94TnGEp0M+?=
 =?us-ascii?Q?lxdQ/A2vWWLDydhUqK3Hc3FtOfAokPCLYGNl/BCfYHwwmzpCgHtCO8lfcwfF?=
 =?us-ascii?Q?Dl3G9CSBkmTOn+/tmFRy5mun744JefqCn2EJitio2CmL5W9kQQToBhz1WfRb?=
 =?us-ascii?Q?1+KMYbGAieL9YDYnO2ktCbOK7XarzDd1yQw5EbSrPLrVCc71ivjcRK8OujuO?=
 =?us-ascii?Q?2ZeYcFifqHa+8vk5eMUa+3HdahhAaZbxd2LQN7BHr6CQ1iKwJJr6f6wIQPz/?=
 =?us-ascii?Q?rE5y2fuJNYEgmw1UEmoPMoCFrHMVme8EbkRDJiiINN0KU9BduyZmWMup75Tx?=
 =?us-ascii?Q?9wk380K+3++zzTDLwARxsGBkZZAfdNR8PtBZAo8esWtg6QNDRA7zeuEG2c2H?=
 =?us-ascii?Q?8NTxNdknc7avl/oBt3ny8ZMFu1bC11kXJjWu4xr+VoX8/VZg/VS0oAZA32yc?=
 =?us-ascii?Q?ldXBGOO4PrmaoRdaC4k0/0SBZvmAA/F2ovoYrLjyVmy8gzoB6x6Oqj9/meoB?=
 =?us-ascii?Q?XF2ga5JaBHz7Tll3wjRHZxD5eJysjQ1O/f2X7q+mVYnHf/kK80lAVhbZtsbZ?=
 =?us-ascii?Q?k9R9Avw7kWnrryLn/oi4b8acsoDsihvk55bJtNVNgAPFiuE+2bWXgZ9BpLwB?=
 =?us-ascii?Q?KyW8K9021tIOp2oyWLaHjb01AoiTuX8v4E6HFytQkXyun4xFLtQm31rtZRWm?=
 =?us-ascii?Q?ASKoYUyTOhObNHG3NBYjpi3jY+H8AnpFFOd/v9srQJS6JNgL5rS3l7tpa9n4?=
 =?us-ascii?Q?9twF4qwq3QMaAz8pmsfgGpEpt4lScxnZ6JUc9PPzMbziA4+jhodgczfOI+G4?=
 =?us-ascii?Q?fikOTMuLmXTr+NoXMP41Mh8k8IZx3UTcl5BZDXfLl3UOsKzfRObmdYbGNe40?=
 =?us-ascii?Q?uVgkGN4S4fD0RLGyYWjlMrvAxW9J4OuVVq2TdhMbNjY4MMNhjryalYkYzTXg?=
 =?us-ascii?Q?J+d9wAIBWgM5BnNA2xsvPDdRRrUHwBdnJAPcO/CCuaqH7hfR+Rg4rZrheS1i?=
 =?us-ascii?Q?/uOAafboDHnsHclTb+6u6EHCpER27BUZNpF8+AyJFBLHE92E+WqzxXri26wd?=
 =?us-ascii?Q?lzjwhK/7nDsA+tP19fSb772bcL0BdoJUObnv2J9/EOvi4BfSOPjHAMzwOXwV?=
 =?us-ascii?Q?hugq21KHO1oms2Xw2xDJzTsx6n07hzPqQclywLNuRJVNwFsRsSCrgjrq/UMA?=
 =?us-ascii?Q?/myCcLobt0XGwPbeb4LsH1sk+jocxf7FCN1Eznlg7s0hIu3nS1EZ6KS4Pb0n?=
 =?us-ascii?Q?Im0IadZptubxKnrX8BMjJQdBxsIwTGtR48uXV4pdfm53yp46CrfCqiS8IWO5?=
 =?us-ascii?Q?6rP10sWqyWR9pLc5MaMvYHWjzQnVCeELSmvXpIs5AzHmAtMvg7eoYCqfx4O0?=
 =?us-ascii?Q?+woxutZTWMjdM9ENkTJMUtTcqC9F/rdGvlOCwJKbEsm8qlgyzfrXU9ygINXH?=
 =?us-ascii?Q?vaK24jav5ZkowDdoqfAX0DWR2e81MR0dg7DK2gosPE+32uxiY8nIYdsxgDxp?=
 =?us-ascii?Q?AYfHmb7mIFIzIHajXi/20o1XUN8vUKjaOJIigd1zS7cX0YOBtmO7Snbkck/N?=
 =?us-ascii?Q?vwP0UQfdZakfj2JyqRA9gMC/KFcWg5AiqDYRuOOC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6d67eb-b556-4a5a-9a15-08dbb55b736b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 19:47:40.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b4e/FeND0KG5tUPIev54zH2swZqfNzFNiUgPCa9lRXsY9xzMChMQD5BecWPDiBfREIrVLIt3ArZfRZRVHtjxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 9/14/23 00:03, Chen Ni wrote:

[snip]

> > diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> > index 1b9f5b8a6167..5765674b36f2 100644
> > --- a/drivers/nvdimm/of_pmem.c
> > +++ b/drivers/nvdimm/of_pmem.c
> > @@ -30,7 +30,13 @@ static int of_pmem_region_probe(struct platform_device *pdev)
> >  	if (!priv)
> >  		return -ENOMEM;
> >  
> > -	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
> > +	priv->bus_desc.provider_name = devm_kstrdup(&pdev->dev, pdev->name,
> > +							GFP_KERNEL);
> > +	if (!priv->bus_desc.provider_name) {
> > +		kfree(priv);
> 
> I wonder if priv should be allocated with devm_kzalloc() instead to reduce the resource management burden. 

I think it could be but this is the driver and I wonder if leaving the
allocation around until the platform device goes away was undesirable for
some reason?

Ira
