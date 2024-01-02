Return-Path: <linux-kernel+bounces-14573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B97E821F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4871F1F22AAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5742914F60;
	Tue,  2 Jan 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjRyV52s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8C14A9A;
	Tue,  2 Jan 2024 15:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CF8C433C7;
	Tue,  2 Jan 2024 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704211089;
	bh=gsBgM/SJ5swumfn/cuVueJtKXK9nInmvCfn1DD55G2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hjRyV52srkWcrFMd9p6aHkxAvUkzcYMa2RWZPQEwAxmGtHyGaxQfbs/v+npGYXCIT
	 6nX2lufBMDX4XoQhsQIv3YMo83DPc7XTW6iQxSMAtrHgte2dIP9cs8JqwUgLlfs3GI
	 jWftuUfNohpebYe4v9tCOTdbHFT68XR6Py2mOIOe4nvsGeCrnBy0LNTaZkYHuSOxR4
	 6m+BzIMKiNgZjYj5yIR2bhYJEiPR4TAFyxM4iCtkctS/vsmGAHD9Y3UujEG4K9Xe7g
	 XKAc+BDP9yNbZSWpiaiCX4tyELCk89f/wvAvpjyazjxFg0jj+n1BaftTt/JPatw0pn
	 kte5fS0oDAw2g==
Date: Tue, 2 Jan 2024 07:58:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: fuyao <fuyao@sjterm.com>
Cc: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Chen-Yu Tsai
 <wens@csie.org>, Samuel Holland <samuel@sholland.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 =?UTF-8?B?6bqm5YGl5bu6?= <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH] gmac: sun8i: r40: add gmac tx_delay support
Message-ID: <20240102075807.1a4cac92@kernel.org>
In-Reply-To: <ZYPmZj8l01eQsDS5@debian.cyg>
References: <ZYKvCQBD-SY9uVLF@debian.cyg>
	<2370947.NG923GbCHz@jernej-laptop>
	<ZYPmZj8l01eQsDS5@debian.cyg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 15:16:54 +0800 fuyao wrote:
> I don't see it in the user manual also.
> 
> it works fine in 100M, but it doesn't work good in 1G without tx_delay
> in my board.
> 
> Read the sdk from allwinner I found in:
> 
> https://sourcegraph.com/github.com/tinalinux/linux-3.10/-/blob/arch/arm/boot/dts/sun8iw11p1.dtsi?L1826
> https://sourcegraph.com/github.com/tinalinux/linux-3.10@r40-v1.y/-/blob/drivers/net/ethernet/allwinner/sunxi-gmac.c?L877
> 
> And I add it to my board, it works fine.
> 
> So, I think it may be exist register but not documented.

Unless Allwinner can chime in we should at least document the situation
clearly in the commit message (incl. what HW+config was tested, exactly)
and add a comment in the code?
-- 
pw-bot: cr

