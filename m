Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198E380E0DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbjLLB04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbjLLB0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:26:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0667CE;
        Mon, 11 Dec 2023 17:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702344388; x=1733880388;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GrSPGg7HtnXQZ6CPnVsweXD2Kl06M2QiJOU3ZRu1Hcg=;
  b=PjElZ/7ODRjDVWnLak9Z4XMcuEGlLrizIatwaVwbwGdHSmn+Fl/aY9Bp
   fMJ3MPkJrgGa9YXuP8Hts8S/pU/hmsOZym1tij5fe8eqLP6zRRoXdryu3
   UM/5ti+JHPJlePET98+oSGwG6x5kV86c1ENEM1QA7/UaGpjm+xzfCDr7B
   TmQCxL0FAo/+RNDQwhgFfEZvb+RlXWmGddMZ2ZrTlzyk0LmGemVWWSWOO
   KOW96Mwnoi9+sNEkcz5aNZDIrhQNGXVQzBzAJb3kUVrj+gwZiaCMYLN2Y
   /y50zedpuGrDp8DQDKJPxzBS0XWUZTJjlPaSO676/JYace4FnOzecbVOx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="398584980"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="398584980"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:26:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="14741032"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 17:26:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 17:26:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 17:26:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 17:26:26 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 17:26:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEvidKFn14sRxhur6axY4RdojFbrxqfaWY4qiYN3TKmTgSEHuhundWC3s7BSls9oEOgXRaTlfFz7BHa4XiP1Q173rBHSgCoqxqCpc4OBGRQ9uLpucbI7yc75+NWnnRzdrSPFwzi94NYsX2n58WI+5N23PCOHUu3mijogwy331p5KN+8RK+4w0xCLA/6wFsBIoIGMAV4o6jyRlGry0DnaOYy55I6a4oiWBERQHOpShG8uMi1KbB8Hy2bXt/8sew7MQUsr+RvaqfHTzzhCM/rgwfBYRAYy+kcvVdaO+sdhXGf+bWiWwNKWTFwpItUUCDWM8Z3wCQMc3jvfmDo43qTSNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqJ1j60QVosnaJoTCMMRWtneC3Mllwns+osCdIFOqeE=;
 b=ZkD0V7M8D7pTCPqoPxMmvW8pMPmYK2Ksdt60NoZOf0C68CP4+Svh6C2J8yK8rqmtSCobv492Q8AysnGuBmrlCJYsmmxV/EZpOBHCNCG7BuDz0MTj5lws9hB/HWxuVv+ktYZu7gogO1w1/z9TiSuodH/pYsvPRHHLVF6ndjABIXwmCs9Q5W44H7mpL5nWwhekLdKzgHi0NKRWSEx49cmwxoW7MlSUHBegpsYMR+3i5bsHiP50MORTYIpGKkW1TbF7zRixCgmFrfoR/yhtU5/497LWtB07K0wDGg2WyJqXnNNubjn6mxrHSb8sIfLKPl1mJxC5i9nTFw+NPF0OdOgoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA0PR11MB4688.namprd11.prod.outlook.com (2603:10b6:806:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 01:26:18 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 01:26:17 +0000
Message-ID: <60c10003-083e-4025-98a3-78e78701043d@intel.com>
Date:   Mon, 11 Dec 2023 18:26:13 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] nvdimm: Remove usage of the deprecated ida_simple_xx()
 API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
References: <50719568e4108f65f3b989ba05c1563e17afba3f.1702228319.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <50719568e4108f65f3b989ba05c1563e17afba3f.1702228319.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA0PR11MB4688:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fc1f26-4cf4-4ded-c1d0-08dbfab1566a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gm+VGskxqMPUyB5VNHHUt44GC0yrslOxW8Lp5SwJYQhjN9tIOsCbTYIqlfRV+jRwxdjdwLdg+oPzYnE3DjNlgiAnKuWzyzlw+RXQTM5aq66eLqyqrEvFIFjvbCsNZQofmz7AAuqIyAUBJs2wwWS+j5AABJogAn9QLM9fJ1s18tW6I7fpvJj7/xYmTBHD91NbY+VUUoCJ3YWiC7vUGkjUClRS8oKmKdu/khJ9EgpbwTI3wlo9TGhB/3nUrwkqAkM3VkRIatCyJaZScGIOi2xpc8x0cc0p0TjkpViaDkVwRcLoLCAu9T2fMVxF0/d1JMDrX+2WVSUOh2+F1lNzBdL+HnnEv2AgnriXX6LN59k3KxU58bK8Wm2V5Lr+ESgOU/UeQg1lqyV+QEt5QSoMPjZImnZyCo3+q3Y++vGbFCsWWQpS8/UjftzEvLhgMfriNYc1hmEmGsqN/kGB6BoSRQbIaDVI3mElku6c2ZRCeSlRbpbhgj+NU9GV/M//uLImwSjE61DoucUVWNIbfTyx7+V1kgMVDBSYdEzZLeXQ1L7iAJJmrWvpA8GvNSCMjAA8/CZylIUamGwc3Ng9HCHQIXO89RA+LYPdXXqaxkgHJ9J9sEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(26005)(6666004)(83380400001)(6512007)(53546011)(5660300002)(44832011)(4326008)(2906002)(6506007)(41300700001)(478600001)(6486002)(8676002)(8936002)(66946007)(110136005)(316002)(6636002)(66476007)(82960400001)(66556008)(31696002)(38100700002)(86362001)(36756003)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWRxYTFsc2JqZmtPTkNxRE9DUHEzNWp1ZjFlUW94Ny9mbkdMc294OEErOFR1?=
 =?utf-8?B?ZlhLKzlpTWk1aSsybm1oSHdqQndWc0l5Y3BDMHdkbExLL3k1dDJic3ZRQzRm?=
 =?utf-8?B?K1RYS1dCMXVJVmMvSk1LQ0xKc2wrMDlpUGNSTW1Ma0UxUlNnNlA5TlV1WGJY?=
 =?utf-8?B?WVo4SEtLWDMyRStCT1ZmUTd5RFJBa29MVWRvTzZUYjVjTlZXTXNsdjRYUjZj?=
 =?utf-8?B?UHkwaFAvMVB3T0V3NVpqaEQyTzNhTXpaWTFTTS9HVXB0Z0R4TisrMGhnQnZC?=
 =?utf-8?B?Qzc4Nk5acXlCMTI1VkpwNWdkM1NWMXR3bnNzdnVka0tISmZOR1Y2Z09uN2Ny?=
 =?utf-8?B?SVQxSDNVL0RJMHRHY3lMbG1jNy82d0x5SkxGWFBHK2doUStEOEg4QjBxT085?=
 =?utf-8?B?cFEwZVV4Rk1taW5UYzQ3K25NK0xLZklhWldSSHBUYkM2M2htaS9GSHlIOVEw?=
 =?utf-8?B?RlByd2t5a3d4Q0tjWHd4WnZ3R2pZbHFiSHJtemxiUE9ubVRXSzJVNHNlZnZy?=
 =?utf-8?B?OElPYzdrWEdNc0FFS2NYazV0NWRSU3NQZlUxRGlrYmkrTFd1ck5uMUtXeDhx?=
 =?utf-8?B?ZC9pclVNRmRHa2E2UHhLOGMwdzZNSDUwbmxLSHdhcHBqakZIRGlMMTlhRHZH?=
 =?utf-8?B?NGQ3U3JOQjNIUkFBTWZDRDB5dkFYZ0I2aTdXeTBzcTdCOHFSUTFldVA0Uk1R?=
 =?utf-8?B?NlkyWjVNcFJlNFpTRGJzRkUrNlVwUCs0bWVGYVJwY2xnV1pzUU9vK2MzcFJ6?=
 =?utf-8?B?RS9XdzlGSzhYKzFrZVd5Z3dtTVVZamZXZzhuSklxMmZTdW9mZlRYVUFiNE8x?=
 =?utf-8?B?SXQyOW90SDdXMGpSRExQajVndjhKSkNrRm1FT1FNRjlOVDd2czFvK0NYYnVy?=
 =?utf-8?B?VjFVc0xwdVdjRndxSmoyanlidU1mUXVaNnZNVTFSWjVxd0hLY2V3U28vMTdS?=
 =?utf-8?B?aXpPbkR1Q2tENDBsMzBpTUIxQ0JrSWlSejQ4TWFSQ0pudnFQRnc2aUkvaytp?=
 =?utf-8?B?Vkh3WFdkbWoxQ29NcjB4MGNhSVBUQ0tjdTQrY2N5ZzZDQnFHRVJVdkNqektm?=
 =?utf-8?B?U3dyVEZ4OEo1R0NjMmQxcVdrbEFBSjhTQ1U1UzZtRnV1eVMyNnJqaDM5REZS?=
 =?utf-8?B?MWcrQzZPY3FnTFN5ZnJNRkp1VVJqMHVQK0JKUGV6U0hhSkMzb2hzZ1F1UmF0?=
 =?utf-8?B?b0s3UE5vR1pIMEo3Z1NTQUZYRkFPQVBRL1JKeXBtVEpSQjc4LzIrTVBWUXg5?=
 =?utf-8?B?VEFHMlVYekJFVTFkVzJnZmZ5U1YxRy93TUQySml4ZWw3L3p2UC8vOWtDMlZE?=
 =?utf-8?B?ZDd3N0ZOenBrOTRiMyt6Zkp1dHNWSHhBQ2xMSGhiemdqc2ZjRmdRbExjd0Y0?=
 =?utf-8?B?ZXh6UktIT1lxQmVWaDk3RnVMUUJoTUhLUmU1aTdWWG9WR3hmNjJOem1NeG9Z?=
 =?utf-8?B?UVJEQjU1NDhvdzAwL0RoTE9GVDY0UGdJK0ZVYnZRNUxtMURNOHJkaFdPOUYv?=
 =?utf-8?B?VXBCeXh4eXhYK2tNMW5LMDVCZG05cmppRkdVeGt1VGtnR2orTHBXMm9aOE4r?=
 =?utf-8?B?YnlEMU4vampIUUZUQ2drMngxV1BLYk43ckVWZFVWVk8wZ2R2U2dXN2FrMUd0?=
 =?utf-8?B?SGtKWFI0ZFptZnc5UW53TEhRSDhOcGhMcWFxU2N4MGRtTC9vZ1hHMnJYREsr?=
 =?utf-8?B?ZjFFUXpZZEJQOTAzd2hZaW00SFZiWWdWYVYzK3p5Y2ZXbWJQc21CSmFIMzdE?=
 =?utf-8?B?WXV1UXRUUHgyQWNldEF3ZkMwcnFvcWgyelhVcGNMSStvR2s2Q0h6eDZDdkRW?=
 =?utf-8?B?YS9VTnYvbEhzdXdrUi9DY3NONEdoZHZPUEdWc3hsUmxrTkdXVW9DS2xQcEFp?=
 =?utf-8?B?QzZjODhqdmg1NCtGSVZ3WHhKRFo3bk8xRG5ZcDVCWHhqOTZIcHRYK012RnVE?=
 =?utf-8?B?a3JNQmE2RlBPS0pWMFRSVk1YNit3cnk1WUtHeVJWYjBXWnFodWU4RzdxdDFw?=
 =?utf-8?B?dlY1OUZ3N3JCU2VWNk5QTld1VmNhME9tS25wK0dyeVA4eFJWdzZ1Wnp6Q004?=
 =?utf-8?B?VmtLbUpIVXlLVU9oSkdpVjNTSGpHOCtBNWorbC95YjVZRWFPSW5kY0k1eHho?=
 =?utf-8?Q?+RLKd4qEVXF4UkKuPBpkudYv9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fc1f26-4cf4-4ded-c1d0-08dbfab1566a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 01:26:17.4201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMsv81vq3RnS8RE2I5V8OP1Yw7nDzHTp1dPFxA1Arm6zvKEKL6pxcVGkiQfr+ebtDb/ArqMcefBTkVN/C/cdtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4688
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/23 10:13, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/nvdimm/btt_devs.c       | 6 +++---
>  drivers/nvdimm/bus.c            | 4 ++--
>  drivers/nvdimm/dax_devs.c       | 4 ++--
>  drivers/nvdimm/dimm_devs.c      | 4 ++--
>  drivers/nvdimm/namespace_devs.c | 7 +++----
>  drivers/nvdimm/pfn_devs.c       | 4 ++--
>  6 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
> index fabbb31f2c35..497fd434a6a1 100644
> --- a/drivers/nvdimm/btt_devs.c
> +++ b/drivers/nvdimm/btt_devs.c
> @@ -19,7 +19,7 @@ static void nd_btt_release(struct device *dev)
>  
>  	dev_dbg(dev, "trace\n");
>  	nd_detach_ndns(&nd_btt->dev, &nd_btt->ndns);
> -	ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
> +	ida_free(&nd_region->btt_ida, nd_btt->id);
>  	kfree(nd_btt->uuid);
>  	kfree(nd_btt);
>  }
> @@ -191,7 +191,7 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
>  	if (!nd_btt)
>  		return NULL;
>  
> -	nd_btt->id = ida_simple_get(&nd_region->btt_ida, 0, 0, GFP_KERNEL);
> +	nd_btt->id = ida_alloc(&nd_region->btt_ida, GFP_KERNEL);
>  	if (nd_btt->id < 0)
>  		goto out_nd_btt;
>  
> @@ -217,7 +217,7 @@ static struct device *__nd_btt_create(struct nd_region *nd_region,
>  	return dev;
>  
>  out_put_id:
> -	ida_simple_remove(&nd_region->btt_ida, nd_btt->id);
> +	ida_free(&nd_region->btt_ida, nd_btt->id);
>  
>  out_nd_btt:
>  	kfree(nd_btt);
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 5852fe290523..ef3d0f83318b 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -285,7 +285,7 @@ static void nvdimm_bus_release(struct device *dev)
>  	struct nvdimm_bus *nvdimm_bus;
>  
>  	nvdimm_bus = container_of(dev, struct nvdimm_bus, dev);
> -	ida_simple_remove(&nd_ida, nvdimm_bus->id);
> +	ida_free(&nd_ida, nvdimm_bus->id);
>  	kfree(nvdimm_bus);
>  }
>  
> @@ -342,7 +342,7 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
>  	INIT_LIST_HEAD(&nvdimm_bus->list);
>  	INIT_LIST_HEAD(&nvdimm_bus->mapping_list);
>  	init_waitqueue_head(&nvdimm_bus->wait);
> -	nvdimm_bus->id = ida_simple_get(&nd_ida, 0, 0, GFP_KERNEL);
> +	nvdimm_bus->id = ida_alloc(&nd_ida, GFP_KERNEL);
>  	if (nvdimm_bus->id < 0) {
>  		kfree(nvdimm_bus);
>  		return NULL;
> diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
> index 3bd61f245788..6b4922de3047 100644
> --- a/drivers/nvdimm/dax_devs.c
> +++ b/drivers/nvdimm/dax_devs.c
> @@ -18,7 +18,7 @@ static void nd_dax_release(struct device *dev)
>  
>  	dev_dbg(dev, "trace\n");
>  	nd_detach_ndns(dev, &nd_pfn->ndns);
> -	ida_simple_remove(&nd_region->dax_ida, nd_pfn->id);
> +	ida_free(&nd_region->dax_ida, nd_pfn->id);
>  	kfree(nd_pfn->uuid);
>  	kfree(nd_dax);
>  }
> @@ -55,7 +55,7 @@ static struct nd_dax *nd_dax_alloc(struct nd_region *nd_region)
>  		return NULL;
>  
>  	nd_pfn = &nd_dax->nd_pfn;
> -	nd_pfn->id = ida_simple_get(&nd_region->dax_ida, 0, 0, GFP_KERNEL);
> +	nd_pfn->id = ida_alloc(&nd_region->dax_ida, GFP_KERNEL);
>  	if (nd_pfn->id < 0) {
>  		kfree(nd_dax);
>  		return NULL;
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 1273873582be..3ceddae0509f 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -194,7 +194,7 @@ static void nvdimm_release(struct device *dev)
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
>  
> -	ida_simple_remove(&dimm_ida, nvdimm->id);
> +	ida_free(&dimm_ida, nvdimm->id);
>  	kfree(nvdimm);
>  }
>  
> @@ -592,7 +592,7 @@ struct nvdimm *__nvdimm_create(struct nvdimm_bus *nvdimm_bus,
>  	if (!nvdimm)
>  		return NULL;
>  
> -	nvdimm->id = ida_simple_get(&dimm_ida, 0, 0, GFP_KERNEL);
> +	nvdimm->id = ida_alloc(&dimm_ida, GFP_KERNEL);
>  	if (nvdimm->id < 0) {
>  		kfree(nvdimm);
>  		return NULL;
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index 07177eadc56e..fa1202e848d9 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -27,7 +27,7 @@ static void namespace_pmem_release(struct device *dev)
>  	struct nd_region *nd_region = to_nd_region(dev->parent);
>  
>  	if (nspm->id >= 0)
> -		ida_simple_remove(&nd_region->ns_ida, nspm->id);
> +		ida_free(&nd_region->ns_ida, nspm->id);
>  	kfree(nspm->alt_name);
>  	kfree(nspm->uuid);
>  	kfree(nspm);
> @@ -1810,7 +1810,7 @@ static struct device *nd_namespace_pmem_create(struct nd_region *nd_region)
>  	res->name = dev_name(&nd_region->dev);
>  	res->flags = IORESOURCE_MEM;
>  
> -	nspm->id = ida_simple_get(&nd_region->ns_ida, 0, 0, GFP_KERNEL);
> +	nspm->id = ida_alloc(&nd_region->ns_ida, GFP_KERNEL);
>  	if (nspm->id < 0) {
>  		kfree(nspm);
>  		return NULL;
> @@ -2188,8 +2188,7 @@ int nd_region_register_namespaces(struct nd_region *nd_region, int *err)
>  			struct nd_namespace_pmem *nspm;
>  
>  			nspm = to_nd_namespace_pmem(dev);
> -			id = ida_simple_get(&nd_region->ns_ida, 0, 0,
> -					    GFP_KERNEL);
> +			id = ida_alloc(&nd_region->ns_ida, GFP_KERNEL);
>  			nspm->id = id;
>  		} else
>  			id = i;
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 0d08e21a1cea..586348125b61 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -22,7 +22,7 @@ static void nd_pfn_release(struct device *dev)
>  
>  	dev_dbg(dev, "trace\n");
>  	nd_detach_ndns(&nd_pfn->dev, &nd_pfn->ndns);
> -	ida_simple_remove(&nd_region->pfn_ida, nd_pfn->id);
> +	ida_free(&nd_region->pfn_ida, nd_pfn->id);
>  	kfree(nd_pfn->uuid);
>  	kfree(nd_pfn);
>  }
> @@ -326,7 +326,7 @@ static struct nd_pfn *nd_pfn_alloc(struct nd_region *nd_region)
>  	if (!nd_pfn)
>  		return NULL;
>  
> -	nd_pfn->id = ida_simple_get(&nd_region->pfn_ida, 0, 0, GFP_KERNEL);
> +	nd_pfn->id = ida_alloc(&nd_region->pfn_ida, GFP_KERNEL);
>  	if (nd_pfn->id < 0) {
>  		kfree(nd_pfn);
>  		return NULL;
