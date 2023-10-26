Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE97D8509
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjJZOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjJZOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:45:06 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF3D44
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:45:02 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B5D1E41529
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698331497;
        bh=KyhXAQ347/D5dTVlSbEJNnsvSJxeXoai/S3IoPDxqGM=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QEEhCKwNmQBYuff9Zej1sV7WH/jtU1b4momBaBD7AYx1XC+VmMTho92C4yNuFvWUe
         JmdNp8AURU3JLOAYl91sGmQbRkbRDcGu5nxR7/FFc9r0sanovaSgjYjweama63pd2N
         CM4y+pFYFJ6w+Yd8mtwQETAaLgfi5iPTvzNlse9lFoU1F/fgbVMP0M4zSBRTzdYPm7
         84tJjwbxXJxhIl1o19xmVbKexBXlSy/wm+MARfZVZos9eKArQwOlDlcFFcdZ3KyMPo
         rk4R9Uh8E5qk4QEbEOgtTYxeoCDuwH3+9pw5aMByw+PpUZHpCriiCc8RADfaA3HZrh
         +MM8LDNOptFUQ==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41bf9a5930aso12610431cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698331495; x=1698936295;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyhXAQ347/D5dTVlSbEJNnsvSJxeXoai/S3IoPDxqGM=;
        b=TeQFmPX3mmxu9/yRn5q/3I15qVivfjBoNYMr1X2sCuo+EzNYW6IN9sOeoaCAnVmn7z
         cwDQ0aBiUsspVB/qCacF1McmuSHeSzEDr3bPBp9eUjwndLbDbfjPmPmM3Zsy0nYQCEY7
         2i32klgGPj/xcaPg9U00AvkCdVkpaabBiol/NkCzfybUal6PGMx0Q2AD/p3fSGZAKhvY
         zjAIIjOuZpXxy7aPfIKETgq/+0xdP3U/Jl2vrz16Z8+RROdEjwK7P7LPwGIfKFPGj/Wr
         6EIPWl1f/RMdpWIajFpiZAW+Y/48IANigP4a653Yxhd+++pDLsG7THpaRHCuQAzde7T3
         8chw==
X-Gm-Message-State: AOJu0YxeikctLL7SMuUD4U4U/+VcPPvrDAQr2hyWqzIp42gLLqyL231r
        kJbmmoKqiX5Mro8stiIsm0opci+l0vjzAbnvy9mGWvHZwOVAKG2szPl62PrFYiLi5KipE/zC+d9
        frvKy9aEu5f2ZyFG2bYeKxWVPeB5dv/IOf5/eWNTlZ/t30T/8l2y6irXJFg==
X-Received: by 2002:a05:622a:1822:b0:418:737:87fc with SMTP id t34-20020a05622a182200b00418073787fcmr21060481qtc.18.1698331495010;
        Thu, 26 Oct 2023 07:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDUZEYahtREjaUlikk/d6DW0+O0yNz17AITtWS0cudA0V0aUT0OQQ86tpZcKtUcpjHs4dEqDgRXm8Mb2EWq70=
X-Received: by 2002:a05:622a:1822:b0:418:737:87fc with SMTP id
 t34-20020a05622a182200b00418073787fcmr21060467qtc.18.1698331494770; Thu, 26
 Oct 2023 07:44:54 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Oct 2023 07:44:54 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231026-cupcake-smashing-eb150e74a17c@spud>
References: <CAJM55Z8DXDs6LT0JrTyEMp8V6BHvsjUW7aJ8Gj+fRGsasHAi_A@mail.gmail.com>
 <20231026-cupcake-smashing-eb150e74a17c@spud>
Mime-Version: 1.0
Date:   Thu, 26 Oct 2023 07:44:54 -0700
Message-ID: <CAJM55Z-NAuGjwGXT7vMg+BCofQ8yo7Q_481LQV4zjN3ByRNxBQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: cache: sifive,ccache0: Add
 sifive,cache-ops property
To:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley wrote:
> Hey Emil,
>
> On Wed, Oct 25, 2023 at 11:56:41AM -0700, Emil Renner Berthing wrote:
> > This cache controller also supports flushing cache lines by writing
> > their address to a register. This can be used for cache management on
> > SoCs with non-coherent DMAs that predate the RISC-V Zicbom extension
> > such as the StarFive JH7100 SoC.
>
> I'm not really sure why we need the flag, is it not sufficient to
> register the cache ops on a per-compatible basis? At least for the
> jh7110

-jh7110
+jh7100

> you're always going to want them, otherwise your system is going
> to be largely non-functional, right?

That's right. I'll do it that way for v2. I guess my thinking was that this
would be easier to just add to the device trees of other platforms that might
need it. Eg. mpfs pci and jh7110 graphics.

> >
> > Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > ---
> >  Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> > b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> > index 7e8cebe21584..36ae6f48ce0b 100644
> > --- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> > +++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> > @@ -81,6 +81,11 @@ properties:
> >        The reference to the reserved-memory for the L2 Loosely
> > Integrated Memory region.
> >        The reserved memory node should be defined as per the bindings
> > in reserved-memory.txt.
> >
> > +  sifive,cache-ops:
> > +    type: boolean
> > +    description: |
>
> and this | is not required btw, since there's no formatting here that
> would need to be preserved.

Ah, thanks.

/Emil
