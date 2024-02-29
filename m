Return-Path: <linux-kernel+bounces-87153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBCD86D051
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C241F22281
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAE56CBF4;
	Thu, 29 Feb 2024 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfToqY1U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8656CBF3;
	Thu, 29 Feb 2024 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227007; cv=none; b=r2KvZIfwwPX0H8WcoHfrqCBcJcvvbczzyYDXqHeGZ1a/O/BBxCIe9/IIhvaBsTAZDYAgD17Hl3znBssHHmQGKzcvRMSe2iqqyrTjbjBx4JXir3wnhg2gj85H7XONfG2CdUiWyVa1XJuW38Qy8tfnIaouVVIqGLxUB37nlYcP0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227007; c=relaxed/simple;
	bh=sO1V/9+1+1pxQKgovU9SQDqskwQ8QcDLkagOKz3zDZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nzZYrh6upu+pVRf7j4ZRq8+8tEKg2IO+gfX6+eCdoev3VPsbceng375WW2TAtYrPii15zLhjHft1y/dhi2IH8z+NFr3U+gzOMkAKeJ3oj5hzK+WF7xRCQjZbBp+sl7QCTT15ZnnKEm1AmG0Pw5lebzCILS3oVnyxCHXwv/vqlWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfToqY1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1824CC433C7;
	Thu, 29 Feb 2024 17:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227006;
	bh=sO1V/9+1+1pxQKgovU9SQDqskwQ8QcDLkagOKz3zDZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mfToqY1UgqQ+hOSLiBwz5q1cVaoYgKNvmupbOIIYnauOFK0aKp92jB6ZmhbylaFeY
	 8r1F4/C3a/qPC19E63rOohIBGLpGSCl6j6AM4f3cqoiD/+9zKRNuWCw2ZQqfB0c8I0
	 r9qSGfwE2kzt7oAfOLU+OrnNo4UnjgqcQNyVYgWUnUeWEjw7C/KEtkEpdUP+b12pP2
	 UGVn81mjeg3vt9JnfV3jkn5O33wDyeHynm9zXszN08fTUR6I6dHVP1v4V5CCY6Lvvx
	 a/RDIRsfMEd1o/ja99bO2sus/5QmQKyqPEktgo2/km7KLbNReQu/GNcd5vbsq5q3I4
	 RiWHgCLEWgH4w==
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Roger Quadros <rogerq@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Rob Herring <robh@kernel.org>
In-Reply-To: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-1-acf77fff4344@kernel.org>
References: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-0-acf77fff4344@kernel.org>
 <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-1-acf77fff4344@kernel.org>
Subject: Re: (subset) [PATCH v6 1/4] dt-bindings: mfd: syscon: Add
 ti,am62-usb-phy-ctrl compatible
Message-Id: <170922700382.1610849.6482403854629206955.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 17:16:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 26 Feb 2024 14:03:07 +0200, Roger Quadros wrote:
> Add the compatible for TI AM62 USB PHY Control register. This
> register is found in the TI AM62 WKUP_CTRL_MMR0 space [1]. It
> is used to indicate the USB PHY PLL reference clock rate and
> core voltage level to the USB controller.
> 
> [1] - https://www.ti.com/lit/pdf/spruiv7
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl compatible
      commit: e9f06bd428d3f07c8d26506ed35d9f8bb836950b

--
Lee Jones [李琼斯]


