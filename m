Return-Path: <linux-kernel+bounces-67077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 619328565DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF1E2857DB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B826A131E3E;
	Thu, 15 Feb 2024 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2K+w9sh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F72131E39;
	Thu, 15 Feb 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006960; cv=none; b=F80wWb4bYIdTAK0XZTmiywVRDRFbOhdAFcsVhRdO138KOMkS5nuk5IMFkoDBs0kQWfQ7XuCr3RYrnNnsHfIGcYZDIgJDkJYkvaTnddA1VZxPiaw5QhmySaXqLxJAjvOpO5/r3ue80wb0qiqebogN+ZVLMjGwgy5hyL6dV/xs2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006960; c=relaxed/simple;
	bh=l+336At4EwqzrdcdtaMKIg1sTlgNtKukVt4yUFiWdig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjO0NJDW8klVo2T0MjaAioQxOJIuaFdn0vCrBHXvJv29RefncXKiGt8epWNVSeuMGnV6ycSy6EC6N5qIPmjreOoxIC7cdsBPxG48MvrDiWLIkGdbg4QOFmp2B6pOzpznXZas7JC35JA+ncpzzt1TWedZV20Bd0SYJPTv0n/8ao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2K+w9sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328B5C433F1;
	Thu, 15 Feb 2024 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708006959;
	bh=l+336At4EwqzrdcdtaMKIg1sTlgNtKukVt4yUFiWdig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2K+w9shzEaitONTGUeCocxPOP1zzDQSHX26JgvUh/DbAXiaNnkqYhCpWOXm1bnP3
	 Fz6gU/S2fcFEpc9AESrAj+4CKeSJgXooy5uKMuaklGcyqtb9s99WiyblIRC5qtcCi6
	 DNMAf3qdvRU3677x0a4NCHXwwZoVvrbH/yODwJM1Qmdk9v/zgBjF52tN+bhD0iFtDM
	 14Djci5CTr20jjpDSMu38CMVQwGOCi2i1m2lZ7JjlSVHXI//qHdXR9xPeSQnGMSHP+
	 qQ1fjE9c3IhfZpl7034NzaUSI3IojPw2ndqaghu4CuVEkpw/Bttj94BLUCHf+TXZEM
	 Z/0wlmpha2KcA==
Date: Thu, 15 Feb 2024 08:22:35 -0600
From: Rob Herring <robh@kernel.org>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/6] dt-bindings: input: add entry for Marvell
 88PM88X PMICs onkey
Message-ID: <20240215142235.GB4180777-robh@kernel.org>
References: <20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz>
 <20240211094609.2223-5-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211094609.2223-5-karelb@gimli.ms.mff.cuni.cz>

On Sun, Feb 11, 2024 at 10:35:54AM +0100, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
> 
> Marvell 88PM88X PMICs provide onkey functionality -- add the bindings.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
> 
> Notes:
>     RFC v2:
>     - Add wakeup-source property and reference onkey schema from MFD.
>     - Reword commit message.
> 
>  .../bindings/input/marvell,88pm88x-onkey.yaml | 32 +++++++++++++++++++
>  .../bindings/mfd/marvell,88pm88x.yaml         |  8 +++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml b/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
> new file mode 100644
> index 000000000000..5d3d451d0e1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/marvell,88pm88x-onkey.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/marvell,88pm88x-onkey.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Onkey driver for Marvell 88PM88X PMICs.
> +
> +maintainers:
> +  - Karel Balej <balejk@matfyz.cz>
> +
> +description: |
> +  This module is part of the 88PM88X MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml.
> +
> +  The onkey controller is represented as a sub-node of the PMIC node in
> +  the device tree.

Why do you need a child node? You don't. Just add 'wakeup-source' to the 
parent.

> +
> +allOf:
> +  - $ref: input.yaml#

Doesn't look like you are using any properties from this?

> +
> +properties:
> +  compatible:
> +    const: marvell,88pm88x-onkey
> +
> +  wakeup-source: true
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +...

