Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9157895D4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjHZKNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjHZKNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:13:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7D5E5C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:13:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500aed06ffcso1028313e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693044779; x=1693649579;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGdO71SK0ws8M3rPYY2CMJ6SkObtmRohY+viWQWMypg=;
        b=S5ZwB0WIGK0pa7DF7oNXL6DdOBxCgyTTsZVhKHWQPSQ9JowqZOJktuvbVsSSyXU1kz
         na1eBl2ICivx9HpUsYkE2NEzqF3lSjZuIrc1YSmQ1vd6IYZeiuNReJ3+JAAu9gbOpjyV
         MVt9uGkCKeD06QphiNdDpLdphO4CtW5MO0dbG6VkH+MfkQc+Tk6Aflp3Nbuj+URYtxDk
         SARs/oQ+8g6Ech7bKn+P/GYOiIUdlLsOkNRoYLEt4Efd9qtRh5Y9Fb6BP/yTHdlibWz9
         mLwk57lM40m6wdMz35dp8OvJTBcDAcSVw9XapMiXxyYS5pK4o++Do19YBw/uAhpAIrTX
         VIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693044779; x=1693649579;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGdO71SK0ws8M3rPYY2CMJ6SkObtmRohY+viWQWMypg=;
        b=lcYGtXIQfxeErUQ5mnV2My/zw2WphIgv+vVVEm40qgn8opCk+c+3znrNgaQ9p0zAnN
         xGP5Ow886m1cYSnJkqs8Gr+SIYGPxXDKNJ+jSP48v/1JL3DwIWzjOAJfl7afyVrP/ASy
         ff155nnb8Eod7ByQHZzmlyMeQFoNQuJfnxTnAfw6VfnuffTxJegWGe+krkVX75dYmxoj
         Gur2LuC9+878iip/sDwdN5nBzSJYXanPglkNp/igeaKJ0L9rgFi1yX4bkaXGhLX4DTLM
         IuppY/XjvjuIwbt//omAX9a22wssYubfcgcBDeTxZqHG36eySMQ0e9WNvx5wr8+Sgh1E
         YqKw==
X-Gm-Message-State: AOJu0Yxvn/cLGnapou+rhgTNxukGUYiyqEEP6/PQ9pt9kFykcfsS5LWF
        LyZ/w/Ls1TMnTsFvdW3inbYGvA==
X-Google-Smtp-Source: AGHT+IHostp7t2FrAV4lZdTN6oe8HAi4wIERNghQq8TZMSeiVdRSH78Y+/9PFwbWIouKcizTvDXjgw==
X-Received: by 2002:a05:6512:1296:b0:4fe:993:2218 with SMTP id u22-20020a056512129600b004fe09932218mr18091367lfs.31.1693044779546;
        Sat, 26 Aug 2023 03:12:59 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id q26-20020ac24a7a000000b004fe1efe3e38sm647999lfp.225.2023.08.26.03.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 03:12:59 -0700 (PDT)
Message-ID: <d8e54e0a-b176-49eb-9d8d-66324cdcd2e8@linaro.org>
Date:   Sat, 26 Aug 2023 12:12:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] media: qcom: camss: Functionally decompose
 CSIPHY clock lookups
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-12-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230823104444.1954663-12-bryan.odonoghue@linaro.org>
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
> The csiphyX_timer and csiX_phy values need not be hard-coded. We can
> functionally decompose the string matching inside of a loop.
> 
> Static string values are brittle, difficult to extend and not required
> anyway since the camss->res->csiphy_num value informs us of the number
> of CSIPHYs and hence the set of potential clocks for a given CSIPHY.
> 
> In simple terms if we have five CSIPHYs we can have no more and no less
> than five csiphy_timer clocks. Similarly csi_phy core clocks have a 1:1
> relationship with the PHY they clock.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../media/platform/qcom/camss/camss-csiphy.c  | 37 ++++++++++++-------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> index 0e8c2a59ea241..baf78c525fbfc 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -536,6 +536,15 @@ static int csiphy_init_formats(struct v4l2_subdev *sd,
>  	return csiphy_set_format(sd, fh ? fh->state : NULL, &format);
>  }
>  
> +static bool csiphy_match_clock_name(const char *clock_name, const char *format,
> +				    int index)
> +{
> +	char name[CAMSS_RES_MAX];
similar comment to the previous patch about the buf size

> +
> +	snprintf(name, sizeof(name), format, index);
> +	return !strcmp(clock_name, name);
> +}
> +
>  /*
>   * msm_csiphy_subdev_init - Initialize CSIPHY device structure and resources
>   * @csiphy: CSIPHY device
> @@ -550,7 +559,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
>  {
>  	struct device *dev = camss->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	int i, j;
> +	int i, j, k;
>  	int ret;
>  
>  	csiphy->camss = camss;
> @@ -666,19 +675,19 @@ int msm_csiphy_subdev_init(struct camss *camss,
>  		for (j = 0; j < clock->nfreqs; j++)
>  			clock->freq[j] = res->clock_rate[i][j];
>  
> -		if (!strcmp(clock->name, "csiphy0_timer") ||
> -		    !strcmp(clock->name, "csiphy1_timer") ||
> -		    !strcmp(clock->name, "csiphy2_timer") ||
> -		    !strcmp(clock->name, "csiphy3_timer") ||
> -		    !strcmp(clock->name, "csiphy4_timer") ||
> -		    !strcmp(clock->name, "csiphy5_timer"))
> -			csiphy->rate_set[i] = true;
> -
> -		if (camss->res->version == CAMSS_660 &&
> -		    (!strcmp(clock->name, "csi0_phy") ||
> -		     !strcmp(clock->name, "csi1_phy") ||
> -		     !strcmp(clock->name, "csi2_phy")))
> -			csiphy->rate_set[i] = true;
> +		for (k = 0; k < camss->res->csiphy_num; k++) {
> +			csiphy->rate_set[i] = csiphy_match_clock_name(clock->name,
> +								      "csiphy%d_timer", k);
This entire functions is like.. soooo over-engineered

adding something like csiphy_timer_clks and cisphy_clks and stuff
would make this string comparison mess unnecessary

> +			if (csiphy->rate_set[i])
> +				break;
> +
> +			if (camss->res->version == CAMSS_660) {
> +				csiphy->rate_set[i] = csiphy_match_clock_name(clock->name,
> +									      "csi%d_phy", k);
hm, only ratesetting on 660 sounds very sus

Konrad
