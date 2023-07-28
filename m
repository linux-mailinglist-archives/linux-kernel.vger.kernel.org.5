Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D7C7673C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjG1Rq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjG1Rq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:46:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71153A8B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:46:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so4017970e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690566412; x=1691171212;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUOsuK9U4cZ6JZwfdNB+TmQHxYWxH/A53SQYnwAxe3c=;
        b=nqfDkCoab4utHUbd/anH85Av0oTWL2HcyEIByGM13NbdM6gIR1d/rsHZ7hXlD2i8L8
         GNxc8SY+uedXv64TvxFBY/QZGUk+Hm6z3fNfghbSZDci/jfvsWED7TecYKzYLi17iGxf
         8JkCkyXYHx24sBhTA+DdqgYntE/uQw+y+LL48KBNdGofivN5jggSqsjLLVL13Xo+6oxs
         IHhxe+7dow63bxvyqgkmYa5MjU0P3Lk+KCu/APhW2T1D6JcrC+mGDzMP5ovEm4+sWLid
         LwyYf2GTkPOKO6zT0hyqAAvLGkCp/dFbM0zB3gUJqruMAWw8xWYRtfDnJnubB9RlP16u
         +L1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566412; x=1691171212;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUOsuK9U4cZ6JZwfdNB+TmQHxYWxH/A53SQYnwAxe3c=;
        b=Hm1+7zBi8ZiQURWz9uSvBt01+ojbkrWyvVTIFc42HYlSnCN2A6lYf+pWfxXujaHCXK
         rDxrw4h/yhAIsiOuJMmE8F6QoF7f/8DDAJPpdVupBjK/7NfSRyM9VXK/fmZfZZ42YCHc
         5Hsvl1VSr2MQ69lroLjo3E9Dl8SHni/jul4ULoA/AC2L735KzabeTPfUAfQFFA1iEw/F
         uvBeiFvye5eo11Ac/xct0KyCqNX48pGNiHLJH/PkU263IF1qn8RuEqzgxAVIgPSLgte+
         HkVEnx5snpBaQ3SNXNR12x4Pdop6DcRs3uMV6Z4ljQOe2MRAu/BeXJl/g2RbuJiIpoEl
         VHPQ==
X-Gm-Message-State: ABy/qLZdKn6Ab1PD/0K61KRLhzv9M3fZAB7vin+V9TPQozVr/or8bYxp
        YWNSMYNtMNTVqOqj/PpzPPZGxA==
X-Google-Smtp-Source: APBJJlGnVjSw7A9DS3Za+2hl0ftYT1UQ5cn4KqOuMH5176hNY6DIv7UEGrIyoIsMuCy2H67BAkFgwQ==
X-Received: by 2002:a05:6512:3c8c:b0:4fb:7da3:de4 with SMTP id h12-20020a0565123c8c00b004fb7da30de4mr2561530lfv.13.1690566412057;
        Fri, 28 Jul 2023 10:46:52 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651204c900b004f85628ec34sm897120lfq.33.2023.07.28.10.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:46:51 -0700 (PDT)
Message-ID: <a8ebcacd-19c7-b5e7-f372-6abde311e17d@linaro.org>
Date:   Fri, 28 Jul 2023 19:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/33] iris: vidc: add helper functions for power
 management
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-14-git-send-email-quic_vgarodia@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1690550624-14642-14-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.2023 15:23, Vikash Garodia wrote:
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> this implements functions for calculating current load of the
> hardware. Depending on the count of instances and
> resolutions it selects the best clock rate for the video
> core. Also it scales clocks, power and enable/disable dcvs.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---[...]

> +
> +/* TODO: Move to dtsi OR use source clock instead of branch clock.*/
> +#define MSM_VIDC_CLOCK_SOURCE_SCALING_RATIO 3
Seems unused in this patch.

> +
> +enum vidc_bus_type {
> +	PERF,
> +	DDR,
> +	LLCC,
> +};
> +
> +/*
> + * Minimum dimensions for which to calculate bandwidth.
> + * This means that anything bandwidth(0, 0) ==
> + * bandwidth(BASELINE_DIMENSIONS.width, BASELINE_DIMENSIONS.height)
> + */
> +static const struct {
> +	int height, width;
> +} BASELINE_DIMENSIONS = {
> +	.width = 1280,
> +	.height = 720,
> +};
> +
> +/* converts Mbps to bps (the "b" part can be bits or bytes based on context) */
if 'b', the multiplier must be 1024 or it makes no sense

> +#define kbps(__mbps) ((__mbps) * 1000)
> +#define bps(__mbps) (kbps(__mbps) * 1000)
> +
[...]

> +void __dump(struct dump dump[], int len)
> +{
> +	int c = 0;
> +
> +	for (c = 0; c < len; ++c) {
> +		char format_line[128] = "", formatted_line[128] = "";
That's a lot of bytes on the stack..

> +
> +		if (dump[c].val == DUMP_HEADER_MAGIC) {
> +			snprintf(formatted_line, sizeof(formatted_line), "%s\n",
> +				 dump[c].key);
> +		} else {
> +			snprintf(format_line, sizeof(format_line),
> +				 "    %-35s: %s\n", dump[c].key,
> +					 dump[c].format);
> +			snprintf(formatted_line, sizeof(formatted_line),
> +				 format_line, dump[c].val);
> +		}
> +		d_vpr_b("%s", formatted_line);
> +	}
> +}
> +
> +u64 msm_vidc_max_freq(struct msm_vidc_inst *inst)
> +{
> +	struct msm_vidc_core *core;
> +	struct frequency_table *freq_tbl;
> +	u64 freq = 0;
> +
> +	core = inst->core;
> +
> +	if (!core->resource || !core->resource->freq_set.freq_tbl ||
> +	    !core->resource->freq_set.count) {
> +		i_vpr_e(inst, "%s: invalid frequency table\n", __func__);
> +		return freq;
> +	}
> +	freq_tbl = core->resource->freq_set.freq_tbl;
Do we need a separate freuqency table if we have OPP?
[...]


> +	if (inst->power.fw_cf) {
> +		cf = inst->power.fw_cf;
> +		frame_size = (msm_vidc_get_mbs_per_frame(inst) / (32 * 8) * 3) / 2;
too magic!

Konrad
