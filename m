Return-Path: <linux-kernel+bounces-90665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A74B8702E1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D9628AF0C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084473E48F;
	Mon,  4 Mar 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZMksxHI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1741EB2C;
	Mon,  4 Mar 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559535; cv=none; b=czBCKn2tpds9ZJ/JXL3vtq7m5VNinyKyNlxmn/KTqOBeNjA97DpIhPNYKXLHrX7omBy0bRk5RBbudwe5gm0gwVn0SP36trZWzIzb9wRvY2hQBsIELZJjoL4LWOW0akvsjd55rYaHL/Wpl03KNjkBq+d/oA/v5+82/EfDldQ6KeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559535; c=relaxed/simple;
	bh=FXo9W2jWdmeP+JJdvlkOdOBLnpOXWalykdF25smen3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ6gquzJU2zxId6g8JzvGH0x/ObMtBEwD2XGWZu3RYYMSlHsKwFcdWEKMeEPA/JNcrxa51S6eN9ZF4YiyW6Cjp7tZ2+P0bvIRAJflMfsqrb9ZAub/zMhjUHsMGq1aMw4+Lgp1twG/RKBry7F/0UgHjL1md8F6+IjXEIVSL56k0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZMksxHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B6BC433C7;
	Mon,  4 Mar 2024 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709559534;
	bh=FXo9W2jWdmeP+JJdvlkOdOBLnpOXWalykdF25smen3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZMksxHIj5/ILwrJERYOXzmQchIsiuHmjBbq8wdPHmJvADQzsDFhKn96NraVCmjwn
	 QwXxHmlrBlRGQo2jfGpe5/XW1Fc0LgWOLtluQVLwszWtcJgjUxjs/pG8khaQtbXa6y
	 BZJZ3HRxZzn2Dncqg7keLOXnzH0Ry8qZ+74BxGRitGLkzq6I5LzfUcmN+9/IqdWLr1
	 cCxL4e5HlOuwcThu4OpEIREOwypWrU619Wi/2rGj/DWZZHfFZn9lR9fpUbRWbjl9xP
	 W3gV84XJU7gUV5UwJWXy1CeOfnkk79GnJN6XVgMR1neZ/ahcvbcPn8T4OaPDdS6A/Y
	 c2dFvKFCgEXyA==
Date: Mon, 4 Mar 2024 07:38:52 -0600
From: Rob Herring <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: claudiu.beznea@tuxon.dev, tglx@linutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	alexandre.belloni@bootlin.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolas.Ferre@microchip.com, conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Message-ID: <170955953165.116756.5262999318809520557.robh@kernel.org>
References: <20240222090738.41628-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222090738.41628-1-dharma.b@microchip.com>


On Thu, 22 Feb 2024 14:37:38 +0530, Dharma Balasubiramani wrote:
> Convert the Atmel AIC binding document to DT schema format using
> json-schema.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changelog
> v3 -> v4
> - Move the allOf after "atmel,external-irqs" as it handles its restriction.
> v2 -> v3
> - Add constraints to the "atmel,external-irqs" property.
> - Move 'reg' before 'interrupt-controller' in the example.
> v1 -> v2
> - Drop the '|' as there is no formatting to preserve.
> - Remove unnecessary marketing statement from description.
> - Drop the description for interrupts and reg, it's obvious.
> - Put reg after compatible.
> - Drop comment in example.
> - Drop the example of device that is wired to an AIC as it's(dma) binding is
>   not yet available.
> ---
>  .../interrupt-controller/atmel,aic.txt        | 43 ---------
>  .../interrupt-controller/atmel,aic.yaml       | 89 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml
> 

Applied, thanks!


