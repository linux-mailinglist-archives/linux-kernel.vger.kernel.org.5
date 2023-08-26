Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188617895D6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjHZKOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjHZKNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:13:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752EF1FCB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:13:50 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500913779f5so2640718e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693044829; x=1693649629;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/q3VpPaIaGZ/5dVJno5sHgen3eMV3oIH2SkR9gJCQ4=;
        b=PSJX5lSLwLq1Kfcfgh0eAhoXich0GScF7Hk+F921GO7FAN0B/05gbY5dRADD1uihRL
         nj2iyRlDZ9KJ7wlcBC5zNokMHQy5d8tn05uNkW65oZfc9FNarKaT/Ndx1oEa8CqUYQjR
         XmYqlPr+GG58oFU7CgkN6AmUzy6D+gUIXWj7TTcfKBDFPtmSdp70rpXbEi4snbhGl27C
         HcB5TciMX8iBxsnG76V/s2bVkUcqH2YiB/mjjU79qOpq3ScABF/ZHcY4j7fuCmNHh4PO
         cyywuzXBSZKuZ4PU9CSkzKnYV6rGpNIOZ5natqmOfFVsZqTaC6Rytg3B7Y6vpNzp44Jz
         pX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693044829; x=1693649629;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/q3VpPaIaGZ/5dVJno5sHgen3eMV3oIH2SkR9gJCQ4=;
        b=PjHXU2Jffu5kgZTcp6EDRd2/NuKWSLuAXumKaC7wFvnafMUNPH03qkiLwSCgAweoLS
         wufPTRB2pzIcyoKzFp8CJMtaSt+T8a9eSh+iqMxyHTGlmz/oMILs/fAs8wGoMsuzZXqc
         y0QsFH/bY+0vk1ySVAcj9RS9ey4sAKPS+7eMBOThtpd/K6T5VRIZ3l1/AVuzcztV0d2u
         W4Nfroh9+9H1RjbYk++Gy+bp4y/CDOneGHBteZvlBJLWQz+DRWHnEy07zK5HvjCSt/aW
         fwRBUvBbnix/oOAqJO8YrXmS1iMtRhnwPB0sSFNyTpxIvGqGJ/RJ/10T51+cJOV4TNiu
         ujDg==
X-Gm-Message-State: AOJu0YzMiJzq5TNG2FkQhCCutsYxdI+UZO47/ZetfRiMMvwf9Y0XHasz
        hUJAzJw7pUE/PZwcxZ/9gy9GUw==
X-Google-Smtp-Source: AGHT+IGq0h3yY+vcHzc2ndCT191RRQ+hhRMyzA37xr5h+i84hUPVVg+5a1/0Tk6MaLdZU52SXin3SQ==
X-Received: by 2002:a05:6512:1186:b0:4f8:752f:3722 with SMTP id g6-20020a056512118600b004f8752f3722mr13770862lfr.5.1693044828699;
        Sat, 26 Aug 2023 03:13:48 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id q26-20020ac24a7a000000b004fe1efe3e38sm647999lfp.225.2023.08.26.03.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 03:13:48 -0700 (PDT)
Message-ID: <6f381a9e-9aac-4a3a-814e-26a230026d66@linaro.org>
Date:   Sat, 26 Aug 2023 12:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/15] media: qcom: camss: Fix support for setting
 CSIPHY clock name csiphyX
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-13-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230823104444.1954663-13-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.2023 12:44, Bryan O'Donoghue wrote:
> Several of our upstream and soon-to-be upstream SoC CAMSS dtsi declare
> csiphyX as opposed to the older clock name csiX_phy.
This only reinforces my point about adding like csiphy_clks or so

Konrad
> 
> Right now the CAMSS code will fail to set the csiphyX clock even if we have
> declared it in our list of clocks. For sdm845 and sm8250 we appear to "get
> away" with this error, however on sc8280xp we don't.
> 
> The right approach here is to set the clock when it is declared. If a SoC
> doesn't require or a SoC driver implementer doesn't think we need, then the
> clock ought to simply be omitted from the clock list.
> 
> Include csiphyX in the set of permissible strings which will subsequently
> lead to the csiphyX clock being set during csiphy_set_clock_rates() phase.
> 
> sdm845 and sm8250 will work with the code as-is so I've omitted this from a
> suggested Fixes list.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss-csiphy.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> index baf78c525fbfc..d9c751f457703 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -687,6 +687,10 @@ int msm_csiphy_subdev_init(struct camss *camss,
>  				if (csiphy->rate_set[i])
>  					break;
>  			}
> +
> +			csiphy->rate_set[i] = csiphy_match_clock_name(clock->name, "csiphy%d", k);
> +			if (csiphy->rate_set[i])
> +				break;
>  		}
>  	}
>  
