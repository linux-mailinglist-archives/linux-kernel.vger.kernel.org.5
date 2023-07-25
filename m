Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1888760902
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjGYFFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGYFFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:05:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A36E56;
        Mon, 24 Jul 2023 22:05:12 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P4xHKv008002;
        Tue, 25 Jul 2023 05:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yLAYUc3XxR4JwK7hTafWdygc9ZsLEyDajZt8xSA0Wkk=;
 b=VpaG8jqDw397vgsGenzaonWz9OGGfxVQf2sBGM+kVpbn5tjNtff3ZpEZT5SAZrRurZ4b
 4Ny18eXrSqvDzX2i0VbpIxpy8mVo+xY3uuqGRZHJJciJvbxOqi1XH5C/LBk0YZngn3Ml
 5U1nMrv5lzarih4ivg7/WWGYpVSWJgnIAP4a3Q87wa4pfuCqgBGFVppWzsme60oAXokK
 X8++T7OcXfLQpRZ/d+EpiassnrvaZKgKMaVzt+jMnUYTw3IkSFvmvz4jOFBfinHVttSf
 NWeCRM88MuYtGkKest1SHl0RNoQzL9Eff9YoL9VOhk/cSU+T+CIcBXnaknj7l7qZTrcW /w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1sr71ssr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:04:29 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P54SVQ014523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:04:28 GMT
Received: from [10.110.90.103] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 22:04:27 -0700
Message-ID: <07931697-8f91-487a-06aa-9d247bd77316@quicinc.com>
Date:   Mon, 24 Jul 2023 22:04:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 12/32] sound: usb: Export USB SND APIs for modules
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <bgoswami@quicinc.com>, <Thinh.Nguyen@synopsys.com>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <quic_jackp@quicinc.com>, <pierre-louis.bossart@linux.intel.com>,
        <oneukum@suse.com>, <albertccwang@google.com>,
        <o-takashi@sakamocchi.jp>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-13-quic_wcheng@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230725023416.11205-13-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xh41puLVhBPoJh7IulUa_m7BBYQccO1H
X-Proofpoint-ORIG-GUID: xh41puLVhBPoJh7IulUa_m7BBYQccO1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_01,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 clxscore=1011 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250045
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2023 7:33 PM, Wesley Cheng wrote:
> Some vendor modules will utilize useful parsing and endpoint management
> APIs to start audio playback/capture.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>   sound/core/oss/pcm_oss.c |  4 ++--
>   sound/usb/card.c         |  2 ++
>   sound/usb/endpoint.c     |  2 ++
>   sound/usb/helper.c       |  1 +
>   sound/usb/pcm.c          |  9 ++++++---
>   sound/usb/pcm.h          | 12 ++++++++++++
>   6 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
> index 728c211142d1..7773b5362e1a 100644
> --- a/sound/core/oss/pcm_oss.c
> +++ b/sound/core/oss/pcm_oss.c
> @@ -444,8 +444,8 @@ static int snd_pcm_hw_param_near(struct snd_pcm_substream *pcm,
>   }
>   
>   static int _snd_pcm_hw_param_set(struct snd_pcm_hw_params *params,
> -				 snd_pcm_hw_param_t var, unsigned int val,
> -				 int dir)
> +				snd_pcm_hw_param_t var, unsigned int val,
> +				int dir)
>   {
>   	int changed;
>   	if (hw_is_mask(var)) {
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 9365d1e17836..a3fad66a3337 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -1076,6 +1076,7 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
>   	}
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(snd_usb_autoresume);
>   
>   void snd_usb_autosuspend(struct snd_usb_audio *chip)
>   {
> @@ -1089,6 +1090,7 @@ void snd_usb_autosuspend(struct snd_usb_audio *chip)
>   	for (i = 0; i < chip->num_interfaces; i++)
>   		usb_autopm_put_interface(chip->intf[i]);
>   }
> +EXPORT_SYMBOL_GPL(snd_usb_autosuspend);
>   
>   static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
>   {
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index a385e85c4650..0757499599c8 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -866,6 +866,7 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
>   	mutex_unlock(&chip->mutex);
>   	return ep;
>   }
> +EXPORT_SYMBOL_GPL(snd_usb_endpoint_open);
>   
>   /*
>    * snd_usb_endpoint_set_sync: Link data and sync endpoints
> @@ -1503,6 +1504,7 @@ int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
>   	mutex_unlock(&chip->mutex);
>   	return err;
>   }
> +EXPORT_SYMBOL_GPL(snd_usb_endpoint_prepare);
>   
>   /* get the current rate set to the given clock by any endpoint */
>   int snd_usb_endpoint_get_clock_rate(struct snd_usb_audio *chip, int clock)
> diff --git a/sound/usb/helper.c b/sound/usb/helper.c
> index bf80e55d013a..4322ae3738e6 100644
> --- a/sound/usb/helper.c
> +++ b/sound/usb/helper.c
> @@ -62,6 +62,7 @@ void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype
>   	}
>   	return NULL;
>   }
> +EXPORT_SYMBOL_GPL(snd_usb_find_csint_desc);
>   
>   /*
>    * Wrapper for usb_control_msg().
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index eec5232f9fb2..b6fb6d84d9eb 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -87,7 +87,7 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream
>   /*
>    * find a matching audio format
>    */
> -static const struct audioformat *
> +const struct audioformat *
>   find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
>   	    unsigned int rate, unsigned int channels, bool strict_match,
>   	    struct snd_usb_substream *subs)
> @@ -147,8 +147,9 @@ find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
>   	}
>   	return found;
>   }
> +EXPORT_SYMBOL_GPL(find_format);
>   
> -static const struct audioformat *
> +const struct audioformat *
>   find_substream_format(struct snd_usb_substream *subs,
>   		      const struct snd_pcm_hw_params *params)
>   {
> @@ -156,6 +157,7 @@ find_substream_format(struct snd_usb_substream *subs,
>   			   params_rate(params), params_channels(params),
>   			   true, subs);
>   }
> +EXPORT_SYMBOL_GPL(find_substream_format);
>   
>   bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
>   {
> @@ -446,7 +448,7 @@ int snd_usb_pcm_resume(struct snd_usb_stream *as)
>   	return 0;
>   }
>   
> -static void close_endpoints(struct snd_usb_audio *chip,
> +void close_endpoints(struct snd_usb_audio *chip,
>   			    struct snd_usb_substream *subs)
>   {
>   	if (subs->data_endpoint) {
> @@ -460,6 +462,7 @@ static void close_endpoints(struct snd_usb_audio *chip,
>   		subs->sync_endpoint = NULL;
>   	}
>   }
> +EXPORT_SYMBOL(close_endpoints);

EXPORT_SYMBOL_GPL here as well?

-- 
---Trilok Soni

