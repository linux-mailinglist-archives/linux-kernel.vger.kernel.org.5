Return-Path: <linux-kernel+bounces-128375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2D895A11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3CD1F27182
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956B515B149;
	Tue,  2 Apr 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXpgWmNf"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2874615B119;
	Tue,  2 Apr 2024 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076388; cv=none; b=YK5+pHeq+avq/yOU6ZzvxN9GDJUTTqSMYjAQak6CcQNniSrHYdw/iZ1+0vnOi86Cxo3yLgf09q9CnD0KrNX5bKQh0XQYVxCZmLp4gOPgBhmiFjQ8R6n3v3ufIR91l3ds4vezvCwVFwLKlVurhILW+RECIX+sYU5Uot0/EXyAZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076388; c=relaxed/simple;
	bh=H0ma8eY/8/S2N+welQc2fVRYTdGUfB4oLn55S6JvmDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxkoDWaKEje48hEWtH54b9JnYPtYNMsnVSVmXQWdbktLDwHRkjF6jkxUfHJw1iLyr5LiM/4Y5GLrc0OiqNuYS4tQT3g0/4qlZpRB7CI2Ie3vQsJ78bzm5Aq5XPsVimSAlNW6xXyBgwTxdxUkdDSwHyfDvAOXfp3upti6U7iwbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXpgWmNf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-515c3eeea5dso6338544e87.1;
        Tue, 02 Apr 2024 09:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076385; x=1712681185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvp9vfG0Jk7g28an8SJ7vQketSIg/VKljXWkv56ib7E=;
        b=BXpgWmNf6NSF3KtTrY/rWU5tJS8wZ5IGNScMCA07dhS636FyUmmBSS4wq5sBXnmOOZ
         wt1HGYhW5Psmgc5bF9Rh0MWSaYvnmxJ1/zc25JO074GbHxnCsX06KlGB+P9pCTm5TO6C
         l2xAGp8+FdDb/CWPtXJKkuZ6mC54hS/nONXoQp7XdKThoKXXfALpkZ4mCEkw09/GQV5J
         +BpAEtNUAUUpntFE1SKnodnf9//O17z/wZkoVzCwD8UihhslrIOIYxJFxYhO+RTx3Gz2
         2F217SIBnAAU9hJkNpAIB2iBvxdVq4uq5JzfwoTu0uk4KLlaGwv/UzIP/BWFS5C/1D80
         R4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076385; x=1712681185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zvp9vfG0Jk7g28an8SJ7vQketSIg/VKljXWkv56ib7E=;
        b=DLeEbBXrHcgJNL8IDBBtGp2h7G0LlaBC12B0CepNZ9492XsRhDTm6lHrqjpqoyybme
         rqqryhjWaEoXhyL8uWT3zi0qqF8oqWC2Mcik0uIbv1gX79DkmqCu14bivFYEJ8wdZy5L
         XgHk1nEUv+3LwkW8fEuAz5BbqRJv6GDKgvhXZfuF0yPXKQfqKgfojFhRcDnuGlYti3f+
         dvqpVfyvQlf7THhlPgva0j3F5y7ltR5zvbcI/JFQlwVIUWjg8l/0NfA2qmJlUKdHFYES
         kZP/1wzHoI/fCPne0JQIu+8nRQXct5g9TlIhefE/ZENxcu6SMtzbvxHoN1ZqaoVWfW0T
         7MEQ==
X-Forwarded-Encrypted: i=1; AJvYcCULSObrNvN5dtl8+JLjyzxaNQQaZx4GTZqQINtGH0mFmK4cPOitcIU+Cu1H8ODh54nDGEtz3j4JQBzcKd7OWaOiVmmvqF5XyMlUsz7H
X-Gm-Message-State: AOJu0YyLWMoKEJffvcsQoH0QxLDiQaljsrBBUA7zs45m3hxmDUFXMDXh
	b/keoKfrefgq2loeTCBB4ZKl2PhsX7QHIpKzZKKaMDwBg6CoCdIcbOxWnQHTTHkTaA==
X-Google-Smtp-Source: AGHT+IEReO8ZOKL4HY4Vm9cDttgAjqCtyW+FlGR/Twe2yq6ADB3Ot4ZsoFYgpQyRa54LPEmWoieyLA==
X-Received: by 2002:a05:6512:200d:b0:513:4a0c:b83d with SMTP id a13-20020a056512200d00b005134a0cb83dmr7938266lfb.46.1712076384509;
        Tue, 02 Apr 2024 09:46:24 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id g1-20020ac24d81000000b00515c102c826sm1779374lfe.270.2024.04.02.09.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:24 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v4 09/20] media: i2c: ov4689: Use runtime PM autosuspend
Date: Tue,  2 Apr 2024 19:45:40 +0300
Message-ID: <20240402164552.19171-10-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use runtime PM autosuspend to avoid powering off the sensor during
fast stop-reconfigure-restart cycles.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 0e0e694510aa..2354397ab34c 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -426,7 +426,8 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 	} else {
 		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 			  OV4689_MODE_SW_STANDBY, NULL);
-		pm_runtime_put(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 unlock_and_return:
@@ -606,7 +607,8 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
-	pm_runtime_put(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -876,8 +878,10 @@ static int ov4689_probe(struct i2c_client *client)
 	}
 
 	pm_runtime_set_active(dev);
+	pm_runtime_get_noresume(dev);
 	pm_runtime_enable(dev);
-	pm_runtime_idle(dev);
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
 
 	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret) {
@@ -885,11 +889,14 @@ static int ov4689_probe(struct i2c_client *client)
 		goto err_clean_subdev_pm;
 	}
 
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 
 err_clean_subdev_pm:
 	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 	v4l2_subdev_cleanup(sd);
 err_clean_entity:
 	media_entity_cleanup(&sd->entity);
-- 
2.44.0


