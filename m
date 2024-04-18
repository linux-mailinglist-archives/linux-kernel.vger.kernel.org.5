Return-Path: <linux-kernel+bounces-150658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C068AA273
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036881C20AED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D292D17AD8F;
	Thu, 18 Apr 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPmaIbs8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60715CD47;
	Thu, 18 Apr 2024 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466949; cv=none; b=t5KlnHmD9kxXmFAe4fvXOuKCcrHcGVGEA0WEnksq+3DDUf/KjTmLON0Hb3YXmLnmhfgb0SZUya/tSWEDadzwpCCwiPbyuNbKT+reQk3VcpQrNyNzSPPEHpgLlrzlCCwrGGzS/7WmRuyUPdiFzKpsRmJqzY5u8SDPngkoV1F2C+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466949; c=relaxed/simple;
	bh=ejgiZz0qd+WyZdvb367j5IL5IuWVO2L3sFcp7HBfsmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEfcfTMGpZgtjr2E5p5FBMxFk3Od8aM2BdzqdPGu4lvZd6xxTbCj8hDhToP1pVS/ZiqzIPB+Cbf5K2bl8JjCYtCZZ+JzlyP26pJzeOdTjdxe2u0F+oTyJ8bXMk6HUnZEGLWBOXrcsEQLiyoyXLupT+ZI5Z4dpFyB3gbfdG75Qzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPmaIbs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081E2C113CC;
	Thu, 18 Apr 2024 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713466948;
	bh=ejgiZz0qd+WyZdvb367j5IL5IuWVO2L3sFcp7HBfsmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lPmaIbs8mQcBQa91dUOyLPAnq39tV7RAN0L0O/FYJ3A20vBF6huzRazAHfMgO5HPD
	 Rxy4MJ9K5jF3Tmp34lXoAASrJPcI83zE5XXzQBzGIhOZ/eDXhBWS01v71vBM+H4a1y
	 JMw5+wuMgcivZKekI1wwIJyL8rhXXavPjysQHFC1rtzADAymLkCbUNjL6HmweAPG9C
	 lLHl2hvy5+v8K2VAjhGudtYuRn1XMaNVyPvtNybU67HUZHezNvknGeN+dyyf0e88iM
	 5weT7Lx0VCtO4Y6kJE6q15RXbOyrNFusa3HJp5bEcgDFAQt/5bX2ZjifNKks0YR6JJ
	 JRfznNjQdB+ig==
Date: Thu, 18 Apr 2024 12:02:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
 <lars.povlsen@microchip.com>, "Steen Hegelund"
 <Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Russell
 King <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Yue Haibing <yuehaibing@huawei.com>
Subject: Re: [PATCH net-next v2 0/5] net: sparx5: add support for port
 mirroring
Message-ID: <20240418120227.0adef49c@kernel.org>
In-Reply-To: <20240418-port-mirroring-v2-0-20642868b386@microchip.com>
References: <20240418-port-mirroring-v2-0-20642868b386@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 18:56:33 +0200 Daniel Machon wrote:
> Changes in v2:
> - Fix clang build warning about uninitialized variable 'err'
> - Link to v1: https://lore.kernel.org/r/20240418-port-mirroring-v1-0-e05c35007c55@microchip.com

Please don't repost within 24h, per:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pv-bot: 24h

