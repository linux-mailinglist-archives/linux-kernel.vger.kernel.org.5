Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4A3782900
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjHUM2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbjHUM2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:28:05 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51CD3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:28:03 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7a01719d3c5so2684579241.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692620882; x=1693225682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOpajm3cCWmy6wmv8U6HMhoxWqJVZlf2EuaP2Zg/6bs=;
        b=wZQYJaxKI6mbzSaHcp5Wnm/tPi+iMA/cW5x/y7nQmQDQgpz4RU1GyzXpD6OFSsRyJ/
         R2XKZvnCG068a7FV9ZIXP951yytmQYx9zVmlpy9IIuKuzoU8cx8QnwEiF34zycGRR0/5
         My9N7HCcjS5GGyeufBrIlNAndFcMlEKHGjUh5OSU1wA003AmnzZcCwgfsiJcUZWN54GJ
         Rx0zKlb05Dlf39WYmPHSV5H44PLIwb8e0HKank2o3223IV998p0ai5TfAuzRX+tKXsny
         HRsh0Htjj8tFBDp82JQa5IHlFfJb+/ZdVqXRj6oBZiP3OvevA7st2HEmaNIM9tgxaiNR
         cN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692620882; x=1693225682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOpajm3cCWmy6wmv8U6HMhoxWqJVZlf2EuaP2Zg/6bs=;
        b=LkrVKhQT0/UUHE2ruw01e18zt5cZ7c+xOxCSu8KR7kIx/RMSJdLt7LdH2WhrPjvCzB
         GGuuqp75Bww5xuESUyfAGl5chrbR++SgtZyq82aMBDe71cJVpgO4nX02YGnddpqebtBe
         Xh+tutOFmhJJEiPzefJ3CYh1IKVc9WmFgEFxoTPWGXWFlU1nmYl6QAugxn2cWKgqG8k8
         Y+lt9IkDiIN/t+ZUk1IPsf+2spZ2JVMHUBeB7HjmbYDlldxodjpo4jfiBCyFQ7fwYONA
         AWHiGRfRz7DaEP3YMRWjKl/1bF5ESMjSfH6pb4TQakRG1O2jp1GA56Xsk5LxS5YDwirC
         9BfQ==
X-Gm-Message-State: AOJu0YxGrCU07YzT1k2dtw7fHSA9cEB/nhUIqYDwpxVznYhvGE7ikkhS
        JsR6fb1T7GGDcRF/ZZSaWXphdNAAHaJLrSuCFg1PAg==
X-Google-Smtp-Source: AGHT+IHY4dCGJNVWAnbeuo65q9Pi/9BMAbFluoL1XIBZeEzZj8CMFt6+5Mg05hyn/+GwsrWspVWbGyJzLfn4+LhykvI=
X-Received: by 2002:a05:6102:7d7:b0:44d:5506:c5a7 with SMTP id
 y23-20020a05610207d700b0044d5506c5a7mr353100vsg.6.1692620882431; Mon, 21 Aug
 2023 05:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230727095432.82591-1-okan.sahin@analog.com> <20230727095432.82591-2-okan.sahin@analog.com>
 <CAMRc=MeLaadEVM1UBaGSJ=cUcJ=ub7_kOc=97t37+oU6+RMuhA@mail.gmail.com> <PH7PR03MB7391911157B3AEAAC9DA44B3E71EA@PH7PR03MB7391.namprd03.prod.outlook.com>
In-Reply-To: <PH7PR03MB7391911157B3AEAAC9DA44B3E71EA@PH7PR03MB7391.namprd03.prod.outlook.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 21 Aug 2023 14:27:51 +0200
Message-ID: <CAMRc=MeCm+Jsn+N4FEdYC-RSLn68OE7dRUJ6HiS0YcMX+rz7fg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: gpio: ds4520: Add ADI DS4520
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Aug 21, 2023 at 12:09=E2=80=AFPM Sahin, Okan <Okan.Sahin@analog.com=
> wrote:
>
>
> >On Thu, Jul 27, 2023 at 11:55=E2=80=AFAM Okan Sahin <okan.sahin@analog.c=
om> wrote:
> >>
> >> Add ADI DS4520 devicetree document.
> >>
> >> Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >> ---
> >>  .../bindings/gpio/adi,ds4520-gpio.yaml        | 51 ++++++++++++++++++=
+
> >>  1 file changed, 51 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/gpio/adi,ds4520-
> >gpio.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/gpio/adi,ds4520-gpio.ya=
ml
> >b/Documentation/devicetree/bindings/gpio/adi,ds4520-gpio.yaml
> >> new file mode 100644
> >> index 000000000000..25b3198c4d3e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/gpio/adi,ds4520-gpio.yaml
> >> @@ -0,0 +1,51 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id:
>
> ...
>
> >>
> >
> >Applied this and the driver, thanks!
> >
> >Bart
>
> Hi Bart,
>
> When will it be released? I could not find your tree that's why I am aski=
ng it.
>
> Regards,
> Okan Sahin

It will be released in v6.6 in around 3 months (see
Documentation/process). My tree is listed in the MAINTAINERS file.

Bart
