Return-Path: <linux-kernel+bounces-90462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A25286FF85
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046262827B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADED383AF;
	Mon,  4 Mar 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AT52U+Vm"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03D381C6;
	Mon,  4 Mar 2024 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549570; cv=none; b=e3MM8wmILyXiDWhoNIyrpBBhIhNG3ldWehuAFMMMX7W7u3uPDLXdtUGHyUUdVAw7EMFVvxdKMxbyOWnaOJdnoTmGp4zmdej7zopa1Zaut79TnngEoFK1A+sBHR3dFqEV0zy52mFrMIXF9ID1pZFiI0lDJWdLRzWBS1qq3eqbLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549570; c=relaxed/simple;
	bh=FT2/g61YhYN+8ZCyUZxvx5hkU5J0uv6XGFwiX085tNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbZ1rtmlDwD6nhyRaFw8w/ZcmhQnVNzIjYVlyrMRFpB429/2IGYYsTv0bTii9HQc8ZwzGew2C6u7t4BGRlWPZSa9ZMdDgGeMHZRxMkGf+BiSBVUqZjkdyHG92kiCxrBxdF85MkIO4TlHXNhYFagsnBObGz0U3C/tihs57rvbnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AT52U+Vm; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709549544; x=1710154344; i=markus.elfring@web.de;
	bh=FT2/g61YhYN+8ZCyUZxvx5hkU5J0uv6XGFwiX085tNo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=AT52U+VmbJ70qVSrTjH+H0GvoqMl/7CcJIJ1vRPal+w7SxosWGmJM5kPW928O+bx
	 OPQkeT0bJAMoeQKo4FoR1zznIfFeKJNWJobdHsDEOcdb2Rj/MXr6af564oJT8niwR
	 xSp6u2UyKOtql/sNJ7HadZYgapeH0FoIEVPYjgkxoUdSuHGJ6s0Q5s9GtMexNRAev
	 SDmABUlJyFFdLdy5s7wmdKURIb4YkhN5jBEUshdk6AWgamUQe3yK62IzRdgBIEOX/
	 iagL/BaIC+Rl5hQQ7WGLVDeEsOrZJ/mrBhtrEsFsFEE4w+AizBNF4lCscFwBd/k8p
	 IEGUB67rnDkDyXBgvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLifk-1rPZ2u0Vqi-00HlzH; Mon, 04
 Mar 2024 11:52:24 +0100
Message-ID: <e8a2b63f-4f9a-463b-b419-c5f673191111@web.de>
Date: Mon, 4 Mar 2024 11:52:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] Input: iqs626a - Use scope-based resource management in
 iqs626_parse_events()
Content-Language: en-GB
To: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeff LaBundy
 <jeff@labundy.com>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <8a7607f8-d634-415e-8269-e26dcc0f9fdc@web.de>
 <ZeU8ENmnPj3sKxAv@nixie71> <ZeVOPSt0L1D4BxuZ@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZeVOPSt0L1D4BxuZ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m7izMg7zQ3ujiwr/T4i1wuTtnimufvqygV+noYdyXIzz4uyU3Ux
 L835cGjttLcO9bgCu1XscCxc7HNEGmmIePrURFSlhdSpiAhmRKtLX3101jD1uJL5NPf07Qv
 adLg5KRP3ZvuVThOqJTZ1afINl5vL/xZby4A7aLjz3jerbu7aZHzM4j8ZVYX6CJqtUichfT
 x+TtclgWq9zv5jIh/Tm7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gKrgivznJd8=;bk83A06BJZnGktz9KrO1i65bIn2
 vcC/jQ+uRpGC7zokuV1sDwtqbBamNXzy2PzmncSdTmgurqMJ0wkBiJd/G6O0HNTpZqMOpBMn2
 1EgPeSZEYkSkLLDsHJCZqE5sW1Fs3e3EQlYtM37YCUOLGQ3KT9TLR9BzTGHakZgywyFzL68zB
 oYFQbMDrySTlCCQcaW0jwbXXKQn5Vct4Gw22feSECIn/ARfdbhpzze3YH6aXxB54qHEPyyJhP
 v/QDMHcZFDKnalVCsbNjY5Oro/NlyMReBe4ZA/qj4YjptQYlD53+m77gMhH8qKF1I2VCaFoDB
 wtTcRSaYOBIl2KwOVSrlB6W2lLr/vMzQzWQzIdlLf1EXwibCOWT9gaN20D90fSkbE8bd3We+V
 8UrOCIPQISzHaGozIC3pKJ6qlqJaRQp/6cBcy0rK2GWh/xQbP6odMQZ1eVVmnq2UsccS/Bye0
 zo707EsyjSorUCM64znysq2GSgaHdcYTaPhCpk4KhI5X2xMWuHZ+tne9aY2sz2Udjt24zGn+0
 iRnYnQXFGjfSkq8GWreoww6v/go+lfxMF9/ZbUK2dPa6++T5AiBXzlAUXS1NlEXd2Yx/l4Pd6
 dX1h9Iep1QZnMCDSA6lwpzkuDEHBk0VmGVffJEyvJ3KBpFahiai0bRacz1faG2m7IB+/0RQIr
 mFNjebGigpNaNc4xgxF8KUdULFEr5uWyKVpEfM/FjldJa16rzmZIFTCAZsjBcZ1Qkhim92EUo
 s4yASKjQ/z9amhHbctD+Ljk/Z0Kg3Z1ID3sd8asM//hfvENAcdAGvfMKmoUO+MLDH1iVgLIQw
 DuvLQFK1X55UHR2D+y2L3efP8h8qKOuf2Ngh/c2g9Fo94=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 4 Mar 2024 11:40:04 +0100

Scope-based resource management became supported also for this software
area by contributions of Jonathan Cameron on 2024-02-17.

device property: Add cleanup.h based fwnode_handle_put() scope based clean=
up.
https://lore.kernel.org/r/20240217164249.921878-3-jic23@kernel.org


* Thus use the attribute =E2=80=9C__free(fwnode_handle)=E2=80=9D.

* Reduce the scope for the local variable =E2=80=9Cev_node=E2=80=9D into a=
 for loop.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
An other cleanup technique was applied as requested by Dmitry Torokhov
and Jeff LaBundy.


 drivers/input/misc/iqs626a.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/iqs626a.c b/drivers/input/misc/iqs626a.c
index 0dab54d3a060..86fcb5134f45 100644
=2D-- a/drivers/input/misc/iqs626a.c
+++ b/drivers/input/misc/iqs626a.c
@@ -462,7 +462,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
 {
 	struct iqs626_sys_reg *sys_reg =3D &iqs626->sys_reg;
 	struct i2c_client *client =3D iqs626->client;
-	struct fwnode_handle *ev_node;
 	const char *ev_name;
 	u8 *thresh, *hyst;
 	unsigned int val;
@@ -501,6 +500,8 @@ iqs626_parse_events(struct iqs626_private *iqs626,
 		if (!iqs626_channels[ch_id].events[i])
 			continue;

+		struct fwnode_handle *ev_node __free(fwnode_handle);
+
 		if (ch_id =3D=3D IQS626_CH_TP_2 || ch_id =3D=3D IQS626_CH_TP_3) {
 			/*
 			 * Trackpad touch events are simply described under the
@@ -530,7 +531,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
 					dev_err(&client->dev,
 						"Invalid input type: %u\n",
 						val);
-					fwnode_handle_put(ev_node);
 					return -EINVAL;
 				}

@@ -545,7 +545,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
 				dev_err(&client->dev,
 					"Invalid %s channel hysteresis: %u\n",
 					fwnode_get_name(ch_node), val);
-				fwnode_handle_put(ev_node);
 				return -EINVAL;
 			}

@@ -566,7 +565,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
 				dev_err(&client->dev,
 					"Invalid %s channel threshold: %u\n",
 					fwnode_get_name(ch_node), val);
-				fwnode_handle_put(ev_node);
 				return -EINVAL;
 			}

@@ -575,8 +573,6 @@ iqs626_parse_events(struct iqs626_private *iqs626,
 			else
 				*(thresh + iqs626_events[i].th_offs) =3D val;
 		}
-
-		fwnode_handle_put(ev_node);
 	}

 	return 0;
=2D-
2.44.0


