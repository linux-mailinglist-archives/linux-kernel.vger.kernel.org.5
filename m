Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C115F7EF5AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346040AbjKQPu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjKQPuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:50:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CFAAA;
        Fri, 17 Nov 2023 07:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700236222; x=1731772222;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+l+mkZ84SFROJDul2JSTrnz7IlwkbaOPjNTXZabTOJU=;
  b=TQ70L8esEL3Y9eiMIA+KrbTqpjovSJf5PNDO0dRTvXeuzsJ4Y0mqHKPk
   o0vOIjkIFagz8kaSdAvyuyh79JmbucsH8Rv0p0DwS/ieYnH3YJdyBy9qH
   Jy02vyHRv5JT5MwBhpPjAKGNzdj92i6F0NJJnvaSbN2vAnp8H62QdgkVW
   kYCUPeTGeG8jvOuFAtBPtgyb/Sj2gU3wrXYabRVPF+LQtzpbz8jXyWSXv
   a2Re569q2NRQ0cVFzVQyOJ6/N8CSjY9kStv1pvVvyvqiwajME+g6TVM+V
   RGM6wrhZCPeRT4xsh678EWxF3tVXUJXbhM6cOTrvgIBREPc1ZNh+YTrEi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="9980048"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9980048"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 07:50:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="836094454"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="836094454"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 07:50:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 07:50:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 07:50:19 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 07:50:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGOfTgHOCs7W86og8m9yHQ/B9KEby2/WgvhY14/AfgN9WQGkAe0rpI5le9wDJTUvEtkZQVwYIcPGNXK7PXNAs/jEN7zv0f3EiivMvmw6f1t03Iht60CW8VgtQO5+TJ52JhXWTA/WBnmRyr24xK6aS97aZmZeDjMCQ3XdJoEbruJpKNfM/8QhPBfZdUE7hN51YkMYERwDYcBh9Aj9xxHXxtd6zTuhmHpZq0G+ck2bLvXwT8NS4ryGyerimatUdALs5OtJJRGRwZYiyf17lPQVIsT3W4c+Magb55cvoIfiUWpBOrw+sV0DiJJ0wUgOl9k9fmeWOdPGNBkM6KwceFng3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQHMLoPpOrKXsnMJTGn+99EjzJtuWPdtF8OCh+Z0rPU=;
 b=dLwyTZzkUNhEBFoFTPezjeZ/om7sFxi5byxsYzLTr3baZ8kzudqHHqRqxU1bCYLIRJsfw5MhMbTXm1e04fR4nWyA7Hgm2fUtGgX3wJdeuPW6Is6p6Zn8juZGLDsbfkgjZ0eTVT2QT6TIpplTU5syEetTeJV6N0P0206vAgN+/IOH94idyHbTUl//a3suuMzIlVpaJpHs4uTT+IwpEkgHOA65A8hivDAnLzLAY9pu4Mag3usSn8+QJXG2OnN1qXYKZyKUWZWQfEIMHDY/z1C5xKM/v+pSpPYA3w+/w41v9c4qadZdaJiuWppSOCPjwY717ZnEKIcZ4gBM1/wCy76CzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB7292.namprd11.prod.outlook.com (2603:10b6:930:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 15:50:18 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 15:50:18 +0000
Message-ID: <67fbbd3c-d4ed-4fa1-9802-fbb5c045b426@intel.com>
Date:   Fri, 17 Nov 2023 08:50:14 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/cdat: Free correct buffer on checksum error
To:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fan Ni <nifan.cxl@gmail.com>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::19) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0c5095-c1ef-4cdc-8e66-08dbe784e59b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rg4gjQgp4cWpH1/wPL4DWybUVgqozIuqz9LaXtWXtV8kpcQDnwBDleVh1DnjAA/dMFz1gx4VvprIgyI7pw+kS989L4lk44leJbvLK5sJ2WuRLV54YtU8FfIFmC1ychE+Ego3+gL613Sf+BVgaHAlRgxVzrZC+XxcMUljRHxlEulJtZ3Wgv0m7J5TKvEkrrUkCQUIKsUlXyPEXL2l5/JXX4NmJgDaa1dI3d49bnCxaM8H4kALCtza1HCYMfdpD7FO4Khty4VguiWY7MjM9GtJQop6FHDE2cM6hzaPFYux4EN5y3zRttbcLkuUIbfT6gZUoFV0ksXrpEeeDGYxbU08wMnb3DhkLn30sqgFKIEGN1ljCKYgWC4T/trlK8PR/t3R5qyTSvIZs23rCaSpJ+Vcfe1nGst4rD2Z0ODzDikzXVD0XdcCLnX9MfkOAwWIlDA7Qx5tfuKLSuEhHile6h7KvDZGSUx6qsJDVXJOmWhJfYpvkTYce+PBx8bW4Fuy5xtebeSfNTZPaCA3TF/Th30KLRwQBXCdrYdlAKnGfC49tYG75zSjYguXTiW9GcxG/rUaw1VWUAkHn7nwh7ouyJTq6G1djVrtx98YVlDNirJns/aNhqoj9OBRckqf5LzAjLSw225TzlrMl+bHsQTjjKxWD7QljFag898wwQUHv30NZ9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799009)(451199024)(64100799003)(6666004)(82960400001)(83380400001)(6512007)(6486002)(478600001)(2616005)(41300700001)(6506007)(53546011)(31686004)(26005)(110136005)(38100700002)(66556008)(86362001)(66946007)(316002)(66476007)(6636002)(36756003)(4326008)(2906002)(31696002)(5660300002)(8676002)(8936002)(44832011)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUN1bG00VXlkb0loRW8xLzJTMnFpakJFejNVZVZJc3IzcFBWZGRUZUN1dXhQ?=
 =?utf-8?B?YlJNVUJWOUp1TTZRakJmR095RTZMZ2I0Sk5Yc2RVOWdvV2IwS3lTd0c3cUd0?=
 =?utf-8?B?U2RITzZIVlJ4cUNhZWdlWDMrOHd0a3d6bFhTQkJjTjBteUV5VDV3bjdCdVVC?=
 =?utf-8?B?K0tRTks4WEZkOGRoYkM2bS9yVWRGbmtrREE2TFA2NVFtaDB6RGVuenRxa2hv?=
 =?utf-8?B?NFc1ODNtbXA1OVBucmNnQWcrZFhFcDZEQ2pMODVSWmxTampWM0pLTXVGaWxU?=
 =?utf-8?B?eHBBS2F2bE1VQWtjeVFPUm1SZ0VWaVVLaXpXYi96MHRKRGsweXRLYzZGV0tP?=
 =?utf-8?B?U3hyczlqZU5oZzVXaHBZalRJQVZxZm1rTDRsVkNITE1GUlZlTHB5QUpiaEo1?=
 =?utf-8?B?L3RGQUpqMUJvcE9NVDhyYXNUSVNrcERrbWhNRjhKQmRteElZN3BObUlPVDE2?=
 =?utf-8?B?WTV4ajlCWWFtWHNmK0FEajQ0QlBGVUxQSTVYenQ1L1BhMzg3a2dIcSs3d1FN?=
 =?utf-8?B?dk1RbHZXU2pQSnNHQ1F6aDYyL1VMZmlQdlpLcVorQzMweWZkQlJxd1NZQUFy?=
 =?utf-8?B?bFNnVGlOTVhCd3NucE5Sek9yd29HbmI5VHpuNjZicWhVV3htTVhqTzlmMjhn?=
 =?utf-8?B?c0pPWnhWdWljZGxxSmhxNm9HTm5pSmtKbVMvRXdtdHVqeTREM1hvUlpPQjRG?=
 =?utf-8?B?U3pkWXJ3M3krc2NMczY2YmdIU3ZTRjBhcmsrZ3pzVlYyay9ENDFqMjZyWC93?=
 =?utf-8?B?M3R4UHdWbEpEd1NQWXdncVZuTDR3TXV4MDZsUkplQVFCZC8vVzhHUm5kRm90?=
 =?utf-8?B?cGZuejZObTZMWk9VWmErN2RYRkVoZUgvZzZtODJ1cDNnRkd5bE5xczNtZEtR?=
 =?utf-8?B?UFhCWk1RNSttaEt6V201cjNLems2UnZET1dhTnFNNmFHRno0QkJKdWFBTGVG?=
 =?utf-8?B?akxGUkt2Vml5eFVtTzhMLzFKRmIxWkUyeGNtL0dueXl6MTY5Tjk2ZGhOWStB?=
 =?utf-8?B?Q2FtSmdodmIyV2NlUXZKdHdDQjdNUWo4a3kvWWk4c2tqZkhzNG1KVDI0bENw?=
 =?utf-8?B?Z2QyNFBmNUM0RUw2R2lIWE9NeE4yR1BWVC9DUlovZ3pNNkFvNWdZa1g2V2JN?=
 =?utf-8?B?VVlzZitWNTBxeVRHeDc2UUxBak9BRFB5TXUxQzRzV3I3dXlvVmFkSlRLSi9T?=
 =?utf-8?B?NVFKSUZ6WldnVXFNVER1bVhLdXlCUjhpWStNNCtncVFkRU9rcVRHeHhKQWxu?=
 =?utf-8?B?dFVjaWxGVmUxTFdmSEthejhaSmt4a29mZ1Y0dEFzelROOGZUWlNVd3U0UktE?=
 =?utf-8?B?RXAzaUJJRnNTMFBzbFVDMlVWb2NKcnFyVkR5ZFdEYmNkd1NCSlQydVM3ckIx?=
 =?utf-8?B?V1hFcGU0WS9TbVphaklaTStjMVNMa0dhSFVxU1JPS2RuNlg1MzdNRUU1SDlK?=
 =?utf-8?B?V2dRZW9FQ2J0SVVRLzR1UDFWb1Z0YTBhOXV2blpuUTlxNHhLbk9va3lrZEpT?=
 =?utf-8?B?c0p3LzB4bXR4UHpHN1NIaFZpQ2pvVzRXZ213VWNLMG1PQWp4SXY0R0Yzd2lk?=
 =?utf-8?B?azJIbTRiQWNDZTdMemFpaHlSN0pjMDYzMk8rL3ZVUjEwUU9MTmFPclRyNGli?=
 =?utf-8?B?aDA1U0JmbG9mM1hQTitKbmlHV0J3V0FNZHdLQ0Q0aDZVREc3UitNQ05ESGRE?=
 =?utf-8?B?MGZFbUpKUklzNzQ0NzgwR1hkbCtjUm1xZ0JKMHc5ZzVsaHFJZWpjSWZaSFFY?=
 =?utf-8?B?ck1VOGNlU3o3ZUliSzk5c2F0OCsrK2VvOWVRaTRmQlZsbHcxV0I4VjkwNms5?=
 =?utf-8?B?akljeTc3RXlZZERGUDBZanJYYVdsMnpuSncyamcweW01UUVBdHRLekc4c3Ro?=
 =?utf-8?B?MmZucVhYYVNPdWlaQnpjd05mNEkxT05pMVd0ZUJLK0RhVFdMRXc4a2RoT2Rq?=
 =?utf-8?B?VW52R0xvUS9LV3ljQjN4dGtjeTJKdk5CUHB6ZnlBemhLZzBka2RRWERIV0xp?=
 =?utf-8?B?b2pJQmp5cUw3QUdDUWFUZTBpWkdkVm9KdFRVMGNXNyt3a0ZzdjFRbjFkd2py?=
 =?utf-8?B?VnREek52bnBpZzVPcDUxYU5xdVkzT3FqOVlDSTRMazdySlFCNlRhLzBFQmNS?=
 =?utf-8?Q?M/YOJIbub7gAq9m0PythblNv+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0c5095-c1ef-4cdc-8e66-08dbe784e59b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 15:50:17.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6/leIjjJpPWrhBrpMi5uPYxQcNqlVXm4JTvsb363Iafs6VdEMHUO4lisqaj2DkL9yi0SoGdB2kAjiC/enZv8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7292
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/23 17:03, Ira Weiny wrote:
> The new 6.7-rc1 kernel now checks the checksum on CDAT data.  While
> using a branch of Fan's DCD qemu work (and specifying DCD devices), the
> following splat was observed.
> 
> 	WARNING: CPU: 1 PID: 1384 at drivers/base/devres.c:1064 devm_kfree+0x4f/0x60
> 	...
> 	RIP: 0010:devm_kfree+0x4f/0x60
> 	...
>  	? devm_kfree+0x4f/0x60
>  	read_cdat_data+0x1a0/0x2a0 [cxl_core]
>  	cxl_port_probe+0xdf/0x200 [cxl_port]
> 	...
> 
> The issue in qemu is still unknown but the spat is a straight forward
> bug in the CDAT checksum processing code.  Use a CDAT buffer variable to
> ensure the devm_free() works correctly on error.
> 
> Cc: jonathan.cameron@huawei.com
> Cc: Fan Ni <nifan.cxl@gmail.com>
> Fixes: 670e4e88f3b1 ("cxl: Add checksum verification to CDAT from CXL")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Thanks for the fix

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index eff20e83d0a6..5aaa0b36c42a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -620,7 +620,7 @@ void read_cdat_data(struct cxl_port *port)
>  	struct pci_dev *pdev = NULL;
>  	struct cxl_memdev *cxlmd;
>  	size_t cdat_length;
> -	void *cdat_table;
> +	void *cdat_table, *cdat_buf;
>  	int rc;
>  
>  	if (is_cxl_memdev(uport)) {
> @@ -651,16 +651,16 @@ void read_cdat_data(struct cxl_port *port)
>  		return;
>  	}
>  
> -	cdat_table = devm_kzalloc(dev, cdat_length + sizeof(__le32),
> +	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32),
>  				  GFP_KERNEL);
> -	if (!cdat_table)
> +	if (!cdat_buf)
>  		return;
>  
> -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_table, &cdat_length);
> +	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
>  	if (rc)
>  		goto err;
>  
> -	cdat_table = cdat_table + sizeof(__le32);
> +	cdat_table = cdat_buf + sizeof(__le32);
>  	if (cdat_checksum(cdat_table, cdat_length))
>  		goto err;
>  
> @@ -670,7 +670,7 @@ void read_cdat_data(struct cxl_port *port)
>  
>  err:
>  	/* Don't leave table data allocated on error */
> -	devm_kfree(dev, cdat_table);
> +	devm_kfree(dev, cdat_buf);
>  	dev_err(dev, "Failed to read/validate CDAT.\n");
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> 
> ---
> base-commit: 7475e51b87969e01a6812eac713a1c8310372e8a
> change-id: 20231116-fix-cdat-devm-free-b47d32b4b833
> 
> Best regards,
