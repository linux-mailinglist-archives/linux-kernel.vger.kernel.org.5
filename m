Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC57E601C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjKHVpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjKHVp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:45:27 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7862591
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 13:45:25 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59b5484fbe6so2335337b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 13:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699479924; x=1700084724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNZCsb+J0tCXIr/CtNET2AcsXu2SaYf1CY84TShlm6Q=;
        b=GdXWk7r/Ww0irC7aIsHcw7wDikNbFo3tRY3z+MPolck9u3bmv9yN23/z52w3m3460W
         RGIKDGXc6mHT+IlxrCECRrX729Zoxl0AOKSZ/qdy/dKS/QyiPw8If7/gOXI/N9CTJ6hd
         o1wgAF+pHv8PA3b9FHohHi5b/mRMt3lCOOwPQNjPQaXf9sH9EKz2xlAQI55UGYRrb0Xg
         PAJfT4PXMmh37cXNfYIA3v2Xq7RzphXqFnprFrnz8ZNCI51SBt27fMPB0aXwjWE15qYR
         rrJGGjPYJDfQPbxHRAIoAzQ2Q7mZM+RHaETChVl2CmOmh5GWqqpoOKxwdq5OJGWjjude
         RTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699479924; x=1700084724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNZCsb+J0tCXIr/CtNET2AcsXu2SaYf1CY84TShlm6Q=;
        b=Y7f5Oc4nxWeGfXWMwRIcWBcmC1A+/zNxmC64jdxknKTFisPllnsBsp55XtpF1/G5bv
         nqxsZ4FTiewXRbyClqBssIYVW0KqDSvHqoJ1X6QICrw9VXZiq1DBcvRh9kU7N3WW4Mtt
         P0sp2DnCf3srKgP8NmXtGdzYRJzXktwEfWOn73pvmziJIqQLvJZrX98+UgzMVYRxYsZE
         r4Ki1E/P7w5HFz+jeYI+rQJni1R3ETkJpTUBjH5xRDX6pSQAqSDNIzLlSKa2cII8Bp5H
         zaH4tYeaCC7HOUlyn1jVMKoLbHsZmZ1Gsu28HSOpNu487ArLVdts4oJ9JMJZWEF2NuOO
         kq2w==
X-Gm-Message-State: AOJu0Yw3U5131MljGolp6K2+3UfkBWG1NJWPcASO4zUTe3cc0CQm/oqn
        zYazeBSCHh6EA4NNtZb5PpN0qTA1K8EOXvhNOOxd4w==
X-Google-Smtp-Source: AGHT+IFY9jFZdG7cvJAasqldeYVJV1lp20ykF6CM/T97HTYZUi8l1zfwxOIgQ7l5PF/miWNeoGVOLOXt0F0G6C0TYx8=
X-Received: by 2002:a81:6cd6:0:b0:5a7:f002:4fe4 with SMTP id
 h205-20020a816cd6000000b005a7f0024fe4mr3127115ywc.23.1699479924475; Wed, 08
 Nov 2023 13:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
 <20231108-fix-mips-nand-v1-2-5fc5586d04de@linaro.org> <20231108191125.GA2754195-robh@kernel.org>
In-Reply-To: <20231108191125.GA2754195-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 8 Nov 2023 22:45:11 +0100
Message-ID: <CACRpkdZx9icF7s5HoS2r40Wuj4sPbEZPiaPsD9GZ94J4LKY5+g@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: mtd: Rewrite gpio-control-nand in schema
To:     Rob Herring <robh@kernel.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        Howard Harte <hharte@magicandroidapps.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 8:11=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
> On Wed, Nov 08, 2023 at 03:33:50PM +0100, Linus Walleij wrote:

> > This creates a schema for GPIO controlled NAND. The txt
> > schema was old and wrong.
> >
> > Mark the old way of passing GPIOs in a long array as
> > deprecated and encourage per-pin GPIO assignments with
> > the named nnn-gpios phandles.
>
> We have 1 user upstream with only a single commit adding it in 2017.
> This doesn't seem like something that's going to gain new users either.
> Is it really worth modernizing this binding?

The whole ordeal was actually prompted by the emergence of a
new user who wants to add a device tree for a new device.
So I don't want to add new users for the old bindings.

Yours,
Linus Walleij
