Return-Path: <linux-kernel+bounces-32963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4CA836284
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9DE1F2890C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADD83D0BD;
	Mon, 22 Jan 2024 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emBBdGaB"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6243C48D;
	Mon, 22 Jan 2024 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924099; cv=none; b=tEV4Y6prV4GUX3vtw0xZXShM6ICFgOVn9ZdCJq8HUlnDle3kNarTOXUUCw0+Ilvkey3VFC4GyvE67TZGuw3HvGYzQkMYG+Ge7vXUbg1bq079phqR+Lyn66TobNjg/+mtNT2XyUsv8oUEgXMwXr6mwBaqbrthQ0u/OoOF6rkcBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924099; c=relaxed/simple;
	bh=IW8JAQINhJrqE1I8Cqc2nNPE7CIP0vSa0LewGZv1Lhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHMP+wBkGVgM6knCKzEnE7Xrrp/iaaQxn4MJPu00IkDMyvMCv2PQLDsjwPPyGmc2TwxhgVzwLQU0d3hjYr3yuwgwlIQOfPMEfpB6vv95LQGNOgQZpv55wpi2lrPR4etxS5B8y0a4EtI7L+GT0hopTJXw+07EICqnRBh/7S3Kk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emBBdGaB; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2906b859560so462252a91.1;
        Mon, 22 Jan 2024 03:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705924097; x=1706528897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmCR5Hs59/0vtuduKlpgs+GpqISPKERHfnKxl2Hek7k=;
        b=emBBdGaBODMIJVvk/QT3kDAWOwKliB0VqbHe9V84cud2Zi83uMLexEF/4u8bNKfFQh
         wx36EJbj2TLB+mcNN0y05t6BfvL70A2G3Yq8OOB8Fz16pn1c53XUoKOese+oUuQW8MwD
         U0EJUl2Q14cKJ2T4veXWwoNjQsDTxL40FPpbIcMrL7FPgrEKAW9Dciuc0KwNazEcNyv3
         FLJ/DfORNkJ2kt5jY/EiPliAJ8fQIFTW7ZI7hkDSVIdJB+YJOUOphfQZo2Zd/I2R0tS/
         J7Ix86SmTPGTvxTf3sovnBxNNqaCDXszg2Gpt+++f2plrkY9Ipc5qV/5GZv5G/0/Czlg
         G/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705924097; x=1706528897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmCR5Hs59/0vtuduKlpgs+GpqISPKERHfnKxl2Hek7k=;
        b=pKshwOo39tkWU7vo1Q5fm8Y61N8izsqwtKHvdCZNEcmhhTS+PpGrLm6qUISv+WDI5p
         wBRudUraafqAXLQoXZnh1xpYRor3tzFGmSCIHLfXrCQg8EAgGoRD8RIGdX1ZKsajwh0e
         KaZ3MOoReiJt4/36SpDkCSycXVvfkoGlPkjOivdMNJibnXXkYY+E2FzUvXtL39yAt9He
         uG0ck8F15PAPT9JS8tMSXPzjU33Ae31I02yuwrKFNuICVmemPrmNbVQ0jETk2UBVbuil
         ABCEp8Zlw7D2/6AdQMuvAF9uwAg2t1uNp2muSdRzfQ5JTluLgB2Lw8pV3Xa73p5fqj1M
         NRTg==
X-Gm-Message-State: AOJu0YwMm6iSvtEVwlmysHmLMN1jfBBK/l5GJM4lrZKbyWb+KUMD/qyF
	Xgis6Ci7LSDIgXD2m4YMoHyyC84TFKXs4mVDrFgBv2voHwhJnddfXRx+csnfe7kFzRKRtChmhRn
	55hJDx56kEwPlQUdaDHthswQ0IeI=
X-Google-Smtp-Source: AGHT+IHbJKr0+ESj/7wEsolCjUfhmX5aIfeStUtaEjVhlvaoVw+P+Od3BmO0j+0slKfHsE4bNUCILoUPH2kUJuGqtHk=
X-Received: by 2002:a17:90a:fe95:b0:290:b5b2:b90c with SMTP id
 co21-20020a17090afe9500b00290b5b2b90cmr333726pjb.58.1705924097190; Mon, 22
 Jan 2024 03:48:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118195356.133391-1-dregan@broadcom.com> <20240118195356.133391-2-dregan@broadcom.com>
In-Reply-To: <20240118195356.133391-2-dregan@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 22 Jan 2024 12:48:05 +0100
Message-ID: <CAOiHx=k2Wn+UaVFbB-n2XKmFuBss4LKmLSW45YME07z=7zg0ww@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
To: dregan@broadcom.com
Cc: dregan@mail.com, miquel.raynal@bootlin.com, richard@nod.at, 
	vigneshr@ti.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, computersforpeace@gmail.com, kdasu.kdev@gmail.com, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joel.peshkin@broadcom.com, 
	tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com, 
	william.zhang@broadcom.com, anand.gore@broadcom.com, kursad.oney@broadcom.com, 
	florian.fainelli@broadcom.com, rafal@milecki.pl, 
	bcm-kernel-feedback-list@broadcom.com, andre.przywara@arm.com, 
	baruch@tkos.co.il, linux-arm-kernel@lists.infradead.org, 
	dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 18 Jan 2024 at 20:56, <dregan@broadcom.com> wrote:
>
> From: William Zhang <william.zhang@broadcom.com>
>
> Update the descriptions to reflect different families of broadband SoC and
> use the general name bcmbca for ARM based SoC.
>
> Add brcm,nand-use-wp property to have an option for disabling this
> feature on broadband board design that does not use write protection.
>
> Add brcm,nand-ecc-use-strap to get ecc setting from board boot strap for
> broadband board designs because they do not specify ecc setting in dts
> but rather using the strap setting.
>
> Remove the requirement of interrupts property to reflect the driver
> code. Also add myself to the list of maintainers.
>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>
> ---
> Changes in v2:
> - Revert the new compatible string nand-bcmbca
> - Drop the BCM63168 compatible fix to avoid any potential ABI
> incompatibility issue
> - Simplify the explanation for brcm,nand-use-wp
> - Keep the interrupt name requirement when interrupt number is specified
> ---
>  .../bindings/mtd/brcm,brcmnand.yaml           | 36 +++++++++++++++----
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> index f57e96374e67..56176ec1a992 100644
> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
>  maintainers:
>    - Brian Norris <computersforpeace@gmail.com>
>    - Kamal Dasu <kdasu.kdev@gmail.com>
> +  - William Zhang <william.zhang@broadcom.com>
>
>  description: |
>    The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
> @@ -18,9 +19,10 @@ description: |
>    supports basic PROGRAM and READ functions, among other features.
>
>    This controller was originally designed for STB SoCs (BCM7xxx) but is now
> -  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
> -  iProc/Cygnus. Its history includes several similar (but not fully register
> -  compatible) versions.
> +  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
> +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
> +  Its history includes several similar (but not fully register compatible)
> +  versions.
>
>    -- Additional SoC-specific NAND controller properties --
>
> @@ -53,7 +55,7 @@ properties:
>                - brcm,brcmnand-v7.2
>                - brcm,brcmnand-v7.3
>            - const: brcm,brcmnand
> -      - description: BCM63138 SoC-specific NAND controller
> +      - description: BCMBCA SoC-specific NAND controller
>          items:
>            - const: brcm,nand-bcm63138
>            - enum:
> @@ -65,7 +67,7 @@ properties:
>            - const: brcm,nand-iproc
>            - const: brcm,brcmnand-v6.1
>            - const: brcm,brcmnand
> -      - description: BCM63168 SoC-specific NAND controller
> +      - description: BCM63xx SoC-specific NAND controller

Only the BCM63268 family has a v4.0 NAND controller with support for
ONFI and raw access; BCM6368 has a v2.1, and BCM6328 and BCM6362 have
a v2.2.

So claiming this is a generic binding is wrong; you would need to add
the appropriate variants first. Or add another one for the BCM6368
NAND v2.x controllers, which is missing. You can find them used in
arch/mips/boot/dts/brcm/bcm63{28,62,68}.dtsi.

>          items:
>            - const: brcm,nand-bcm63168
>            - const: brcm,nand-bcm6368

Also bcm63168's v4.0 has a different register layout than bcm6368's
v2.x, so claiming brcm.nand-bcm6368 as compatible here is a bit weird.
It works because the register layout used is derived from the
"brcm,brcmnand-vX.Y" compatible, and the driver attaching to
'brcm,nand-bcm6368" only uses the shared interrupt registers which are
identical, the layout only diverges after that.

But then again these aren't really used as compatibles in the original
sense, and more like tags which describe different parts of the
controller, and the combination is the whole unique "compatible". Not
sure if this is how compatibles are supposed to be used. /rant.

Best Regards,
Jonas

