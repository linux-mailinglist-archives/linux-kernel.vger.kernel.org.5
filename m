Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3148777206
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjHJICS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjHJICP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:02:15 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A04210F6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:02:15 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56c85b723cfso515423eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691654534; x=1692259334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMKiJP9PwsAWvDuO6MkUcwKguB3RiOk5A4iPaJAWueQ=;
        b=qEL5eGpx3R1tGDnwFwbzoOd17uJ974M4YHJNL9ecktLrW7gE2xzpRITpGmyw+K7r0h
         X5jHgyLRc+kyZpRtNyJ/GK0opTjPFd/R6GdtXjXHz3xe+9y1hyUtDdIYGsJPaKphQJ2p
         3fNLGBdEYV6jDXBo3a6rG7D9I04puqMP4IwsFr34BWWh2yMSlRFEKkvLjAx52FHxmRbW
         OzUvkynWacCeFIi8URjbXP6xk7/JAQV9Wd/cClpwCMTHuHI6zBSSVlhieWObku/7Xaip
         V41FUMA6V/c31pMaJabmUXHrZFZ4FflNWHNRW08+K2964Wxnt/Ha1STq6oucnJ7jIJRG
         Xgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654534; x=1692259334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMKiJP9PwsAWvDuO6MkUcwKguB3RiOk5A4iPaJAWueQ=;
        b=YajA7IAOMiWu1dim+sI7HJQSBZOX2L5QY1mY44WtOgK70DRN5P5hXB0j7srXeILvXK
         4/JUkgkDCLu9EUuBdq4/PM3n4YKYyvDyIsWPSbPgLNUMCDIOutUXHHaaK+zWB+Yhyn/v
         BqMeoZFs5oEcWICYPWiEt6luBzyuTrEnBgQonyQiFKZAyqwIcFBb+ggz1lZpxQ2sEfEJ
         S1ittmqXc2IrKNGfd/5MnFqrdvlwHA5+UWHq6tpeoBf31rDBhuMTDo7EzQzaKol2oHwT
         kP22h4rhvX5/zFv2+zC7G99mHuhJO5mvd8A1nzbFSLrPs8UxhJBYUpAUxar2kyBI5pee
         Rl/g==
X-Gm-Message-State: AOJu0YzrmW8KryLi1w79IJAauU7OyHb0NBiswh+FLRq9f0G9ER9QC7RI
        eWZi+fPkP2Mji6WT6ljpWVQDQVMaazaygLEMHwhf6w==
X-Google-Smtp-Source: AGHT+IG7LOqODLO4XzzBQe6xjH9VCYPGuG47m7VY+spU3s+lQHTx7nqOVDrJK/EgUZKq9lp5grUSW9v+4kD1trQ+qgI=
X-Received: by 2002:a05:6808:4389:b0:3a7:1d15:28fe with SMTP id
 dz9-20020a056808438900b003a71d1528femr1706802oib.56.1691654534562; Thu, 10
 Aug 2023 01:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230726070353.103989-1-krzysztof.kozlowski@linaro.org> <20230726070353.103989-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726070353.103989-3-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:02:03 +0200
Message-ID: <CACRpkdZXUEh2cCyWaNyMnBot40DHQa0O8LPHOB14hpk8sXRM9w@mail.gmail.com>
Subject: Re: [PATCH 3/4] AMR: dts: st: ste: switch to enable-gpios
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 9:03=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The recommended name for enable GPIOs property in regulator-gpio is
> "enable-gpios".  This is also required by bindings:
>
>   ste-hrefv60plus-stuib.dtb: regulator-gpio: Unevaluated properties are n=
ot allowed ('enable-gpio' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hm if the subject start turning ARM: dts: st: ste: on these I might
need to consider
to move the ste(ricsson) stuff out of dts/st, this series mixes up the Ux50=
0 and
st maintainers. I can deal with this one but if it confuses the scripts tha=
t's
not good.

Anyways, patch applied! (With subject fixed.)

Yours,
Linus Walleij
