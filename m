Return-Path: <linux-kernel+bounces-134958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FA089B957
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8EE284156
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FD1374C3;
	Mon,  8 Apr 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iesaAbYl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB528DBF;
	Mon,  8 Apr 2024 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562585; cv=none; b=BIX4A7rTf6ZHdKAqYSMmVPXpIBNDuO95D2Zpnk39y9jRp3xCmhRmHu+NyhrzE+vMcv3HYZ6kFya0jUaNPlkrNaElJe5v5zSJve4Z7upBhK+Dl/QvVJJ/gQRF7RU52Q64G46OYgXvFpUPaEm51qLOhYhJyi09bY5grcT66+Sric0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562585; c=relaxed/simple;
	bh=LAW48u0YukI7Nx6rcTEvzNn8pI0xiVP9cLF5MviH2/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/fWkxd0iJps2qEs9clBuWW0DdxQDFrfm1Za64xO3L+X+WWmm64L8Ito/Gc5PF7nqFkqfytCGLME1IIQhSFfK7rdH4QPgtxPT0wKAYSDRWbBVA1z4qIG8K7u01dsqh6IchGJvGpmxyXga9yVy48ooDTj3qEiaB6vL8s548TQPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iesaAbYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0F2C433F1;
	Mon,  8 Apr 2024 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712562585;
	bh=LAW48u0YukI7Nx6rcTEvzNn8pI0xiVP9cLF5MviH2/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iesaAbYlJbY3bVmvw//J/0XvCbKc6p8GuvTQhEd4Ec0egMIIG+RZFgflhWdgPSHXP
	 O0XIL5WSXYQe7POMezMhEceqMj+XViMr16DM13dMbMizMAPwA6j12JcflZHjVVZSZB
	 a+9y5RHha2wBrayG0v85B5Sl4Lqdd57rtUt6MON5H2xy9ta9A+YYEqIRsHh6NOcs73
	 yAjA4aLPAvqt7e8AvDeJOEzUGsg59uKmdxpLRpinZy0xnG3mGDb4ujGrGbtk9Yo2E1
	 FlY9cfoUsDpa4dKc64W5eeKKW5VQ6lOP0jNZ6Q7Tu9bv08VqIi0NV1+fWnuqL2oDgW
	 B2eYiQyXb2p2Q==
Date: Mon, 8 Apr 2024 08:49:39 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Noah Goldstein <goldstein.w.n@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib: checksum: hide unused expected_csum_ipv6_magic[]
Message-ID: <20240408074939.GB26556@kernel.org>
References: <20240404163702.241706-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404163702.241706-1-arnd@kernel.org>

On Thu, Apr 04, 2024 at 06:36:45PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_NET is disabled, an extra warning shows up for this
> unused variable:
> 
> lib/checksum_kunit.c:218:18: error: 'expected_csum_ipv6_magic' defined but not used [-Werror=unused-const-variable=]
> 
> Replace the #ifdef with an IS_ENABLED() check that makes the compiler's
> dead-code-elimination take care of the link failure.
> 
> Fixes: f24a70106dc1 ("lib: checksum: Fix build with CONFIG_NET=n")
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> resending v2 to netdev

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

