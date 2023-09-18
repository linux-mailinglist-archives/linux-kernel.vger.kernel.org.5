Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BB17A451A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbjIRIsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240940AbjIRIay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:30:54 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0298D114;
        Mon, 18 Sep 2023 01:30:35 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5734b893a11so2800765eaf.1;
        Mon, 18 Sep 2023 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695025835; x=1695630635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gxUVSVCUEW7zut2SflwjM4pYcypiURMBMDu4ko25UQ=;
        b=QtLJTewZQlOhMGjKbwuWodACZeXhFMHj+l21jGQEoV3ME/+wFK3OF1sKcQwgqcz/U/
         VQYhRJ4kdA8T5/mJL1A6P+YyULYI1FN+nuYS7XReQgo2Po0sUAR15fCvL/xJfq7NWRTY
         brDPM1v3voobhB/HdKwGmNbmxgB1K4ruNuj1c6/+/3N6Ua3Qwft4hhgGzdfXFZdd3Y4w
         zHYWe1u/wiPIxbeFfES5unMQu6w7NDIFQrxEDrws632SQ7M1yUej10gU462D3xHqWLIV
         kc+XBBQGigt0QdN4ejZ3o4+2pH340fP5njc4aTA6KwBVNo7rEnCVd9/Lcog1Y3SHrtBs
         cJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695025835; x=1695630635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gxUVSVCUEW7zut2SflwjM4pYcypiURMBMDu4ko25UQ=;
        b=uLvVuDzobv9Eqyfha538L/G53AYvcCdBoJASK68h0oOZXPI66UTc6r27AfiS4ER9EU
         pj035zFXQ1RXyOOLGLLEJ3ywsQmC1TC2QAA+mZMzUNKS7pHd9prR0Se2RQxPJ5NtAy+a
         WS4gMuR/OWckkNuqcWP5J2SOULYRPwFMXoaRO3LI2JVTWnS+3Ho1chdLgs7E+NBhVGCf
         CzrAZYTPrBbT62ZywDlbbKfS5j2ru+4zEkcIuYY0Wx1Q3dEauly8Y9/f5KMsy7HMkaAY
         CcSxsJQzNTJTXonyVFY/7Em33XEFDYJrKnsjF1FGg0nvL7w3wfxA+B4LCDBwbBLgsI7p
         /z/g==
X-Gm-Message-State: AOJu0YzaezOFCkhUTvUvk3Cq+e3zIFhuIiR2lM16A4PHXbITJaD/JHxn
        akn69hcUfcd8iH1RTfpxr+yGXwvYKaiNfBOpqyI=
X-Google-Smtp-Source: AGHT+IHrSDRkd5WNauUdlZMq5j/Pp4W7T1SSLTlkg0boyakoxeUeVrdmPvAbatnVgTgjJF89LlTtpEB1FizNovQ6HuM=
X-Received: by 2002:a05:6870:95aa:b0:1ba:d044:8a4 with SMTP id
 k42-20020a05687095aa00b001bad04408a4mr10884539oao.18.1695025835198; Mon, 18
 Sep 2023 01:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230917162837.277405-1-arinc.unal@arinc9.com> <20230917162837.277405-2-arinc.unal@arinc9.com>
In-Reply-To: <20230917162837.277405-2-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 18 Sep 2023 10:30:24 +0200
Message-ID: <CAMhs-H-MPjiRLY1khOdj7AXhvU62HKTZfoXTH=fsvngF-rsnCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: mtmips: document pins of groups
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 6:30=E2=80=AFPM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.un=
al@arinc9.com> wrote:
>
> Document the pins of each group on the MediaTek MTMIPS SoC pin controller=
s.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/mediatek,mt7620-pinctrl.yaml      | 22 ++++++++++++-
>  .../pinctrl/mediatek,mt7621-pinctrl.yaml      | 18 +++++++++-
>  .../pinctrl/mediatek,mt76x8-pinctrl.yaml      | 33 ++++++++++++++++++-
>  .../pinctrl/ralink,rt2880-pinctrl.yaml        | 17 +++++++++-
>  .../pinctrl/ralink,rt305x-pinctrl.yaml        | 16 ++++++++-
>  .../pinctrl/ralink,rt3352-pinctrl.yaml        | 17 +++++++++-
>  .../pinctrl/ralink,rt3883-pinctrl.yaml        | 16 ++++++++-
>  .../pinctrl/ralink,rt5350-pinctrl.yaml        | 13 +++++++-
>  8 files changed, 144 insertions(+), 8 deletions(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
