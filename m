Return-Path: <linux-kernel+bounces-48807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A718461D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5191C21F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023085642;
	Thu,  1 Feb 2024 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="uEX/QmMf"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5869D8528E;
	Thu,  1 Feb 2024 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818635; cv=none; b=OnYRM92WKuPiKKrimngS1q9eBQmTH1x/X6yy6Hik6JtICsi5GMPyoaZcyYycq8rclDQUwl72ASTYQNf6kRgx0bb4WbSP0bB86gj94k8aC0Z7qVqfudlEk87/hehEgnlyh8xasekeX3RxmImV/2SWSLvHLKYzh65DQRpw8rbM9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818635; c=relaxed/simple;
	bh=kUJ0d3O/c0wajgWfESE7EH663Rzvk91KqBPyZn/q+LA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WQizPctuMtrkeEyeWgc2+AfpzpK8rra7J8ky3GsG6iWMY0Arly1UYGypwtJV+kr3FHMeRFzLUSSYQmSl/l+tTvI/5WF7OrZeFU2EDgli+3keisqXPMOFEnNOWnvmHqsLMgm2erSb2nE0EXYNOFj4Lu6j2QPjrWlm+1wZ6K6Mm3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=uEX/QmMf; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706818630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQ4LObGFJg/ha8hZmJ9oAUbu9DDaZFLu+D2ZoTVr7XY=;
	b=uEX/QmMf0zExWZ912UGlq+tML5qMj/92LtN25+1uudl4cc01SleXspXqRqXKJ9nRv0a0fw
	x/N8E64ubnnVJXrJGSBPjwTq4cqHHWivYYPi3YJ46kdkqf4tts136hK74q6NFcqYqaRRt0
	0TjwNrvwt03lKnfYr8u4qpPG3RjdV52YPdcsImOLpCoehjSC94Y/dvvd0bpJUGSrr5Ut3A
	As2O6AzDzQH9Ph60tLDy4f2BURXvfKS0ajp4++ghPJyo3Gv/R9WIb3TVoOkM1cysWAL/+O
	kVd4uhg44YlhOx/8v3j8Z8lodhWBNK/WvNJImFdynAZSkAPcfjEOlTSYPhZnnw==
Date: Thu, 01 Feb 2024 21:17:08 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Greg KH <gregkh@linuxfoundation.org>, Christina Quast
 <contact@christina-quast.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj?=
 =?UTF-8?Q?=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice
 Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiko
 Stuebner <heiko@sntech.de>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Rockchip PHY driver
In-Reply-To: <2024020105-bankroll-opium-a6e5@gregkh>
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
 <20240201-rockchip-rust-phy_depend-v2-3-c5fa4faab924@christina-quast.de>
 <2024020105-bankroll-opium-a6e5@gregkh>
Message-ID: <cabb91e97a5e563cccbffd56f331a477@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-01 19:23, Greg KH wrote:
> On Thu, Feb 01, 2024 at 07:07:00PM +0100, Christina Quast wrote:
>> This is the Rust implementation of drivers/net/phy/rockchip.c. The
>> features are equivalent. You can choose C or Rust version kernel
>> configuration.
>> 
>> Signed-off-by: Christina Quast <contact@christina-quast.de>
> 
> Cool, but why?  Is this going to happen for all phy drivers going
> forward?  What's the end-game here, dropping all .c phy drivers that
> are in rust?  Or having duplicates for all of them?

I'd also like to know what's the intended purpose of rewriting a mature
existing PHY driver in Rust?

