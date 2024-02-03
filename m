Return-Path: <linux-kernel+bounces-51130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 648E88486E2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B14B26810
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D3A5F56E;
	Sat,  3 Feb 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="INjUJtz8"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813465F553;
	Sat,  3 Feb 2024 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972271; cv=none; b=W7NdYurPVB/QT3LyHVxOCxhlpfNQMY9uIhpHag+9FatDtN6fsRtCnaf0JILRi5TygXqFSqNRDgRpxmrfMz7N/IiiHweMrjuSELoNdDRyjM7PpbGeEgiRfSyqL0kSEIhaqTNLRzqe1FGL+u4AWrO7E38wUFHqP+nwAPmd7Jo1vWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972271; c=relaxed/simple;
	bh=N6FUHZVz7nICU9v02WHrAmRqKZqNMR8e/cf9i/r7ubY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OITBQjNNZfzoJomexlacC+LucTqSkUIRcgQR2zkYEtG9KEnU6+xM9U+crc3hqi4eIhJ3MqTwjRaHrSzzFVvFCCXvmzZrUcg21jp8kMIexnHzr1XlEb1QRkriE2n9QesDzWIYcGit6o5z1guahbXsLQRWtPbY1zNmFoLDyftGm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=INjUJtz8 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8df2edd29so2430441a12.2;
        Sat, 03 Feb 2024 06:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706972269; x=1707577069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVvoN0wXfCgYng52T3ebQoQAp0KpMeD8Gkb2umjpO9Y=;
        b=OhbffOEkZTreT1mgnmLZbBr2cDdHw5kQdTmLftwkzjHU8qNf3LpHLbNJgwH+pRap+R
         EYT6p3+U1ZMfm8sr3pZmZFH88VvbJQO0/E72ColMMKrV+pNA2302QCtPIorAQkdFdcUp
         aAV5t2QCZFpnyTO21SFSjImGFjRrLGwyE4HRVPgZEyjRQhv5NB/B6ITYTKVnO3jkmYbs
         4Zg+n6EJYDSzxBsEUB8n9PJnbBVrX4Bu2J80/IuP1XzfguAvwcDi8ld0DgR4dKYdGZiF
         99KIGfw3ZsffDeZjUJKarl0t4fLoKCPGR3Yt6RFUC7cUzJovuUtUkSXcGcBMdupwr80z
         O+ZA==
X-Gm-Message-State: AOJu0YwgF0QnKP1f9qdRwluPtBBZnf7Lyux3YG5J3sQpgGoqA4gUx4DM
	LFc6xLGNhdrUHRL6E16/QlIb963B75Q8A7kJtBEM0rPp9kGCaDxg
X-Google-Smtp-Source: AGHT+IEb93RulWl2g3T6Yln5NlnWcRp5M/DcdebJH6KDd+/l0CZRNZQ7M64pwzzk9wBHOSYs9juBig==
X-Received: by 2002:a05:6a20:cb59:b0:19b:125f:66e with SMTP id hd25-20020a056a20cb5900b0019b125f066emr7229393pzb.62.1706972268758;
        Sat, 03 Feb 2024 06:57:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV6Pe17rVITfrIst4h3i4oE2dzkNkWkMoqgGar+km5N7ztG3W/mKCmavoo3yXm8u5wI9+LTD1RpORrpkHC3NDdnLfiANCI+YtpM4OUg+cse/51zcnzGptOlZwBCENpHe1BGSNk+L8FXVsrhsU24Nkacqi7+LTVgf9how1eSo388JLu1sTqYJiizY86nI2LEUipSiUogdmgHmZjYSUui+DAS9lr6Lftwexj9J0de0Re6p3pvH0GDx2v61jR5UgM4G6CsOnoEoMPYd126F3gJLDvjQEeOU0XaEOH57aWEqqSCtY/iUlSxabHrz14Jq6ctvJqgT6pbNnunI4h4OX7wY4Dx/9QQySoi6Y8EyPzflF6rer6AN68jK0/EdD3RUsQv/r5DsyBZcpUL2yxSiUKSGhJZlcW0pbnpQtdMLr4Xrcw0jYlSSXwC5jg=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090aa40c00b002962f35fb42sm1855377pjp.48.2024.02.03.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:57:48 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706972267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVvoN0wXfCgYng52T3ebQoQAp0KpMeD8Gkb2umjpO9Y=;
	b=INjUJtz8DPIqbSPB0oi9DnXpCTzfz5qo35IochaMl9KhSs8YmCILnNcSTacdhYtIuOGtGs
	rWqFE2y8ntWahRi4AAIXM8wK5OTX+QXqN+Fp4qCuwecIrJ2L/lKYJPDWWJUNywg/toav+t
	sMGs8n1TRjEmmCYmL6zZIYpS3qJf1JTeCwPSB9wG5p/ieyRh5mcVaUJBODlIsUw5bG68jg
	gNJNSunbiV6lHW9PEFMV7s2ELYHCShKrsqj7glWxKF+nwxvCQJAdruq2EdSWy7ueTutrTp
	qqtsSIiYLRPLeIrEhmkncasu9tU99kRVTDiU1T4Galyu74wPkVFc/+TM9CzBhw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 11:57:59 -0300
Subject: [PATCH 2/6] s390: cio: make css_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-s390-v1-2-ac891afc7282@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=N6FUHZVz7nICU9v02WHrAmRqKZqNMR8e/cf9i/r7ubY=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvlSAaI76EJeeVXoo8iaG+VhshhoYFeT2164bO
 RcuJ5CXZBWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb5UgAAKCRDJC4p8Y4ZY
 poydEACS+mzfhuRF81tMmnPhK5zhdwkdrD7Smo4iHrRjIo3rGrRcPwv1oKSao5mO74I52AhKiPl
 NmAFaYdy75D3lmp6F8zUpCwOO94c9u9rzSzF4hGcDxCgwb2ec9VZQyZTOReLwEbzpjgsUsuHral
 FLXMM7CP277PWR5IdExKGEY5SZy78p58kphhWKlB3XCYfmSB3lRmtDjkFFrt03iKwyjaiYQRf5C
 ueZ8UQgC8DEvA8sgIA/OA90tO6OJqytjyv3JlbUYCsv004gqvwunlUwjM/QvbeM2X+xGMSMclEF
 5A3BRzNWDzro/UnWbvxxpQ5SLc/vihE8GNLSsHnGRTYc5FEDUaHPBIy6nDNB1bb0gETZRzvPDGO
 +QCxOYB1kZGVx40veOQLJxUpTeeWeyHp5esxw1kmMZlbQ9l1rMpWVlAPr5YSGQ3ccbcZO3RjP59
 dJL3uiNjlCGUJVMhU3/X8wHwh9zIfLk0zhQG85vADt7ZXHPhilW0ZeEmQoUNRUDECW1MlylOKV3
 BWT93RNweFDyUIVpGWnIv7SBGXbkgih5/cXCU7buWPcKLNY/sPfz6+u1h/d1F9KSE5FzQBC+Z+I
 eRr1qrx2WNkaE2vR1wyeUG6tEcgVA+DMEI354OXqi5dLG5CLaxZNa2FRIk7d8VNXk3uoyLFguzW
 Z0QJNQ5DlGHdlLQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the css_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/cio/css.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 28a88ed2c3aa..094431a62ad5 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -39,7 +39,7 @@ int max_ssid;
 
 #define MAX_CSS_IDX 0
 struct channel_subsystem *channel_subsystems[MAX_CSS_IDX + 1];
-static struct bus_type css_bus_type;
+static const struct bus_type css_bus_type;
 
 int
 for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *data)
@@ -1409,7 +1409,7 @@ static int css_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return ret;
 }
 
-static struct bus_type css_bus_type = {
+static const struct bus_type css_bus_type = {
 	.name     = "css",
 	.match    = css_bus_match,
 	.probe    = css_probe,

-- 
2.43.0


