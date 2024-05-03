Return-Path: <linux-kernel+bounces-168340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B378BB6FA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925901C244C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ED55BAF0;
	Fri,  3 May 2024 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqd3wEFd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5094CDE0;
	Fri,  3 May 2024 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774571; cv=none; b=mmW7wLP+AdBySrlmAoq+d/ZIY/nUal5/nyNxNSldmmji1FpI/bhalFEyUePoVrfr8xJc8FciZ9lQfNj6Q9gP2MV0pHHWS9SKR7N4GD8VZ9bqfDORZ+CwN+z5Zic/dguWRwAC+iULnv/YcZijfR/8rPaaoyXhPJQyV3yXzE68Fxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774571; c=relaxed/simple;
	bh=/UJu1Ov70BGuD271Kroj1aGJrc0n51VS/Nnq25arbrk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=pSaBXcyMmktA5QLLXp+TezU7nnf+NgtL/T1hIxAVbWDUzPNBO9Uf2v4+ruSHj1Vt/291lqRx2310o012NwnyKwEG++Xwnu/EP7XAgxYjgwV0lFUSaLCjVak++LQ2HqgsaAn0SJkbi8c8WZcGFPetDB9y1MiDsHw5JffCRg2WM8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sqd3wEFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDCBC116B1;
	Fri,  3 May 2024 22:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714774570;
	bh=/UJu1Ov70BGuD271Kroj1aGJrc0n51VS/Nnq25arbrk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Sqd3wEFdli/3nBIAxEQRsE9SruP28ELXjSws6p4x9+nB1JuIEgsRodtoMBnIKhswT
	 692ZoZdsdLNcG3d/EJNbQFY9SgCHgVQ+h0tjmrUsYotwzJEMmGMGsbKXHn0/PLLd1N
	 Wn3uUW64QR9+Ynu7uku7/c/HNmrIYSdGA3nz3FER+oxY8aPWnXoFbtMrc7zLfsYNVh
	 Ov95K9wlcK2wtR7n6KXzwzanrILRdoHLDhMQQJNwW7IlQgsixbwmrUUeydujHeNf5l
	 sJADaoWLo5f7hTJLycotZyCUyswWW9qeUKH9gOFbSB5lde9ngz08w5t6e9vRLruLfB
	 82r21W9jZyNCQ==
Date: Fri, 03 May 2024 17:16:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>, 
 =?utf-8?q?Daniel_Gonz=C3=A1lez_Cabanelas?= <dgcbueu@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org
In-Reply-To: <20240503212139.5811-4-ansuelsmth@gmail.com>
References: <20240503212139.5811-1-ansuelsmth@gmail.com>
 <20240503212139.5811-4-ansuelsmth@gmail.com>
Message-Id: <171477456930.1857104.15200554671056631850.robh@kernel.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: mips: brcm: Document
 brcm,bmips-cbr-reg property


On Fri, 03 May 2024 23:20:59 +0200, Christian Marangi wrote:
> Document brcm,bmips-cbr-reg and brcm,bmips-broken-cbr-reg property.
> 
> Some SoC suffer from a BUG where read_c0_brcm_cbr() might return 0
> if called from TP1. The CBR address is always the same on the SoC
> hence it can be provided in DT to handle broken case where bootloader
> doesn't init it or SMP where read_c0_brcm_cbr() returns 0 from TP1.
> 
> Usage of this property is to give an address also in these broken
> configuration/bootloader.
> 
> If the SoC/Bootloader ALWAYS provide a broken CBR address the property
> "brcm,bmips-broken-cbr-reg" can be used to ignore any value already set
> in the registers for CBR address.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mips/brcm/soc.yaml    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/mips/brcm/soc.yaml:83:37: [warning] too few spaces after comma (commas)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240503212139.5811-4-ansuelsmth@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


