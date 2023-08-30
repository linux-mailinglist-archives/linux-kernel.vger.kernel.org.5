Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CDF78DF01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbjH3TLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244281AbjH3MvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:51:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C228D132;
        Wed, 30 Aug 2023 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693399864; x=1724935864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RSyj81n43sFmtQjzuHfNNauGPkAW6fiLijQd+FzizcA=;
  b=iKtgWQVKbZGOI6SoRQWdACyuHirlarsbd0gH85UJJ3pFkn2wJZXVXcCP
   JwsaxRsKfg8VmKLOPUZHEW/Y4heWbhvR1KKWi9qFQ3KdRNMeEaG23W175
   X4nV5kvNmjGhxvTnXWPxucd1dnp/E7dGAPKQTJfleRg8AG8iKNcEHaiFF
   mD2xWqlW7XOI+0quOAiKzsL9keBuedhLRYFs+fiN36z3AJA2rVrnEfjVB
   15YyOTdRlTJoVMl9lIt+JHNeThJyYfNE5w9mJOm1gH+S9I8aeCJAhu7Jp
   0anQCmwfI3m1gPbCh7HqkTOx198glpDDXFPuLiskZWAyLRKQERt9Z6guu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="365839418"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="365839418"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 05:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="739082012"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="739082012"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.91]) ([10.94.0.91])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 05:50:58 -0700
Message-ID: <5a5eb3a8-1379-116b-ca17-eac573207c57@linux.intel.com>
Date:   Wed, 30 Aug 2023 14:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 12/32] sound: usb: Export USB SND APIs for modules
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230829210657.9904-1-quic_wcheng@quicinc.com>
 <20230829210657.9904-13-quic_wcheng@quicinc.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230829210657.9904-13-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/2023 11:06 PM, Wesley Cheng wrote:
> Some vendor modules will utilize useful parsing and endpoint management
> APIs to start audio playback/capture.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>   sound/usb/card.c     |  4 +++
>   sound/usb/endpoint.c |  1 +
>   sound/usb/helper.c   |  1 +
>   sound/usb/pcm.c      | 67 +++++++++++++++++++++++++++++++++-----------
>   sound/usb/pcm.h      | 11 ++++++++
>   5 files changed, 67 insertions(+), 17 deletions(-)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 067a1e82f4bf..b45b6daee7b7 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -1053,6 +1053,7 @@ int snd_usb_lock_shutdown(struct snd_usb_audio *chip)
>   		wake_up(&chip->shutdown_wait);
>   	return err;
>   }
> +EXPORT_SYMBOL_GPL(snd_usb_lock_shutdown);
>   
>   /* autosuspend and unlock the shutdown */
>   void snd_usb_unlock_shutdown(struct snd_usb_audio *chip)
> @@ -1061,6 +1062,7 @@ void snd_usb_unlock_shutdown(struct snd_usb_audio *chip)
>   	if (atomic_dec_and_test(&chip->usage_count))
>   		wake_up(&chip->shutdown_wait);
>   }
> +EXPORT_SYMBOL_GPL(snd_usb_unlock_shutdown);
>   
>   int snd_usb_autoresume(struct snd_usb_audio *chip)
>   {
> @@ -1083,6 +1085,7 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
>   	}
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(snd_usb_autoresume);
>   
>   void snd_usb_autosuspend(struct snd_usb_audio *chip)
>   {
> @@ -1096,6 +1099,7 @@ void snd_usb_autosuspend(struct snd_usb_audio *chip)
>   	for (i = 0; i < chip->num_interfaces; i++)
>   		usb_autopm_put_interface(chip->intf[i]);
>   }
> +EXPORT_SYMBOL_GPL(snd_usb_autosuspend);
>   
>   static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
>   {
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index a385e85c4650..aac92e0b8aa2 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -1503,6 +1503,7 @@ int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
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
> index 08bf535ed163..999f66080649 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -148,6 +148,16 @@ find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
>   	return found;
>   }
>   
> +const struct audioformat *
> +snd_usb_find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
> +	    unsigned int rate, unsigned int channels, bool strict_match,
> +	    struct snd_usb_substream *subs)
> +{
> +	return find_format(fmt_list_head, format, rate, channels, strict_match,
> +			subs);
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_find_format);
> +
>   static const struct audioformat *
>   find_substream_format(struct snd_usb_substream *subs,
>   		      const struct snd_pcm_hw_params *params)
> @@ -157,6 +167,14 @@ find_substream_format(struct snd_usb_substream *subs,
>   			   true, subs);
>   }
>   
> +const struct audioformat *
> +snd_usb_find_substream_format(struct snd_usb_substream *subs,
> +		      const struct snd_pcm_hw_params *params)
> +{
> +	return find_substream_format(subs, params);
> +}
> +EXPORT_SYMBOL_GPL(snd_usb_find_substream_format);
> +
>   bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
>   {
>   	const struct audioformat *fp;
> @@ -461,20 +479,9 @@ static void close_endpoints(struct snd_usb_audio *chip,
>   	}
>   }
>   
> -/*
> - * hw_params callback
> - *
> - * allocate a buffer and set the given audio format.
> - *
> - * so far we use a physically linear buffer although packetize transfer
> - * doesn't need a continuous area.
> - * if sg buffer is supported on the later version of alsa, we'll follow
> - * that.
> - */
> -static int snd_usb_hw_params(struct snd_pcm_substream *substream,
> -			     struct snd_pcm_hw_params *hw_params)
> +int snd_usb_attach_endpoints(struct snd_usb_substream *subs,
> +				struct snd_pcm_hw_params *hw_params)
>   {
> -	struct snd_usb_substream *subs = substream->runtime->private_data;
>   	struct snd_usb_audio *chip = subs->stream->chip;
>   	const struct audioformat *fmt;
>   	const struct audioformat *sync_fmt;
> @@ -499,7 +506,7 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
>   	if (fmt->implicit_fb) {
>   		sync_fmt = snd_usb_find_implicit_fb_sync_format(chip, fmt,
>   								hw_params,
> -								!substream->stream,
> +								!subs->direction,
>   								&sync_fixed_rate);
>   		if (!sync_fmt) {
>   			usb_audio_dbg(chip,
> @@ -579,15 +586,28 @@ static int snd_usb_hw_params(struct snd_pcm_substream *substream,
>   
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(snd_usb_attach_endpoints);
>   
>   /*
> - * hw_free callback
> + * hw_params callback
>    *
> - * reset the audio format and release the buffer
> + * allocate a buffer and set the given audio format.
> + *
> + * so far we use a physically linear buffer although packetize transfer
> + * doesn't need a continuous area.
> + * if sg buffer is supported on the later version of alsa, we'll follow
> + * that.
>    */
> -static int snd_usb_hw_free(struct snd_pcm_substream *substream)
> +static int snd_usb_hw_params(struct snd_pcm_substream *substream,
> +			     struct snd_pcm_hw_params *hw_params)
>   {
>   	struct snd_usb_substream *subs = substream->runtime->private_data;
> +
> +	return snd_usb_attach_endpoints(subs, hw_params);
> +}
> +
> +int snd_usb_detach_endpoint(struct snd_usb_substream *subs)
> +{
>   	struct snd_usb_audio *chip = subs->stream->chip;
>   
>   	snd_media_stop_pipeline(subs);
> @@ -603,6 +623,19 @@ static int snd_usb_hw_free(struct snd_pcm_substream *substream)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(snd_usb_detach_endpoint);
> +
> +/*
> + * hw_free callback
> + *
> + * reset the audio format and release the buffer
> + */
> +static int snd_usb_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct snd_usb_substream *subs = substream->runtime->private_data;
> +
> +	return snd_usb_detach_endpoint(subs);
> +}
>   
>   /* free-wheeling mode? (e.g. dmix) */
>   static int in_free_wheeling_mode(struct snd_pcm_runtime *runtime)
> diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
> index 388fe2ba346d..e36df3611a05 100644
> --- a/sound/usb/pcm.h
> +++ b/sound/usb/pcm.h
> @@ -15,4 +15,15 @@ void snd_usb_preallocate_buffer(struct snd_usb_substream *subs);
>   int snd_usb_audioformat_set_sync_ep(struct snd_usb_audio *chip,
>   				    struct audioformat *fmt);
>   
> +const struct audioformat *
> +snd_usb_find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
> +	    unsigned int rate, unsigned int channels, bool strict_match,
> +	    struct snd_usb_substream *subs);
> +const struct audioformat *
> +snd_usb_find_substream_format(struct snd_usb_substream *subs,
> +		      const struct snd_pcm_hw_params *params);
> +
> +int snd_usb_attach_endpoints(struct snd_usb_substream *subs,
> +				struct snd_pcm_hw_params *hw_params);
> +int snd_usb_detach_endpoint(struct snd_usb_substream *subs);
>   #endif /* __USBAUDIO_PCM_H */

Why is it multiple "endpoints" when attaching, but only one "endpoint" 
when detaching? Both seem to be getting similar arguments.
