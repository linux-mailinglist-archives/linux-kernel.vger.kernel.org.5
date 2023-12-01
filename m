Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069A380074B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjLAJjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377899AbjLAJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:39:02 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD611730
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:39:07 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-46456814197so660610137.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701423546; x=1702028346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8ZuKUeVfTp+wxTfK+NUsGEji4JyXDZpkF3g5/v1QY4=;
        b=073HcE3C8vSsMl6nVyS3xM4UGwnH6uKDKtTokY6PyIZcQsQOuIveyU8XnR7hzNA6sB
         DpZuutGyw52aorViiheoc+WdLBASa8ReO+c1MSuT9W1IRG7ygnCyPA4K/pr15j1OZhUb
         2H22mGr73SVkjZHAdU1c/Ku+vI/pk8pJfDv8dDvZz0rTNacU245LjsrtG5GnUI5DvSdO
         /mcoF8uazK+hOWr/paHQ61rxx8A/lWn64Adlo88V04L8K2rUNEVrWpLtStu9AkU54FA1
         eqGmoLHBr564euW2OsACBCJZbM6sUzPnpYu1Mbg89gg/n67W/QmgpschaxzWXaP2px4l
         62GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423546; x=1702028346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8ZuKUeVfTp+wxTfK+NUsGEji4JyXDZpkF3g5/v1QY4=;
        b=CWUGi/aRcNugBeVrYamaihBsl6ETLId+UeTzcDl7rSVR8wXJIsyqT3HO6gEDtszU37
         TcJmUMWGel8q1RPnQ22HdkNNPxBnN/ksVGuzrNG6idY/Z4FW7Mf8w6QmxnW8CwhHsGlb
         VJN6jLDietC29Wk+V+AkOpctwrnhDWViAHtbl1OuL1lWAULCiCHlCT89kBpXEXYx8Ckl
         LgqY4J+msXDgJF9FGA0qfSc1Aq0bqwaGrhVKdBMeiyQ1iRAfmOMsND7wC1U6GQXyM11U
         BYYN+ks4UDGEu6o94yBEF+YroP8+9qjUAC2rF/JvDE0W+9VDL8bhYWcJGlyUokyWbpGo
         lvRg==
X-Gm-Message-State: AOJu0YxGWBwDRQcd6H8KX2LRTKgpVjAx3xoAkwv1ZtWC2FdlmiXbnxZa
        e3I3w14JDlyTUQXiImZD7G3V7dh34Tby9z1ABJ28Rg==
X-Google-Smtp-Source: AGHT+IH+dZrEPlQrEQxPz8LBu9W0IH+o/0FK3aIMgrHiVOtbkiEm+9JiVZdS/A4+MMhqSwl8n1ZvjJA8xOuv7BT79FA=
X-Received: by 2002:a05:6102:3b9a:b0:464:41f7:cf17 with SMTP id
 z26-20020a0561023b9a00b0046441f7cf17mr10403139vsu.12.1701423546726; Fri, 01
 Dec 2023 01:39:06 -0800 (PST)
MIME-Version: 1.0
References: <20231127-b4-imx7-var-som-gome-v1-0-f26f88f2d0bc@pengutronix.de> <20231127-b4-imx7-var-som-gome-v1-1-f26f88f2d0bc@pengutronix.de>
In-Reply-To: <20231127-b4-imx7-var-som-gome-v1-1-f26f88f2d0bc@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Dec 2023 10:38:55 +0100
Message-ID: <CAMRc=Md8mDhNJcOZDCx5Ew2DvLfvtbB+WpQtxwt78CxJy4hJHg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: at24: add ROHM BR24G04
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:12=E2=80=AFPM Roland Hieber <rhi@pengutronix.de>=
 wrote:
>
> From: Philipp Zabel <p.zabel@pengutronix.de>
>
> Add compatible for ROHM Semiconductor BR24G04 EEPROMs.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documen=
tation/devicetree/bindings/eeprom/at24.yaml
> index b6864d0ee81e..1812ef31d5f1 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> @@ -123,6 +123,7 @@ properties:
>            - enum:
>                - onnn,cat24c04
>                - onnn,cat24c05
> +              - rohm,br24g04
>            - const: atmel,24c04
>        - items:
>            - const: renesas,r1ex24016
>
> --
> 2.39.2
>

Applied, thanks!

Bart
