Return-Path: <linux-kernel+bounces-25159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A382C8C3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD9B1C22CAD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2450A18623;
	Sat, 13 Jan 2024 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4AQeqgs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F01A5B9;
	Sat, 13 Jan 2024 01:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0082C433C7;
	Sat, 13 Jan 2024 01:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705109376;
	bh=4159aUol2be32Rm/FKh9kOm2pfBIwydY2bGQPvRtmBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4AQeqgsCooUB+nPotOSUsyOqjYIk4TKMkQgJD7r5BNKRw5DypK/PA6z4MGP90ide
	 p64gp9MwRuXNydAJPHExHjxBjvNnz/2V+ksCy44rulyM8QwEciSyqKVg2BHjvmHV15
	 7r/YQv6nYHqARkpOvrkv1qeIrQ1ue/03H8BFDmytRSyVvBgDWzU+4zqfkkD5brFGjf
	 4vNGEyCqaJ48++tfqcnU1+LFJ5DyVQVVJVTrRjG+AZdojA7ucrsZUW0/yhiC7UlGay
	 IFAAITOQw46OjEiW28GNNzmzKH/Cn9I9yw1LN3IfbJbwKREVOg861SNaUXO/RRXlzS
	 EDtw0N1B5LCsQ==
Date: Fri, 12 Jan 2024 19:29:34 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>, Pavel Machek <pavel@ucw.cz>,
	Kursad Oney <kursad.oney@broadcom.com>, Lee Jones <lee@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	William Zhang <william.zhang@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-leds@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Fern=E1ndez?= Rojas <noltari@gmail.com>,
	netdev@vger.kernel.org, Anand Gore <anand.gore@broadcom.com>,
	devicetree@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [net-next PATCH v9 2/5] dt-bindings: net: phy: Document LED
 inactive high impedance mode
Message-ID: <170510937346.3795602.13542241905094505502.robh@kernel.org>
References: <20240105142719.11042-1-ansuelsmth@gmail.com>
 <20240105142719.11042-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105142719.11042-3-ansuelsmth@gmail.com>


On Fri, 05 Jan 2024 15:27:14 +0100, Christian Marangi wrote:
> Document LED inactive high impedance mode to set the LED to require high
> impedance configuration to be turned OFF.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v5:
> - Add this patch
> 
>  Documentation/devicetree/bindings/leds/common.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


