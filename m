Return-Path: <linux-kernel+bounces-133332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E1A89A263
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A181C20FE1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A0B17108B;
	Fri,  5 Apr 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IezP4Cxa"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AA16C858;
	Fri,  5 Apr 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334130; cv=none; b=u9uM3U8XQA3/XKjto0S+lFdW7QGKQVCOvOnuZCu6Kra/iUbuppUbum6ZyummRyS9Ijlv6rbE4ZaCkewVcXkUdYakNoEngwD1f7AnB13SylEJNyuYNMEfHpczM9TvanNbRn7N13vX9dtnOJ/O0oqaLQrZ7W7hQaKuf5yxJQDBUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334130; c=relaxed/simple;
	bh=BKLget3zVcch6Et1v/4ZsurOnV/ojVhkQsDlcqhq99g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrlBtEmyMrO5dsC7q26XIO4g8G/vbTZKJQMMUZgDVjxm4zKGmVMBokDMDdNVIUia4Zczh4oj1TL9GI+15sPx+qkS+b3AHGinD7cP7kZTeGnzpfOcT4/Ip9OgZRPM/WTTCrWrVnjGxCnj2s0s+nfbMpJauN9AlpQdcOGHVJCzSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IezP4Cxa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UMHG5WAqDsP+/+fZR/YsyFb3zl/RkAxZvjPf1Xgd3JA=; b=IezP4Cxa2GSeMtKTsc4nkfg149
	6o1VZoolrIuNOna/Ier+kLUe/J0RT6Yo19xdrqGYCfe3diE7QqLPOgrGt6NvXvZpmmlkx+RIgj0XX
	NY6Ov2kVU7G0wRjqp94kOWxaXjbpcZa6hc2uJz7Bfkh5ql8UJrWf04XBdG7egq/1DRaEd7JcNbLwD
	GqNyvupMWZX6+VlxZMJlwdGGLyElKMB3uMloQinDDNP7rE1vlCI4OqFVRqlkZr4PsaefX4gZ0KWCI
	zZamjeGvdxPMNqdXLCuULWKLFTosrqimp4NGNHqdPcRqH/CHVQD3/NuKBp2NNYo33hnxMVymUobRI
	IrDXeHmQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsmKH-00000007yld-21UJ;
	Fri, 05 Apr 2024 16:22:01 +0000
Message-ID: <5628d83f-cc05-46b4-997a-2309701d3a77@infradead.org>
Date: Fri, 5 Apr 2024 09:22:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add MO(mod objs) variable to process ext modules with
 subdirs
To: Valerii Chernous <vchernou@cisco.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: xe-linux-external@cisco.com, Jonathan Corbet <corbet@lwn.net>,
 linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240405100140.1394290-1-vchernou@cisco.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240405100140.1394290-1-vchernou@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 4/5/24 3:01 AM, Valerii Chernous wrote:
> The change allow to build external modules with nested makefiles.
> With current unofficial way(using "src" variable) it is possible to build
> external(out of tree) kernel module with separating source and build

                                           separate

> artifacts dirs but with nested makefiles it doesn't work properly.
> Build system trap to recursion inside makefiles, artifacts output dir
> path grow with each iteration until exceed max path len and build failed

                                                                    failed.

> Providing "MO" variable and using "override" directive with declaring
> "src" variable solve the problem

                 solves the problem.

> Usage example:
> make -C KERNEL_SOURCE_TREE MO=BUILD_OUT_DIR M=EXT_MOD_SRC_DIR modules
> 
> Cc: xe-linux-external@cisco.com
> Cc: Valerii Chernous <vchernou@cisco.com>
> Signed-off-by: Valerii Chernous <vchernou@cisco.com>
> ---
>  Documentation/kbuild/kbuild.rst  | 14 +++++++++++++-
>  Documentation/kbuild/modules.rst | 16 +++++++++++++++-
>  Makefile                         | 17 +++++++++++++++++
>  scripts/Makefile.build           |  7 +++++++
>  4 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> index 9c8d1d046ea5..63e1a71a3b9a 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -121,10 +121,22 @@ Setting "V=..." takes precedence over KBUILD_VERBOSE.
>  KBUILD_EXTMOD
>  -------------
>  Set the directory to look for the kernel source when building external
> -modules.
> +modules. In case of using separate sources and module artifatcs directories

                                                         artifacts

> +(KBUILD_EXTMOD + KBUILD_EXTMOD_SRC), KBUILD_EXTMOD working as output
> +artifacts directory

             directory.

>  
>  Setting "M=..." takes precedence over KBUILD_EXTMOD.
>  
> +KBUILD_EXTMOD_SRC
> +-------------

Extend the underline to the same length as the title.

> +Set the external module source directory in case when separate module
> +sources and build artifacts directories required. Working in pair with

                                           are required.
or
                                           are used.

> +KBUILD_EXTMOD. If KBUILD_EXTMOD_SRC is set then KBUILD_EXTMOD working as

                                                                 works as
or
                                                                 is used as

> +module build artifacts directory

                          directory.

> +
> +Setting "MO=..." takes precedence over KBUILD_EXTMOD.
> +Setting "M=..." takes precedence over KBUILD_EXTMOD_SRC.
> +
>  KBUILD_OUTPUT
>  -------------
>  Specify the output directory when building the kernel.
> diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
> index a1f3eb7a43e2..135be2fc798e 100644
> --- a/Documentation/kbuild/modules.rst
> +++ b/Documentation/kbuild/modules.rst
> @@ -79,6 +79,14 @@ executed to make module versioning work.
>  	The kbuild system knows that an external module is being built
>  	due to the "M=<dir>" option given in the command.
>  
> +	To build an external module with separate src and artifacts dirs use::
> +
> +		$ make -C <path_to_kernel_src> M=$PWD MO=<output_dir>
> +
> +	The kbuild system knows that an external module with separate sources
> +	and build artifacts dirs is being built due to the "M=<dir>" and
> +	"MO=<output_dir>" options given in the command.
> +
>  	To build against the running kernel use::
>  
>  		$ make -C /lib/modules/`uname -r`/build M=$PWD
> @@ -93,7 +101,7 @@ executed to make module versioning work.
>  
>  	($KDIR refers to the path of the kernel source directory.)
>  
> -	make -C $KDIR M=$PWD
> +	make -C $KDIR M=$PWD MO=<module_output_dir>
>  
>  	-C $KDIR
>  		The directory where the kernel source is located.
> @@ -106,6 +114,12 @@ executed to make module versioning work.
>  		directory where the external module (kbuild file) is
>  		located.
>  
> +	MO=<module_output_dir>
> +		Informs kbuild that an external module build artifacts

         drop                       an

> +		should be placed into specific dir(<module_output_dir>)

		                                                      ).

> +		This parameter optional, without it "M" working as

                     parameter is optional. Without it "M" works as both

> +		source provider and build output location

		                                 location.

> +
>  2.3 Targets
>  ===========
>  
> diff --git a/Makefile b/Makefile
> index 4bef6323c47d..3d45a41737a6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -142,6 +142,7 @@ ifeq ("$(origin M)", "command line")
>    KBUILD_EXTMOD := $(M)
>  endif
>  
> +define kbuild_extmod_check_TEMPLATE
>  $(if $(word 2, $(KBUILD_EXTMOD)), \
>  	$(error building multiple external modules is not supported))
>  
> @@ -152,9 +153,25 @@ $(foreach x, % :, $(if $(findstring $x, $(KBUILD_EXTMOD)), \
>  ifneq ($(filter %/, $(KBUILD_EXTMOD)),)
>  KBUILD_EXTMOD := $(shell dirname $(KBUILD_EXTMOD).)
>  endif
> +endef
> +$(eval $(call kbuild_extmod_check_TEMPLATE))
>  
>  export KBUILD_EXTMOD
>  
> +# Use make M=src_dir MO=ko_dir or set the environment variables:
> +# KBUILD_EXTMOD_SRC, KBUILD_EXTMOD to specify separate directories of
> +# external module sources and build artifacts.
> +ifeq ("$(origin MO)", "command line")
> +ifeq ($(KBUILD_EXTMOD),)
> +	$(error Ext module objects without module sources is not supported))
> +endif
> +KBUILD_EXTMOD_SRC := $(KBUILD_EXTMOD)
> +KBUILD_EXTMOD := $(MO)
> +$(eval $(call kbuild_extmod_check_TEMPLATE))
> +endif
> +
> +export KBUILD_EXTMOD_SRC
> +
>  # backward compatibility
>  KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
>  
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index baf86c0880b6..a293950e2e07 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -3,7 +3,14 @@
>  # Building
>  # ==========================================================================
>  
> +ifeq ($(KBUILD_EXTMOD_SRC),)
>  src := $(obj)
> +else ifeq ($(KBUILD_EXTMOD),$(obj))
> +override src := $(KBUILD_EXTMOD_SRC)
> +else
> +src_subdir := $(patsubst $(KBUILD_EXTMOD)/%,%,$(obj))
> +override src := $(KBUILD_EXTMOD_SRC)/$(src_subdir)
> +endif
>  
>  PHONY := $(obj)/
>  $(obj)/:

-- 
#Randy

