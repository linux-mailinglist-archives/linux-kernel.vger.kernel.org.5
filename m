Return-Path: <linux-kernel+bounces-44658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1CB842595
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F86F1C24A77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF526DCFD;
	Tue, 30 Jan 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPThSBBS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C46A327;
	Tue, 30 Jan 2024 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619415; cv=none; b=g4dhcye3eVNIWIbz7+14mx1+xC6HAogECmr2b1dVVQ9YTyKJ7KuLcnTN+cdmxgbKst6huPvLGqR1OrhDI4IVO9Pmg1cJAuWWwB1F6v5lLiGvcpHPcwOutwtHn1j9nZc7xD8NrheoVxplm6m9UWhe3vEJ1r1Q6k2golT1J4BgK18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619415; c=relaxed/simple;
	bh=8FYnOFzp7lrsJcX6tRJa4Cck3+U76gyyBXxVd460tLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fgmozd2PJ4zqHud5XVbJ0CturUzfblAAAFS0UhkbJ0wi7CUxBBN8/yPMiNIRe7Tmk9+Zbf7hsku4BtUcInzml6S07V+SJWiLzsSrx9QxMTps0j0e8yX3IBPItJXcx8GAKr7Qkt5BpqP4ayHs620viqHhEp1cndSBB5KbSwNs9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPThSBBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7882C433F1;
	Tue, 30 Jan 2024 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706619414;
	bh=8FYnOFzp7lrsJcX6tRJa4Cck3+U76gyyBXxVd460tLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPThSBBSRd/OSe7say3+ieOOILpVTW2mxlLfh4SIqsRlKMCQqTQtnCYgyGs/xWLl4
	 CD9hn5fXvy54KhAexNojsVqVQKCssGfY57JjsbqAM9my5jjijad1JsVjtJ0KH8G6TL
	 s/dduCQ/IUMPwsmJ2iZJD3+NWHLMSqso9tLMXGspw0c03X3QZdEMiE/O9Q1Tsti4xx
	 J4ySsVXrFTtGWY3XP382nQojtAo72yydO3PgwE6LXT27BBtVWTb5I3wpzwcjZP3ubl
	 0nyK9BNMQNzZCNYtGumJ4Gi3T2wNVEFM6YFo7A2vK/SPo/NarIFzNfWEuNb3AElndn
	 t24fkuBevoMlg==
Date: Tue, 30 Jan 2024 12:56:46 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, dsahern@kernel.org,
	weiwan@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net 05/10] net: fill in MODULE_DESCRIPTION()s for
 dwmac-socfpga
Message-ID: <20240130125646.GD351311@kernel.org>
References: <20240125193420.533604-1-leitao@debian.org>
 <20240125193420.533604-6-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125193420.533604-6-leitao@debian.org>

On Thu, Jan 25, 2024 at 11:34:15AM -0800, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the STMicro DWMAC for Altera SOCs.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


