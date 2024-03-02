Return-Path: <linux-kernel+bounces-89370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 643E886EF81
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047051F232FD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733E9134AB;
	Sat,  2 Mar 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ssCxMlfw"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF967134C0;
	Sat,  2 Mar 2024 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709367931; cv=none; b=EsKtz6kWuZBNa2173+7Jc5AuYUBrzZ4HBanX4v6IfGSfucP29Ykj/Fa/Pt7xV2lYjxqXlbt0YRkUocaHq0KocytlAumHMjyPRymysuqdtCPeBYmCBLdAnoS04jiJg5h+4No/t4mF5hTyl1ed2G//2Bm1wUGwpT/dkVwA4yg8DO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709367931; c=relaxed/simple;
	bh=/IG9/MvSXI2w4ZqCioEYLm/AwTPThoGcnx9Is/OAFXM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=urofCfqKh/MsYIgU5PWrC0Y9yMyaSD8TEr/9S5ygWICbT+OwGo+av7YwrI9TuVX1SOTqVo+R5c+txhy5kt/00rI2WZ0EN0PIt7dWopucbOqFYt7eyQr6PtSA1syaoXhKqpTED/pOxXjcxFCeHjZSPzr4gsHy1qMSpS1oFn16qZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ssCxMlfw; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709367911; x=1709972711; i=markus.elfring@web.de;
	bh=/IG9/MvSXI2w4ZqCioEYLm/AwTPThoGcnx9Is/OAFXM=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=ssCxMlfwCti+lOYRr21QF1mgHtF/RJ2XEgyrgSRDdTolNlWxeYRylRsMCZwpUutg
	 4yEfrW5hdcg24pVXOCLhX1CiSekUjtHJ+Lg1mgPcplrEL3TPwSUvHgrIYxllbDme1
	 cui/uo9Ext4bJQ/QjHrJFUGwWZa0eNhtf6t6+jGrnsTqn+mw/yY25qZWF+HExrKFO
	 DJ+YXBVKR5lXTJKntIJYcVVJFms0L8myBq+CcvEMUTdhTOnNZyz3VkJtJ6WVdzVMj
	 GWSFRIvFbVsnraGwXBzKjZ3TbpnljoF3b5jAaQr/Rk0gjCocKZGO9i6ae0WCBFNAM
	 vrkCAji9FxFdgxD59w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVsa-1r0vNZ35Re-00lx1U; Sat, 02
 Mar 2024 09:25:11 +0100
Message-ID: <6bf9f962-cf75-459d-89f4-2546063fc154@web.de>
Date: Sat, 2 Mar 2024 09:24:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeff LaBundy
 <jeff@labundy.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 ye xingchen <ye.xingchen@zte.com.cn>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] Input: iqs269a - Use common error handling code in
 iqs269_parse_chan()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iU4w52N3qhKoRJLZZSPtf+QHPTsIuBjeHh8AJHJA3BiJ68hGjUg
 OnTVLq4wHVnSswAktXNc6dfsXtZ6yA+MUmif4fJ6HWmKukEu+vAd4rMkWVcUIlQruvyQUdo
 X93656kXivda+FvLfXLBYRmORhXDo7N1QGteUQpqZckHV0+KOsIBPG0DQ6qxuq7JDQGCac4
 I4j0Y3JEHv1YIntrt0MdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FRSmwSz1bmE=;ENul1wobOmr+CBbTNQETJkUvNDM
 AsjLTij0F36cjs1ms8NK65I/gPpWSEUtZhMuvEoqUDRgm5CImCgra+4bb7tK8eLxwxjyiYHDO
 Jfa7MfMo54QvXFn1F+2bkNES2YyNdx3jdq/YxodC84JrpKj28EaIUy7gv6E8DZMYVXSaaOTyT
 Hab9fOV/ftFhhIk/FATVYsJCxL75lT+qj31R3qLHLkCre5nbFqcAc0Wpd4FN9ygu58J2b6yxm
 YEAK9Y655F4JMCLpLzJzHJeJqirQhMyddilrhP166oW4j+iFCH3q+3kqNkw3f/uYmXhhrrHeU
 gYG4++xz45Ij7JZ5tdmSe83k/1MffxdLL7mdBsh3FOUWYsRamDwlElYkFgFxM4aZ98hsw62s9
 TQgPKTrNV3CqPHdqyfRPozGgIJDttHD1s9BuMXl2Ple2hFxsS44flAXAhsEJzeF3xfqo8rN5H
 evYRggqUkOu4adB4QoRutX1PNzDSO82evjnpAQcK9dBW44NFjLbfFIX5zLfRTLeulDzIhQG4I
 jkjZBXfr9+hdzjfv61YjKb9v/Ercao0q7pim6XhM4IJ6PtEiEsp0s+9ELz0mnDwQRGSFkO/n3
 WPcdDKxbAzVqhDfdCze4tKbWST9xjH7Tiohyebk+54BFbKNgRjYD4wG8kYXFWNzhO87nkBNJ3
 4NDiUjxpVeolTzqynZfMJceAdHoxK1m5qYxkXvaLBTuveA6k7pHHplf21Tv+Dzj3f4coJJG20
 Ozi+XuxQdJyWQYYYAbgdwRcYzBQfvBXnrU2qlFQniW9adSC9hNdZmFv0VJsinPbOKr//J1b0i
 iYK4aAhd0HDgJzeEvnLO2kJZgyAp+z82vimTokAt3mzM4=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 2 Mar 2024 09:15:20 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/input/misc/iqs269a.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
index cd14ff9f57cf..1379f80c00e2 100644
=2D-- a/drivers/input/misc/iqs269a.c
+++ b/drivers/input/misc/iqs269a.c
@@ -744,8 +744,7 @@ static int iqs269_parse_chan(struct iqs269_private *iq=
s269,
 				dev_err(&client->dev,
 					"Invalid channel %u threshold: %u\n",
 					reg, val);
-				fwnode_handle_put(ev_node);
-				return -EINVAL;
+				goto put_fwnode;
 			}

 			ch_reg->thresh[iqs269_events[i].th_offs] =3D val;
@@ -758,8 +757,7 @@ static int iqs269_parse_chan(struct iqs269_private *iq=
s269,
 				dev_err(&client->dev,
 					"Invalid channel %u hysteresis: %u\n",
 					reg, val);
-				fwnode_handle_put(ev_node);
-				return -EINVAL;
+				goto put_fwnode;
 			}

 			if (i =3D=3D IQS269_EVENT_DEEP_DN ||
@@ -805,6 +803,10 @@ static int iqs269_parse_chan(struct iqs269_private *i=
qs269,
 	}

 	return 0;
+
+put_fwnode:
+	fwnode_handle_put(ev_node);
+	return -EINVAL;
 }

 static int iqs269_parse_prop(struct iqs269_private *iqs269)
=2D-
2.44.0


