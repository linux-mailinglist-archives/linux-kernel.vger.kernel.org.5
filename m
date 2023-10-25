Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE37D778E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjJYWFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJYWFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:05:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B37213A;
        Wed, 25 Oct 2023 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698271506; x=1729807506;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D4VIEG4nX5wnRoPZsHz5ewZ1cstzXIOjByv9giZb/WQ=;
  b=LBrYX6vxTb6489o13G+e0yPTMJgAuRyU+GtrxYQuq7LzJWUtlJkH4QAX
   DRaaQupUup7dRMc/QfwObXmo++K5m0sp9eIi7drFhzNBLIhVXpMVwmX88
   ASA0TSQy/xCDLwmhbEXc36iO9tn+WY0Dv9MvEX5C9PC/EG5Lt11jbwSKW
   rWWofgOhdMYinI4+2WPdj5JkznyFsSKNE5+o91k97WYgP5S2jt+xk1s8a
   o3v8fCFuzDrCyNNDQn/9n0dp34qlsuQk1S/vvUA6wCa20yRPa6lHq+Tje
   fRTHT/EtiqqnV6g8ytw2RMvFQDI191XWTUWVsc8SmIAE4NPwMb+oC07xC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="209790"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="209790"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 15:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="276492"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 15:04:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 15:05:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 15:05:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 15:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3f0hEFqdhHtIbyWAjoQXQp5oYnFyIH8bbDq1caWsYN4o/Bk4IQ6F8TZpLAcxQU9MWypjiUq701kuOWZr6qCrwxbuSieLyQVPq7XBQl1ETrfzXtoW+cTVSrfxKlrLBUxgIl5/hVVtZbDzZvFq15p6j7lToBpp2kq2LLztECz6V6rPDiwt1RCsY1nmzVb+JokJ8WebFuVsxoHdkuQVpqA9fN7tOeMaowpFUcctRVi4qlv+W1oBeIJy/naCpBR4pAwDa3h446E7i1hlWuRWC+waWJ4pUehUvMNLcektNcGaPHMCJtcaUP0VSyEUw63F96gPcZcr4gpkhGmDJV6+OfYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9MFXdpbMiIFrMuWIwXjrXykAEwGrogxnmsk8T89lvk=;
 b=l06h8cNBbOWaGKh7W6O6nDLwoeF3NtN1TKA8GvdCx2QDRkSugxcQxhk8U0BKRZz2Ma1E4oAgv78HsfauhwexpdH8zlazTdyxuMXc62TXctAGggk3wtJjQjq3/pLjy1UFkAoW50G3zsQ+ZU0qSnHIxOIzJjvMx67vkaOrwT+XIl1qVvpyhCljPcZ/6uepDnevEL/JHh4/s4kwNt0ZuDApT0yHY0ijNQ32bRn5tsznSm93MIZ2ulSZGoQ0N4hBpH3rZaNRcVWEtkB9gA8mIoltKftjOJj5n+nOGMuH+H6t5Tr8WnJY1NoYAi1Sr079qcQdeXCrV2dG1H/X3wY1c58GDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 22:05:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 22:05:01 +0000
Date:   Wed, 25 Oct 2023 15:04:59 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Li Zhijian <lizhijian@fujitsu.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: RE: [PATCH] cxl/region: Fix cxl_region_rwsem lock held when
 returning to user space
Message-ID: <6539910b1ae5c_780ef2949e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231025085450.2514906-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231025085450.2514906-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MW4PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:303:6a::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 449f5b8a-135d-4260-8f12-08dbd5a66f81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jaIWiUIM3SQRSKG+PNdCY5xVvAc32FrG2gyKYphKtd7hMKDyGkL1U+uKUdJE6j5u813pp7/4edwagJiUiAILqkK4ZB9I3P/iY7tlvSj3exMh+TGmkr6lwFTTaD9uSIWUESIujLnbuCLxFaKJhgTdMU6/X61ajbPQ/4WSbsSRZp0CoxQ7WC7HGC1fQNbwNgYhekex8YaiMQ4oUVfmW9lDmnQCr385CEEiZtchkfnZK2EKGAZ+o7OwIxqhtkZNivz6BrRjXA49+rHTIUiIBosGAu+tG4cZNru5WipMMPCyhu+3w8N+EzZQzMTZZEleJjupFa+NvGkbUkyauRR35twDojw7ZoM/vgHZbmonRGy0ZVan+byj+2duJMNu2SwifIlo+KYyoFCz7J35TWXpKsAyHCMHNOTdp1qwdhr2saKijld2bSRoEEQyajR/Fk80o61Jy2P81Uf6xFsv7q1gPifbkMV91VjCFU4KqhWCItw9KuQEc7phnJwXZSX7NDeVISX0ER6XCG/HVZf6aG8QcVyErPqaM6vYTA5jRUiLskTYae5scNSjJDoXILwtZjpabJza
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(66476007)(2906002)(86362001)(38100700002)(41300700001)(66556008)(478600001)(6506007)(316002)(66946007)(6512007)(9686003)(6486002)(83380400001)(82960400001)(5660300002)(4326008)(8676002)(8936002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BPnoJri7FYW5g5DdbUbTrJLOL+mGbf2oQMbzs8piv+bqYgcUi/qHRv0d3W4N?=
 =?us-ascii?Q?hZVLpnWkzdMJf8ZiEXkWACM1R6N3ZQ73fL1ht9fZyj466zJgiGW6BXz0H1UP?=
 =?us-ascii?Q?reE8cO0VdKnxOj2htCJ8Eu72x/tl9ctwnmhZ3WsGdlYzkqbhqnaVvp2m1TCv?=
 =?us-ascii?Q?zOlc/ydfLCeTEaA4wCpwMJMrI7kFIzUf8nA5H61//4S9ekdkW/i+3isbIxiQ?=
 =?us-ascii?Q?yeBTbk3PaPOOby8vwd99+ytQJlKDbHdq+0kHERCd00FHROc1UAueA/jBCvHB?=
 =?us-ascii?Q?nC+RuKDf8IZ1XJrxB2eOx19AUs79wC+4PP4F+OTbIbHAuAIfCwqC6A6sIVRX?=
 =?us-ascii?Q?Dh6SrMq/FyXtxSozQ5ej6VcChOIeytqOfLsKOosNd8D8EsTpPhX/PlBAZTYQ?=
 =?us-ascii?Q?OWZqMRBkE8pKvVpKGcLVE/vSQCvmxmdkumhBD27OKhOCTk9u59hdZfRc/Xnq?=
 =?us-ascii?Q?N3dsJwjcH6s9gCCMwDBxHl0oIuwNHEWHOTqKwqM5Cey5vetdBuJRpszbbThJ?=
 =?us-ascii?Q?c1cFOXrclK23GmQneMTtLuYbAU6EuWBnrZnlJpYeBv4/jOu0avMYw48K4yHD?=
 =?us-ascii?Q?xOb+3tcjBk0SsECWCFuaIYAnYZcwxsuzHe10OYOOd2O6by0/G1vb5xZIlmj5?=
 =?us-ascii?Q?FMbz1Y3pttjF6iFNS/FwG33QqA8e9O+d8poqFphYpKxsztFPVSoDEXHM1Yhf?=
 =?us-ascii?Q?uS+bTfpyIwuzrFCvVJxpWReW+Mee09mBqU8AzuaGCLKxALvTihH6uI30enHT?=
 =?us-ascii?Q?0jTrxsowSMX36NrTTk9Lnrv+Ay0gJ4jaf6DXScU0MloYelArVH9EsxK3HtVA?=
 =?us-ascii?Q?RjmJYNkD4SnJeafOF1Jc2Ll9B/UyeGcWOnd8LdWpbrE8Udn8sQp/gJYC335R?=
 =?us-ascii?Q?+wostzfbL+WLQZiXBdFYsd9Xh2BVMF1nSNi9q+u+ByiYNRpiXHA+CB+cOCpE?=
 =?us-ascii?Q?OcSWRq22HbtR5/eRaY7P0GQ2dKERfcYfeXu5zd5TsGKwKLT3rNO5WpRfEp7e?=
 =?us-ascii?Q?Zn4ygB49COH/lMVXwgUe2cwMOmZDkAXSOrs9a6KodytMjAs6kGcxTTn7l7vc?=
 =?us-ascii?Q?sM0zmTk0xt36UXTiQq2oaUAILPsZR0COoGhawnKCIPyLAFH7NBQ+d4HHJViX?=
 =?us-ascii?Q?qxIeyh/fbb/X1DsD0gtJOleEFwKR9/e5Oe24XDNuFlChApBaYrWCRa3uWqIk?=
 =?us-ascii?Q?imy6mEWpDphK1fhS9BSIJcd/KFBRJwWXq0qlMzJYnkdkAmeRgLT2aT/WvZP/?=
 =?us-ascii?Q?rbrpLitVVF2TeOAfZOgR3wlXlGA8Jjn+vPCe+zDZqqKSbMiyEFiCvqSMlgNj?=
 =?us-ascii?Q?NTLVxvXQhjjSqvY043IPK07eLxD8MAH5KNDf5zKX4VuN1FIqLkfhhmGpkPC2?=
 =?us-ascii?Q?GZGfPyNBYmZmgt3NrNVM0VPvL3viOmzcetE6k8kRIJDT0MLYcpX/aMw1T2eF?=
 =?us-ascii?Q?VjnHZ3drwAByjQusBg1NtZPmFc6H42S7Gxk4wduGG4NKfnhaNduUGgCSwWGX?=
 =?us-ascii?Q?0x+aORI8bs6CcJAGqrecZHXXAcZ4VpwDmTecqb6mPds3NfIVR13vRhQqQpgd?=
 =?us-ascii?Q?vJinv/H0dXUrzunqhGfeesSTYwXL32q8cecq4GlsbS1fY+HxBNR532nuR6Hp?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 449f5b8a-135d-4260-8f12-08dbd5a66f81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 22:05:01.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbc3Tctw5opk3OS+nMWwtRNgcZ28vz5LLoFvvZHFGakiomtt7WmjewOGfGB0NdUC/MnnL44CPi88gyWrlyv7lz+y5A+/FXFw1qgopHO1dQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7053
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

Li Zhijian wrote:
> goto out to release cxl_region_rwsem. Fix below warning:

Hi, this change looks good, the changelog would benefit from more
detail so that backporters can determine how important this fix is. I
will add the following:

---

cxl_region_invalidate_memregion() on x86 invokes wbinvd which is a
problematic instruction for virtualized environments. So, on virtualized
x86, cxl_region_invalidate_memregion() returns an error. This failure
case got missed because CXL memory-expander device passthrough is not a
production use case, and emulation of CXL devices is typically limited
to kernel development builds with CONFIG_CXL_REGION_INVALIDATION_TEST=y,
that makes cxl_region_invalidate_memregion() succeed.

In other words, the expected exposure of this bug is limited to CXL
subsystem development environments using QEMU that neglected
CONFIG_CXL_REGION_INVALIDATION_TEST=y.

> ================================================
> WARNING: lock held when returning to user space!
> 6.6.0-rc3-lizhijian+ #213 Not tainted
> ------------------------------------------------
> cxl/673 is leaving the kernel with locks still held!
> 1 lock held by cxl/673:
>  #0: ffffffffa013b9d0 (cxl_region_rwsem){++++}-{3:3}, at: commit_store+0x7d/0x3e0 [cxl_core]
> 
> Fixes: d1257d098a5a ("cxl/region: Move cache invalidation before region teardown, and before setup")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..18da77f8f22b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -294,7 +294,7 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>  	 */
>  	rc = cxl_region_invalidate_memregion(cxlr);
>  	if (rc)
> -		return rc;
> +		goto out;
>  
>  	if (commit) {
>  		rc = cxl_region_decode_commit(cxlr);
> -- 
> 2.29.2
> 


