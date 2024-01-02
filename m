Return-Path: <linux-kernel+bounces-14087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AD38217C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CEB1C21355
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF92106;
	Tue,  2 Jan 2024 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="dV7wv0RK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CE120E0;
	Tue,  2 Jan 2024 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  2 Jan 2024 07:46:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1704177963; bh=QQev2ciCK3hkHdj2Q1kdmr5ap2bmXVDZb4B/wvBpinY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dV7wv0RKeI5dcz/9uNblIsKQGpxGhoot7b17ZhxDg5fAKBmufxdjr8A1CdceDApGq
	 1pa4kwCaHuVdJlcr+NuGUT7ALkY65Vf3kL6em9vnuZh0HAK6Ct5lAdnYQAIPILhtew
	 N6SHu46p0DfeDsDR6xiCGOpptCZQDE4ZDUBhKFZw=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id E176E805A6;
	Tue,  2 Jan 2024 07:46:02 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id D6EB51830A6; Tue,  2 Jan 2024 07:46:02 +0100 (CET)
Date: Tue, 2 Jan 2024 07:46:02 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Kevin Martin <kevinmbecause@gmail.com>
Cc: joeyzerocrash@protonmail.com, Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: Enable decompression for use by
 EXTRA_FIRMWARE The build system can currently only compress files. This
 patch adds the functionality to decompress files. Decompression is needed
 for building firmware files into the kernel if those files are compressed on
 the filesystem. Compressed firmware files are in use by Gentoo, Fedora,
 Arch, and others.
Message-ID: <ZZOxKh1c4reeR_tl@buildd.core.avm.de>
Mail-Followup-To: Kevin Martin <kevinmbecause@gmail.com>,
	joeyzerocrash@protonmail.com,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1703042081.git.kevinmbecause@gmail.com>
 <941a566eb114701685dc44f708f81891b3bd085b.1703042082.git.kevinmbecause@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <941a566eb114701685dc44f708f81891b3bd085b.1703042082.git.kevinmbecause@gmail.com>
Organization: AVM GmbH
X-purgate-ID: 149429::1704177963-8064B92C-C9B0DD7C/0/0
X-purgate-type: clean
X-purgate-size: 1908
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

Hi Kevin,

> Subject: Re: [PATCH 1/2] kbuild: Enable decompression for use by
>  EXTRA_FIRMWARE The build system can currently only compress files. This
>  patch adds the functionality to decompress files. Decompression is needed
>  for building firmware files into the kernel if those files are compressed on
>  the filesystem. Compressed firmware files are in use by Gentoo, Fedora,
>  Arch, and others.

patch description is squashed into the subject.  Did your tooling
accidentially remove the empty line between?

The patch itself looks good to me.

Tested-by: Nicolas Schier <n.schier@avm.de>

Kind regards,
Nicolas

On Wed, Dec 20, 2023 at 05:22:50AM -0500, Kevin Martin wrote:
> Signed-off-by: Kevin Martin <kevinmbecause@gmail.com>
> ---
>  scripts/Makefile.lib | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1a965fe68..d043be3dc 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -523,6 +523,9 @@ quiet_cmd_xzkern_with_size = XZKERN  $@
>  quiet_cmd_xzmisc = XZMISC  $@
>        cmd_xzmisc = cat $(real-prereqs) | $(XZ) --check=crc32 --lzma2=dict=1MiB > $@
>  
> +quiet_cmd_xzdec = XZDEC   $@
> +      cmd_xzdec = cat $(real-prereqs) | $(XZ) --decompress > $@
> +
>  # ZSTD
>  # ---------------------------------------------------------------------------
>  # Appends the uncompressed size of the data using size_append. The .zst
> @@ -548,6 +551,9 @@ quiet_cmd_zstd22 = ZSTD22  $@
>  quiet_cmd_zstd22_with_size = ZSTD22  $@
>        cmd_zstd22_with_size = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
>  
> +quiet_cmd_zstddec = ZSTDDEC $@
> +      cmd_zstddec = cat $(real-prereqs) | $(ZSTD) --decompress > $@
> +
>  # ASM offsets
>  # ---------------------------------------------------------------------------
>  
> -- 
> 2.41.0
> 

