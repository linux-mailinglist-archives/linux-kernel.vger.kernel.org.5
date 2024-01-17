Return-Path: <linux-kernel+bounces-28877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE9583041C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C3D281BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8BE1CD3C;
	Wed, 17 Jan 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="BduyVabK"
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658C1D521;
	Wed, 17 Jan 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489476; cv=none; b=u5oPqsumE46/rfF7NHbiRGcKzHGqVSK4r/GaUWmr5lullvRvoHIMUHBKWlJ9sI6HZxs0TB2ABLBG+RJ9RiC+Qd/XniL6kbO69WHJQDRHVGdC/SKnsEuxvhCAZI0L4WzPKpF+wQvJAYj/C9kjw0TuaTXvCDb/Qx0bHlcS9CGTO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489476; c=relaxed/simple;
	bh=HrPZYQqbExd63Zfudzoo3ljRavdvSOtyLIQ4Bi8P7Tg=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-purgate-ID:X-purgate-type:X-purgate-size:
	 X-purgate-Ad:X-purgate:X-purgate; b=mKPEyIGNcyBCeNDBgSVQrSEu6Ru5wMGoAQ+aQU9iMKmgbM4QdEaZlGgc8mo0yEVZr4rdUFOPCNE1chj/H4SGb/AO7mgKEhHO4LfXZDapID/z86MKxLgRRx73dG7s4tGYDPo3EznFRUG9K5zCv55bm/PNqnZUNrSTfd2r+ZP/oBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=BduyVabK; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1705489464; bh=HrPZYQqbExd63Zfudzoo3ljRavdvSOtyLIQ4Bi8P7Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BduyVabKK+1Mp1b/en1S1GIVo95XSaKeg9iUV5j3/Qsz3V59bntrKtrf9sWLTgsF+
	 pJoWe3w/5uMJd4+YAdKrVMuis7UA3GfUwDKAngDQ3QZuJpSsPGO/u2Z/7HQeUJhJhS
	 jza/09Ri+UW9Bs9/mMCgaA2w2TCm/qTYA6csiq+E=
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 17 Jan 2024 12:04:23 +0100 (CET)
Date: Wed, 17 Jan 2024 12:04:22 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] kbuild: deb-pkg: show verbose log for direct
 package builds
Message-ID: <Zae0NpsCckChoCzW@debian-BULLSEYE-live-builder-AMD64>
References: <20240113104339.16131-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240113104339.16131-1-masahiroy@kernel.org>
X-purgate-ID: 149429::1705489463-5855CEB6-63E38E50/0/0
X-purgate-type: clean
X-purgate-size: 2019
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Sat, Jan 13, 2024 at 07:43:36PM +0900, Masahiro Yamada wrote:
> When the Debian package build is initiated by Kbuild ('make deb-pkg'
> or 'make bindeb-pkg'), the log messages are displayed in the short
> form, which is the Kbuild default.
> 
> Otherwise, let's show verbose messages (unless the 'terse' tag is set
> in DEB_BUILD_OPTION), as suggested by Debian Policy: "The package build
> should be as verbose as reasonably possible, except where the terse tag
> is included in DEB_BUILD_OPTIONS." [1]
> 
> This is what the Debian kernel also does. [2]
> 
> [1]: https://www.debian.org/doc/debian-policy/ch-source.html#main-building-script-debian-rules
> [2]: https://salsa.debian.org/kernel-team/linux/-/blob/debian/6.7-1_exp1/debian/rules.real#L36
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - New patch
> 
>  scripts/package/debian/rules | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index 098307780062..697fbfa7595f 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -11,6 +11,14 @@ ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
>      MAKEFLAGS += -j$(NUMJOBS)
>  endif
>  
> +# When KBUILD_VERBOSE is undefined (presumably you are directly working with
> +# the debianized tree), show verbose logs unless DEB_BUILD_OPTION=terse is set.
> +ifeq ($(origin KBUILD_VERBOSE),undefined)
> +    ifeq (,$(filter terse,$(DEB_BUILD_OPTIONS)))
> +        export KBUILD_VERBOSE := 1
> +    endif
> +endif
> +
>  revision = $(lastword $(subst -, ,$(shell dpkg-parsechangelog -S Version)))
>  CROSS_COMPILE ?= $(filter-out $(DEB_BUILD_GNU_TYPE)-, $(DEB_HOST_GNU_TYPE)-)
>  make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(revision) $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
> -- 
> 2.40.1
> 

thanks!

Reviewed-by: Nicolas Schier <n.schier@avm.de>

