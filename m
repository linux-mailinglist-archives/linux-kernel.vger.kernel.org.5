Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1388E7A6AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjISSZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjISSZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:25:52 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F1BC;
        Tue, 19 Sep 2023 11:25:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b974031aeaso98782121fa.0;
        Tue, 19 Sep 2023 11:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695147945; x=1695752745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohVVUXRSTVuwmwAI3dwryx4B5iagEHAMRt/He7o75f4=;
        b=jp0GFkljx52gWiKUgBj/a11EURcrOvQSgg3Ix4W0DnsxRQNJpPDjRwN9R3LhpdH8CN
         elAcK6HIqwwXxU/1tY2ZWSDUQAUrNbnf8fsXmdX1V/2bj25ccJZnq6zcCjguUQu1onHH
         eHjtaDO+Ze23sBSv64Dt0oO/n7o7FhjtnYO3CILIUP/iorXBpPrvhKNHFzFdg+isczXE
         UKo+Roo7otsQ7MCPD63OtqIBiqHA5s0Od+BA6JoEFDa8rBygmnd9RPj9UM/87lBn3Xop
         gEYuxo2d0nObkSfUGoDN6Lds/DJ/u/sqf+uh6OXAapl+ICx08H8jfow94k4Gk+fprvEU
         r9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695147945; x=1695752745;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohVVUXRSTVuwmwAI3dwryx4B5iagEHAMRt/He7o75f4=;
        b=RL/7jsHIoG1xQIgYFOrGAG4nZTtvwflxi9L5x+g8VuIZlaR5BZlH70NCxcNjt8+1pH
         2xmtKRsIyqxQsV1Brr+JG2Za8+q9SHB8gWWn4zNfAnB7e+YGnXHyk78O+aJ5WOXpyiyO
         y3KOJGVui2HK20u2B5URkNE0xoI7btXiXplDJaPrAK+8ahWT3kkWyHJZ8Ryx58jU9y0e
         z1WQ2MYz+YP9jWf20KBvpX+/WZhiaXeiorRhaWyN6S0vOmRqMFRGnxd4R8F03FtAjTLd
         kXDASnYi00ZcGFUE8GkR7vjo0GfaYVWU8CROROwaDo74MUSGzci8LvPKuEFUdzWJb8fn
         /UcA==
X-Gm-Message-State: AOJu0Yy5Qo9puFD+T5RD5lbnBLRlKD7IAZOl9wj6RBTWa/kIg2LpWX04
        j8aBEGLlxk4TikOOmQHF7saYRU/dTbXujXaZ
X-Google-Smtp-Source: AGHT+IHS2kHXLsSi9+Qc6kPfDaaUR2ud2Y+VIWJcZzSIwgpvpy69kUc/3cPfs//vca3zpn1ZEjnE9A==
X-Received: by 2002:a05:6512:3da7:b0:502:fd1a:9fa0 with SMTP id k39-20020a0565123da700b00502fd1a9fa0mr515169lfv.53.1695147944529;
        Tue, 19 Sep 2023 11:25:44 -0700 (PDT)
Received: from [10.0.0.42] (host-85-29-92-32.kaisa-laajakaista.fi. [85.29.92.32])
        by smtp.gmail.com with ESMTPSA id m30-20020a056512015e00b004fbad09317csm2370415lfo.189.2023.09.19.11.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 11:25:44 -0700 (PDT)
Message-ID: <7d58d52d-2087-45af-b29e-2515b63ead13@gmail.com>
Date:   Tue, 19 Sep 2023 21:25:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ASoC: ti: omap-mcbsp: Ignore errors for getting
 fck_src
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20230705190324.355282-1-andreas@kemnade.info>
 <20230705190324.355282-2-andreas@kemnade.info>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20230705190324.355282-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/23 22:03, Andreas Kemnade wrote:
> Commit 349355ce3a05 ("ARM: OMAP2+: Drop legacy platform data for omap4 mcbsp")
> dropped prcm_fck for omap4,

it also dropped the pad_fck for that matter.

> so the clk_src might not be >available making the
> clk_get(src) fail.

Wow, so OMAP4 audio is pretty broken if would ever need to select FCLK?
By default we don't on OMAP4, but this is astonishing.

> In such cases, rely on the devicetree to assign
> the correct parent.

You cannot rely on DT to dynamically select the FCLK parent for
different use cases.
The dai_set_dai_sysclk() cannot select between internal or external
source of the reference clock and DT cannot handle this.
If one sampling frequency is available with pad_fck while other is only
possible with internal clock then this is no longer possible.

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  sound/soc/ti/omap-mcbsp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
> index 21fa7b9787997..f9fe96b61852b 100644
> --- a/sound/soc/ti/omap-mcbsp.c
> +++ b/sound/soc/ti/omap-mcbsp.c
> @@ -70,8 +70,8 @@ static int omap2_mcbsp_set_clks_src(struct omap_mcbsp *mcbsp, u8 fck_src_id)
>  
>  	fck_src = clk_get(mcbsp->dev, src);
>  	if (IS_ERR(fck_src)) {
> -		dev_err(mcbsp->dev, "CLKS: could not clk_get() %s\n", src);
> -		return -EINVAL;
> +		dev_info(mcbsp->dev, "CLKS: could not clk_get() %s\n", src);
> +		return 0;

I would rather have some clock alias for OMAP4/5 to provide the clocks
that we need for the fclk.
If we did not got the clock we needed to select we cannot say that all
is good, carry on.
Normally the machine driver does this and it thinks that we switched
clocks while we did not and the clocking is all wrong now.

>  	}
>  
>  	pm_runtime_put_sync(mcbsp->dev);

-- 
Péter
