Return-Path: <linux-kernel+bounces-16687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C07824273
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67457B212B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED10E22311;
	Thu,  4 Jan 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOpevqlP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB922304;
	Thu,  4 Jan 2024 13:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A011BC433C8;
	Thu,  4 Jan 2024 13:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704373662;
	bh=Tdc/scx6/keEynCGWsRwPQT00F7mWkXemkBEJ7rCt9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uOpevqlPMTia6ASNeEc6Pfe/HsDQGFUsgWFGtCQgSTw7edzP1yOo7lCTCnD8lGqRc
	 JEyoSweY/JPnBb8fiSO56iEdnU8FB0JvMZ0fE68YJ4UcCP3ZK5JVXLlEIG4+KJBt4L
	 B5NkTT3/z3q4Q1Vo53px/DareE7uIMzkhF/T+tudssa8Li4X5fbe7iIruPeccRM9ot
	 BXzWuJcFis38oU044r0+kGSqxssLwtXOreOkwfXpm19gNU8fjSCR/vtLzTfJUgKnrP
	 KOehLw+yPnHIvu5DAq9gogdxyQ0Rbf/cnUAiDpSFD+nundS69abWVlNEhzCPYlnQBo
	 6EKWKPPP9r73w==
Date: Thu, 4 Jan 2024 13:07:38 +0000
From: Simon Horman <horms@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 1/4] net: phy: at803x: generalize cdt fault
 length function
Message-ID: <20240104130738.GH31813@kernel.org>
References: <20240103124637.3078-1-ansuelsmth@gmail.com>
 <20240103124637.3078-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103124637.3078-2-ansuelsmth@gmail.com>

On Wed, Jan 03, 2024 at 01:46:32PM +0100, Christian Marangi wrote:
> Generalize cable test fault length function since they all base on the
> same magic values (already reverse engineered to understand the meaning
> of it) to have consistenct values on every PHY.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

