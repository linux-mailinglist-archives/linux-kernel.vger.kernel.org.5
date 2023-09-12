Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DBD79C819
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjILHVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjILHVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:21:46 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4853DE73
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:21:42 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d7eccc1b8c6so4981819276.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694503301; x=1695108101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2r0YpULLY6K+PxoHfEEwV/ucVHBZJ+Dpxajz81fyHs=;
        b=u2PBuX93fI2Rpasq/z7cSoNZh+orlb09Brx1ovk4kVDI2uLLcZ6d/q+593F+Y+IRxU
         P8jzoDpg+4zFMEGC46B+VDC12Rd49ozjSvr0DG1CH3IpNHQPap+UcYadbAJUQPRehGGX
         PE0RGTzRYJTky6KN2s86Ddg33YYIN4xmtQ5v/PsPs/ut0L0NJtPyouK0GDWhw/XZyKBn
         0Onis/rCaT56OSuNgFV7+akclCIiKdVZH8f1mc47hWWPnMk1wtoFj+RJqr4nerZy9JzI
         y2h+czZ7EuN2vFUsofmZs3jka7zEbdoxsduKTmg0d8c3gv2A3Pa7fxUg8cH2J9FdZy7w
         BoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503301; x=1695108101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2r0YpULLY6K+PxoHfEEwV/ucVHBZJ+Dpxajz81fyHs=;
        b=c9YeHZa/gVaJ7j1FxJViMUCL/zcvOzGOIHsjuMoESGzDed8no1t1v2CcxiSy1tf29D
         J0Q6yKpXpjlWEQOXUUQfqA1PjoygrBqwBL2ZAO5NikW7PW1SebkDR9iQxk5Ho0r94UN8
         iSnyDhQsylPNHG86Mrlt6OTuDmrgymODsIulhJSRE3ogQxKQDPqP36G3qXzQZdr0Sjb/
         l1FFlruSmxInhjpmllINLkqUU1wS7vS5t9sUxm7Dtil/tsrw0yNjuNfiL4O3tNvqXXLM
         G87ifydAkxdfqJNeI+ZmQWpyOuV3oF3EQoadp0xsAI3XlafFxDlSS6eKWBTnXYByr4ak
         ZCcA==
X-Gm-Message-State: AOJu0Yy2UyaMtQM6dmJIkyT5JlpTzoh+bkaOnSGDAukMA0WVFzGpDoET
        YkhFaE8wzy7pv9Ty4BEM/xAXZcy/U8sWOYnH0MvCWQ==
X-Google-Smtp-Source: AGHT+IGg2CzEWP667Qqfts/ono6Td0uu2ls6pFuWNKcBbheeGuby4e11KXIChG8MZ1ozsgyPMRvu62/lvBUhMk9vKbU=
X-Received: by 2002:a25:42d7:0:b0:d3b:b36f:37b1 with SMTP id
 p206-20020a2542d7000000b00d3bb36f37b1mr10652029yba.33.1694503301543; Tue, 12
 Sep 2023 00:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230830200437.715735-1-robh@kernel.org>
In-Reply-To: <20230830200437.715735-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 09:21:30 +0200
Message-ID: <CACRpkdbEcejuN64+y+s0B=jpPcHwG+0Q8ufE+0ytxqUT=3976A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: arm,integrator-ap: Fix PCI node name
To:     Rob Herring <robh@kernel.org>
Cc:     soc@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lin Yujun <linyujun809@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:05=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:

> PCI bus nodes should be named "pci":
>
> arch/arm/boot/dts/arm/integratorap.dts:161.22-206.4: Warning (pci_bridge)=
: /pciv3@62000000: node name is not "pci" or "pcie"
>
> Signed-off-by: Rob Herring <robh@kernel.org>

This was fixed during the merge window by Lin Yujun.
Thanks anyway!

Yours,
Linus Walleij
