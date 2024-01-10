Return-Path: <linux-kernel+bounces-21668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB73829299
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D36B257AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4081023D5;
	Wed, 10 Jan 2024 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiw5eztN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721111870;
	Wed, 10 Jan 2024 03:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5485C433F1;
	Wed, 10 Jan 2024 03:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704855688;
	bh=hFyD7JFn18c0P76WRINW0EbljDeMpm60zrkIGl7kYho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiw5eztNk8JZ6rKF6q1LwsRY9axhOht08hnzwdkU22MzZo0eELNxNkkTLBzhgIXCJ
	 um48AnMivF/X0qvfJ5VLCDlpwiYrd+WvUo22zma5TGroE1GRA/0q9ZNL1hSGplxX5B
	 df8mtS4+ZIlcenxvgYlT09pF6AipptPzxKE/0MMghCXHjW2te/EKxPCdFVGFmhaIz4
	 oQ1zTgoxBi+d3NspJ5GEfYVF7Wo93z7+/IszRSAzAS41hMWXLuSPmVePNd7RpPpzdf
	 A9Z2ypgHODnEMcdj3gncnuPB3DprgCiyaztZuadX9j8gzgYtwEHDIEqm4+LNrzZ13L
	 y6zEUNWaVVBHA==
Date: Tue, 9 Jan 2024 20:01:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCHv2 1/2] Compiler Attributes: counted_by: bump min gcc
 version
Message-ID: <20240110030126.GA3624259@dev-arch.thelio-3990X>
References: <e1c27b64ae7abe2ebe647be11b71cf1bca84f677.1704855495.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c27b64ae7abe2ebe647be11b71cf1bca84f677.1704855495.git.senozhatsky@chromium.org>

On Wed, Jan 10, 2024 at 11:58:17AM +0900, Sergey Senozhatsky wrote:
> GCC is expected to implement this feature in version 15,
> so bump the version.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/compiler_attributes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 28566624f008..215882a1341a 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -95,7 +95,7 @@
>  #endif
>  
>  /*
> - * Optional: only supported since gcc >= 14
> + * Optional: only supported since gcc >= 15
>   * Optional: only supported since clang >= 18
>   *
>   *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

