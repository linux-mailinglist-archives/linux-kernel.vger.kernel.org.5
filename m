Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8625976B680
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjHAN6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjHAN6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:58:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC07DC;
        Tue,  1 Aug 2023 06:58:38 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so9275245e87.0;
        Tue, 01 Aug 2023 06:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690898317; x=1691503117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9LCAsr2bIL8kLMgkEwkdI+MgOLqKLakMLSAWcTBAIPs=;
        b=VwPraxCeRIr2mAW9uLS3E1/rWkUsOFaKUUwtl5DRFP4MAwgK6s8t3MTB+pSty7hiU0
         vAbe3m1AJM5QMtYLXqCLXQtDM9GKEKyysMuWgczAMYNGC6kNV7bucErLjdVFC4TSUM3p
         P9fgJGHDX8mAw16H57HZcG1xNLdIMVZBMBDoU7NBBtSLC8V6RJYR5G2xDvjQJq4ljzAL
         kACOqBSZewUf3PNLkJtg//OAJKCuvTXRSjsPLj6vPsqsJNzhbpDizI9uwnYcTzbFp/o3
         Ga5RHWYQabbaAgpChUI9ZoT52HMfbp9guSuW0o0v7GfpGa+pY8vlrmWeWfbC/kIDH2Lc
         3AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898317; x=1691503117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LCAsr2bIL8kLMgkEwkdI+MgOLqKLakMLSAWcTBAIPs=;
        b=H6WGqHj8FabhYS/hjNtYOlMiXVkfFfLzClmx6lKqd91G+bCscCyZtKSDxA2baoYNO+
         tUH3oKi0g36h1i3FMDy919hmy8zYrkIjis4Kt1bi78JJdUkkZCQzNOEoLj930TPJ08pV
         27hjRZ7hYciKYAXMocGv5o1CfgwaqbaHF2qYKu+1gPP2UZeQL5+b4cPMQihp4bPwCxjZ
         k+J/wLBvme+2ncvTu1ysJ7IfZXsSFWK8vBMve/28c5yU5ZJU1HBqSNT8KYNVPgNolFR6
         ocdEx6RhKu001cF+ui0DX+NvxOUnFs2548qCsx882EYKmDHym0AaQ8xW/PrRGd4ifs3r
         cctw==
X-Gm-Message-State: ABy/qLYZ8t9p+9NVPpOHNkSj4kQ08yCgS0Ev0AuKmnzZF/CNV8RsFAjI
        ZdvsyDrydGNdcxu/jwvW82a+17GO+UBTsOHPxI0=
X-Google-Smtp-Source: APBJJlEoNwnh+Ebgn0hDAnQlavgKTJxX9UrRWcPCk34A/XO9GiTaGag7RkbaBBxz7XtW7k0d504mj057GMahDehAfac=
X-Received: by 2002:a19:6514:0:b0:4fb:845d:9e8f with SMTP id
 z20-20020a196514000000b004fb845d9e8fmr1871744lfb.53.1690898316655; Tue, 01
 Aug 2023 06:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com> <1690265540-25999-2-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1690265540-25999-2-git-send-email-shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 1 Aug 2023 16:58:24 +0300
Message-ID: <CAEnQRZCzUkpE-ppSDqBzhTXZHphr+twSju=snSiMii9gR=v0nA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] ASoC: fsl_asrc: define functions for memory to
 memory usage
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int fsl_asrc_m2m_check_format(u8 dir, u32 rate, u32 channels, u32 format)
> +{
> +       u64 support_format = FSL_ASRC_FORMATS;
> +
> +       if (channels < 1 || channels > 10)
> +               return -EINVAL;
> +
> +       if (rate < 5512 || rate > 192000)
> +               return -EINVAL;
> +

I think we can avoid using magic numbers. Instead we could do:

#define FSL_ASRC_MIN_CHANNELS 1
/...
#define FSL_ASRC_MAX_RATE 192000


> +       if (dir == IN)
> +               support_format |= SNDRV_PCM_FMTBIT_S8;
> +
> +       if (!(1 << format & support_format))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +/* calculate capture data length according to output data length and sample rate */
> +static int fsl_asrc_m2m_calc_out_len(struct fsl_asrc_pair *pair, int input_buffer_length)
> +{
> +       unsigned int in_width, out_width;
> +       unsigned int channels = pair->channels;
> +       unsigned int in_samples, out_samples;
> +       unsigned int out_length;
> +
> +       in_width = snd_pcm_format_physical_width(pair->sample_format[IN]) / 8;
> +       out_width = snd_pcm_format_physical_width(pair->sample_format[OUT]) / 8;
> +
> +       in_samples = input_buffer_length / in_width / channels;
> +       out_samples = pair->rate[OUT] * in_samples / pair->rate[IN];
> +       out_length = (out_samples - ASRC_OUTPUT_LAST_SAMPLE) * out_width * channels;
> +
> +       return out_length;
> +}
> +
> +static int fsl_asrc_m2m_get_maxburst(u8 dir, struct fsl_asrc_pair *pair)
> +{
> +       struct fsl_asrc *asrc = pair->asrc;
> +       struct fsl_asrc_priv *asrc_priv = asrc->private;
> +       int wml = (dir == IN) ? ASRC_M2M_INPUTFIFO_WML : ASRC_M2M_OUTPUTFIFO_WML;
> +
> +       if (!asrc_priv->soc->use_edma)
> +               return wml * pair->channels;
> +       else
> +               return 1;
> +}
> +
> +static int fsl_asrc_m2m_pair_resume(struct fsl_asrc_pair *pair)
> +{
> +       struct fsl_asrc *asrc = pair->asrc;
> +       int i;
> +
> +       for (i = 0; i < pair->channels * 4; i++)
> +               regmap_write(asrc->regmap, REG_ASRDI(pair->index), 0);
> +
> +       return 0;
> +}
> +
>  static int fsl_asrc_runtime_resume(struct device *dev);
>  static int fsl_asrc_runtime_suspend(struct device *dev);

<snip>

There is no implementation for _suspend although you mention it
in the commit message.

> + * @complete: dma task complete
> + * @sample_format: format of m2m
> + * @rate: rate of m2m
> + * @buf_len: buffer length of m2m
> + * @req_pair: flag for request pair


For example @complete field is not used in this patch. Maybe add it in the patch
that uses it?

I think is the same for other fields.
