Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D075609D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjGQKhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjGQKhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:37:17 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C203118;
        Mon, 17 Jul 2023 03:37:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55b1238a024so3335702a12.0;
        Mon, 17 Jul 2023 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689590236; x=1692182236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l5xqvDPNGoyvEYRfPhyK85Kw/zzYVcuJucCvVvL9ig=;
        b=OqDfAU+Jn9QP3sHnEhBNasN57SAKS7a79TSjawpfjL4qZeoBPEkiqvwKlc+3i2wQ1A
         AQodZVDulhq+6rUDlHebnmkXA7p7Y1cCVMiJ728dcPXsNc8FDBgtCDwEj3B79zUZZtud
         2lSVkl1oObtyB+ibJgvypBttBJrItRwazZ/kCeIBbArDW4fJQxHEAuwwUlDVDjWwXuGZ
         aS2GN+z5S6Pa3dolPUcQRpkX4NYradtezv+T5dL2pH5y7sjOckCVA1nxywNiGXACqaEz
         fqu6xbKArM6S0Kwmakz6QoVsPyk3CgRlQPA/1nLZh1OQwF/z/sdzfouGGXLwdNM0gItB
         kzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689590236; x=1692182236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l5xqvDPNGoyvEYRfPhyK85Kw/zzYVcuJucCvVvL9ig=;
        b=G3QIYqWAlMyGHerjiJ7AkHs0YtRP3xOlwisevsESwB7w0nMiNTXe0LYZMYIpjAOlxn
         yel/lXeVFv0GR/ydNxmdbgCLGTklENol4W7PL/XkBfUnoCO2ICQp7D9JAJV/f1LXsvmU
         w2uXuOZ3BsYyk08vW4HE11AA1HTrgC478HQ2IZgkG6k8jdIosRa3v3NEVv4UalHExgDO
         CGujJbNn69Po5ovCVXkhDN5KyggkVYZBELU3fhrVUukGOyC049HC5fD9AkOwKqCtL5Jo
         XO75vuYjirUp5OR9ph8IuELWxD8u5G22Gv3SCZEkxBHJ/aETZX4gulyclrJdPrREuxIr
         4R7A==
X-Gm-Message-State: ABy/qLYwnKmPAzudgW2A+7GmuMKEVGf9bCcHpM7EKLtdCrw6h36uSAT2
        ityIH/+lfdRrobezIc9eTACQyh+Erl1+Cd6HyoY=
X-Google-Smtp-Source: APBJJlEF4apZzBMkvVeoZzSw5LBPn6lTVsyPpvBDFjj39oUO7hD/9tcZM0nVGuaj6kTWJsCkDPTxNlts9pr1Ob4lK+g=
X-Received: by 2002:a17:90a:d789:b0:267:909f:3719 with SMTP id
 z9-20020a17090ad78900b00267909f3719mr2984884pju.19.1689590235728; Mon, 17 Jul
 2023 03:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230717075123.1597977-1-dylan_hung@aspeedtech.com> <6dbf7628-da4e-6be6-27ed-b0bafa15d8bb@linaro.org>
In-Reply-To: <6dbf7628-da4e-6be6-27ed-b0bafa15d8bb@linaro.org>
From:   Chih-Jen Hung <kobedylan@gmail.com>
Date:   Mon, 17 Jul 2023 18:37:04 +0800
Message-ID: <CAKohO566nYsReUExwwX8KEU3pCHFGqvif56QR6r-bNrnvxawMw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] dt-bindings: clock: ast2600: Add I3C and MAC
 reset definitions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com,
        Dylan Hung <dylan_hung@aspeedtech.com>
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2023=E5=B9=
=B47=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:00=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 17/07/2023 09:51, Dylan Hung wrote:
> > Add reset definitions of AST2600 I3C and MAC controllers.
> >
> > Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> > ---
> >
> > Resend v2 patch through my gmail account as the aspeedtech.com domain i=
s blocked by gmail.com
>
> Where is the changelog?
>

Apologies for the oversight. I will ensure to include the changelog in V3.

> >
> >  include/dt-bindings/clock/ast2600-clock.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bin=
dings/clock/ast2600-clock.h
> > index e149eee61588..712782177c90 100644
> > --- a/include/dt-bindings/clock/ast2600-clock.h
> > +++ b/include/dt-bindings/clock/ast2600-clock.h
> > @@ -90,7 +90,19 @@
> >  /* Only list resets here that are not part of a clock gate + reset pai=
r */
> >  #define ASPEED_RESET_ADC             55
> >  #define ASPEED_RESET_JTAG_MASTER2    54
> > +
> > +#define ASPEED_RESET_MAC4            53
> > +#define ASPEED_RESET_MAC3            52
> > +
> > +#define ASPEED_RESET_I3C5            45
> > +#define ASPEED_RESET_I3C4            44
> > +#define ASPEED_RESET_I3C3            43
> > +#define ASPEED_RESET_I3C2            42
> > +#define ASPEED_RESET_I3C1            41
> > +#define ASPEED_RESET_I3C0            40
> > +#define ASPEED_RESET_I3C             39
> >  #define ASPEED_RESET_I3C_DMA         39
>
> Why adding duplicate ID? Your commit msg or a comment here should
> explain this.
>

There is no reset-line hardware available for `ASPEED_RESET_I3C_DMA`, so I =
have
added a new macro to provide a better representation of the hardware design=
.
However, since removing the old macro may affect all users, I decide to kee=
p
both the old and new macros. I will include the explainaion in the commit
message of V3.

> Best regards,
> Krzysztof
>
