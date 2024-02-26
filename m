Return-Path: <linux-kernel+bounces-81845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CBC867AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048D71C25C73
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46012CD9D;
	Mon, 26 Feb 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mZX7B+8e"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718A012BF0C;
	Mon, 26 Feb 2024 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962740; cv=none; b=EGNqyxJE0r01NvdgU3MaUE4HjJNz0Xihj/X4W40kTZDKrc/n7Zvx7oHpKeLniHYUUUuRtx1gkfG2h/c+W2RY1oIe/IYrQcYHNl5l7dJdB0+3xR8wECYup6IMVvvSP5037IgIKxfb/wHSRaBP1pTLqEpsH13QtpHxqbBSjQdWQ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962740; c=relaxed/simple;
	bh=zfFSrlx6q7/zq/izozDGFE+JawPbXOp/Z4mndgPjXHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6ef5jLOS+c1u8W4SRzmiDWCG7e9hYDtPanNt2eZHRLZr4NoRUYfbAuJB5I8tURywqo7VaTUlF+OAYLlOsfFrwpUNXYzWjFtXa2vEJLqetMElSnYPtxVAfwHRovbypj/bYImZ/jjPp54eRGVNw/2Q4+djU/+X9ifaF/n5KUwk44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mZX7B+8e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Y+x/bJfh4HN/QSpeHGkXOfMB2CgBRknyhVgfmsHeiVE=; b=mZX7B+8er8ccXQBq1LsEtLuRW0
	vU4GnRFehemfB5K77CW8SH491NcIfDvKHOwlMTmWhCkwgK7nunMa7v/I0oL13KpGV2F7z2GunR6qs
	xIixbVMrZGuYihPYXf+swXq7GIYHJMv4+Qa9nBtOZaxSK3hAWK18reIj5wDBjirHXkv4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1redHG-008jt7-2D; Mon, 26 Feb 2024 16:52:26 +0100
Date: Mon, 26 Feb 2024 16:52:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: add quirks for ODI DFP-34X-2C2
Message-ID: <b601e76e-47ac-4670-9ab6-bfec9beedd8f@lunn.ch>
References: <TY3P286MB2611C0FA24318AA397DB689B985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyahVYAhPgf2Xqn@shell.armlinux.org.uk>
 <TY3P286MB2611BD62C30B37A5BE02D3C5985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <ZdyiigYNGf8WVZNu@shell.armlinux.org.uk>
 <TY3P286MB261155090B2D07593901C0DE985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <b8fdb5df-57e4-491a-b310-e8e13a89d331@lunn.ch>
 <TY3P286MB2611E440DA1D914C1A0307F7985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611E440DA1D914C1A0307F7985A2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>

On Mon, Feb 26, 2024 at 11:42:49PM +0800, Shengyu Qu wrote:
> Hi Andrew,
> 
> So I should describe in commit message that user should set the stick to
> 2.5g/automatic mode and include the link in previous mail? Is that enough?

As Russell pointed out, this sounds racy. We need lots of details in
the commit message to convince us this is safe, and is not going to
cause a regression. If it does break and cause a regression, having
those details will also help us decide what to do, other than just
revert the change.

The further the devices get from well defined standardised behaviour,
the more details are needed.

       Andrew

