Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9664877AFA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 04:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjHNCkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 22:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjHNCjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 22:39:37 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0E2E5C;
        Sun, 13 Aug 2023 19:39:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52557cc5e7bso1236109a12.0;
        Sun, 13 Aug 2023 19:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691980774; x=1692585574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o88IqoMul1NmqneJL1pozmAF/JAULtWS//3BlTdUYhw=;
        b=dx21bchEmSOgW5N3EaIdXyNZMMaPjqDFkAXC3jm7P2oIhejYkgnucnK+3RgO24hLQ6
         G7DVRadbYUeOpFMCJ47uxtwJkQ//MtaOsVYMbvzzfle/qUjYZR3gplWY8sQQ7yWAmEJ3
         n7AOwH6jvNVAgMtL2sMSSP/v4XGz8CfG3BJk5l2GoFeSMBWppWbJ8P/HNfIvbYyI17DA
         uNMTHQhWtBATZTt2o+3pdoCdxK/rb+0290MS5BQ2OwFwWV/i7MxIikxt3CzvGvSndqU4
         QKbkknYwg1XFltEBOLovboZsqdsZRI/9aLaqAlwInWg3sAnZX7INWlMGdu4zEDnyc93v
         3v+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691980774; x=1692585574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o88IqoMul1NmqneJL1pozmAF/JAULtWS//3BlTdUYhw=;
        b=gd1lC6b58iIX5xSeuZhOZvqNe7x3DUrm5Sk0lkUVePdASrOEEoo50keVgOexl5zysV
         Tgr3FNPjGBBYGpxzu6HRVA4dEnLwWJYeTp4wnVf8J09Ijm0c2MiAFaeN7PED33adGUKp
         2iuU9ObnDcxAZfYpwcvbLbxHSrmBr/aL3KmfRkqaYZuUBeMxH3X9gv7Gpo0AQw2/s9wv
         D50bdOVrw2JwjVBCymgvgvdBuyHTdMe17+E4MPm1AeE30XAkKbz8KvLLcPOi7RBQ4rG0
         Xc5b+jc1oFFS4JDzKXQGjPSulUAkJ+9neIC0AfY5aeuKL94jVMAaxqY4PQ3Lj8bSE1e0
         WyLg==
X-Gm-Message-State: AOJu0YwFNxxofwZ8Ij0ZIpYW1nDxC1qTHQoQQcOtN16uVWsuAMidJfBO
        9Jhii2/OTjUe2V3yXLLjTXo8XZRYE2cza0PcwMc=
X-Google-Smtp-Source: AGHT+IH5OtWDXARgolJQKyqZo0mDfZ3BN8MY79h7fU3Mkky5lG/CWHlqGHigQFgUTdawJ08wpQoU2tcutsoFIOTpQyU=
X-Received: by 2002:aa7:d84e:0:b0:523:c6fa:871d with SMTP id
 f14-20020aa7d84e000000b00523c6fa871dmr7701653eds.19.1691980774374; Sun, 13
 Aug 2023 19:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230812151135.1028780-1-keguang.zhang@gmail.com> <2ed268fd-113a-4da0-8f33-04d618053dca@lunn.ch>
In-Reply-To: <2ed268fd-113a-4da0-8f33-04d618053dca@lunn.ch>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 14 Aug 2023 10:39:18 +0800
Message-ID: <CAJhJPsWPnsPkp95G2wRfAdw6u7v9SfgqgMUUH3s+2Us2ue4F9g@mail.gmail.com>
Subject: Re: [PATCH 0/5] Move Loongson1 MAC arch-code to the driver dir
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
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

On Sun, Aug 13, 2023 at 11:24=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Sat, Aug 12, 2023 at 11:11:30PM +0800, Keguang Zhang wrote:
> > From: Kelvin Zhang <kelvin.zhang@amlogic.com>
> >
> > In order to convert Loongson1 MAC platform devices to the devicetree
> > nodes, Loongson1 MAC arch-code should be moved to the driver dir.
> >
> > In other words, this patchset is a preparation for converting
> > Loongson1 platform devices to devicetree.
>
> It is a long time since i converted an ARM system from platform data
> to DT. But what we tended to do was to allow both for a period of
> time.
>
> Does a system using platform data still work after this change? The
> first patch seems to delete a lot of code, not just move it around.
>
> Can you restructure this patchset to add the glue layer and DT binding
> in parallel with platform data. Then have a patchset which convert all
> in tree machines to using DT. And then a patchset, submitted in maybe
> 6 months time, to remove support for platform data.
>
Sure, I will keep the platform data from the next version.
Thanks!

>         Andrew



--=20
Best regards,

Keguang Zhang
