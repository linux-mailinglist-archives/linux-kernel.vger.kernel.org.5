Return-Path: <linux-kernel+bounces-25158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CE882C8BC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E78B1C22842
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5205171DD;
	Sat, 13 Jan 2024 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZ2H2lYC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367AE18E0F;
	Sat, 13 Jan 2024 01:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7C3C433C7;
	Sat, 13 Jan 2024 01:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705109358;
	bh=3gfJsBCOj95iGvlfeaMcYo6PaAxu7sDaTS+k0H9585s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZ2H2lYC3WdyBqBjE/fndSo8j0bRYU8r17RvS+62ATm/UOXEVY1CMwgGtAsHTXJkE
	 QndEsSMVPn35VPcC5HNKtUFUU5c7zXFSTh8CKVMnPcktXfCp41220wr+aQ0yULSIj5
	 GXjStD13/wSc7tTpF+MLiNUmjU66HEptfh67W4S7sp658vAHHFhw7uR86MkMwAkRUN
	 KXQ6pv7w8KtwayBNAZBpKnJ2v2q6J3X/Cr525enlKGZHZdXzm8BslncFhNrsLcyJgC
	 ajbYvMZpEkXgPWM30x4KQxZTw2H3M7hSieCQEo+DkUSAe6Y5KbB8I8r121z7Z6qLJ/
	 hQofdf5OZO5IA==
Date: Fri, 12 Jan 2024 19:29:16 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Lee Jones <lee@kernel.org>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	William Zhang <william.zhang@broadcom.com>,
	Pavel Machek <pavel@ucw.cz>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-leds@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Anand Gore <anand.gore@broadcom.com>,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Subject: Re: [net-next PATCH v9 1/5] dt-bindings: net: phy: Make LED
 active-low property common
Message-ID: <170510935584.3795106.4060460999461861209.robh@kernel.org>
References: <20240105142719.11042-1-ansuelsmth@gmail.com>
 <20240105142719.11042-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105142719.11042-2-ansuelsmth@gmail.com>


On Fri, 05 Jan 2024 15:27:13 +0100, Christian Marangi wrote:
> Move LED active-low property to common.yaml. This property is currently
> defined multiple times by bcm LEDs. This property will now be supported
> in a generic way for PHY LEDs with the use of a generic function.
> 
> With active-low bool property not defined, active-high is always
> assumed.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v5:
> - Make active-low generic
> Changes v4:
> - Drop support for global active-low
> - Rework to polarity option (for marvell10g series support)
> Changes v3:
> - Out of RFC
> Changes v2:
> - Add this patch
> 
>  Documentation/devicetree/bindings/leds/common.yaml          | 6 ++++++
>  Documentation/devicetree/bindings/leds/leds-bcm63138.yaml   | 4 ----
>  Documentation/devicetree/bindings/leds/leds-bcm6328.yaml    | 4 ----
>  Documentation/devicetree/bindings/leds/leds-bcm6358.txt     | 2 --
>  .../devicetree/bindings/leds/leds-pwm-multicolor.yaml       | 4 ----
>  Documentation/devicetree/bindings/leds/leds-pwm.yaml        | 5 -----
>  6 files changed, 6 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


