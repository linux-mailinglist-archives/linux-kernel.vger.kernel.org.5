Return-Path: <linux-kernel+bounces-18878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC10C826478
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E6AB2172B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064DF134AA;
	Sun,  7 Jan 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=ethgen.de header.i=@ethgen.de header.b="uDhXiD6C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from tschil.ethgen.ch (tschil.ethgen.ch [5.9.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD6134B5
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ethgen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethgen.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ethgen.de;
	 s=mail; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xOjQKdDK2DvuAgk/bAS6qH1KAyUAR5e4SwxVcf7A800=; b=uDhXiD6COIj4dCVHs7RsUhW+6v
	n0Qanm5+Boo/eZOf1SQfJhqRp6Ix2/1AIkTpVZuxg7nLbJdvXeyPgz8zDn6jpW0BxN2eZ8/7dxlId
	8xYVKPv2fgbxlgiJnujeS7u6cL+ZvE9ZGmR0OrBWjbS8QteGSb1RBG25FEVptM378bJTd8js9cXpG
	cqpVmd1Wai0wgu/Q2wEJd7t4EZibxahFqzYSRUfd8pGCN0jX+12evR8BpLA/hhgbtb0VuVRGViO/q
	9Ax5RQny22IOhQ87QqoZpDykj4YmXM3nIZNWAh6xDAy9QPIanC8pMcEHyi+39LeJq91+nd2gmXoa5
	l95CkXIjPcSPckQOxkvjGeXBLyLMUNyHezah5x2xnmC9RjUsMx67PYs/zfsLVt+1q/VnYHI6eP183
	xDPsejvVa0SFan2hJjJ0BEjL8ZZjcn0tgXw7nlLmyo20duNj+vaBaKrAfY1XCvGEXsHbJuQqFRcO2
	4obljqZ8L6FpWwe/oEHQGJ5n2K5nn8Ja0S4du8ou0M8r+7PutM2xJv+biPXfgw7yXtm84zWYPiHNe
	P1WvrEeisqrB3tTT+pX2UmGNUXw6wSC8WHEAWcIyorlkQiwv78ORwp8Y3SIat/8gBUSpVrhX/Ty1t
	oZwDG4nAnYT695/znO17Em4HeJQoaTwXFY7OYYsHY=;
Received: from [192.168.17.4] (helo=ikki.ket)
	by tschil.ethgen.ch with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <Klaus+lkml@ethgen.de>)
	id 1rMTfo-0003uY-HX; Sun, 07 Jan 2024 13:58:44 +0000
Received: from klaus by ikki.ket with local (Exim 4.97)
	(envelope-from <Klaus+lkml@ethgen.de>)
	id 1rMTfo-00000000609-1ILe;
	Sun, 07 Jan 2024 14:58:44 +0100
Date: Sun, 7 Jan 2024 14:58:44 +0100
From: Klaus Ethgen <Klaus+lkml@ethgen.de>
To: linux-kernel@vger.kernel.org
Cc: Klaus+lkml@ethgen.de
Subject: Privacy issue with blanking screensaver on 6.5+ kernel
Message-ID: <ZZquFOfeEoU8cZ4F@ikki.ethgen.ch>
Mail-Followup-To: Klaus Ethgen <Klaus+lkml@ethgen.de>,
	linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NAvJsAzl2SLDO8tZ"
Content-Disposition: inline
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt


--NAvJsAzl2SLDO8tZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi,

I have an privacy issue with kernel 6.5+ on AMD GPU.

I usually lock my laptop (AMD GPU) with xscreensaver in blank only mode.
Up to kernel 6.4, this is working perfect.

But since 6.5, sometimes after coming back from sleep, only the desktop
background is black but all windows fully visible. Of cause, I need to
unlock the screensaver to interact with the windows but they are visible
and might have confidential content.

I seen that issue also on a different Lenovo laptop.

There are the facts that I know:
- Kernel 6.5+, last kernel with positive identified bug: 6.6.9
- AMD GPU (I cannot say if other GPUs have the same issue, I only have
  this GPU with such a use pattern.
- Problem occurs after coming back from sleep but not always
- Desktop is fvwm (2 or 3, doesn't matter)
- Screensaver is xscreensaver version 6.06
- Display size is 1920x1200 but read below
- Output is eDP, internal Panel of the laptop (I cannot exclude
  different output as I don't have)

There is another issue in the early 6.5 series that is already fixed. My
laptop has a main resolution of 3840x2400 but this is far from readable.
It is impossible to see any on that resolution. That's why I use
1920x1200 on that display. In the early 6.5 series, the resolution of
1920x1200 was not available anymore, which led me to the idea, that
there was some rework in AMD based driver which has the regression of
the above rework.

About reproducing:
The issue does not happens every time the laptop comes back from sleep.
I have always to check for several days to see if the bug is still there
or not. But it seems that the issue happens more often after longer
sleep.

Regards
   Klaus

Ps. Please keep me in Cc as I am not subscribed to the list.
-- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C

--NAvJsAzl2SLDO8tZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAABCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAmWarhQACgkQpnwKsYAZ
9qzBEQwAvdNhmttL1d0QD9iaAKCwSlvIlOdLrz4OxFThMbYgpNPB3/HRHVho1HpL
D4TQoi//4C/EbrGSMIW0QJLd6WnKz4NUgLr4Cyf3pLAkCxVV0SdygPw9C5aOasYK
NRa6ktJjSmVEnYRFdgwI8xke3ki0bOiWS7BFqje0Hbpt6YheZM96av7mu0x7G/jf
lBd2wNqF1IQArE5vTbYu4kB8h4PVXx3yyrkAuedlxzJvGrkzQ5te2I2DMj5X0Jfg
tlILPQKHww6u2RvbO1zhh8V0aRkU0e/L2WMTLQTNSQg5oOppVOXFOykQ5tHITcS/
ViyPFmp3BEnvOCR5oUvF4Zz72zPQOvaQKfDma68y2disJy8Jwgu9DBjsHNGyNTUH
WeUq/7HrJQhMxf7/1pTe+kvvqwOmW2hZzhwqJpHCB1Mpodskzl5p01i9B7sRnG5j
efk6YZsB1hBCppx+cV2RJ2PQ5kbjZEyKXclrKv4mc0pnmW6SIMAe7qyxwkFP0REt
uujhLSjf
=vDg9
-----END PGP SIGNATURE-----

--NAvJsAzl2SLDO8tZ--

