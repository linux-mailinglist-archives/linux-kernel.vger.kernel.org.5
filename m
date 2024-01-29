Return-Path: <linux-kernel+bounces-42936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4BB8408D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A671C247C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3380B152DE8;
	Mon, 29 Jan 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HD4Qi1t7"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4760DEF;
	Mon, 29 Jan 2024 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539379; cv=none; b=kD3yw16mXn2wBS65rFLnFMX1Me6KjHMkX36yt8zexDuVGYqSmXwMjWun2DXq5JCDiP8Dobol4BuQNwKJMNNWUhhgOddC4EqPLx1cuveQzmahYXbQbJLL8slqupIUgVYfKTtXQZOdBtrp/ZkoviK+BNAO5vtgFvFqqcUzTPhqv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539379; c=relaxed/simple;
	bh=++qUoPyfSFKzuZZvQ546dLVeeD7/xqChTmaE0VECfQw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HM0IX6bzjtB42O9hhsdgY8XyeP3IReXs+UZ+zz/7Wpln7H1FgEKQx40IOlihehLVjY+wELJh0QG/sA2SB+esPfL4BGM0eLZTvnzT/CR4QAYKTJYdwRgjJFfjrKJcvRiNuXRI6Ob8gr/afcWpm+CySTsTYvzh+gnnQV6+NU8G5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HD4Qi1t7; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706539355; x=1707144155; i=markus.elfring@web.de;
	bh=++qUoPyfSFKzuZZvQ546dLVeeD7/xqChTmaE0VECfQw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=HD4Qi1t7MQyDoJzZrhOAzd0xI2XWlx7WVmWrIFndluH86ZU8FTCh85utlu/SRtCu
	 /A9E7YKJF4McMouZ8MYGroopBuqOw1WqJv1jdaUWnd12qSHFXvTcFp2kwH/pBmZzq
	 elXbaHBfukHK3a2QoVIoF1CPJBKOsPtZzDGG//oHb4c6TdxiMyxnHKEZsFdP+PDxi
	 QqcKvLiDN6/P5DpK+IFTR587phFlWTU0q8gfcr4v8XMRJkwoRW65QamIzkSP1LY0Q
	 j8MFHY+lWmnnI63tzNfEAaCw14C0kW7xMe2XSUdBFxoQH/J30b+pGpqVHRZ5/lYcZ
	 KC1UtRZJH3W3Rley+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3V6G-1rTusT3B7y-000k58; Mon, 29
 Jan 2024 15:42:35 +0100
Message-ID: <2541ed5c-2afe-4cd4-861c-53aad2c355ea@web.de>
Date: Mon, 29 Jan 2024 15:42:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] misc: fastrpc: Use memdup_user() rather than duplicating
 its implementation
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Amol Maheshwari <amahesh@qti.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Cong Liu <liucong2@kylinos.cn>,
 Kunwu Chan <chentao@kylinos.cn>
References: <e5d9404d-eb3b-4d35-a027-790229986cdf@web.de>
In-Reply-To: <e5d9404d-eb3b-4d35-a027-790229986cdf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r9VMldPJx3OLpWHDPHCTbM5jKIquc7JqOrnd3z0oDELwDTPp6JW
 RFWOx7Eas9Q44RgCgaftbxhjQQ30jnxz+c0kI/LCkp/2TCHCWn6HcI6pbC0Bn/TgnOp8j2i
 JsYjFJmCTJ77FygbPhLbZ32UZ4ldmA5mehojAUT+hBSLwHmVFwa+CHL+bNg4wsVX0/tkUWl
 qeG+qAYSBo0FqKSk8it8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mAP1zM/zOi0=;qcNnELy4j9lhIMdz0d55zCw3xej
 Irt4KrlFHMCYTr+AttHLh/kIo08/PXlxadMy20PvLkqBBGSIDNuLdnRQR/bujlrKVpgViLkpi
 bZMhcN00fZTpN1/v1e2D9Yrlf8wgESgFLSejRVnptLH1P3qikOk2gOlDN5UxmQR4k3FnGiiHA
 +erVyq3+IIAGLcevHFYGNrIMOSG9MRpaFYi41lJTbAyCXFYNVpwP2gYNYUn/5EhbE+tvFZrip
 pbxltq61BRYrmgDQ2BWIr29BbvlSNVCF4WrSsqOlicNbCCEKuKGPzzqdV2W8Kiznbv59fROEG
 OKYaYUOL6oWQ8y78ova8EGJxv2CFTbmORP0k2J+CzZAiEUBFA5rlSDX8t+SmDR6MyODK2RKDS
 9NvXEiXqQ6AbAUwEaliMDpZ3d27De8w/o9mNDBoC5eI4uncVNeOD8Q/b1QMVo+vvRlWVJF3Bn
 w6K7HRa+t2KZ5uSBPLqaKYk37zJF5SKQu95GxnYStb0avw4BjdGdOqnIdzmPQnkC8pzIfkWsS
 IAd5sv/xH8bxJk2FBdlpTDCXsCU8XCEHqW9T5xPRR+JGvAKqTQc5QYqzHnXZctM/Qz874xhvn
 kEfsvRjfek/gmmARGEzlZh8q+gg6ZOzPXPa59txXuKDybfV5t4wApOrxoXE7oNb3h176O0sBd
 HFRGIKorLPGcLuv8Y8UsunyZo3eVctJr0uzcbcwJGX7vh5Sii3en+8ePFUDoxdb7Q4TlA0cCG
 IpaLc+MTgJDpxRViiCVraPf6aesdvDR+t2vMHzzLnbEYVJ5yPHd4KKS866MDp0BbeFHg1XLu7
 CWX0BErtnxcjtL8t8I01elrDlEDwqZfOXRwNAvGYezRo7t8o3x7NRk3Lz66bHGfYys2wceehN
 wWijfthjw94iRL7HbJ5hJEknlMOJYyG+hwP+d8AObRRQbpync0qqX/gNVEvM2YnbCB1fqIrfG
 hArPBw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 29 Jan 2024 15:33:41 +0100

* Reuse existing functionality from memdup_user() instead of keeping
  duplicate source code.

  Generated by: scripts/coccinelle/api/memdup_user.cocci

* Adjust a data type conversion for a function call parameter.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
A data type conversion should still be applied for one function call param=
eter.

 drivers/misc/fastrpc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1c6c62a7f7f5..3b18c339d091 100644
=2D-- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1260,17 +1260,12 @@ static int fastrpc_init_create_static_process(stru=
ct fastrpc_user *fl,
 		goto err;
 	}

-	name =3D kzalloc(init.namelen, GFP_KERNEL);
-	if (!name) {
-		err =3D -ENOMEM;
+	name =3D memdup_user(u64_to_user_ptr(init.name), init.namelen);
+	if (IS_ERR(name) {
+		err =3D PTR_ERR(name);
 		goto err;
 	}

-	if (copy_from_user(name, (void __user *)(uintptr_t)init.name, init.namel=
en)) {
-		err =3D -EFAULT;
-		goto err_name;
-	}
-
 	if (!fl->cctx->remote_heap) {
 		err =3D fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
 						&fl->cctx->remote_heap);
=2D-
2.43.0


