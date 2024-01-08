Return-Path: <linux-kernel+bounces-19336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5DE826B95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982F61C208A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF9913FEB;
	Mon,  8 Jan 2024 10:29:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382513ACF;
	Mon,  8 Jan 2024 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B1C21A155C;
	Mon,  8 Jan 2024 10:21:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id C8CE620026;
	Mon,  8 Jan 2024 10:21:11 +0000 (UTC)
Message-ID: <486973921f89f70bcc5d42501eeca3fd105be2c4.camel@perches.com>
Subject: Re: [HID Patchsets for Samsung driver v2 2/6] HID: Samsung : Fix
 the checkpatch complain.
From: Joe Perches <joe@perches.com>
To: Sandeep C S <sandeep.cs@samsung.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: gaudium.lee@samsung.com, ih0923.kim@samsung.com,
 suhyun_.kim@samsung.com,  jitender.s21@samsung.com, junwan.cho@samsung.com,
 linux-input@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Mon, 08 Jan 2024 02:21:10 -0800
In-Reply-To: <20240108091917.1552013-3-sandeep.cs@samsung.com>
References: <20240108091917.1552013-1-sandeep.cs@samsung.com>
	 <CGME20240108091959epcas5p2559b779424e2fb7c7e268d1b24612b4f@epcas5p2.samsung.com>
	 <20240108091917.1552013-3-sandeep.cs@samsung.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C8CE620026
X-Stat-Signature: ohyahdhggxcq6imyoria9os1j15h5bc3
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/53bmHUQaLyx7q7JMJOiCZyDhi2zgUNEI=
X-HE-Tag: 1704709271-838445
X-HE-Meta: U2FsdGVkX196M2AdNXOPLo9uz+4s8/IoxjHpXeHLkLeCQAmORr8bhzTvACQY+KOVz3zekDoNImo57EunBEU513qa2RTm3p9lWfSkK457FybOEmGQRcTUp8XTy/gf6xQugTubj1iyTK4Wh7MxgstD6r3mvOj5tLFPjiEEXGTeNPFF3Cj7AAy94fa+ybN/8GYAfJTKHWbtOxRJLcbc1Bzg7jz2BoA47b6ZhoJn4s7ejKhxZraYWQBUAZonO5lYKtreZS45+VtX8A6b7vfJTCxmAX9h/sZTSI6tkxtYQvGBv2jP3Pr8L86mVAcbIZgpmZ56

On Mon, 2024-01-08 at 14:49 +0530, Sandeep C S wrote:
> Warning found by checkpatch.pl script.
[]
> diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
[]
> @@ -67,20 +67,17 @@ static __u8 *samsung_irda_report_fixup(struct hid_dev=
ice *hdev, __u8 *rdesc,
>  		rdesc[178] =3D 0x08;
>  		rdesc[180] =3D 0x06;
>  		rdesc[182] =3D 0x42;
> -	} else
> -	if (*rsize =3D=3D 203 && rdesc[192] =3D=3D 0x15 && rdesc[193] =3D=3D 0x=
0 &&
> +	} else if (*rsize =3D=3D 203 && rdesc[192] =3D=3D 0x15 && rdesc[193] =
=3D=3D 0x0 &&
>  			rdesc[194] =3D=3D 0x25 && rdesc[195] =3D=3D 0x12) {
>  		samsung_irda_dev_trace(hdev, 203);
>  		rdesc[193] =3D 0x1;
>  		rdesc[195] =3D 0xf;
> -	} else
> -	if (*rsize =3D=3D 135 && rdesc[124] =3D=3D 0x15 && rdesc[125] =3D=3D 0x=
0 &&
> +	} else if (*rsize =3D=3D 135 && rdesc[124] =3D=3D 0x15 && rdesc[125] =
=3D=3D 0x0 &&
>  			rdesc[126] =3D=3D 0x25 && rdesc[127] =3D=3D 0x11) {
>  		samsung_irda_dev_trace(hdev, 135);
>  		rdesc[125] =3D 0x1;
>  		rdesc[127] =3D 0xe;
> -	} else
> -	if (*rsize =3D=3D 171 && rdesc[160] =3D=3D 0x15 && rdesc[161] =3D=3D 0x=
0 &&
> +	} else if (*rsize =3D=3D 171 && rdesc[160] =3D=3D 0x15 && rdesc[161] =
=3D=3D 0x0 &&
>  			rdesc[162] =3D=3D 0x25 && rdesc[163] =3D=3D 0x01) {
>  		samsung_irda_dev_trace(hdev, 171);
>  		rdesc[161] =3D 0x1;

For this block, I think a rewrite using memcmp would be clearer.
Something like:
---
 drivers/hid/hid-samsung.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-samsung.c b/drivers/hid/hid-samsung.c
index cf5992e970940..cd84fb5e68f69 100644
--- a/drivers/hid/hid-samsung.c
+++ b/drivers/hid/hid-samsung.c
@@ -58,33 +58,29 @@ static inline void samsung_irda_dev_trace(struct hid_de=
vice *hdev,
 static __u8 *samsung_irda_report_fixup(struct hid_device *hdev, __u8 *rdes=
c,
 		unsigned int *rsize)
 {
-	if (*rsize =3D=3D 184 && rdesc[175] =3D=3D 0x25 && rdesc[176] =3D=3D 0x40=
 &&
-			rdesc[177] =3D=3D 0x75 && rdesc[178] =3D=3D 0x30 &&
-			rdesc[179] =3D=3D 0x95 && rdesc[180] =3D=3D 0x01 &&
-			rdesc[182] =3D=3D 0x40) {
+	if (*rsize =3D=3D 184 &&
+	    !memcmp(&rdesc[175], "\x25\x40\x75\x30\x95\x01", 6) &&
+	    rdesc[182] =3D=3D 0x40) {
 		samsung_irda_dev_trace(hdev, 184);
 		rdesc[176] =3D 0xff;
 		rdesc[178] =3D 0x08;
 		rdesc[180] =3D 0x06;
 		rdesc[182] =3D 0x42;
-	} else
-	if (*rsize =3D=3D 203 && rdesc[192] =3D=3D 0x15 && rdesc[193] =3D=3D 0x0 =
&&
-			rdesc[194] =3D=3D 0x25 && rdesc[195] =3D=3D 0x12) {
+	} else if (*rsize =3D=3D 203 &&
+		   !memcmp(&rdesc[192], "\x15\x00\x25\x12", 4)) {
 		samsung_irda_dev_trace(hdev, 203);
-		rdesc[193] =3D 0x1;
-		rdesc[195] =3D 0xf;
-	} else
-	if (*rsize =3D=3D 135 && rdesc[124] =3D=3D 0x15 && rdesc[125] =3D=3D 0x0 =
&&
-			rdesc[126] =3D=3D 0x25 && rdesc[127] =3D=3D 0x11) {
+		rdesc[193] =3D 0x01;
+		rdesc[195] =3D 0x0f;
+	} else if (*rsize =3D=3D 135 &&
+		   !memcmp(&rdesc[124], "\x15\x00\x25\x11", 4)) {
 		samsung_irda_dev_trace(hdev, 135);
-		rdesc[125] =3D 0x1;
-		rdesc[127] =3D 0xe;
-	} else
-	if (*rsize =3D=3D 171 && rdesc[160] =3D=3D 0x15 && rdesc[161] =3D=3D 0x0 =
&&
-			rdesc[162] =3D=3D 0x25 && rdesc[163] =3D=3D 0x01) {
+		rdesc[125] =3D 0x01;
+		rdesc[127] =3D 0x0e;
+	} else if (*rsize =3D=3D 171 &&
+		   !memcmp(&rdesc[160], "\x15\x00\x25\x01", 4)) {
 		samsung_irda_dev_trace(hdev, 171);
-		rdesc[161] =3D 0x1;
-		rdesc[163] =3D 0x3;
+		rdesc[161] =3D 0x01;
+		rdesc[163] =3D 0x03;
 	}
 	return rdesc;
 }


