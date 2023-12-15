Return-Path: <linux-kernel+bounces-1129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65711814AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D553282322
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDF0347A4;
	Fri, 15 Dec 2023 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zgYMbsAH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD722DB8F;
	Fri, 15 Dec 2023 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J//PYcA5jAIbZYTxiRAFVYIHPquk/Ifqya+R4JxFRxdSXM8Cp6CaYehrNBZu/++7qgITLjGPN03NTLtZzSGLEjoQY1+ZIKu8xkRGQj/54Vi7R5f4H4jTEOdwUSTe2ifcqSAS8OIKw13au23ImDEXrRibppH5/olB9mRBDbg0SFwJK7VVGinp/hzGqJmBIhbRMu/0rF0yUZxyqC9s8WGKl1tV9E4aNHHYUMEyLWlvI3QlYQtZnGso1Ga4/AGbjwmcSsXrMDBNIv4/TKSC2UJirbZxh9QX19g6SDcfswsQR+cHiU5MAbvrzfm4bcT/ACrdtUN41qCKb9Kv9YsO7oAcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SqgzzWfijJItV9jSIgl1b0YAIpvrZGNDzFnum+HfnQ=;
 b=H8r1qfQ3gvUcGmwl98bhXQB6J61hblS46xhxkapHfA4GJeDiIyoeyqy1YGnSyHPCGgq968jeq9N89s+R8FdZ/akN5UWXRf54YRHw/8Glr2GMwBSdCPDS0t6hBNv5ZRFjOoTLtZvn7EQ8ZH9kxFwxp82TFGKWNciH2mSR0vheJTiAE18PUDY+ZgnpSqrE51rLCY8xcTwhbH/E9zCqlIqeb6KSVIVmrpRz8gzPgLMMmFD6PeGF08YkBe0Sps0qdLt0HwoCChuqqn0fhFpw+K4OpeHeyyk2HfaU051ldHBqyb6yAbi4edpCRndKs0QYyv8DpXqZAvHWNnV+HEKNV1UTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SqgzzWfijJItV9jSIgl1b0YAIpvrZGNDzFnum+HfnQ=;
 b=zgYMbsAHl2xUnp8MfkJMBgVN/1qPIw11Nnm71ohIOffDuhY/0cQ3awaoS3w4Rmr3Fiwl3rE3KKzQnGxI47Ku2X7o4NIHLg14+xsDTTA+N2x0o6RZAqxbNnO+Bz0/BUuziefYJ7m6thgLqu/nqc69Ycimj/Kk0beVqxa4VYtcisY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 14:46:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 14:46:10 +0000
Message-ID: <b981f884-803f-4aca-a4fd-f68e443def2f@amd.com>
Date: Fri, 15 Dec 2023 08:46:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] ASoC: amd: acp: add pm ops support for renoir platform.
Content-Language: en-US
To: Syed Saba Kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, posteuca@mutex.one, bagasdotme@gmail.com,
 venkataprasad.potturu@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20231215130300.1247475-1-Syed.SabaKareem@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231215130300.1247475-1-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:5:100::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9cc9fd-ba04-48b3-73a1-08dbfd7c9397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+YQn1yDygYzMwC1rXbA2TAqp/IDerhSQN6G/UhXCTigztiMKH6ExQv/ZYbCu3ohdvZMqO8d4bEp7WnEFnM9haQDTkAUSDf2Ek778iAlWtw8A4GyGmBRuZ4IOZGk8g4dQ9hfpptEMwt7yV0ZBcE4Q+xHtrZVDzJGNZS6942IXIsjv07jnsezwv01eAgf8YCQEb99bja8llv+J6qRkrsnY8bU7riZsPbnU9kRqqOS7mts/ZCesTA1O4V7I2pcu2X0+Tcf72b4gS2Z6cnzFZc0vQRUIheLR8OiWXLVQztEhTHk99AFkHDUM877POm74l6EcOOn79aNGevkijqO11jbpEOtDtGl53Q9D89d5axDtbTvsa1rC6jc8jA1ixEv13EL8pLgwRkuDcILetbcqOVM5E6lJ4862XqO6SsXpytbSeckEuc7YorZI3CBPuuMo2yAYbMQ0set9dvtDcPskE+ugRECVU33Rjdb0xTlabgqeaVKrba2fvgTqhluVxDAkrd/NYavpc2dOYYccQozQjPANfvde8X4xTrk1B+IxVATWbrjqhZwBhOZJ8lkh1pdWi2uEb8i6IGFePUJsNpAeJUrj8bGIuqreXx4eKo01Xbi5f0j98OQgxjMTRbWOOyP00qb50YDxwErjH/Oec9IZ96Kbng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(2906002)(7416002)(36756003)(5660300002)(83380400001)(53546011)(6666004)(6506007)(38100700002)(26005)(2616005)(6512007)(478600001)(54906003)(66476007)(66556008)(66946007)(6486002)(41300700001)(86362001)(4326008)(8676002)(8936002)(31696002)(316002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjdsUHlQVXFjczBEV1h0YWtSYUJPWkovUk4zZXhxRkRpcFFzUHNneTZTZ2Ja?=
 =?utf-8?B?aU5wTFBXcUNZTHJRVDZJUy9qWjRWSDk3cUFBNjJsaFVsRndLUWJRb3NKTUFn?=
 =?utf-8?B?STNvUDkxRVd5cnM2MTlrb21qRWRFbTRhNkI2WkJZMWxaTlpMOVBoR3dQQlVn?=
 =?utf-8?B?S2EycWg1d2t0YlFqSlEwQlNRTVlIZE9waVc0YytWTFNuN1ppczA3RHlsdEdw?=
 =?utf-8?B?UVFIRmpVcFliQkRmQnErY2FKNWZKQ1FydGZqakNiNVR6SkVLK295Qk1GMzFq?=
 =?utf-8?B?dDdsSGZiUlJnQU1RTWk4Y0gzUDY1RkJkbG1sMGgweStYYWYrUkZ4bnpNT2hY?=
 =?utf-8?B?UGhseWJxVUQzVk5EMWpIWEFRbUVJaENEUTNZSXZtK1Q0cnVCTDFzWjU5dVpK?=
 =?utf-8?B?RjFDOXVkclJoc2VVR3pybkpXejhRcGxseHVSay9iVkt6TU03ZG12UFA5MEQ1?=
 =?utf-8?B?UHZmYjJhRkUyN0JjTVo5bUpyc216cE1Kb0xaVmVicEZXNXp4Rk9idzQrTUVt?=
 =?utf-8?B?Y2U1dzh5VmRZY2FZWmc3S3RzTTJxZ0RXOUZWNDR6WlFhV0QzZkpwcDBiZDNa?=
 =?utf-8?B?Nkp2VE82ZzlZNzg3cVh3SldBdmg3NVd4L1hLbW1oSzFmaXlrOXlsQzJ2OXFV?=
 =?utf-8?B?OFZDRkRaaElDVW1DQ1VzMVlkTVNhRHNON3VxeGhmc1BWNE9XUTd5L2dRcm9G?=
 =?utf-8?B?TXgrOElZUjRVZmRqbjh6aExrdjJoOG9UQUcwUHI1SXF4ajZhY2RtelloVEYx?=
 =?utf-8?B?TU9WQnVlZGZmU3RHWTVaZUxLRG9RWmN3Y1ZhdVBUbXZoZGlSRDQvTE1NaFlr?=
 =?utf-8?B?WVZZVGVCK1NIWWdzUFl6ZkhJaHVlWHV6MGVWRkNvK3FSelEyY0xuNjBnbFlX?=
 =?utf-8?B?b2ZPclZ0cXVHMWY3Z3R5eFpHZitGS3N1ZTJOeGV2SkVXYXY5dDlKRVBWL215?=
 =?utf-8?B?TGhqd1J2OGo5dlRrTlUzZ0V6bUdEaDhwYmdlYTV2bjMxaUVScGZ5UUpka0hH?=
 =?utf-8?B?emM2RlJvZmlBa21MQm1SeFNKUUpYYkYrY3pZa2V5K3BsZHNtczJLR2tJUTE5?=
 =?utf-8?B?WFNzUlFxMTlXMW9CelJmOHRrL3VWM0ZIY3lHT1pBVjZqZTlRMkdTL3N0WkRv?=
 =?utf-8?B?MmVHUGwySHpEUStkYlVoOTNCak1xNlBBNGRRNGtEaTdmVk1oTTMzd0VzcDlM?=
 =?utf-8?B?MW9RYUI4RFE0bDFYaVArSkczYWVvL1YzYlM5bVdiVmF3M0pzOTZvWmFOVEdx?=
 =?utf-8?B?TEpyR3JZRS9Ea2E4WnQzanZwTTF1VU5SSGhxRDVVdGpBcVhDcDZiMWtiTWNB?=
 =?utf-8?B?dXV2ZjdrZkVaSjkzcFF3ZS9UMHBZbHA3YXo5UGZ6M2ZDaEhKMkV1T0pqWkhj?=
 =?utf-8?B?aENtL1p1ZHZrU3piSFR5ZWQ1alJ2NE90M3VsOXhTcWY5Uk9xOEVGQWQ5d0JE?=
 =?utf-8?B?YmlpNk1YdGhsVnlvNVBWWHlhOThQM2RaZG5TWk5FMjE2cmkxVHlEd3NhR0Qr?=
 =?utf-8?B?Nk9PVE9QUXRUR0FPMHdXcWh5RktrMHdwY1EwaWowRDdVaGlKYjk5WVltSjVM?=
 =?utf-8?B?UDdnalVxZEFNY1ZQcEQ4RlRYSmNLWDY2NTRJOWIwbjRGeTNaNVBpVExkMEtq?=
 =?utf-8?B?cVowR1BTQ051OHJJR3NENGk4bmhqaWNkZXN2Y2JLRTcwbjFxZ2lLdENrTmpO?=
 =?utf-8?B?MFR5RGtOKy9BeTVJMk1hWERpTjBXbzZCWklHZ2IxME1LdG9lejZOL1ozTnky?=
 =?utf-8?B?dEFtVzlDcUpndzV1NFdIV3BCbjZIcUloMUEzYWVzUDVLTWViWmEwOGdMeUZu?=
 =?utf-8?B?UjVoNGtDN05lelFRTWJLUHJodUJqcVhzYUVQMDNXZ016SGFQMWtLNkJLWXdU?=
 =?utf-8?B?TitMY0xJVkpkaThQVVl3NVJRbVBUV2FyMnE2Mk54ZEdLTHlzOUI2cTUyS0hC?=
 =?utf-8?B?Mi9BN0VVUWY5VStwYTBTa3dzYmFuUnZ5UDNDWWpnVWZEeXpmdFdyY3VZbzZX?=
 =?utf-8?B?clh4VTFPOWUzY1IzbGdab1FNNHZ3QWxPNFp3dnZKaTdQZG1GZFkyVGZzMC8x?=
 =?utf-8?B?R3EwaGVaSDlURHdWdTdyRVFRbmhoQWoxVExvYm9pM25jZGdMT3FOOU9GbzJy?=
 =?utf-8?Q?dHyjb/AGTCSTi5uCVTzGjv3BL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9cc9fd-ba04-48b3-73a1-08dbfd7c9397
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 14:46:10.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvg7/IuUt9HKo+ehyyF6J2fp1ErkbRAUMFGEpWX9YeR5hB7mq8vICObZJmU5IHmQkli8anmJxlV77Eyvnug0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309

On 12/15/2023 07:02, Syed Saba Kareem wrote:
> Add pm ops for renoir platform.
> 
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   sound/soc/amd/acp/acp-renoir.c | 37 ++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
> index a591482a0726..b0e181c9a733 100644
> --- a/sound/soc/amd/acp/acp-renoir.c
> +++ b/sound/soc/amd/acp/acp-renoir.c
> @@ -20,6 +20,7 @@
>   #include <sound/soc.h>
>   #include <sound/soc-dai.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/pm_runtime.h>
>   
>   #include "amd.h"
>   #include "acp-mach.h"
> @@ -196,6 +197,11 @@ static int renoir_audio_probe(struct platform_device *pdev)
>   	acp_enable_interrupts(adata);
>   	acp_platform_register(dev);
>   
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
>   	return 0;
>   }
>   
> @@ -208,11 +214,42 @@ static void renoir_audio_remove(struct platform_device *pdev)
>   	acp_platform_unregister(dev);
>   }
>   
> +static int __maybe_unused rn_pcm_resume(struct device *dev)
> +{
> +	struct acp_dev_data *adata = dev_get_drvdata(dev);
> +	struct acp_stream *stream;
> +	struct snd_pcm_substream *substream;
> +	snd_pcm_uframes_t buf_in_frames;
> +	u64 buf_size;
> +
> +	spin_lock(&adata->acp_lock);
> +	list_for_each_entry(stream, &adata->stream_list, list) {
> +		substream = stream->substream;
> +		if (substream && substream->runtime) {
> +			buf_in_frames = (substream->runtime->buffer_size);
> +			buf_size = frames_to_bytes(substream->runtime, buf_in_frames);
> +			config_pte_for_stream(adata, stream);
> +			config_acp_dma(adata, stream, buf_size);
> +			if (stream->dai_id)
> +				restore_acp_i2s_params(substream, adata, stream);
> +			else
> +				restore_acp_pdm_params(substream, adata);
> +		}
> +	}
> +	spin_unlock(&adata->acp_lock);
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops rn_dma_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, rn_pcm_resume)
> +};
> +
>   static struct platform_driver renoir_driver = {
>   	.probe = renoir_audio_probe,
>   	.remove_new = renoir_audio_remove,
>   	.driver = {
>   		.name = "acp_asoc_renoir",
> +		.pm = &rn_dma_pm_ops,
>   	},
>   };
>   


