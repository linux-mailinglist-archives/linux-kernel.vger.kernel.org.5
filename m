Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCB2805DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345566AbjLESNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjLESNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:13:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D90D122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:13:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c77e0832cso4550450a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1701800014; x=1702404814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXq0MfZRsUUXWF9wD5yNB4JShTMDiPdjDXjC0F7taj4=;
        b=Zk/tiMBtakw5L3FcipK7znbHmefycm8fIrj6JtDEjulBR1qOK/8He7CaAkzszZjWR+
         VQ+GpOf/tBRj+PujLs3pwnGHYR++Oi+mD8oqydqQbNoftKvFF9uP1k0ns874PSttsUBA
         nmGfosSDzXPhZhG01ZbapclY9kjDI8Vg5gQoDQ2q7WraPdijNmLH+/fBAHsjJ7EBqJMP
         5vV/ofOm0KMkL08yUMXBqoz0MkGqtpEtooWZrEXwgxvFcg5PLyi5lsSEO14hwXXLt8mx
         yyF89RVlPbQGc47vsrLV+IWdvjaK4NBABHYszrrkD+FBHeWe0ATJtktTzh5wytw3jQBm
         Rrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800014; x=1702404814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXq0MfZRsUUXWF9wD5yNB4JShTMDiPdjDXjC0F7taj4=;
        b=MizvDAniqaZ1LlfEqGLT9HI6KPL/NBVWbac5Lahg5xCZY1IKyCxpjFB9X4lQXrWDi4
         bROuKdOQ0xRUtzYs4fPya1v26gweVEeOlig6GFJi3QckKnfqkSe8t3QTWk43EtuswiQY
         +eGsbW1/dFKlRGhDt3LFlyUrB7wzcjfWoMZN4St/RsXPO5JadxtzY+zRP4tf8FpSN8xI
         9aKsUEz2Si0JUVC/1criXFIj7J4YrjAzKgC36LoJ6zTgXBR4nenkrLInHjo7EzDo/qvX
         gi9BV9JKEOayiIwXBg3vq5c9RzQYGys4J1GInRboaaeNNUAG5VvSdLqmqyhap/mrX2lm
         d11Q==
X-Gm-Message-State: AOJu0YzCnrbzFr6mvSrrGtjbBc3ywij3HT65dsxvl4lxDtZIOC1nlSqY
        sZVvQnBfnN5cG+ilgACKptiOa2lGZ7U/fJ+6Hlfh4w==
X-Google-Smtp-Source: AGHT+IFmKwiC4EDFrybnCkMnPFoevOkPdtg4vQBvxBHXLhsCV0BnoZlp1hCTpg2BeuOvGr+igVu2Q9Lq73abUwn5b58=
X-Received: by 2002:a17:906:73d1:b0:a19:b93c:d28e with SMTP id
 n17-20020a17090673d100b00a19b93cd28emr4703493ejl.2.1701800014652; Tue, 05 Dec
 2023 10:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20231130191815.2421978-1-robh@kernel.org> <CAOMZO5AZNz1cRg+aYQjDmpZ75ATJQUTWmC5mx+vgaYcBL6M+2w@mail.gmail.com>
 <CAL_JsqKLFpPo8xTh_vgWvDXSY5J8tQJZh9SrkW2EiK5V_ZNeeA@mail.gmail.com>
In-Reply-To: <CAL_JsqKLFpPo8xTh_vgWvDXSY5J8tQJZh9SrkW2EiK5V_ZNeeA@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 5 Dec 2023 10:13:21 -0800
Message-ID: <CAJ+vNU1DiFbQivka8gA1URiLMD2mWJnWSdn-77bEo8Uz0Liqcg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-venice: Fix PCI bus nodes
To:     Rob Herring <robh@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 2:33=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Nov 30, 2023 at 1:28=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
> >
> > Hi Rob,
> >
> > On Thu, Nov 30, 2023 at 4:18=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > The imx8mm-venice boards PCI bus nodes are a complete mess. The
> > > unit-addresses are wrong. The PCI bridge nodes are incomplete missing
> > > "device_type" and "ranges" and just wrong for "#address-cells" and
> > > "#size-cells" values.
> > >
> > > All of these issues are reported warnings if anyone bothered to pay
> > > attention. Sigh.

Rob,

Sorry about that. At the time the dt was submitted there were still so
many dt warnings it wasn't very clear what was a legitimate issue and
the PCI bindings are not that easy to understand.

> >
> > The warnings are gone in linux-next:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/arch/arm64/boot/dts/freescale?h=3Dnext-20231130&id=3Dd61c5068729a76a618=
3a897bcad4bf26e8d3d674
>
> Linux-next is wrong. The ethernet device should have a node name of
> 'ethernet'. The 'pcie' node name and 'device_type =3D "pci"' is for PCI
> buses/bridges only.

So as Fabio has tried to fix this with a patch that landed in
linux-next this patch won't apply. I'll submit one that covers your
changes.

It's always been unfortunate to have to have this level of detail in a
device-tree just to allow boot firmware to populate the mac address of
a PCI ethernet device.

Best Regards,

Tim
