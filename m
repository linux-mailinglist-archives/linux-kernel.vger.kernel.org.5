Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4604F7725F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjHGNiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjHGNh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:37:56 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D8010D4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:37:55 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so3720009276.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691415474; x=1692020274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whejdASkJGYmLZxS+FlOqF2f/J1Rdm5EDe6V5ST3LuQ=;
        b=gZ+36WDDT3vFYnLcSlRKa/NuShCqLSSyXuRIKuBCcK2PB75SwhpLFE5DGSxZtR3+GQ
         MWZ9PJtesN4mNZjrT3daZc6cH+e6gL+BYTJKIjTCg4n1uJf1Qe/y/4FDjHr19M2fiDXw
         btkW4xbEeiAXJuuLmeNCwl4FV89XQRUsnGARA2nH2TkNpUwOFAWQXPzuZIM7YNjPS0Sp
         9+apZXATVERqCRT4T+sJcS7UArh2Kzsq8gcplqQxBivztk9N5AvMLC5hFea2wA6Q4vXO
         dHK5qEpjuCPIjMHzBqgUoiYsPkyBk2sf5uPz6/tSmJkg8yqAK7fkhNXcjLPZhlVx/lFh
         UUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691415474; x=1692020274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whejdASkJGYmLZxS+FlOqF2f/J1Rdm5EDe6V5ST3LuQ=;
        b=CGBLlbzH5Tx/5Myshn05AIfvuwweCoiEHRKZitIsm7VNxKy4jtziigVdYLnEyBN8xH
         N1zwxOXr52t9B8ISoVNZ98VpUQX9Uqg4lCf2mIBpZ3YHu6UoF/Hhq5ZYAC2lRkz28Hef
         vhFSUH4H9Qi6JVXkAl7bL+twYj7S62bt46SB478KZj+Ga/9XlRcMyl6H/2cR5bpsi6iZ
         H5HwwEd2Bwr6pKiNGVA9AVSnhgE/ggnvRSMfPRG0E7Xw+qhmCktHVx9aIyiYmzHHCPG+
         NdQsFDRDgSClqvJpQvH8kAkD0YEVGz6JGG3tGAu4433nambyVQQaXMFjAm2vQoZ3Pyrc
         doMg==
X-Gm-Message-State: AOJu0YxPW3oX/lE02RGGe+V4tODhaivIUTdR0bJEfGtdHgQ8zKZHIDar
        hno8zW3SpQQyH3UUQ4e9APZspKlC7PjkoQ8Xsl569A==
X-Google-Smtp-Source: AGHT+IF8qFOkXRjcLVqPSJs0Dcjy+XexfZt9JpoPqlbfN68UupareNNAKBdj08K5cz1GN8sYL8dyB/+6maviIRw0lVg=
X-Received: by 2002:a25:4256:0:b0:d0a:fa7f:2fbf with SMTP id
 p83-20020a254256000000b00d0afa7f2fbfmr7826923yba.48.1691415474298; Mon, 07
 Aug 2023 06:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230724060108.1403662-1-huqiang.qin@amlogic.com>
In-Reply-To: <20230724060108.1403662-1-huqiang.qin@amlogic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Aug 2023 15:37:43 +0200
Message-ID: <CACRpkdafAWgt9A8km1zLZF9UawXkdqBOEVnMHiRjaF=2SeyhgA@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] Add binding header file for GPIO interrupt of
 Amlogic Meson-G12A
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 8:02=E2=80=AFAM Huqiang Qin <huqiang.qin@amlogic.co=
m> wrote:

> After adding this binding header file, you can intuitively find
> the interrupt number corresponding to each GPIO, and apply it
> in the format of IRQID_XXX where it needs to be used.
(...)

> Huqiang Qin (3):
>   dt-bindings: interrupt-controller: Add header file for Amlogic
>     Meson-G12A SoCs
>   pinctrl: Replace the IRQ number in the driver with the IRQID macro
>     definition
>   arm64: dts: Replace the IRQ number with the IRQID macro definition

Neil wrote:
> What's the best way to apply this patchset ?

I just applied all three to the pin control tree.

I could have applied just the two first and then offered an
immutable branch. But eh... too much work for too low risk.
Better to just apply it and hope all works out. If it explodes
I just back out and figure something like the above.

Yours,
Linus Walleij
