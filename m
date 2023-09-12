Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E176979DC51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 01:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjILXAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 19:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjILXAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 19:00:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F76210F4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 16:00:38 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-415155b2796so61171cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 16:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694559637; x=1695164437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyJmDwSUEBAT5TkJCd5pReZaLPzxfz30Afne5dFuwCE=;
        b=Kpvobm1wnpQ+fWxNPUTube1GEHxHedwSoZoGO/2mU4IJn8Ot8UDuR2rJdwR5r3Am57
         vilNY2yO/ymj8ixnIdqQJyzPRZSYfXDZLbVwvOJtucbmHotywzvtnUgsFVpe5jSlcAFg
         borvFbIbhjYNWx1L8zLEEo+oMpsDNI7EdlookF38o104UP3qWJynSj50PPbB/z3LqzES
         W61L65G3wth4GhlE8LtziVEZv4r4PCCkGsgQJkjOB93zfj21yS0NJEg6ljTxhuUX2op5
         rYMU2pW4gYEVrUSQtKfK8vt5XtBp+mOkQkFqMTgkAUBx7VsvRVqwo7HNvICu2v0cW6Hr
         G/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694559637; x=1695164437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyJmDwSUEBAT5TkJCd5pReZaLPzxfz30Afne5dFuwCE=;
        b=HyChwekRXef7vgdBX5b3p1OUxu8n41oimbImgFRduzUoSexILzAZx835cV4KV86P1/
         rmPi8ekX6ySk4Ld6Nfp6w4Hu1Rq61R61DjnmAHW/J+G7UpO/r+QIZZg/8GjtbKNX3hIE
         L11W05fvItf/FexTFm9hZcJi/ByO8ZGz9TsjEIivr9uuUzmbZSWQrNy+n3fr4k8jRjgy
         Tnef0m6F9RSgO2MQcw7c6pyU3yL+NEsXMEI3HLiC3Rtq4ENfhm7RaRCDw25N8uyML8ND
         OAdzBDdB7VMlXRCvgNUSwiVwCse5P1h6YFOSl8QD5Gupx4F7FD8K5cMF/9rYO0ApbbTJ
         rxCg==
X-Gm-Message-State: AOJu0YxroMnWidUieVCdWXfYMgREFjq3ntVAFbRODSZDF8umJLKsTI6c
        VUi6IAjDg43UM3VT1VR0q3/Md3d9+zGLZlNIwrc88g==
X-Google-Smtp-Source: AGHT+IG3EcPXprLCAz21KTVrZkubgDDyvYv8YnsUJ3H3R/WudOZ5LBCK6NOqf5lVyujbVWA/U47VjCUJj4AsCKvlQJo=
X-Received: by 2002:ac8:58d0:0:b0:410:88a5:92f with SMTP id
 u16-20020ac858d0000000b0041088a5092fmr116138qta.0.1694559637027; Tue, 12 Sep
 2023 16:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230912174928.528414-1-apatel@ventanamicro.com> <20230912174928.528414-4-apatel@ventanamicro.com>
In-Reply-To: <20230912174928.528414-4-apatel@ventanamicro.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 12 Sep 2023 16:00:00 -0700
Message-ID: <CAGETcx8vXifmS2U5PTtmBySA=dih3GUOQ93A_qA5nm3faQqcGg@mail.gmail.com>
Subject: Re: [PATCH v8 03/16] of: property: Add fw_devlink support for msi-parent
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:50=E2=80=AFAM Anup Patel <apatel@ventanamicro.co=
m> wrote:
>
> This allows fw_devlink to create device links between consumers of
> a MSI and the supplier of the MSI.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index cf8dacf3e3b8..758ea822e46d 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1267,6 +1267,7 @@ DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells"=
)
>  DEFINE_SIMPLE_PROP(leds, "leds", NULL)
>  DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
>  DEFINE_SIMPLE_PROP(panel, "panel", NULL)
> +DEFINE_SIMPLE_PROP(msi_parent, "msi-parent", "#msi-cells")
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>
> @@ -1361,6 +1362,7 @@ static const struct supplier_bindings of_supplier_b=
indings[] =3D {
>         { .parse_prop =3D parse_regulators, },
>         { .parse_prop =3D parse_gpio, },
>         { .parse_prop =3D parse_gpios, },
> +       { .parse_prop =3D parse_msi_parent, },

Please follow the same ordering here as the DEFINE_SIMPLE_PROP macros.
So, this should come after the panel one.

-Saravana
