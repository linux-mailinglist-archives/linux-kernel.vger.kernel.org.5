Return-Path: <linux-kernel+bounces-64201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04047853BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B4D1C26796
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5654B60B85;
	Tue, 13 Feb 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="a/I+3k8N"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4F60894;
	Tue, 13 Feb 2024 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854433; cv=none; b=Pnz3ccB10Idx/y7SxOUpYjR/edDSEWgGywF2wjnabFVnQwI9dbtINxoYdJxrh9I6f3P+fefXkx8m9rVjCGvYhNveosLEeavwATjDsiIyRI5yAEfiOJH+AoPO4rxXIDD43W5C/d7fxcSZPRtSMnSxsotavaIbYzcBrKqxus+JvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854433; c=relaxed/simple;
	bh=o+UtUBoWIBnLq7hS5tRy94VdJqWGzZdtZhxoTJc/hNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeDBiG1PX5Rdam9fs8LWbzOmjRU30lhSNTDoT85g+95l1F5/BSEkTt5wkZFOaJlSQZUkR/0Tox7xSgS3cQqtTMNrNFUTVnHp6CZB9T6XpcIX5heACyJ56n1OLAhDiPhSOMHEnwHwM+B1Dr6y3pfGTPjG6ts/oVaPwMHQb+BxWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=a/I+3k8N; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ud9kP134wBy3ssKtmURanYc0oXG48zbkDyfGvOLR8gw=; b=a/I+3k8NEdqqDpeonjGZJj82yW
	5oS3rePXR9zZccQV6iiBFON5q9h+sazljs400x3igksipq5KCdVPTw8us9MH3TjlGczKzWFt2511S
	VSmvmEtZTzAvakf8Vu+TWADcwq6ABP+tAdCdW9s+czq2wUrOVYc6CB8tbAkf1YJuSnWyfqP57uteK
	lcEleXlYSx0GVhmMFf5rwbth+FPVLI76D5gL19Ohuljnw3S1RKGblvWAC2arACs5wVZRqYALvScLO
	V0vCrwtCIlAUqeIgiVqRBYcYse6rTm1rHQ2+DQI5S0csqBOT7a1eEM3SXTL64COOpTzQEc8x1HgTu
	eOt60Ggw==;
Received: from [2001:9e8:9d1:8401:6f0:21ff:fe91:394] (port=48586 helo=bergen.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1rZyws-00HFHx-9G;
	Tue, 13 Feb 2024 21:00:11 +0100
Date: Tue, 13 Feb 2024 21:00:03 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: masahiroy@kernel.org, justinstitt@google.com,
	linux-kbuild@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	morbo@google.com, nathan@kernel.org, ndesaulniers@google.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] gen_compile_commands: fix invalid escape sequence
 warning
Message-ID: <ZcvKQ3SpLNR9RfIe@bergen.fjasle.eu>
References: <CAK7LNARaW1V5X79BFW5_YTKY+n+OSp+_ACpRxpiw+VOJ+2hf=g@mail.gmail.com>
 <20240213022552.754830-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4fCuJxvhdgZQ0EhT"
Content-Disposition: inline
In-Reply-To: <20240213022552.754830-1-andrewjballance@gmail.com>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no


--4fCuJxvhdgZQ0EhT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 12 Feb 2024 20:25:52 GMT, Andrew Ballance wrote:
> with python 12.1 '\#' results in this warning

funny typo: it's Python 3.12 :)

Kind regards,
Nicolas


>     SyntaxWarning: invalid escape sequence '\#'
>=20
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> ---
>  scripts/clang-tools/gen_compile_commands.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-=
tools/gen_compile_commands.py
> index 5dea4479240b..93f64095fda9 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -170,7 +170,7 @@ def process_line(root_directory, command_prefix, file=
_path):
>      # escape the pound sign '#', either as '\#' or '$(pound)' (depending=
 on the
>      # kernel version). The compile_commands.json file is not interepreted
>      # by Make, so this code replaces the escaped version with '#'.
> -    prefix =3D command_prefix.replace('\#', '#').replace('$(pound)', '#')
> +    prefix =3D command_prefix.replace('\\#', '#').replace('$(pound)', '#=
')
> =20
>      # Return the canonical path, eliminating any symbolic links encounte=
red in the path.
>      abs_path =3D os.path.realpath(os.path.join(root_directory, file_path=
))
> --=20
> 2.43.0
>=20

--=20
Nicolas Schier
=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--4fCuJxvhdgZQ0EhT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmXLykMACgkQB1IKcBYm
Emn2WhAAr/uP7ONWF6OazqnaFTX1stVYRqCALkxE77ELcU/9Fwa7+SRBbZHsHoi9
Qxt5pjUssHWVnEtPDfWbr6lrcFlharkhAXkyBr2AN7Se6qrnRIQGVKn9QR8L6q7k
nZprjuStF7beixYrlKtFasfnj9u6XQlwiJ87zF5Cl9usJfDHIf3KOEMrZQHKTUzQ
thAyzIwXXM+q/nSCUk0ot/evURyVjvHqlXS+qeNmUO2qYB8GTKTqXU2QyT/eS6bm
7kXvuMXHeaCoDNPfYWI7qvKvSzs//bjJVvmhCLbRaoF9kaA6e8ppSuPIEDbmYO7A
BPlC6wQAMFCqFLJu8O6miyf6YYXDLth4PTzV+LbI2fTcdowyjgPGMXah3EanDrp/
lnhBx+gUoGKO4pvUHIe6O+KVzSPF2QUjsL716pbeHc+yFF/kJmpP+8aTRmdZb5Vq
OWSNEmzN79/RsnaaAhk2wZQnT9/62han7+N8DZZ2KYOezeSRzcrrAd+UNKlfPLE8
HB+PJ+T4C0EcK2YIhcHVgRiKw3wWcdfVYj6P67rF7TK620hSvomo+mvAQVXUSiDy
2z1mHlz71LEJyyCKwQY15AXRZJF7q01m8Zy8NJcR3aPZAZ3nK35YCElXxpPOrvYh
iWylrp89sQAZ+om9VxwLX4bxbDp1l5Ce5zRI34uLGhWXpuWEF6k=
=EmZL
-----END PGP SIGNATURE-----

--4fCuJxvhdgZQ0EhT--

