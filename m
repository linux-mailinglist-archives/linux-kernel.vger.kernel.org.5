Return-Path: <linux-kernel+bounces-111428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 194D8886C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843BCB22D64
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C984438E;
	Fri, 22 Mar 2024 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hW8+VDeD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0QV366OT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="glSoNJHf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G/cKCy92"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72551E4A2;
	Fri, 22 Mar 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711111093; cv=none; b=SV51nlyf3mIGZ3SYXn6Z5/dmNi8BH/MXnGWcZq8A6z+Cx4o4CU9wX5bs+868lajsL5/kg0yXoS79TkmZwE13kqeoBqmuN6ZQ+X215OczrMXi1X19uXsNYpekf9vDwbK0IfMlXGBQVFZCm4jhtKKpkWsjEDvKjS4izshB+gL3pBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711111093; c=relaxed/simple;
	bh=15tjurI1jexSxmci0pNrPX6/+b+J8UZRC6bvVYb0kfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbbK9GbHm0o/85CxsiQDdbnIWlP71m/f2fx2LMasMJPxRX4upCO9exECV+ydX9T56PvOLJs/XRZK5Z1KMKMNmjwjoeBYOhpsGK9fzcPar/3UZnVBwDmHAhHHD0hAnKT9xl8ftNbvrgFMrUHZET24b/LSrIIQIUEsOIPr9SIUfRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hW8+VDeD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0QV366OT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=glSoNJHf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G/cKCy92; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 184BC20B4A;
	Fri, 22 Mar 2024 12:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711111084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QnJLtx+GDoU+PN93+arvr4wqI3/TSA8DCa2s94Jv5C0=;
	b=hW8+VDeDoIYsl+z+JmHKDCTliFTYdEavOw6yQj4UEjMIP0Fksh46J8a/zSfkcm5fOMW5VC
	BTd7G3R3piMzzo8QLVwqPd7+BSPWC1xoUHDDik5gr7Y6pQcSDVC/Z9aNUtPBh+DohiY3sN
	aRGExamMqWib5Q9Mruz+7qs0bzBHXJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711111084;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QnJLtx+GDoU+PN93+arvr4wqI3/TSA8DCa2s94Jv5C0=;
	b=0QV366OTz5PmJ292Fku/6U8g0cXBa3VpQ8pbFEzmsKVjd05bos8bE7pW4lAEzetcCcPkDP
	iPsgeV4B+yU/D1Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711111083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QnJLtx+GDoU+PN93+arvr4wqI3/TSA8DCa2s94Jv5C0=;
	b=glSoNJHf0nVCDsQYo+u5QGLLI12D8ABqxYSp6twS4uEJlHBH/wEp8okUvuTjSOqu88Z1NM
	ooNzbzyPAhCspc0iUdieNqFqBbc1Ht4FgX1YdFghsrUMyWTbghwVKk8eJTPSOfjjE6ny0j
	PFWfS6DHBwPNzjKOFNc2So4SE1oEwJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711111083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QnJLtx+GDoU+PN93+arvr4wqI3/TSA8DCa2s94Jv5C0=;
	b=G/cKCy92vNPyf+4nFoLo9Z5DzYNxspg8cZHxcJM+AaLLhi+uqaTcGxtRleUhld21OxsB+z
	CM6laCjgYxxjXoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E550A13688;
	Fri, 22 Mar 2024 12:38:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W1ZsNqp7/WXnAgAAD6G6ig
	(envelope-from <trenn@suse.de>); Fri, 22 Mar 2024 12:38:02 +0000
From: Thomas Renninger <trenn@suse.de>
To: Len Brown <lenb@kernel.org>, Justin Ernst <justin.ernst@hpe.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Justin Ernst <justin.ernst@hpe.com>
Subject: Re: [PATCH] tools/power/turbostat: Fix uncore frequency file string
Date: Fri, 22 Mar 2024 13:38:02 +0100
Message-ID: <1980117.DIVbhacDa7@work.fritz.box>
In-Reply-To: <20240308204957.2007212-1-justin.ernst@hpe.com>
References: <20240308204957.2007212-1-justin.ernst@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7509112.W097sEU6C4";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Score: -8.61
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-8.61 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[hpe.com:email,suse.de:dkim,suse.de:email];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=glSoNJHf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="G/cKCy92"
X-Rspamd-Queue-Id: 184BC20B4A

--nextPart7509112.W097sEU6C4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Thomas Renninger <trenn@suse.de>
To: Len Brown <lenb@kernel.org>, Justin Ernst <justin.ernst@hpe.com>
Date: Fri, 22 Mar 2024 13:38:02 +0100
Message-ID: <1980117.DIVbhacDa7@work.fritz.box>
In-Reply-To: <20240308204957.2007212-1-justin.ernst@hpe.com>
References: <20240308204957.2007212-1-justin.ernst@hpe.com>
MIME-Version: 1.0

On Freitag, 8. M=E4rz 2024 21:49:57 CET Justin Ernst wrote:
> Running turbostat on a 16 socket HPE Scale-up Compute 3200 (SapphireRapid=
s)
> fails with: turbostat:
> /sys/devices/system/cpu/intel_uncore_frequency/package_010_die_00/current=
_f
> req_khz: open failed: No such file or directory
>=20
> We observe the sysfs uncore frequency directories named:
> ...
> package_09_die_00/
> package_10_die_00/
> package_11_die_00/
> ...
> package_15_die_00/
>=20
> The culprit is an incorrect sprintf format string "package_0%d_die_0%d" u=
sed
> with each instance of reading uncore frequency files.
> uncore-frequency-common.c creates the sysfs directory with the format
> "package_%02d_die_%02d". Once the package value reaches double digits, the
> formats diverge.
Yep, currently in:
drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
line 238.

Looks like the proper bugfix.
=20
> Change each instance of "package_0%d_die_0%d" to "package_%02d_die_%02d".
>=20
> Signed-off-by: Justin Ernst <justin.ernst@hpe.com>

Reviewed-by: Thomas Renninger <trenn@suse.de>

       Thomas
--nextPart7509112.W097sEU6C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEo0EXulPW3gW/5bAoTxjWwdl3vVUFAmX9e6oACgkQTxjWwdl3
vVXxNwf5AWawwcrw7oZOe5MpqLkq3TLMdUCnB2ZyDdYQvL/53El5phMTS1giob/S
xdppK7m50CrbWVw3rugnrN/ljgQ1FAhLzmL2yfJ16WO3LtQxUttNfFWFLg/4Ug4n
MCdeKa8FamtxQu4CTLijPjx1LWcCSISxjCrFMb4Fvuz5EkVZfj1F2sOV8A/shpfK
hPS23mywWpC5UwFEh0i3kKLil0QexN3oF3A5xj2byqfQr8TOMrKAC8Lm8JkAD9si
EFueVsnoVzJLMqW4D8q80rQByjau3GHGHn9q+8o4hEmfNXu821Dv/SZUu72xnydC
6dk3bBfCNR3w8UYTjf/JNv24LdkG5w==
=nD7I
-----END PGP SIGNATURE-----

--nextPart7509112.W097sEU6C4--




