Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371E676A939
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjHAGeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjHAGeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:34:19 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E053F1736;
        Mon, 31 Jul 2023 23:33:58 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5633b7e5f90so3974527eaf.1;
        Mon, 31 Jul 2023 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690871638; x=1691476438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKCc2rKXf8V4+XCXWPe8OLQkPwapI0w4aGB/FpbSmi4=;
        b=qiemk3mohhg+xAOpbLyh75xBQ0XBf+pyKp8+mn3/iwJr7lb/d6K4Jmd2CT/3NhGxpJ
         0ig6IJLsSCSM2hjvFqaaE7KRNu/sRSEGscDbk64GseP1uJjscnZNEwJ8nR7gqCrvYNzp
         IJTtYU/ZnEDQMWEDnHb5vDTYldERmJUQC0kziFDooKMObuBg0P0TIUTM1AHWA2tQ65ME
         YATRzqFKFQHCn7POVF9LZMKIfw1mQYVFRJkNHd6tszZ01Hd5lECAcuXlfjvrNPCa2dt4
         kEjF0YibGo2edUsW373dRNmgFcE5zHwPlEAazqLFOaVbpk2oNq5o4AJ1JVxN4OetErIH
         VcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690871638; x=1691476438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKCc2rKXf8V4+XCXWPe8OLQkPwapI0w4aGB/FpbSmi4=;
        b=KNWy9yEwjMkl48BdJWOA6oeMeg35HEFfWZTenZ9lJQzCSLkQoa4Z705PIKQKceATf1
         6021OSrZYbJeG7ojqaiC/B86A2pCU2LSWiElQWe5pea8nTndwoxqHyOSe2ith1rlSnG7
         cRhcJEGyUI5hd7GuRolRP4bpw8pVbkY1bL3LJeqAnviJzYHMHKAPl/Mf/1Hf05jC8ZPV
         im2rM5yeAhRrBedS3OZSL+iKfOquVdgO9MLMSuTzpzHORMOw6kcad/tqM3a5D6bu9Utn
         j74X3cUHGbsziBQaloAVdhiPKwd8GEvkhria3aeQ6E22NlVxIukXWBJitYRH+6ShwZvf
         /J8g==
X-Gm-Message-State: ABy/qLZkiNk/veMCzfza9W6CxdloGxpnBeuVJvSxf1JZu1kGD4ubUPwl
        9rqmwOppEPLNI8NxPQiHUr4HepugymrhdGXhVyQ=
X-Google-Smtp-Source: APBJJlE7oK2nlXq2a2uZW19q6boXQ0GoIFtAt0DViwCQHqSjaq44TkYovJHXpkKu7Yr24VlvKFZwqsDS2UMCA9m0Fsc=
X-Received: by 2002:a4a:9c03:0:b0:565:bbc0:2e36 with SMTP id
 y3-20020a4a9c03000000b00565bbc02e36mr10919110ooj.3.1690871637923; Mon, 31 Jul
 2023 23:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230729110449.1357-1-zajec5@gmail.com>
In-Reply-To: <20230729110449.1357-1-zajec5@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 1 Aug 2023 08:33:45 +0200
Message-ID: <CAMhs-H9RpyCTcrRjtALg_aqGR7cmrz_ufQdVYm=WSEgUObpxKA@mail.gmail.com>
Subject: Re: [PATCH] mips: dts: ralink: reorder MT7621 clocks in Ethernet block
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
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

On Sat, Jul 29, 2023 at 1:04=E2=80=AFPM Rafa=C5=82 Mi=C5=82ecki <zajec5@gma=
il.com> wrote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> Use order as specified in the binding (first "ethif" then "fe").
>
> This fixes:
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e10000=
0: clock-names:0: 'ethif' was expected
>         From schema: Documentation/devicetree/bindings/net/mediatek,net.y=
aml
> arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dtb: ethernet@1e10000=
0: clock-names:1: 'fe' was expected
>         From schema: Documentation/devicetree/bindings/net/mediatek,net.y=
aml
>
> Fixes: 7a6ee0bbab25 ("mips: dts: ralink: add MT7621 SoC")
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
