Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F24782462
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjHUHWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjHUHWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:22:39 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F8DC7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:22:12 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d73c595b558so3012623276.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692602526; x=1693207326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgI1MYhv8309+bCWxdxoJqdqvZCrtsQ/VE9m30u9HF4=;
        b=u5QT6x/FxMVr+1aoFCgsJDj0QEzfuHcrI2+VtQeO3v/dDMfnEXre6eKjslbAPuUGTR
         aDUsBu03dfbFVS8OhYUJcmZRNRxDOJQK6WxjkipX7+Fd0mFDQ5MV5BjVeGuHVtrGJNbJ
         ABD+WhvSqFyI0oNdtM/dDZBfYoqbEG8UatfAl8s4MibiV1a0vVRj7TTPWy3g6zF6Zlnv
         Hnx7JSh5IjFD1Zj9/8hUuYRLDQAMHhlxn4UXcU4/t3qc+6D+q93GHHvFJ7feucAIuzzw
         Ytn4kIvomeBgbEXGMAFSY06730ouBsxWljY/tT5fZycl1G5UNmE9iI7QTtvC2zGFK9Jf
         7sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692602526; x=1693207326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgI1MYhv8309+bCWxdxoJqdqvZCrtsQ/VE9m30u9HF4=;
        b=Gqm82gW2bBdqUn1v/e1CPm/peIem8MXh38SChgx3/oayGpyYETn0TLfiA19v0LLcSX
         9LKlVLjsQniWPZMSI5aU0+5u0YXXwBR72lMRkdTVdNKz44NQVCr10xb08ttIoc0LxNeU
         UAagQuG5svPE+iPVkNPrjIvNfWVjCvJL+e+ESQfnObA0dg+86UcVSXzrB1KQft+aYHbv
         GFc4mzk2Nx5TM/sso/ijBx7+aenvHjIqW1HHWaD4NrsNhRaMs4wyBQ5/DENYfruVSoAv
         Q+UiENqewHR5TACvmXQDgUhxRTO/UKdXI/rw7sKkgqieTFsNh2sAB4AiWo2C11u0ZQLg
         uvDg==
X-Gm-Message-State: AOJu0YylbPLmNyCEvzZ3ymEbwcBWkJq3JK2DrFD0jqa8fZYJpUBnirld
        wfMtmY31mnsdn38K+UWZydBetedcVcka9vMSC3u9tg==
X-Google-Smtp-Source: AGHT+IF/JTlr0dFi7ImP5aRW58ulW03tzkcnFFuhr9AUEC0SHkebzyrNv7zePScJNAsfPiEBnyQ9/wv9Y8G7TlIDK6A=
X-Received: by 2002:a25:abeb:0:b0:d5b:1dd9:8e3f with SMTP id
 v98-20020a25abeb000000b00d5b1dd98e3fmr6148796ybi.41.1692602526568; Mon, 21
 Aug 2023 00:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692376360.git.christophe.leroy@csgroup.eu>
 <5f671caf19be0a9bb7ea7b96a6c86381e243ca4c.1692376361.git.christophe.leroy@csgroup.eu>
 <CACRpkdamyFvzqrQ1=k04CbfEJn1azOF+yP5Ls2Qa3Ux6WGq7_A@mail.gmail.com> <fc5f1daa-58a1-fb86-65ba-c6b236051d45@csgroup.eu>
In-Reply-To: <fc5f1daa-58a1-fb86-65ba-c6b236051d45@csgroup.eu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Aug 2023 09:21:54 +0200
Message-ID: <CACRpkdaiW1QgQAjaC3hTsTjwvuWw9OUwXGsH2t3X8k+ueuBN4A@mail.gmail.com>
Subject: Re: [PATCH v4 21/28] net: wan: Add framer framework support
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

On Mon, Aug 21, 2023 at 7:19=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 20/08/2023 =C3=A0 23:06, Linus Walleij a =C3=A9crit :
> > On Fri, Aug 18, 2023 at 6:41=E2=80=AFPM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >
> >> From: Herve Codina <herve.codina@bootlin.com>
> >>
> >> A framer is a component in charge of an E1/T1 line interface.
> >> Connected usually to a TDM bus, it converts TDM frames to/from E1/T1
> >> frames. It also provides information related to the E1/T1 line.
> >>
> >> The framer framework provides a set of APIs for the framer drivers
> >> (framer provider) to create/destroy a framer and APIs for the framer
> >> users (framer consumer) to obtain a reference to the framer, and
> >> use the framer.
> >>
> >> This basic implementation provides a framer abstraction for:
> >>   - power on/off the framer
> >>   - get the framer status (line state)
> >>   - be notified on framer status changes
> >>   - get/set the framer configuration
> >>
> >> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >
> > I had these review comments, you must have missed them?
> > https://lore.kernel.org/netdev/CACRpkdZQ9_f6+9CseV1L_wGphHujFPAYXMjJfjU=
rzSZRakOBzg@mail.gmail.com/
> >
>
> As I said in the cover letter, this series only fixes critical build
> failures that happened when CONFIG_MODULES is set. The purpose was to
> allow robots to perform their job up to the end. Other feedback and
> comments will be taken into account by Herv=C3=A9 when he is back from ho=
lidays.

Ah I see. I completely missed this.

Yours,
Linus Walleij
