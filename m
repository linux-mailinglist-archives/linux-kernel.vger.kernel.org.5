Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654FD76E2C6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjHCIRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjHCIQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:16:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274EB1BF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:11:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3174aac120aso571351f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 01:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691050283; x=1691655083;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ccPdz93R2ktglChLK92GsVW4oztvWhZvA2sF5gQ4E4=;
        b=Xk3NwDYu/IWY5bxvTmJUzlnKk0MJgrIyWoWVmPtWHROPtQU5f6g103KazMrNOC6IN9
         WhENeO7HTGwFmnMBfzLBC4nBBXcXKCaN4YN1wdjPpF4IODjdqzGMzbtXY/+WpfG8Jptg
         33iA5eKlkCFYM/VvxIowE+LuYumRaOOSNVptfpkVL7JZWfYNSOswXFp2eRrwZmfYFNCi
         2rYN6kBFdgl1+I92huKXp7xG5K8UBvfjDSCWq0QpGT2+uxfMVpS51sXh59M5xbWTT63z
         cq114zttfsDap+T6LOuVWq8WMIXkqP8zRNjra23n8PzE7MHbJEt34gtVgK5qABA1FPL5
         QYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691050283; x=1691655083;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ccPdz93R2ktglChLK92GsVW4oztvWhZvA2sF5gQ4E4=;
        b=Uwe2gkfV2ilNty4JOriERqcQyYvV6nVarDKaVeraGB1OamXTFJHQIsRYGy/VWBnVk/
         zhuc19NzRT2OCf7F6wGxXG2258LjmZvFc1fWDpNgrrpW33lNpFpapolj1BlHnonnq0L0
         NDLJIORnvBOcmHZM2JO/tfMp85ju6jiVZ+YotBBBoto6JoUGwPKeP/vBeDe+ddMSDo1C
         rcofPY3BVHE+o+VeNB/hx3DwFJOxgsRsjQwCqVG8SHKD7fMdsPC0WOoGidjj7wwxVpkm
         8X1FXorJp2cWCkFbAB2es/vjPlRZtH7SqNVUJ8BqL5sFhWAZjCIo64icPV8TrDW1jf1B
         T0mg==
X-Gm-Message-State: ABy/qLZxJ4ZVxFTTNGTAxYbnWMgKvP/jMFYgB1xqveYwvf4OeRCvAwuV
        FUk797A0wrqnuKWLrTa+dyG7BfarkLa2zOjwNPfF4Q==
X-Google-Smtp-Source: APBJJlG9vqYlLa8TO1V125NzyUWy8dv5qhbsaq1Wlu0Ug4Tj9TeUDSeNSlV5glf13iso5ElI9rTb2Q==
X-Received: by 2002:a05:6000:1371:b0:317:5e22:3ed4 with SMTP id q17-20020a056000137100b003175e223ed4mr6414482wrz.49.1691050283581;
        Thu, 03 Aug 2023 01:11:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8656:583:d034:d966? ([2a01:e0a:982:cbb0:8656:583:d034:d966])
        by smtp.gmail.com with ESMTPSA id y18-20020adff152000000b0031779a6b451sm21101418wro.83.2023.08.03.01.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 01:11:23 -0700 (PDT)
Message-ID: <292c3e7d-82ea-2631-bd4b-ef747f56287c@linaro.org>
Date:   Thu, 3 Aug 2023 10:11:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     David Airlie <airlied@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
Organization: Linaro Developer Services
Subject: Re: [PATCH 0/4] drm/panel: sitronix-st7789v: add support for partial
 mode
In-Reply-To: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/07/2023 17:31, Michael Riesch wrote:
> Hi all,
> 
> This series adds support for the partial display mode to the Sitronix
> ST7789V panel driver. This is useful for panels that are partially
> occluded by design, such as the Jasonic JT240MHQS-HWT-EK-E3. Support
> for this particular panel is added as well.
> 
> Note: This series is already based on
> https://lore.kernel.org/lkml/20230714013756.1546769-1-sre@kernel.org/

I understand Maxime's arguments, but by looking closely at the code,
this doesn't look like an hack at all and uses capabilities of the
panel controller to expose a smaller area without depending on any
changes or hacks on the display controller side which is coherent.

Following's Daniel's summary we cannot compare it to TV overscan
because overscan is only on *some* displays, we can still get 100%
of the picture from the signal.
While here, we cannot, there's physically less pixels on the panel.

If there's no more still a strong nack or pending comments,
I plan to apply those tomorrow.

Thanks,
Neil

> 
> Looking forward to your comments!
> 
> ---
> Michael Riesch (4):
>        dt-bindings: vendor-prefixes: add jasonic
>        dt-bindings: display: st7789v: add jasonic jt240mhqs-hwt-ek-e3 display
>        drm/panel: sitronix-st7789v: add support for partial mode
>        drm/panel: sitronix-st7789v: add jasonic jt240mhqs-hwt-ek-e3 support
> 
>   .../bindings/display/panel/sitronix,st7789v.yaml   |  1 +
>   .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
>   drivers/gpu/drm/panel/panel-sitronix-st7789v.c     | 67 +++++++++++++++++++++-
>   3 files changed, 68 insertions(+), 2 deletions(-)
> ---
> base-commit: b43dae411767f34288aa347f26b5ed2dade39469
> change-id: 20230718-feature-lcd-panel-26d9f29a7830
> 
> Best regards,

