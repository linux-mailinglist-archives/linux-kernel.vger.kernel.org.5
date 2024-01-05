Return-Path: <linux-kernel+bounces-18212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F812825A12
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1D51F21A89
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C532D3589E;
	Fri,  5 Jan 2024 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIbyo1IW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD7A35287;
	Fri,  5 Jan 2024 18:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E026C433C8;
	Fri,  5 Jan 2024 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704479230;
	bh=PXpu5Xpx0PYmd0ahyVLbQBfzsHYgsvVoi3WRRuvskAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIbyo1IWzqYkRHL/0UKG1pLVPTQz5kX34sc+xIp7mR4n1y3Ff1Jb/Ex6JUGtKyxp1
	 /e8v47PaWzHAoLYsKSAYluOE7PXAmR96+0CRNhnv7LYWyeiW7R1OarEXoKklo8LEXO
	 eGyZt65YjW6rUgOPbluX8QKUven7FLVHIydnJWxX7uMFPekcTHuyucj0iqm/1Gqz6c
	 PgiDQJ05WxRpA2ziXxibCxcW2yb5LiMiVEiRFbm9ri0lle46SaRys62/ZEH7Q9D8eY
	 dPdNlgdufhS9aMZOpd4tpwDf+nRis1vr3s8MT5i7NN7ogKdSs1TdOD+IlIXPzydftV
	 9LnpF3FgCM26g==
Date: Fri, 5 Jan 2024 18:27:06 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v4 3/4] net: phy: at803x: add support for cdt
 cross short test for qca808x
Message-ID: <20240105182706.GX31813@kernel.org>
References: <20240104213044.4653-1-ansuelsmth@gmail.com>
 <20240104213044.4653-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104213044.4653-4-ansuelsmth@gmail.com>

On Thu, Jan 04, 2024 at 10:30:40PM +0100, Christian Marangi wrote:
> QCA808x PHY Family supports Cable Diagnostic Test also for Cross Pair
> Short.
> 
> Add all the define to make enable and support these additional tests.
> 
> Cross Short test was previously disabled by default, this is now changed
> and enabled by default. In this mode, the mask changed a bit and length
> is shifted based on the fault condition.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


