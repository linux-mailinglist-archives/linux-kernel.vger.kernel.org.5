Return-Path: <linux-kernel+bounces-51134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43A78486EA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77781C21612
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024725FBAB;
	Sat,  3 Feb 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="lrmSx367"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF855FB95;
	Sat,  3 Feb 2024 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972284; cv=none; b=oUYUhS982hE2GRbFQM760hAeMkFnEEuI5ttFEUTh1rxc9fG5qj/3fzodT2MZ+fKVxxn+Ewh1j+GvDNXGPS0u8bmcM4oGdwFQ0N1LXVlpek7TgkAk3qIic5x91UI2tmIlWiZW3IBPMpYYCaRHtSFwbu1iAAt5jT/tinu4PUc1UbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972284; c=relaxed/simple;
	bh=zVJN/4oHdWhuzz1+BiygMaV1vFRfNwCcrWxJLFyYdCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cSUR+NwbqorM/Ug4zSsTTn2eWeCrYVyqC8pO2f1ptL+6+ZPIPnsXoV1S7RzvvSgx5KFiDEEjZId3cb7jmLdeOyFsRp/q7wetZ2235A43KmWi6y1sV2HiSsBsIxX39+S/CFxJJJ8rtbXt19Ol1eWYYoRbAhhJBSS3n+WII5JR2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=lrmSx367 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59a58ef4a04so1615752eaf.2;
        Sat, 03 Feb 2024 06:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706972282; x=1707577082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EoZhzCvvxVDQhcFrFWhYjcTT9FE0yDllqaUNaTBUtCY=;
        b=kcbj6vOz8aUH2mx68Yoc/1iVBb8c7dMNoqolpMfbvK/WfRf0+w+YMGnazpvuZ7nsn3
         nOW+6ygrlcOKmSF3a23SA5/EJnxJqpiomQYQM+Yz6beOEEvvKuK29TvpU7yo+pDUR0wc
         KkhMXJPfe3Qpz5JO+PX3BeltwY5D9aA2M5mi1X9qocYTRU6r8XMrDE+96CIv5MUqwHgS
         5zLXudKV9YQsmcl6eRGf4lYimOMbzcT5NenVH43Mo5reeTj0XJpjr2iV5qCNAJeGhwMJ
         n1jCf8R0lYWwJE7Wxh0JLUVoEjRYtktBqpf7L6PdMN7ZQ0Dw7d9OMoiav+3+gu43XEnA
         DbAA==
X-Gm-Message-State: AOJu0Yxa8rL0MzzdbDOlfK/ICkaDGwGnfO/ktz2rGEhVpzAd5oin21jL
	MCsIUNB1dJgXfCc8Fz4MAIBDKtjReFbH/VUyCgJy9vuzeGzoJ/DpqrmeWfy2QN1EFQ==
X-Google-Smtp-Source: AGHT+IGolQcaZoOhAaigwDOhfZduwQhHbm8m39V5N9qPdHbKmrByQ/U6UyZ71UaPZUfYhKt7DqoeaA==
X-Received: by 2002:a05:6358:4195:b0:176:4ac9:5509 with SMTP id w21-20020a056358419500b001764ac95509mr5751592rwc.13.1706972281635;
        Sat, 03 Feb 2024 06:58:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXZb0P2zPtnL+GZJ9/f0OOblCsIboCZ4Q6H/8BfLAcjNoHjckTHVSFl5FfRApQxZc19XaWVzNODxctlMTI1GaCQExdEFBsZpDlHqmKrlqYVq0ng5jtZgOAn43KDZurRgpyKFruhpzNQRHc2djtKkJTr2EqylTgbYjceZiXmBTd1CnAJM9CNKFRV077t59HLz9iVmB/pVTK8WHTIwScbf4OA4RECa7DZ75Zg1HlthOGddX3ai5Vn4+1NgplbVD+kd4F0JJarzsu157VePO1senMd3lV//Y5KES7wiCkhbjpGaHjlp7IrsGxo8hLTkNYnNsZ6yiesHPYd/kLdt5lZkPcSyHtTl6pRss0LBNtu7Ub45DHjcC0boipBGl+zBdh7j3wIzLSQzVRpoac3blLJUVsB2OZaYn0kg1opoBB/ApsFlbhukdkhi4E=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78110000000b006dd84763ce3sm3489047pfi.169.2024.02.03.06.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:58:01 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706972280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EoZhzCvvxVDQhcFrFWhYjcTT9FE0yDllqaUNaTBUtCY=;
	b=lrmSx367erV5VvtWn6dQBwmKTQrkZFuZJxLN1lJx9sl2Aayl88w4LVeMQjpDrQsMG9wHVJ
	qifkLRQTrT9+FHWXXi9OKTEdcE8UanisUg/jIp9Fzm/foeet8G0g//sC75Zdte1jXVGp91
	HFK4XIwIHrrs3Er/d1ZS1rjT0psaNAm/yLpbZfon7858SUD/l6Mutr/xk24qgFmcnk44/L
	ffl2RdCD2wbWHcI+UdbBMZ2fZrwKMUwpdUpUcklwGzrmxfwxT8XpmoTs5rGPu8REwCZc2B
	gEjundXNTpuCJx89vAEqYcLKGBR0es1IFAyKpDorNDqCC1NVooZqKw0Xy4JAag==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 11:58:03 -0300
Subject: [PATCH 6/6] s390: vfio-ap: make matrix_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-s390-v1-6-ac891afc7282@marliere.net>
References: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
In-Reply-To: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
To: Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=zVJN/4oHdWhuzz1+BiygMaV1vFRfNwCcrWxJLFyYdCk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvlSBVU4dVPwR7qDD3b3GsqypoBcNDlFatTQP/
 HNx1U1Vrd+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb5UgQAKCRDJC4p8Y4ZY
 ps9yD/91LPanJxDOZZp2FyW7DsA1PB1sUZPd0BXEBDLPI3DWWEMgCyrVc6y3iZ+ANd+q2oINvQS
 Bj30Drmz/3rxlBEA/f1hWh24vd9hMG8IZJo6QLxG4jvalJ8SosGtbKSk79oQFwDW4W2Lw2ppec/
 F7MzM+b00XDJ6M9Be2mEwmiJu75oyH4zbTBlWmQshx1EMLnRkr3D8mLBg9NM1k4Lt7bxc5fiNsE
 yVWqVnp6M7Llbb5FM4/xAn+3io/qjvkDLe+h8vcRTY4c56cgVRu3556vAAUl+FN71zZAOsh5IBF
 NY44GJ6+acSA1RdQvJFkBZJT9CoPxsKcRbySZ/qqyhLKaBR2Z014dhUvoLRIbr13e4ZZ+Fbhp3R
 TK8cl++eIejXeqmHVPbxvr7Cv5iQAH7wjZoHjS8LKmWBvsaghISHIJAeAH0zswC3VYNStufgGif
 fcrGGZDkmDCyvdzFHIxYgKgSRlvebfVHq9yJabXhmIXO35Khg+/ISr1dsTEBIYByGBYEvBaaUep
 ch296TvFzX1gZ1S0Jdx/HF91bB/WQuxttKGfhUPPw16769goXAxjPuiIHe5+/Lvtlei5Et2Ji2M
 JW2RTjTGIpy+ZyD6W+d+H4Fz4r/XIZeLZunrCLbRKI03rotmmBqAzcSeyb3DIf9AqNoAHJsKFAZ
 Su/WtB2jQNwAzRA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the matrix_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/crypto/vfio_ap_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index a5ab03e42ff1..4aeb3e1213c7 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -60,7 +60,7 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
 	kfree(matrix_dev);
 }
 
-static struct bus_type matrix_bus = {
+static const struct bus_type matrix_bus = {
 	.name = "matrix",
 };
 

-- 
2.43.0


