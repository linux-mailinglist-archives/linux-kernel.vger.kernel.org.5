Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91FC7AEF08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbjIZOzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIZOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:55:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F84E6;
        Tue, 26 Sep 2023 07:54:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6927528c01dso1396453b3a.0;
        Tue, 26 Sep 2023 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695740093; x=1696344893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUg7RA9AWENnAEvjktXw0Q0VX8Hq+Jj1QvlmV23RBnY=;
        b=ANYBt44+/IwPebLXa0MyLXFpGzZTlK96CifKfSLSiTzy4VHZMIpvbYqYapLkme9pIK
         i9hfvr2HDCUoAivcMPVfYOtBg9YxmatI0FaNxfogqbQ2oqO9bLwCBN5BSN+6K4VCrvw4
         DMtFgr4lkFtNLuXUdE8/5lw1nS1U/veY36+hirQYHVlj/WncU2OlP1d/qraBJsmpIM9g
         xIIgBd3qjTvlCc6i3WQJleFcQN2b4iBAowQLsB/hMVpTJ4KO933boZixWGZjckOpb6wJ
         Pv62Bsfa90S//khiikZGSDmYdrEv5zvzQ/QVOhA/0HWKIp3JhbIOc3cQXCe1dCKvGKiy
         tM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740093; x=1696344893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUg7RA9AWENnAEvjktXw0Q0VX8Hq+Jj1QvlmV23RBnY=;
        b=ON8iwdTgOESD/wRyhPcoD/jwUv03wQ2ic+WegpQFwQv4hNCz+otXLW3h5O21xjtIEC
         XqraEnYAqGPl54+cqftPnNBFylWI3T3U64i8qHgu2UtGMaRuztY/OU4ivDScbkyDBkys
         OXxLKnF2eK18xdWHh/QVm/5vD5C9ED6+/+QkLs8KFdBMK5s+XUcnSUg755meI3S8jycd
         waWCVo+nAV4w//97Bfv7/lPnXPN7cyOaoM/NALAP8XzGCzq4YZQgFrb+bZC30ORwgxug
         jwPFUKQPAu8LwB1ZbR/CDJNhKebc4fKSx/rezRYnFViU3Wldp8wTUwgNMxS9Fsa6OJ1+
         nI8Q==
X-Gm-Message-State: AOJu0YzcSAwgEVULvtjhdM/FBf5LVIfnOr+9n36MUTaVGoqVYS+bABSX
        QlviNIWyULp4/n6IKFz9PlvksfGKTH7uz+HPNgQ=
X-Google-Smtp-Source: AGHT+IGppKOdOzhPvyCP7PuxYQZxIRXjPesiJpWn0izFZt6xiJeROoTqfOhhXOSb2Cksmwz8hbvNIH79Vu8b2i/Q4a4=
X-Received: by 2002:a05:6a20:8e19:b0:15a:f7fd:dd97 with SMTP id
 y25-20020a056a208e1900b0015af7fddd97mr10735996pzj.2.1695740092640; Tue, 26
 Sep 2023 07:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230926-vf610-gpio-v4-0-b57b7f6e8368@nxp.com> <20230926-vf610-gpio-v4-1-b57b7f6e8368@nxp.com>
In-Reply-To: <20230926-vf610-gpio-v4-1-b57b7f6e8368@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 26 Sep 2023 11:54:41 -0300
Message-ID: <CAOMZO5BXb02NAEd32vr5OoPXyL=Xm46FwomT2L7nDzLYZQGF1w@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: gpio: vf610: update gpio-ranges
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Tue, Sep 26, 2023 at 12:28=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX93 supports four gpio-ranges at max. To fix below issue:
> "gpio@43820080: gpio-ranges: [[30, 0, 84, 8], [30, 8, 66, 18],
>  [30, 26, 34, 2], [30, 28, 0, 4]] is too long"
>
>  Update the gpio-ranges property
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
