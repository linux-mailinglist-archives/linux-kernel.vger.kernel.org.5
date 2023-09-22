Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0AF7AB475
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjIVPKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjIVPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:10:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D658A3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:10:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-503397ee920so3680783e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695395401; x=1696000201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eBbLfmPpKzgVoeBpgucGlr3BpZFPgPf0mz1waJgwt2Q=;
        b=nIP3ta1uztlrBe6zLQIA6D1mjtCNalCJs/yfLbJ/46/n/UYEkRy8wMHYVpA0o5LDax
         VPPnYFh6V1RyDCWsH0JUJsDiFkXFg1emgmbGC5XTQdWJDVeNsnQhEgCm/2Y6FtM5uyLJ
         hgVqaam0FuyLGwSPZvHAEOk+PsDmQxzuA8YnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695395401; x=1696000201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBbLfmPpKzgVoeBpgucGlr3BpZFPgPf0mz1waJgwt2Q=;
        b=MVGFzbzHk9RT5b5qE9EYVrrzDtlczvsPzXOIwj+L1rRh28x9HP9fiWMgCyRq1eNzJR
         iZZc5OtmWiUPfDgCe//2reaFB3F4dnSLDQgGaWom2BumAguxRrjn5N4v46E1sDOaWQgz
         lDmiK0sLbSVqcNd1VPlAW+Yd57AFKMyEfwqaq4I32Sw4jJYyIJCfw0+9cDgEF/TP1zJL
         Zvh3cyOeZDfeiTbynN5Hu6baK6fpVi2JaLC+8qENEyzvnKqwryKm/4ZW5hfNByC3R/+W
         fOQV0G58oQ++OrPtpo32wzqB+Xb/7L81o1Qs83OUV2SYmtJshzZINabX3mgTo0YfUKRc
         W8pA==
X-Gm-Message-State: AOJu0Yyq/S/FeKK8ohRa1zE0A5i3lPD/14zNnvgE4TtCtsYui7TvJwCy
        MWnB2AbXPvn6kAocXy4+QnuFXYywzjhHdvndiyknSQ==
X-Google-Smtp-Source: AGHT+IG0+FTwy7leUuJNc07mqM4ZpBxga4kMOkpvPH1KKuybgHujWbeNV789s9axdxdQeWXDb18UprYq/1LXcelxM4U=
X-Received: by 2002:a05:6512:449:b0:4f8:77db:1d9e with SMTP id
 y9-20020a056512044900b004f877db1d9emr7510046lfk.12.1695395401203; Fri, 22 Sep
 2023 08:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <e045afaa-bc38-4fed-966e-a034e106c86c@gmail.com>
In-Reply-To: <e045afaa-bc38-4fed-966e-a034e106c86c@gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Fri, 22 Sep 2023 09:09:50 -0600
Message-ID: <CAPnjgZ2sN1bRKOFpDXXc0QfYsiHMxEFR8K+p=swLWs8ZCQBusw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alper,

On Fri, 22 Sept 2023 at 07:57, Alper Nebi Yasak
<alpernebiyasak@gmail.com> wrote:
>
> On 2023-09-21 21:45 +03:00, Simon Glass wrote:
> > Binman[1] is a tool for creating firmware images. It allows you to
> > combine various binaries and place them in an output file.
> >
> > Binman uses a DT schema to describe an image, in enough detail that
> > it can be automatically built from component parts, disassembled,
> > replaced, listed, etc.
> >
> > Images are typically stored in flash, which is why this binding is
> > targeted at mtd. Previous discussion is at [2] [3].
> >
> > [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
> > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.org/
> > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  .../bindings/mtd/partitions/binman.yaml       | 50 +++++++++++++++
> >  .../bindings/mtd/partitions/binman/entry.yaml | 61 +++++++++++++++++++
> >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> >  MAINTAINERS                                   |  5 ++
> >  4 files changed, 117 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
>
> This doesn't match the schema in [2], but seems more like v1 of that. Is
> that intentional?

Yes. Based on discussions with Rob, the idea of setting a general
format seems to be too ambitious, at least for now.

Regards,
Simon
