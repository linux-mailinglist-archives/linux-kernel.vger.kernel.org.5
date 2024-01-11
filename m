Return-Path: <linux-kernel+bounces-23482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9612582AD58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF8B1F22B64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF3A154BD;
	Thu, 11 Jan 2024 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBTO0rWF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927E154AC;
	Thu, 11 Jan 2024 11:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBC1C433A6;
	Thu, 11 Jan 2024 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704972403;
	bh=ZIWRy+xjY6IT5ij6R/Vb7UhT0I45ahpnU35t0mqhwaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBTO0rWFAH6NH7qj5EdoUo93cBBFXywZeeO4eLzzKNdf/jJNY1ZmmdUY8aX02m4LL
	 sHRootAdW7DbUjFVp8tEDblrymA4js3Zd1yZJRnEUOsDuCHeS10O19SGdwAWSMJGhN
	 /K94pPoHXu/oIv75ME8Zug9Om0Ry2j03k9kXBZsvCu9pkpUu2BcArNBONDPzbtrsCo
	 Fa9bCWPwMeCEJJkeDjAwKyQNjIeOWXtEKgh06VmaQfzWZc4HP9x7baM+LnxLl7R47o
	 1fM5W6aXyE2gfB1EoMRK1Mw+nfm4CpMZ4piq7f9d/XYa1W3uJ4TCpldCsMjVxqFuNd
	 SVpSd2DO0GBCw==
Date: Thu, 11 Jan 2024 11:26:38 +0000
From: Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 2/2] docs: ABI: sysfs-class-led-trigger-netdev:
 Document now hidable link_*
Message-ID: <20240111112638.GG1678981@google.com>
References: <20231221171125.1732-1-ansuelsmth@gmail.com>
 <20231221171125.1732-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221171125.1732-2-ansuelsmth@gmail.com>

On Thu, 21 Dec 2023, Christian Marangi wrote:

> Document now hidable link speed modes for the LED netdev trigger.
> 
> Link speed modes are now showed only if the named network device
> supports them and are hidden if not.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> ---
> Changes v6:
> - Add Reviewed-by tag
> Changes v2:
> - Add this patch
> 
>  .../ABI/testing/sysfs-class-led-trigger-netdev       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Lee Jones <lee@kernel.org>

> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
> index a6c307c4befa..ed46b37ab8a2 100644
> --- a/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-netdev
> @@ -88,6 +88,8 @@ Description:
>  		speed of 10MBps of the named network device.
>  		Setting this value also immediately changes the LED state.
>  
> +		Present only if the named network device supports 10Mbps link speed.
> +
>  What:		/sys/class/leds/<led>/link_100
>  Date:		Jun 2023
>  KernelVersion:	6.5
> @@ -101,6 +103,8 @@ Description:
>  		speed of 100Mbps of the named network device.
>  		Setting this value also immediately changes the LED state.
>  
> +		Present only if the named network device supports 100Mbps link speed.
> +
>  What:		/sys/class/leds/<led>/link_1000
>  Date:		Jun 2023
>  KernelVersion:	6.5
> @@ -114,6 +118,8 @@ Description:
>  		speed of 1000Mbps of the named network device.
>  		Setting this value also immediately changes the LED state.
>  
> +		Present only if the named network device supports 1000Mbps link speed.
> +
>  What:		/sys/class/leds/<led>/link_2500
>  Date:		Nov 2023
>  KernelVersion:	6.8
> @@ -127,6 +133,8 @@ Description:
>  		speed of 2500Mbps of the named network device.
>  		Setting this value also immediately changes the LED state.
>  
> +		Present only if the named network device supports 2500Mbps link speed.
> +
>  What:		/sys/class/leds/<led>/link_5000
>  Date:		Nov 2023
>  KernelVersion:	6.8
> @@ -140,6 +148,8 @@ Description:
>  		speed of 5000Mbps of the named network device.
>  		Setting this value also immediately changes the LED state.
>  
> +		Present only if the named network device supports 5000Mbps link speed.
> +
>  What:		/sys/class/leds/<led>/link_10000
>  Date:		Nov 2023
>  KernelVersion:	6.8
> @@ -153,6 +163,8 @@ Description:
>  		speed of 10000Mbps of the named network device.
>  		Setting this value also immediately changes the LED state.
>  
> +		Present only if the named network device supports 10000Mbps link speed.
> +
>  What:		/sys/class/leds/<led>/half_duplex
>  Date:		Jun 2023
>  KernelVersion:	6.5
> -- 
> 2.40.1
> 

-- 
Lee Jones [李琼斯]

