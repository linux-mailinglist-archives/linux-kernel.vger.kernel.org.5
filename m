Return-Path: <linux-kernel+bounces-143705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFDE8A3C74
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B84E1C20F23
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EBD3F9D5;
	Sat, 13 Apr 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.li header.i=thomas.kuehne@gmx.li header.b="nBo/ZaT0"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A814265;
	Sat, 13 Apr 2024 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007342; cv=none; b=BRyqS42GWK0+wi28JC6VMl9vdP+MMZrn4Us+i1zoWpdg2JbR83+etPtF3MJItIpiuBQbZikGItyAfrWoNfuN1xczy6+da+SAA9mSO+L/LkavD9DupaLlaPpWVT3ZQ2vjjOELk7tVqh2BoKZBebnoJOrYsf6lQWtcnyntfz81Duc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007342; c=relaxed/simple;
	bh=Axsr/nzrO25gt5TEC8AG/h4rGLgiv+48O8lzV6yGAUU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VcPt69iWZZAZBHrN+6xf2katR0KuiVcGptocXaX3Od6hHfxL67MmUaYjCWhjghbBAlGlB51tPVmHtWi9MVIW+ZnVBVlJ40Pi/DxSkXbhF3QFMzm+STiBbEm4xiaAETxQMqNoHgk77GXXExYR4yWGnXZfhExSuqWJo6n3nV2oOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li; spf=pass smtp.mailfrom=gmx.li; dkim=pass (2048-bit key) header.d=gmx.li header.i=thomas.kuehne@gmx.li header.b=nBo/ZaT0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.li
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.li;
	s=s31663417; t=1713007335; x=1713612135; i=thomas.kuehne@gmx.li;
	bh=xJgkLJ9NFMdCgJJK4+x3XxjEan/ok72qczaHR/gYZ3M=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nBo/ZaT0QlgNpuX5JaqB9pu4tisf4w2AOGsnno8kI3zrnF7xSfPX+Enz2nyB9i2O
	 Z6wAAU5csALq2BjqlFLelUqxJa+L/r6gO2Iea9FZ4/aRBH1/K4WYcWZz6ojSD7+l4
	 5rd2CLRxSXMkC/s25EnT0oo9HlYy6IzfXryUjMEbZzjMktUhzQtVrkf9//QO01lWH
	 KU3YPzpF/3D+0tLgYFV6wqok54gH1HHcQmnHP0qOBal+FECTblA0u4Cah7H7jtQnR
	 NYDu7icC1zBYof6FhY/zf0r4tdWoLIkzCpMs3PkiWuiwngBvYBd8XHOrAfGuYMo91
	 +GUuba0Fj/OAilwX+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from black ([2.59.120.154]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1swc433c5l-0119yX; Sat, 13
 Apr 2024 13:22:14 +0200
Date: Sat, 13 Apr 2024 12:23:30 +0000
From: Thomas Kuehne <thomas.kuehne@gmx.li>
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hid-debug: more informative output for EV_KEY
Message-ID: <Zhp5QlMGazcW+RV5@black>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:FBWElY3FxUdH8MS8jlylJx/nxPhCcvvkObWTrVYQAgbb6rfPeKI
 aebEh7XciVylwX7l1+9KFK4HFSIAXsZBkGB6NKH0Ena4SHSs5ImUgIot3swyrwLIe/UeUES
 78r4dSrMAmSVd7nQXJkTKZrVkP40CxT8DY9kkTxaSsn/LnrJad/oRNpwRQMAlgvzeThYpxf
 4EcBuhb+H3H0Gg+aKzKnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OTqW0KqRI0A=;ve9dM0XsXOdiUM0XSwr9KaqU5TQ
 RzbwYEn0wWgsSBg6lwaeXT+xiaqlDcLPXdI6NkQOp8Z8E+m8UDsMcjnFHCPDrqIqKYa4iNedD
 0g/RHrLGGPYgq307r+lsGdhjg4WgAsMgOeb9fdcFVHrAI5n9ciWV0w/X4uz4h2VdpW8BBzUOI
 AwhOBi/uk2V8Ekk9pNLbvoA1ZtW9CyCyRdzchmOUYK73/dcQkalIRayo05ltNshR3hMqhuIEy
 bf3l0+y5sth9QRO6ONsQq+HFgycyXJyglC35BzWFC3GcHXdD80QMW+AxR4bP93oAOT7CCHOo7
 X555vL33rFKWCNGlc/WeKuRCk2SKv2PQyMOyBRLJdnVcfUZap7P4lqPAoHzIiGzP3elnaziZv
 AaGnFYeNNoASP8HLkju16Q1aVNrO6ftB/mwapCE5iZq11V7yKBgl+8a23GdI3KnWyoH1NFGUD
 7GLu5gROaNJjfYb/e+6h0nFYMlHOyX8GFz9coshoH/fa0IC9XvOEXyMu6jp6sBcfPD4wMKUJK
 Cp4AkSpUyq7N+ElshWWNPYzNTew/I7kWCx98wWS/j/MszQvUiBHGWcPBMy2f+72tsFnz+b2l4
 80v6LhakDquMjqOd/SPpQXdQSElP34AAXrqS8aNVOVd45cw5lMBlVf/3mlIrM8nVHM4bLfHn6
 rwlJMeuyORnNCVEn0lkOMIMGFMTM1FgY3pBUUirzF+9BYYTb/bAU/ydWS6fPz52wxulgXPbn6
 dR4mJ5/K2+To5ORv5G9bBMrHrK7n/oebSpQQYwYIAXeIxDr40urwFqrE+4yeVgZPhuj9QdWMV
 bzN2PHb0PvWCkt6NpNJqVx0JLIzK+4UwSJ3d8d0bRORiA=
Content-Transfer-Encoding: quoted-printable

Currently hid-debug's hid_resolv_event prints questions marks for
all entries without explicit mapping information. This makes
debugging unnecessarily complicated as multiple different
keys may simply result in the same uninformative output.

Some common event codes are deliberately not defined in
input-event-codes.h. For example the 16th gamepad key.

Instead, print the hexadecimal codes for all events without symbolic
names.

Signed-off-by: Thomas Kuehne <thomas.kuehne@gmx.li>
=2D--
 drivers/hid/hid-debug.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index add353a17853..0a0c435a1284 100644
=2D-- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -3582,8 +3582,15 @@ static const char **names[EV_MAX + 1] =3D {

 static void hid_resolv_event(__u8 type, __u16 code, struct seq_file *f)
 {
-	seq_printf(f, "%s.%s", events[type] ? events[type] : "?",
-		names[type] ? (names[type][code] ? names[type][code] : "?") : "?");
+	if (events[type])
+		seq_printf(f, "%s.", events[type]);
+	else
+		seq_printf(f, "%02x.", type);
+
+	if (names[type] && names[type][code])
+		seq_printf(f, "%s", names[type][code]);
+	else
+		seq_printf(f, "%04x", code);
 }

 static void hid_dump_input_mapping(struct hid_device *hid, struct seq_fil=
e *f)

base-commit: 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39
=2D-
2.40.1


