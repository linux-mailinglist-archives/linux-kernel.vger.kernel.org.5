Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3876CE93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjHBN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjHBN1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:27:05 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F365626BB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:27:03 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-447c22f326aso29436137.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690982823; x=1691587623;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nGo7XjMqAnc/FigJw/B09DaMvgiAsBs40lE/RPajQrY=;
        b=gxZ5TnagDxPCgnQg+/iOxATNhMRfpviCFHa6YSFsTGbG1z/s27ITjrT0BqEvR7wmXa
         8dz76e1cuR5fLqXX242THiYEKa1O4gOapSiXfUCRiuQaagg9G+7yCT0MVln+bCZHgIta
         ck0BPXwNofMHTWuJ9W6UxfiM+EBR4kPDq1zHRwz4NDFTGn+Z38ULQwsCO2xEciFdpcLE
         OdQad7Oq339rgg+Cgq6y3Yjvl1lWyb2eNp1q9/kITCbnjgqo20F52HYlEzXw5ewIE43d
         0e9oOmyemdqW9NUeLyZcY93IldtYfDpknRZDjWwDbfParOu9q8/7S0Sp7dJpyDXxyzAC
         Xn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690982823; x=1691587623;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGo7XjMqAnc/FigJw/B09DaMvgiAsBs40lE/RPajQrY=;
        b=b6B7H9X+OGqV7nRrJRcCYOQRf+B1fiJF0unc7743CUOlTgaGi/C7tfTehxnhKam8uP
         +k2SVm6xxgfHB4PKJpOSw8uvQY9f1xONLb107i+GOo9qafCPntoRdEjRPJ0NBNNxCmT6
         CSFlwm28cFyjI7xeYMSylBHYinhk+wk0EUfbuB9FN8qOePlUo4Glx7nUSdHoY1ruCVra
         FwF8Io+ElB1DQb7B74sWJ4oq02+hoiCpHRL+N3Pz5X4Q9Q8rVstqXZskSFkUm1svYgiR
         7lgh+fpqMCS0iGe6eNwXaFjN5zE2bgupOYgLNQRJXy69xPrZh3Y93pY1FwlBc3u1AYBg
         jT+g==
X-Gm-Message-State: ABy/qLZ7qbVwTKCrSQjjnjPmQXEEqVJXSGJxh//X/SoCNTN4e8Qke5K6
        P13cZRdUWqV34F23flM5Skiyzg==
X-Google-Smtp-Source: APBJJlH7sH25Ud2skh1LZpJSBKwf+gvqVrqLmjM7fxhP1Df2P5pL28xWBTiaPUqongYoSQIFMM8z4Q==
X-Received: by 2002:a67:ec11:0:b0:443:672c:2d8 with SMTP id d17-20020a67ec11000000b00443672c02d8mr4958678vso.22.1690982823059;
        Wed, 02 Aug 2023 06:27:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5bb:5b4:61e3:d196? ([2a01:e0a:982:cbb0:c5bb:5b4:61e3:d196])
        by smtp.gmail.com with ESMTPSA id e20-20020a67e194000000b00443551587c3sm2248653vsl.7.2023.08.02.06.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 06:27:02 -0700 (PDT)
Message-ID: <b63c9227-3627-5c7d-4521-c8bcca22a41c@linaro.org>
Date:   Wed, 2 Aug 2023 15:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] drm/panel: sitronix-st7789v: add panel orientation
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
References: <20230718-feature-st7789v-v1-0-76d6ca9b31d8@wolfvision.net>
 <20230718-feature-st7789v-v1-1-76d6ca9b31d8@wolfvision.net>
 <1e538813-69d4-b3bc-47f9-1ea69d65ef00@linaro.org>
 <f7cb2a51-fce1-659d-9c29-3b21b5ba85b9@wolfvision.net>
Organization: Linaro Developer Services
In-Reply-To: <f7cb2a51-fce1-659d-9c29-3b21b5ba85b9@wolfvision.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 15:19, Michael Riesch wrote:
> Hi Neil,
> 
> On 8/2/23 14:39, Neil Armstrong wrote:
>> On 18/07/2023 17:12, Michael Riesch wrote:
>>> Determine the orientation of the display based on the device tree and
>>> propagate it.
>>>
>>> While at it, fix the indentation in the struct drm_panel_funcs.
>>>
>>> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
>>> ---
>>>    drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 28
>>> +++++++++++++++++++++-----
>>>    1 file changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
>>> b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
>>> index bbc4569cbcdc..6575f07d49e3 100644
>>> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
>>> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
>>> @@ -116,6 +116,7 @@ struct st7789v {
>>>        struct spi_device *spi;
>>>        struct gpio_desc *reset;
>>>        struct regulator *power;
>>> +    enum drm_panel_orientation orientation;
>>>    };
>>>      enum st7789v_prefix {
>>> @@ -170,6 +171,7 @@ static const struct drm_display_mode default_mode = {
>>>    static int st7789v_get_modes(struct drm_panel *panel,
>>>                     struct drm_connector *connector)
>>>    {
>>> +    struct st7789v *ctx = panel_to_st7789v(panel);
>>>        struct drm_display_mode *mode;
>>>          mode = drm_mode_duplicate(connector->dev, &default_mode);
>>> @@ -188,9 +190,22 @@ static int st7789v_get_modes(struct drm_panel
>>> *panel,
>>>        connector->display_info.width_mm = 61;
>>>        connector->display_info.height_mm = 103;
>>>    +    /*
>>> +     * TODO: Remove once all drm drivers call
>>> +     * drm_connector_set_orientation_from_panel()
>>> +     */
>>> +    drm_connector_set_panel_orientation(connector, ctx->orientation);
>>> +
>>>        return 1;
>>>    }
>>>    +static enum drm_panel_orientation st7789v_get_orientation(struct
>>> drm_panel *p)
>>> +{
>>> +    struct st7789v *ctx = panel_to_st7789v(p);
>>> +
>>> +    return ctx->orientation;
>>> +}
>>> +
>>>    static int st7789v_prepare(struct drm_panel *panel)
>>>    {
>>>        struct st7789v *ctx = panel_to_st7789v(panel);
>>> @@ -346,11 +361,12 @@ static int st7789v_unprepare(struct drm_panel
>>> *panel)
>>>    }
>>>      static const struct drm_panel_funcs st7789v_drm_funcs = {
>>> -    .disable    = st7789v_disable,
>>> -    .enable        = st7789v_enable,
>>> -    .get_modes    = st7789v_get_modes,
>>> -    .prepare    = st7789v_prepare,
>>> -    .unprepare    = st7789v_unprepare,
>>> +    .disable = st7789v_disable,
>>> +    .enable    = st7789v_enable,
>>> +    .get_modes = st7789v_get_modes,
>>> +    .get_orientation = st7789v_get_orientation,
>>> +    .prepare = st7789v_prepare,
>>> +    .unprepare = st7789v_unprepare,
>>
>> Changing the indentation of the whole block is a spurious change,
>> either change it in a separate patch or use the current indentation
>> style...
> 
> OK, if we agree that the indentation should be changed I'll be happy to
> move the change to an extra patch.

Sure,

Neil

> 
>>>    };
>>>      static int st7789v_probe(struct spi_device *spi)
>>> @@ -382,6 +398,8 @@ static int st7789v_probe(struct spi_device *spi)
>>>        if (ret)
>>>            return ret;
>>>    +    of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
>>> +
>>>        drm_panel_add(&ctx->panel);
>>>          return 0;
>>>
>>
>> With this changed:
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Thanks!
> 
> Best regards,
> Michael
> 
>>
>> Thanks,
>> Neil
>>

