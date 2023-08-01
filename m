Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC21176B2A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjHALGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjHALGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:06:02 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165837AAC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:59:47 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso83122771fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690887585; x=1691492385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F76i/7vGNisrChJeRqvuEQPeFIPFgiCjw08O3STlUnc=;
        b=BPClByZTHs7jw3OZmeyJAD4PsN3zyPlaDbDLMU+3gZiyPb9Y5o8jW2P8Tlh5p6s+9r
         BlAORineS72jryyv1aMOR7CAQ2QvqCqS/FShXPD9ckwFFobrBr11l6md0DRF8LeRFIz4
         HCPs+ezWMsz/3i8x1k5giQ/4TLSXcYfFz1qdugHdRSJaAktMjWW27OnYbTbc26pq+uaA
         TAsAgdfii8Q3g3jqkVlVDBMDeEzhdfHKh2CjtXZISoVLj3TOFhG4UACU0RVa8Uv6rnCE
         j2R5L0KAqpYyOdyThqIB0o+bIGvj9QVRG1oJPwOhFBE6PomEkl6xWZjSuOSkBoTarhIp
         0tuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690887585; x=1691492385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F76i/7vGNisrChJeRqvuEQPeFIPFgiCjw08O3STlUnc=;
        b=PbrPZT4aPRit30zdULDycVEKPpxOcf+0APaWhRfQh4xoU5q9ao+XBFkJx9qAkQGq9S
         e85PmLfbpVcjxzvzp9jVpjKYSizruHmZy5X5LcC9Hh9vvi7o7C+2usyTf9p/EWki4wiQ
         L5Dmg/gaEUByFBxOLIXNUdGB/iX2xtpoqynk482q1I/nuhLUdyktlPj+HaUWvaKnWGwZ
         q8W+Ae1TNYKKMesLgWaiHL5SEF0sRXgpgHuRYV7uhQWLuy4qaFM3NnDEi36jQKhgy3DY
         1zHM6S8k9+8kcQJG4T6FeNi63OlC+SyuzHC9yzp2bgKyUefmcabfgmbjCcRvOqOzBgVx
         pPnw==
X-Gm-Message-State: ABy/qLbfIopg/VKDwo947LpcW7GIjj2l9JKM2zOXpKjFo8CDA2WCJOrj
        PsD8aL+Ql4zfLX4gYnpAEp77Ivi1+z92VyhQi+Lk4w==
X-Google-Smtp-Source: APBJJlFNZI1VOiwUF6e/KUPHc2Zx0vZxESwSvI5tKYuKGB7IyFDDEb7la65niBvb/xQFqiAfDcQvct1KidT8ZF2BKmc=
X-Received: by 2002:a2e:b0c1:0:b0:2b9:e93e:65d9 with SMTP id
 g1-20020a2eb0c1000000b002b9e93e65d9mr2272839ljl.40.1690887585321; Tue, 01 Aug
 2023 03:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230720135125.21240-1-eric.lin@sifive.com> <20230720135125.21240-2-eric.lin@sifive.com>
 <cbf0a8fd-3479-1684-fe90-81f2159804ef@linaro.org> <CAPqJEFr5h+5+F4TdNuRMaWsrmeedbfGgbgd9wh8sUUQsj2Pw-A@mail.gmail.com>
 <be748338-987b-d474-d040-82af7cfb5f01@linaro.org> <CAPqJEFpYOgaEiSJ4HJwxMtpu1MZeUg9=tARTWa7hwTkjsQ3UAA@mail.gmail.com>
 <f7df407e-1deb-f667-912c-81415fffcbfd@linaro.org>
In-Reply-To: <f7df407e-1deb-f667-912c-81415fffcbfd@linaro.org>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Tue, 1 Aug 2023 18:59:34 +0800
Message-ID: <CAPqJEFrYrbH2H5F=V4D4-exLjmnuJybj8L2GKPzqhTrDsqe-gA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 5:39=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/07/2023 11:04, Eric Lin wrote:
> > On Fri, Jul 28, 2023 at 2:58=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 28/07/2023 08:01, Eric Lin wrote:
> >>> Hi Krzysztof,
> >>>
> >>> On Fri, Jul 21, 2023 at 4:35=E2=80=AFPM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 20/07/2023 15:51, Eric Lin wrote:
> >>>>> This add YAML DT binding documentation for SiFive Private L2
> >>>>> cache controller
> >>>>>
> >>>>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> >>>>> Reviewed-by: Zong Li <zong.li@sifive.com>
> >>>>> Reviewed-by: Nick Hu <nick.hu@sifive.com>
> >>>>
> >>>>
> >>>> ...
> >>>>
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    items:
> >>>>> +      - const: sifive,pl2cache1
> >>>>
> >>>> I still have doubts that it is not used in any SoC. This is what you
> >>>> said last time: "is not part of any SoC."
> >>>> If not part of any SoC, then where is it? Why are you adding it to t=
he
> >>>> kernel?
> >>>>
> >>>
> >>> Sorry for the late reply. I didn't describe it clearly last time.
> >>> Currently, we have two hardware versions of pl2cache: pl2cache0 and p=
l2cache1.
> >>> The pl2cache0 is used in unmatched board SoC. The pl2cache1 is
> >>> utilized in our internal FPGA platform for evaluation; it's our core
> >>> IP.
> >>
> >> And why do you add bindings for some internal FPGA IP block which does
> >> not interface with any SW?
> >>
> >
> > Hi Krzysztof,
> > The pl2cache has mmio interface for SW. Thanks.
>
> Then did you mean that FPGA represented some model of your SoC? If so,
> what are other bindings for that FPGA components?
>
Hi Krzysztof,

Sorry for the late reply.
Yes, here are the devices dt-binding that we use on the internal FPGA
SoC platform. Thanks.

uart:
Documentation/devicetree/bindings/serial/sifive-serial.yaml

gpio:
Documentation/devicetree/bindings/gpio/sifive,gpio.yaml

dma:
Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml

spi:
Documentation/devicetree/bindings/spi/spi-sifive.yaml

Best regards,
Eric Lin

> Best regards,
> Krzysztof
>
