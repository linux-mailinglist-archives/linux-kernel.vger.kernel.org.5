Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA95C7AD914
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjIYN2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjIYN2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:28:13 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCB6B8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:28:06 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59c0a7d54bdso75861537b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695648485; x=1696253285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZknO15oVls1exzOXk3a1gfVWqzfAFBCtfmB4d9YaDI=;
        b=CjaNwOUgaN9kphDDqfk+caA5xvxe9EaF3mujwBMbNVVB0gOoN5JMGviiz98SM+nqvH
         tpd5sJdMtI9zKP0ULZycP90Apv7ykDhUNSFoEJwMRTO9hiMHjHVdbSSX62cJMhIyTymO
         A7ViWfVrjb2HTxjcxXHvrCcyMbow76WRI5HF/F2Yu4pf3R9L1Z4xq8njlD3VK3FAvWlT
         a67959d7nWPHnoc+66f38pPL+L5U5bNSt+OBNSL0BwsX2Sx4xzz1bM95EnJ1d2KemhTF
         4BK7ldzmQQqixHlTFHoXBmDz4+lhu6SqIBqiQAaMOLYPw4O5KkmrwaYOyTZGlqz+I84h
         4UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695648485; x=1696253285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZknO15oVls1exzOXk3a1gfVWqzfAFBCtfmB4d9YaDI=;
        b=AJycjqsMQtl8ryFo7jvm71h/V9dLxe7oAmhcA8uM3kbitvS8jSvAYEtoQHQrMW63eD
         OEfMrurga6uA+A46WHErmQ3Vr7zq9hlD7M1FK3MRVTbLBNQAgc/yP1EugnbD39WPNQXO
         xwhdd/8DHUzgoMgyiPd0a2NPptQ1ntsuti0lywuOZMfOGOaDW5IzC5TYeD+VuNUdDlKa
         cabtFQG80xnIg1M2kwxZGFySpPkXAbtmuCRfintmKd5+OTq4jOeSijZ0u7zZ9Lv1LciE
         JhNVk/CCxOw67XJNhOOqBm2Ul+GvsG6Q+iAirHi4R5LNsGHxXR0MCfDtc85VtRlYh10k
         c+hQ==
X-Gm-Message-State: AOJu0YxTDbU9fl/2xV8ubPVm3rC0PwEOxN2yGROqXWl5+shrxHHgi18s
        47HpBcqxkxXPW7fvCVabXz0JbHm5b1VyxPcxTi3kSg==
X-Google-Smtp-Source: AGHT+IGM7YPpQZLlMQolSiJosvS1gnpdsPSQVS9F7veXMpyagz9PcCbXUT5Cp+eVJ/Vi8PV88//TltYGmv0SU/0+xwA=
X-Received: by 2002:a25:c804:0:b0:d74:6cdc:290d with SMTP id
 y4-20020a25c804000000b00d746cdc290dmr5021839ybf.36.1695648485671; Mon, 25 Sep
 2023 06:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230916081615.4237-1-iuncuim@gmail.com>
In-Reply-To: <20230916081615.4237-1-iuncuim@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Sep 2023 15:27:54 +0200
Message-ID: <CACRpkdZeDpyy812ijbKr2gC5zfhDSuEPHydrCNpRyUnRW1QpWA@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: sunxi: h616: add extra gpio banks
To:     Mikhail Kalashnikov <iuncuim@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Sat, Sep 16, 2023 at 10:16=E2=80=AFAM Mikhail Kalashnikov <iuncuim@gmail=
.com> wrote:

> From: iuncuim <iuncuim@gmail.com>
>
> Some SoCs from the H616 family (such as the T507) have the same die but
> more output pins that are used for additional peripherals. The T507 SoC
> don't have a built-in multiphy like the AC200 or AC300 connected to the
> bank A. With the T507 these pins can be freely used for any other applica=
tion.
> This patch adds the missing muxes on banks A, D and E.
>
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>

Patch applied, fixed up the commit message in the process,
thanks!

Yours,
Linus Walleij
