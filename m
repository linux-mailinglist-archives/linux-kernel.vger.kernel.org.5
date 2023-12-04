Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04816802F59
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjLDJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjLDJxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:53:47 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24F5DF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:53:53 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5c08c47c055so46328197b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701683633; x=1702288433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzMOxxlEg/QFrxypJgdxPuDbMTB8FVdAxHNtSJTBldI=;
        b=mEFGIH+KDTI6iObuF+GOXSisfw/zDOYMXVyhB9vU5TLA6qaJGeswbnIzzzFBvRDlLz
         fwjJzwYNo+yJTb6fCr99Bd1BbHEH0IbOw1zuScpBkaIdy2CxgdtUhEbB01BXz+JnjwC6
         kyl+X+MWyI5DWvwRIxTsPJQna7iN+fmqvpI1NXI0oF5ybAlVUS6vZXM/7UtaceLJkhau
         N15XaLB5y3pH25BVKUjNZ3bAAxdqUU0D8sH81VyC4VYm6Jpcukg/htxCd6BoQjFLVEa+
         kuXhn5kwp33EWg9lEMX2VRfAf8UuOxYkCp754UQr4bRSnnfCqOk6xoVLHsllFnHm5297
         BMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701683633; x=1702288433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzMOxxlEg/QFrxypJgdxPuDbMTB8FVdAxHNtSJTBldI=;
        b=XiOpqv3Dsz5LOYeTA30aaOAzmyP/HEbarnvuzkebEeHHtOOksxhapNXL0kpA+Lk8dt
         i35R+yFecKWlNmMDEjovfCpHleZHLhvBK+DJPiBUqwovXeTVTNB5gu+XJ+e9eCg5GU2E
         H4+GOA2aiudvy3cQ4CSexKIWMi4OyqVICLzwqt4HeCQtJMQNosKMbVQIVHhVP/iHyzEj
         PZU/aRvCEBZ//H5GBOkjM9gftznB1cu4q4BWYIqZ6huu7KmlRX55T2HADls8sV21HA6U
         IE8abvjOoW56vycsanlLlg9YqxMr7CXzwjQHOOMFlmoWgU+WyRy0tv/FyUhDMXotYJE1
         G3kQ==
X-Gm-Message-State: AOJu0YyV+HmnUgrtw1w+v8rxAWpFitBUgHbhk5kl/upvx78wCO8MEO3i
        D2bDKQqosofHWrKPXeTgjORfqdX5Ksk54ssSU47fFw==
X-Google-Smtp-Source: AGHT+IEf2tKDzcON3NlEWW9zl7T+Ip9DEjCMzaO4XQ9afDuuBb8LKUN0p5LBxWpJxwqrynnEIc94uFQW0MlXOdgNJv4=
X-Received: by 2002:a81:b702:0:b0:5d4:7f5:cdaa with SMTP id
 v2-20020a81b702000000b005d407f5cdaamr6258004ywh.33.1701683632891; Mon, 04 Dec
 2023 01:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com> <20231128-j7200-pinctrl-s2r-v1-3-704e7dc24460@bootlin.com>
In-Reply-To: <20231128-j7200-pinctrl-s2r-v1-3-704e7dc24460@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 10:53:41 +0100
Message-ID: <CACRpkdYndEUkC7j133LVsrFXgpujwimvxGPYfDeVTRZAWsQprQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j7200: use ti,j7200-padconf compatible
To:     Thomas Richard <thomas.richard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        theo.lebrun@bootlin.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 4:35=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:

> For suspend to ram on j7200, use ti,j7200-padconf compatible to save and
> restore pinctrl contexts.
>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
