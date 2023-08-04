Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3357576FC22
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjHDIkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHDIkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:40:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1432A30F3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:40:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3177163aa97so1591814f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691138404; x=1691743204;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wdx3f+50DISgPPdeHaF0Mb88wToJy9z92MXQTy2q84c=;
        b=hB9V8I0glM0cDRfG7+8UN4Ubaid2OSD46rTP9V16nGgVB4fsisVPZ7KCVDB/EZLW+V
         yKJ4rv++74jOrxUO0L7w3SYVbQ609CWQe28Dcut/Jv7yChXGuFlX7TQs+3hjeJQN69Xm
         D55fS1N4pa8iYPY0KZur9KoPD2yIdHlFrvvnegD1QiI+clS3aUcwLuO9wFsn5QNrbewp
         OxXUflTWArgs7DRGM8HYBUqY4xyBBkT+l5yH44jNChIY+CbuhFQX4j8iOiuI1xVh4kSY
         UrhJWBYK1KW277SOUKRcnJbk07f70ohDxoGQdkd8EOTpQbyCajLjZZTshgxEeZwZ5KKQ
         DkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138404; x=1691743204;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdx3f+50DISgPPdeHaF0Mb88wToJy9z92MXQTy2q84c=;
        b=blviNgGArFu8tidyYK4kboFrTBAE8qlEY7C6u6JpjjtT5GyvAFcf1M/jrQuLmHWQ8R
         OmN9zyqOWe5Sb80sQTJQiEGQ+V+Xn3Lo1x580Ge8RzJAcySvcTLuRdfsYbpvV/qnJGWt
         3aYi93F0kSU2J3Tmzmn4uNM5gN2YuKuOqGq2rRiyJVGEX615B1UI/C1VqFGaTdzgGxsi
         FaH7NcxxATBiA47GBiawxmEXfZloCDfvA1Dao0UW+KEBDZj3sw6LgZkTA8RnRfUvtWlT
         KGUphpoAVA6M6QvetWMsYNKv6MgKPyEbeRjoOQfxm1y/cCg9eA0JU5IjoW713sQ9IQsZ
         3JLg==
X-Gm-Message-State: AOJu0YysDYX0AJLMP+oJ97e9uOydZK7hJiEqSnYi8yLaKnpzh32lisqT
        hYgueiNbCSUB1gVHZOJT42nVpw==
X-Google-Smtp-Source: AGHT+IHZJjfZzR14MYOvYq7wNubxQq7a16qY4NsGBsLLUeTuQhj3Q57WLx2xslUl8/d9+Zez0BZtPA==
X-Received: by 2002:adf:dfcf:0:b0:313:f429:f6e9 with SMTP id q15-20020adfdfcf000000b00313f429f6e9mr824781wrn.60.1691138404492;
        Fri, 04 Aug 2023 01:40:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b526:9083:f5a6:4af1? ([2a01:e0a:982:cbb0:b526:9083:f5a6:4af1])
        by smtp.gmail.com with ESMTPSA id w17-20020adff9d1000000b00301a351a8d6sm1930082wrr.84.2023.08.04.01.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 01:40:04 -0700 (PDT)
Message-ID: <b2407b1d-23fb-3284-c4bb-b3a952d361dd@linaro.org>
Date:   Fri, 4 Aug 2023 10:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] drm/panel: sitronix-st7789v: add panel orientation
 support
Content-Language: en-US
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230718-feature-st7789v-v2-0-207cb1baea0f@wolfvision.net>
 <20230718-feature-st7789v-v2-2-207cb1baea0f@wolfvision.net>
Organization: Linaro Developer Services
In-Reply-To: <20230718-feature-st7789v-v2-2-207cb1baea0f@wolfvision.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/08/2023 22:13, Michael Riesch wrote:
> Determine the orientation of the display based on the device tree and
> propagate it.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> index c7cbfe6ca82c..6575f07d49e3 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -116,6 +116,7 @@ struct st7789v {
>   	struct spi_device *spi;
>   	struct gpio_desc *reset;
>   	struct regulator *power;
> +	enum drm_panel_orientation orientation;
>   };
>   
>   enum st7789v_prefix {
> @@ -170,6 +171,7 @@ static const struct drm_display_mode default_mode = {
>   static int st7789v_get_modes(struct drm_panel *panel,
>   			     struct drm_connector *connector)
>   {
> +	struct st7789v *ctx = panel_to_st7789v(panel);
>   	struct drm_display_mode *mode;
>   
>   	mode = drm_mode_duplicate(connector->dev, &default_mode);
> @@ -188,9 +190,22 @@ static int st7789v_get_modes(struct drm_panel *panel,
>   	connector->display_info.width_mm = 61;
>   	connector->display_info.height_mm = 103;
>   
> +	/*
> +	 * TODO: Remove once all drm drivers call
> +	 * drm_connector_set_orientation_from_panel()
> +	 */
> +	drm_connector_set_panel_orientation(connector, ctx->orientation);
> +
>   	return 1;
>   }
>   
> +static enum drm_panel_orientation st7789v_get_orientation(struct drm_panel *p)
> +{
> +	struct st7789v *ctx = panel_to_st7789v(p);
> +
> +	return ctx->orientation;
> +}
> +
>   static int st7789v_prepare(struct drm_panel *panel)
>   {
>   	struct st7789v *ctx = panel_to_st7789v(panel);
> @@ -349,6 +364,7 @@ static const struct drm_panel_funcs st7789v_drm_funcs = {
>   	.disable = st7789v_disable,
>   	.enable	= st7789v_enable,
>   	.get_modes = st7789v_get_modes,
> +	.get_orientation = st7789v_get_orientation,
>   	.prepare = st7789v_prepare,
>   	.unprepare = st7789v_unprepare,
>   };
> @@ -382,6 +398,8 @@ static int st7789v_probe(struct spi_device *spi)
>   	if (ret)
>   		return ret;
>   
> +	of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
> +
>   	drm_panel_add(&ctx->panel);
>   
>   	return 0;
> 

This patch doesn't apply clean on drm-misc-next, could you rebase and resend ?

Thanks,
Neil
