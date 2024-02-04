Return-Path: <linux-kernel+bounces-51876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17305849053
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD2BB21D10
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB182561C;
	Sun,  4 Feb 2024 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="svtFoUML"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DA2555B
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707078325; cv=none; b=VCchTsH3U1WyeuWs/TCkyyiwQthshx9I2dPpHMdAAphg/28nN2A83OaNmWk0oNIygLZUKt4xldc6vvvsBVVCLPOyEv932ZUZYRl5umeDixCAfILYgYzj+nUIf2tRdNj+xjrBcz5qlLa3fPiXTWTztuQDg+RyjzBsog6y5+7Q2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707078325; c=relaxed/simple;
	bh=RYLbDWm0uaUPeD4FN0DDzn2bsu2FRM0y0X7bHo+IfIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jfc79OfZqvCfuKBVV1KRT7rOCvpxMRqehIXNzG8ONexs7wtSwRYm2K8iuYl6W0E9pJUKs9oSfaAY7OGz8xdRuc/KyR6uP8iimN0BatM59rxNA957d63jCdz2xUVHz8h3J4/CZWkleptwlnueFebNMzqZSAOqqag1vZXSAxyVsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=svtFoUML reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-296a02b7104so114952a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707078323; x=1707683123;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HVWp3c2p28iozrjDEr3UrWLraJ8M244Iggf4/P5uAM=;
        b=NIeQVoNGjhuLrPSkh0wrHmBrEsmsHaxORrDxBS/y8QUQh/sLgQKEfQxM/Q40wBZHmZ
         BPaStuO/7FwyqWJt0zI8dtsyhKqefbWcCcUzve3gg1g3qD6R3rFJ9+g6Fu+WzY++P/Qb
         ExnarxOYvugz7dV7HQ2FkkgcqILutUPh0/ru+7jwaW1O9CJAXOG0HCs3b1G/3yzK32Z+
         cBGWR3R7wP2WTJ78hM9eRPnNsjCpDmyyawTxxNqr4SSGkeqcc6uLe2f367XQ3KQb2S87
         NVhbsdEM7iS/haqP3H9+rfKMt4jb35rJFJF7tlfndioX/7rRvWY8GDP53prI+NfHfBi+
         uGGA==
X-Gm-Message-State: AOJu0YzCbwrHCqwspmSWEgM8/oE5+/kL029QVsMBo8ABapISfxhralvs
	YwznzEJ3RxFrart1oQxp2re/3ZL9LREkFMA99qGux7jRX61MqDz9XRe6/AlihNqyAw==
X-Google-Smtp-Source: AGHT+IFg9xJyvN9ua4DtF3uA8fNYKcwDTvg4DSLOCgWIvNXn1kc6LQlfABeQOqDN7L2/CScvZpxeww==
X-Received: by 2002:a17:90b:224e:b0:296:a464:ee3b with SMTP id hk14-20020a17090b224e00b00296a464ee3bmr124003pjb.30.1707078323156;
        Sun, 04 Feb 2024 12:25:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDodRHhpejXeE+59cCH4HZgYy7tn940QBj6YA+5KP3ypOGrukjhfOSbo5UxsBBx6q4faI/5TsbOr7QBqqwOfBLI6HM+ncBV2Ywrw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ga6-20020a17090b038600b0029659674bbesm3646965pjb.43.2024.02.04.12.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:25:22 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707078320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8HVWp3c2p28iozrjDEr3UrWLraJ8M244Iggf4/P5uAM=;
	b=svtFoUMLYDCoDmhja19sdH5p+LM+Kudg5Nr3170s2Fpgf1ZmqBSj1vnGpdWXLWH6ck/5xe
	cgdxFXNHUFFMO/eQhnB+1dK2yqx9ISM+42gJ6X3H/CqXYm/wG9gRphFk6kyxI8MPpcdxq2
	WV0TRZR2MDDH8+OUPCp+dmZS3Yb5fOGsmJPthLfqAFnMo36n5osolB6H8EClKuALrhGr+J
	RNKlUHJNOjaAYGPjvsNPiDQOENPd9BEYs+ouRUtSB0Ct/RYy15Tjjvr88T57jh9sDmX8Ws
	ctt3DAPeguWF2fSTZ3ENxF4X0i3v2z2qOeBsI7Dl1PLGQaJ71hGH3c1qlC+zKg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:25:51 -0300
Subject: [PATCH] parport: make parport_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-parport-v1-1-e6a0f756bbb8@marliere.net>
X-B4-Tracking: v=1; b=H4sIAM7yv2UC/x3MTQqAIBBA4avErBPUpL+rRITVVANhMmYE0d2Tl
 t/ivQcCMmGANnuA8aJAh0tQeQbTZt2KguZk0FIbqaURYwzDtKN10Qtv2R98CitViVWhmrlWkEr
 PuND9X7v+fT+wK2LmZQAAAA==
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=RYLbDWm0uaUPeD4FN0DDzn2bsu2FRM0y0X7bHo+IfIg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/LPlkzIn6j0jm8HoHS3F+F8Yc7t8L+JSz1EH
 w/Z+UB+CX6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/yzwAKCRDJC4p8Y4ZY
 prZuEACqEqos6ELywPpfLbDliN6YeBDSBgRdZjw2JRZqymM0aYZLvg6Fc5MuB4YoFFOXTkFvt+a
 BqyyALNE260xpwEl0gPJVvDy6/PvW7IrzEaLa2fsLFMoUTG3/wtwwrY8P/e8zc1ALpZM3OIJJLS
 vJHGvgoeBlspANhbCLM60NUedWuXHwTN/BPNAm6p5IcHKHOlNWJF3WY/x0AKkJ91n2wrfQ+dAtr
 C2DG2FwIqLiU/BMlx7TjmuvRiUQucBU0AD1m1M3BKnsxMMD0WeQiU3gSO4TdYRA4TZN/fQD3Fv/
 1mFo9IzZ7mNCoJJFzKgHmYqJ4aPPgIE/uOdhMM+vpaisxkcYVvOSLqv/Cmt5PGz8LOmrHwNmsU6
 o1TqeFdnBdNj/GGlGnJMw6AB9WoxA0aNjSync8Y+XBiBh/NOm0KAlQ5xyZMKmZEkbTuLWWi7IA7
 oinj9/or12ulLi+kHNMCoIPq3gqu8EseEQVAmBc5htKYSCAzF2s/wnlzjJR9LuWBEbSVFbN2wex
 d8qLi9MUUjyO3Jrw8d+WcCbE5Fqyy61Qroqfz/REaiCb40kVs//dFYysElQOZhMB3EU1hwu9LiC
 zd1PB3aWXlaRtfOlZeIl8p2ctO+Ia1YhPndxdFgDc+1diGNtvXLKqWytSPbYxiM5FVxy6Sx4rgn
 OQLujiW09SuniPQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the parport_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/parport/share.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 49c74ded8a53..08dfa74be3c5 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -130,7 +130,7 @@ static int parport_probe(struct device *dev)
 	return drv->probe(to_pardevice(dev));
 }
 
-static struct bus_type parport_bus_type = {
+static const struct bus_type parport_bus_type = {
 	.name = "parport",
 	.probe = parport_probe,
 };

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-parport-a016e7319d81

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


