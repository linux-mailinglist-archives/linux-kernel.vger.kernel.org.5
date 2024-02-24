Return-Path: <linux-kernel+bounces-79889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD8D8627F1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E67D1F218BE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70D64D9E0;
	Sat, 24 Feb 2024 22:28:45 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A540481C6;
	Sat, 24 Feb 2024 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708813725; cv=none; b=ngfYuXklIrMds4GbQq/aU2cu+slPSiLfS3ywh/Sx+t4e5sDdhKJy7AIhECukUKZaWMQeIYk4Ck89naJZFOPgjNFVqs4Rh2zN98ORMDQ6RIeSfqYNRHEKaZiyjOMMk/d3jho2kYXNqSYlH8gykhmswC5gHvBPij/XXvsY2qWDA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708813725; c=relaxed/simple;
	bh=XFvUuIiArPZtcIaAv5GeV7fVRjc1Q38QRdmJEDP+YqI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=j27zvObdMaK9yPEibBE5keEkEkfHYxHf26cATsX9GbUkjkBlVSfcLeP2xLjO5ydyd/vJ1MNswSY4NfalJtrw6AyZmRgi8DYdjSWrJtMkS+EF4ki3mY79dgnlPHp/i9s7RvgF0d9Ew0jFS0DnDwpr514oulCXXHx/K3eL2Zp1/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DF5C780453;
	Sat, 24 Feb 2024 22:28:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id DAB2317;
	Sat, 24 Feb 2024 22:28:33 +0000 (UTC)
Message-ID: <2cf0b77f51b907969ae83993854773961b4e159c.camel@perches.com>
Subject: sibyte: pointless if tests
From: Joe Perches <joe@perches.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date: Sat, 24 Feb 2024 14:28:32 -0800
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: DAB2317
X-Rspamd-Server: rspamout02
X-Stat-Signature: rbkbkkufbwqdzrt4f99nfrgmpaseaoh4
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+8vWvWo4t1B6xMC3gg99zgB4EFce9pg9I=
X-HE-Tag: 1708813713-824061
X-HE-Meta: U2FsdGVkX1+Uaj7nWPg01jMtq1aN1QyBgqKd4hIUp8kgnnMMpD8AQgkQ59G1gLz5gLxSsCdBlwN/sAaz/Lwq8H7tNI/yngwf54hagJEGeHuKHIgN+g7yHdDMLGgwKOD4bovS0jUzMoVAcGMPRmn0o/oASUxLXmy1UzRtbuXh+DV16aIRowGpzBL7xtyo56qsOyC1koZ6uBGROzytO87qxOCse/lvk3pO7j6D4vN7RyepyXOUWJaM8Jjp1KOdxhLgnLNMH5jrMNtn3OPb3Sxfm54iOnRiG1P/JUejNr6wc3JbqenSKq6P01tF5xuDH/Uc

A checkpatch modification was suggested privately about
braces around an if test like

	if (foo)
		;

so I thought I'd see how many of these possibly pointless
if tests exist.  There aren't many.

Here are a couple in sibyte:

Maybe this should be documented as:

	"well, don't know what to do here"

$ cat if_semi.cocci
@@
expression e;
@@

*	if (e) ;

$ spatch --very-quiet -sp-file if_semi.cocci .
diff -u -p ./arch/mips/sibyte/common/cfe_console.c /tmp/nothing/arch/mips/s=
ibyte/common/cfe_console.c
--- ./arch/mips/sibyte/common/cfe_console.c
+++ /tmp/nothing/arch/mips/sibyte/common/cfe_console.c
@@ -22,8 +22,6 @@ static void cfe_console_write(struct con
 		if (str[i] =3D=3D '\n') {
 			do {
 				written =3D cfe_write(cfe_cons_handle, &str[last], i-last);
-				if (written < 0)
-					;
 				last +=3D written;
 			} while (last < i);
 			while (cfe_write(cfe_cons_handle, "\r", 1) <=3D 0)
@@ -33,8 +31,6 @@ static void cfe_console_write(struct con
 	if (last !=3D count) {
 		do {
 			written =3D cfe_write(cfe_cons_handle, &str[last], count-last);
-			if (written < 0)
-				;
 			last +=3D written;
 		} while (last < count);
 	}


