Return-Path: <linux-kernel+bounces-7148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776E181A24A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE751C20CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D84778F;
	Wed, 20 Dec 2023 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPUCjTa2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC54778D;
	Wed, 20 Dec 2023 15:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BEAC433C8;
	Wed, 20 Dec 2023 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703085731;
	bh=/VBEJow9gZvDr3dfVllZGJwgfM/5tIcquyK819mX7Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPUCjTa2by5PlCM/epGHDql/dkP1aSRo7SsmjSgHp7GxMPmhqbjFPV9zEptgfMbQO
	 dx8Xg/s1rJCz2HqfzQe7eOyL6jTqv2mghxi0SFz7w5MI+3WDqPmasE+N2nHoiYygNw
	 +ILdlv/Kz7/A6cXBRXOw0cKqom6EsXzDxns3c5KRncm4xfBUcNdTWjLHSx2xJ4Goda
	 nIK/AikrMbJwkhK+wz6yKU/oVfEP7aGDfo1rBCY/zQTgKdY9LlnhU5QniA6sUSjEuW
	 qP0+sm7GvrbZzn1OGxPN2/kfS25No7hemBDnUnR+VaycRl9rtUoApcIAs0UJNLD1wG
	 dBfVyCwZDBskQ==
Received: (nullmailer pid 242348 invoked by uid 1000);
	Wed, 20 Dec 2023 15:22:09 -0000
Date: Wed, 20 Dec 2023 09:22:09 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [net-next PATCH v4 1/4] dt-bindings: net: phy: Document new LEDs
 polarity property
Message-ID: <20231220152209.GA229412-robh@kernel.org>
References: <20231215212244.1658-1-ansuelsmth@gmail.com>
 <20231215212244.1658-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215212244.1658-2-ansuelsmth@gmail.com>

On Fri, Dec 15, 2023 at 10:22:41PM +0100, Christian Marangi wrote:
> Document new LEDs polarity property to define what mode the LED needs to
> be put to turn it on.
> 
> Currently supported modes are:
> 
> - active-low
> - active-high
> - active-low-tristate
> - active-high-tristate

Why is having a polarity unique to LEDs on ethernet PHYs? It's not. We 
already have 'active-low' established on several LED bindings. Please 
move the definition to leds/common.yaml and extend it. I would simply 
add an 'inactive-tristate' boolean property (if there's an actual user). 

I do worry this continues to evolve until we've re-created the pinctrl 
binding...

Rob

