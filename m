Return-Path: <linux-kernel+bounces-153424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3869B8ACDF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F27B2563A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1514F9DD;
	Mon, 22 Apr 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tjDw6cTo"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DFA14F123;
	Mon, 22 Apr 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791660; cv=none; b=n6GQiohbIpOqptbOJphUzIJyAeWWoij7pK3GMrbD7Hde+Mfhb1+FVDIr9s2ioFJUSoKa9/ratUHeToQGwxnhLvfTKBOQGMwhySF0OKz2xuARFA48YdeQv2JBHnwQ4xW/BY3lD7CrMZlsDqik6iAhkQgToB/jxrs+wPxoCPAeEy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791660; c=relaxed/simple;
	bh=hPRmFIFYiJN/6bf0YcOYo5UrScKhMIeu5BKYFrgEz+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfaEcutdfaqivknHM4CVEcGroOoy5L9YPVfNk92pUCUVP78Nv6OZUNFRQ9JGc9qqWE8skSCJf+586WkCx0QS6ISeCX7WbyE8yQ3dHH6wQkOOcQ5YSUZDyJ9tLrpwLm3wUV8qCl70Vd8UjePjTvpHqeepimXjdBuqpmMKjkiitYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tjDw6cTo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7m/NEnQbMSmAGNLxJ0CrFAMWF7x2McYRy+y8URj23QA=; b=tjDw6cToW6Slo/C3OouTVirmOX
	f3rHzTyiQ8odCj8AuKV2tXlJVOUzYQ14Rkif6HZsXmjW36Br6iVYETbapEvL1rvBNMZEWwIQrK5yj
	yJ4IRApUIkuazCVKeHZB28GIbtb7EV1mVGQfOnyC9+Fino+GzWv+RDCkeIP2GP593hpg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rytUq-00DcQI-4z; Mon, 22 Apr 2024 15:14:12 +0200
Date: Mon, 22 Apr 2024 15:14:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next 2/3] net: pse-pd: pse_core: Fix pse regulator
 type
Message-ID: <a5991b1a-a669-4c47-8918-60c4c12a1505@lunn.ch>
References: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
 <20240422-fix_poe-v1-2-811c8c0b9da7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-fix_poe-v1-2-811c8c0b9da7@bootlin.com>

On Mon, Apr 22, 2024 at 02:50:49PM +0200, Kory Maincent (Dent Project) wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Clarify PSE regulator as voltage regulator, not current.
> The PSE (Power Sourcing Equipment) regulator is defined as a voltage
> regulator, maintaining fixed voltage while accommodating varying current.
> 
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

