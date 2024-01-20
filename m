Return-Path: <linux-kernel+bounces-31894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B98833602
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA7E2282089
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788A7125DA;
	Sat, 20 Jan 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1W+9pqF2"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F0411727;
	Sat, 20 Jan 2024 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705780473; cv=none; b=UJ2z8c2Tra3gzayz0pXKq9CpzA5+SXnAZDU8XHgiQivRCSVvDwSfT6ZgEjMs+5yZWPpDJddF/i8hnodIAnrxTk3TzEVYGNJD3RJUMQZv9mOOVi1lM1mRDbtc1gYIWKjKR8B/CsYBjSQqt9D09ESdLYVQMCesBWcjSDsBaAAGaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705780473; c=relaxed/simple;
	bh=tbOOeN6McKZXfmtSKXEcyKn8BTQPKrksBWnAPBQTyvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKbuWVukk5lFzBJrcGqRUl8E3nieKvJc2HfEFoFZotwVCZqgg5Cw+ahFnJbbp6qtmSAQ7dDW1achUyRJSu+h6pGY9RmxpEpzQWKKv+tknS+1zU0DZlRmt5oJdDReShjIH9yv4CjOYt0OVHtFzn97LNLIOOWmsM0P2SLsAAcKBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1W+9pqF2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eL91QtNhG/z4mZ22GAv/7KhK3UTnXQMTH/oaMziGrzQ=; b=1W+9pqF2JuajB+Fj+83VQqesO5
	diYhbNkJOcGZq8qSbqiNflD67YJ45/O4whSDbTRt2g1jZV2IziP1s10tY+A9+rmgnwDqWMhe3qFnG
	a1K7vSEpy67xujzQ/TE1p05ghQCRHRd3MIAeGQQdhIHdV3OUA95wDA1u43Mt3jqDs818=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rRHQ4-005csb-EN; Sat, 20 Jan 2024 20:54:20 +0100
Date: Sat, 20 Jan 2024 20:54:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Peng Fan <peng.fan@nxp.com>,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] gpio: vf610: allow disabling the vf610 driver
Message-ID: <a0ff7c6e-3c3d-4535-9033-439da0dc4b7e@lunn.ch>
References: <20240120182929.1129183-1-martin@kaiser.cx>
 <20240120182929.1129183-2-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120182929.1129183-2-martin@kaiser.cx>

On Sat, Jan 20, 2024 at 07:29:27PM +0100, Martin Kaiser wrote:
> The vf610 gpio driver is enabled by default for all i.MX machines,
> without any option to disable it in a board-specific config file.
> 
> Most i.MX chipsets have no hardware for this driver. Change the default
> to enable GPIO_VF610 for SOC_VF610 and disable it otherwise.

Hi Martin

Please ensure it is compiled when COMPILE_TEST is set. We don't want
to reduce build test coverage.

   Andrew

