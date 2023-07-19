Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828E97599AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjGSP0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjGSP0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:26:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399F7E60
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689780398; x=1721316398;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OA3xvVmng5WdxsRG4C58LZ+aDbWeIigpQD1I0v9rngw=;
  b=DeZNx0T2Bru68yDOmIFGiRFBUyYC6IG9cnA43fXtHWZB2owaVZbuePmZ
   OSw65LCyuVFgShlSBYX5sJ5PM9evn2CyaDtVrLM8L6tJRy42LnGO8gpnu
   fL+xnvS1/bdHFhSTfnVhN6m6pQgOn+ZTsIIUPC+SQcjztGjf3ZQGMtKke
   EhBJ1fpbH2kg2DKfcrFVQy6kBUvg/IQdbElBsKQq6f1mZnWhJsXA/2FAb
   B5Y8s5Z01Ihs0y82nT6szh0v0u4h0NBn87+P6p6FmB7YRltEoKvJKBK1M
   VBWpuozJ+8mqjfVcHtP3qQDSu5D+Y15jEcUsg/wIkdhDchjmS3OjgPP/C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363956511"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363956511"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 08:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="759230657"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="759230657"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2023 08:26:37 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 08:26:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 08:26:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 08:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyqbGAhYZZgqkA1SI1gWWdT9p6V1aQmZOpKNyQRhNtisxDtxktlOeZ2JAyfJGhx8X/GKGIswESgnjNybi+1VQcpigNRMVv/FSZtz5n0x5K/Cljt+eDYT0HkSDB8X81Jj0h6WZv+P6NyER83jDa33Rbl+IT6p+ccpMRzo2XZ5wwMHVFZNqw5QibVl8+dtkAGBd8wmr/OhwLK2ecpVXUHcStsmvUMWRhnfPoadDzy+GvhEge2ZxH6Z1trT3rzXB2Jdt1ypPv6OIYNVXiaSSrpqrrovaIHowIyD89wt2L+12EEtHqePTv2j78LNq7fQ1bgDtA6prca16fGGm5R78UaFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+iHztOIT2R316oIr9hEqe/UMgMp/o8FLlE0Hl1wz5o=;
 b=cxlEnT3IaQ6voKsspi35MBXjkXzG7JCaIzW0UzjvKCS+O6HuNHFojE51rulSMpUAIrg6QGD4kv1pDtGvMPDLWdB4OO22XNTmVMv9GkJ+l1k+t+869UrvEnZUnLcQ7K5WFEge9bx+LqzW7dNEUalOF8UFpdqtSBcgMXhVIo8Wv/UjJPUYwco5uWoy2RZ+ZzP9EJBc9IReh7xWDNF6vE2E72qjjh0sKBIV7F5DZ9J0pjrQHZks8pf+/EgVpm+RFGMiSvUyziY1+fw6Y4Ope8OmWM4hXFG2ddpJRYykFyDhDQgamhhdEfgyM7j53w6Oh83M845w9utRM1jpYyL02Bwdcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33; Wed, 19 Jul 2023 15:26:34 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::3a96:9177:fd4f:c649%6]) with mapi id 15.20.6588.028; Wed, 19 Jul 2023
 15:26:33 +0000
Message-ID: <18fb40b9-f5b4-60d8-79df-e0719cf48231@intel.com>
Date:   Wed, 19 Jul 2023 17:26:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/7] ASoC: Intel: avs: Move snd_hdac_i915_init to before
 probe_work.
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        <alsa-devel@alsa-project.org>
CC:     <sound-open-firmware@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Daniel Baluta" <daniel.baluta@nxp.com>
References: <20230718084522.116952-1-maarten.lankhorst@linux.intel.com>
 <20230718084522.116952-4-maarten.lankhorst@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20230718084522.116952-4-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0405.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::14) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|MW3PR11MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: 07821957-73cb-4ffc-3e9e-08db886c88d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H17W6jrpPFTVo+le8Mi01Pg7QnAHsx9hl72NUQ97jlSK1SRxPAxAxJTPXkGUXOqnIdTg7WzS9YDjkEI7gZ38CKR1YPffut7OsBNrJgiceHcVkMIFjwMtpde77Nohtd/uqAh0nUoPulAk+Pv6KsXbUJP7vr/artMIPcw5uQj/kmYgRKbbk34kMCEZPkJptmL6xryMaEvv1EYkDPkkKqj1er7Qvw5DFPpoZlq4EHq24IIGVx7DviUAIVGmZ6jxxz9jw/2DVR4+Nn2j29qTjkGgW0wuG2vGU/u5vWPj+ddmjX7kLXIAfAxkqaxQ59Rz3n8/Figbe122BVsjzpZbz2tYqOGrCmJkJR8zs7PZeied2L1v6W54180ITNUnXB4uKXC2h+o9DRHbLhysQyD8T+DR1qiGaQQtWISN72mzLZwjdDox0/XBDW2qI5POHoZ4P9tduLZOWWxHzg0rhDjrIaI9lsW13uJa+cQTnShVjARKFaEPMWEFb+2dz29D51jqA1tN57DknsH35vtIp2vxuvCA+RE55aC3je7c+uKRpvii2/MMuKKeKWAhUPSileMz9l8opGP+EiluQdCN5kRqMAuawqVnh+4F4Qf9zMRvT73tJ6N51+u9K1RA/JvZKdy+1LY8eIUXT3KIaFNmBeV8DUTlXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(41300700001)(26005)(8676002)(8936002)(6506007)(53546011)(54906003)(82960400001)(478600001)(4326008)(66556008)(66476007)(316002)(6512007)(66946007)(6666004)(36756003)(38100700002)(2906002)(6486002)(86362001)(83380400001)(31696002)(2616005)(5660300002)(186003)(44832011)(31686004)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWZuWkpxeFVXSitBRHFsanlKVVJtaTluWTAzcDgvekRvZkVSZldzKytMLzdL?=
 =?utf-8?B?bGFqamRuNGhPMjBPejVVWkZ2eTlNUVc1UWJ3ZkJmdCtmWHFyaXpIRnBpYkla?=
 =?utf-8?B?N2NxOS9rWE85YlEwYis3SlY1UTFIQlFTN0ZGQWIzK21iL2FpWWdjU0FHRWV1?=
 =?utf-8?B?bnVDNlM2blFjajNJT3RuUnlENDdDRGxmVThDQ0hEY0hvdDFrUzhtR2FmTHRL?=
 =?utf-8?B?czJFa05nRnZuWkFqaGNwdTJHakEzR2gxWCtodjdtK1NEUWFCZnpCSjVnWnVE?=
 =?utf-8?B?WnpPNzlHcFVWK0krcHh2N3M2M2c1NlVhNkt2OUhPczRJUUNGVEZ2VWEwempW?=
 =?utf-8?B?OWF5ZlRkTWl0WjlhWWgzRm14NXIxVTZZL3Q0NXRBNzAxWkEwVXUrVk45OXRj?=
 =?utf-8?B?T2c0U3RLOVRmQXBURVBwMy9WcnlDdFo0dEgvRUhxQlVkRXhFdmZlSmpSKytW?=
 =?utf-8?B?SWsxdVJvaHhzMTlLNFB1dnh4bTRjTFY5OGdHeDRpS1RiK0g3cW9UMjFsYklx?=
 =?utf-8?B?cDRtMlVTczRZTHNsT0Q0bnlObEhZcjI5Y0xia0dTNy9BZklVR0sxaWhFRHhG?=
 =?utf-8?B?bGdrYmRDTXprYjNQTFY2blpqcC9wNjFncXZZdHNtaUZ6YlJZRnlMRDlEUjA1?=
 =?utf-8?B?MXhhNVRDVDM0dWxYdHNlMFcvZ01BZXdYRlFmdGZkaWFEU0RVSDNyS2YxR1U1?=
 =?utf-8?B?cnZMTm1aQmJRRjgwcEtMYzVibENWTitGOTk3VVBWZmFMYU8rNUFLWHRUM1JV?=
 =?utf-8?B?S1hVNE5iV3lrRkE0cExLWmdON2pudS81SHZqaWppdmRaR1BtRi9iOWFETlRh?=
 =?utf-8?B?WmxjenZ3eW9nRDdyd1VycXVaaGlQcTVoYmNvaDBrdlpSOVdYNmo3eDcwbldX?=
 =?utf-8?B?L3dOOEVIcXVQb3dodVpMbGdnK2laQWVlb1VxWjZwMlJjcmVxUkx0ZGlZQnU5?=
 =?utf-8?B?dEdGT3lrTVZMWDluTk1aSkFNN2Z3T3BsRVRlMFM4NVhDdm9wd01NRFdUeVhH?=
 =?utf-8?B?SERVdzZ1TmRCQVNhd21KSmFDbXZVamxEWG5VcU9kTjVyeGV4Q3U4aEFFQkFm?=
 =?utf-8?B?clBWcGhXbVJoVVpwVzNYOFRFaFY4UVJFZGZkS3pyNlNmaWhZRHEvT2JIelNI?=
 =?utf-8?B?R3p3VUFFK1ZBMXJzNlBLRS9EWHIwa1YxSUtYbUpyZzlPME1CQlZDMks3OGJz?=
 =?utf-8?B?NEtqSDJHMy9LdzJrWGpwZVRUVmxQdjJqa0hlNXBQUitBb0RjYXNqNDJ0c3RH?=
 =?utf-8?B?ODBDdlBIeWNFd1lMSktINUlVVTJ0MUd2Z1ExdVhJYUpzSDV2NzNmQURVVVk3?=
 =?utf-8?B?SU01dzkrR05aY2h3S3lFSVRQNFFiVlFCNWFWOGtuRDZCN29nY0cxckg5b1NQ?=
 =?utf-8?B?MERVTkcyKzhTZjZ3TXpFSERzZ1hXZ05GRVBxaEF4N2lROUZrMGdJYWpnOGlu?=
 =?utf-8?B?c3pOTUxaWTk1cFhNOU14VWNNdCtuNmtobjczQ1R3a0dTSDAxa3RtMEo2TkF0?=
 =?utf-8?B?SzVIM2NlRHNUNjR1S1Nqc29GMWRzWkxsaWlYb1BidEtScWhvMEZhYUFHK1R4?=
 =?utf-8?B?dlB5OWsza2lOZi9jd1ZJcWlrci9Ga1h3OXQxajR4K2VXaUx5TEdpUFZZSFpu?=
 =?utf-8?B?TTFzUjZxRGxySXpmTXg2ZElOSTNLRUlSSEpOVlBuMWNkbE9RYjNLN3ZsUUoy?=
 =?utf-8?B?akttbmh0TGp3Mlk5MDBINWVlL0V0N0tQZnpvS1dvaDc5S1FydldJd1prVitQ?=
 =?utf-8?B?M2UrZUtUUi9oc0ZBc05uYTlzOGRDNkJOdkM0dC9xVmgxUlRzRzBTd2RhSzFk?=
 =?utf-8?B?REcrLzVsMU9yNEtTSXdIRE0ydmltSlh5eHVtKzZhRUpqaXovMGdRcW44WkJj?=
 =?utf-8?B?czJwK2w4K0pNVzJzNk9DbFkxY1pRTEFFYjlWTjVWNk5KWWhVZDlxemdqSjUr?=
 =?utf-8?B?em5YdmVVYXNTcndrTUI2NUxtOUdhOVpkd0hRZHJoNVZ4MktwRXExdGF2U0Ry?=
 =?utf-8?B?K0xWTmo0ejVlNy9QN1hNVFhJNklUNVFkVXk3UXBnOFd4MU4xU0Qzb0dvRzlo?=
 =?utf-8?B?MHBKdG9UMGt2TTNETzh0M0ZCTXpmWjhlcjk3amNCWDBwYW1OV0FaSGVnOHpl?=
 =?utf-8?B?b25TUjdCem1EaHF5b0pOWUt4RVVWY28xZmtFRjRRMy8zMU5SWnhWTlJJWmhB?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07821957-73cb-4ffc-3e9e-08db886c88d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 15:26:33.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfVRynVxW2ofSDNXgh5ywTm+iGfkKIfnosx4dGxLhix/KN0Z9tLnUxNf1bisb2k0mALBrj430UGECyumq47DPGIzzUDud/APc+1OLHxv38Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-18 10:45 AM, Maarten Lankhorst wrote:
> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
> the snd_hdac_i915_init into a workqueue. It's likely the whole workqueue
> can be destroyed, but I don't have the means to test this.
> 
> Removing the workqueue would simplify init even further, but is left
> as exercise for the reviewer.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>   sound/soc/intel/avs/core.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
> index 3311a6f142001..d3a7f42387e9b 100644
> --- a/sound/soc/intel/avs/core.c
> +++ b/sound/soc/intel/avs/core.c
> @@ -191,10 +191,6 @@ static void avs_hda_probe_work(struct work_struct *work)
>   
>   	pm_runtime_set_active(bus->dev); /* clear runtime_error flag */
>   
> -	ret = snd_hdac_i915_init(bus, true);
> -	if (ret < 0)
> -		dev_info(bus->dev, "i915 init unsuccessful: %d\n", ret);
> -
>   	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
>   	avs_hdac_bus_init_chip(bus, true);
>   	avs_hdac_bus_probe_codecs(bus);
> @@ -465,10 +461,19 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   	pci_set_drvdata(pci, bus);
>   	device_disable_async_suspend(dev);
>   
> +	ret = snd_hdac_i915_init(bus, false);
> +	if (ret == -EPROBE_DEFER)
> +		goto err_unmaster;
> +	else if (ret < 0)
> +		dev_info(bus->dev, "i915 init unsuccessful: %d\n", ret);
> +

While our tests are currently passing I have my doubts about 
EPROBE_DEFER. We do want to have audio functionality there even if some 
problems with HDMI arise along the way - some audio is better than no 
audio. Here, i915 may ruin the day for a platform equipped with 
hda/hdmi/i2c/dmic chips simultaneously.

Also, why call snd_hdac_i915_init() _after_ setting drvdata?

>   	schedule_work(&adev->probe_work);
>   
>   	return 0;
>   
> +err_unmaster:
> +	pci_clear_master(pci);
> +	pci_set_drvdata(pci, NULL);

Not a fan. It's hard to grasp entire error-step within name of a single 
label. Thus I'd suggest "err_<cause>" naming pattern instead. Even here, 
under "unmaster" you hid clearing master and drvdata both. Let's do 
"err_i915_init" instead.

>   err_acquire_irq:
>   	snd_hdac_bus_free_stream_pages(bus);
>   	snd_hdac_ext_stream_free_all(bus);
