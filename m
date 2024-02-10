Return-Path: <linux-kernel+bounces-60582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E464E850757
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A91283659
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB465FEFF;
	Sat, 10 Feb 2024 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxGW1cnT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8EE273FE;
	Sat, 10 Feb 2024 23:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707608886; cv=none; b=RA4X48AXJS+rZwHKrNKNe3ALbFF4w6bT9oh+obiCMAmIZvQz89/1RJHUkqIwnLSJ+CpmngdVPbtE8Wdicdb7l/Zt/aU6PZFzEEZafu2poYo6GeSPAHZ7kvt8f7k47s3HhjlI2QmmujxtYV30xL/bAChGJgG9dLQf8/rTCi04wXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707608886; c=relaxed/simple;
	bh=dYZD4WI7tWl+bu33ScNByuHp4m0cumdmH+nlOirGBXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2Bn1BnBWsmLNXNPE2023DmZWiQYrV9QHijfMtC0xn9E78FXXy53i93oTib7NWIogLRp/JHRgrb0tOY/jwJq0440MclcI+fX3K7b0TT6ZOrEtPI3Cyz2iwkZ5GjdzoHfKbcHP1ZYtkW1Jboyp5m1xiQEuSJ68p1Zcs9wd2B41qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxGW1cnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E029C433C7;
	Sat, 10 Feb 2024 23:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707608886;
	bh=dYZD4WI7tWl+bu33ScNByuHp4m0cumdmH+nlOirGBXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bxGW1cnTG9BwW8XVxe3xT1JAzL+DfdiPiVFfvslLtAkH/ApAs35kV0ZX6C8av4iu6
	 JlhotsfxIyRvpQbmYJG5Le4i9nQLDkxghntgQvcvoi9j2OBLa/RkvQSfrnZ2MNmUFv
	 JXvKyL/dvLo/rRaeAGwsKQI0/WixMMOOIh0oEd3JIW0Z0c/PRt/DFLhC0r82e941rt
	 JGzQ0HWREZvKRh8QCPK3IXRKy8BkkcgFo+B5xTh+wdm8cAwbmAMgBngGZunXs9HTSB
	 SJtcWZ8nYkeDutzMAZRT6cy3YyPPybyd3B5XEXVi2tEsPMHXDw6TW+TEpFi7zZa7Dn
	 MIAKpx4Zi18sA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51182ece518so657954e87.3;
        Sat, 10 Feb 2024 15:48:06 -0800 (PST)
X-Gm-Message-State: AOJu0YzIpncK9FTs1Gx7eOT99lVTLDpedBc2/EKt36cUbO3fCDFil/7k
	fS6lg73uPCk2SsUHlYLe0INaDyCKKREDbdFoOzfJe3D132mSFkubjO3dAyFohmvA0c4Mdy6Kc4Q
	S0q73Ks01xK2swmxGeM2WEQTswc4=
X-Google-Smtp-Source: AGHT+IE1M/QFz/lQt1QS3fwRw8lwklZEkFaHSNp8stPFixImZ7zW0Ru4GlxHTd6Y0FDeCmta4rVcocHXHzzjXPuCNMc=
X-Received: by 2002:ac2:4850:0:b0:511:8692:12 with SMTP id 16-20020ac24850000000b0051186920012mr909565lfy.4.1707608884733;
 Sat, 10 Feb 2024 15:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202155825.314567-1-masahiroy@kernel.org>
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 11 Feb 2024 08:47:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT-C8oWixYji5ejWm=k5ZAx6Z0mPye3Zuc3tjJfT08_Rg@mail.gmail.com>
Message-ID: <CAK7LNAT-C8oWixYji5ejWm=k5ZAx6Z0mPye3Zuc3tjJfT08_Rg@mail.gmail.com>
Subject: Re: [PATCH 00/27] kconfig: refactor lexer and parser code
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 12:58=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Random fixes, cleanups, etc.
>
> Masahiro Yamada (27):
>   kconfig: fix infinite loop when expanding a macro at the end of file
>   kconfig: fix off-by-one in zconf_error()
>   kconfig: remove orphan lookup_file() declaration
>   kconfig: remove compat_getline()
>   kconfig: remove unneeded sym_find() call in conf_parse()
>   kconfig: write Kconfig files to autoconf.cmd in order
>   kconfig: call env_write_dep() right after yyparse()
>   kconfig: split preprocessor prototypes into preprocess.h
>   kconfig: replace current_pos with separate cur_{filename,lineno}
>   kconfig: remove zconf_curname() and zconf_lineno()
>   kconfig: associate struct menu with file name directly
>   kconfig: associate struct property with file name directly
>   kconfig: replace file->name with name in zconf_nextfile()
>   kconfig: do not delay the cur_filename update
>   kconfig: replace remaining current_file->name with cur_filename
>   kconfig: move the file and lineno in struct file to struct buffer
>   kconfig: make file::name a flexible array member
>   kconfig: change file_lookup() to return the file name
>   kconfig: split list_head into a separate header
>   kconfig: resync list.h
>   kconfig: import more list macros and inline functions
>   kconfig: add macros useful for hashtable
>   kconfig: move ARRAY_SIZE to a header
>   kconfig: move strhash() to a header
>   kconfig: convert linked list of files to hash table
>   kconfig: use generic macros to implement symbol hashtable
>   kconfig: do not imply the type of choice value


Applied except 26/27.


26/27 breaks 'make testconfig'.
I will do a respin for 26/27 later.





>  scripts/kconfig/array_size.h |  11 ++
>  scripts/kconfig/conf.c       |  12 +-
>  scripts/kconfig/confdata.c   |  91 +++----------
>  scripts/kconfig/expr.h       |  24 +---
>  scripts/kconfig/hashtable.h  |  48 +++++++
>  scripts/kconfig/internal.h   |  12 ++
>  scripts/kconfig/lexer.l      | 100 +++++++-------
>  scripts/kconfig/list.h       | 254 ++++++++++++++++++++++++++---------
>  scripts/kconfig/list_types.h |  17 +++
>  scripts/kconfig/lkc.h        |   5 +-
>  scripts/kconfig/lkc_proto.h  |  15 ---
>  scripts/kconfig/mconf.c      |   1 +
>  scripts/kconfig/menu.c       |  24 ++--
>  scripts/kconfig/nconf.c      |   1 +
>  scripts/kconfig/parser.y     |  92 +++++++------
>  scripts/kconfig/preprocess.c |  23 ++--
>  scripts/kconfig/preprocess.h |  19 +++
>  scripts/kconfig/qconf.cc     |   2 +-
>  scripts/kconfig/symbol.c     |  46 +++----
>  scripts/kconfig/util.c       |  38 ++++--
>  scripts/kconfig/util.h       |  15 +++
>  21 files changed, 511 insertions(+), 339 deletions(-)
>  create mode 100644 scripts/kconfig/array_size.h
>  create mode 100644 scripts/kconfig/hashtable.h
>  create mode 100644 scripts/kconfig/list_types.h
>  create mode 100644 scripts/kconfig/preprocess.h
>  create mode 100644 scripts/kconfig/util.h
>
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada

