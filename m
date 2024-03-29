Return-Path: <linux-kernel+bounces-125413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375D08925A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BA71C20918
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD3433C7;
	Fri, 29 Mar 2024 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZXHZWWKH"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373B3C24
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745508; cv=none; b=t9geA0GfdYGNYcPQ7Epyv2EAPITaW26UssaoZsancZMLT+j9/81Prq8ABFAs8IW4wb0mPU1DmdTflu3XSF1l8SqBMZ9SvBG0dzzaJ2BClSH81RdLW7TrBvsP1nMsnBbWFN1SOb0mHjBx3JgE33tc1RihVpMzrg03bG/Fq95u9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745508; c=relaxed/simple;
	bh=ZFpa7FbviEpZlTbuiCcGoiJ7oVZWG7DqrPW7x3cMQ+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pu7phnOxh4c8m0Fc1SShzTLDjTceBAZvcHszDWPiw6aMm7RyI1eXyQSLz/tV6787vRmJUmsQ7bbGvx1lhevSfnibV03pr7bSF56ePu/REOkhLiJxGn+u3+WSMkJ4vHVVS3O3pQQajtdOKzqs+GaEWASoAP0QBb48K7uRwyITj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZXHZWWKH; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 423FB47C24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1711745502; bh=94atPGKdvmtJTXQd4ievicixxpk5ZjPT78jpcgddab4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZXHZWWKHzKiQtsq/GQrFL3XlFBz/a6Tqvns9UyuDws0g6T2hx7Oy2+E3d9p5vLM+v
	 dsHcwhTR7T4N8Y+oP/+4P1dpaXt6goCELiG9YSVo4KrC7ZyhxD85BVUxQdBMBeH7/W
	 917ujQ9hcODOGzdpyzwkCLymx4sRWOxsaHhldsPDeaMRiackT02OAraIKAFN5PDtO0
	 y8eZZ69vUq8GkWmOZVA5gLhSR3+A20EEtlemA6WSRepJ0P3esnRgnupehNA/SFd5yO
	 c5wonqbiOppIsCM+6Lhb3rXxs1GDqAEBNyK/KiTCHIUOLsfppswkzTmVKAKPtIzROw
	 hT2JA8MdfoxGg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 423FB47C24;
	Fri, 29 Mar 2024 20:51:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>, Jia Tan <jiat0218@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [tech-board] [PATCH 00/11] xz: Updates to license, filters, and
 compression options
In-Reply-To: <202403291221.124220E0F4@keescook>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
 <202403291221.124220E0F4@keescook>
Date: Fri, 29 Mar 2024 14:51:41 -0600
Message-ID: <87h6go3go2.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kees Cook" <keescook@chromium.org> writes:

> On Wed, Mar 20, 2024 at 08:38:33PM +0200, Lasse Collin wrote:
>> XZ Embedded, the upstream project, switched from public domain to the
>> BSD Zero Clause License (0BSD). Now matching SPDX license identifiers
>> can be added.
>> 
>> The new ARM64 and RISC-V filters can be used by Squashfs.
>> 
>> Account for the default threading change made in the xz command line
>> tool version 5.6.0. Tweak kernel compression options for archs that
>> support XZ compressed kernel.
>> 
>> Documentation was revised. There are minor cleanups too.
>> 
>> Lasse Collin (11):
>>   MAINTAINERS: Add XZ Embedded maintainers
>>   LICENSES: Add 0BSD license text
>>   xz: Switch from public domain to BSD Zero Clause License (0BSD)
>>   xz: Documentation/staging/xz.rst: Revise thoroughly
>>   xz: Fix comments and coding style
>>   xz: Cleanup CRC32 edits from 2018
>>   xz: Optimize for-loop conditions in the BCJ decoders
>>   xz: Add ARM64 BCJ filter
>>   xz: Add RISC-V BCJ filter
>>   xz: Use 128 MiB dictionary and force single-threaded mode
>>   xz: Adjust arch-specific options for better kernel compression
>> 
>>  Documentation/staging/xz.rst    | 130 ++++++++---------------
>>  LICENSES/deprecated/0BSD        |  23 ++++
>>  MAINTAINERS                     |  14 +++
>>  include/linux/decompress/unxz.h |   5 +-
>>  include/linux/xz.h              |   5 +-
>>  init/Kconfig                    |   5 +-
>>  lib/decompress_unxz.c           |  39 ++++---
>>  lib/xz/Kconfig                  |  13 ++-
>>  lib/xz/xz_crc32.c               |   7 +-
>>  lib/xz/xz_dec_bcj.c             | 183 ++++++++++++++++++++++++++++++--
>>  lib/xz/xz_dec_lzma2.c           |   5 +-
>>  lib/xz/xz_dec_stream.c          |   5 +-
>>  lib/xz/xz_dec_syms.c            |  16 +--
>>  lib/xz/xz_dec_test.c            |  12 +--
>>  lib/xz/xz_lzma2.h               |   5 +-
>>  lib/xz/xz_private.h             |  20 ++--
>>  lib/xz/xz_stream.h              |   7 +-
>>  scripts/Makefile.lib            |  13 ++-
>>  scripts/xz_wrap.sh              | 157 +++++++++++++++++++++++++--
>>  19 files changed, 487 insertions(+), 177 deletions(-)
>>  create mode 100644 LICENSES/deprecated/0BSD
>
> Andrew (and anyone else), please do not take this code right now.
>
> Until the backdooring of upstream xz[1] is fully understood, we should not
> accept any code from Jia Tan, Lasse Collin, or any other folks associated
> with tukaani.org. It appears the domain, or at least credentials
> associated with Jia Tan, have been used to create an obfuscated ssh
> server backdoor via the xz upstream releases since at least 5.6.0.
> Without extensive analysis, we should not take any associated code.
> It may be worth doing some retrospective analysis of past contributions
> as well...
>
> Lasse, are you able to comment about what is going on here?

FWIW, it looks like this series has been in linux-next for a few days.
Maybe it needs to come out, for now at least?

jon

