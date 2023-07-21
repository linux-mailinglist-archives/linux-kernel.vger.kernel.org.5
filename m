Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC6375C6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGUM0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGUM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:26:08 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A141E172A;
        Fri, 21 Jul 2023 05:26:07 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-483ad06a37aso2028535e0c.1;
        Fri, 21 Jul 2023 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689942367; x=1690547167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xluE36BD8mVrNVro8WajFgh+qTA9z/PcVNAY+dwKLfA=;
        b=pIf6X1un4jqkN/qzNs5aHSjweGBRD9IFIwqtxIPEstPA6ZdTcBuaEoa9mC5zDfaM7b
         l8sr9ke9PPXbllJ2MxN8dg3/1MY4m06w/joAgtrIpKSLR57LqTrBgw4ciuLIisHk2HGO
         hEYbzHnQPK/h9LYy6bkznftE7raGK/UgST3pj5IZH14DvQWVGpZ2Zpu6M+56mIxG7kiq
         HkIM8kOkfdwLbFroSYfMkWzM0Nk6AvlIYuzrBT3lH02RDspACz4fwd4rLrwd/FR1hjm3
         xpyNJNGtUqoqK+w/ggeSF1yyC0cNqg96t5BOsxHSC5G/aduDul6FtWrptMl3k/5IA/Xm
         RSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689942367; x=1690547167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xluE36BD8mVrNVro8WajFgh+qTA9z/PcVNAY+dwKLfA=;
        b=aM5z7te2lyp5aRWeIraIS8wb9AqyFPBUeVCinn2Z86bddSc98lVNQnpt0lHBhxTle2
         tlGgtRhmi0eNK4z999IVamonz3uwsF4m7pxUXQhAE/R3mI5V9ZjWQIQ9V6geIICF0veb
         cLiOm0LkdVuQEsWqRe90tp1H63LoiH45VqrVgy5aFeX8HbfcBLjJ8C1I2cHjSExB3Gp7
         dr9Ht1bK9upVBI5aOzrBlDta/hOfc+hsnOYQEwS9TZ2dfXOSnoTJy/sqEqj7bGenCcO5
         W3+JcUo/mVx0XpRPES/LLyuqJVl7LTo9r6wicnDjPwulfOcIzYxFoPzPriBODr/iKZdH
         fclg==
X-Gm-Message-State: ABy/qLacQN833Z93pi+kMumfm/g8jwEdsZw/kwhJij4iz6sTimbh3n0y
        y1dWfoHEYTLVhnrosbQgyPr/eWZ7NypvWMIOamk=
X-Google-Smtp-Source: APBJJlFSFie+d/eOgAkf4EVoTC3bSAOyfbKhUcbE7hyw5UwumUJ67EQf6xLnDr2X7mdMRCp3uIl4YEbZlZDFiPsbEMA=
X-Received: by 2002:a05:6122:656:b0:477:4872:7f9d with SMTP id
 h22-20020a056122065600b0047748727f9dmr2310534vkp.4.1689942366532; Fri, 21 Jul
 2023 05:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230720124026.356603-1-viteosen@gmail.com> <5b9ceb0e-b7e4-d4b3-461e-c70f4a01fa5e@linaro.org>
In-Reply-To: <5b9ceb0e-b7e4-d4b3-461e-c70f4a01fa5e@linaro.org>
From:   Viktar Simanenka <viteosen@gmail.com>
Date:   Fri, 21 Jul 2023 15:25:54 +0300
Message-ID: <CAFQqR8-O+w-RQnLUSvyL-4h78pJ1cSr67Chce03+tLCTYP7YWg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: add bindings for pcd8544 displays
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:42=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/07/2023 14:40, Viktar Simanenka wrote:
> > +allOf:
> > +  - $ref: panel/panel-common.yaml#
>
> This is not a panel, is it?

I can't clearly tell the difference between LCD display and panel.
I've added panel-common because of 'backlight' and 'reset-gpios'
properties. I've looked at 'sitronix,st7735r.yaml',
'ilitek,ili9486.yaml' as examples. SPI controlled LCD displays, but in
color.
In fact 'reset-gpios' is already in my yaml. I might just add the
'backlight' property explicitly and remove this dependency. Should I?
