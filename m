Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E164F76681D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjG1JEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjG1JEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:04:37 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E91B6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:04:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so28639501fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690535074; x=1691139874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoUjJ9zL9e663eyjUh3+yZMV+gsB92P640Sm3159mYQ=;
        b=GWE2v5GO0nR84rzpqfnEgejBzGhN8kmeIhUex9shslMfLPk8x4dv8QTreZX6Xth0FC
         SJeQBMwslj3Hg8jppS7yNQ41Jg+5J0l6/aJ5iPM0raqiZN+GpksIu2nXTlyYkCXNNw4S
         VPHZWoR4IgMDrMmwkp3ms++fNSTf/MykV8Ugh41L+duzNuhm2XvaRObJa9FOZgr7uI6y
         amAEVguzKhWS8ui7CoNHnTNhIjJFZohoStgGhN7io2g3TVUDTHvkeyYhINgDBQYrEDZe
         mW0R3+Yg0QnEfTlQbNFhmxx90NlZjF7MX3YyJypumLONO3cERP2TLnj3r0TibU9nN/um
         MpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690535074; x=1691139874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoUjJ9zL9e663eyjUh3+yZMV+gsB92P640Sm3159mYQ=;
        b=aas3z2QTJdhMqjUk7KVhG+OCqVMmTI++doUGshBZe0aZpDZbxG6CdCSr9S6jhm/giI
         T4a6h5sfhmz/jHM9Hes7n3A6FgqvMvyg71SNQsT9iCMYiVh1hwBTUex3TZPVntArc+be
         RegQ3Ck0cJHt8noocGPZUWHR+8JNZOjjKTOSggo699dP2NXgmsrJL+CuGpokTZ9r38mD
         vpi/Mg2RK8DjKz19EzaGuE9d2RWT1+nFXv+f8uwtI4qM24Xo1VXSkhIPZ1lOefD70HOB
         3mtgjM3feOu7+1jmrA8LcTtK4vJ60GUBThyFmPEgBP7UyO+DKaFM5FpzlXlG6R+CHkNN
         3s6w==
X-Gm-Message-State: ABy/qLZXzot1dvTns7slcIJxCbOaPkKYxTSAnBs3YgHeiar53Ne4pamu
        FeuE2T1Hg3E+C+NWt5m7v2CSKfYYSYHbW2zERVDvfA==
X-Google-Smtp-Source: APBJJlE2xC/ePHFkPLVLV9/WTr37CR88KoeWLBzMv1tBu7gB0t5QjfHg6H1TPAqSzSN+blmCxSh5RZhbRETHKEBz5Gs=
X-Received: by 2002:a2e:97d7:0:b0:2b6:fa60:85a1 with SMTP id
 m23-20020a2e97d7000000b002b6fa6085a1mr1301429ljj.21.1690535074159; Fri, 28
 Jul 2023 02:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230720135125.21240-1-eric.lin@sifive.com> <20230720135125.21240-2-eric.lin@sifive.com>
 <cbf0a8fd-3479-1684-fe90-81f2159804ef@linaro.org> <CAPqJEFr5h+5+F4TdNuRMaWsrmeedbfGgbgd9wh8sUUQsj2Pw-A@mail.gmail.com>
 <be748338-987b-d474-d040-82af7cfb5f01@linaro.org>
In-Reply-To: <be748338-987b-d474-d040-82af7cfb5f01@linaro.org>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Fri, 28 Jul 2023 17:04:23 +0800
Message-ID: <CAPqJEFpYOgaEiSJ4HJwxMtpu1MZeUg9=tARTWa7hwTkjsQ3UAA@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 2:58=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/07/2023 08:01, Eric Lin wrote:
> > Hi Krzysztof,
> >
> > On Fri, Jul 21, 2023 at 4:35=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 20/07/2023 15:51, Eric Lin wrote:
> >>> This add YAML DT binding documentation for SiFive Private L2
> >>> cache controller
> >>>
> >>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> >>> Reviewed-by: Zong Li <zong.li@sifive.com>
> >>> Reviewed-by: Nick Hu <nick.hu@sifive.com>
> >>
> >>
> >> ...
> >>
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - const: sifive,pl2cache1
> >>
> >> I still have doubts that it is not used in any SoC. This is what you
> >> said last time: "is not part of any SoC."
> >> If not part of any SoC, then where is it? Why are you adding it to the
> >> kernel?
> >>
> >
> > Sorry for the late reply. I didn't describe it clearly last time.
> > Currently, we have two hardware versions of pl2cache: pl2cache0 and pl2=
cache1.
> > The pl2cache0 is used in unmatched board SoC. The pl2cache1 is
> > utilized in our internal FPGA platform for evaluation; it's our core
> > IP.
>
> And why do you add bindings for some internal FPGA IP block which does
> not interface with any SW?
>

Hi Krzysztof,
The pl2cache has mmio interface for SW. Thanks.

Best regards,
Eric Lin

> Best regards,
> Krzysztof
>
