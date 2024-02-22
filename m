Return-Path: <linux-kernel+bounces-75750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1585EE6B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CDA21F232B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F2111AA;
	Thu, 22 Feb 2024 01:05:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061F812E49;
	Thu, 22 Feb 2024 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708563944; cv=none; b=GI5At/X6pjMZHC7Iw+ICeOUS07CV9pbKhJllmGrSV2Hljp3uAhtN7ZMJ5+KReYgWsbhZKdYoKBmdZJ1QFwX2dnGl+1kaXRtZB6dT4DtIDv2brpqYqxxjYmYASBXMrp+EK5Bd+d7yyIa6bDsAGia9P3lsmdUHaBHRxhEAUbMZkkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708563944; c=relaxed/simple;
	bh=FsJU68LcNxW7h4DF/UR5XSZahK63i7JaNo9cTyHunOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=De3FxXe8O5Leh0LMqIk9oz3t2S6S3ZgPptW1XpbruiVaXOWTh9jDz9zwmTv3kFK/aTueHff5xLgg30PuRv3lfTI9+1qtpSeLB4N33V6Rc4JwnSXzYQpGiKoijnGk11SLgg3zAZiTGEwasJFHplGmyBUQ4sjXny6eLiGKMrDdISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 400B7C0C28;
	Thu, 22 Feb 2024 01:05:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id AA0B12002C;
	Thu, 22 Feb 2024 01:05:31 +0000 (UTC)
Message-ID: <bccc704fc78b362bbc57a79eb240219f5ec1548e.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add check for snprintf to scnprintf
From: Joe Perches <joe@perches.com>
To: Justin Stitt <justinstitt@google.com>, Andy Whitcroft
 <apw@canonical.com>,  Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, Finn
 Thain <fthain@linux-m68k.org>
Date: Wed, 21 Feb 2024 17:05:30 -0800
In-Reply-To: <20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com>
References: <20240221-snprintf-checkpatch-v2-1-9baeb59dae30@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: AA0B12002C
X-Rspamd-Server: rspamout02
X-Stat-Signature: cyucsypd3qhnw59f9ezfa9557qf9fsux
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/0uf+Q0wPPk+E8Q442h+fw1PySOnfqySI=
X-HE-Tag: 1708563931-486686
X-HE-Meta: U2FsdGVkX18di8ZY8Lx3J5yZpNPSNulE1qFL0I57DOQ/eaeZywd5jWcZRnNYgG9paRrRvpE8dgeSdevTISn2cf5OLsschxZqnxdaV1U5bNYMB3HbohNNP5DYTyH/PCP14IZjr+ZnLIkcEeros7ZlNQRMMqz4Ni7+YyLmDTb0JAFt3G9VePngpbF4XmwmG9sh/6SyPr8V6K9g2CDvS5wCUfX3QM1aG5Sy5CpwLE/PqbIfkPajWImacyXWI/iqxo5uv0vHoGTbjA3Yxs1mFm2ZeUCYNDIg8ZjVri0JAGKtNHgh2k87u6OTNysp4pnrxxTnFgYssMhs6MUiHAv81+a8lpqWmNmVDE6SHhaczHD1CMIkD+TYjS9Tvifnq0tmLhABz9CAq/DpfO0DUcwLyio6P2DOZkvwIz3/+8iJBFJGhF2nKDWH/YNEfEVEj6Lw9H/awthTWL3Qe14EoJjIDXsp/1y6fHCrG7WPSjezpj4e8tI=

On Wed, 2024-02-21 at 22:11 +0000, Justin Stitt wrote:
> I am going to quote Lee Jones who has been doing some snprintf ->
> scnprintf refactorings:
>=20
> "There is a general misunderstanding amongst engineers that
> {v}snprintf() returns the length of the data *actually* encoded into the
> destination array.  However, as per the C99 standard {v}snprintf()
> really returns the length of the data that *would have been* written if
> there were enough space for it.  This misunderstanding has led to
> buffer-overruns in the past.  It's generally considered safer to use the
> {v}scnprintf() variants in their place (or even sprintf() in simple
> cases).  So let's do that."
>=20
> To help prevent new instances of snprintf() from popping up, let's add a
> check to checkpatch.pl.
>=20
> Suggested-by: Finn Thain <fthain@linux-m68k.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - Had a vim moment and deleted a character before sending the patch.
> - Replaced the character :)
> - Link to v1: https://lore.kernel.org/r/20240221-snprintf-checkpatch-v1-1=
-3ac5025b5961@google.com
> ---
> From a discussion here [1].
>=20
> [1]: https://lore.kernel.org/all/0f9c95f9-2c14-eee6-7faf-635880edcea4@lin=
ux-m68k.org/

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7012,6 +7012,12 @@ sub process {
>  			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see:=
 https://github.com/KSPP/linux/issues/90\n" . $herecurr);
>  		}
> =20
> +# snprintf uses that should likely be {v}scnprintf
> +		if ($line =3D~ /\bsnprintf\s*\(\s*/) {
> +				WARN("SNPRINTF",
> +				     "Prefer scnprintf over snprintf\n" . $herecurr);

There really should be some sort of reference link here
similar to the one above this.

Also, I rather doubt _all_ of these should be changed just
for churn's sake.

Maybe add a test for some return value use like

		if (defined($stat) &&
		    $stat =3D~ /$Lval\s*=3D\s*snprintf\s*\(/) {
			etc...

Maybe offer to --fix it too.


