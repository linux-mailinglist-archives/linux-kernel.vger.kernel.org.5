Return-Path: <linux-kernel+bounces-131540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2D3898951
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B829CB29717
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC1D1292E9;
	Thu,  4 Apr 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMjKtPig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32CF127B7E;
	Thu,  4 Apr 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238877; cv=none; b=NAQQLx0BYAE2osyzzHkdIk2npa1M0KI8JCv7ZTRQJjCShJnVkTXKwU63NBmElmVuf9A5kOvFInWPhmt+LW/FvvV+2T222Ctbrotzeoo8mWhDio3XjhydtgYjY2AQMApYQcI0EAP4j7qhU283sanDKwUUTgN0ZiHfbDNki8U8kkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238877; c=relaxed/simple;
	bh=rgcpub8PrWzAxQAh6zx9KkF/3iwVXcYaz/F02yMjsW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0Jz6IZXLkWROXiyadZxxO/ZvkIOuqSwMxAAVwpO7gmrSQuKA7owt6Q4KiEMcLtaRVsKIy4QzI6jXhNAKCGCnVDWTmNo1r3SaXWYQ3D7TCyqBsALEDIsIp1bI1qT49rXb9GPViU+Q4UvmyTFiAykGkhBTP8y8HvlT1hnAOiHhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMjKtPig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B531C433C7;
	Thu,  4 Apr 2024 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712238876;
	bh=rgcpub8PrWzAxQAh6zx9KkF/3iwVXcYaz/F02yMjsW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMjKtPigKuG4hf+rhQ4oXyN9pnE0r+2jKtlodRHqYpONHEZ+uLzOYutmvm7p2nRXF
	 71wmJMMjzNOV9lk7KppXm5F+oh4kzMH+6Pb1Sq/trgjknR2SFbUYhUJb82GunPwIfA
	 hooQwIBOsxlNKvbg57lUdW0CNjTzDwG7TUW0BZkG/3Mi9XbTh3mQsZjfBbFoBwQZWe
	 U2glc2kIM0B0uJe/k1RMKVITrOQRPUbCUc0JKS/34MRyLTap6MdO8I3epTANccciyu
	 vV3FOKK5S6oYe3b3ZQcR1eyh+lWxOTWQvGc843R5M6pM1VSuaPHqYnNQsXU2+kks86
	 ffrgDNYZaDYfw==
Date: Thu, 4 Apr 2024 14:54:32 +0100
From: Simon Horman <horms@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: kuba@kernel.org, dave.stevenson@raspberrypi.com, davem@davemloft.net,
	edumazet@google.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net v4] net: usb: ax88179_178a: avoid the interface
 always configured as random address
Message-ID: <20240404135432.GR26556@kernel.org>
References: <20240402183012.119f1511@kernel.org>
 <20240403132158.344838-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403132158.344838-1-jtornosm@redhat.com>

On Wed, Apr 03, 2024 at 03:21:58PM +0200, Jose Ignacio Tornos Martinez wrote:
> After the commit d2689b6a86b9 ("net: usb: ax88179_178a: avoid two
> consecutive device resets"), reset is not executed from bind operation and
> mac address is not read from the device registers or the devicetree at that
> moment. Since the check to configure if the assigned mac address is random
> or not for the interface, happens after the bind operation from
> usbnet_probe, the interface keeps configured as random address, although the
> address is correctly read and set during open operation (the only reset
> now).
> 
> In order to keep only one reset for the device and to avoid the interface
> always configured as random address, after reset, configure correctly the
> suitable field from the driver, if the mac address is read successfully from
> the device registers or the devicetree. Take into account if a locally
> administered address (random) was previously stored.
> 
> cc: stable@vger.kernel.org # 6.6+
> Fixes: d2689b6a86b9 ("net: usb: ax88179_178a: avoid two consecutive device resets")
> Reported-by: Dave Stevenson  <dave.stevenson@raspberrypi.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v4:
>   - Add locally administerd address check as Jakub Kicinski suggests

Reviewed-by: Simon Horman <horms@kernel.org>


