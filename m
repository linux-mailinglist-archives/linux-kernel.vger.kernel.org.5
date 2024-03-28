Return-Path: <linux-kernel+bounces-122736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2736D88FC40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66AC2917AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA7651B6;
	Thu, 28 Mar 2024 09:57:53 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB64376E5;
	Thu, 28 Mar 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619873; cv=none; b=dcpHmJuaEC4XaXHXZqub0z+3NF7dva4/btbVy3mI5Qyg+Pzqy3PMpM6qIK4fNQU5PBiZ2hyfldHqHtVG8CQ2JnuHAYmNbax4fQvZswcUMgAR71QIK8J80iaV/RzwiyrugxYnJgRovUUf4bbJEZJT0ICjKCXJZ48LczUriJ4M5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619873; c=relaxed/simple;
	bh=VfjOP9sNdYzTZcnGwVYgxZE+kwKdHl8h61ANJqp0Foc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t5/47agdWp5menBmcOWJltQFNXVjcoiz6pCdNVt3CUCPiAX/MJ7uMVAVxoz46C5TNdf+Q9JkNlsf7l+MzlyCR0Xr1D+EURLnLr2lTvfLVRI5Gc4ekbxSPh9j1UpC52WU6RCL33pZolj24tCSmi3WRGoNVH7uSrpCS0Ux0PMx7XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C45471C1348;
	Thu, 28 Mar 2024 09:57:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 734022002D;
	Thu, 28 Mar 2024 09:57:36 +0000 (UTC)
Message-ID: <ef2c96e40bcf777535c9ff2405e4dc5b3138b27e.camel@perches.com>
Subject: Re: [PATCH v4 2/2] scripts: checkpatch: check unused parameters for
 function-like macro
From: Joe Perches <joe@perches.com>
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-doc@vger.kernel.org
Cc: apw@canonical.com, broonie@kernel.org, chenhuacai@loongson.cn, 
 chris@zankel.net, corbet@lwn.net, dwaipayanray1@gmail.com, 
 herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 linux@roeck-us.net,  lukas.bulwahn@gmail.com, mac.xxn@outlook.com,
 sfr@canb.auug.org.au,  v-songbaohua@oppo.com, workflows@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 28 Mar 2024 02:57:35 -0700
In-Reply-To: <20240328022136.5789-3-21cnbao@gmail.com>
References: <20240328022136.5789-1-21cnbao@gmail.com>
	 <20240328022136.5789-3-21cnbao@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 734022002D
X-Rspamd-Server: rspamout08
X-Stat-Signature: 7riserhy3yknb9m7sgmq6fti4q81xd8p
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+g2gqFrn5/7Zkoo0gSWx2LTXg0VwuKnyU=
X-HE-Tag: 1711619856-999954
X-HE-Meta: U2FsdGVkX1/xm2Wdm2oMCUMZ0DkhhGweQNTy8N67yxZaCTWJszs1ZErjTWTfmdVB4tZImk178Kb47yNJ1X4bZ2fvC2kWIycpsMIGfvkozPOruh5kXUgNl6yZXt7Fi5QlHOXoWGgoeFXJNjfgDA9bzcCQHN1gPGbSTVvZsCiIonSzwUwrOMpBxR7MKQ2WhvJdZWVSdV144V8/jhP+0rmIlUfvaPmxV15dm9LWKY3am0ckGHPzumvDereLovNuDt87Mx6oQ0eg6U4wzT6viHNqiQUnx57GlGtqXmKIyyxnQYw6h+RJuMHqDXsl0dHBK9WoUqVURbGXq4cihhQg9LK9OnJHkxppVoF9

On Thu, 2024-03-28 at 15:21 +1300, Barry Song wrote:
> From: Xining Xu <mac.xxn@outlook.com>
>=20
> If function-like macros do not utilize a parameter, it might result in a
> build warning.  In our coding style guidelines, we advocate for utilizing
> static inline functions to replace such macros.  This patch verifies
> compliance with the new rule.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6109,6 +6109,36 @@ sub process {
>  				WARN("TRAILING_SEMICOLON",
>  				     "macros should not use a trailing semicolon\n" . "$herectx");
>  			}
> +
> +			# match "\s*" rather than "\s+" after the balanced parens, as macro d=
efinition with arguments
> +			# is not required to have whitespace after arguments
> +			if ($dstat =3D~ /^\+\s*#\s*define\s+$Ident$balanced_parens\s*(\S+.*)(=
\/[\/*].*)?/) {

I think '(\/[\/*].*)?' doesn't do what you expect
perhaps '(\/[\/\*].*)?'
though I don't know why this should be capture group

> +				my $params =3D $1 || "";


> +				my $body =3D $2 || "";

Should never get the || "" as the 2nd capture group is not optional

> +
> +			    # get the individual params
> +				$params =3D~ tr/()//d;
> +				# remove leading and trailing whitespace
> +				$params =3D~ s/^\s+|\s+$//g;
> +
> +				$ctx =3D~ s/\n*$//;
> +				my $cnt =3D statement_rawlines($ctx);
> +				my $herectx =3D get_stat_here($linenr, $cnt, $here);
> +
> +				if ($params ne "") {

probably unnecessary

> +					my @paramList =3D split /,\s*/, $params;

please use split() with parentheses

> +					foreach my $param(@paramList) {

maybe
				foreach my $param (split(/,/, $params) {
					$param =3D trim($param);
					next if ($param =3D~ /\.\.\.$/);

> +						if ($param =3D~ /\.\.\.$/) {
> +							# if the param name ends with "...", skip the check
> +							next;
> +						}
> +						if ($body !~ /\b$param\b/) {
> +							WARN("UNUSED_PARAM_IN_MACRO",
> +								"Parameter '$param' is not used in function-like macro\n" . "$he=
rectx");
> +						}
> +					}

It seems this logic is a bit redundant to existing
code and might be better added in the block that starts

(line 6026)
# check if any macro arguments are reused (ignore '...' and 'type')

as that already does each param in a #define and
ignores ... and type


