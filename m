Return-Path: <linux-kernel+bounces-123414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B7089083F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DD71C242DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E7135A7E;
	Thu, 28 Mar 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/+K/ruK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB2712FB36;
	Thu, 28 Mar 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711650501; cv=none; b=bO+1Z4IeFoyWgI0Jcng6JihJpgbytqGBfcnXuZqR1r7MMzNM0QXGf1TAyqHRP2XA6u1gS0eNS38bqldBKgbdtxkE0YLYlrI/Bp0VY05kbeJNffGF/N8uKMA1XX/XZ08B2JZ5R3Bb3SLcd4zopN2SneMmkInYuXX88rilXFmelEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711650501; c=relaxed/simple;
	bh=qnTHkMKWFqmASjF7Mj+8qIPTwlEXLcYYW+bC2hrrVzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIDDJNcxu+OPLn6XFdQEXjf+Lx4QQEj5Q/1qO2B/hZ8IC2j8mXX0OdvqzvoyqbV/FyL0dEovxi6zNQKd3iqNZf/L9aCMvYBc6k1ioQN2hCQX4922OJbWXluvBUPnKM7xzjZ+7vPRCfrfUsR9t5K43WiY1MoWzLxYYd4sDdTSjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/+K/ruK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAD7C433C7;
	Thu, 28 Mar 2024 18:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711650500;
	bh=qnTHkMKWFqmASjF7Mj+8qIPTwlEXLcYYW+bC2hrrVzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e/+K/ruKxZb7JvjBJcoirN9aLxCRTyZpGFXYzUtBh+XcBHlV0RLiUsH/ELMzaekKK
	 ic8Nr98JWNxPmMjJ5WNnrQZNNpxdHB/45BjPqVo1D6qftZvJfRTg+gvZrvJ8BcXm5U
	 umsPNXdQ8/3IAa4gLPFPMo0s8Th6f6V6vxeDnqEkXlInG9ek42QSvSlcscILVfMI8j
	 r5iLLBn583f4KnMLhZNOL0p1JvYvoEOsByhDSxO9yYlagbTfv3x0pXgq6N2sOpbGHJ
	 FKy6I0g4ow/sRsXYFyAk0S/NqWtvzxMOcRgmnf7Mg4zyrGoqhzClmGc6Iw7YWIZVMy
	 EOg2vtGhCfuDg==
Date: Thu, 28 Mar 2024 11:28:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, Jerin Jacob
 <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] octeontx2-af: Add array index check
Message-ID: <20240328112818.49c0de17@kernel.org>
In-Reply-To: <20240328081648.13193-1-amishin@t-argos.ru>
References: <20240328081648.13193-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 11:16:48 +0300 Aleksandr Mishin wrote:
> In rvu_map_cgx_lmac_pf() the 'iter', which is used as an array index, can reach
> value (up to 14) that exceed the size (MAX_LMAC_COUNT = 8) of the array.
> Fix this bug by adding 'iter' value check.

I'm guessing you got the 14 from:

	hw->lmac_per_cgx = (nix_const >> 8) & 0xFULL;

Seems more reasonable to cap the size at that point than every use
afterwards.
-- 
pw-bot: cr

