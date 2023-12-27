Return-Path: <linux-kernel+bounces-11899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C884E81ED2A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F2DB2243D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06166ADF;
	Wed, 27 Dec 2023 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="PTN68ztl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A96AA3;
	Wed, 27 Dec 2023 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 27 Dec 2023 09:10:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1703664660; bh=yHjNm4KxLqqPxAzMCgpry3p1RA9R/QeX87BJUF71wg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTN68ztlu3/9knQ9BYxah58qDi+C5RVUaLfRxflPDEBQWxr20U4jK93BgcTKu+s2J
	 38f/+8/DTn98+GZ+AA24MnARG0jU9HDZXKtmaVB10SRXMV6/ZXxtsi2xJ6PL4Uo6qW
	 gs3i/jwlRYJi0nNmL+nwuWxlvBADFFaAGCV24mzw=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 86EC88001F;
	Wed, 27 Dec 2023 09:11:05 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 81D8D181988; Wed, 27 Dec 2023 09:11:05 +0100 (CET)
Date: Wed, 27 Dec 2023 09:11:05 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] kbuild: deb-pkg: remove unneeded '-f
 $srctree/Makefile' in debian/rules
Message-ID: <ZYvcGT0nP6uJR5Ma@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231226135243.1393780-1-masahiroy@kernel.org>
 <20231226135243.1393780-5-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231226135243.1393780-5-masahiroy@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1703664660-FD32DDFE-0F3E500A/0/0
X-purgate-type: clean
X-purgate-size: 1866
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Tue, Dec 26, 2023 at 10:52:42PM +0900, Masahiro Yamada wrote:
> This is unneeded because the Makefile in the output directory wraps
> the top-level Makefile in the srctree.
> 
> Just run $(MAKE) irrespective of the build location.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <n.schier@avm.de>

> 
>  scripts/package/debian/rules | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index 6b2333e3cf96..36d51f60f98d 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -3,8 +3,6 @@
>  
>  include debian/rules.vars
>  
> -srctree ?= .
> -
>  ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
>      NUMJOBS = $(patsubst parallel=%,%,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
>      MAKEFLAGS += -j$(NUMJOBS)
> @@ -18,20 +16,20 @@ make-opts = ARCH=$(ARCH) KERNELRELEASE=$(KERNELRELEASE) KBUILD_BUILD_VERSION=$(r
>  binary: binary-arch binary-indep
>  binary-indep: build-indep
>  binary-arch: build-arch
> -	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
> +	$(MAKE) $(make-opts) \
>  	run-command KBUILD_RUN_COMMAND='+$${srctree}/scripts/package/builddeb'
>  
>  .PHONY: build build-indep build-arch
>  build: build-arch build-indep
>  build-indep:
>  build-arch:
> -	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
> +	$(MAKE) $(make-opts) \
>  	olddefconfig all
>  
>  .PHONY: clean
>  clean:
>  	rm -rf debian/files debian/linux-* debian/deb-env.vars
> -	$(MAKE) -f $(srctree)/Makefile ARCH=$(ARCH) clean
> +	$(MAKE) ARCH=$(ARCH) clean
>  
>  # If DEB_HOST_ARCH is empty, it is likely that debian/rules was executed
>  # directly. Run 'dpkg-architecture --print-set --print-format=make' to
> -- 
> 2.40.1
> 

