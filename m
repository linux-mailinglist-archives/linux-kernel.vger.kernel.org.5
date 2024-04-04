Return-Path: <linux-kernel+bounces-131841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50779898C64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066841F23925
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE801CA8B;
	Thu,  4 Apr 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+0Iyqc7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541118039;
	Thu,  4 Apr 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248899; cv=none; b=qJJipKv+4PP/KAEcz2eFPYKTkdDQB8MtxU/EKMCIU/25tq+Jc+DUCZowbIRg2WcsNnrLR+/UYBb0TctmdQf81lvxRTh/yIPpxzRbkQzY3zUMTFhOlK886BGX3dP5vQlQ9vM0eTW18POPcidnl2SimQ+0iBS/LL1OKZ0N763x82w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248899; c=relaxed/simple;
	bh=nc40APYHvfyD3nTNCNYukD92FnAI7PdPEO8akKw01ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxYtmYZubg1PjvIROEOfxQxom6X1lS3lgU8M1lqQvxJeWoN96xY2c6H/BjEGMZX9eocWMgWqLV6elJNYAxt1aeT6z6nSNvpiENH9ejTXBYLFhZ8YPjU0XfAO4Qhwo576xOs6QRzx9A9YREQOLVJd/8IWpxpJWQAYRBOT4+vBJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+0Iyqc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5E3C433C7;
	Thu,  4 Apr 2024 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712248899;
	bh=nc40APYHvfyD3nTNCNYukD92FnAI7PdPEO8akKw01ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b+0Iyqc776lIFE5TU+tiflZb+ThDJeyFzIQS9Zufq0S95zRoiuPQWRdLBlG/mss/S
	 dzF+RewFPVAZb+yL0c4wqveCnQHXiiq1/WQDzpA0IIeOAIOJj89rsO5qDClZbvNrnZ
	 pfXf8wL4J2PSjD+l3OGV/+Mj8LrfswlTyhAyHpyuDutSX7/uGec8/XvsqP3oFDkzyM
	 HTsre4eZExdu50VjosCVbzzOXMey23CNdN/z75lmrnR885hZlzNE5aAX7wLuJQLD6d
	 OwEkrhOifVBB0T+xW8O3DIV4oUgcXzXRi0Kw0jRBXoQbN2zjG1UiIuUemKtUyLG0i6
	 uorfVi8JPSs6Q==
Date: Thu, 4 Apr 2024 09:41:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next 2/2] net: phy: micrel: lan8814: Add support for
 PTP_PF_PEROUT
Message-ID: <20240404094137.51b1397e@kernel.org>
In-Reply-To: <20240404080115.450929-3-horatiu.vultur@microchip.com>
References: <20240404080115.450929-1-horatiu.vultur@microchip.com>
	<20240404080115.450929-3-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 10:01:15 +0200 Horatiu Vultur wrote:
> +	if (period_nsec < 200) {
> +		pr_warn_ratelimited("%s: perout period too small, minimum is 200 nsec\n",
> +				    phydev_name(phydev));
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (on_nsec >= period_nsec) {
> +		pr_warn_ratelimited("%s: pulse width must be smaller than period\n",
> +				    phydev_name(phydev));
> +		return -EINVAL;
> +	}

-ENOUNLOCK brought to you by coccicheck:

drivers/net/phy/micrel.c:3049:2-8: preceding lock on line 3017
-- 
pw-bot: cr

