Return-Path: <linux-kernel+bounces-143919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE82D8A3F8F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 01:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696DC282289
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8B58AA1;
	Sat, 13 Apr 2024 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFyuaQr3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C85467B;
	Sat, 13 Apr 2024 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713050522; cv=none; b=AIYdwWeRSt+ZiLfBOtiMgT2r5kryQYyBR2iSGUk4puOHtFEQvtD+KYsmy5+EZm8bjWe9l2N1/hEhZqT/OxqAkRdZ/02eJq4EYmLwS66whHX8tx9UDyzFttfe5olagNzzXbtWIIpgitRqFz0KSt6i0rdHRA61e6zizRgWphZi3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713050522; c=relaxed/simple;
	bh=5sXxlITJ7ccJ9IO677OflEjBXzzDrtBJfYoq9+yqxrU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=SRAdTgZ8caOvRH1jpj/DQnTfPKCSIUTai78S+OsR0xvqg0bs8PHEbSyrUOTocYCaF5s65e7pCPYTTMEfDk/0NAPoaWZ+mGjZV7lbBdGirWGcGw3kJlf+ASRNEHC5g3aC+OTlVk9GyAAovQm8GTWbY+BZ+Gcm/NaSnJ81eA5FgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFyuaQr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A165C113CD;
	Sat, 13 Apr 2024 23:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713050521;
	bh=5sXxlITJ7ccJ9IO677OflEjBXzzDrtBJfYoq9+yqxrU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=JFyuaQr3iqQKPC3xtPcJKTaugcMkzIT3+QIOscOXXPPIAWkz1ntYjYcdZteFXXi3v
	 WTrMgBDobIDYSheTLC/8akivtt+2h2244i7XFd/+ir3mL7G+uNH2tkHJ5UntJ3GPHh
	 gOhLL+TdmbhAsYZUhZV1vDuG6DbL0pEVjoss5UQzdISlghAcnLUVRodgcL/1BbRtE3
	 qg/KGhqEkEjJRbRLsX0iEB7lt+r8fvYhXGzdKxZI8fyHiETLYsm6hDos92lg4EUV06
	 1A/70+KgVh67zAHTAjzIK5maFaDE/FzjglALJq5r/No5qOIXY9jQSWflfCZtAHpaVx
	 Bhszc9/Mg5H9A==
Date: Sat, 13 Apr 2024 18:22:00 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Phil Elwell <phil@raspberrypi.com>, linux-gpio@vger.kernel.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, Kamal Dasu <kamal.dasu@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Jonathan Bell <jonathan@raspberrypi.com>, devicetree@vger.kernel.org, 
 Al Cooper <alcooperx@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <2d1272cad92ad618297a6683e9264e31b8f2df73.1713036964.git.andrea.porta@suse.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <2d1272cad92ad618297a6683e9264e31b8f2df73.1713036964.git.andrea.porta@suse.com>
Message-Id: <171305051859.2373978.16308105985451713694.robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: Add support for BCM2712 pin
 controller


On Sun, 14 Apr 2024 00:14:23 +0200, Andrea della Porta wrote:
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../pinctrl/brcm,bcm2712-pinctrl.yaml         | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:46:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:47:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:48:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:49:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:50:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:51:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:52:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:53:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:54:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:55:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:56:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:57:18: [warning] wrong indentation: expected 18 but found 17 (indentation)
/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml:58:18: [warning] wrong indentation: expected 18 but found 17 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2d1272cad92ad618297a6683e9264e31b8f2df73.1713036964.git.andrea.porta@suse.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


