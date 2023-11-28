Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF77FC556
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345286AbjK1UKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1UKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:10:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83CEF4;
        Tue, 28 Nov 2023 12:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701202243; x=1732738243;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mD1adC44BBsWUK8SpHa37ESPJJyRqoLpUJuNpzVcXPw=;
  b=HhvK+xhjl0m4HUPKs6juSMqTymJkO+dCnZ8YuuJpat/Qx7/Mtg7niM9A
   l5KAJ5UKA6lZHpzuyH/+bpImbgQpC114nN0Xde6Raf3Y5om0J0iR2gJ2G
   qTmasr8a5U1BrX3RaOV4EqKlmuNoMJIBrxZzX5ce8TG4LxUXeHBXpn5hr
   Yj32c6YFxNJQW5+9M9Z1phVF0RMR42BSPpyXkDY5wtWMf0teFh371G6CH
   /RP1rD7Rd0pt6hViAifToe29YJp2lIC3tNHGZQZ2XxH3OM3bqmYMXOTfn
   qeMAIcIivjWZOR5px1WQEbrHqk5fMBTlhRyCOrPTpat6nhs4mWWgCEWpF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6220398"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6220398"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:06:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="892182433"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="892182433"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 12:06:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 12:06:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 12:06:38 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 12:06:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJW9My2Wy1VdBNvLojVdZmvpg1KNQ+mANZtTCn32nlznRA8Ub0bWx7uGgPVRk9brtmIblJXRqCzz1ZmrUFEzOp+fy8HkuXmYiCn4cNs0wA8c/aBxL2dT+ktqqnfiHDp/wo5SAZ5DvejugfPKcPiBPH28hMwKzg/pvbNQEmf3H2ropJ4mxGtn2AP6Lt/zKWeeW58+oXvQ9ZL8C/gnMt1ZQH/J+dculIONYgRXzh/VBkcOYOoiUKlTn7epKy1zwOyPVtiVrt5MxEgndeC/ynecnbtN3qvnJVXFNi52trUpyJ6dcDMlPUmzQxCEvcBm+VPWW/Vv0+Uc+nGr3xKiueSSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hhj6HmGoh826g77s+p1x3BIb2uVE6p/2I8GoB+c4/L0=;
 b=Nn3ThjEZRZuuDxHXNHFsUXjzYgqYXep5zLK+2ekvCLjV4qVJnFPWsE6VVXYWg03j7rYpTD7zZt+994/B2Y5ZSZSYSPUMTdswihAeOCCjLn7ETSGlOdOyADELN1bP0ATEDScBfXWGUjFdRobgOwvhD3SZpJrApOzJp9qj07p6pgRqxB6FCqnIdgOw3WnYX9TmxEGys30S+mD3L4eEutJ7kYCV16n1Cv6T1G+PYq/ue0K0PydTs32jVcfNlQIPv6acBF/wx67odOfElhk4EJX+EnpwozCtQCkOc/cG4E1EL9O9QHLnKa7Cm/nDWv7Pj04X6tlZl+NVG4O3VQN0+y/mFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 20:06:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 20:06:35 +0000
Date:   Tue, 28 Nov 2023 12:06:27 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fan Ni <nifan.cxl@gmail.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
Message-ID: <656648433bd82_888fe294a6@iweiny-mobl.notmuch>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
 <ZVfIaNhiSc-yQZo5@rric.localdomain>
 <ZVfJ6Fxidvw_gz7r@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZVfJ6Fxidvw_gz7r@rric.localdomain>
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4dd38d-c2d2-431e-e8c8-08dbf04d85db
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SQpyYkKg4Q/Smk1/ow2+BqFKplWcxh56v6tIlUy+Y8Xt7xgdfFsuZ4bYm/k4+9ZcExP5lgyjQ0M18vutHoUDPbHgkWlKi9VPVYehRzlaqs1WSKvkBhhDp624T8TTPPf+EbVkAYk6eSJzF4TvVnHiFyKnEagzQJDWj8aaXoi3DUawB3fGHZy+HWyLFaP1RgIkUaA2NmLe4c6AesVhvTECWieMFJApd0rl/Gqi4H7KxSUAz62R1oKRHxsTmszmvDEEp7+FlHyErrNHlhMnzcYcwHFJKSZrxPMyAM6NokN4j8p0Jynjr62u33G7HSCbAe1M1FzziiZ/hl7KnkBKGEPKbyZ5vGoX6VKY29p99mOsUXuuWdTgkiLWnKXyer7INzJEGS4ElYznPhOhTFJxJq7OtSIQXWDsA9i3fX0paJmjXFhp3HlIrD4+hFRGX8v2v1ctI/+Rm52kMsBL59WSX6A1c+FyE8fAmkjhEtPd/IZpPyctB7fNyS3RBC9eWrla745t51uCzHwM+j3BvOVm0W0UwpbedlXUrNX8BiOaYjnZlhXhf2NzyTYk6ut6i3KD7R0RDMrjFvg/COgAlDI9jzC566stVsY/CsBkzkVgb7IK90=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(38100700002)(86362001)(26005)(83380400001)(5660300002)(82960400001)(44832011)(2906002)(6512007)(9686003)(6506007)(53546011)(6666004)(8676002)(4326008)(8936002)(478600001)(6486002)(54906003)(66556008)(66946007)(66476007)(66899024)(110136005)(6636002)(316002)(26583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1qlb51UNcS7JCjJlwHSIF2SfQPgzYvFkHa2cuPITT+LZZaLa47fMKaYYUJUt?=
 =?us-ascii?Q?9BYdvMuCWDpedrWsDNVQTzi+3U4su0Ai22ctRAb5FlKzeWx6NX9A0lbryDnc?=
 =?us-ascii?Q?9JV+D93Iz0UPcyOMyNWpPrEpd+M/Pp/xAIaqR0gxb23s6BRI3Q/8J79UpL/R?=
 =?us-ascii?Q?TFELPIu02DStBN7MRkzLcMrxT3eapzaugFQVu0XB7GDcA7SHWKWxsuNG2KLu?=
 =?us-ascii?Q?VlA1Hp2qwzLjwM37EnlIzC/2S3UalTpJB5lMPZieYbg2ZjkH5FJ1oaCilv6W?=
 =?us-ascii?Q?YInPvzic3dLM5e0Jtp676/7isTUswZRov/C40dKtlrWyQcKOYOuft6I8Z7p4?=
 =?us-ascii?Q?ncrBCmQUSPMgoETPZu9MddiYsiBYMLkbpCPHvaP5OAJ/nksyD5XqpgvjhfsQ?=
 =?us-ascii?Q?AQ0Ebzt3jq3LEymVNyrS9rzgQWGtGOlj80cHpK1jjlcnu6NfaAfp3uZ9X3Bw?=
 =?us-ascii?Q?v+xOEvpif1wmEsyKjv0FTYPhG2wMHdmjTmHiPe7V4CYHb1AUmJTO1C95HBcY?=
 =?us-ascii?Q?LCA8LQJJcEq9WIvsHhOqpQVhnM/mmRfmnocwCaTG9Nbr0/hMHk8UPBzVVDSf?=
 =?us-ascii?Q?sRtBOLoj9332oeABd7ToS+IPMy6/5FgSCE+nlMWnGFB5ltVa+AJOr1boqz0H?=
 =?us-ascii?Q?+R0A6VT5JSXWz8wB77hjvrx9uAENoHg/iInO2iJPVTJ9/YhyRmpDerkVtkJR?=
 =?us-ascii?Q?GzzxTVx3hU1nai0f8vhmXiZCHE+eb+6urAqsEHhBEceyftET4R1wZcf0511X?=
 =?us-ascii?Q?uxWRJyqP5WKBzv/auh9XgyTOK7CVAOnW0T0Y9F0+Pqidw0741sS4D1x0GSVC?=
 =?us-ascii?Q?kxyDwheFVpOv1CJ7zDa4OVZHXyrkUaY6Zw9rRKYY6AyGZRTejscqFwGZbG3n?=
 =?us-ascii?Q?RTj4GiNxHD88JVWGnVEXuy42Wf0px09BNGjSKcIpx+Ze2qWh1NJpJ0mB+XUy?=
 =?us-ascii?Q?LN3kNhYHDDw9hFCqbRkPvmavXZNCtWF4x9B+yipU+rkjznZDlslhYuu5C8Tm?=
 =?us-ascii?Q?RxGRJcbryVcrKeTXOkeJXfioWaAEDcPXnsrPNoiUfqt3J4tjnyvVUaoGHjzg?=
 =?us-ascii?Q?D9o2SLz44U7pxRyulHwClhryiQr0JRsEYV18o4MYIPMxHxJsqnLaVNWtXWKc?=
 =?us-ascii?Q?LdFcRfBFaA92s/GT3xnTcIznn0bQC1SziZU8JWt94Q1QPGm+lPemVq2nxXQ1?=
 =?us-ascii?Q?NRyZggYzjPUDcVdNSakQ3aDUoG87mUDfu4z4UncEGwz8vk6jdky0MbjrVFg4?=
 =?us-ascii?Q?XEr3s2c+2sKjtblulMQmRvceLq5XrvqpodMZzoD5Em1x9A+En62Apa64/iXU?=
 =?us-ascii?Q?gLJnRT1BgXNJXf7QahaDfZ65dJctbpGPxlxsFjB14dJz4RnYdJqjbtQZxBZP?=
 =?us-ascii?Q?SxQ+41/Xyk3SUz2Or+/A9F2saNvQqyzC+FI+IjJKGBvafYdMjkP4tDLfQ2Yy?=
 =?us-ascii?Q?L0ia4m5MYQogGCD8WtRMwM20adUSrTai3tfjwQI3D2M16KtYimPesTMYVOEl?=
 =?us-ascii?Q?CBAV2InhlVKg+rABnjA14HSAePSh3kIIUir0Ocix+mBJAfbMITcMboQKut8W?=
 =?us-ascii?Q?mY/azXQ/JEIfFCFnrMJJGxFyi7gGgpr2YJm+hRkM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4dd38d-c2d2-431e-e8c8-08dbf04d85db
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 20:06:35.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlWT5kybLAywYkpDoZgynnmwopMgMFHEWYI7JH+x0/ldOkiQPysyxAPUzZTqgq9wtAI6nmYgZh8ODifYOH8spA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> On 17.11.23 21:09:18, Robert Richter wrote:
> > I will send an on-top patch for 6.8 that reworks that code area to
> > remove the pointer arithmetic.
> 
> Here it is:
> 
> From 13787f72c20b8c54754ae86015d982307eae0397 Mon Sep 17 00:00:00 2001
> From: Robert Richter <rrichter@amd.com>
> Subject: [PATCH] cxl/pci: Get rid of pointer arithmetic reading CDAT table
> 
> Reading the CDAT table using DOE requires a Table Access Response
> Header in addition to the CDAT entry. In current implementation this
> has caused offsets with sizeof(__le32) to the actual buffers. This led
> to hardly readable code and even bugs (see fix of devm_kfree() in
> read_cdat_data()).
> 
> Rework code to avoid calculations with sizeof(__le32). Introduce
> struct cdat_doe for this which contains the Table Access Response
> Header and a variable payload size for various data structures
> afterwards to access the CDAT table and its CDAT Data Structures
> without recalculating buffer offsets.

Thanks for this.

> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Fan Ni <nifan.cxl@gmail.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 80 ++++++++++++++++++++----------------------
>  drivers/cxl/cxlpci.h   | 19 ++++++++++
>  2 files changed, 57 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5aaa0b36c42a..f900740c6dea 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -517,14 +517,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
>  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
>  
>  static int cxl_cdat_get_length(struct device *dev,
> -			       struct pci_doe_mb *cdat_doe,
> +			       struct pci_doe_mb *doe_mb,

NIT: Why change the variable name here?

>  			       size_t *length)
>  {
>  	__le32 request = CDAT_DOE_REQ(0);
>  	__le32 response[2];
>  	int rc;
>  
> -	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +	rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
>  		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  		     &request, sizeof(request),
>  		     &response, sizeof(response));
> @@ -542,56 +542,54 @@ static int cxl_cdat_get_length(struct device *dev,
>  }
>  
>  static int cxl_cdat_read_table(struct device *dev,
> -			       struct pci_doe_mb *cdat_doe,
> -			       void *cdat_table, size_t *cdat_length)
> +			       struct pci_doe_mb *doe_mb,
> +			       struct cdat_doe *doe, size_t *length)
>  {
> -	size_t length = *cdat_length + sizeof(__le32);
> -	__le32 *data = cdat_table;
> +	size_t received, remaining = *length;
>  	int entry_handle = 0;
>  	__le32 saved_dw = 0;
>  
>  	do {
>  		__le32 request = CDAT_DOE_REQ(entry_handle);
> -		struct cdat_entry_header *entry;
> -		size_t entry_dw;
>  		int rc;
>  
> -		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
>  			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  			     &request, sizeof(request),
> -			     data, length);
> +			     doe, sizeof(*doe) + remaining);
>  		if (rc < 0) {
>  			dev_err(dev, "DOE failed: %d", rc);
>  			return rc;
>  		}
>  
> -		/* 1 DW Table Access Response Header + CDAT entry */
> -		entry = (struct cdat_entry_header *)(data + 1);
> +		if (rc < sizeof(*doe))
> +			return -EIO;
> +
> +		received = rc - sizeof(*doe);

This is not ideal.  See comments on struct cdat_doe below.

> +
>  		if ((entry_handle == 0 &&
> -		     rc != sizeof(__le32) + sizeof(struct cdat_header)) ||
> +		     received != sizeof(doe->header[0])) ||
>  		    (entry_handle > 0 &&
> -		     (rc < sizeof(__le32) + sizeof(*entry) ||
> -		      rc != sizeof(__le32) + le16_to_cpu(entry->length))))
> +		     (received < sizeof(doe->entry[0]) ||
> +		      received != le16_to_cpu(doe->entry->length))))
>  			return -EIO;
>  
>  		/* Get the CXL table access header entry handle */
>  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> -					 le32_to_cpu(data[0]));
> -		entry_dw = rc / sizeof(__le32);
> -		/* Skip Header */
> -		entry_dw -= 1;
> +					 le32_to_cpu(doe->doe_header));
> +
>  		/*
>  		 * Table Access Response Header overwrote the last DW of
>  		 * previous entry, so restore that DW
>  		 */
> -		*data = saved_dw;
> -		length -= entry_dw * sizeof(__le32);
> -		data += entry_dw;
> -		saved_dw = *data;
> +		doe->doe_header = saved_dw;
> +		remaining -= received;
> +		doe = (void *)doe + received;
> +		saved_dw = doe->doe_header;
>  	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
>  
>  	/* Length in CDAT header may exceed concatenation of CDAT entries */
> -	*cdat_length -= length - sizeof(__le32);
> +	*length -= remaining;
>  
>  	return 0;
>  }
> @@ -616,11 +614,11 @@ void read_cdat_data(struct cxl_port *port)
>  {
>  	struct device *uport = port->uport_dev;
>  	struct device *dev = &port->dev;
> -	struct pci_doe_mb *cdat_doe;
> +	struct pci_doe_mb *doe_mb;
>  	struct pci_dev *pdev = NULL;
>  	struct cxl_memdev *cxlmd;
> -	size_t cdat_length;
> -	void *cdat_table, *cdat_buf;
> +	struct cdat_doe *doe;

Since we are trying to make this cleaner I would prefer a struct and
variable name of cdat_doe_rsp.

So...
	struct cdat_doe_rsp *cdat_doe_rsp;

> +	size_t length;
>  	int rc;
>  
>  	if (is_cxl_memdev(uport)) {
> @@ -637,40 +635,38 @@ void read_cdat_data(struct cxl_port *port)
>  	if (!pdev)
>  		return;
>  
> -	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> -					CXL_DOE_PROTOCOL_TABLE_ACCESS);
> -	if (!cdat_doe) {
> +	doe_mb = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
> +	if (!doe_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
>  		return;
>  	}
>  
>  	port->cdat_available = true;
>  
> -	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
> +	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
>  		dev_dbg(dev, "No CDAT length\n");
>  		return;
>  	}
>  
> -	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32),
> -				  GFP_KERNEL);
> -	if (!cdat_buf)
> -		return;
> +	doe = devm_kzalloc(dev, sizeof(*doe) + length, GFP_KERNEL);
> +	if (!doe)
> +		goto err;
>  
> -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
> +	rc = cxl_cdat_read_table(dev, doe_mb, doe, &length);
>  	if (rc)
>  		goto err;
>  
> -	cdat_table = cdat_buf + sizeof(__le32);
> -	if (cdat_checksum(cdat_table, cdat_length))
> +	if (cdat_checksum(doe->table, length))
>  		goto err;
>  
> -	port->cdat.table = cdat_table;
> -	port->cdat.length = cdat_length;
> -	return;
> +	port->cdat.table = doe->table;

As an aside: the type of port->cdat may need to change at some point too.

> +	port->cdat.length = length;
>  
> +	return;
>  err:
>  	/* Don't leave table data allocated on error */
> -	devm_kfree(dev, cdat_buf);
> +	devm_kfree(dev, doe);
>  	dev_err(dev, "Failed to read/validate CDAT.\n");
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 0fa4799ea316..d12ed9d8dec1 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -85,6 +85,25 @@ struct cdat_entry_header {
>  	__le16 length;
>  } __packed;
>  
> +/*
> + * Response contains the CDAT only response header of the DOE. The
> + * response payload is a CDAT structure (either CDAT header or entry),
> + * it may also mark the beginning of the CDAT table.
> + *
> + * Spec refs:
> + *
> + * CXL 3.1 Table 8-14: Read Entry Response
> + * CDAT Specification 1.03: 2 CDAT Data Structures
> + */
> +struct cdat_doe {
> +	__le32 doe_header;
> +	union {
> +		u8 table[0];

At a minimum we need to use flexible arrays here.  See:

.../Documentation/process/deprecated.rst
	'Zero-length and one-element arrays'

> +		struct cdat_header header[0];
> +		struct cdat_entry_header entry[0];

So this would need to be:

		DECLARE_FLEX_ARRAY(u8, table);
		DECLARE_FLEX_ARRAY(struct cdat_header, header);
		DECLARE_FLEX_ARRAY(struct cdat_entry_header, entry);

Also I think it would be best to use sizeof_field().

That said I got crossed up when this structure was used to represent not
only the individual DOE responses but also the cdat table as a whole.

I think it would be best to call this cdat_doe_rsp and somehow make a
distinction in read_cdat_data() when assigning to the entire port cdat
table.

Ira

> +	};
> +} __packed;
> +
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> -- 
> 2.39.2
> 
> 


