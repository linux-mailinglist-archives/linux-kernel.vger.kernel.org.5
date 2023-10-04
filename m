Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4F7B8D93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbjJDTpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjJDTo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:44:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63AC9E;
        Wed,  4 Oct 2023 12:44:48 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.63]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N6bo8-1rgQo01axi-017zCF; Wed, 04 Oct 2023 21:44:26 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 578EB3F7AC;
        Wed,  4 Oct 2023 21:44:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1696448664; bh=+sOJ5EgHxT5wYCGHn/JIgpODGmW+glQm+GGjb9pnf38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y2SOzJeM3K50BDYibD/1g609pjzGbIKU84OU5hSiEKDmCX/AHd7B34YEHGlI1Sonf
         kHGlWYKw9RuTRfiakIXPjlxYDnQAqrRpTzAORA/q8T5GKX+F4OemH1pRI5vyYMVuCr
         /F95d4NFX3XEDIYYydkJSHkBsGBF/5fqhlRcXaAE=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 10CBF160; Wed,  4 Oct 2023 21:44:24 +0200 (CEST)
Date:   Wed, 4 Oct 2023 21:44:23 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: remove stale code for 'source' symlink in
 packaging scripts
Message-ID: <ZR3Al3I1wPtCrnjy@bergen.fjasle.eu>
References: <20231001140339.1707548-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20231001140339.1707548-1-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:ainBqd464cZx/Vb+DbKDXyh/8FTURjYbPAn6Vi/aJzpbT36WvtU
 YB13HhnH6Cc+RSOTdJJTe5a/kieF/SCG+mg1RYGshArt8dVuwgHoiLXfyBQOgsX2w2FU807
 bDi1bS1G/aa4jnou2KqWQZHTsFqt5liOXwuad/1KU3UyvjLMwyew7ITIh9tWQBk37vURkmH
 x/ozET5dABZQB7N6TvUPQ==
UI-OutboundReport: notjunk:1;M01:P0:SoTilS0CwDU=;iMXsUyCHU6UypIwJEWNKk3NkZqI
 oYm/GGDwTVRcJX1vhY06Ol3gcsduqTQAk2jG2OERZ1/lKuczHbMzKtUtl74DVX2NJYo3oEeNA
 RJF6NzDRgZjBrK5e9M2QG/kFW+YrpRdomjVKU/GkkKdgx7AuJiSVm3p9/SE/TMeprb8NUj6XM
 SzPFa7duOlyLbTYzsadbpjkvE+Izp4xdGgtUqNWZq4WRplyoRrX15kCo40WtO/r46loBvvm2/
 KyGzUbFcXzWaSpUMvD0oTZ76e82GMFXjBwwCHKC0bOGwKDKmrNiZFlugHf63wb5xva/tAiQQI
 x3VlUdv1lxkj1a0VjBLe92G5j/S/ulw82oUUsalEX9evfspGcxdXr9nSyYeDskhYxz6Atb+q5
 /YRFOJxmJNkTAskKCl5c2CT/N+ZC8l7uXm0u0mEA+NJ0hLpC+VOnYnCTzSJbvOHjSSYd68r1T
 WsHaEhaGSOh3zrGa6Y4p06yOhETwmRl8sVOfZiylCScfCLuQWSfvQ/IuacNgVP3wdyKtxUVLR
 GEcr5k1OY8gqfHkKvKiyCbyBVsR0ep7yfqsqjGW05/tXYxfGZxqX+Z1S8L8GX7ctgwHD8TtB6
 ElpK5oDsBUzCNrIS6x0uF39GfM/buFrxsyc2AuEYdIebsXj8Y6lmTuIExjrshQ0Xzkus8XAtM
 nwCWYPJXAggBh2Nen8NsW8pBLRJzmRkbZL+G6TIvHqXQ6lHIpmEyFmMQyMQp7zF4WMUITuvfr
 UtYO9rrIMpcxN+jaK5VV2yCuOpLmK2Muir0hxFIu9iJ5ilkM4TEkGZd352r0OjxrK9aebBYXw
 XL67WTu188+KBgMmw8Bz8ckhO9JoyDPS2yHDD6T5lhxJNc6I4LSzsqnJLQbVOIA+6Fiewu37c
 ks40rsDdP6X9xtQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 01 Oct 2023 23:03:39 GMT, Masahiro Yamada wrote:
> Since commit d8131c2965d5 ("kbuild: remove $(MODLIB)/source symlink"),
> modules_install does not create the 'source' symlink.
> 
> Remove the stale code from builddeb and kernel.spec.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/package/builddeb    | 1 -
>  scripts/package/kernel.spec | 3 ---
>  2 files changed, 4 deletions(-)
> 
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index bf3f8561aa68..d7dd0d04c70c 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -64,7 +64,6 @@ install_linux_image () {
>  
>  	${MAKE} -f ${srctree}/Makefile INSTALL_MOD_PATH="${pdir}" modules_install
>  	rm -f "${pdir}/lib/modules/${KERNELRELEASE}/build"
> -	rm -f "${pdir}/lib/modules/${KERNELRELEASE}/source"
>  
>  	# Install the kernel
>  	if [ "${ARCH}" = um ] ; then
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index ac3f2ee6d7a0..3eee0143e0c5 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -68,7 +68,6 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEA
>  cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
>  cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
>  ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
> -ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/source
>  %if %{with_devel}
>  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
>  %endif
> @@ -101,7 +100,6 @@ fi
>  %defattr (-, root, root)
>  /lib/modules/%{KERNELRELEASE}
>  %exclude /lib/modules/%{KERNELRELEASE}/build
> -%exclude /lib/modules/%{KERNELRELEASE}/source
>  /boot/*
>  
>  %files headers
> @@ -113,5 +111,4 @@ fi
>  %defattr (-, root, root)
>  /usr/src/kernels/%{KERNELRELEASE}
>  /lib/modules/%{KERNELRELEASE}/build
> -/lib/modules/%{KERNELRELEASE}/source
>  %endif
> -- 
> 2.39.2

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
