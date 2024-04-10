Return-Path: <linux-kernel+bounces-139035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D686789FDB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1438B1C22FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D65B17BB3B;
	Wed, 10 Apr 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IL23dQAu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCE17B4F5;
	Wed, 10 Apr 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768693; cv=none; b=deJ0L8F2+uxhRHGsHeNnV0L6SQk2zeujsCuvrDe/sHLfaVptMh+DDH9v3aGUTvDI4/t5KD8BoFOF4pfIoKXcT4I7xaOwvtKAel6ibWX+hR06ihShqkpADKln3hYC4OmLvAEkGk7eh6acVLOGuXkjcsEHBzqSqSL67wyd7xgaMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768693; c=relaxed/simple;
	bh=lGUayZ0NERip+JtN2fxcFADYK4Fi8n9sC6/iV/waWTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nY47TYPETcHdmjfgrE0X0zXfftsdpAbX4J6oUUv/J992LDvVnh6S6NI6a+0kPk6vYXn7EpC/IHLnX6m7502WSYANq787XJDtgvIvkQaC98h316ImAF9bGUvJbHgmdNFxEKA2FUblVDoMNTEkyGKQQzAiqMQM1LGbEp1K991cXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IL23dQAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1EFC433F1;
	Wed, 10 Apr 2024 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768693;
	bh=lGUayZ0NERip+JtN2fxcFADYK4Fi8n9sC6/iV/waWTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IL23dQAuS21Z7Jri7a6tuqD9tixV+AyBTokcwo1EI/YAsR4S6ofOcLw7pBWUV6TRk
	 XcoCJapTePCjvMsMxK8dY7Q0uHUz+ZXL9nZgBZ2D7DURT+9UG8ZKJ4fcRM8QzdN69W
	 LtPrDLJ3HsC6Ej3jSQdp5hZHWPKD7NQII//DoX5Atb/RveQobO+xP9VbiBF9SmjZ26
	 sCnqHBUNHvfcAPi091DcmS/Y3RloyUM9DtRU/qDmNn9T7PYIJyOb2sk+seRlRRhFJE
	 8IoK+5TVhq45Xq8t6JK7e+FZggEzv/pRbLL8SleuxRtwSFDfdPi4PkUDMl1pPIMGrp
	 DjOMpj3/J95EA==
Date: Wed, 10 Apr 2024 10:04:50 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: buildtar: Add arm support
Message-ID: <20240410170450.GA1828262@dev-arch.thelio-3990X>
References: <e7c14a0d329e28bdcda21376b54a43c85a4aaf3f.1712682861.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7c14a0d329e28bdcda21376b54a43c85a4aaf3f.1712682861.git.calvin@wbinvd.org>

Hi Calvin,

Thanks for the patch!

On Tue, Apr 09, 2024 at 10:17:07AM -0700, Calvin Owens wrote:
> Make 'make tar-pkg' and friends work on 32-bit arm.
> 
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>

Technically speaking, buildtar works for 32-bit ARM right now (I use it
almost daily), this is just explicitly adding it to the supported list
to avoid the warning and putting zImage at vmlinuz-${KERNELRELEASE}
instead of vmlinux-kbuild-${KERNELRELEASE}, right?

That said, looks mostly fine to me, one comment below.

Before:

  './System.map' -> 'tar-install/boot/System.map-6.9.0-rc3-00023-g2c71fdf02a95'
  '.config' -> 'tar-install/boot/config-6.9.0-rc3-00023-g2c71fdf02a95'
  './vmlinux' -> 'tar-install/boot/vmlinux-6.9.0-rc3-00023-g2c71fdf02a95'
  'arch/arm/boot/zImage' -> 'tar-install/boot/vmlinux-kbuild-6.9.0-rc3-00023-g2c71fdf02a95'

  ** ** **  WARNING  ** ** **

  Your architecture did not define any architecture-dependent files
  to be placed into the tarball. Please add those to scripts/package/buildtar ...

After:

  './System.map' -> 'tar-install/boot/System.map-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
  '.config' -> 'tar-install/boot/config-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
  './vmlinux' -> 'tar-install/boot/vmlinux-6.9.0-rc3-00023-g2c71fdf02a95-dirty'
  './arch/arm/boot/zImage' -> 'tar-install/boot/vmlinuz-6.9.0-rc3-00023-g2c71fdf02a95-dirty'

and the location of zImage is the only thing that changes as expected.

> ---
>  scripts/package/buildtar | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> index 72c91a1b832f..0939f9eabbf2 100755
> --- a/scripts/package/buildtar
> +++ b/scripts/package/buildtar
> @@ -101,6 +101,9 @@ case "${ARCH}" in
>  			fi
>  		done
>  		;;
> +	arm)
> +		[ -f "${objtree}/arch/arm/boot/zImage" ] && cp -v -- "${objtree}/arch/arm/boot/zImage" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"

While it probably does not matter too much, it would be more proper to
make this

  [ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"

as the current line does not work with CONFIG_XIP_KERNEL=y, since zImage
does not exist (KBUILD_IMAGE is arch/arm/boot/xipImage with this
configuration)

  $ ls arch/arm/boot
  compressed  dts  xipImage

resulting in buildtar failing because

  [ -f "${objtree}/arch/arm/boot/zImage" ]

fails and is the last statement that runs in the script (and the tar
package is not really complete in this configuration anyways).

Prior to this change, the correct image would get placed into the
tarball.

  'arch/arm/boot/xipImage' -> 'tar-install/boot/vmlinux-kbuild-6.9.0-rc3-00023-g2c71fdf02a95'

> +		;;
>  	*)
>  		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-kbuild-${KERNELRELEASE}"
>  		echo "" >&2
> -- 
> 2.39.2
> 

Cheers,
Nathan

