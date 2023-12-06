Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3D806911
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377062AbjLFICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFICg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:02:36 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6E18D;
        Wed,  6 Dec 2023 00:02:42 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9f62fca3bso50544471fa.0;
        Wed, 06 Dec 2023 00:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701849761; x=1702454561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nps3x3kXECpjSVN0GJfWfEZC0kLw3Q0hQaPDM6Qseb4=;
        b=S6gOLeiCG3lV8U4MLoPRL4s9QHCpm9JdvtL/Q1i0ycP6ZcGsHq8hNGkwWfwjih1uc0
         dvil3i53XzE0ILLRWbUZsXJlGN6uCVrRIGc6CenlW9LEUJPTdv0tmeEawPw/9KwfhHbq
         gOKudisppw8uoDaZPfUBsIxN+tvZ2Za9JftHSk7ZSVSQqKFSeD0eqn/ht7YaNKp/ms2q
         NNWR/OTw23oSpbO8twJQVXKhkEjPMLiieQlsisWsLFJoLfSrJzH7KBCeldQdel8PgMhQ
         IpPnS7D7rlGCDJLSyhHWqyQsp+YyHkVoupl3a1aERdGyMHNqtyY7Af1T5bieP5k85lfC
         +CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701849761; x=1702454561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nps3x3kXECpjSVN0GJfWfEZC0kLw3Q0hQaPDM6Qseb4=;
        b=GT/ncshmoEA5MQQ/9WnkL2bbGgbx5mLSt5SpuUU0tj4p/ferA+8dXbghH7SEs+yOrO
         OTZ1NrW81cfq5IZ6vR4q/zF69SPPIp5RHKZI1xWXu7Zh3eg2Q5zg5dZwucGL8/rjcSoJ
         NTidzXTRPQFw2AeSLzLTSf0q19nXAhqiK0WdxZMkhgXFTQQs6ifHFdDeL3U6uNkR9aSF
         HJfbfxFQ37MEZ5ucCCi1FgiMhxcOtvA+5QQFxu1Dh+fV+Uk1eBvMB2kx8K4EB+WAYeHs
         obRkB5+JnjByRNXGc0d8InCx5sjaPP9W6Ws3gqJcLwoYLpxfavW2GtpylHHNeYHQMEhH
         QPeA==
X-Gm-Message-State: AOJu0Yx80jJPQmdtQ/NrCiIoPCgrUqLFVeYvk8C88voZiWsEHXAYCaWr
        QPWJ5ys4PTgLrrlp47AofcPBbq0K55gVLcvAzRstAH9Etqw=
X-Google-Smtp-Source: AGHT+IHepnuvogKeLi3oXX5pEqb3kASsZ0KDKo1NHGVo8loC0doBaghpwlYGO8VTYCWzkPsnvUV3vmduSIH9LUGNyhM=
X-Received: by 2002:a2e:9250:0:b0:2c9:ee72:f2d9 with SMTP id
 v16-20020a2e9250000000b002c9ee72f2d9mr294304ljg.2.1701849760578; Wed, 06 Dec
 2023 00:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20231205074723.3546295-1-chou.cosmo@gmail.com>
 <20231205074723.3546295-3-chou.cosmo@gmail.com> <20231205-moneyless-hash-202129b0c636@spud>
In-Reply-To: <20231205-moneyless-hash-202129b0c636@spud>
From:   Cosmo Chou <chou.cosmo@gmail.com>
Date:   Wed, 6 Dec 2023 16:02:28 +0800
Message-ID: <CAOeEDyv4G8H3-d8aFewkfsx8fCFiRsBMp+bD7nUirJ-YY4Gi8g@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: hwmon: pt516xx: add bindings
To:     Conor Dooley <conor@kernel.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, heiko@sntech.de, jernej.skrabec@gmail.com,
        macromorgan@hotmail.com, linus.walleij@linaro.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        cosmo.chou@quantatw.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK. I will change to trivial-devices.yaml.

Thanks
Cosmo
On Tue, 5 Dec 2023 16:46:42 +0000, Conor Dooley <conor@kernel.org> wrote:
>
> On Tue, Dec 05, 2023 at 03:47:22PM +0800, Cosmo Chou wrote:
> > Add dt-bindings for pt516xx temperature monitor.
> >
> > Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
>
> This can just go into trivial-devices.yaml, no?
>
> Thanks,
> Conor.
>
> > ---
> >  .../bindings/hwmon/asteralabs,pt516xx.yaml    | 36 +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/asteralabs,pt516xx.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/asteralabs,pt516xx.yaml b/Documentation/devicetree/bindings/hwmon/asteralabs,pt516xx.yaml
> > new file mode 100644
> > index 000000000000..5700d4c91a0d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hwmon/asteralabs,pt516xx.yaml
> > @@ -0,0 +1,36 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hwmon/asteralabs,pt516xx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PT5161L hwmon sensor
> > +
> > +maintainers:
> > +  - Cosmo Chou <cosmo.chou@quantatw.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - asteralabs,pt5161l
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    i2c {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      sensor@24 {
> > +        compatible = "asteralabs,pt5161l";
> > +        reg = <0x24>;
> > +      };
> > +    };
> > --
> > 2.34.1
> >
