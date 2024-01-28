Return-Path: <linux-kernel+bounces-42018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBCC83FB09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989D7284B49
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462245958;
	Sun, 28 Jan 2024 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5JN5wlIS"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E3446A3;
	Sun, 28 Jan 2024 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706485360; cv=none; b=H5JDU6YzizUhoQBxSje+i54oRuYx4LDFxjG93Uy20QNgA7B0I0QEp3Dr3OFgNX3wldZeSBY118OxtIkJuhpzkNE4kp8IHhd3DOdL//D7b4surIOMQkyPlmY5iL+UTzeEdkNxX/gItjgbCExmJ47YPLHSPPhsMdh1/s1hgQ1WZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706485360; c=relaxed/simple;
	bh=ruLpvCm6M0DxtE+SB5SbEv3gaUIAATBFY0jv0cQoebE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCDHYSyZ5F9xepuG4pcUDU3AgtziqQvlKdjwpRmBPWd6uHlXKlxlpJPwZTOr76L4vwx7J7Bheya0pGnRYQjDIEM7ID+t27AjWN/gaxZ7rMN4LNA+k/nvDv/N33UO6DbgRkE3LkzsWHWPlTxbL7096qRAZwlHLqt27sMBXVu6H94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5JN5wlIS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3TkdISWdaeUFKPadAK6WAUC4O64clOaAdKcW0y0A3J0=; b=5JN5wlISY0d5ycpemNYCJ4Aydk
	BTzrpfAj1Br1fBhDrN3a75lk4E8UI7Kj0cJdlT5EYNn/+GDe2aHoqv72WbswHnmebz3XptvMs8gbl
	D3ATEk+DvhzDSLegYLyAJq0gs/MwHqX9lptTeFT9jVBSL/QBunWb1RY16oL40z1VVx7Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUEnG-006Kfd-Kw; Mon, 29 Jan 2024 00:42:30 +0100
Date: Mon, 29 Jan 2024 00:42:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v3 2/5] net: phy: qcom: create and move
 functions to shared library
Message-ID: <558003f8-c58c-4a16-ade5-d052503cea56@lunn.ch>
References: <20240128120451.31219-1-ansuelsmth@gmail.com>
 <20240128120451.31219-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128120451.31219-3-ansuelsmth@gmail.com>

On Sun, Jan 28, 2024 at 01:04:23PM +0100, Christian Marangi wrote:
> Create and move functions to shared library in preparation for qca83xx
> PHY Family to be detached from at803x driver.
> 
> Only the shared defines are moved to the shared qcom.h header.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

