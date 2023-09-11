Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F3079BE41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjIKWPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244204AbjIKThJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:37:09 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1DB12A;
        Mon, 11 Sep 2023 12:37:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so79331141fa.0;
        Mon, 11 Sep 2023 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694461022; x=1695065822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtHFkIB4HjNpruap74rc4M+x6RD0lNjgWaeMc48DnVQ=;
        b=RYAdqzSwjA0vXLzI3rZNNLL4KCYHTAHIeYRfpWdCJu63dUoVm6o3krh88pduVUNn61
         y1IwaQ+okTDekJQ6k+cTQfuHS/vokebki+R3dLwSTBnRoDEmg1CHaNGNf5NQRyJQ2mJo
         FZaa8OsklGbHt82x9/m7asFqgSP19t8buxTkTmXQ5jpftTS6EpCoyNPKTwB/KWX0DgYY
         QGzMtHUfGtb2UtqEIFZnAX19CIZxE+DqHfDTMrXa3+Qc8mTj7OrmhBUNy1QVXpaY1cVZ
         EUPZNjpwJaVKiPmXyYvYPUSnvWc9L63prLf2+v4JvaC7vk7kMmVYzPls6SlZ2F7zFgO3
         puZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461022; x=1695065822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtHFkIB4HjNpruap74rc4M+x6RD0lNjgWaeMc48DnVQ=;
        b=mFg343KDZOAIWdS+XegH3w6JWq+wO4ObzLpabNoCg++S0cMBCUPgLS/Z2pUma8Roaz
         x/gcJegtI6WXzwzebzIJ8qnPFQ+Oabm6vylyCmlSILVk2Zxr3VO7vy0088G8QRdTMpGQ
         78AnPKPoZhEc2PabJ0Q5ZYz3hah/+4cimc9L3vQnlUajJmAeS7zppze0Sv1FAcz9R64N
         UNm6lKnD11wqL25an6q92YJxl5KzxNQP1LcT3NOeuEtvmZ8IAmv8rhFGj3501HVgZnj/
         nxdDxrKMGZ3MW0vCteEWdIPggX8R+WLQEixEm0DryRtVYKiwaY8Pj85e5tSsrWIkSkPW
         r0xQ==
X-Gm-Message-State: AOJu0Yz+L9sonq7qoqrZtUv5X3h00O/PrTKI1PdIufZ8SN8pgBoOzJb2
        X0V7+y4xwMvt1MScjVMT2G9aqAbM+iMAr8qyotk=
X-Google-Smtp-Source: AGHT+IEHONmFCXlIl8CtsQ1p//AgYvzN0oFymF5kb+m/A+LqIbbN2JHzQ3n/Wj2UhSy7rLEgh8So+tK68vdnGyP+3QY=
X-Received: by 2002:a2e:8297:0:b0:2bc:e330:660b with SMTP id
 y23-20020a2e8297000000b002bce330660bmr9020360ljg.9.1694461022242; Mon, 11 Sep
 2023 12:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230828140849.21724-1-tmaimon77@gmail.com> <CACRpkdY0C7S_VjZ8CKxj9MOv401jUPesvwKwHyCfHM+p8jRSOg@mail.gmail.com>
In-Reply-To: <CACRpkdY0C7S_VjZ8CKxj9MOv401jUPesvwKwHyCfHM+p8jRSOg@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 11 Sep 2023 22:36:50 +0300
Message-ID: <CAP6Zq1gd7j7c3RuB+E4S65JNhOmEEZOMgn2AqXwO29f=BRKXzA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] pinctrl: nuvoton: add pinmux and GPIO driver for NPCM8XX
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot Linus
appreciate it :-)

On Mon, 11 Sept 2023 at 16:53, Linus Walleij <linus.walleij@linaro.org> wro=
te:
>
> On Mon, Aug 28, 2023 at 4:08=E2=80=AFPM Tomer Maimon <tmaimon77@gmail.com=
> wrote:
>
> > This patch set adds pinmux and GPIO controller for the Arbel NPCM8XX
> > Baseboard Management Controller (BMC).
>
> Patches applied. I can send some more nitpicky comments about
> patch 2/2 but they are not serious enough to warrant a resend of the
> patches, it is better to touch it up in-tree, if at all.
>
> Good work with this driver, and also good patience since you
> iterated 7 versions and polished everything up so it's really nice
> and shiny now!
>
> Yours,
> Linus Walleij
