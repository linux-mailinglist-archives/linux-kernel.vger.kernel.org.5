Return-Path: <linux-kernel+bounces-152548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 962598AC05C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24AD4B20BDB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F13A1DE;
	Sun, 21 Apr 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="lKb381rr"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591C1CAA1;
	Sun, 21 Apr 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721890; cv=none; b=VQEdL/TqONMFeXmGHp9fpf5gcEeUy2f+XeqH5YYhpOvmPDx9EFRZPeasKPHAgYM+GKkwOO/wzyijPzh0HZOu3Kd65qtglhxtaBZuF4B2WDSP3Qo5APffkNP7+kgzWcsJmPjq6AWqB/XJjMJjC3bn02ajo1pF1DjxXt1H0Bb0Dt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721890; c=relaxed/simple;
	bh=5IPXUDBBcbakimn/NOZOKQEFT86gHCEU+F0q4cpL6xk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ju1GhWjYzDNV8dFXCpCLdP721IUFg/n98YIcQT9ERnn9LFka/1qJ2nTBAHo2QjzOQKNufL3bYsvWUIEZdLbYRlInnIooeGclbokmjBou7LepTBB/SlXpgU2kFRQWUthji8AR6S/kjDLAubTZO4vK0LTUFOjLlfmDnqg4QQozX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=lKb381rr; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lk3TilNxi0cj+NwInWVUuirdi32TkuCOqcAWmQKeC98=; t=1713721887; x=1714326687; 
	b=lKb381rr6dg03ZMGhDCBxru0Um11nGD4L5JAqnlfsHrc2xpKnc/pws4YoG5+6hS5qO31cX8FS+t
	RzQ4fExLNl5iLx2n0XNZ0NFy2b5Gvs39qRZDIMaiAX33yJ18asPljTQAzQnoBzQIaM4srJhKhg1qd
	RnqXeNCpEOy9gc5/xGcjR3OAhmxx6ysaNKus0Ac8AUqW/oaC5hqQTHAOvha1jjSk/DbvdxJJnm83n
	SbCpk5VUe5oZycXiOm+fkl7yqR/h5mtjRgDpkiTfmUiW8OyiqglDlm6HWGN7H8xPyknQnLnhlgiDW
	gxthBhSnLwdH9TQHngcMWWlLIJYw4cnB3R8Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rybLS-00000003THp-1f2C; Sun, 21 Apr 2024 19:51:18 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rybLS-00000002MVy-0L55; Sun, 21 Apr 2024 19:51:18 +0200
Message-ID: <80d969b70038f5c0de6f2d912cb1f6b395eea94a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] sh: convert the last use of 'optional' property in
 Kconfig
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org
Date: Sun, 21 Apr 2024 19:51:17 +0200
In-Reply-To: <20240421120824.2713923-2-masahiroy@kernel.org>
References: <20240421120824.2713923-1-masahiroy@kernel.org>
	 <20240421120824.2713923-2-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Masahiro,

On Sun, 2024-04-21 at 21:08 +0900, Masahiro Yamada wrote:
> The 'choice' statement is primarily used to exclusively select one
> option, but the 'optional' property allows all entries to be disabled.
>=20
> This feature is only used in arch/sh/Kconfig because the equivalent
> outcome can be achieved by inserting one more entry as a place-holder.
> This approach is commonly used, for example, LTO_NONE, DEBUG_INFO_NONE,
> INITRAMFS_COMPRESSION_NONE, etc.
>=20
> The 'optional' property support will be removed from Kconfig.
>=20
> This commit converts the last user.
>=20
> Note:
>  The 'default CMDLINE_OVERWRITE' statement does not work as intended
>  in combination with 'optional'. If neither CONFIG_CMDLINE_OVERWRITE
>  nor CONFIG_CMD_EXTEND is specified in a defconfig file, both of them
>  are disabled. This is a bug. To maintain the current behavior, I
>  added CONFIG_CMD_NO_MODIFY=3Dy to those defconfig files.
         ^^^^^^^^^^^^^^^^^^^^^^
     This would be CMDLINE_NO_MODIFY as used in the actual Kconfig files.

I am fine with the change per se, but could you rename CMDLINE_NO_MODIFY to
CMDLINE_FROM_BOOTLOADER as it's used on the other architectures such as arm
and powerpc, preferably using the same help text.

Also, I usually prefer the first word in the subject to be capitalized, i.e=
.

	sh: Convert the last use of 'optional' property in Kconfig

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

