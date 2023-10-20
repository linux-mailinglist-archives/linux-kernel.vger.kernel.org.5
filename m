Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8842F7D0C71
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376745AbjJTJ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376713AbjJTJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:58:17 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE3C2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:58:13 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-581de3e691dso331533eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697795893; x=1698400693; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:subject:from:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K4UW710i+SVdY2veq5p3ftxx/JVFwnSzPwKQM6w6iuU=;
        b=Vg9npKWtGFS4GnT0tu5NnXRP9fFmul/pJKe0+BkhhCbjtfFjrra3buSdB9s+kN3cRJ
         +pBvLWIVCBmwqyq8XfwLBzYPrDi//7GtRdlhN5hhAcu82e7v8nTfUrlRu1N4Y+mLRHXk
         cD3nby3j/nFeXmkvyBVvsHtAuV2SxvCbV6kNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697795893; x=1698400693;
        h=in-reply-to:references:cc:to:subject:from:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4UW710i+SVdY2veq5p3ftxx/JVFwnSzPwKQM6w6iuU=;
        b=tQwDOVbuLpLQHTx/SK2luJ+KggZ1UniukaUR8xpFjPf7lFqJ8JEx/TFe4XJ4LLgZn2
         bm3hBO9NaliWZdEP0gVyfh2zsq2Z6W6Jp9DQrCYou0GfCevupjvHA4l92ujVwRwnKCH4
         OOwIyLbqn0IiGIDKUjB9/EB34kWp59eS22u6Bnrmlx9lm8E7Y4E/bI7HqoS7/Ej4Z4r8
         nxKzJahesUQrt1cMtC41UGu1pqrkvJekCCRF440drOOiUDOPFkfVUOsiJUtHhZwRw8Ai
         uSLZAxi80/uYWg+rg564WjVkrSWH5z9lu05QOtS31DJqnf3drRLqdp4rlWNu7K+QdsVe
         NjjQ==
X-Gm-Message-State: AOJu0YxuOIBVbSmiuxnj69oZNuZaJpeKSlyDRkyksKlarEQBNQZrjC2T
        j9ZD84BSucvRE0FvLFH0QghfVQ==
X-Google-Smtp-Source: AGHT+IGnEFdEt/CCGFGza8FfuK2/dcG8xOrehrVfSNf8XpSVJ+Xgz6+7c/FDa5GcEU0LFiL4cr7LbQ==
X-Received: by 2002:a05:6358:418d:b0:168:ab50:b90b with SMTP id w13-20020a056358418d00b00168ab50b90bmr1471437rwc.17.1697795892884;
        Fri, 20 Oct 2023 02:58:12 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a7-20020aa794a7000000b006be484e5b9bsm1154874pfl.58.2023.10.20.02.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 02:58:11 -0700 (PDT)
Message-ID: <cc58057b-bc08-f717-1676-13046fc26c5c@broadcom.com>
Date:   Fri, 20 Oct 2023 11:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 2/5] [brcmfmac] Add support for 6G bands
To:     Daniel Berlin <dberlin@dberlin.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org
References: <cover.1697650207.git.dberlin@dberlin.org>
 <52c993fd93e13ac015be935a5284294c9a74ea8e.1697650207.git.dberlin@dberlin.org>
In-Reply-To: <52c993fd93e13ac015be935a5284294c9a74ea8e.1697650207.git.dberlin@dberlin.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000206f79060822e9b5"
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000206f79060822e9b5
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/2023 3:42 AM, Daniel Berlin wrote:
> This patch adds support for 6G bands, along with HE capabilities,
> as they are required to register 6G bands with wiphy.
> This in turn, enables 802.11ax support for the other bands.
> 
> Scanning is not updated in this patch, so the bands are unused
> except to be able to process what the firmware tells us.
> 
> Existing code is updated to handle all the bands rather than just 2g and
> 5g channels.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Daniel Berlin <dberlin@dberlin.org>
> ---
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 365 +++++++++++++++---
>   1 file changed, 313 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 667462369a32..7143ffe659f6 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -178,6 +178,22 @@ static struct ieee80211_rate __wl_rates[] = {
>   	.max_power		= 30,				\
>   }
>   
> +#define CHAN6G(_channel) {					\
> +	.band			= NL80211_BAND_6GHZ,		\
> +	.center_freq		= 5950 + (5 * (_channel)),	\

maybe handle channel 2 here as well, ie.:
	.center_freq = ((_channel) == 2) ? 5935 : 5950 + (5 * (_channel)),

> +	.hw_value		= (_channel),			\
> +	.max_antenna_gain	= 0,				\
> +	.max_power		= 30,				\
> +}

so we can drop this one below...

> +#define CHAN6G_CHAN2() {					\
> +	.band			= NL80211_BAND_6GHZ,		\
> +	.center_freq		= 5935,				\
> +	.hw_value		= 2,				\
> +	.max_antenna_gain	= 0,				\
> +	.max_power		= 30,				\
> +}
> +
>   static struct ieee80211_channel __wl_2ghz_channels[] = {
>   	CHAN2G(1, 2412), CHAN2G(2, 2417), CHAN2G(3, 2422), CHAN2G(4, 2427),
>   	CHAN2G(5, 2432), CHAN2G(6, 2437), CHAN2G(7, 2442), CHAN2G(8, 2447),
> @@ -194,6 +210,23 @@ static struct ieee80211_channel __wl_5ghz_channels[] = {
>   	CHAN5G(153), CHAN5G(157), CHAN5G(161), CHAN5G(165)
>   };
> 
> +static struct ieee80211_channel __wl_6ghz_channels[] = {
> +	CHAN6G_CHAN2(), CHAN6G(1),   CHAN6G(5),	  CHAN6G(9),   CHAN6G(13),
> +	CHAN6G(17),	CHAN6G(21),  CHAN6G(25),  CHAN6G(29),  CHAN6G(33),
> +	CHAN6G(37),	CHAN6G(41),  CHAN6G(45),  CHAN6G(49),  CHAN6G(53),
> +	CHAN6G(57),	CHAN6G(61),  CHAN6G(65),  CHAN6G(69),  CHAN6G(73),
> +	CHAN6G(77),	CHAN6G(81),  CHAN6G(85),  CHAN6G(89),  CHAN6G(93),
> +	CHAN6G(97),	CHAN6G(101), CHAN6G(105), CHAN6G(109), CHAN6G(113),
> +	CHAN6G(117),	CHAN6G(121), CHAN6G(125), CHAN6G(129), CHAN6G(133),
> +	CHAN6G(137),	CHAN6G(141), CHAN6G(145), CHAN6G(149), CHAN6G(153),
> +	CHAN6G(157),	CHAN6G(161), CHAN6G(165), CHAN6G(169), CHAN6G(173),
> +	CHAN6G(177),	CHAN6G(181), CHAN6G(185), CHAN6G(189), CHAN6G(193),
> +	CHAN6G(197),	CHAN6G(201), CHAN6G(205), CHAN6G(209), CHAN6G(213),
> +	CHAN6G(217),	CHAN6G(221), CHAN6G(225), CHAN6G(229), CHAN6G(233),
> +};
> +
> +struct ieee80211_sband_iftype_data sdata[NUM_NL80211_BANDS];
> +
>   /* Band templates duplicated per wiphy. The channel info
>    * above is added to the band during setup.
>    */
> @@ -209,6 +242,12 @@ static const struct ieee80211_supported_band __wl_band_5ghz = {
>   	.n_bitrates = wl_a_rates_size,
>   };
>   
> +static const struct ieee80211_supported_band __wl_band_6ghz = {
> +	.band = NL80211_BAND_6GHZ,
> +	.bitrates = wl_a_rates,
> +	.n_bitrates = wl_a_rates_size,
> +};
> +
>   /* This is to override regulatory domains defined in cfg80211 module (reg.c)
>    * By default world regulatory domain defined in reg.c puts the flags
>    * NL80211_RRF_NO_IR for 5GHz channels (for * 36..48 and 149..165).
> @@ -217,20 +256,22 @@ static const struct ieee80211_supported_band __wl_band_5ghz = {
>    * domain are to be done here.
>    */
>   static const struct ieee80211_regdomain brcmf_regdom = {
> -	.n_reg_rules = 4,
> +	.n_reg_rules = 5,
>   	.alpha2 =  "99",
>   	.reg_rules = {
>   		/* IEEE 802.11b/g, channels 1..11 */
> -		REG_RULE(2412-10, 2472+10, 40, 6, 20, 0),
> +		REG_RULE(2412 - 10, 2472 + 10, 40, 6, 20, 0),
>   		/* If any */
>   		/* IEEE 802.11 channel 14 - Only JP enables
>   		 * this and for 802.11b only
>   		 */
> -		REG_RULE(2484-10, 2484+10, 20, 6, 20, 0),
> +		REG_RULE(2484 - 10, 2484 + 10, 20, 6, 20, 0),
>   		/* IEEE 802.11a, channel 36..64 */
> -		REG_RULE(5150-10, 5350+10, 160, 6, 20, 0),
> +		REG_RULE(5150 - 10, 5350 + 10, 160, 6, 20, 0),
>   		/* IEEE 802.11a, channel 100..165 */
> -		REG_RULE(5470-10, 5850+10, 160, 6, 20, 0), }
> +		REG_RULE(5470 - 10, 5850 + 10, 160, 6, 20, 0),
> +		/* IEEE 802.11ax, 6E */
> +		REG_RULE(5935 - 10, 7115 + 10, 160, 6, 20, 0), }
>   };
>   
>   /* Note: brcmf_cipher_suites is an array of int defining which cipher suites
> @@ -316,6 +357,8 @@ static u8 nl80211_band_to_fwil(enum nl80211_band band)
>   		return WLC_BAND_2G;
>   	case NL80211_BAND_5GHZ:
>   		return WLC_BAND_5G;
> +	case NL80211_BAND_6GHZ:
> +		return WLC_BAND_6G;
>   	default:
>   		WARN_ON(1);
>   		break;
> @@ -323,6 +366,23 @@ static u8 nl80211_band_to_fwil(enum nl80211_band band)
>   	return 0;
>   }
>   
> +static __le32 nl80211_band_to_chanspec_band(enum nl80211_band band)
> +{
> +	switch (band) {
> +	case NL80211_BAND_2GHZ:
> +		return BRCMU_CHAN_BAND_2G;
> +	case NL80211_BAND_5GHZ:
> +		return BRCMU_CHAN_BAND_5G;
> +	case NL80211_BAND_6GHZ:
> +		return BRCMU_CHAN_BAND_6G;
> +	case NL80211_BAND_60GHZ:
> +	default:
> +		WARN_ON_ONCE(1);
> +		// Choose a safe default
> +		return BRCMU_CHAN_BAND_2G;
> +	}
> +}
> +
>   static u16 chandef_to_chanspec(struct brcmu_d11inf *d11inf,
>   			       struct cfg80211_chan_def *ch)
>   {
> @@ -382,17 +442,7 @@ static u16 chandef_to_chanspec(struct brcmu_d11inf *d11inf,
>   	default:
>   		WARN_ON_ONCE(1);
>   	}
> -	switch (ch->chan->band) {
> -	case NL80211_BAND_2GHZ:
> -		ch_inf.band = BRCMU_CHAN_BAND_2G;
> -		break;
> -	case NL80211_BAND_5GHZ:
> -		ch_inf.band = BRCMU_CHAN_BAND_5G;
> -		break;
> -	case NL80211_BAND_60GHZ:
> -	default:
> -		WARN_ON_ONCE(1);
> -	}
> +	ch_inf.band = nl80211_band_to_chanspec_band(ch->chan->band);
>   	d11inf->encchspec(&ch_inf);
>   
>   	brcmf_dbg(TRACE, "chanspec: 0x%x\n", ch_inf.chspec);
> @@ -404,6 +454,7 @@ u16 channel_to_chanspec(struct brcmu_d11inf *d11inf,
>   {
>   	struct brcmu_chan ch_inf;
>   
> +	ch_inf.band = nl80211_band_to_chanspec_band(ch->band);
>   	ch_inf.chnum = ieee80211_frequency_to_channel(ch->center_freq);
>   	ch_inf.bw = BRCMU_CHAN_BW_20;
>   	d11inf->encchspec(&ch_inf);
> @@ -3340,6 +3391,7 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
>   	struct cfg80211_bss *bss;
>   	enum nl80211_band band;
>   	struct brcmu_chan ch;
> +	u16 chanspec;
>   	u16 channel;
>   	u32 freq;
>   	u16 notify_capability;
> @@ -3353,20 +3405,41 @@ static s32 brcmf_inform_single_bss(struct brcmf_cfg80211_info *cfg,
>   		return -EINVAL;
>   	}
>   
> +	chanspec = le16_to_cpu(bi->chanspec);
>   	if (!bi->ctl_ch) {
> -		ch.chspec = le16_to_cpu(bi->chanspec);
> +		ch.chspec = chanspec;
>   		cfg->d11inf.decchspec(&ch);
>   		bi->ctl_ch = ch.control_ch_num;
>   	}
>   	channel = bi->ctl_ch;
>   
> -	if (channel <= CH_MAX_2G_CHANNEL)
> -		band = NL80211_BAND_2GHZ;
> -	else
> +	if (CHSPEC_IS6G(chanspec))
> +		band = NL80211_BAND_6GHZ;
> +	else if (CHSPEC_IS5G(chanspec))
>   		band = NL80211_BAND_5GHZ;
> +	else
> +		band = NL80211_BAND_2GHZ;
>   
>   	freq = ieee80211_channel_to_frequency(channel, band);
> +	if (!freq) {
> +		brcmf_err("Invalid frequency %d returned for channel %d, band %d. chanspec was %04x\n",
> +			  freq, channel, band, bi->chanspec);
> +
> +		/* We ignore this BSS ID rather than try to continue on.
> +		 * Otherwise we will cause an OOPs because our frequency is 0.
> +		 * The main case this occurs is some new frequency band
> +		 * we have not seen before, and if we return an error,
> +		 * we will cause the scan to fail.  It seems better to
> +		 * report the error, skip this BSS, and move on.
> +		 */
> +		return 0;
> +	}
>   	bss_data.chan = ieee80211_get_channel(wiphy, freq);

How could this fail? Our wiphy registers all possible channels so if 
ieee80211_channel_to_frequency() succeeds ieee80211_get_channel() can 
not fail.

> +	if (!bss_data.chan) {
> +		brcmf_err("Could not convert frequency into channel for channel %d, band %d, chanspec was %04x\n",
> +			  channel, band, bi->chanspec);
> +		return 0;
> +	}
>   	bss_data.boottime_ns = ktime_to_ns(ktime_get_boottime());
>   
>   	notify_capability = le16_to_cpu(bi->capability);
> @@ -3454,7 +3527,7 @@ static s32 brcmf_inform_ibss(struct brcmf_cfg80211_info *cfg,
>   	buf = kzalloc(WL_BSS_INFO_MAX, GFP_KERNEL);
>   	if (buf == NULL) {
>   		err = -ENOMEM;
> -		goto CleanUp;
> +		goto cleanup;
>   	}
>   
>   	*(__le32 *)buf = cpu_to_le32(WL_BSS_INFO_MAX);
> @@ -3463,7 +3536,7 @@ static s32 brcmf_inform_ibss(struct brcmf_cfg80211_info *cfg,
>   				     buf, WL_BSS_INFO_MAX);
>   	if (err) {
>   		bphy_err(drvr, "WLC_GET_BSS_INFO failed: %d\n", err);
> -		goto CleanUp;
> +		goto cleanup;
>   	}
>   
>   	bi = (struct brcmf_bss_info_le *)(buf + 4);
> @@ -3473,10 +3546,18 @@ static s32 brcmf_inform_ibss(struct brcmf_cfg80211_info *cfg,
>   
>   	if (ch.band == BRCMU_CHAN_BAND_2G)
>   		band = wiphy->bands[NL80211_BAND_2GHZ];
> -	else
> +	else if (ch.band == BRCMU_CHAN_BAND_5G)
>   		band = wiphy->bands[NL80211_BAND_5GHZ];
> +	else
> +		band = wiphy->bands[NL80211_BAND_6GHZ];
>   
>   	freq = ieee80211_channel_to_frequency(ch.control_ch_num, band->band);
> +	if (freq == 0) {
> +		brcmf_err("Invalid frequency %d returned for channel %d, band %d. chanspec was %04x\n",
> +			  freq, ch.control_ch_num, ch.band, bi->chanspec);
> +		goto cleanup;
> +	}
> +
>   	cfg->channel = freq;
>   	notify_channel = ieee80211_get_channel(wiphy, freq);
>   
> @@ -3499,12 +3580,12 @@ static s32 brcmf_inform_ibss(struct brcmf_cfg80211_info *cfg,
>   
>   	if (!bss) {
>   		err = -ENOMEM;
> -		goto CleanUp;
> +		goto cleanup;
>   	}
>   
>   	cfg80211_put_bss(wiphy, bss);
>   
> -CleanUp:
> +cleanup:
>   
>   	kfree(buf);
>   
> @@ -5707,6 +5788,9 @@ static int brcmf_cfg80211_get_channel(struct wiphy *wiphy,
>   	case BRCMU_CHAN_BAND_5G:
>   		band = NL80211_BAND_5GHZ;
>   		break;
> +	case BRCMU_CHAN_BAND_6G:
> +		band = NL80211_BAND_6GHZ;
> +		break;
>   	}
>   
>   	switch (ch.bw) {
> @@ -5728,9 +5812,19 @@ static int brcmf_cfg80211_get_channel(struct wiphy *wiphy,
>   	}
>   
>   	freq = ieee80211_channel_to_frequency(ch.control_ch_num, band);
> +	if (freq == 0) {
> +		brcmf_err("Invalid frequency %d returned for channel %d, band %d. chanspec was %04x\n",
> +			  freq, ch.control_ch_num, ch.band, chanspec);
> +		return -EINVAL;
> +	}
>   	chandef->chan = ieee80211_get_channel(wiphy, freq);
>   	chandef->width = width;
>   	chandef->center_freq1 = ieee80211_channel_to_frequency(ch.chnum, band);
> +	if (chandef->center_freq1 == 0) {
> +		brcmf_err("Invalid frequency %d returned for channel %d, band %d. chanspec was %04x\n",
> +			  freq, ch.chnum, ch.band, chanspec);
> +		return -EINVAL;
> +	}
>   	chandef->center_freq2 = 0;
>   
>   	return 0;
> @@ -6386,10 +6480,17 @@ brcmf_bss_roaming_done(struct brcmf_cfg80211_info *cfg,
>   
>   	if (ch.band == BRCMU_CHAN_BAND_2G)
>   		band = wiphy->bands[NL80211_BAND_2GHZ];
> -	else
> +	else if (ch.band == BRCMU_CHAN_BAND_5G)
>   		band = wiphy->bands[NL80211_BAND_5GHZ];
> +	else
> +		band = wiphy->bands[NL80211_BAND_6GHZ];
>   
>   	freq = ieee80211_channel_to_frequency(ch.control_ch_num, band->band);
> +	if (freq == 0) {
> +		brcmf_err("Invalid frequency %d returned for channel %d, band %d. chanspec was %04x\n",
> +			  freq, ch.control_ch_num, ch.band, bi->chanspec);
> +		goto done;
> +	}
>   	notify_channel = ieee80211_get_channel(wiphy, freq);
>   
>   done:
> @@ -6965,6 +7066,10 @@ static int brcmf_construct_chaninfo(struct brcmf_cfg80211_info *cfg,
>   		for (i = 0; i < band->n_channels; i++)
>   			band->channels[i].flags = IEEE80211_CHAN_DISABLED;
>   	band = wiphy->bands[NL80211_BAND_5GHZ];
> +	if (band)

Eh. Why is this conditional? We are creating all bands in the wiphy 
instance so why the null check here?

> +		for (i = 0; i < band->n_channels; i++)
> +			band->channels[i].flags = IEEE80211_CHAN_DISABLED;
> +	band = wiphy->bands[NL80211_BAND_6GHZ];
>   	if (band)
>   		for (i = 0; i < band->n_channels; i++)
>   			band->channels[i].flags = IEEE80211_CHAN_DISABLED;
> @@ -6985,6 +7090,8 @@ static int brcmf_construct_chaninfo(struct brcmf_cfg80211_info *cfg,
>   			band = wiphy->bands[NL80211_BAND_2GHZ];
>   		} else if (ch.band == BRCMU_CHAN_BAND_5G) {
>   			band = wiphy->bands[NL80211_BAND_5GHZ];
> +		} else if (ch.band == BRCMU_CHAN_BAND_6G) {
> +			band = wiphy->bands[NL80211_BAND_6GHZ];
>   		} else {
>   			bphy_err(drvr, "Invalid channel Spec. 0x%x.\n",
>   				 ch.chspec);
> @@ -7150,7 +7257,7 @@ static int brcmf_enable_bw40_2g(struct brcmf_cfg80211_info *cfg)
>   	return err;
>   }
>   
> -static void brcmf_get_bwcap(struct brcmf_if *ifp, u32 bw_cap[])
> +static void brcmf_get_bwcap(struct brcmf_if *ifp, u32 bw_cap[], bool has_6g)
>   {
>   	struct brcmf_pub *drvr = ifp->drvr;
>   	u32 band, mimo_bwcap;
> @@ -7158,17 +7265,29 @@ static void brcmf_get_bwcap(struct brcmf_if *ifp, u32 bw_cap[])
>   
>   	band = WLC_BAND_2G;
>   	err = brcmf_fil_iovar_int_get(ifp, "bw_cap", &band);
> -	if (!err) {
> -		bw_cap[NL80211_BAND_2GHZ] = band;
> -		band = WLC_BAND_5G;
> -		err = brcmf_fil_iovar_int_get(ifp, "bw_cap", &band);
> -		if (!err) {
> -			bw_cap[NL80211_BAND_5GHZ] = band;
> -			return;
> -		}
> -		WARN_ON(1);
> +	if (err)
> +		goto fallback;
> +	bw_cap[NL80211_BAND_2GHZ] = band;
> +	band = WLC_BAND_5G;
> +	err |= brcmf_fil_iovar_int_get(ifp, "bw_cap", &band);
> +	if (err)
> +		goto fallback;
> +	bw_cap[NL80211_BAND_5GHZ] = band;
> +	if (!has_6g)
>   		return;
> -	}
> +	band = WLC_BAND_6G;
> +	err |= brcmf_fil_iovar_int_get(ifp, "bw_cap", &band);
> +	/* Prior to the introduction of 6g, this function only
> +	 * did fallback in the case of 2g and 5g -failing.
> +	 * As mimo_bwcap does not have 6g bwcap info anyway,
> +	 * we keep that behavior.
> +	 */
> +	if (err)
> +		return;
> +	bw_cap[NL80211_BAND_6GHZ] = band;
> +	return;
> +fallback:
> +
>   	brcmf_dbg(INFO, "fallback to mimo_bw_cap info\n");
>   	mimo_bwcap = 0;
>   	err = brcmf_fil_iovar_int_get(ifp, "mimo_bw_cap", &mimo_bwcap);
> @@ -7195,6 +7314,9 @@ static void brcmf_get_bwcap(struct brcmf_if *ifp, u32 bw_cap[])
>   static void brcmf_update_ht_cap(struct ieee80211_supported_band *band,
>   				u32 bw_cap[2], u32 nchain)
>   {
> +	/* Not supported in 6G band */
> +	if (band->band == NL80211_BAND_6GHZ)
> +		return;
>   	band->ht_cap.ht_supported = true;
>   	if (bw_cap[band->band] & WLC_BW_40MHZ_BIT) {
>   		band->ht_cap.cap |= IEEE80211_HT_CAP_SGI_40;
> @@ -7225,8 +7347,8 @@ static void brcmf_update_vht_cap(struct ieee80211_supported_band *band,
>   {
>   	__le16 mcs_map;
>   
> -	/* not allowed in 2.4G band */
> -	if (band->band == NL80211_BAND_2GHZ)
> +	/* not allowed in 2.4G or 6G band */
> +	if (band->band == NL80211_BAND_2GHZ || band->band == NL80211_BAND_6GHZ)
>   		return;
>   
>   	band->vht_cap.vht_supported = true;
> @@ -7261,6 +7383,116 @@ static void brcmf_update_vht_cap(struct ieee80211_supported_band *band,
>   	}
>   }
>   
> +static void brcmf_update_he_cap(struct ieee80211_supported_band *band,
> +				struct ieee80211_sband_iftype_data *data)
> +{
> +	int idx = 1;
> +	struct ieee80211_sta_he_cap *he_cap = &data->he_cap;
> +	struct ieee80211_he_cap_elem *he_cap_elem = &he_cap->he_cap_elem;
> +	struct ieee80211_he_mcs_nss_supp *he_mcs = &he_cap->he_mcs_nss_supp;
> +	struct ieee80211_he_6ghz_capa *he_6ghz_capa = &data->he_6ghz_capa;
> +
> +	if (!data) {

There is no allocation in sight here *and* data is already dereferenced 
above to obtain the he_cap. data points to static global array so it is 
never NULL.

> +		brcmf_err("failed to allocate sdata\n");
> +		return;
> +	}
> +
> +	data->types_mask = BIT(NL80211_IFTYPE_STATION) | BIT(NL80211_IFTYPE_AP);

It is unlikely STA and AP ever have the same capabilities.

> +	he_cap->has_he = true;

has_he should be set according feature flag. The firmware capability 
should have '11ax' in it.

Below stuff is all hardcoded. That is fine to enable its use for now, 
but may not be fully true. At least for BCA I know that there is a 
firmware command for it. Expect WCC chips do not have that. If it can 
differ per device we can not use static global array. Maybe better to 
take that into account off the bat:

1) define hard-coded global sdata array
2) only pass band as parameter
3) duplicate sdata entry and setup iftype data
4) add iftype data reference to band

> +	/* HE MAC Capabilities Information */
> +	he_cap_elem->mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE |
> +				       IEEE80211_HE_MAC_CAP0_TWT_REQ |
> +				       IEEE80211_HE_MAC_CAP0_TWT_RES;
> +
> +	he_cap_elem->mac_cap_info[1] =
> +		IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_8US |
> +		IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_16US;
> +
> +	he_cap_elem->mac_cap_info[2] = IEEE80211_HE_MAC_CAP2_BSR |
> +				       IEEE80211_HE_MAC_CAP2_BCAST_TWT;
> +
> +	he_cap_elem->mac_cap_info[3] =
> +		IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
> +		IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_1 |
> +		IEEE80211_HE_MAC_CAP3_FLEX_TWT_SCHED;
> +
> +	he_cap_elem->mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU;
> +
> +	/* HE PHY Capabilities Information */
> +	he_cap_elem->phy_cap_info[0] =
> +		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G |
> +		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
> +		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
> +	;
> +
> +	he_cap_elem->phy_cap_info[1] =
> +		IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
> +
> +	he_cap_elem->phy_cap_info[2] =
> +		IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
> +		IEEE80211_HE_PHY_CAP2_UL_MU_FULL_MU_MIMO |
> +		IEEE80211_HE_PHY_CAP2_UL_MU_PARTIAL_MU_MIMO;
> +
> +	he_cap_elem->phy_cap_info[3] =
> +		IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_TX_QPSK |
> +		IEEE80211_HE_PHY_CAP3_DCM_MAX_TX_NSS_2 |
> +		IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_16_QAM |
> +		IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
> +
> +	he_cap_elem->phy_cap_info[4] =
> +		IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE |
> +		IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_8;
> +
> +	he_cap_elem->phy_cap_info[5] =
> +		IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK |
> +		IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK |
> +		IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_2;
> +
> +	he_cap_elem->phy_cap_info[6] =
> +		IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU |
> +		IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
> +		IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
> +		IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB |
> +		IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB |
> +		IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE |
> +		IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT;
> +
> +	he_cap_elem->phy_cap_info[7] =
> +		IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI |
> +		IEEE80211_HE_PHY_CAP7_MAX_NC_1;
> +
> +	he_cap_elem->phy_cap_info[8] =
> +		IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI |
> +		IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
> +		IEEE80211_HE_PHY_CAP8_20MHZ_IN_160MHZ_HE_PPDU |
> +		IEEE80211_HE_PHY_CAP8_80MHZ_IN_160MHZ_HE_PPDU;
> +
> +	he_cap_elem->phy_cap_info[9] =
> +		IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU |
> +		IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU |
> +		IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
> +		IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB;
> +
> +	/* HE Supported MCS and NSS Set */
> +	he_mcs->rx_mcs_80 = cpu_to_le16(0xfffa);
> +	he_mcs->tx_mcs_80 = cpu_to_le16(0xfffa);
> +	/* HE 6 GHz band capabilities */
> +	if (band->band == NL80211_BAND_6GHZ) {
> +		u16 capa = 0;
> +
> +		capa = FIELD_PREP(IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START,
> +				  IEEE80211_HT_MPDU_DENSITY_8) |
> +		       FIELD_PREP(IEEE80211_HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP,
> +				  IEEE80211_VHT_MAX_AMPDU_1024K) |
> +		       FIELD_PREP(IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LEN,
> +				  IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454);
> +		he_6ghz_capa->capa = cpu_to_le16(capa);
> +	}
> +	band->n_iftype_data = idx;
> +	band->iftype_data = data;
> +}
> +
>   static int brcmf_setup_wiphybands(struct brcmf_cfg80211_info *cfg)
>   {
>   	struct brcmf_pub *drvr = cfg->pub;
> @@ -7268,7 +7500,8 @@ static int brcmf_setup_wiphybands(struct brcmf_cfg80211_info *cfg)
>   	struct wiphy *wiphy = cfg_to_wiphy(cfg);
>   	u32 nmode = 0;
>   	u32 vhtmode = 0;
> -	u32 bw_cap[2] = { WLC_BW_20MHZ_BIT, WLC_BW_20MHZ_BIT };
> +	/* 2GHZ, 5GHZ, 60GHZ, 6GHZ */
> +	u32 bw_cap[4] = { WLC_BW_20MHZ_BIT, WLC_BW_20MHZ_BIT, 0, 0 };

Too bad we reserve space for 60G which we probably never will support.

>   	u32 rxchain;
>   	u32 nchain;
>   	int err;
> @@ -7277,17 +7510,21 @@ static int brcmf_setup_wiphybands(struct brcmf_cfg80211_info *cfg)
>   	u32 txstreams = 0;
>   	u32 txbf_bfe_cap = 0;
>   	u32 txbf_bfr_cap = 0;
> +	u32 he_cap[2] = {0, 0};
>   
>   	(void)brcmf_fil_iovar_int_get(ifp, "vhtmode", &vhtmode);
> +	(void)brcmf_fil_iovar_data_get(ifp, "he", &he_cap, sizeof(he_cap));
>   	err = brcmf_fil_iovar_int_get(ifp, "nmode", &nmode);
>   	if (err) {
>   		bphy_err(drvr, "nmode error (%d)\n", err);
>   	} else {
> -		brcmf_get_bwcap(ifp, bw_cap);
> +		brcmf_get_bwcap(ifp, bw_cap, he_cap[0] != 0);
>   	}
> -	brcmf_dbg(INFO, "nmode=%d, vhtmode=%d, bw_cap=(%d, %d)\n",
> +	brcmf_dbg(INFO,
> +		  "nmode=%d, vhtmode=%d, bw_cap=(%d, %d, %d), he_cap=(%d, %d)\n",
>   		  nmode, vhtmode, bw_cap[NL80211_BAND_2GHZ],
> -		  bw_cap[NL80211_BAND_5GHZ]);
> +		  bw_cap[NL80211_BAND_5GHZ], bw_cap[NL80211_BAND_6GHZ],
> +		  he_cap[0], he_cap[1]);

So are these he mac and phy capabilities? ...

>   
>   	err = brcmf_fil_iovar_int_get(ifp, "rxchain", &rxchain);
>   	if (err) {
> @@ -7328,6 +7565,8 @@ static int brcmf_setup_wiphybands(struct brcmf_cfg80211_info *cfg)
>   		if (vhtmode)
>   			brcmf_update_vht_cap(band, bw_cap, nchain, txstreams,
>   					     txbf_bfe_cap, txbf_bfr_cap);
> +		if (he_cap[0])
> +			brcmf_update_he_cap(band, &sdata[band->band]);

... if so should they be passed here?

>   	}
>   
>   	return 0;
> @@ -7698,12 +7937,27 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, struct brcmf_if *ifp)
>   			band->n_channels = ARRAY_SIZE(__wl_5ghz_channels);
>   			wiphy->bands[NL80211_BAND_5GHZ] = band;
>   		}
> -	}
> +		if (bandlist[i] == cpu_to_le32(WLC_BAND_6G)) {

Ok. So wiphy band can be NULL.

> +			band = kmemdup(&__wl_band_6ghz, sizeof(__wl_band_6ghz),
> +				       GFP_KERNEL);
> +			if (!band)
> +				return -ENOMEM;
> +
> +			band->channels = kmemdup(&__wl_6ghz_channels,
> +						 sizeof(__wl_6ghz_channels),
> +						 GFP_KERNEL);
> +			if (!band->channels) {
> +				kfree(band);
> +				return -ENOMEM;
> +			}
>   
> +			band->n_channels = ARRAY_SIZE(__wl_6ghz_channels);
> +			wiphy->bands[NL80211_BAND_6GHZ] = band;
> +		}
> +	}
>   	if (wiphy->bands[NL80211_BAND_5GHZ] &&
>   	    brcmf_feat_is_enabled(ifp, BRCMF_FEAT_DOT11H))
> -		wiphy_ext_feature_set(wiphy,
> -				      NL80211_EXT_FEATURE_DFS_OFFLOAD);
> +		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_DFS_OFFLOAD);
>   
>   	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>   
> @@ -8240,6 +8494,10 @@ static void brcmf_free_wiphy(struct wiphy *wiphy)
>   		kfree(wiphy->bands[NL80211_BAND_5GHZ]->channels);
>   		kfree(wiphy->bands[NL80211_BAND_5GHZ]);
>   	}
> +	if (wiphy->bands[NL80211_BAND_6GHZ]) {
> +		kfree(wiphy->bands[NL80211_BAND_6GHZ]->channels);
> +		kfree(wiphy->bands[NL80211_BAND_6GHZ]);
> +	}
>   #if IS_ENABLED(CONFIG_PM)
>   	if (wiphy->wowlan != &brcmf_wowlan_support)
>   		kfree(wiphy->wowlan);
> @@ -8331,18 +8589,21 @@ struct brcmf_cfg80211_info *brcmf_cfg80211_attach(struct brcmf_pub *drvr,
>   	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_DUMP_OBSS))
>   		ops->dump_survey = brcmf_cfg80211_dump_survey;
>   
> -	err = wiphy_register(wiphy);
> -	if (err < 0) {
> -		bphy_err(drvr, "Could not register wiphy device (%d)\n", err);
> -		goto priv_out;
> -	}
> -
> +	/* We have to configure the bands before we register the wiphy device
> +	 * because it requires that band capabilities be correct.
> +	 */

Is it? The order was deliberate. brcmf_setup_wiphybands() calls 
brcmf_construct_chaninfo() which disables all channels. When you do that 
before wiphy_register() the orig_flags of the channel will be DISABLED 
and can never be used.

>   	err = brcmf_setup_wiphybands(cfg);
>   	if (err) {
>   		bphy_err(drvr, "Setting wiphy bands failed (%d)\n", err);
>   		goto wiphy_unreg_out;
>   	}
>   
> +	err = wiphy_register(wiphy);
> +	if (err < 0) {
> +		bphy_err(drvr, "Could not register wiphy device (%d)\n", err);
> +		goto priv_out;
> +	}
> +
>   	/* If cfg80211 didn't disable 40MHz HT CAP in wiphy_register(),
>   	 * setup 40MHz in 2GHz band and enable OBSS scanning.
>   	 */


--000000000000206f79060822e9b5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDEdwhGnNcYga7Hq6Nv
1860vj6W+yIsLjxkwS2Hp8ovNDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzEwMjAwOTU4MTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA6jwmhK95h6y8E5zaK7JjtORxbQ3m8l5o6sG4
A4g7pjADRo+AUzhPElmicBkDcGM7OmAm7OA+REF5/B75iuoEqu/hp1pq50iOe3+H8nmJj2pCVyGL
nwMWzhLTEZxYJEfc75zpMDJnoM3srrOCLQdCd5FqYjhW0N2BvQFzktT6mdHfCwHB4FEiia32yC07
FmBHqYBaaF3tPryhSU2ZR1aTyA1t2abN/vzrBWHQRxTc1Y97MUfh1Fe0N38mu3bW7vddurOj0GMv
HAxSZ6CB7000CjvFTEI0omtAbLWep/I/c7VQocEKNlj9r8JbtYYDJx/VOQrVNmaIf0ECfVoigsvw
Jw==
--000000000000206f79060822e9b5--
