Return-Path: <linux-kernel+bounces-86548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ABA86C6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83275B2819F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288664CCF;
	Thu, 29 Feb 2024 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WMmPu6Ae"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8E6351F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202505; cv=none; b=hxvmubYb309SDH4BZWqc3rOLJyOX8l1s4vivyo3DRADO6o/XGwOt+/XavYyTfUOPMCDJCAF18HxSFRMpsrcnBRTmtqXqjhafBxgQAK9fjZ0sGWnauthVGdt7aMITzncUbX65yX1VHl3I9mmn/kOq0/qaFoa0raB5N8z4K/At7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202505; c=relaxed/simple;
	bh=eeDD+DeKPSDr1WtjESPvm1w22Z1MROiKdpETcntfyV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoXfg3JITKegSHBmaWuYruNMmEfZpCx8ImVPj7vhil+vBxXQn2nRuGIKLr6yOLoOlpYZdejTM9Af8lhl1RfRzV0eqwMMBtLtW6W5MsHC9sZjHp4Dy+irCBbMHYSS0mcHfp920OB3cLZycTZip3ySvCox4/Yrn/kR/IDh9eM38co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WMmPu6Ae; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A52D4FF802;
	Thu, 29 Feb 2024 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709202501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eeDD+DeKPSDr1WtjESPvm1w22Z1MROiKdpETcntfyV4=;
	b=WMmPu6AeTOOvO9e3UT4x19t9GFPYH0LGFFUQsBwx8l0vP+1L/K+2sdLQapD0182T0lZcyu
	TK+O2BbD4jkaRTBhkMci3nnL1OVZHJi46rMfi+t8LFBMKd2nA3r7aUas6xauxSp3H4bNoQ
	PcTh289wCQF6ZUEMVywtncbBCbUUPPRK3e19n4KnK+PeKIB6g7zn3WehLmVLMoG/T14Qgf
	PFvpZu1w01J93H7xcXRnc8MaJq/8WoLFJns7t9NW7Fk94+U+jUCg5DG+Vr7ArK8N7hpMXI
	fhkiJS4mXzaNhrkSDlYAICLzgrL+xpSuUiNc0M+XuTxeFwGNBQdtMiep3143ZQ==
Date: Thu, 29 Feb 2024 11:28:18 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, f.fainelli@gmail.com,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com, David Regan
 <dregan@broadcom.com>, linux-kernel@vger.kernel.org, Vignesh Raghavendra
 <vigneshr@ti.com>, Brian Norris <computersforpeace@gmail.com>, Richard
 Weinberger <richard@nod.at>
Subject: Re: [PATCH v7] mtd: rawnand: brcmnand: Add support for getting ecc
 setting from strap
Message-ID: <20240229112818.2e54d0f6@xps-13>
In-Reply-To: <20240227201253.31978-1-william.zhang@broadcom.com>
References: <20240227201253.31978-1-william.zhang@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi William,

william.zhang@broadcom.com wrote on Tue, 27 Feb 2024 12:12:52 -0800:

> This is the update to the patch 12 in the original series [1] that was
> applied to nand-next except this patch.

This is context. While interesting, it should not be part of the commit
log but instead located...

>=20
> BCMBCA broadband SoC based board design does not specify ecc setting in
> dts but rather use the SoC NAND strap info to obtain the ecc strength
> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
> this purpose and update driver to support this option. However these two
> options can not be used at the same time.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>
>=20
> [1] https://lore.kernel.org/lkml/20240223034758.13753-1-william.zhang@bro=
adcom.com/

This as well should be below.
>=20
> ---

..here.

Thanks,
Miqu=C3=A8l

