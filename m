Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE27D6FDC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbjJYOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbjJYOwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:52:41 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F6410C6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:52:13 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7b6cd2afaf2so2099717241.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1698245531; x=1698850331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLjdKZ5k0mXVbD8bW7euvhzE58el0xEiaStx/smEM9o=;
        b=L2zx2ZDUTUcNhjd/kQhBfl0X6zLoWnqtZftN5bvJLKV8MKaeH+LxAIiuNlaXBauLFe
         olCtDxbH+t09Olwjiuwif1Oxm6GktIiG4Rwm3z6Gr/OnLSQAOE2T2K8QWLk/Bql4yTZ1
         vEDW9Rc6LSkY2q7TqlAgLV5mvnni0yfndg8EZEkDGBsNVZAAm/67qXPnX4r21w9+r5s7
         AMmr/QdCizQRiu51ynVZB0L+RecCDYSjd9/5pxqfrL9+4yPhG1kpfnrszGLdga3CA/uM
         RDPeD+zQTRJxoaWGcdr2iodOWpIE65JKHQvoPhU5HCa6SIevFw7DlYjCirKVdqmJTHr/
         yuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698245531; x=1698850331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLjdKZ5k0mXVbD8bW7euvhzE58el0xEiaStx/smEM9o=;
        b=Pv4NWM0R6k7QJXt3DHmurRUwls0UXQhbUyhlJEa1xpyZvCRjRvtrlSQzxlajX4aKl/
         e+6TsEPxhDTGO9Zm1GQFGCYCWWY4K3sqDmzQ/BDhZXlXL4+NPLSyavT4hySRHGZY9SDZ
         I6b0MMwPMS8FGgsZckhi1RBmwl8eBXgGgKw1BxoltE6QYG36s5Ssjzd3oYHBUpzkZiNh
         jp8n/uhF0HwHijPyV026sM0/Tw1b6YONKcgfp8iNS0Ov9bJmJh7tmRTIgZL9BQCx3Dpu
         p5cucxNC1QdHk0IQhE4k9oSXfJu0cJhnW+DPkWZvVvfrFvyhS5HMW1qk7wVFSU5isaL5
         SRNg==
X-Gm-Message-State: AOJu0YyEC4qX2R31t0d7f9ZSiwZFF3yFxTSzlCtVa/nkuBRE9Bubq6O3
        oEoHTD+DHEg73iM1N48gbta2AqbQlqlL8jU1Vr6d6A==
X-Google-Smtp-Source: AGHT+IH9eZcIeh5TypMu2DrELpqy3iFXVc5K2Hl5mUVraJmb0uVk6Ut6VGVvmn/692Isw5J2GiM90b5hEhQWssWFL90=
X-Received: by 2002:a67:c295:0:b0:458:47e6:70e4 with SMTP id
 k21-20020a67c295000000b0045847e670e4mr15925625vsj.19.1698245531279; Wed, 25
 Oct 2023 07:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231024171253.19976-1-zajec5@gmail.com> <20231024171253.19976-2-zajec5@gmail.com>
In-Reply-To: <20231024171253.19976-2-zajec5@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 25 Oct 2023 16:52:00 +0200
Message-ID: <CAMRc=Mdb7mjOLQSVVka4XTCuziB1DNj9kpgB=sE=fcJKvpk0_A@mail.gmail.com>
Subject: Re: [PATCH 6.7 fix 2/2] dt-bindings: eeprom: at24: allow NVMEM cells
 based on old syntax
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 7:13=E2=80=AFPM Rafa=C5=82 Mi=C5=82ecki <zajec5@gma=
il.com> wrote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> This binding supported NVMEM cells as subnodes and that syntax is used
> by few in-kenel DTS files. Modify binding to allow it.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: c5330723d5a0 ("dt-bindings: nvmem: move deprecated cells binding t=
o its own file")
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documen=
tation/devicetree/bindings/eeprom/at24.yaml
> index 6385b05a1e62..b6864d0ee81e 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> @@ -12,6 +12,7 @@ maintainers:
>
>  allOf:
>    - $ref: /schemas/nvmem/nvmem.yaml
> +  - $ref: /schemas/nvmem/nvmem-deprecated-cells.yaml
>
>  select:
>    properties:
> --
> 2.35.3
>

Do you want it to go through the at24 and subsequently i2c tree?

Otherwise if someone else will pick it up:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
