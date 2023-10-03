Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE2D7B68CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjJCMQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240045AbjJCMQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:16:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1AA10D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 05:16:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b29186e20aso142621966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1696335366; x=1696940166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgQLMDGVZkVLZyj0dhlagnpnLCjs6qYaB5ALz7FOawU=;
        b=Lao2rFwUiLF5qNcSoDcaZBiSlKlI2b8Be7z/2Jf1i28anlGcEyMH6GZ3dWeD/MyrCk
         jhXrDygS25lMrrll2kBCYoZ/YPrwqFF+DXnlkymrlfyLXie8fJt2093kogXceA0/VMqX
         r0WAmDC/FiqkXHm6FSYPvFmryxK/J5pDdcctE9EuXII009t17hoiDknvMURWK0BCvUJx
         tHwZtvFv/Zymn65FxVY16S7UcVHIxmlqONuz56ZDKBUz4zPIZTY24TfJduoFeIhLt3a5
         xqy7CiB/OtmP0DYBE2ITWp1TlP5CqXVffjQCOUta+7wh0RJ71b7tUvIxhSXjsnXOyYMD
         M7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696335366; x=1696940166;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgQLMDGVZkVLZyj0dhlagnpnLCjs6qYaB5ALz7FOawU=;
        b=ETbbD7dYRpByjxWEgtdtpgAL+uoflzcwmcwJigTgPLcuS6vR5GxPBAvl0Wu8V5MmW1
         hCKAbGdtBjyPW+UGVDH9MkARaSpD74OyZkSxJMwo68gmh7t5wjU05/yY4bIhak/+ySAy
         LUlvvNcrJqLS4jSoKgeZse5SCsoEtZ+sXm3b/2z8s1AdUf/VQPaeN0k3WbnApYurgTo9
         OSyQ5It8Ve0MPRctDaUyE1DmgxC0p6WpQBMcVG+636YzZ1GfIY5zmDkHDUUOV5YkIJLV
         bZYa7nAXAKPrG3mLueLLzaMvTwZSJyqaZiL5PR2FpG2VVW8llEe1FjtZ30ed7sfsqq0D
         Mo4Q==
X-Gm-Message-State: AOJu0YxJ304QD8wPpPaSvlkgLQmuk2EgqMv4hLxktsopIOCn3g4fX5AA
        VklT3eqnkyUT2VmYazqBcvB0tQ==
X-Google-Smtp-Source: AGHT+IHY/KXXJnIN+qr0to0K8GhwBTYpHdTHSo6ZMZ2vOl5MFUOijQbV0HK09Y+i/G934VucUALVgA==
X-Received: by 2002:a17:906:197:b0:99e:f3b:2f78 with SMTP id 23-20020a170906019700b0099e0f3b2f78mr12320288ejb.67.1696335366246;
        Tue, 03 Oct 2023 05:16:06 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.190])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090614c900b009a1a5a7ebacsm951533ejc.201.2023.10.03.05.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 05:16:05 -0700 (PDT)
Message-ID: <31bce134-7e9a-0293-5d5a-fba657daed07@tuxon.dev>
Date:   Tue, 3 Oct 2023 15:16:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 1/7] drm: atmel-hlcdc: add flag and driver ops to
 differentiate XLCDC and HLCDC IP
Content-Language: en-US
To:     Manikandan.M@microchip.com, sam@ravnborg.org,
        bbrezillon@kernel.org, airlied@gmail.com, daniel@ffwll.ch,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        lee@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
References: <20230927094732.490228-1-manikandan.m@microchip.com>
 <20230927094732.490228-2-manikandan.m@microchip.com>
 <35d861b5-eca0-c817-684c-e39a841f17db@tuxon.dev>
 <8b721bd5-187c-6aad-39ee-e9a5ded6cee5@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <8b721bd5-187c-6aad-39ee-e9a5ded6cee5@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.10.2023 07:18, Manikandan.M@microchip.com wrote:
> On 28/09/23 11:31 am, claudiu beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi, Manikandan,
>>
>> On 27.09.2023 12:47, Manikandan Muralidharan wrote:
>>> +void atmel_hlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
>>> +                                 struct atmel_hlcdc_plane_state *state);
>>> +void atmel_xlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
>>> +                                 struct atmel_hlcdc_plane_state *state);
>>> +void update_hlcdc_buffers(struct atmel_hlcdc_plane *plane,
>>> +                       struct atmel_hlcdc_plane_state *state,
>>> +                       u32 sr, int i);
>>> +void update_xlcdc_buffers(struct atmel_hlcdc_plane *plane,
>>> +                       struct atmel_hlcdc_plane_state *state,
>>> +                       u32 sr, int i);
>>> +void hlcdc_atomic_disable(struct atmel_hlcdc_plane *plane);
>>> +void xlcdc_atomic_disable(struct atmel_hlcdc_plane *plane);
>>> +void
>>> +atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
>>> +                                       struct atmel_hlcdc_plane_state *state);
>>> +void
>>> +atmel_xlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
>>> +                                       struct atmel_hlcdc_plane_state *state);
>>> +void hlcdc_atomic_update(struct atmel_hlcdc_plane *plane,
>>> +                      struct atmel_hlcdc_dc *dc);
>>> +void xlcdc_atomic_update(struct atmel_hlcdc_plane *plane,
>>> +                      struct atmel_hlcdc_dc *dc);
>>> +void hlcdc_csc_init(struct atmel_hlcdc_plane *plane,
>>> +                 const struct atmel_hlcdc_layer_desc *desc);
>>> +void xlcdc_csc_init(struct atmel_hlcdc_plane *plane,
>>> +                 const struct atmel_hlcdc_layer_desc *desc);
>>> +void hlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
>>> +                const struct atmel_hlcdc_layer_desc *desc);
>>> +void xlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
>>> +                const struct atmel_hlcdc_layer_desc *desc);
>>> +
>>
>> These are still here... Isn't the solution I proposed to you in the
>> previous version good enough?
> Hi Claudiu
> 
> These changes were integrated in the current patch set based on the 
> solution which you proposed in the previous series.
> The XLCDC and HLCDC functions calls are moved to IP specific driver->ops
> and their function declarations are made here in atmel_hlcdc_dc.h
> Rest of the changes are integrated in Patch 4/7.

I still think (and I've checked it last time) you can remove these
declaration. See comment from previous version:

"You can get rid of these and keep the function definitions static to
atmel_hlcdc_plane.c if you define struct atmel_lcdc_dc_ops objects directly
to atmel_hlcdc_plane.c. In atmel_hlcdc_dc.c you can have something like:

extern const struct atmel_lcdc_dc_ops  atmel_hlcdc_ops;
extern const struct atmel_lcdc_dc_ops  atmel_xlcdc_ops;
"

>>
>> Thank you,
>> Claudiu Beznea
> 
