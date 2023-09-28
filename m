Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D673A7B1244
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjI1GBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1GBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:01:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F999
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:01:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so29882412a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 23:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695880907; x=1696485707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/un9SCO8NQAaFwwS/v5Hgk7wmnwT4tzJzG9xCDorHU4=;
        b=b1OPzff8n8AGO3PBCOcMOxF7bUMqvNP0Kewoi2wg0LeFv17aTzdgGpKSYb0Qwmg8ok
         H+P1rF/jp4XOhM2fQEQPnPS1Mq442N3Zb7prKcfce8pnbrWVbUCW3AzhJCBPxkBgPahI
         cc7ClMSgn2Cm0afBZpDFNfEzELKSxExOoTIpp9oDngfWQf1pxzQ/9bMAy0lFJ1G5uyxH
         De/8UjI2AIgRyv0bRzSU5UPD6g+juUUUw0WH71nx69MuXpXwlMkA+krpjJyqqYiT00eS
         iTTw+Ra6TD2EYEGrc0CYXYv/XiLzZs9ShHhNAe38ae5bwL6JmobOkYM4dPv+1imv5Lr0
         EWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695880907; x=1696485707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/un9SCO8NQAaFwwS/v5Hgk7wmnwT4tzJzG9xCDorHU4=;
        b=XLjjy9BE1v4smf5KT2I+kD+g30RwNZLzdbX7l5ynSw57rl/CybnWoYpJZ0ptIE6ogf
         AquDWM4ADfxM3WuX6q9CnXOQmB4UwFZJs521ZLHIuMaO/1tzbTR2EJnS3xG7vIFi/a1M
         wQcxkC8Ql19Qid4g6Liijp7V3CtmT7itPKAPDTyQQvBpmLhcXlR0ztH2+16rsDvCRk1b
         eOnSoy3jiuoedz+OQMXvv+HWuZb8EiehNmJoVMaEDtxSJX2i9rrBTZPUtI3BfzbkkfxI
         PciW7P/NOh5t6nO2Aon+ExhptNtSiXGxLN33/7eHi/1SkvPcnv6BUhIReKI/OvkjBPs1
         MYMA==
X-Gm-Message-State: AOJu0Yz0vGE+g9MwFz1hPx5Qo5hW6aPoDkdTW4H73Z5dSINPR/qefApC
        CgNop0CZ3ivO+oKgXoVSDZ4hZg==
X-Google-Smtp-Source: AGHT+IHXb9MrwailC9Z16pLKAsLb2LIAcdlIDi/yek1TmJBbg8D2/I0CLSC9kn/rBKIYcrF5oG47zQ==
X-Received: by 2002:a05:6402:26c2:b0:533:5d3d:7efe with SMTP id x2-20020a05640226c200b005335d3d7efemr300757edd.6.1695880907095;
        Wed, 27 Sep 2023 23:01:47 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id n26-20020a056402061a00b005313c60165asm9195535edv.77.2023.09.27.23.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 23:01:46 -0700 (PDT)
Message-ID: <35d861b5-eca0-c817-684c-e39a841f17db@tuxon.dev>
Date:   Thu, 28 Sep 2023 09:01:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 1/7] drm: atmel-hlcdc: add flag and driver ops to
 differentiate XLCDC and HLCDC IP
Content-Language: en-US
To:     Manikandan Muralidharan <manikandan.m@microchip.com>,
        sam@ravnborg.org, bbrezillon@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, lee@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
References: <20230927094732.490228-1-manikandan.m@microchip.com>
 <20230927094732.490228-2-manikandan.m@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230927094732.490228-2-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Manikandan,

On 27.09.2023 12:47, Manikandan Muralidharan wrote:
> +void atmel_hlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
> +				    struct atmel_hlcdc_plane_state *state);
> +void atmel_xlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
> +				    struct atmel_hlcdc_plane_state *state);
> +void update_hlcdc_buffers(struct atmel_hlcdc_plane *plane,
> +			  struct atmel_hlcdc_plane_state *state,
> +			  u32 sr, int i);
> +void update_xlcdc_buffers(struct atmel_hlcdc_plane *plane,
> +			  struct atmel_hlcdc_plane_state *state,
> +			  u32 sr, int i);
> +void hlcdc_atomic_disable(struct atmel_hlcdc_plane *plane);
> +void xlcdc_atomic_disable(struct atmel_hlcdc_plane *plane);
> +void
> +atmel_hlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
> +					  struct atmel_hlcdc_plane_state *state);
> +void
> +atmel_xlcdc_plane_update_general_settings(struct atmel_hlcdc_plane *plane,
> +					  struct atmel_hlcdc_plane_state *state);
> +void hlcdc_atomic_update(struct atmel_hlcdc_plane *plane,
> +			 struct atmel_hlcdc_dc *dc);
> +void xlcdc_atomic_update(struct atmel_hlcdc_plane *plane,
> +			 struct atmel_hlcdc_dc *dc);
> +void hlcdc_csc_init(struct atmel_hlcdc_plane *plane,
> +		    const struct atmel_hlcdc_layer_desc *desc);
> +void xlcdc_csc_init(struct atmel_hlcdc_plane *plane,
> +		    const struct atmel_hlcdc_layer_desc *desc);
> +void hlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
> +		   const struct atmel_hlcdc_layer_desc *desc);
> +void xlcdc_irq_dbg(struct atmel_hlcdc_plane *plane,
> +		   const struct atmel_hlcdc_layer_desc *desc);
> +

These are still here... Isn't the solution I proposed to you in the
previous version good enough?

Thank you,
Claudiu Beznea
