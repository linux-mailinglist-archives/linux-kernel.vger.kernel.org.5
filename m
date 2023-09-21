Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1877AA56B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjIUXBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjIUXBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:01:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DA488AE3;
        Thu, 21 Sep 2023 10:39:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c3d6d88231so10219145ad.0;
        Thu, 21 Sep 2023 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317963; x=1695922763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAmdVadS4jiR5GzblmwpxzkMv/YPmugIu95wefEmcJc=;
        b=FnSzQvM1ECHLbCrxQ319md6GnA2+8/Yq0K9YRkxDA4xTzQx3dRkhVn7rREFKt28QQl
         Mms1CftpqtZCkVnVVwGmEN+h2AWGHRgI6nQ26gaff3FcAJjYtFLcMf6rZkJ5c12QhVYu
         nSXjvLzJ0PpkmqAfM4AINhTiTk8QjtXHSOmt2bm5Wv4+wnJOO0Wgoav5NEN9ugaawj/v
         WjsUb8+zaFKzIAONgLfVJsFwmqTwfmxWwybmk2+y1narYQsGfumAe3ZNBomuOdjUQJ7q
         pZJZb+YjwbzHmbCDCdVgnCFNFGyryd2NGKEED6ucSSHtBfzuZr+kQrExXwcJHM66IsFV
         T+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317963; x=1695922763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAmdVadS4jiR5GzblmwpxzkMv/YPmugIu95wefEmcJc=;
        b=FkVehBGiZpblQEdXTXyhDz78PcdTVDE+V4Z5Hpnasw3nWGRQShBKaGkX0dIegTKk7u
         85Gc5x/v5yCDasG7fruqy8Pwc8HZ1wFI5Zc9rkdt/eT5Q1DMQX7Wx40xgJcj5CHIGS11
         2gHx+ka01WW9ztMXyNsjah9mNWrncIk6YyKkgsvD/EO9NzmkrimPkqAaNxn5YalVuZ2s
         sB1lYvEmXrUC/0c+gIIG3XZz9hfJ0i/DFpKaM1vjR0iGUe0ryzOLyxRwioVioD+22DvB
         jombFE117zKWICKBNkXXeQ7dJVtWD5aq1gPykALe5NrpDevpJL2tWkeVUWPw42hfvVtO
         owaQ==
X-Gm-Message-State: AOJu0YwYMbIUNSZ0Aa+HnQmxqxPuFb5tlyaJqiNlWK77HxaC3uJF7UDM
        PdPeqdN4c27/9962n4sgfzte6w4cHzxKw1IGbPcKfQ3x/mY=
X-Google-Smtp-Source: AGHT+IHrZ874aKkUdfbv776TdxNWdIdVUn21Sf0N7vEUuJLhyrWz1QRiMxsOlbMIKfFPGhrHtZ1SgEc8c+fptK2rbDA=
X-Received: by 2002:a05:6214:249:b0:64f:67ae:a132 with SMTP id
 k9-20020a056214024900b0064f67aea132mr4510858qvt.23.1695291679027; Thu, 21 Sep
 2023 03:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <c6aea83bb1df563b1f2a66c5f230c3861aed1e15.1695189879.git.wangchen20@iscas.ac.cn>
 <20230920-arrival-bonanza-e335686420f4@wendy>
In-Reply-To: <20230920-arrival-bonanza-e335686420f4@wendy>
From:   Chen Wang <unicornxw@gmail.com>
Date:   Thu, 21 Sep 2023 18:21:08 +0800
Message-ID: <CAHAQgRDh72FLQPOFzn2rhsWmOOaLUO0sKyJwJQBG0Z7qZN_YLw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] dt-bindings: riscv: add sophgo sg2042 bindings
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regards,

unicornx

Conor Dooley <conor.dooley@microchip.com> =E4=BA=8E2023=E5=B9=B49=E6=9C=882=
0=E6=97=A5=E5=91=A8=E4=B8=89 16:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Yo,
>
> On Wed, Sep 20, 2023 at 02:37:51PM +0800, Chen Wang wrote:
> > Add DT binding documentation for the Sophgo SG2042 Soc [1] and the
> > Milk-V Pioneer board [2].
> >
> > [1]: https://en.sophgo.com/product/introduce/sg2042.html
> > [2]: https://milkv.io/pioneer
>
> Again, link tags please.
>
> > Acked-by: Chao Wei <chao.wei@sophgo.com>
> > Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> > ---
> >  .../devicetree/bindings/riscv/sophgo.yaml     | 28 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 +++++
> >  2 files changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/sophgo.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Docu=
mentation/devicetree/bindings/riscv/sophgo.yaml
> > new file mode 100644
> > index 000000000000..82468ae915db
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> > @@ -0,0 +1,28 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/sophgo.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo SoC-based boards
> > +
> > +maintainers:
> > +  - Chao Wei <chao.wei@sophgo.com>
> > +  - Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > +
> > +description:
> > +  Sophgo SoC-based boards
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - milkv,pioneer
> > +          - const: sophgo,sg2042
> > +
> > +additionalProperties: true
> > +
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 90f13281d297..b74d505003e2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20063,6 +20063,13 @@ F:   drivers/char/sonypi.c
> >  F:   drivers/platform/x86/sony-laptop.c
> >  F:   include/linux/sony-laptop.h
> >
> > +SOPHGO DEVICETREES
> > +M:   Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > +M:   Chao Wei <chao.wei@sophgo.com>
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/riscv/sophgo.yaml
>
> > +F:   arch/riscv/boot/dts/sophgo/
>
> Firstly, this directory does not exist at the time of this patch, so it
> should not be added here, but rather at the time that you create it.
>
> Secondly, are Xiaoguang Xing and Chao Wei going to monitor the lists &
> apply patches for these files? If so, you should add a git tree here
> that they will apply patches to & add to linux-next. Also, I'd really
> like to see some on-list signs of life from these people, otherwise
> I'd rather see your name here instead of theirs.
>
> If they don't intend reviewing/testing/applying patches, I can do it as
> a last resort but I would rather that someone who specifically cares for
> this hardware does it.
>
> Thanks,
> Conor.
>

Hi, Conor:
Please allow me to explain first. As a community volunteer, I actually
had full discussions and testing with Sophgo people when submitting
patches, so I added tag such "Acked-by: Xiaoguang Xing ..." to the
signature part of most patches. Also if you think a formal email is
required, I will talk them to send it.

As for the issue of MAINTAINERS, I discussed it with the people from
Sophgo. They (including me also) feel that we are not very familiar
with the community process (especially as maintainer, and actually I
modify the file MAINTAINERS is just to suppress warning information
when running checkpatch.pl), so we sincerely hope to invite you, Mr.
Conor, to help us for a period of time on maintenance work, including
checking relevant patches, merging and submitting PRs, we will learn
together with you for a while, and then take over this part of the
work when we become familiar with it. We know that you are also very
busy at work, especially if you don't have the hardware at hand. I
have the hardware here and I can take the responsibility to run
testing. What do you think? I'm waiting for your reply. Thanks in
advance.

> > +
> >  SOUND
> >  M:   Jaroslav Kysela <perex@perex.cz>
> >  M:   Takashi Iwai <tiwai@suse.com>
> > --
> > 2.25.1
> >
