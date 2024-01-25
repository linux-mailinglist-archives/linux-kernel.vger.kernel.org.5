Return-Path: <linux-kernel+bounces-38655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359FF83C3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C51292255
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3689956767;
	Thu, 25 Jan 2024 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft1hS6ad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA54F212;
	Thu, 25 Jan 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189592; cv=none; b=qC+0UUPrt6BS3LifA+uTh5bR7j3kb+TSsj07AU6hXGfnBfMKccw+LLwSbgLnxGBUmynSzQ2s9zB5b+GEJb0/lG/iuUOd9NQRYIut4tlymR2e204Bky5r0H09wPzh4Ix1ojTc2ScbywQDmWCt4RpIShwpCmkOR3pGk2hbewz4Phc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189592; c=relaxed/simple;
	bh=oR73ElII+Ea6VkMoxYabaKds5uCTTrP+pC0GdwTuXJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t4xTg+fLjrBx3R//vSMBCADbiIC+2GcG9PD6p5LIyNqXXmI8BhK+ZxE5OR6fkpxNXmUy9GFNbgepIxhqdwKydrKJ4Ry4DCajpb7oYxA1QGjhH/UhC9uMYrdfdWruC67ErD7DOCxkelTR5At9EKn01xmi1TrztdSfuhGSzSIJ2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft1hS6ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6A0C433C7;
	Thu, 25 Jan 2024 13:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706189592;
	bh=oR73ElII+Ea6VkMoxYabaKds5uCTTrP+pC0GdwTuXJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ft1hS6adPP9rT33QQ5YF1IUjkQU/i4uGCPgGGVy6fv1v2/1MWLgEGyW/yBxL4fCtf
	 /wkb2OI9H150wo5Ql7HEXpRbe6897kQEKEGKHd3CikE5FnL5h/PglTcLXo5+yWdCDC
	 64ReazRq9rCEAlsrkEQhEjq/xPmVv3suG7qTNOWHB/4h2e8A8/tZ+NVDa51ip3frcV
	 CZAxmGk0/UjHSc4LHzDEQUegYEpJUdE/ELITIWFt3WdWC9ECx7Jp4mYVW5uf+FJq6G
	 Pk+hFzHICw75gO4/fNn20eCl/m/jk1jfpAGR5vguJLF6FjGrvOdv//+8coaoDZQylW
	 rAqX5U2Yzcefw==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, openwrt-devel@lists.openwrt.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20240117151736.27440-1-zajec5@gmail.com>
References: <20240117151736.27440-1-zajec5@gmail.com>
Subject: Re: (subset) [PATCH] dt-bindings: leds: add FUNCTION defines for
 per-band WLANs
Message-Id: <170618958957.1465772.9140099725352786170.b4-ty@kernel.org>
Date: Thu, 25 Jan 2024 13:33:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Wed, 17 Jan 2024 16:17:36 +0100, Rafał Miłecki wrote:
> Most wireless routers and access points can operate in multiple bands
> simultaneously. Vendors often equip their devices with per-band LEDs.
> 
> Add defines for those very common functions to allow cleaner & clearer
> bindings.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: leds: add FUNCTION defines for per-band WLANs
      commit: 89d9d3eedc8804e06a770e3cf1279f9131b785f1

--
Lee Jones [李琼斯]


