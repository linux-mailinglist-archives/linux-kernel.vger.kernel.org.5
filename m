Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462377F124A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjKTLk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjKTLk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:40:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4C283;
        Mon, 20 Nov 2023 03:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700480453; x=1732016453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=maM/loag+0e1vOqj+tqfaXDKz+qhCEa5r88adAQaGQ4=;
  b=IpDMZBXCaFPOu02e7FyjPo3nTDX2Wv1HbL/gahWN8l7I8NB8fd3K+pB8
   Nxosyqzr+7dMEZahnq5YYXpswyZ3Tjqs06zo7FyrLmwR9GMxoD3RUqtvr
   3QbXFQrST6Mqax6Fuf/+LMPdTiv5w425vOpe3orXe1qgbJBLuhXhp+P3k
   QwUm8TT7Btc7AyO80PDgaa+zqA9bKlwgtb8WBLaIvFNdbvJjbpT0BoxTz
   lWTAOBOlk0gSXfY/JNTGrT1uNE5AVetGGbOsc056gNl8qXLSeqkC9YKpS
   PPzWVxx4SV9JC2ufpx1QezMwPsxk721UmqMX2IukIv9iG7p+EVIqtMawQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="381990312"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="381990312"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:40:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="742699936"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="742699936"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 03:40:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 03:40:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 03:40:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 03:40:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 03:40:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoIZfEm0PWJkKa2A8638DpcyJDZvw/pSwYAZp1DezIcMek4jcMafibXRG3Nrm7EDqgg0+uXrJRSCG4fANlKow3D5KrD7GfsPahi/vhWBMP+DFJy3dzykwaxM/903dFfJWCQyNhmAnYU7dVRQbexJ4mkAPtL99//kbLWTkiYH0qamF0ml1yrmjYwclWRtLey4+ZPV/eb0Fcr9k2RlnhN884ODJCneuP2graD4Kq/+fPgmpK26ST3dFzPDCl3l8155Jp7hdfWtyDWf9gjaO4+IGlHyKknXQwxRSBlfXltpyf1cG/imca0plpV4ltpUr4WoLahp+OHr5L6pmwUVSn4dQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IBYiWYMCk2qOxQTlg5adsviPdNgN5YZaSFpKFG6Uvc=;
 b=cmwUugsWp70MJzUxtCqcAbL+R2jGmB3ldXE6ky881kwa9K2aDoznTSagfN8il2ZOilykF3XC0rEOJB5GmeIJO+tnvK34vl65KDILWEprvazyVtdIezCRpH6UDG1yhkIQrVERge0mwMS8iwZUJppOl6B+T+3rv6OpGZVghnFTDfvBqaoGYg7mYoH7Q0VpM7M84e2ppZ47BSLU4R4dH2Z0GCZVTI9vxSRcxx3MyDHv6c5VqI8w/i6cQLCxcbHd0h2NlIqn/MYl+afRnAs+liVUmVALEGxjXSPUtyQ9eAGeE3dLdaDbXw7TCbxFU+/luiBtxDbdmEczoz9Y2zNCLvx67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 11:40:47 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 11:40:47 +0000
Message-ID: <1f836577-5f33-4662-bb32-26f99f737ee6@intel.com>
Date:   Mon, 20 Nov 2023 12:40:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: hsr: Add support for MC filtering at the
 slave device
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <bigeasy@linutronix.de>, <horms@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231120110105.18416-1-r-gunasekaran@ti.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231120110105.18416-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SJ0PR11MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: eedcfa5f-8a74-41a7-270b-08dbe9bd89e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6GjiLznhHwc6xHjSbPIiE5Hx49kilMIQ90NrCISVOy/BwSmBJ+DZotbgmOfVWTxBhuB8HOdKUt8MzY0QQeqB9KMTC8UyJDGF0RWcSRPvoI4jDX/Cpv7dERLzWcH9UNoAz5Q5sSP7sdPf7dTGPxnn3Cb5jTzhgMO5RjbEFdzsko3024vGF7bWRosFUx7dyLxcOQjOtvekw/1Hp898dpmsBnjRMI4FWHqBbbmCIqyY61l18YIvOWBIm0ZAzVC3tdy4g9Hv73VM6G9Rk/KT06WhYhFLKtI+UkolvZYe34gQ6KI++nSf71B7Myif39fd3E+gszWI24ZCrounptH4/4kcT/jGIyoqzQP5WoMkHdT5RGDG/sy90bpctT4Pf/sGYRkL4lB0s5qLPFGUZbILY1S2s5Byb2uk6ZJWRymII/yoJ2Mx+13vpeuMOsvCYOfrpVPDYVF/ZcPJfHAp+Pw+ibt4XcxNXff0CZmzIikRYMOSKCJe+Gm6MXi/r4drTFvHcBs2o9f27j4CJ1M02P/IcSryAtbbeDHrwn8MmqyC8GxmsHB0d9L2CS0OuVbLjzNeCOdOz4N0J2Sfy3qyKpB15r4UfB/eMl8hWawizSLpjD2vtQy4p5+erHPas6xahi++NYxzMFTM4miIDYT7ojy+HSFtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(53546011)(478600001)(31686004)(6506007)(83380400001)(6486002)(316002)(6512007)(66556008)(66476007)(66946007)(2616005)(6666004)(26005)(8676002)(8936002)(4326008)(38100700002)(82960400001)(44832011)(31696002)(5660300002)(2906002)(41300700001)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJIR2tMTVBmekJzbjJJNk1lcXNLU1VLdmJjc1d6Z24zWTRKVmVjdTVVRGZO?=
 =?utf-8?B?Wk9vM0I5ZHJyc3U4NXpzRkZIbFFHU1lUWU9mR2t5YVZEOXZLL2JhU2lqdnZC?=
 =?utf-8?B?L3pkeWh1S0pWTGtoQkY0NHpvWTg4NU5tNWl5dkF4cWJzY3RhWFptOUNqeHlk?=
 =?utf-8?B?c3Q0bEZZanFXWEtOQUtPSUpmU3pqU01DQkQzQUhkcHhkaDZtWmxxa3JUK28w?=
 =?utf-8?B?MWlBOGRmSGVMR21ja3FWbWtYZTRFWHhjdWFKdVQ2aGJvZmFOSjA1c1crNUxa?=
 =?utf-8?B?a2VVYllBMWN0OWhXZDREK21vN2J3TXdLOHBQcHNnYXAwUzVWVjRSVlhUbkxU?=
 =?utf-8?B?bWJEeHUyU3lBaEU0cDExTGJLSWNWUWNvaVhSSkdIUk1ZZ2pyTXBlS3hYenZE?=
 =?utf-8?B?MHB0NHRES01Uait6TEZ6K0psNVcwQ2YwckVOYXFFSko4c2hiUGZWM3pCWkFV?=
 =?utf-8?B?c2cvbTQybDhjSGJaU1VQNGtjSWx3Nmw0K3NwU1FzM3p5OTNocVFKL3ZIdzN1?=
 =?utf-8?B?T1h2eS9nK3k5b2QwUHc3L2hNRFZNVG5vV3hpbGdGdmRDbGZ6UGFLYTRCN0k1?=
 =?utf-8?B?RVh6b2F2OXI5WXF2K0RpS21jU1N1blM1a05pc1dmUzFQQmN1SzdMZTYzdnhh?=
 =?utf-8?B?Q3FjNnRTUmJTRWw5SHFSTU41RTlkK3ltL2RHVWxSUHhKTHI0OHN1ZDdJZ2RO?=
 =?utf-8?B?cCtTa3ZneWdCR0FnNDUxcEJacXdVQUluU2ViZzRocllnOFg0aGJReVg2ZXNF?=
 =?utf-8?B?b3dTR0E5Vk1yNVY3dlp1b3VTT3J1dEhaSjE5NWp5QVFJQnR5WE9xQWFIKzNm?=
 =?utf-8?B?R0NJR3BQaFU4VmNpcWlXd3dpY0VrQ2V0THJUUkJIdEloZjZ3NjhWczlEeUkv?=
 =?utf-8?B?YWtjZWFtODI5TEptRnc5MFMrRVlDbVI5Z28rR1NEQm5ZWUZXQ3luWlFuem4v?=
 =?utf-8?B?RU1qcnBLbzZncnpiY1RwVi9lMVAzVWhHU0VyWFArQUN4WC9rZmNsdjdJSmRI?=
 =?utf-8?B?dm9PQ1U1YVdPRlB0QXo3cy9salk1VDlPRFhJWnRIT2srUFkzaGZMNEdnNE1E?=
 =?utf-8?B?N3RQbTJNam8rUkJ2aWc1ZVFRWjBFY1FHVExrWDFKMTAvcytPbWdJd3lSc0Js?=
 =?utf-8?B?a3FZU2wvWFlxbitPSFdrZE5IMUc5d0YxWU53NU1HL0VteUkvd0JRMU4rblRo?=
 =?utf-8?B?L0ZJdk5mR1JMY0FkcG5GcjZjZm45anRROXNtTnFIaG9JMTIxOWRZdTE2OU1z?=
 =?utf-8?B?RXhXMWJCbXBEdTJ6UTNGUWtLVVdRb2ZYUzFPTURMQkpJd2JWcVZMQUpqeUJa?=
 =?utf-8?B?ZzMwbWcza0RFOEY4WnM1UVlUQlZTTEtPUllSdXdFL2tYTnhPeEN1bjlVdUE3?=
 =?utf-8?B?VnVrckpqbVBBYy8yUnVWV3YzTjZVWmwzb3IrSjlxaUk5b0lWTytOb3JLQlVa?=
 =?utf-8?B?V1dDRGpwVVlaQVBib21nenhjbGRyb05hODQ4K0hRaG5jUXg1RWU3NkFBUjAz?=
 =?utf-8?B?SnJHYU9VNmNLTS9wRENhVVNRUTEzcGtLblhKaE1FZFlwRnQrLzAzZ0xkSFFC?=
 =?utf-8?B?NHM2T1NnRzlYLzM5TjlRalBaV01oUzEvUm5ONDFBRWJ3QVREeWF1ZzFwbmdG?=
 =?utf-8?B?K0JIUTZDTXdNeWg5N1dSUStSVGNiMndORWswckY2RlJCT0R2R1VhM0dHUlV6?=
 =?utf-8?B?MXkwSEhlU0pNU0Vva3hHSmJ3SlBDVFFtQ3ZaejVxN2FTRHZSM2RrL1pmeVox?=
 =?utf-8?B?T3Njek93RkxSTEJ6cGx4NE1WREpDQnFzTEhwYkJsbEZUMWRGZldMeFd2MzVz?=
 =?utf-8?B?aUZScWh5OHl2V1pYWk9mY3laNkFUa0FsRHRMVXVRMVNTMlZvVlNLeDR5SVBK?=
 =?utf-8?B?em5EYUhnS2lGQnpiUjBoeTV0ZmtpRXgzKzNNbFozazVUTmxMNFFldVFqVkhQ?=
 =?utf-8?B?WjB6ZkFxLytMYlREaGF3blphdVFaTlQ2UngxaFZ3VTJobnBPVUNPOHlWSFl2?=
 =?utf-8?B?QkVOMXI5ZStvNE5zU3BhZFlvTkJlY2dXMmZrOUpmZXp2VzJxYmtnK3hUVUtX?=
 =?utf-8?B?b29jUXJBRzJUQTRNUHE4djlnTkRlcnRWZ2JRVmlIMXl5Q05IbWZEZWdYb0d0?=
 =?utf-8?B?UGFudDY0dnVtU0pVZEd3VTA4bFBLS29sbXRwSDEwVkUyQnkrTnZnOFY2amd6?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eedcfa5f-8a74-41a7-270b-08dbe9bd89e7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 11:40:47.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gklt7Da9VzrYlcNgfDUJL3cf0aKwbzrL7LFFGcyyODBssEXomvvZYIdtF9fbTHZHl8tQ8vrN8iecNqYdEkoHH8ILCQw68hcRif1/cWR8okY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.11.2023 12:01, Ravi Gunasekaran wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> 
> When MC (multicast) list is updated by the networking layer due to a
> user command and as well as when allmulti flag is set, it needs to be
> passed to the enslaved Ethernet devices. This patch allows this
> to happen by implementing ndo_change_rx_flags() and ndo_set_rx_mode()
> API calls that in turns pass it to the slave devices using
> existing API calls.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---

One small nit, besides that:
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  net/hsr/hsr_device.c | 67 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 306f942c3b28..4e8f4a3cefbf 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -173,7 +173,24 @@ static int hsr_dev_open(struct net_device *dev)
>  
>  static int hsr_dev_close(struct net_device *dev)
>  {
> -	/* Nothing to do here. */
> +	struct hsr_port *port;
> +	struct hsr_priv *hsr;
> +
> +	hsr = netdev_priv(dev);
> +	hsr_for_each_port(hsr, port) {
> +		if (port->type == HSR_PT_MASTER)
> +			continue;
> +		switch (port->type) {
> +		case HSR_PT_SLAVE_A:
> +		case HSR_PT_SLAVE_B:
> +			dev_uc_unsync(port->dev, dev);
> +			dev_mc_unsync(port->dev, dev);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -404,12 +421,60 @@ void hsr_del_ports(struct hsr_priv *hsr)
>  		hsr_del_port(port);
>  }
>  
> +static void hsr_ndo_set_rx_mode(struct net_device *dev)

I wouldn't add "ndo" to the callback name, let's not stand out from other ndo callbacks here.

> +{
> +	struct hsr_port *port;
> +	struct hsr_priv *hsr;
> +
> +	hsr = netdev_priv(dev);
> +
> +	hsr_for_each_port(hsr, port) {
> +		if (port->type == HSR_PT_MASTER)
> +			continue;
> +		switch (port->type) {
> +		case HSR_PT_SLAVE_A:
> +		case HSR_PT_SLAVE_B:
> +			dev_mc_sync_multiple(port->dev, dev);
> +			dev_uc_sync_multiple(port->dev, dev);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static void hsr_change_rx_flags(struct net_device *dev, int change)
> +{
> +	struct hsr_port *port;
> +	struct hsr_priv *hsr;
> +
> +	hsr = netdev_priv(dev);
> +
> +	hsr_for_each_port(hsr, port) {
> +		if (port->type == HSR_PT_MASTER)
> +			continue;
> +		switch (port->type) {
> +		case HSR_PT_SLAVE_A:
> +		case HSR_PT_SLAVE_B:
> +			if (change & IFF_ALLMULTI)
> +				dev_set_allmulti(port->dev,
> +						 dev->flags &
> +						 IFF_ALLMULTI ? 1 : -1);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
>  static const struct net_device_ops hsr_device_ops = {
>  	.ndo_change_mtu = hsr_dev_change_mtu,
>  	.ndo_open = hsr_dev_open,
>  	.ndo_stop = hsr_dev_close,
>  	.ndo_start_xmit = hsr_dev_xmit,
> +	.ndo_change_rx_flags = hsr_change_rx_flags,
>  	.ndo_fix_features = hsr_fix_features,
> +	.ndo_set_rx_mode = hsr_ndo_set_rx_mode,
>  };
>  
>  static struct device_type hsr_type = {
> 
> base-commit: 5a82d69d48c82e89aef44483d2a129f869f3506a
