Return-Path: <linux-kernel+bounces-19855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D02827575
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568991F23ABA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CDB5381D;
	Mon,  8 Jan 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMWfUJNK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259354BDF;
	Mon,  8 Jan 2024 16:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB7BC433C8;
	Mon,  8 Jan 2024 16:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704731881;
	bh=WygZITSSEujfD54so4MqFGyTBa68OD3Lin5aOy2bgbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMWfUJNKayP/cEqk1VqEnlahZkPCOBuIOKsFnhZBmJuDPBYlHHpjpYm2oYiTvcFg4
	 1MZe2FSRVs0PaNFlgtK6y40PBO3dqyUTfQfoYozb25H4dGjp4ATEItBo/3cw7tKXcA
	 XPpJ2wPjiMoIRu6K+Pm25+NgFj66dWBWYrr1hFY9lzfWkx6UrCOD+afhABBJSVroZ5
	 EDscvzpn3c8fX8FAYtSqqW45mOE07HtpbMbram2pDlzRCvD1Fg28TyGRYOSNqTdYCj
	 fHitOw6rZolcZJOl/HHG39R5MsiApw4rdJSAPgh43x6i/2D1biFTJ5EVJAF1a7fT/b
	 Djb9jHHkk3GIg==
Date: Mon, 8 Jan 2024 09:37:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: WANG Rui <wangrui@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] scripts/min-tool-version.sh: Raise min clang version to
 18.0.0 for loongarch
Message-ID: <20240108163759.GA2899468@dev-arch.thelio-3990X>
References: <20240108033138.217032-1-wangrui@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108033138.217032-1-wangrui@loongson.cn>

On Mon, Jan 08, 2024 at 11:31:38AM +0800, WANG Rui wrote:
> The existing mainline clang development version encounters diffculties
> compiling the LoongArch kernel module. It is anticipated that this issue
> will be resolved in the upcoming 18.0.0 release. To prevent user
> confusion arising from broken builds, it is advisable to raise the
> minimum required clang version for LoongArch to 18.0.0.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Signed-off-by: WANG Rui <wangrui@loongson.cn>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks a lot for all the work driving getting everything to work
properly with LLVM!

> ---
>  scripts/min-tool-version.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index c62066825f53..9faa4d3d91e3 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -26,6 +26,8 @@ gcc)
>  llvm)
>  	if [ "$SRCARCH" = s390 ]; then
>  		echo 15.0.0
> +	elif [ "$SRCARCH" = loongarch ]; then
> +		echo 18.0.0
>  	else
>  		echo 11.0.0
>  	fi
> -- 
> 2.43.0
> 
> 

