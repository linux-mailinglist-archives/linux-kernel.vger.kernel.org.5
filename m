Return-Path: <linux-kernel+bounces-18215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F62825A19
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20681F245BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671F358A9;
	Fri,  5 Jan 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoiuRVwE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA043588D;
	Fri,  5 Jan 2024 18:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92373C433C8;
	Fri,  5 Jan 2024 18:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704479318;
	bh=UWZ9g69LqblqTIx2GsfZYc5KFDWrnQY+MHpPKLD/9kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoiuRVwEFI/Jv8ITCVQiIftCwl5eJYf9CHolDmSmwwFjBxiekrtFNdx40Hn0XwKlu
	 J3FskHOaV6alK/FmOI2lJOnAnd6JyqRzfxhFrnylY6AsLUMb4deWwcpGJlnnXYmHSg
	 kQaEbbtmZJpAmEw4FSdg/QlHwp+G2CR5R+GcbU4mUF6gYXjJ/Eb+8cmy0c7kYa9B15
	 0f5yU2PZgT5FgwKyGd96Cu3A98uiwH9hc3FaMbczSC54Pf9rfUCfcTiOZ8hyvKGfBi
	 TOISPT4tpbsnaPZbZgQ//dUwJD5Tnrz+oplNjiGcmxLrjtYGeGJuIfX+HKe31ZF7Co
	 8Agxh9Y3iu6Ww==
Date: Fri, 5 Jan 2024 18:28:34 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v4 4/4] net: phy: at803x: make read_status more
 generic
Message-ID: <20240105182834.GY31813@kernel.org>
References: <20240104213044.4653-1-ansuelsmth@gmail.com>
 <20240104213044.4653-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104213044.4653-5-ansuelsmth@gmail.com>

On Thu, Jan 04, 2024 at 10:30:41PM +0100, Christian Marangi wrote:
> Make read_status more generic in preparation on moving it to shared
> library as other PHY Family Driver will have the exact same
> implementation.
> 
> The only specific part was a check for AR8031/33 if 1000basex was used.
> The check is moved to a dedicated function specific for those PHYs.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


