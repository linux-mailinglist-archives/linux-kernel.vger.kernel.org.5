Return-Path: <linux-kernel+bounces-11894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7547581ED0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D761C22389
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4862363BA;
	Wed, 27 Dec 2023 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="TyLfAH/1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6663A8;
	Wed, 27 Dec 2023 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 27 Dec 2023 08:56:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1703663788; bh=ppkGT7Kj6s6j36J8+e94V+BhFS+R0X9zZwQMqkNg3nY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyLfAH/12eQ2NLq7EICcuFtwgxKxR+Bs58wX8oBD2NUwPjAfP6r9WYYkWYUpHnmOe
	 Oui9wb4RZrE7pkJqGLacGXWRLWWhG7Fj9QuLQgTSDAqnavCspNnJln4eJwd68xyWND
	 hrzGpVC/19tWFjSRHANpLFO6fuojNVT/7g4syANc=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id BB7E2803E7;
	Wed, 27 Dec 2023 08:56:33 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id B5F0018297D; Wed, 27 Dec 2023 08:56:33 +0100 (CET)
Date: Wed, 27 Dec 2023 08:56:33 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] kbuild: deb-pkg: squash
 scripts/package/deb-build-option to debian/rules
Message-ID: <ZYvYsR_pOK3h3DZz@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231226135243.1393780-1-masahiroy@kernel.org>
 <20231226135243.1393780-2-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231226135243.1393780-2-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1703663788-A6FEBDFE-25EC0C3B/0/0
X-purgate-type: clean
X-purgate-size: 2407
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Tue, Dec 26, 2023 at 10:52:39PM +0900, Masahiro Yamada wrote:
> The binary-arch target needs to use the same CROSS_COMPILE as used in
> build-arch; otherwise, 'make run-command' may attempt to resync the
> .config file.
> 
> Squash scripts/package/deb-build-option into debian/rules, as it is a
> small amount of code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>


> 
>  scripts/package/deb-build-option | 14 --------------
>  scripts/package/debian/rules     |  5 +++--
>  2 files changed, 3 insertions(+), 16 deletions(-)
>  delete mode 100755 scripts/package/deb-build-option
> 
> diff --git a/scripts/package/deb-build-option b/scripts/package/deb-build-option
> deleted file mode 100755
> index 7950eff01781..000000000000
> --- a/scripts/package/deb-build-option
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0-only
> -
> -# Set up CROSS_COMPILE if not defined yet
> -if [ "${CROSS_COMPILE+set}" != "set" -a "${DEB_HOST_ARCH}" != "${DEB_BUILD_ARCH}" ]; then
> -	echo CROSS_COMPILE=${DEB_HOST_GNU_TYPE}-
> -fi
> -
> -version=$(dpkg-parsechangelog -S Version)
> -debian_revision="${version##*-}"
> -
> -if [ "${version}" != "${debian_revision}" ]; then
> -	echo KBUILD_BUILD_VERSION=${debian_revision}
> -fi
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index 26bc6239e200..529b71b55efa 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -10,7 +10,9 @@ ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
>      MAKEFLAGS += -j$(NUMJOBS)
>  endif
>  
> -make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE)
> +revision = $(lastword $(subst -, ,$(shell dpkg-parsechangelog -S Version)))
> +CROSS_COMPILE ?= $(filter-out $(DEB_BUILD_GNU_TYPE)-, $(DEB_HOST_GNU_TYPE)-)
> +make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(revision) $(addprefix CROSS_COMPILE=,$(CROSS_COMPILE))
>  
>  .PHONY: binary binary-indep binary-arch
>  binary: binary-arch binary-indep
> @@ -24,7 +26,6 @@ build: build-arch build-indep
>  build-indep:
>  build-arch:
>  	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
> -	$(shell $(srctree)/scripts/package/deb-build-option) \
>  	olddefconfig all
>  
>  .PHONY: clean
> -- 
> 2.40.1
> 

