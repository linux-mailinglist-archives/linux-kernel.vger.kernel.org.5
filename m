Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695397EF8D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjKQUpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQUpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:45:12 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA69D72
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:45:06 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so30680501fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700253905; x=1700858705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSNFX2xgBRNTvwuhJ0I7igrYtExQWX8lNq71/XrSzzU=;
        b=TTviavqp/wFo0etkomAdEiON0ayJHBCOAcSLLJoj04B+gGhUVGFSxl0qGMLnE0y8n4
         nLza4Izcoob2gJMbleLimEbJMenEOeODc0ZkEjMWMZ7E6DXJiVUrWZp5b1WNqFCSipr8
         v4nEFVj5UbzKGdmBfNAFHK8ExHJSlsMf7fOhgmnAsPpfpgapQ8hUtNH5sK8kI+V802+o
         wXM+A4Mhpkzm5FbveUB3uxEnkdag4MyL4omnRXf53Y8UWiVNDiGDmcGcfOGk70JxkDF9
         xl+9ndI6TZ8L/a5V/p2SFXDyI1YMW/nrwxpEJTAxuwYj7fbf9qQsrfIlYGmay2OlzMa3
         C3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700253905; x=1700858705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSNFX2xgBRNTvwuhJ0I7igrYtExQWX8lNq71/XrSzzU=;
        b=SVXz0OCXC3CODQ/L46ndMpn2o9kcT0KmJtWuAfjQ/VDEthLmxqhoBk9P32k7rpJNST
         Fz9Yoe4W/ulmBq/wTBlX9l4Fl1DYkXDdnbInuZGJNouSazKFj2iBldKwkoJDVYwosJaD
         CQPVimqpwXdO7pYShSoyiliegAaYbNDF+R+vKdYgMhJxYCcK/Y/+OcZRsb+b/AXGBdhO
         gLOPlA1vN+KzCtpCPUpobaO+LII6OFr8xeWIZ2O0YXhWU6CuQnLFUXvBOGGC15Xqk6Vk
         cASjD08KdbpwnAW6m3qmj6lT+dUK/BefiRpUCjvnoDbsDgDlp/oj6ccL3ZqOdm23slln
         vRQg==
X-Gm-Message-State: AOJu0YyIYF1ohv7cfmfDU5XQ9tSqEF0+xMNeJvJQVOU1F4ze8Pdynbt2
        aCzA5zeO6QmObJhKotXhkWGM4VurGIRyepDLLh10wg==
X-Google-Smtp-Source: AGHT+IHAmBTmUCjMYCaAjKfqdGljXqu2/itJFKfS89EjD+aW9EbnPvNFklw4Dw/9dPDhyelPELAxTybGgHsG0vlPbRs=
X-Received: by 2002:a2e:780e:0:b0:2c5:1603:9c48 with SMTP id
 t14-20020a2e780e000000b002c516039c48mr538982ljc.20.1700253904700; Fri, 17 Nov
 2023 12:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20231117-axi-spi-engine-series-1-v1-0-cc59db999b87@baylibre.com> <20231117-axi-spi-engine-series-1-v1-2-cc59db999b87@baylibre.com>
In-Reply-To: <20231117-axi-spi-engine-series-1-v1-2-cc59db999b87@baylibre.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Fri, 17 Nov 2023 14:44:53 -0600
Message-ID: <CAMknhBEi64y7uC=kYbL1698VES2xGcQEAFQJM-469E77McxkPg@mail.gmail.com>
Subject: Re: [PATCH 02/14] MAINTAINERS: add entry for AXI SPI Engine
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 2:13=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> The AXI SPI Engine driver has been in the kernel for many years but has
> lacked a proper maintainers entry. This adds a new entry for the driver
> and the devicetree bindings.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>
> Note: This work is being done by BayLibre on behalf of Analog Devices Inc=
.
> This is why the maintainers are @analog.com rather than @baylibre.com.
>
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f51d5ec1cf..a40f61ad5843 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3415,6 +3415,16 @@ W:       https://ez.analog.com/linux-software-driv=
ers
>  F:     Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
>  F:     drivers/hwmon/axi-fan-control.c
>
> +AXI SPI ENGINE
> +M:     Michael Hennerich <michael.hennerich@analog.com>
> +M:     Nuno S=C3=A1 <nuno.sa@analog.com>
> +R:     David Lechner <dlechner@baylibre.com>
> +L:     linux-spi@vger.kernel.org
> +S:     Supported
> +W:     https://ez.analog.com/linux-software-drivers
> +F:     Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> +F:     drivers/spi/spi-axi-spi-engine.c
> +
>  AXXIA I2C CONTROLLER
>  M:     Krzysztof Adamski <krzysztof.adamski@nokia.com>
>  L:     linux-i2c@vger.kernel.org
>
> --
> 2.42.0
>

Hi Lars,

As the original author, do you have an interested in being included in
this list?
