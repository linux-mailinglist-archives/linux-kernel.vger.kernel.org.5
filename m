Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4249778201F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjHTVIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjHTVIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:08:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4D155A7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:06:28 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d63c0a6568fso2827605276.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692565587; x=1693170387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD9cyaHgSU7OecxP7U/v+MRhNN5iRGNEtNN5f+NxK3E=;
        b=EkbIjelbdLkuzIuqi8lN2IaFia7QROWlfjiI7q7zlP6jDAvGYdauZr5rWGeP5TyNj/
         FTLwzTAVecCKL3BibvaoUCvO+gGncYmRqvynbSCU/H9CSnnaBpgnH1tOwcSw/jhwlTNE
         yxf9olC181R4u63D7T09ydG+I3s3ZtZ/u2PVgFULhzS48dJpD5wb5F9dF3a9Y+PsFYj+
         NHgSZ9uwlOzKa4/KiVA0h3lpcev49Jt9Lvu2vbMboOBUQF5Ovmhefg1ifsF1lEHMhDCm
         MbXMx2vz3Or/EDK9+/FBko1YDMvcoaLkgfWLakufV6DztPp4m3w4Zu6/QJHcRw+4VVzp
         LubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692565587; x=1693170387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jD9cyaHgSU7OecxP7U/v+MRhNN5iRGNEtNN5f+NxK3E=;
        b=D3RHtulXhy65ciCMc2Zdix6n8Izo/YsuyZlux5ORm/zKPhFbefHztgXE5KIW0KAqNb
         lq4sHUl6TCXZRgPi7udAF6U5GxT5KI+msxW0aQI3okqnKNRz85l+AUSeQDadTtWVFYsR
         4QnUV1mFPDy4rgiZSoYhy7SqEngkw9rk1rN21OebpJwEzvizqyM62czWfk3/Pgft4kbM
         onr5tIswlznSnqIKCnHmCaVCNR671XME0KQ2GgBP5BfTGSRuuGFI9v64/mcXR7BE3wmU
         8PI+UJnr6iNRc5y/JRTqlwaYAepNTRE3NFn0NRhBYJGj4u9mIU67/0yPh4hI681z6JrW
         1D1w==
X-Gm-Message-State: AOJu0Yw6v+ifX2VzDaKffTGNckcZkrbMTvZ4S3ejbzkYmLzFtAnYXNOI
        Q/V7ock1bB2qsW1+PpV7jMu7uuCn2ZDNuk12dMGARg==
X-Google-Smtp-Source: AGHT+IFUaS1hymFHjE/AoExPooLhJU9s7gYCM4hD5xHtjEpweKryYFaY4soUhFjoyRUlcRmul8KDvXSLKE35vGSqXJ8=
X-Received: by 2002:a81:7283:0:b0:589:8b55:f8cf with SMTP id
 n125-20020a817283000000b005898b55f8cfmr4756130ywc.50.1692565587414; Sun, 20
 Aug 2023 14:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692376360.git.christophe.leroy@csgroup.eu> <5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 20 Aug 2023 23:06:16 +0200
Message-ID: <CACRpkdamyFvzqrQ1=k04CbfEJn1azOF+yP5Ls2Qa3Ux6WGq7_A@mail.gmail.com>
Subject: Re: [PATCH v4 21/28] net: wan: Add framer framework support
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 6:41=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:

> From: Herve Codina <herve.codina@bootlin.com>
>
> A framer is a component in charge of an E1/T1 line interface.
> Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> frames. It also provides information related to the E1/T1 line.
>
> The framer framework provides a set of APIs for the framer drivers
> (framer provider) to create/destroy a framer and APIs for the framer
> users (framer consumer) to obtain a reference to the framer, and
> use the framer.
>
> This basic implementation provides a framer abstraction for:
>  - power on/off the framer
>  - get the framer status (line state)
>  - be notified on framer status changes
>  - get/set the framer configuration
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I had these review comments, you must have missed them?
https://lore.kernel.org/netdev/CACRpkdZQ9_f6+9CseV1L_wGphHujFPAYXMjJfjUrzSZ=
RakOBzg@mail.gmail.com/

Yours,
Linus Walleij
