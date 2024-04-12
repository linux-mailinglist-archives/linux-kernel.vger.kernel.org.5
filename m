Return-Path: <linux-kernel+bounces-143396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C178A3813
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3034D1C224D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C440C152180;
	Fri, 12 Apr 2024 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLb+yyKw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1239E8827;
	Fri, 12 Apr 2024 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712958539; cv=none; b=ilvwMRo3Glq8xdkWxGhic00qtVbdYDqkQiZPJF6JQrio6SVFDm8TKrWEhtVTkFK3JdhklVV43uhCovcq/Lq0tphJZevTtCvx/CxZmEujMRDua3ZpZnYYocXVIBK9FxRdbEeqmuS5ins0ULvi4zHKH5BC9YO4h3KqXEg6XzJ/l+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712958539; c=relaxed/simple;
	bh=wHsovwQIflk5tJi490gtZReLoIdMMEYMNvR7V66iTm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVCMcXxAEnK6KyVTWIM2UsLF2B9iylJXDRu3JINSHrFwWB00VLRl9d2GLsFOebynDEnC4g8egc+DF9hwa9F53y1GWhNAdktx05e5zs6ojekX/Ky8dVRftSoHSjNbPrbZN2V7HLGa5O1VJpC5pZbQk6rojcxmduulbP5eI6v2MFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLb+yyKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3BAC113CC;
	Fri, 12 Apr 2024 21:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712958538;
	bh=wHsovwQIflk5tJi490gtZReLoIdMMEYMNvR7V66iTm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLb+yyKwPePC3z9VXOdajD4lIxwC7N4wtaT6zv65DspgaJXB9I1lqqapqFZ3nRQzi
	 fyAu3iQqKDv1Phwj0VFbQHvayAQm8n5kCEe2zItttjtNhpNE8NCw7CgjsoxPAwA2uJ
	 S6loTX0mK1UluRc1hbWinZokr6Vxb/wXTYPy+vXZaMzKVHkmlpvX3ndKiuWVgfwwcJ
	 wUF3tExqq08Ot4ETmMCcODwxMMrOUr5eOl4oJHwCYJzO8RQ5aZI+XY5UmLhi/9v9Wa
	 QRRefRSMcr2Beh2Wvc9oz5Q+pnrnK/4uvHtI/oNzMa8kHSc2yUkU0dV/68yK8A9mPM
	 Ev3X9n4lBg2cA==
Date: Fri, 12 Apr 2024 14:48:56 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: buildtar: Add explicit 32-bit arm support
Message-ID: <20240412214856.GF2252629@dev-arch.thelio-3990X>
References: <e7c14a0d329e28bdcda21376b54a43c85a4aaf3f.1712682861.git.calvin@wbinvd.org>
 <20240410170450.GA1828262@dev-arch.thelio-3990X>
 <ZhcZCwMmANQS39s2@mozart.vkv.me>
 <ZhmKzqxHXaSZmXee@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhmKzqxHXaSZmXee@mozart.vkv.me>

On Fri, Apr 12, 2024 at 12:26:06PM -0700, Calvin Owens wrote:
> Implement buildtar for 32-bit arm, so the zImage (or xipimage) appears
> at boot/vmlinuz-$foo, rather than at boot/vmlinux-kbuild-$foo, matching
> the structure of the tar-pkg on arm64 and other architectures.
> 
> Link: https://lore.kernel.org/all/e7c14a0d329e28bdcda21376b54a43c85a4aaf3f.1712682861.git.calvin@wbinvd.org/
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>

Looks good to me, especially with the added justification of matching
other architectures.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/package/buildtar | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> index 72c91a1b832f..86035c990aec 100755
> --- a/scripts/package/buildtar
> +++ b/scripts/package/buildtar
> @@ -101,6 +101,9 @@ case "${ARCH}" in
>  			fi
>  		done
>  		;;
> +	arm)
> +		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> +		;;
>  	*)
>  		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
>  		echo "" >&2
> -- 
> 2.39.2
> 

