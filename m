Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D349D7E1DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjKFKIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:08:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E8B8;
        Mon,  6 Nov 2023 02:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699265288; x=1730801288;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZJs8GrRIjJ2lR6XxxhjLDamV3936D6VpT9p81XEeuRQ=;
  b=Lb80MGkXi+3jrBrCNC8P0lhZPK1FyZ4MgK2cztQz8odqHeI1I2/ARN5P
   VV0sIsryF2Hw9An7Yge6d2koqCCrMhjONC+dnV2nrLAKdn3oTnXSAaOy5
   XGlH8bdTR4N2EUwGumQJepP4RIRGZVfJa96ddi7K1EjkR7/yz3QYYv4Vt
   0UVojMq7mK7ckToF6tSI6Aw5RgJTMhdc10jwkWZWyE3LWVi23hbKsrqMi
   zuYL6O0ExU2B8vQUDD/dUVZ6GIXOumi4qq4Z+sy/xD3MORMLstOgsYrXn
   d6LljImH8KkFJBPEtHK3M4nlyGVndDOo7LcYskv74y6EjO8A+iFW/oLiq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="379636201"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="379636201"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:08:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="879383165"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="879383165"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 02:08:07 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 02:08:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 02:08:06 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 02:08:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRUFPiJ3IaUTBbv198ufMBTaAz05hnKGvpZiSDflqErNdMaq2DUNWRXiO3Yql5SldlIz3KWzA+i5n7PVIxmzwKLJfWTD6DvqcxKWFj30lhF8U0bIkYte05NyjPn1X1h+DPxr7lugTi9tzX8yYVMEQYLnaHS14hhcn9IFRMQsVgzfpr0viaNhr8tEZInxxyTP+5t/p3mBbGbGS+vuWzNJGO65PaKdeIC36wTmQ3MQgwwlWoCfHuWLIAIl4C0O2UbTdZO3bJVF5Xws28//1ndEKxcWVoK9TPFW4NzBYT49+VrLOVU+UNHUQQOQGb8yrrgVUsOJSiN6FievDC+1hYUoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQzCHnrC0W+1820/oNzeNPYXtEcXBGuBWkeON90wB+4=;
 b=OHW2b/9EHx/6/Vi5gy4+y0hRdPw6o3qFznI0HtTGzQH4v37SHpMLXIqFFWh+HXQpMTtuYh3Tl73geIAwsWkaIQx3BpJeOadi81sJyIRnQGWciUef7e7GmLVZ9GpDaEdAsqJviZs9yVFSwEEnMF/50ySyLsgNQ3HqT2ZLqwnxO1eJKEfFiSEVJGaNgiEMqNgQHDB+RAmGGlDfgRTujg4v0z4KmlRTpReIliHu0hPb4yHM8Q24sM14/1xjKmSBIVPaeIGNar7w4mDULJ6FtAXWiWj2gWHa1p3YMn5P5zi07nJcICwT9WUC/Zakqn/qReg18sXSUuYedr/AxfcQuJ4S9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 10:07:58 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::1b1e:8472:f24b:6693]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::1b1e:8472:f24b:6693%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 10:07:58 +0000
Message-ID: <f8d6c53d-f241-4ba6-9e27-4d6bc5fbed05@intel.com>
Date:   Mon, 6 Nov 2023 11:07:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix error cleanup on
 failing pruss_request_mem_region
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <06ed13ca-9f52-4b49-9178-aae245bfd958@siemens.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <06ed13ca-9f52-4b49-9178-aae245bfd958@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fcb43b-8ae0-410f-3f34-08dbdeb04085
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GL8FcyC/Kl5BGUqRSNeOrjJKv43g4W1wQWJ67zVgkwFmxh/wAxpOunYBrTZaKvWeOP4TA//CVk0AlEiS/z1r+LCbnXDqNUr/phIPkLUtExlc0HDzwYTrI7dysSY2soTqxfMOIEYQjdWJhm9a8Mqg2tfdmKW8BX0DX2VNV9w5cKM5VjA6S675GScF3hB27kTVJpP9gecZzs7k9IMOs0wGHidNTu9nN55fba66xD4mVxQBtJWJehnujUZpDD5s+ZYAnRA+PCIbPlfga4Rlbkg6vt47FsfpGQIh8mikSdSA9h2Ld0eTRlU+y8+fkhiTQ/4aQsP6hbW4pA+AsEXpyPL9tEWU30jfzYDr13Cs/KP54nHS1IRawCGy3RZf5q/g4OzlaRaL0iDBMBq2Ld8sbRLZv4bbm7KRibfwty/Z4QVcxVwUlnbNc+d325azUCgqm8elGneINzYVU2zzPR6Ca+Rzqbz0wNNJI5SCKlvytjeKjpC56VsKK06EDBWYrFI3J+BzIQ6mklRqCEJu0hEv76LjHJdle+6ybeLWdrvhzs3/NUSzgneX06oVX4c47+sYD+infd2LV1CtjMh4B+G8mc0NBx8hGD4lHg7gebdMAHUdyQiSo4wkwYiOe5tocF7jZnpzHxkx7gUZEIciFNHW+xshA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(44832011)(6512007)(31696002)(82960400001)(6486002)(26005)(478600001)(36756003)(54906003)(66476007)(66556008)(66946007)(316002)(110136005)(6666004)(53546011)(6506007)(8936002)(8676002)(4326008)(2906002)(31686004)(38100700002)(83380400001)(5660300002)(41300700001)(7416002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXlBKzgxVzNDRmI5VklybmFXbm92WlBvbm9jQlFJVkNnYjVvclBCMlo0elRZ?=
 =?utf-8?B?T2djSkUyUjd3V1kwc1RYMG1rNXNsQmRudHRoUUYrTU5kZlRGTWJKOWxpVE9B?=
 =?utf-8?B?SGNEeThoV1RGQUR0MXhpNlJvWllXY0tMY0x1WW80RW5ydGdNZWdTU2huaHpP?=
 =?utf-8?B?Q1hqcUt3aDF5eE5RNytEY2NMbWVmUy9wbGRLTzZ1bDVUODBMTVVDUS9KUXVr?=
 =?utf-8?B?ME5vR1U2OG9uS0hpZTZhWmZvSG9td0QxQ3BvTmN4RjRkQkloMUlQT3hUVVpl?=
 =?utf-8?B?RXExRFprMS9OQWJwR0xlOHc1WkRxOFJHckhGdmtZTFdoTURuQWV3Z0FIVmVr?=
 =?utf-8?B?eFdXTHFaWXlkT0xnaElpQUdVam9tZFN4TFFmL2pJcnJQMFdWZXNnQXJlTk1a?=
 =?utf-8?B?NmdsVHdETFFMdUROcE9sbGlaUlJGQUZYWi9zVVhRc1ZVUTAxMEVTakI1QklF?=
 =?utf-8?B?UGkvUmdWcUhDUmV1UjdxOUhvbnBGbFNTT0daU2VqdlBZWm9iR3VnNkRHeE5i?=
 =?utf-8?B?dnlaWXp3dEZBcExqdHgrajR1VlNhanlPQ2dmaVBCTWdUTUdWS0FMdFloWHFD?=
 =?utf-8?B?Umx2TVBYWXM3b2pVYzlUajNzclJRdi8wZ2orSUJLZUNOTVgzRTZFYWxuSU5F?=
 =?utf-8?B?RFNZYS9nbmhIZW91M0l0d1c4aUNMZUxSZlZZeE43b0ljbEdUUVpXUDNCWTlk?=
 =?utf-8?B?TGk0cS9qSU1Mdk9tbjBnd1hvaWE0YmVNQmFRSzFxSE1MQytUQW15bnhJak9W?=
 =?utf-8?B?T0ZrNDJwQ2MrSi9TbHJ3d3I3QnpwVktkcWpiVGdEMFFzek1yMS8rZHJNWWNK?=
 =?utf-8?B?bmNFSGhXZ1pYZFArNC9VSlhUUk8vK2RaVjlaOHRBeUt1ek5nNytWcTJjMGxP?=
 =?utf-8?B?MzhJMUZqM0YzRGcrM0xNVVI3T252QjJLQ214VmNZdXJSbGJ5dmMzYURuQlEx?=
 =?utf-8?B?cU9SYW81SmdoakJxMUQveHlRcEsyZWRxa0xBK0k5K2l3RGZZSkN5eFcxNlRX?=
 =?utf-8?B?NmJ3Y0ZPWXN6TXNJSUNiOTFrZVlyWldNM0VOSVByR2U1c2REZWVYYlcvTFpV?=
 =?utf-8?B?SGFybDVDam4rSzBGeXJUYXhHNHYvbVFVbXhyeEZRQlpYZjhmY3NZcEszMVFi?=
 =?utf-8?B?SnNYS2RUQnFoM2NReExZRlV6ME9zSXF6UmJjU21VcEwxTmpqNGpVUlUybWJt?=
 =?utf-8?B?MzVOQk5LN2xWeklhdlBxVExjbUJJWkY2TzRXOCszSHlOam85ei9hYlhmTDlQ?=
 =?utf-8?B?QWxzQ3FnSStlWlhZWkF4MnppVVMweWVoSk1pa1cycEwwTVRkMUY2cXhIZWNW?=
 =?utf-8?B?N3JEUTVlTFFrWEFqT0ZIcHhVRVUyR0RDc2l2VjZZckFkd0x0RVp6eHBTVEVn?=
 =?utf-8?B?MEJadnJnbVJOLzA0R1FOdmsvVnV2RFBjM05LOFlsbDcyK2hRL1laZGRLMWFs?=
 =?utf-8?B?dldHZVV4M1ZPV2oyYk8zZGNTckdqVExMTGU4KzgvZXZBNmM4SUhNV0xkclJh?=
 =?utf-8?B?MmszbHd5QW01R1IyV045aXI1T1ZhTFNrVmhkWVl2VnJMZTM2WTJzaDhqTUpO?=
 =?utf-8?B?dWg3dmxrcTZPV1ZCeTlqL2hNWFdTWUZkZ0UzYVFpS29wZlk4cHNTK1lxV2k1?=
 =?utf-8?B?OVdaSklUYUF6OXNPNjQ2cHlrM2kvWHRzVXl0RXREOXJ4TFRuY01HekQ0aE9M?=
 =?utf-8?B?WXZlc1JsNFp3VnMxT0xJbG9LdVNsRGx2eHdzMlJJYzhvOXM4VC80QklxaVFS?=
 =?utf-8?B?Qmg1Uk9sMFVGZ3cybmZZYmtBeG1HNUR3YVh6WHNxQnV1MkluUVlrMjVyTitx?=
 =?utf-8?B?bDNQWWNkN2s1Rk9JZXlmejRjZ2F6M1VNT2dpYk9NanVDV05xa1djTE9RTkpo?=
 =?utf-8?B?eHlWRVdsdlFlbElLdlpDQmNzYnBxdlJQQTVVdHVvOFdCTFcvaGNhazJwRCtu?=
 =?utf-8?B?Uy9zVjZPOUR1ZVZmYmJMakN5dWh0emp4TjNzZDMrMVhmdStlQWg4cXBEYWtT?=
 =?utf-8?B?Tnp6c0t3bkphOS9ZM1lNQ3hQMjZ6YjFTNWlKOFAvaXV1WVdOU2hWbHU5WG1m?=
 =?utf-8?B?dVVCODdKWi8wWDNPSzJycVFKL2phNE1mQ0J6REZjSUVkeW92c1RWRzREMmtY?=
 =?utf-8?B?Y0xhL3psWHRLZ0tXTnJLZVBFcUJuR1I4WGhSSTh3Rmw1OWVlN1pOWERocHc4?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fcb43b-8ae0-410f-3f34-08dbdeb04085
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 10:07:58.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPdIOX/5tovWuIwPukKMbzJlXkbWLW8ZEkHX+olHooWdNcdr1UIksW8HFzTwu3SfQJYXuWWvnfybenAMsLYmXiXt8nP0xzS2zSm8yJtFgEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7309
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.11.2023 10:51, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We were just continuing in this case, surely not desired.
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> Changes in v2:
>  - add proper tags
> 
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index d119b2bb8158..845e8a782d3a 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -2063,7 +2063,7 @@ static int prueth_probe(struct platform_device *pdev)
>  				       &prueth->shram);
>  	if (ret) {
>  		dev_err(dev, "unable to get PRUSS SHRD RAM2: %d\n", ret);
> -		pruss_put(prueth->pruss);
> +		goto put_pruss;
>  	}
>  
>  	prueth->sram_pool = of_gen_pool_get(np, "sram", 0);
> @@ -2215,6 +2215,8 @@ static int prueth_probe(struct platform_device *pdev)
>  
>  put_mem:
>  	pruss_release_mem_region(prueth->pruss, &prueth->shram);
> +
> +put_pruss:
>  	pruss_put(prueth->pruss);
>  
>  put_cores:
