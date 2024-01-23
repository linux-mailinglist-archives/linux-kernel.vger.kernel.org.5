Return-Path: <linux-kernel+bounces-35098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C848E838C27
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FC51C22A75
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A385C8E1;
	Tue, 23 Jan 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1//IP1t"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C925C610;
	Tue, 23 Jan 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006086; cv=none; b=LgiG4NrvQVvOXyo24xYLL6+vgcBWhkS9hgM7rISH3qFwxJR9uBZjUP1pdwFqBvwfxoSdwfrWiBsxjvBQbu3Pq+gml2jedn3UQ49Iub9hP+lnzwNIIOJ6evDu9IdatC2Pq4inib9AqyH4/Yzw5oJaGWb1YZL7yKuylehFl4zDHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006086; c=relaxed/simple;
	bh=n8EVx1KnsxT023JauzBveoILnBLCXi0WB1yyp0yg88E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FT7THHOfrQOkkLKJFtL5HPFcUsBLOENz/SvtNOjIEGENNZVlOSw45djM+H1WTUbAQGj6PR2KA/mK4xlwl2oEvsg3NTA3PaTY0pYQbielqdBhMwiCsr0iYtTx5REfILmE2cvUYjOWtSK8iqcAjIXG3pK/rEWLvbmbYo5O0hN2Z+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1//IP1t; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28bec6ae0ffso1987169a91.3;
        Tue, 23 Jan 2024 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706006084; x=1706610884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf2YaREmVYXxOJZhUokIKRBOvqtSAWNcOsE6VEYJ3QI=;
        b=Z1//IP1tUBhzo4bn4vSZbEqYl+EQsZ+78t38uqNA69vn+YslND2HVWgK3HbGgfTpPT
         j1WMuL/DIi3FyVOpuvQr5HJ9Wf6SOJ9DvUVg42burj2t0pcZ6skHvWqNxsJ7ema3btaQ
         4YSFDrVCYEBH1airbRdSdvKrTSUWREcxXNig75w9kh05uQ4QqEPQvHbRAGc7GQMkxG93
         SXgUbO8SSkOS/YN0j3X/meiBeCLnFw1Urs+GIKG9naOxoz/c4DxSzwO5Y7ICGBZo6tfN
         9d58UauGIsTLYcc3FHnMO/l91PnGC3dnaqy4cbL5tWJbo4dh9FcUgcdDtjoULeO+Nz0S
         kkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706006084; x=1706610884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gf2YaREmVYXxOJZhUokIKRBOvqtSAWNcOsE6VEYJ3QI=;
        b=WFryIEq2S9VHx8DIgXgak5NBZfwWW4Mpb7gyIMhlUrCaCtcko6zNdQVamMbLjzD+NF
         OWttLH7vcyukiSAK8k+KYV/T5Zg90XgZZmB+Zi5atcRXZufjWPYTPdAcTQnIjoScoDYZ
         eqXaZYUFVK0ZUxhtHW7dvFrATG21LAMgbhqI/khsbjP3lX2XFDvtM7nmXCtbg2LoItwP
         +uDLae+F6oxOPwCTpLExwmxJNRV3+bkTFpycGXeUhK65XvzqfCm7lBmf/S2V5aUZcR4X
         i6M1qN2Q0oX8A2PILfeqJqohPChPBM93ENfcAoZSH2clwUZMSesoN0EfmcLh+FQaFEMi
         XAKg==
X-Gm-Message-State: AOJu0YzVHjYzFeh6KtSPhzm+nUStVUt6xMK1R5pJq4UBfpANlLZ2RqkW
	6DvN/RZ+l5PN7M8B7bqaAphJQdoYUMRnjmB5zmTDi9ekz0XMeJa7iKiWPQ1lgb8KyARHz6074Bq
	nnpgfvIYyHlf5gBy8QCezfB0ZiFSYR7qttmw=
X-Google-Smtp-Source: AGHT+IGtLI4G6LyMbWMUQB8P4MTNxrKBQrJ79HxJ8bP4yLpCab9rJ66u1Flg526m0fJyc9ODaJKxJjZvD7pQkLmg+ws=
X-Received: by 2002:a17:90b:228f:b0:28e:82bb:746f with SMTP id
 kx15-20020a17090b228f00b0028e82bb746fmr2297885pjb.97.1706006084311; Tue, 23
 Jan 2024 02:34:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118195356.133391-1-dregan@broadcom.com> <20240118195356.133391-2-dregan@broadcom.com>
 <CAOiHx=k2Wn+UaVFbB-n2XKmFuBss4LKmLSW45YME07z=7zg0ww@mail.gmail.com> <c1fc163b-1f4f-42a5-91c3-b31ad33a9741@broadcom.com>
In-Reply-To: <c1fc163b-1f4f-42a5-91c3-b31ad33a9741@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 23 Jan 2024 11:34:32 +0100
Message-ID: <CAOiHx=n62Ap8bGbTu0xcKMHcqgpaLZ-GNjsW2DQ5XPrnsxmAJw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
To: William Zhang <william.zhang@broadcom.com>
Cc: dregan@broadcom.com, dregan@mail.com, miquel.raynal@bootlin.com, 
	richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	computersforpeace@gmail.com, kdasu.kdev@gmail.com, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joel.peshkin@broadcom.com, 
	tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com, 
	anand.gore@broadcom.com, kursad.oney@broadcom.com, 
	florian.fainelli@broadcom.com, rafal@milecki.pl, 
	bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com, 
	baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org, 
	dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 18:34, William Zhang <william.zhang@broadcom.com> wrote:
>
> Hi,
>
> On 1/22/24 03:48, Jonas Gorski wrote:
> > Hi,
> >
> > On Thu, 18 Jan 2024 at 20:56, <dregan@broadcom.com> wrote:
> >>
> >> From: William Zhang <william.zhang@broadcom.com>
> >>
> >> Update the descriptions to reflect different families of broadband SoC and
> >> use the general name bcmbca for ARM based SoC.
> >>
> >> Add brcm,nand-use-wp property to have an option for disabling this
> >> feature on broadband board design that does not use write protection.
> >>
> >> Add brcm,nand-ecc-use-strap to get ecc setting from board boot strap for
> >> broadband board designs because they do not specify ecc setting in dts
> >> but rather using the strap setting.
> >>
> >> Remove the requirement of interrupts property to reflect the driver
> >> code. Also add myself to the list of maintainers.
> >>
> >> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> >> Reviewed-by: David Regan <dregan@broadcom.com>
> >> ---
> >> Changes in v2:
> >> - Revert the new compatible string nand-bcmbca
> >> - Drop the BCM63168 compatible fix to avoid any potential ABI
> >> incompatibility issue
> >> - Simplify the explanation for brcm,nand-use-wp
> >> - Keep the interrupt name requirement when interrupt number is specified
> >> ---
> >>   .../bindings/mtd/brcm,brcmnand.yaml           | 36 +++++++++++++++----
> >>   1 file changed, 30 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> >> index f57e96374e67..56176ec1a992 100644
> >> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> >> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> >> @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
> >>   maintainers:
> >>     - Brian Norris <computersforpeace@gmail.com>
> >>     - Kamal Dasu <kdasu.kdev@gmail.com>
> >> +  - William Zhang <william.zhang@broadcom.com>
> >>
> >>   description: |
> >>     The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
> >> @@ -18,9 +19,10 @@ description: |
> >>     supports basic PROGRAM and READ functions, among other features.
> >>
> >>     This controller was originally designed for STB SoCs (BCM7xxx) but is now
> >> -  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
> >> -  iProc/Cygnus. Its history includes several similar (but not fully register
> >> -  compatible) versions.
> >> +  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
> >> +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
> >> +  Its history includes several similar (but not fully register compatible)
> >> +  versions.
> >>
> >>     -- Additional SoC-specific NAND controller properties --
> >>
> >> @@ -53,7 +55,7 @@ properties:
> >>                 - brcm,brcmnand-v7.2
> >>                 - brcm,brcmnand-v7.3
> >>             - const: brcm,brcmnand
> >> -      - description: BCM63138 SoC-specific NAND controller
> >> +      - description: BCMBCA SoC-specific NAND controller
> >>           items:
> >>             - const: brcm,nand-bcm63138
> >>             - enum:
> >> @@ -65,7 +67,7 @@ properties:
> >>             - const: brcm,nand-iproc
> >>             - const: brcm,brcmnand-v6.1
> >>             - const: brcm,brcmnand
> >> -      - description: BCM63168 SoC-specific NAND controller
> >> +      - description: BCM63xx SoC-specific NAND controller
> >
> > Only the BCM63268 family has a v4.0 NAND controller with support for
> > ONFI and raw access; BCM6368 has a v2.1, and BCM6328 and BCM6362 have
> > a v2.2.
> >
> > So claiming this is a generic binding is wrong; you would need to add
> > the appropriate variants first. Or add another one for the BCM6368
> > NAND v2.x controllers, which is missing. You can find them used in
> > arch/mips/boot/dts/brcm/bcm63{28,62,68}.dtsi.
> >
> I am not changing binding here but jsut update the description to
> identify these MIPS based chip as bcm63xx family. This convention is
> used in other IP blocks too.  And yes this binding is not correct and I
> noticed the same v2.x usage in the dtsi files you pointed out. So I
> actually updated this binding in my v1 here
> https://lore.kernel.org/lkml/20230606231252.94838-6-william.zhang@broadcom.com/
> but there was some concern as it could possibly break the ABI in that
> thread's discussion.

That change did change the ABI that would have (AFAICT) broken it for BCM63168.

My point is: This binding in its current state is valid *only* for the
BCM63168 NAND controller, and not for any other BCM63xx NAND
controllers.

So changing the description to BCM63xx is wrong, unless you extend it
to also match the BCM6328/6362/6368 NAND controller bindings as used.

I can send a patch adding the missing binding parts, I actually have a
WIP one lying around as I started trying to address dts issues in the
MIPS bcm63xx dts(i) files a while ago.

Best Regards,
Jonas

