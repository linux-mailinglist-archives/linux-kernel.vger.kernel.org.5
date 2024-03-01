Return-Path: <linux-kernel+bounces-88387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408B586E0E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5BB7B24310
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD576E5EB;
	Fri,  1 Mar 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="n3l4oFTv"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681FE6D1C8;
	Fri,  1 Mar 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709295027; cv=none; b=Qj2Z+SqVzXnO7OZFHXKiIbXK1GsBDZQ9duz/wbhpZntHWbXOEF7aawv9G/+HfEMs+T9V6cKXON2fec6rRDSeT3meJPVGPT/ktxkRRst1zOIXbbK1keA/bitWX8UxMlTH+TPm51jrMABNrJU3KiCiUGrMkuBWUE6muAw10VnUVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709295027; c=relaxed/simple;
	bh=h8r+c+xKuJfgNjc2uCEc8QP+kKYh711JxeWWh1eRyno=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QLaPByFn3wc/tMgRKIp80FfLzkywSNOHadEA+JFHJxZEDjOSpOa9pMG3F4eIwqiAki7dTOds5fNHTTlnKnKWTUb47rsypYlSI+FZfSTCvVQnaFoXdqgL+kqHv99Wx55aDwIsqtEFPfvlby/MmwIB1ASxtnFezAAJcXvGOXZgqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=n3l4oFTv; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709295017; x=1709899817; i=markus.elfring@web.de;
	bh=h8r+c+xKuJfgNjc2uCEc8QP+kKYh711JxeWWh1eRyno=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=n3l4oFTv4zuiXWliiZvjBJZbFVEooofgg1ZO8VFnph2rxIxDIl3a1PwgUBQjrmMT
	 3CXKHW6FF4b6vyDMnzUlebagfMbWFB1jxG9n4ESARXmVD4C5S1vvHorddyG68e7f0
	 lQYhi6ITZN+s218/gF/ZH194gWzLW3RZfGeiEuwHMpnAySke20j9OOKg4o6tLyPPM
	 NquEwkdm46wXuax9eMfGUuPM/BU96S93UtMW0V5sZo8PDmMk5YedBO+eXwzXrxW6C
	 nt6c4uoCRWZ12c76sAHXggo15J98ZB9xMTCJCHz4raJ9aphV1fTCxk7umrydX7EIJ
	 enaQpavjlDWt6IjlzA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnG2C-1qz1O03hCe-00jGjk; Fri, 01
 Mar 2024 13:10:16 +0100
Message-ID: <8b4203dc-bc0a-4c00-8862-e2d0ed6e346b@web.de>
Date: Fri, 1 Mar 2024 13:10:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] media: rcar-csi2: Use common error handling code in
 rcsi2_parse_dt()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e8Qqigu2HipwdgXe/vRLuYUi8hLo5kQbAiTz9sFlCosswWvxxUW
 4HX41fYAAKfZdNf+WASi8tNE7buVMkC/he+b+KUcDHvvkQqY/z9y76Jb7Qzeyo9q30gYDjA
 9/rYIq4bJT/pg6NXz12dJdcM6sBVfKt5E11ofBT33ffijdD2GKL6ivh3Rb+SN9x5Ialx1k1
 TD+xhBj2gEFEgphdDkDuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UBnMxTdMKLg=;UNsb8OzDk+kpUby0bo5bEnYl2TL
 Nw4xE3IVlD2gtfd9iz32rR9iVDP9wTL72Cno/LKep3Sc1a7lOLYls08djqGUV2EI9pgKAwtoW
 MtjWBIKRApK9d3GA2jjxnyyL41/o8v1P55RlwHJs2CzyZHWiJYIC62fWZQbj5T2YyvsEDZykZ
 RcO/ZgZqrqSlbhjxdQExSqFUeQuz829ILmjxzOEPAAZfv5nfW9CARciS+G+aGjpEdy5ZtGDEN
 7Eu20ZDp0ZhXFwpX3R+N0ylymoLOuhZIO4sfLvmuLLt/gzu5Bc6ebWGOMD7noTgClnKpp6wTz
 smvimXUuQfBm3egJpr/pLIjEmrfL1x8aE4yPy2+RoVjYDkQL3nqXYh83ZQOhn4bxznKqS8hqE
 UreOHhP9Zx4ON8X3yfMdZFQ2Q4jZ4gNf7j5aYRM41qEhLVH6e1QCMdSrr1i+YIBRcwN3tiewS
 zIQ9zjN6BVirtlqJvjBTrjeVbmK0kWa1enFO1cSV3B4hQXLdhBYYVebBuhg8T49e5vYJDdZ9O
 rGj3H5YspFlCd9s311fdaxfoYM00GcG6fbnN/wrmfjDe5BCZ12jf0nWqBtjPuKfN+B+v/hadt
 8ojsjT4DgDw8RIPW76W3CBbVAGJhOyIlUE3lrxUTSgCmD0F8aqLho49n2/kU1rFR66UtdgQ8U
 5tu3i+2OzixOAgKVNKXpZbd9kPnTDExkAEKDtKddptb/c32CoQF7VtwrXzln71ZMQDJPUx+KN
 jT+BmPQrzxkP52XiuQwcL98q4mPU9U3UMfq8c/YeMvyB5QsrtVvNGXuzADJgPDO713Myphypt
 b+/HQFpyV5gyaTdptna/d6DZCDrMuXtjcnDLBspLPEWog=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 1 Mar 2024 13:02:18 +0100

Add a label so that a bit of exception handling can be better reused
in an if branch of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/platform/renesas/rcar-csi2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-csi2.c b/drivers/media/pl=
atform/renesas/rcar-csi2.c
index 582d5e35db0e..621c92c31965 100644
=2D-- a/drivers/media/platform/renesas/rcar-csi2.c
+++ b/drivers/media/platform/renesas/rcar-csi2.c
@@ -1388,12 +1388,13 @@ static int rcsi2_parse_dt(struct rcar_csi2 *priv)
 	ret =3D v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
 	if (ret) {
 		dev_err(priv->dev, "Could not parse v4l2 endpoint\n");
-		fwnode_handle_put(ep);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto put_fwnode_ep;
 	}

 	ret =3D rcsi2_parse_v4l2(priv, &v4l2_ep);
 	if (ret) {
+put_fwnode_ep:
 		fwnode_handle_put(ep);
 		return ret;
 	}
=2D-
2.44.0


