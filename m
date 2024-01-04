Return-Path: <linux-kernel+bounces-17228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFDB824A19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9C21F21B17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8AD1E511;
	Thu,  4 Jan 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELGaajLK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A932C197;
	Thu,  4 Jan 2024 21:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E857C433C7;
	Thu,  4 Jan 2024 21:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704402947;
	bh=Hop6+r5XKbN1rDwgG+qbZQBmGuqmnkpWYMbhXP1QkD8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ELGaajLK3aMQKLYY3R56E1ATyJwevf7zA2+E1v0z18wjZli/mcGsG/zGczRBzsS9C
	 4kh58FsLXsxoDPdyFFbNQQaE3r5XVnotKEKo1cKqEcazP6pBqF1fFPsChX5H85XZw+
	 /88S1WUU3xxeQukK0XZTpvp9quZUu6lMkHTdQ7gKFna9/MubzfDljSIHhgjlqoZf8p
	 cQSI/6j1+eok+RtctJt7KiVuo/SdpVYzI/w8BOmOi40oUHQvMJIBKpBzFnp1kB5t53
	 2dycVmQUPRWkv/dUAtuxa0m7Q0JRxd5iICbvz8k4zEuGAlYmOyV1vqRB5MI53jpAQw
	 +pCtMp7WEqoZg==
Date: Thu, 4 Jan 2024 13:15:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Networking
 <netdev@vger.kernel.org>, Mathis Marion <mathis.marion@silabs.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Robert Marko
 <robimarko@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20240104131546.0dbe74c4@kernel.org>
In-Reply-To: <20231221130946.7ed9a805@canb.auug.org.au>
References: <20231221130946.7ed9a805@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 13:09:46 +1100 Stephen Rothwell wrote:
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 21 Dec 2023 12:49:11 +1100
> Subject: [PATCH] fix up for "net: phy: aquantia: add firmware load support"
> 
> interacting with commit
> 
>   56ded2dd1a43 ("lib: crc_ccitt_false() is identical to crc_itu_t()")
> 
> from the mm tree.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied to net-next with a massaged commit msg, thanks!

