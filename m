Return-Path: <linux-kernel+bounces-60551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8D785069B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58C1B242A6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825705FF1A;
	Sat, 10 Feb 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhr4Mrvb"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C65FEE7;
	Sat, 10 Feb 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707601980; cv=none; b=SkAVjlyX44Ok9lSFBM4OYor87+XN0JyD7ASVM/hW/aFzF2BAUk9jIbblI8NbjllZJk2liRRN7c5s/TSkO0iUTkpGsa3wco26P6oD4VPOMT+Kvp5YXZJ77Y2D2K9NUHjC9O0f99uwJ4HNqyGNBrFhGXSmzjN+iYEqk7+7Gh1zox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707601980; c=relaxed/simple;
	bh=+gpFQT4ELKCeTcAffH47le2OqwH0PUarupoW82tKagk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qr+qEgrv8D2z3F7qjZxlojk6anTE51enpjKJuBzCQsLOcAQRda8n1wyDQ/MulbO5FKvHA4WgVNG7BDjumYlZKVG3pAQkAwv/8zLkoCRcAr/El31AGYOOVEGpZhH8JvqCIVwhrHcb5IUsbCDj6aBHmrY2VyLBEYzGxz5Hq4dlnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhr4Mrvb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51142b5b76dso3208872e87.2;
        Sat, 10 Feb 2024 13:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707601977; x=1708206777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIdw/Yz0Q97V7CTgaGjXXRg1G+fU20Qvt8n1MGF3Yf0=;
        b=dhr4MrvbRqC4ZU7po7Lu6Mtj8xuAp8ececwH/zvWU9T665DXLHVfzHgB8gvLL7f358
         kZ3Yu2pcxtPRuMXai8HK6Qhio73dE/oB060aUoxeINL+OjpJSfEfMDYPcPLScYnk/nFi
         rXypb8gS/c9jJVuZHGl0oikl6Zm+jEBdfgr8iy0XdwD9ue6JoIM/bv4OncT4VZ9zKsct
         B9TLe6c2ftmSqqFoK5xXfb/yx/Kkw+NvacTjk8ypS3oI2Dtu59P06vTjnjltp1S+01ED
         tGmYthAEHIOJ7TA0d9fr7myLxNzWrlAefIkMVDIaw5jA7UY4/ZJQ9paX8NvxQwzFqkXp
         VUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707601977; x=1708206777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIdw/Yz0Q97V7CTgaGjXXRg1G+fU20Qvt8n1MGF3Yf0=;
        b=ZhVtAWRfXROUpEU3tGIGh34AROLok3uORizTIAqNQ8UOKfslr02lkSGTOx5bsHRebk
         ow9sCHhV0M7yWU7x+66fyMQrrHXtr9dD+u0TFrZQS+Qrc4sMscmwtagVE80sezMiIgP2
         ACMOQG6w1Q7ILBUjR1JMQhxsku9zklHRcH5f6X08PTzn5/ABA1nnBghcAlv7FFjh+OAF
         nln6wIC3WY+q1Y9iWoQbsvc4I07p1LMDkBnLr2gvqm0caHDU0/sIlU9pQUJTS971281y
         w49Yd4/cCRmdhIHiQjb9ACUrpmQQ1juGJLuLOy3MIOhhAyeMZKO3MWFdTJaGsABfo61P
         7euQ==
X-Forwarded-Encrypted: i=1; AJvYcCUglLEmBL8jmRRY73kyI2+wckM1KT8qgZcCvntWp1u3iqMxM163LaTRfJgDFF3BfJqIpwKNKDGu3kIfVQI5ldBjKcdnVkb3eQS+gc75pkVf1JbBc8AKgFWsGrPf1z1Ssnkes91mRFcSgIw=
X-Gm-Message-State: AOJu0Yx+SzdAAsoDREGEws8Jhudat4bZo+LRRzccXfhVVvVbCJGc/qoR
	tUEOoHlb3N8m+3a7DgQEnz3Jyq5liQpX9VhxCiF7UadFBXZ8tmEP
X-Google-Smtp-Source: AGHT+IHhIQKjHQWG133TzasYPGdsz4BD2bTaKitWQe0Tz1DzqfhbEO8+6t+WhJpgEDFVvdgXMMzdvA==
X-Received: by 2002:ac2:44ab:0:b0:511:87ee:297b with SMTP id c11-20020ac244ab000000b0051187ee297bmr422417lfm.53.1707601977045;
        Sat, 10 Feb 2024 13:52:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKWen3NWtIxj8+5gqx8iABYDfx49aOEBAmRmf7Z2U8DH0HhkB++Y2dMBRcOjPbQvYzOTY5hsY0MwZA6Wgo4Z7/d7MYm4I9TX6LwK7dLqCN6gYyR0+w6KqoYJ8NchF9FtAItLfWAS2TePvmkk0qnJThWRUH8HH7fuxgMDDTUtLPDmSrmGW18/hJe/WlbM5DniHYlDh7Cp/rNmOkyqSz7XfIrXVkOg1eW8K1/8H14cA5T4SeFEMsvEYsVkczd66MtHDv+t4dYIRwqMERWBnRxtgmaEtIIRDs9R5EZZHp79XbOlzgt0DnzeFo1Ax4nM1m6LVpTUAk+GxkY07K9XioMdLmXv7/zNShAu5binsF/FDprvbz+++8tQ==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:52:56 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 04/19] hid-ft260: remove dead code in ft260_uart_receive_chars
Date: Sat, 10 Feb 2024 23:51:32 +0200
Message-Id: <20240210215147.77629-5-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove conditional expression, which will never be true here since
it is already filtered in the ft260_raw_event procedure.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index a348f11600c6..77638cae595e 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1202,16 +1202,11 @@ static int ft260_uart_receive_chars(struct ft260_device *port,
 				    u8 *data, u8 length)
 {
 	struct hid_device *hdev = port->hdev;
-	int ret = 0;
-
-	if (length > FT260_RD_DATA_MAX) {
-		hid_err(hdev, "Received too much data (%d)\n", length);
-		return -EBADR;
-	}
+	int ret;
 
 	ret = tty_insert_flip_string(&port->port, data, length);
 	if (ret != length)
-		hid_err(hdev, "%d char not inserted to flip buffer\n", length - ret);
+		hid_dbg(hdev, "%d char not inserted to flip buffer\n", length - ret);
 	port->icount.rx += ret;
 
 	if (ret)
-- 
2.40.1


