Return-Path: <linux-kernel+bounces-23445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207CE82ACCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60E12830DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101C6154AA;
	Thu, 11 Jan 2024 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXydpx5Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370515482;
	Thu, 11 Jan 2024 11:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0942C433C7;
	Thu, 11 Jan 2024 11:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704971012;
	bh=bI1Tet5jDj/QH09wURUJK1NElS1yuV/fwxx+hGurCKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXydpx5YYq7Gt4XhTMlirofDbH/GMG4JFQlhuY7CLC45RscIa+dfuNP803StsPw4j
	 n/UR34vmiBCA5F5LI5+rTkeauMcYorGlS7G839valCfkC8HrstTBx/HJsz6aG/7HPW
	 0Dc/Zw10+M/cbeekw5rO3Q4C8RFcHWRO0oUmMto6iyj7jTZEYb/tzmOLpyuIpMrkle
	 rT74OZ9SuM4hEjuUvmH/w+kcmqEybvzeiuRI5mLvZvnafUfn+u4YJWb7y0p2tW7toF
	 0YZdGHN5h95Yfef+oqzDKrSKm8BoCpRNP7GIQ5gIchh5x8DU1Sg6DKuGEhiBjyddh0
	 ws0TlA9d2M/Dg==
Date: Thu, 11 Jan 2024 11:03:25 +0000
From: Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Subject: Re: [net-next PATCH v9 1/5] dt-bindings: net: phy: Make LED
 active-low property common
Message-ID: <20240111110325.GE1678981@google.com>
References: <20240105142719.11042-1-ansuelsmth@gmail.com>
 <20240105142719.11042-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240105142719.11042-2-ansuelsmth@gmail.com>

On Fri, 05 Jan 2024, Christian Marangi wrote:

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

If the DT Maintainers are happy, so am I.

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

