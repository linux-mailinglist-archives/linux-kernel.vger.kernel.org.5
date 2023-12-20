Return-Path: <linux-kernel+bounces-7276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FA381A49E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8481FB25F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9044447A6C;
	Wed, 20 Dec 2023 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gGK5xHD4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843D47A4D;
	Wed, 20 Dec 2023 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703088941; x=1703693741; i=markus.elfring@web.de;
	bh=gEfLWQnd9+b0Ecm0j1dt7pp3gS7iO02w8tVpBjD0hGA=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=gGK5xHD4/upEQGDibJFhcyFDYUeaxS7Sy+Slbr4ehw7UWXNxlI04dkQg4w2O4+5K
	 Y6fw5x+oKUEIgWQTW+yazEhZARkZ1YO/nEAZEtoJZPUmZmR00vV8VpBbwkC/AFBgO
	 qdvv5zO2SHQPQabTe/H70OWBWULu2RRr9NhZAUgVD0Ta/02D/p102w90/lxuLoO9K
	 +6gfFkjDOMeD/HAq4G8o1SMge8pluo/ZEB1HDQ+tWahtvWHTkoIsWb93dG/jvDbMl
	 uDUZhUC8yk14ReHNrhzWfL40PURSizblWTDz2HbWuMdampVA6ObmK99woOIsFYw5B
	 CZ7bwqIThlB6EVL5PQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIc7b-1rU1zE2s1l-00Eo1M; Wed, 20
 Dec 2023 17:15:41 +0100
Message-ID: <154454fe-2cbd-4432-ae44-634b1624504a@web.de>
Date: Wed, 20 Dec 2023 17:15:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
 linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Avadhut Naik <avadhut.naik@amd.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 John Allen <john.allen@amd.com>, Muralidhara M K <muralidhara.mk@amd.com>,
 Tony Luck <tony.luck@intel.com>, William Roche <william.roche@oracle.com>
References: <20231218190406.27479-2-yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 1/3] RAS: Introduce AMD Address Translation Library
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231218190406.27479-2-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VZ1CMcWpi44oruv3gX9iZVGVDcWc5QtxjyFIjGHreD07L+/rfIV
 e/oIkM9H62fQUTX9kpMsUBYIEksNwiSEP2Q7G8Fe8+lKeSxhtuNKjIST8Xcq0H4bWnKVYmj
 TtejieXu5dX41jRPxiO/nurB3InS5dx2ykA5RoAJfh9WpoRlTyakki8lMMJQgWZF3LfaOGc
 KtOJpPU0EcBtMYeqNsU6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8nxw63w+qyw=;MPZZqgrLI5/rl1ccGTBv/vdbywG
 PrlvoohF49xOyfSN/qPmwF9Qxa/vusjBqXF2Nbq3J0fqKq2bBuyP2yfcE1SmNeea1SM/s7p0T
 oRDjilOTOJDesenASziYr4uki4aaChWV1866DFqdpQMkCMEZPx+sYXvnKT+Zg7Jiv0Sanfk0H
 Qqllk1hZf7L/LvrdPlckXsPNpYVuQzFxbQDtiSUSPUqsZ5mx97OQhTAlWIhOT9XwMUgczZade
 C0IqCoa3okc+TxAFANDZarL0dYnbfXZsoX+JpRFg1YLQA7Oib/Np/4S2Cw4W5DDPeBd73gloE
 C/zPv0FaQihkftx3GDX2sxHDaroGB8RwrzATapqbLNGcwhCHk7WD45Zvwexxu5/jWgB+nd2lb
 S9BXDCO44DIG4WRLnarevCnWiOkbt0hNk3k0oSABmo0jSARNWbDhepY07354yNM8sUCGZ/y14
 ZmJscarjYUTRFc0JyY2j0eeh1xNt4YXhNlUMTae6MUKkzsOPlASY34ck+KeS0E+WzmnxL1ez2
 cAUyctoVdRsvPcRrTzTWQ5aQQZwvAtv1W/xCmnhR2Sev+3OC1cdN85wNut/UvkLy2tBCD1LdK
 JIhReqQwK9DKuFWo102cAeqcZLUR9NnsKQBq0Qp3KzaT2Kcppa2Xpk7NfFlfLdbo0DtrLxClM
 YdHZ+oaLjdbljzzBvvZnUBwbWo/u/I1Yr/fLyH4ZlE+W01zCVgzQyTsPy3LiJqRDUxsvw7+5j
 +dFKL548g6nweWQNBqKlvWSgoTeAgLm2u/h3RauzsMFUErDi6eg2nHjGuVegifNnlJEfRJQ4i
 tNb4Gz140MYsQYFZv66cibc0P8v+KhLfxswmX9DEPBslqFLzWzWq//R1ag85DR9F2m4aq/03e
 t80D+D57SrmIsuMveu2nWQ2ttJZxbOJ89O8l5w1/yYeB6jl+pjHGXuatM3nUcM5UtcmI9WpSy
 ytQD09phXzgP8KmiGeHgptFB3Ec=

=E2=80=A6
> +++ b/drivers/ras/amd/atl/core.c
> @@ -0,0 +1,225 @@
=E2=80=A6
> +unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_=
id, unsigned long addr)
> +{
=E2=80=A6
> +	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx))
> +		return -EINVAL;
> +
> +	if (dehash_address(&ctx))
> +		return -EINVAL;
> +
> +	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx))
> +		return -EINVAL;
=E2=80=A6
> +	return ctx.ret_addr;
> +}
=E2=80=A6

I wonder which condition checks should actually be used for such
a function implementation.

How do you think about to avoid also the specification of duplicate
return statements here?

Regards,
Markus

