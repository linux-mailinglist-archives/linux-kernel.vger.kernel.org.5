Return-Path: <linux-kernel+bounces-27755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A83482F564
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38731F24903
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E21D53D;
	Tue, 16 Jan 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/FP32qA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEA81D521;
	Tue, 16 Jan 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433517; cv=none; b=JpSD9tOAKzWmb+bKR0oaiNI25CX9i4EX/8nlAgsHpbz3/ofp6KPUpa7EEZtG0b9E4w3/KovEUr6J6RD2VDbZ9OMwrPc7iihyWf/CaDYUttR9iC0YNpo5Y+nMZfkZJuott4YA2rtyH5rSBdZjyt8dL1z8eolLpl3LRXvygaG/kkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433517; c=relaxed/simple;
	bh=B8rlXf1IueqTuTpDml4lMwGNJ5SQRj3OuuWeFvVrO8M=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=c3c2PNyfbvSrmpJnQwfNeUlqLRDAtiOO/r5vAnyG9yoZimjCbBkky5vG1OGBDK246UEHKPU4LhkAmL+xMXcsRqRFRWmyvINKJFZbvBJ5QM6f4bQ62X4QCSVhGfe773BFSGUNW/hVtlcwhYZdIBvcpAV6bK1fcaNG2aYN+oE4Lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/FP32qA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A1DC433F1;
	Tue, 16 Jan 2024 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705433516;
	bh=B8rlXf1IueqTuTpDml4lMwGNJ5SQRj3OuuWeFvVrO8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/FP32qARru7jIWYpaWws6d0A/ohcBaw+U8YExv9z7BRlQmCwdEs1ugEp7GUctQN7
	 /tINuOed8BV8acqKGR23Ijl6F/U9UmbSaos5YDbgKJgs+U0R5AOJjqqMw0I92iaSk5
	 y72k1k6EaJPhDRw0W2j/YxgOC707IZ73kmhmPOe9DOmDMqyZAo01HuRnWae1UNTGs+
	 QAm/0nYvpPHMi6wpQUEuQmXbTz9WwwfUbbeGfxzYF/m6j0oyO0/EHraXr7taR+zUI4
	 uYxDUppBnlemRLOszfa4XBqH0j4ysXUXCLg5AN3HUYtdphNVk9S7R/MSMshsfUHd0b
	 IVVyagNi/KY3Q==
Date: Tue, 16 Jan 2024 19:31:52 +0000
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alex Elder <elder@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: ipa: remove the redundant assignment to
 variable trans_id
Message-ID: <20240116193152.GD588419@kernel.org>
References: <20240116114025.2264839-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116114025.2264839-1-colin.i.king@gmail.com>

On Tue, Jan 16, 2024 at 11:40:25AM +0000, Colin Ian King wrote:
> The variable trans_id is being modulo'd by channel->tre_count and
> the value is being re-assigned back to trans_id even though the
> variable is not used after this operation. The assignment is
> redundant. Remove the assignment and just replace it with the modulo
> operator.
> 
> Cleans up clang scan build warning:
> warning: Although the value stored to 'trans_id' is used in the
> enclosing expression, the value is never actually read from
> 'trans_id' [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

## Form letter - net-next-closed

[adapted from text by Jakub]

Hi Colin,

The merge window for v6.8 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens on or after 22nd January.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

