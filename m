Return-Path: <linux-kernel+bounces-21670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55D482929B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7047B2894C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1805B1870;
	Wed, 10 Jan 2024 03:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NocbWuyD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640578F5B;
	Wed, 10 Jan 2024 03:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611E5C433C7;
	Wed, 10 Jan 2024 03:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704855780;
	bh=A5rzmYISI/sWahGLTcGrNcQxysD0BlcReNeKoH0MPXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NocbWuyDY9gq4Hef6VcDkN1IFNvBwkuLU4trf2y04Xa3f9wAa/9DkNDcS3gJuiClt
	 sJwL+iXAgyA31ZoUnqjPAgN+Xv+fBp/uYvi0og43aKRe6U9msJDKArgQmAAbQx7dfr
	 KmXJ59PPMXlG3HzoFymkmeTFx99VxnZpSQIKehkLPJzCHzLWAZ+eV7LZ/WS5Kk6IG2
	 rReFKY1od7ZQBfXWMi0t7BgsSi1gdtJkiPJpjxz5XTTU51uYxI4TvRjGA3W0JmIiGF
	 5nrrDDhs3KID/UUocbhsRbVw7dyGVnFvBBNVJET9sdxv666sVPWa3aGNLZZN7CtZMU
	 7/pVvTGnfmPPw==
Date: Tue, 9 Jan 2024 20:02:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCHv2 2/2] Compiler Attributes: counted_by: fixup clang URL
Message-ID: <20240110030258.GB3624259@dev-arch.thelio-3990X>
References: <e1c27b64ae7abe2ebe647be11b71cf1bca84f677.1704855495.git.senozhatsky@chromium.org>
 <b7babeb9c5b14af9189f0d6225673e6e9a8f4ad3.1704855496.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7babeb9c5b14af9189f0d6225673e6e9a8f4ad3.1704855496.git.senozhatsky@chromium.org>

On Wed, Jan 10, 2024 at 11:58:18AM +0900, Sergey Senozhatsky wrote:
> The URL in question 404 now, fix it up (and switch to github).
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I sent a patch series today for the rest of the tree, which includes a
link to what happened here:

https://lore.kernel.org/20240109-update-llvm-links-v1-1-eb09b59db071@kernel.org/
https://lore.kernel.org/20240109-update-llvm-links-v1-2-eb09b59db071@kernel.org/

> ---
>  include/linux/compiler_attributes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 215882a1341a..289810685fc5 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -99,7 +99,7 @@
>   * Optional: only supported since clang >= 18
>   *
>   *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
> - * clang: https://reviews.llvm.org/D148381
> + * clang: https://github.com/llvm/llvm-project/pull/76348
>   */
>  #if __has_attribute(__counted_by__)
>  # define __counted_by(member)		__attribute__((__counted_by__(member)))
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

