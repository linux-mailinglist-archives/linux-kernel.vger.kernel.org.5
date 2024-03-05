Return-Path: <linux-kernel+bounces-92605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2625B8722C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83678283BA8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5C3127B46;
	Tue,  5 Mar 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qEraWjgZ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE7912A16B;
	Tue,  5 Mar 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652412; cv=none; b=IGsajiMf89PpiQgp1gVm8AZH4HtDV2PmcD3qLuOaOH2OpEinmVNU8ab2UceT+0lMRq0BoRvnkbYp0u/Oz2rCypDYYnfq8bipA/MG7V+bubi2m+wAWfl+xLJ9gRrkTGJQVnv5hYvjQ4UGDPouiPfAwkkYdFMl6WHFRgJEEq+QZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652412; c=relaxed/simple;
	bh=FjPbKABVjTLfXn9jQJVJX1mQDEs2gEELCKPi8miizI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxvj7xZtMs1Xj5tJiaD0uVO7TBwyqazQ3tuB98e4qn35QTDuZNdfi0YePhqsw8NaL4+AOv8lUkBO3Rfd3woxAI9HtA30hQ6qdQX0p3/zMLZNXTo7oZQiOuXiBEJrJ9rPE0Cr4FBSjz4ZRJl+Z+TJ+RvUeDcq7DkFhjo9TbAOjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qEraWjgZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=yRXMUN+TQatOqByiIwR1LGZ/DCm9S3/1qaWiI2V3UUM=; b=qE
	raWjgZy3CJLDDq3mnNj9M9UPDeiB0JSL57CB4ZL3mOgT5RdRtAsNCX8byXEuun0mGuhUMIjiVNWHe
	ybm6Rhr9BS2yGHQ/h5gZTyW8gEuehoYkas23DZWfEk6kHzuqUI5R4AVjLz5ZT7GYrYE8f+cDtbr1u
	PhHQW6gwk9SEi1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhWh8-009RHn-Vc; Tue, 05 Mar 2024 16:27:06 +0100
Date: Tue, 5 Mar 2024 16:27:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH RESEND net-next] dt-bindings: net: dp83822: change
 ti,rmii-mode description
Message-ID: <b5802d2c-4a22-4246-a44b-a7ef6bc6dcd1@lunn.ch>
References: <20240305141309.127669-1-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305141309.127669-1-jeremie.dautheribes@bootlin.com>

On Tue, Mar 05, 2024 at 03:13:09PM +0100, Jérémie Dautheribes wrote:
> Drop reference to the 25MHz clock as it has nothing to do with connecting
> the PHY and the MAC.
> Add info about the reference clock direction between the PHY and the MAC
> as it depends on the selected rmii mode.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

