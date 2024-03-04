Return-Path: <linux-kernel+bounces-90362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 433A986FE1E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAD32842A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A47224E0;
	Mon,  4 Mar 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pdDIlOJv"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5322636;
	Mon,  4 Mar 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546166; cv=none; b=DoxA83Zvj/2UWYB88zEFIvSWzzn9AEctPZm0760oU0xuxwHRR4cBQSH3SzYtJYixJkDL9zF0LAgOI/0FnwhRNWfx7+wxu/pv0Aht7Cy+BsIpc+IP1KCS6CIeoTXNOdewHP2cVz3OWawq+ban1+hPnrs8A8pewG7koQ8I052LSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546166; c=relaxed/simple;
	bh=jSfbbkk9CK9YA15plDKrv6U6U/hTy+uv5U2LvfWuUe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POeSQfItq/QxWVm/PxZDDr7o6FFR7hgc1y1jV8BVgXKttJ9nAkLiNXnEAn6tBjHtDBjttqpvDHnf04GgH6vC6l3C4RKw6VfAc0OdGc+aL2L1dGmpV6WT2mMWNCTOhsZuKQk0rCio0ZQum1O4NUFP4kh1VrPtht3Efn8vF3IvqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pdDIlOJv; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709546126; x=1710150926; i=markus.elfring@web.de;
	bh=jSfbbkk9CK9YA15plDKrv6U6U/hTy+uv5U2LvfWuUe4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=pdDIlOJvuvnotqh5K70Ry4Ls/JceTgSbTt1GPGXnwmVNEqnzyuZDPLt4WEAKa/nu
	 SksNrs6ifMgU75g4NfUSKGYzbO3hgw5LJTlx3JVtfFwGZZhgt+g9y39mlve8c8qHz
	 NeHpQ61HFqolkwhiMs/nISUU/5uGZdJaCHTRduDDbXFajl+rvi2Efew1IC+w5re+F
	 pM12jDdmSBf56CX6jOaBSQpEbbgSsv8dIw/TzbEdC9naztLag+DKDGPV9sPHygiI4
	 qFB6pJtge/TNeAfjhGRGIPF3GhLsc3wFvUp6X1zSe1epr5VzxfNOAzN2ugOfCkeec
	 QOjPs/81EpMiHoT4hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ek-1r2oYK036s-00oEyI; Mon, 04
 Mar 2024 10:55:26 +0100
Message-ID: <b5f9c66e-d9c8-4dc6-8ce5-8d1dc5f0782d@web.de>
Date: Mon, 4 Mar 2024 10:55:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] Input: iqs269a - Use scope-based resource management in
 iqs269_parse_chan()
To: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeff LaBundy
 <jeff@labundy.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 ye xingchen <ye.xingchen@zte.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <6bf9f962-cf75-459d-89f4-2546063fc154@web.de>
 <ZeT6UUFNq1ujMW17@google.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZeT6UUFNq1ujMW17@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qkke/HXW4fcpS+uHR6ibXHPFQmgBB8hmITPhKPu+t98AJ6FUAyE
 y3AleKWpPAmbl1YM51DH41xg+dufDZ3BwZVci4msJx+bk2elUt+xCqARh93QQ3cgLDb/KJc
 1ibnQNJc/8Uy6ueutkhwBy08yc2GwxvimWejYrJPgCEQ3cMJHKt8iaJCmpEZXsD0U/n7gz7
 gERj+PKd7tMP+heRxV5lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M3fBihiZ3/M=;6dsTCfsvsglmme9bdNMzy5cxJBp
 nO3I7HSl6I7Cs72oMggwnpaXoZ9USrn/YicGy5Ghyn74wznYK4XzgjjkdeoKP9EPzw8aRqGc2
 UH6cmMlf4awa85fRZ9LgNSo2w5t4nHhdgwsnkpIG4rZs6BQbt+cCSYiCfDJhdnfmfWBzSfH7K
 QlnagVRADFLoY5Pj1x/Ftvx1WTrE2pdRBHiSF2jcAUaP8BKlIamjWgaVITFoeKIsPAKIzxUK4
 ypn1yy7wfxIYcUotBqJasvq7Avg8aFfpwUaAO1Gs1fxP2zKK/8o5w6xps/ubEgigzEXN/BZA5
 UzkMMJJG2fjkphlzGiyCYGInBdzMtjvOSwuqfGnOS9csvDsjKtlmca4VgUHfqUerLBmTrb4X3
 uyd9yXZP+yd9JzIzINqXK0ob8Zi8mjoTdNbmJyeZVTFY+g1tY9luQq0/Fg6K1ydS3PALvo2fA
 9+VjsSfKSrv7Zz9EXXzHV22swgxvgK9yBXS9Tq110ose9K3BY2sCRnAZVGy8HSndD+tSzjmyS
 XE+9sDhD90JfSorFAWVjHOV/9godxVFC0qYDcTlLsYty5Dr5nPPwF8gLgKGFvcVFOBG2CC0Pn
 18tLE5MfrihpfEdtgcLIfLzNlGaniimTGtiAxZp88gQGxrV3pNDK34aFTbjBqPUfvL69olBlE
 TD8Qo+dvKLoeqjuQV7psU6FebbvpZN9RoRofkoCTD/yq7GoCAH7n32MwLLK8GUFxZ9Alh8hQu
 TNoFodgLg4wDDPZusgIziFzA1JIhK6GxE4KlZjmKGtCodjRs1t1A8y6ALDL8DqtZR+Eh5tJoz
 GP1+8gVnao6bo31EB2ie3g+VqZU8cvZDwA1OJtaTkjVDQ=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 4 Mar 2024 10:30:52 +0100

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
An other cleanup technique was applied as requested by Dmitry Torokhov.


 drivers/input/misc/iqs269a.c | 73 ++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
index cd14ff9f57cf..9caee936927b 100644
=2D-- a/drivers/input/misc/iqs269a.c
+++ b/drivers/input/misc/iqs269a.c
@@ -557,7 +557,6 @@ static int iqs269_parse_chan(struct iqs269_private *iq=
s269,
 			     const struct fwnode_handle *ch_node)
 {
 	struct i2c_client *client =3D iqs269->client;
-	struct fwnode_handle *ev_node;
 	struct iqs269_ch_reg *ch_reg;
 	u16 engine_a, engine_b;
 	unsigned int reg, val;
@@ -734,47 +733,49 @@ static int iqs269_parse_chan(struct iqs269_private *=
iqs269,
 	}

 	for (i =3D 0; i < ARRAY_SIZE(iqs269_events); i++) {
-		ev_node =3D fwnode_get_named_child_node(ch_node,
-						      iqs269_events[i].name);
-		if (!ev_node)
-			continue;
-
-		if (!fwnode_property_read_u32(ev_node, "azoteq,thresh", &val)) {
-			if (val > IQS269_CHx_THRESH_MAX) {
-				dev_err(&client->dev,
-					"Invalid channel %u threshold: %u\n",
-					reg, val);
-				fwnode_handle_put(ev_node);
-				return -EINVAL;
+		{
+			struct fwnode_handle *ev_node __free(fwnode_handle)
+						      =3D fwnode_get_named_child_node(ch_node,
+										    iqs269_events[i].name);
+
+			if (!ev_node)
+				continue;
+
+			if (!fwnode_property_read_u32(ev_node, "azoteq,thresh", &val)) {
+				if (val > IQS269_CHx_THRESH_MAX) {
+					dev_err(&client->dev,
+						"Invalid channel %u threshold: %u\n",
+						reg, val);
+					return -EINVAL;
+				}
+
+				ch_reg->thresh[iqs269_events[i].th_offs] =3D val;
 			}

-			ch_reg->thresh[iqs269_events[i].th_offs] =3D val;
-		}
-
-		if (!fwnode_property_read_u32(ev_node, "azoteq,hyst", &val)) {
-			u8 *hyst =3D &ch_reg->hyst;
-
-			if (val > IQS269_CHx_HYST_MAX) {
-				dev_err(&client->dev,
-					"Invalid channel %u hysteresis: %u\n",
-					reg, val);
-				fwnode_handle_put(ev_node);
-				return -EINVAL;
+			if (!fwnode_property_read_u32(ev_node, "azoteq,hyst", &val)) {
+				u8 *hyst =3D &ch_reg->hyst;
+
+				if (val > IQS269_CHx_HYST_MAX) {
+					dev_err(&client->dev,
+						"Invalid channel %u hysteresis: %u\n",
+						reg, val);
+					return -EINVAL;
+				}
+
+				if (i =3D=3D IQS269_EVENT_DEEP_DN ||
+				    i =3D=3D IQS269_EVENT_DEEP_UP) {
+					*hyst &=3D ~IQS269_CHx_HYST_DEEP_MASK;
+					*hyst |=3D (val << IQS269_CHx_HYST_DEEP_SHIFT);
+				} else if (i =3D=3D IQS269_EVENT_TOUCH_DN ||
+					   i =3D=3D IQS269_EVENT_TOUCH_UP) {
+					*hyst &=3D ~IQS269_CHx_HYST_TOUCH_MASK;
+					*hyst |=3D val;
+				}
 			}

-			if (i =3D=3D IQS269_EVENT_DEEP_DN ||
-			    i =3D=3D IQS269_EVENT_DEEP_UP) {
-				*hyst &=3D ~IQS269_CHx_HYST_DEEP_MASK;
-				*hyst |=3D (val << IQS269_CHx_HYST_DEEP_SHIFT);
-			} else if (i =3D=3D IQS269_EVENT_TOUCH_DN ||
-				   i =3D=3D IQS269_EVENT_TOUCH_UP) {
-				*hyst &=3D ~IQS269_CHx_HYST_TOUCH_MASK;
-				*hyst |=3D val;
-			}
+			error =3D fwnode_property_read_u32(ev_node, "linux,code", &val);
 		}

-		error =3D fwnode_property_read_u32(ev_node, "linux,code", &val);
-		fwnode_handle_put(ev_node);
 		if (error =3D=3D -EINVAL) {
 			continue;
 		} else if (error) {
=2D-
2.44.0


