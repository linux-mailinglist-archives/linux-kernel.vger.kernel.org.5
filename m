Return-Path: <linux-kernel+bounces-63644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8724C8532B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75A61F2768D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C90357335;
	Tue, 13 Feb 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2XoFnshX"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42057865;
	Tue, 13 Feb 2024 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833397; cv=none; b=HI5hkJnLUtclHcsDPZTW0HJcdS2iOpd1z0i5M0uOJ8mwFJlAXHbj3ypEB6okeBO2kza5oA90Y7xhEQJ4GuWt+Nl0/DwDObCNehjHeId50sk7x8BOiEj9dCKM1tgKn6soh0t4ln80knqF9pccCZvwBvgOS8sXKbL38lToI1TNXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833397; c=relaxed/simple;
	bh=LyZY5XtSPAFIYABnEh4G9R8dKwQnSIg19PQFCVPXHpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lx5RGUdKTfYlUmIF+hP83PUli2IMTb07K75W2GwUxcOi4+nmywqx6ptZzpGsegPXhF1EmxjFookRgoPPuZtVNoBLBhUoexoqXoZbOoyHmQiSpltSEGqHjBStcZPgkRG0t+rW9d1Imji8u+AIe6H6D1Xfl2hLvBIem81Gzr/2hcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2XoFnshX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ew55hBxuEJ33nYeuVYtnOfePjtxba6lPCJQgCZ2WFP8=; b=2XoFnshXfcUYummiNlB22cnmet
	mNbSF0huOZPEYITJQI8sBCWPDfwB+oGccpWjzzYatTaZs/2XZT6nWwrgmhcR1nH9A4q19owHoGXrF
	tUg/XBz2MTgINBEIFMjvfiTMLtDHrQQGIir7yMUGKFALcWmvETOslFGh0Ek0i54xHYIE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rZtTx-007gYT-Fq; Tue, 13 Feb 2024 15:09:57 +0100
Date: Tue, 13 Feb 2024 15:09:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: aquantia: add AQR111 and AQR111B0 PHY
 ID
Message-ID: <233cd45b-28d5-477d-a193-8273684953aa@lunn.ch>
References: <20240213133558.1836-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213133558.1836-1-ansuelsmth@gmail.com>

On Tue, Feb 13, 2024 at 02:35:51PM +0100, Christian Marangi wrote:
> Add Aquantia AQR111 and AQR111B0 PHY ID. These PHY advertise 10G speed
> but actually supports up to 5G speed, hence some manual fixup is needed.

Any chance this is a "golden screwdriver" situation? The chip really
can do 10G, but the firmware is supposed to limit it to 5G? This is
just a firmware "bug"?

     Andrew

