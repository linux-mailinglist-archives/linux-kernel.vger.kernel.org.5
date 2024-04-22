Return-Path: <linux-kernel+bounces-154007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88E8AD60E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1D51C215C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C41BF24;
	Mon, 22 Apr 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJjMUgn0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DCD1BC41;
	Mon, 22 Apr 2024 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818757; cv=none; b=a2MWEZjjqbxeUFdssexwJ7TkcCdX7dkXDzAwZhv3bJS+7ptnHDqH/OxdozmOtu8Z/2Me/4Q0uN2vugT/wWGMoxzLhzR4ctCARV59yN2DDduyZiI/5X63U5Othz2uRXY7COBjAEfFFvBGHbXrQhG3h71x266ZpGke+IBXcldJ6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818757; c=relaxed/simple;
	bh=Sbq8AQxOxQUWYrB0cQCMBOHJrc2Bf8DYvwxjKQofJlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfcgwtULr/h86Oqk6hrdhxKsIhm/HDpO1Y8LvFynChd3tPBpvuNQPm3bXgAc52/JE6m68Vz5QA3Tmyu56pJNJNjMSu1kp9zGBS+zaqmh3lv5SvTKjtAdbxUFdqHkStZgBauJDVnMjJMEhs1SH+cZUu/vLWQfF75eHcQBJU4kPsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJjMUgn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8ACC2BD11;
	Mon, 22 Apr 2024 20:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713818757;
	bh=Sbq8AQxOxQUWYrB0cQCMBOHJrc2Bf8DYvwxjKQofJlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJjMUgn0EWPR+XMQBeND8aT5mJrXbhcWEIC+L9PIqtQVkXJHp1XcFeCz+z+A2FhDk
	 GEuAlp4VoZrWhfLSEaI3oPdDoDP3BfmI+TCuq97BgbmXOM42DVa/yrJCcoAF9Bhsn7
	 wroMdsKUJ18LZJkwwvVa42O5svFRj623IqCrqvLJ/9ebX9/8p7YE24ryOAEuaoraJ5
	 d8pOi0brRgddYclMPx53K9vs742r7A0LEhR5V59kyKJPU6fTHFp64eEMNyF62A0dNo
	 JIPljxac/lpd8PxzMXAv3RZAtU745rvRCLs8frXVdM8VUO6xV4buD0Qo0ZI1gCf6AW
	 GjqnKxWIKQs9Q==
Date: Mon, 22 Apr 2024 13:45:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: buildtar: remove warning for the default case
Message-ID: <20240422204555.GB770800@dev-arch.thelio-3990X>
References: <20240422154610.2864941-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422154610.2864941-1-masahiroy@kernel.org>

On Tue, Apr 23, 2024 at 12:46:10AM +0900, Masahiro Yamada wrote:
> Given KBUILD_IMAGE properly set in arch/*/Makefile, the default case
> should work in most scenarios. The only oddity is the naming of the
> copy destination, vmlinux-kbuild-${KERNELRELEASE}. Let's rename it
> to vmlinuz-${KERNELRELEASE} because the kernel is often compressed.
> Remove the warning to avoid unnecessary patch submissions when the
> default case suffices.
> 
> Remove the x86 case, which is now identical to the default.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Sounds good to me, the script is extensible enough that if this does not
work by default for some architecture, a new case can be added, rather
than penalizing architectures for which it does work.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/package/buildtar | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> index ed8d9b496305..fe816f62a290 100755
> --- a/scripts/package/buildtar
> +++ b/scripts/package/buildtar
> @@ -59,9 +59,6 @@ cp -v -- "${objtree}/vmlinux" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}"
>  #   build tree.
>  #
>  case "${ARCH}" in
> -	x86|i386|x86_64)
> -		cp -v -- "${objtree}/arch/x86/boot/bzImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> -		;;
>  	alpha)
>  		cp -v -- "${objtree}/arch/alpha/boot/vmlinux.gz" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
>  		;;
> @@ -110,13 +107,6 @@ case "${ARCH}" in
>  		done
>  		;;
>  	*)
> -		cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
> -		echo "" >&2
> -		echo '** ** **  WARNING  ** ** **' >&2
> -		echo "" >&2
> -		echo "Your architecture did not define any architecture-dependent files" >&2
> -		echo "to be placed into the tarball. Please add those to ${0} ..." >&2
> -		echo "" >&2
> -		sleep 5
> +		cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
>  		;;
>  esac
> -- 
> 2.40.1
> 

