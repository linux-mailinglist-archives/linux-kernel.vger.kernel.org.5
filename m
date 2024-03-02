Return-Path: <linux-kernel+bounces-89433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A186F04A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 12:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59062284DC1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 11:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7CF175AC;
	Sat,  2 Mar 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DPXjRX1d"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25642376;
	Sat,  2 Mar 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709379756; cv=none; b=A1Ih5EXtV+5oCBT2Utt9nQDmJopnVKh4R5BWW40WxOvKihgV+j3IwXr22B8o1BlmVQiiadqXgLOmeCAuIZRI8X1I+VmHjsZ7aM6rmuenBX/k6o88XLjE7DP6/G4Ns64iMp3sSJJNXZwGZFLBq3GI6zdRvtqajfhW3mCwO2klkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709379756; c=relaxed/simple;
	bh=E3Q9qWL8O0+GN7VCd1Dl19Fyi0SNZTTCX+IlfgtclCY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=q8EU+MrbzLAF/bux9mi22Nqx6+kNUwE8Dc/8ivstopf9SkA4yb4jp0KcJK7eubupm3KtTuxIBXGbgHS1Rrli0ss1pExATY/zqWvHH4ZLAh9EqHzy8MYWBb7I0K8FtpFCsos3MIIJ4lwzSjPt3EBOAzqQ0CciXebiLV9fadKLi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DPXjRX1d; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709379729; x=1709984529; i=markus.elfring@web.de;
	bh=E3Q9qWL8O0+GN7VCd1Dl19Fyi0SNZTTCX+IlfgtclCY=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=DPXjRX1d6w9S6Wi3Yvg/FUZrL14SO1FScXJSOxyDgch1YbvYXMK+Tkwz0voKtzSa
	 XydXNk9qno9veQye0HBtEdDw1EhNudQh2HvHJLA7iSsWeZXzMThBSYcHf4brt4zLY
	 mdwzDp0Y1bB/XG/eCv/nZt3OLvQfcxy6sxYO+IJaQOx4J9BS0EDajim9g+/lMZvBT
	 CeFt9w8yUALALMCVlccluCb9wlfvWrjgFIvXJgQg8CDbPfvhHllFaQ0pkyBRcCIJI
	 jIX1XnYWoWsIWCBDKWysBiHLjD0RFzRjhK4J3rrf9zWJ0JpbnRYS/FCsP9zG2RW+Z
	 Bl6VjOSA9m3uyj/9iA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MActe-1rZpFp2G88-00BXXz; Sat, 02
 Mar 2024 12:42:09 +0100
Message-ID: <8a7607f8-d634-415e-8269-e26dcc0f9fdc@web.de>
Date: Sat, 2 Mar 2024 12:42:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeff LaBundy
 <jeff@labundy.com>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] Input: iqs626a - Use common error handling code in
 iqs626_parse_events()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h9A/1MY03Hlt1owaa+huYDBVzhk7qF1ZdtK174hH1eiFGxapT2y
 Pw/pNtsWPNsatHBRwAxOvnvQXDIFIbs0sVAa1uSBSJSTL10AUeqHlv0e9mJoqgcz0kBHfay
 H48J2/sMmnVgXmXl6ryZH1OlUJBSJpuCfyKZjGYRQ9CpWRgVKvSBXJXIAqoBnn15TMoBHxx
 7Fq2+BvxeC5/aIgp54OLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pmsEEA7ll84=;dN/IpDwWFntwUoLhARGcxU797SD
 Zg1a1k0c7eO4VMzGtV6DrBvjwBqb5YJlqjVVZn0jaEzgtGg3WVKhb1RbLuF7n+xyZYsl8gFny
 1Jay2eQlONetdD+M0SF6SmVZQMj4LRCEMQ4lgOI+idzT9mLy62Rog5h4BoG6vBVD46Nx7Xv+J
 CrQjLq0ktWL6/lLhPNv1REL+H6z/I+XrFJ1Cfm/t2HhK0b97TFBnod97va3t3f4GYw9iHNtxn
 3qRl2VYU6m/K1eO3LtjPN47q2sEmKNOwRdYp5dczOCMNd/Wv7bn6nNQEYwxaduDMVS1oH49Tv
 Z60b7zH7wVtt1rlzMj5uVrTq9mCdGBHnTCqGj8+Z9nwoCsQ7nyXmnWrN1RCY4OjD9yZeja5Cw
 5PXKsTMkqq/Mhu/KpZ8WaH2kSUeoOje7x0j4w5q/FheRuNwe2L9+Z9VB3EJoAn5mXWR9VxUaE
 E23bQsqFtXZG9YUqPCk1HnbiJpioQRB5P8S7mzHcHnXLhEFHlUmwhMX1twxW7DZ0pjWx6W7Vf
 wy2xlLkpA/96MrqT2Bx8JZ8nAQtaQ8D/2HTiK3w1dG0kLaJQudQtD0ea/kAGFkwE28Rnrh/SU
 ImuYUlUBSk+GwypHnP9rAtjsqkF2COh7oZtrHxS7YR1ZbfL6VCIWfRC7llkFne7t0i6hZmouo
 5+Yo0AyO/yHU2ojsqJG+yGnmT00dzLmTgQUg7ZoRygrheL3FF0Zl9wVPtWGGWCbFFYyqKEmua
 GXp37jTM8x3aRTE/gr+v16PdOaGp3ZjVXXsWJPOL87oafeNAHL3aOlLXieoi6BsAKvMGXvaI6
 oez+RcDVLbOJAyDCTtT3Ed5feWOFn19BdTDbWySRDGNoo=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 2 Mar 2024 11:44:17 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/input/misc/iqs626a.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/iqs626a.c b/drivers/input/misc/iqs626a.c
index 0dab54d3a060..fa9570755f7b 100644
=2D-- a/drivers/input/misc/iqs626a.c
+++ b/drivers/input/misc/iqs626a.c
@@ -530,8 +530,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
 					dev_err(&client->dev,
 						"Invalid input type: %u\n",
 						val);
-					fwnode_handle_put(ev_node);
-					return -EINVAL;
+					goto put_fwnode;
 				}

 				iqs626->kp_type[ch_id][i] =3D val;
@@ -545,8 +544,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
 				dev_err(&client->dev,
 					"Invalid %s channel hysteresis: %u\n",
 					fwnode_get_name(ch_node), val);
-				fwnode_handle_put(ev_node);
-				return -EINVAL;
+				goto put_fwnode;
 			}

 			if (i =3D=3D IQS626_EVENT_DEEP_DN ||
@@ -566,8 +564,7 @@ iqs626_parse_events(struct iqs626_private *iqs626,
 				dev_err(&client->dev,
 					"Invalid %s channel threshold: %u\n",
 					fwnode_get_name(ch_node), val);
-				fwnode_handle_put(ev_node);
-				return -EINVAL;
+				goto put_fwnode;
 			}

 			if (ch_id =3D=3D IQS626_CH_HALL)
@@ -580,6 +577,10 @@ iqs626_parse_events(struct iqs626_private *iqs626,
 	}

 	return 0;
+
+put_fwnode:
+	fwnode_handle_put(ev_node);
+	return -EINVAL;
 }

 static noinline_for_stack int
=2D-
2.44.0


