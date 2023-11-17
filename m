Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48667EFA85
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346215AbjKQVYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjKQVY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:24:27 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E73F2D4E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:23:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso321751666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700256190; x=1700860990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFBqw6WWFn2DTJJAm5oTscYcujSFx4g4cXCp4v+z0IA=;
        b=NXJqXa+GrWs4EjbDRUHSMKUDu6DoWDlZ/IB3CFDKQ9jNem4v54qdb1cS52H0tS1tiY
         FzQgApeDdbSa/7puBkcU4YD16zqJyEKUYfjNhkpP6X1FUZ6S4E0YFUauT5AyaC6qgwOc
         aUanh6y9tK616MAt+2fIqBNnD43TiaEJAQhw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700256190; x=1700860990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFBqw6WWFn2DTJJAm5oTscYcujSFx4g4cXCp4v+z0IA=;
        b=w/8OK78rRVjqstJYAPWcXKIWvGbaMVi/rUegOj3uu/KPimktnrO8+10oKNsm821OSB
         6Xpj54BlvocqR1mKwRAYy6OS3xSiA4a7Kvh6L2Wqa6pwJVUIfcK+AGgZvJ8hGHSM+Z++
         4xoThra6GXg3Mg2aXQW0FLnpPrWycctKshz7+Nbz/NWWvOuEPSLEGrWFp93ykTUoJGQo
         Txf82sLLxYcAmg3vV5swJQwGLtHPCFaHdqXUReXGJWyB9FJUcoZKgsv9zpcxCDQnKmss
         FuaD51nNWX6kp2Zyn+tcwA6DKL9pec5CN01/6pnlJxejwKuQW7WKTj82Pmzs9rQICDNe
         1l+g==
X-Gm-Message-State: AOJu0YyAcv31Aud2kFE5V+hdxzqUJAFtnjMYw/Rr8oYBw1UFWnyryz37
        sGyklCprHTR0FyLBR4/ZFXtz0vIh+LN1Lckr1Gpiiw==
X-Google-Smtp-Source: AGHT+IG0CCBD/vhOnAxvQk6kik8V8UE3UKMY+1zxh06hcSsW+6RBV19PfTA00+edHZ5uYsaEBZXjDQ==
X-Received: by 2002:a17:906:ae4d:b0:9d3:afe1:b3e5 with SMTP id lf13-20020a170906ae4d00b009d3afe1b3e5mr234536ejb.75.1700256190534;
        Fri, 17 Nov 2023 13:23:10 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id y20-20020a170906471400b009db53aa4f7bsm1176888ejq.28.2023.11.17.13.23.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 13:23:10 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so3475e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:23:09 -0800 (PST)
X-Received: by 2002:a1c:7504:0:b0:404:74f8:f47c with SMTP id
 o4-20020a1c7504000000b0040474f8f47cmr50225wmc.5.1700256189626; Fri, 17 Nov
 2023 13:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20231114044205.613421-1-xuxinxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20231114044205.613421-1-xuxinxiong@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Nov 2023 13:22:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vg5YouEYVSnv3XJ-ghjZoLa9-QG6Ksh4yg5hExN_9gWA@mail.gmail.com>
Message-ID: <CAD=FV=Vg5YouEYVSnv3XJ-ghjZoLa9-QG6Ksh4yg5hExN_9gWA@mail.gmail.com>
Subject: Re: [V3] drm/panel: auo,b101uan08.3: Fine tune the panel power sequence
To:     Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 13, 2023 at 8:42=E2=80=AFPM Xuxin Xiong
<xuxinxiong@huaqin.corp-partner.google.com> wrote:
>
> For "auo,b101uan08.3" this panel, it is stipulated in the panel spec that
> MIPI needs to keep the LP11 state before the lcm_reset pin is pulled high=
.
>
> Fixes: 56ad624b4cb5 ("drm/panel: support for auo, b101uan08.3 wuxga dsi v=
ideo mode panel")
> Signed-off-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
> ---
> Changes in V3:
>   - Updated the Fixes tag's style.
> link to V2: https://patchwork.kernel.org/project/dri-devel/patch/20231114=
034505.288569-1-xuxinxiong@huaqin.corp-partner.google.com/
> ---
> Changes in V2:
>   - Updated the commit message and added the Fixes tag.
> link to V1: https://patchwork.kernel.org/project/dri-devel/patch/20231109=
092634.1694066-1-xuxinxiong@huaqin.corp-partner.google.com/
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 1 +
>  1 file changed, 1 insertion(+)

In my response to v1 [1] I said you could have just added my
Reviewed-by tag yourself after the problems were fixed. Some
maintainers actually get a bit annoyed when you don't do this, so you
should get in the habit of doing it.

In any case, this looks fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-fixes with my tag:
6965809e5269 drm/panel: auo,b101uan08.3: Fine tune the panel power sequence



[1] https://lore.kernel.org/r/CAD=3DFV=3DVxQJFWFaGHD+zpr4dxB85jMQpJiTDAmFZk=
67CTYNcg=3Dw@mail.gmail.com/
