Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1377D94B6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbjJ0KIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJ0KIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:08:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562BB111;
        Fri, 27 Oct 2023 03:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698401278; x=1729937278;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LxUytc961084NW3nAi+dwfOhkpq0rGxyzW3LMGEOj+Q=;
  b=XPD2MqXIQx/TpGAmtkFrYH9q/SAwx0KQmtA7DvdSf7L6uxcUDPq2gqvI
   2wX2Vo7wdGP1qdOxunyXinO1A1yDqZR7udIUaUa45QuW+r4c1bi23sirS
   eSUlVXCikXwTxuOt9618+tzmY47JBUr/Eit52qNeq82Qs6zeBfNRdMQWp
   NBFC73WlW0yV9xuqmHBITldoNSKSpZihLZ32HnzbncEJvrdH/h7ajWL44
   kcgM4eyjMBXKwicUPI86QAziNJRrPUTcJPZ1dL3vARoep0EIuM2jqpm8P
   lyqpJ5eqEwT5djMSUParfhrA5QPYrgyjFxPXtK87cQdvsTy8M2+p7Szw3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="387561384"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="387561384"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 03:07:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="933024900"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="933024900"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 03:07:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 03:07:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 03:07:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 03:07:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdAc2q6tvS3G6ijGt9MlKdtPI5Vq+TffmVx3mntI5cs7JTOf6WxDN3VcKumfe8wlNVCOJGwilBZfh/6MiC1894yF5hgKgSCl5RqqJjSkm1SUAgXFo3wSvBsQbNBdT11vFLgSlXcWxNLHk5E0HMIjb+C+ndDbvpnEQVLG3PnILpyIxavXMSwIt0LoD+yrxWjy37963YoHrNn5O6rhoiRyA1Xsrg8mTpH2gjbUvTuf23YBwRqj4uPHMTM4k+Huybld9IUgQeSjGwa/Folj/Aew/sVxPkygTCtyzgZA8tGQXloFbyy+iz7snT9gQ2MPS2BCliQPq+1RqaWrgyUNVyF4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkMD2/Nb5FPb+qUAzdiAPdO21I31HcNPp3a6iS6ilbE=;
 b=XHQN9/v/s9jGTooSX8aKKOrvM/brT7GiD/qDLTUQEoViapE18FQWR1T2RLfLtxKlLLxS/m3sPJamS+7n/zFEg/god/ghPInOMFuWXnc8n8R3wOKKcYy5uJe6M+4HFYTN/s0dLgHhFpB0qf/+IQxyZXoI5iJE7C6YXudOto/CzdIiXjSPp4aH3p2xoeQOd9liOLWaYGtm1jBWBvlh6WMNGor72eeEZ6nnHCKMX0rdtglzEpgVSxqINa8WstnkGKFUjdmCf0ii0CaP0ZCLh+LjkZX1N9RyIeGWlB+vPiEhhFauxGsi7F/xxVct07kmNqiMqUrqkOQ7xziGvuMuBIrRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 10:07:50 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 10:07:50 +0000
Message-ID: <99233115-89ca-4ae8-8679-a16e1f959727@intel.com>
Date:   Fri, 27 Oct 2023 12:07:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/1] net: stmmac: check CBS input values before
 configuration
To:     Gan Yi Fang <yi.fang.gan@intel.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
References: <20231027061114.3792619-1-yi.fang.gan@intel.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231027061114.3792619-1-yi.fang.gan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::22) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW4PR11MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d75ddf-66a2-4700-01ef-08dbd6d493d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bl4RuclLSlfauec+pTtSkaB3D0FZcUcT3OsgL0+dULFhwQp2XYdixapJxTj2Vq1qm2FTVL/jF5+RgdWQX364rbeZvX/hTlM0M1HEgVgHnZ2wSyLobjLFkxH5aqExIGp6dWj51vHZxNj64VzcZWGiNxvXRBZFIGwdIPYXNPbj0lnXm3kpysprGoTG9NcLIha+LNTgFAHJ+fs62l2rluP7wqpZ52FC1w5x9p363SKg14ejdA38ksFMi4z5ucjlyki4KFxf1g/jFO6ja6UkmBFiZTHQrdDPq6jCLCAc/iqg+OqkTLhiinVwnb1zvnu7B7ztLrCk5JcIJ3WrO8qCoMAOUPyTCrgtQ673l77D9wWQsBj7LyEkSdSJmbFQ4Y2s8aGqHjd6ITcUA+11LtNDW4dpcOdUem1idKu0Ktf6MjdrkLG2zKmqynmY1nBhELRKUj4m74uzskg+XHLJX4VMCSDGpVh9lEDy7fdFYeune0aGY1jM8fL3uHhqyseI0VvD8+KdzJhJ3Evs9J1cV9RalyspDUWcPCvtagZ3LcoScUolQ1jMj/jmHWRHIHJE0fVmBoVEOxqzsAVAwkKHCBehZVIFMftZLz37ZS8G1EDzfvwTRg5GyQ00L4rEc88AlIlAD8LJL8kH68tBfTTO/D7JgpEwR9VH7V/IH2bJzDNWoJ+iv+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36756003)(86362001)(31696002)(921008)(31686004)(6486002)(2906002)(478600001)(6512007)(8676002)(8936002)(41300700001)(6666004)(4326008)(6506007)(53546011)(44832011)(83380400001)(107886003)(2616005)(26005)(66556008)(110136005)(7416002)(5660300002)(54906003)(316002)(66946007)(66476007)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3NkSnladDJPckQ1blZ4YzEyUHpoWnpMT2FrRDc2U0JRVVI3UWJmeHdmOUxX?=
 =?utf-8?B?ZndmMVNqZXBVd0ZaemFORTQ1OVROdE5JeXpIT2N1SUNEZWo5ck9nZlVPTWhB?=
 =?utf-8?B?a0s4WmJKSGpKVVlxb0VHNFo4dkRsekR4TXJRS0MrcGx3Tkt1VyticWlVYndP?=
 =?utf-8?B?aWQyNGpIdnNDL0Rxa0RlZ0hCZ2tnNXZXa2NuTWtjcHI1akc5MGRTa3lOSFZa?=
 =?utf-8?B?ZDRoRnduSmJ5QlRXRXVXeHEzRzh3bk85d0tFam04T2ZOblRGUTVuV0t5dUlx?=
 =?utf-8?B?VmRVNFVVcDJuNnpKRk9RZ00yNkkwVlFGY1QzcmxCRm9BbVA3bXFINjdIQjZk?=
 =?utf-8?B?SitURXc3NHpvUVZtUnF5SFZ6eEZ4VzViWGR4THhYR1NzblFDbENvazRhczZG?=
 =?utf-8?B?TGpXV2FibHZxeXRZWHhicFZGQ2J3Q0w5S25iV1JBMm5TS090WjRSQ08vOUJ3?=
 =?utf-8?B?aThXbXAwYzNuWmtjTUlaV1Y0aDFaTW54QTJnWlpsRlN1UURtaGpxakh3NklK?=
 =?utf-8?B?UTU0OTFxYmk2WWo0QkY0QVh4MzV2c0d3UFRCdDV5aUhSdytkdDk5S2RpRFNV?=
 =?utf-8?B?aWx5SzVkSHYxa3dFVG05NGdEMEM2SnRpM1dFdTg1NHk0ZFFhTTVnVG1Gc0sy?=
 =?utf-8?B?MHFHM05sanZxajBiQ3AwTjlCVFZGNjNIQ3gyWEhHa1lTa0d1UmE1Q3dxTFFS?=
 =?utf-8?B?TW0wSEhHMWZ4UUg3UDhQUitzckQ3OXhjUzNsN2VsNkEzMmJyZTZoM1hBTHB0?=
 =?utf-8?B?aW9FTmdncW4zTitEK3JOUXM3clJhVTZFQjlzLzhsRUxwZzNBd1FSN0dSa2hM?=
 =?utf-8?B?ejVYMFVrVzVHUWhXdERETElLcXVpeFYvK3NXZXhKLzBjNmN6UjA0WW96dlhw?=
 =?utf-8?B?K3JDTkpueUJTZ2x1WHM0S1Z6Y2l3aFBUaG9EbnVzWFZSODZpaWdZc0xSR2hm?=
 =?utf-8?B?NE52dlEvdjMvczNNUFVCeGVIQk9BUjlqZ3pQazg5ditGUkVSalVUTHhsSHQ3?=
 =?utf-8?B?RmpFRS9QSVdCNTlGcmxjMHhtbnFlNkp2d3FvSnZzaTBacnVxVStLRWxMYmtt?=
 =?utf-8?B?eUFDSEc0N2V0T1Y4anltZzlML3hSWDlmS1EyZkpSVDJ4cUpMd0pZMGFOemkr?=
 =?utf-8?B?SmtjN2pjZ2hNQUFTc21IbFhFSWdROEM0YkNFTExBNVZZNEpWdXZTYXFKdURu?=
 =?utf-8?B?Zm9LR3hFZ2xMV1kyN3cyOFpXK1JZVW9qMzdPV2R2UEpPSnNaQ1FGR3M3SnYx?=
 =?utf-8?B?Zk1ZL1ZVQS9sMlNxU255MVhydE5TZzdYU2o1RXFrekIzZnVObTFvMFBJcEZE?=
 =?utf-8?B?VGZybTZhNTFDaW9URG1uNDZmSU40cUZROVZkMnlyZ09mLzFsQXV2ZGVXejlB?=
 =?utf-8?B?anN2dkppbkx3M0RBMjZkUGl3S3dSUlE3TExjZ0E4Ny81Vmd3WWF5RFNjclB6?=
 =?utf-8?B?YzBWdXJlVDhVMGpPT09ZSjRGUmJ1czB3Y0hyN0NEZlA4amZ1Y2ZFbTVLV3pB?=
 =?utf-8?B?ZjA5d2ZZWE5zUUt5QjBmUnVjNnRUb3E3VkUyR21hZzU5WXpGT0R6MHJ0Q2Jq?=
 =?utf-8?B?RitDVklDdUl2eUFJelZYaUdydE0xdW9xY3JsYjNyVFpMdThrUDlQQXlZd2Zo?=
 =?utf-8?B?MUVDTnYwanpXT01zMXF4czdzbjY5aXlZWG5NQUZmdW9UeVdGb2dWTEpjZnVF?=
 =?utf-8?B?M3MveHF6eUtYNEcwT2hCdmtFNnJ5aG0va2NFNzl6UGp2VWtuMGhDektxZ3lL?=
 =?utf-8?B?VmRLZ2FFQVN1bG5iLy9aTFhQK0JudGFJOTVxZ3VCQzlRUS9RYm9nSzZkcGdS?=
 =?utf-8?B?STBWZTVZRFl6M0wyN2JXKzhlc0hjeVNZU2RFQnVIZFBJZTYwemg5RmJIVUlN?=
 =?utf-8?B?dWtKSnNPVDR6cWlLYmRHeEdYVmlKZFFrcE53dkRZc1IyWDVGblprb0I2bWNL?=
 =?utf-8?B?OERrV1Nqd0RxVmF2VlNnbGVRRXFwei9OQmw3YStJdjkzWnJlZXRBTzdjNWxt?=
 =?utf-8?B?azh2a0NyY2xrRHhEK0VETUc3SWw2Vk1KZHJkNE0vWFljV3VsVlRKc3diQzl5?=
 =?utf-8?B?M2t3U1hGU3FGV1B0dUVtK29PeENETmo1eEIwUVhGVDR4UzJ4TnJKQ29HVThU?=
 =?utf-8?B?QXptdzhEbHB2TXcvN0RHanZIZ0YweGJyTmJ1OFR0R1dqUUxIOTB1WG14L1Fo?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d75ddf-66a2-4700-01ef-08dbd6d493d8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 10:07:50.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xwf2eNJ1QjNDh1PPLg5YjifOXereS4kAMWRQ+egCnwWGQ9C/gT3djtArvbRCxRpT0myvSviwko+gSMMZWQ442Ych+5cGxk5/VnNBBJZ3JJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.10.2023 08:11, Gan Yi Fang wrote:
> From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> 
> Add check for below conditions before proceeding to configuration.
> A message will be prompted if the input value is invalid.
> 
> Idleslope minus sendslope should equal speed_div.
> Idleslope is always a positive value.
> Sendslope is always a negative value.
> Hicredit is always a positive value.
> Locredit is always a negative value.

Can those values be equal to 0? The code allows it but the commit msg doesn't mention that.
Some drivers does not allow 0, lan966x_cbs_add e.g. Would be good to double check that.

> 
> Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index ac41ef4cbd2f..e8a079946f84 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -381,6 +381,11 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if ((qopt->idleslope - qopt->sendslope != speed_div) ||
> +	    qopt->idleslope < 0 || qopt->sendslope > 0 ||
> +	    qopt->hicredit < 0 || qopt->locredit > 0)
> +		return -EINVAL;
> +
>  	mode_to_use = priv->plat->tx_queues_cfg[queue].mode_to_use;
>  	if (mode_to_use == MTL_QUEUE_DCB && qopt->enable) {
>  		ret = stmmac_dma_qmode(priv, priv->ioaddr, queue, MTL_QUEUE_AVB);
