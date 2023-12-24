Return-Path: <linux-kernel+bounces-10768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC8081DB8A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686BBB21030
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA59CA68;
	Sun, 24 Dec 2023 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0oKoeIv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26AC8C4;
	Sun, 24 Dec 2023 16:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4FEC433C7;
	Sun, 24 Dec 2023 16:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703436385;
	bh=QeU2Ly31P1TyQMfLFugJcRwwIS7qI78WGMHA0AHX//Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0oKoeIvOCAvGd7wK2QpmXT9nhxMGY36BGiWznZGkEcDiW4GZPxZH6TNMTnwMtN0o
	 dyAFenzJqw4HW5ZDilKuxKevA2XVvz421PWLjjZBTjvSDn2mPSZMCHKOUcKvRnuog7
	 H8SiAxS3Vw+CXQAN54Bo0liY6rx+Tu6Siq4rM1i0zt4W8bxHYdnqE3xJfFMMA9dDJV
	 I2xPN3kFm63uBXbkmf1nsDKVqNoKLIFXk3sdm3nC2XAknk/M+5hj/uXvPECRQ4t/Uo
	 wlNVqVgHXIDNCrMSzV8ETG96vuf412HK5VemAkpbfPGl9rDOovz3P6SLi9TfoFlm8L
	 FJMpBOlLk/ExA==
Date: Sun, 24 Dec 2023 16:46:20 +0000
From: Simon Horman <horms@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Breno Leitao <leitao@debian.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] Documentation: add pyyaml to requirements.txt
Message-ID: <20231224164620.GB228041@kernel.org>
References: <20231222133628.3010641-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222133628.3010641-1-vegard.nossum@oracle.com>

On Fri, Dec 22, 2023 at 02:36:28PM +0100, Vegard Nossum wrote:
> Commit f061c9f7d058 ("Documentation: Document each netlink family") added
> a new Python script that is invoked during 'make htmldocs' and which reads
> the netlink YAML spec files.
> 
> Using the virtualenv from scripts/sphinx-pre-install, we get this new
> error wen running 'make htmldocs':
> 
>   Traceback (most recent call last):
>     File "./tools/net/ynl/ynl-gen-rst.py", line 26, in <module>
>       import yaml
>   ModuleNotFoundError: No module named 'yaml'
>   make[2]: *** [Documentation/Makefile:112: Documentation/networking/netlink_spec/rt_link.rst] Error 1
>   make[1]: *** [Makefile:1708: htmldocs] Error 2
> 
> Fix this by adding 'pyyaml' to requirements.txt.
> 
> Note: This was somehow present in the original patch submission:
> <https://lore.kernel.org/all/20231103135622.250314-1-leitao@debian.org/>
> I'm not sure why the pyyaml requirement disappeared in the meantime.
> 
> Fixes: f061c9f7d058 ("Documentation: Document each netlink family")
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

I think the patch at the link above went through a few revisions
and landed as:

  f061c9f7d058 ("Documentation: Document each netlink family")

And that along the way the requirements.txt update got lost.

Reviewed-by: Simon Horman <horms@kernel.org>

