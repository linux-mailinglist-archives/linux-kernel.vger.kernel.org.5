Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BB5800873
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378305AbjLAKiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378266AbjLAKiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:38:06 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9352712A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:38:11 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4644f2e611bso662353137.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 02:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701427090; x=1702031890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTTB5Qf3NGi+WB3GCJHG37DhU59Gl9ODLb3haNT1v/c=;
        b=kEJAUXezhcezJLZxMjtGjmmwIBcxqs+4A2DBK2At1NFG4VXACwh4I+X4Z5X6yja1lJ
         F2ESnvA0dnxy2jC87uy7dPz+HuVPHbcQLwsthM/Jjh13zRLzl+7WXan2CNE2w0aTDOX6
         2NVQENlG5BJw6FwWlmt2fkbh5kHFVpn8HOrrbzlTkxVX4P/TjecdWGfE3PB533uF++7H
         Sj7TIgNjvdESagMEbr41pg38lJ3JiC5rLFZj5Eg4dRm4Ez01/9rHHQdUO/gOb7My+ja6
         OuvuwWLdPBW3eWljkWFFNO/5gNi5S9rOv8cSTXx5d68se+xwosg0JzDSgEI9QMT9uJnz
         q4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701427090; x=1702031890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTTB5Qf3NGi+WB3GCJHG37DhU59Gl9ODLb3haNT1v/c=;
        b=TsX93OOmSniOzTwI5iczNK3bV1cEObNLMdT7HorgWaREiHto8r9LAEmMnSeM8tdHMp
         GBe39Zq685aXZMtNG32QN2tAaejamcxAgSloCr51A8U1Oxxy0ztRRk+PKd174FoEgM/x
         i1Skfe2i3ooxaegU+XhXHmyNmVJurRP2H4BxJu4K46zuycb2Wz8Ihb4MshMHLIK+Yhw9
         1CY4otvVODRII5pJeq73Iw8AaSwoiGRQqe/xOxDxgjcxVo7JK7mi6VVQblTeXaB6PTpj
         azG+Ebh910L+0HY8mb02QqazWHHfibrcjMwjlppx4QR52/TS93upr0vXToG4ocB0egvi
         0DYg==
X-Gm-Message-State: AOJu0Yz+tcUC+YkK74ilHNy9RiPQLZ98T6Syk8hbyi6VWZ/7DVnWB0PG
        6JjU72ag7HDFdECWjpY0PR9spd6kWdiJVxSxArBYchAZWYlVymWH
X-Google-Smtp-Source: AGHT+IHD3C4jeU8YUMrsywQzBJT50HuwUQ8yJRyHKKpw9tFA3HPIcqu/SHTN20FoIPSzlf2zVyUp/WJHxr0sgyP3xm4=
X-Received: by 2002:a67:bc19:0:b0:464:4891:cce4 with SMTP id
 t25-20020a67bc19000000b004644891cce4mr8735525vsn.20.1701427090706; Fri, 01
 Dec 2023 02:38:10 -0800 (PST)
MIME-Version: 1.0
References: <10db3021e8617c1f98eca51e26d350dc4b51b53c.1701335736.git.michal.simek@amd.com>
In-Reply-To: <10db3021e8617c1f98eca51e26d350dc4b51b53c.1701335736.git.michal.simek@amd.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Dec 2023 11:37:59 +0100
Message-ID: <CAMRc=Md7iQnkOp+nB3=haakpt5jF_STtYgDAcxRVQJjYWnjFKA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: modepin: Describe label property
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Andy Shevchenko <andy@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:15=E2=80=AFAM Michal Simek <michal.simek@amd.com=
> wrote:
>
> Describe optional label property which can be used for better gpio
> identification.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  .../devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml     | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-mode=
pin.yaml b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.=
yaml
> index 56143f1fe84a..b1fd632718d4 100644
> --- a/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yam=
l
> +++ b/Documentation/devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yam=
l
> @@ -23,6 +23,8 @@ properties:
>    "#gpio-cells":
>      const: 2
>
> +  label: true
> +
>  required:
>    - compatible
>    - gpio-controller
> @@ -37,6 +39,7 @@ examples:
>              compatible =3D "xlnx,zynqmp-gpio-modepin";
>              gpio-controller;
>              #gpio-cells =3D <2>;
> +            label =3D "modepin";
>          };
>      };
>
> --
> 2.36.1
>

Applied, thanks!

Bart
