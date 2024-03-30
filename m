Return-Path: <linux-kernel+bounces-125611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09708929A0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9FDB225AB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 07:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96FD79FE;
	Sat, 30 Mar 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUseh+i5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119B7FB;
	Sat, 30 Mar 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711782280; cv=none; b=NClnz5hTmHhjpmggQHjUD8wqAHC+oiqw4ql6Mjblgdm6V4ia0OJ4MdrlbUCTM94oPIlYPENDjivp7nFiDvRQypWovHc8wK3kUTt2vzuA2FsnWZMNdtOJdnv3YLcyvXpNa8HZscOmIeVd1mfih4M46EOqJ8Ycwb5VDfaAfRJW4n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711782280; c=relaxed/simple;
	bh=6skwf4Qku9XlVc9hVSWid4iW7kN43KKMxd9CZDDFHhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSKQ8f6JePNYk/k6avA4FszrYUBqLC49XBMQ6gtf3VaOnhv/VaFz15ssmvetZ8m7N+TcaGSYqwBj8y2+/Bzf0sr9BJzeyrgCZQ81EpxSX0h6UPqhl6QGACC2iavfYpsAk2N+GRSsEeET9uy3rw9rDyaP6n+X3phxzuDVlL1c0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUseh+i5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30554C433C7;
	Sat, 30 Mar 2024 07:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711782278;
	bh=6skwf4Qku9XlVc9hVSWid4iW7kN43KKMxd9CZDDFHhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUseh+i5ndxW1primh8pCO2E/8TcMJ1bPVKtdAnBpp34J90y5pfd2lCIVIurFnpCF
	 qUonlKS0MzoE3hYx77FM0N3ocDVFhCQOxtJrHjsBDKzkqYSpYGg5nNRFvNhvuQ242X
	 kYRu3iHREYRhqL5/iJl0o5yh2Qg1uvK1LjVBGrVlH6y3I2xaTNJti0PFtKTd0tOucI
	 MATCPMf2L7/yedOfhCyS6roaMc1fQFzELcb1DTTiyyoQGTiXQAOgU9DYw78mvsOC1b
	 eiYs+k87RN1Slf1fM32DtPDORUnnREpf7rXkiX6T2gWKj7ttU+Bv0GvugbZQOnAD2c
	 NBdl+o9JUzy8Q==
Date: Sat, 30 Mar 2024 00:04:36 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Zhang Yiqun <zhangyiqun@phytium.com.cn>
Cc: dhowells@redhat.com, jarkko@kernel.org, corbet@lwn.net,
	keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] KEYS: Add ECDH support
Message-ID: <20240330070436.GA2116@sol.localdomain>
References: <20240330065506.3146-1-zhangyiqun@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330065506.3146-1-zhangyiqun@phytium.com.cn>

[+Cc linux-crypto]

On Sat, Mar 30, 2024 at 02:55:06PM +0800, Zhang Yiqun wrote:
> This patch is to introduce ECDH into keyctl syscall for
> userspace usage, containing public key generation and
> shared secret computation.
> 
> It is mainly based on dh code, so it has the same condition
> to the input which only user keys is supported. The output
> result is storing into the buffer with the provided length.
> 
> Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
> ---
>  Documentation/security/keys/core.rst |  62 ++++++
>  include/linux/compat.h               |   4 +
>  include/uapi/linux/keyctl.h          |  11 +
>  security/keys/Kconfig                |  12 +
>  security/keys/Makefile               |   2 +
>  security/keys/compat_ecdh.c          |  50 +++++
>  security/keys/ecdh.c                 | 318 +++++++++++++++++++++++++++
>  security/keys/internal.h             |  44 ++++
>  security/keys/keyctl.c               |  10 +
>  9 files changed, 513 insertions(+)
>  create mode 100644 security/keys/compat_ecdh.c
>  create mode 100644 security/keys/ecdh.c

Nacked-by: Eric Biggers <ebiggers@google.com>

The existing KEYCTL_PKEY_*, KEYCTL_DH_COMPUTE, and AF_ALG are causing enough
problems.  We do not need any more UAPIs like this.  They are hard to maintain,
break often, not properly documented, increase the kernel's attack surface, and
what they do is better done in userspace.

Please refer to the recent thread
https://lore.kernel.org/linux-crypto/CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz/T/#u
where these issues were discussed in detail.

- Eric

