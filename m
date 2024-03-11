Return-Path: <linux-kernel+bounces-99649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D52878B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862DAB20DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC5A58AC1;
	Mon, 11 Mar 2024 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sM2kfcYv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0794AECF;
	Mon, 11 Mar 2024 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199049; cv=none; b=HUihJCRbezURe6ubs32cuH4J6R/bsLPSH0vfWvfn3o3hFJEmW3JXS+SSz4pX8a10LoiwHaKGkCgX9eV0ByfbW9eZZe2An+q4XGIUmuYf2s9GLZ3F2AUUGRxOMrATRBRiFFdZvZ9Uoe/o1mAIE0Iee7RSeF6KpsFMMvbECiOv/0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199049; c=relaxed/simple;
	bh=Yyx2SljWGGhoQy/gF540D+08seq/pSyWBT/BUFx9wo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrE4IusoWLB62WnpsEiPnETLpsKy5br9HCrqKmipSnwcxBUR9gLWGYsNkPzW+pD/FmR+iR12/pqNF2Q47gxgSgkGByj8L5V2hTfjmbivFBfF1VblIynq4h/XQOup2WI/aS+eRlt8lYOuRP681rcoQKBAVuG57L9yf9HGEBe5S8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sM2kfcYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3690C433C7;
	Mon, 11 Mar 2024 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710199049;
	bh=Yyx2SljWGGhoQy/gF540D+08seq/pSyWBT/BUFx9wo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sM2kfcYvtsVLPBQPJYNs+z8HCxp33ssQCLonJP3rVVS1mh5DJb1Gch3TXE7ElPw/T
	 2FX5KZKDvmDig9b4O6PP1Xd1ggzf0ZUaqemdoduVpuIaDLRYahUHg5uhDfyGG0AGya
	 mFJ5qFoVIPaY19D3rhlJiwcv4fBUspb/9krTu3zVNiGyd9bmvdUv4yEkfageWQAKhm
	 Hpdp7DkiLq9tGjEa2wCg/p2j2rNH+KyIpjjlv5TsBxTUXQilusQGHGyiPNgPvFBsI2
	 /F2HcXW3pJObvPtd3uvC/046ZpU8vM+ZbqIlbyRGKUHcu8j5UyWpe+eRfRh94Cw1M+
	 8T8LPtmDzoYYw==
Date: Mon, 11 Mar 2024 16:17:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: thomas.perrot@bootlin.com
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: macb: remove change_mtu callback
Message-ID: <20240311161727.629c0bab@kernel.org>
In-Reply-To: <20240311154315.2575297-1-thomas.perrot@bootlin.com>
References: <20240311154315.2575297-1-thomas.perrot@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 16:43:15 +0100 thomas.perrot@bootlin.com wrote:
> Because it doesn't allow MTU changes when the interface is up, although
> it is not necessary.
> 
> This callback has been added to add in a first implementation of the Jumbo
> support [1],since it has been reworked and moved to the probe [2].
> 
> With this patch the core will set the MTU, regardless of if the interface
> is up or not.
> 
> [1] commit a5898ea09aad ("net: macb: Add change_mtu callback with
>     jumbo support")
> [2] commit 44770e1180de ("ethernet: use core min/max MTU checking")
> 
> Fixes: 44770e1180de ("ethernet: use core min/max MTU checking")

static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
{
	if (!macb_is_gem(bp)) {
		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
	} else {
		bp->rx_buffer_size = size;

where size is:

	size_t bufsz = dev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;

I guess you tested this on a platform where !macb_is_gem(bp) ?
Otherwise the buffer size seems to be based on MTU and the proposed
change won't be correct.
-- 
pw-bot: cr

