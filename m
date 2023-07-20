Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9D75B3EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjGTQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGTQMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:12:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA1AE44;
        Thu, 20 Jul 2023 09:12:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-992b27e1c55so163038066b.2;
        Thu, 20 Jul 2023 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689869522; x=1690474322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0nrbQn1sFt+hrc37Tnt0J9Wx46AspN3f8YZCBPziq4=;
        b=p7hIaMOMHLK0Suqn6HH3aXxki2zzGmkbWsJUlNcpr2DA22XWi9uv87SMXBTs24xDuN
         tNA8wvxpZvToGcCci2SeC4oSXs4WHzj+tN7tMkaItJE1hG85eEeLk3XLDmt1bVZwP8Cp
         JkVe3h5rFu75qKDZWocdshcQI327qC5ykZMETMADbUEIq4QtBQTQdaQTXeT0eszld5PC
         exJ2wwlgW23rc4ybLqutmm2n4kOOX/J/giglcQzSMeFsITJiJTRPKUZw2WSbiIrzHTd/
         3uDKWSpmxtyKMoT68ttd8HVwMvVPCO9yI/5cd1kv7rpYafwBKU4Eq6ftgH6sy12B+sxV
         IWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869522; x=1690474322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0nrbQn1sFt+hrc37Tnt0J9Wx46AspN3f8YZCBPziq4=;
        b=Stbl97Kov98ro1pLyCERqAMJvQFjvXh3D13oItzREjRa4wUzVNe5a/KaAKeQ6E/Iek
         StNLLxu6uvB5AW8AfBqTzvK09+bCPBEc7cLwbwXZVPO7MeLGuwDEU8IfZpWueAGWkE3Z
         33GARKZzuk6xIO5YcAlSK0WJQeLpHbaB2vn/pKAL6NeT5hpnFOzTDZNmIHDC6lMOpCwA
         oURg8511kmTgdeyMPBCb9eOK0ZOqKGEHAvK0lKlJ+Oqve0GYHyQcXZeU/ppNE1MuZMEj
         zYx+4gArAo+HmPOp8lECdT2mzDs+IFn6mj6JexAokmMSHq6h0/cqqxs2INXZNvn9YYwU
         XgCg==
X-Gm-Message-State: ABy/qLZdrOqPjIllegvO4miQCVlPljZ6fx9fB/RJ1DaNigZSK1+26KFO
        FOc25C4AZ/6UeR4h58oBj8BeXmOuu2KnRnXB6Pw=
X-Google-Smtp-Source: APBJJlEnUEKc1nZ6g4LU0MLJRu8qBi9abiNe++BWYtu6/abRbCIn/YlRMjBaWCk6kGuncCaVmTrbpS+6zKjnHlyhDA4=
X-Received: by 2002:a17:906:d7:b0:993:d617:bdc5 with SMTP id
 23-20020a17090600d700b00993d617bdc5mr2870468eji.37.1689869522220; Thu, 20 Jul
 2023 09:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <43109a0f2f362222fca79e2afd15c46ed9a32977.1686063941.git.oleksii_moisieiev@epam.com>
 <ZIAxLdexyKBnMOmU@surfacebook> <87sf9ihfc7.fsf@epam.com>
In-Reply-To: <87sf9ihfc7.fsf@epam.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Jul 2023 19:11:25 +0300
Message-ID: <CAHp75Vf+H_wnhT=2w=A9M7wFeOkf_m1M1gmL9vd8WHNid7+YBg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 4:40=E2=80=AFPM Oleksii Moisieiev
<Oleksii_Moisieiev@epam.com> wrote:
> andy.shevchenko@gmail.com writes:
> > Tue, Jun 06, 2023 at 04:22:28PM +0000, Oleksii Moisieiev kirjoitti:

...

> >> +    devm_kfree(pmx->dev, pmx->functions[selector].groups);
> >
> > Red Flag. Please, elaborate.
>
> Thank you for the review.
> I did some research regarding this and now I'm confused. Could you
> please explain to me why it's a red flag?
> IIUC devm_alloc/free functions are the calls to the resource-managed
> alloc/free command, which is bound to the device.
> pinctrl-scmi driver does devm_pinctrl_register_and_init which does
> devres_alloc and doesn't open devres_group like
> scmi_alloc_init_protocol_instance (thanks to Cristian detailed
> explanation).
>
> As was mentioned in Documentation/driver-api/driver-model/devres.rst:
>
> ```
> No matter what, all devres entries are released on driver detach.  On
> release, the associated release function is invoked and then the
> devres entry is freed.
> ```

Precisely. So, why do you intervene in this?

> Also there is devm_pinctrl_get call listed in the managed interfaces.
>
> My understanding is that all resources, bound to the particular device
> will be freed on driver detach.
>
> Also I found some examples of using devm_alloc/free like from dt_node_to_=
map
> call in pinctrl-simple.c driver.
>
> I agree that I need to implement .remove callback with proper cleanup,
> but why can't I use devm_* here?

You can use devm_*(), but what's the point if you call release
yourself? That's quite a red flag usually shows a bigger issue
(misunderstanding of the objects lifetimes and their interaction).

> Maybe I've misunderstood your point.

--=20
With Best Regards,
Andy Shevchenko
