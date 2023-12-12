Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF7780F4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjLLRjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLLRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:39:22 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125469F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:39:28 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-20316647099so84181fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1702402767; x=1703007567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUNcmTOafhUTvYQgQCAZ2J3XidKSJdEQq/nWiWeUEgE=;
        b=Uahcjca7Pm5sO1adSdHjqXTnJtThnJjHeBLrMAimlYmIVG+2c27XbPPYX5mKWdj7cR
         G8+CliuYp+mTllA7GyLcztbWkHeufOcDajzRhMGxc/M2AyrGeIcs1NOHzUPjdygumhPM
         R2u9e82H4++WVPFS9rxxg5D9b8+7ocMoORY1UI0Bf17X8EChcUiBfjnQ2b2CLcrBdk2G
         BMCkjU5l1LEFKDmjlk3JC9IZu+T+JicfqJkv5DKdvIuUcipqV9UNYblCfeDkZc0zjWlC
         E1kKDeylDS8YfBNaK+W6S6ByxuMg7wJlJ5S0y96Ryfk+xkJ+6hxE9HvbThLnkZluZ8G7
         h85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402767; x=1703007567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUNcmTOafhUTvYQgQCAZ2J3XidKSJdEQq/nWiWeUEgE=;
        b=fGVhNE0IDRXY/uL8T/v8cUwn5lhPgbJaC85A1Uh/FH7abcHB2+93hE58/znfL/qfcG
         uBqUdSPU1rM67nfe2Jpoa4aQ+Z1Er8fBI9RHRy++fnGZ6vV4CcLPPe9ZamFzEaiWpz55
         lAoKiXsH8mMMif9WXn/Cl4cv+eaI8HWrKLhw8Yf2sM2oPpoyt/Eaa+n9Q7XZ9DqoElkr
         SsMCxohSV2KyGFEEZoa+/kw3VA+kUVr+kp067v4kr0mYJ1mhCYTr6ZXpxV0OASeA0STI
         LoxHyaqQpsA9nuI8y4HgMlVVZhx0EI2s0hxAzAnnaaHw6/AcEN6n0F3v0rKlAR//bXjK
         j9YA==
X-Gm-Message-State: AOJu0Yxd5CU/h7hZJj6PREJT5bf1v/j1mBP2/IA4gXiFrzVs6iRB4HfS
        UiwmkvlaTR35Jdp1Ryw+p/lM47m4G27TL5t3MC/F7J7W0DQEopWh
X-Google-Smtp-Source: AGHT+IH8FppDOJz1c2vNZhu2IoyiV03XlApPbOHQwSfNyieubu2559mIvdKWWArZPTLxB5xikCyyW94EFosm8JLdBec=
X-Received: by 2002:a05:6870:659e:b0:1fb:3741:4dc5 with SMTP id
 fp30-20020a056870659e00b001fb37414dc5mr8515512oab.34.1702402766687; Tue, 12
 Dec 2023 09:39:26 -0800 (PST)
MIME-Version: 1.0
References: <20231212141200.62579-1-eichest@gmail.com> <20231212170704.74565969@device.home>
In-Reply-To: <20231212170704.74565969@device.home>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 12 Dec 2023 18:39:14 +0100
Message-ID: <CAPv3WKfY2ATjPPV=yFQNUE=dV4wpyV3d0cQNBGOuSPb+id=mvw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: mvpp2: add support for mii
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Stefan Eichenberger <eichest@gmail.com>, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

wt., 12 gru 2023 o 17:07 Maxime Chevallier
<maxime.chevallier@bootlin.com> napisa=C5=82(a):
>
> Hi Stefan,
>
> On Tue, 12 Dec 2023 15:12:00 +0100
> Stefan Eichenberger <eichest@gmail.com> wrote:
>
> > Currently, mvpp2 only supports RGMII. This commit adds support for MII.
> > The description in Marvell's functional specification seems to be wrong=
.
> > To enable MII, we need to set GENCONF_CTRL0_PORT3_RGMII, while for RGMI=
I
> > we need to clear it. This is also how U-Boot handles it.
> >
> > Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

LGTM, as well.
Reviewed-by: Marcin Wojtas <mw@semihalf.com>

Best regards,
Marcin
