Return-Path: <linux-kernel+bounces-163893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B927F8B7563
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEBD1C2222F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4552145B00;
	Tue, 30 Apr 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvvdYvaH"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D458141995;
	Tue, 30 Apr 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478763; cv=none; b=EuZvLhHMl9XvB6qkHIQtQz7OcDy2XxbkB2phDwJJMln4QstQxiqnJC4Fhlsyj55nJxg9R0VUXPLhSva0EC9IzGGMwOSotpJDHfdgkgMOAfj7MZuVxacjZi+cK1R+DYW0bEtNrl5FOELn/ehx72u0EsRcoUBJ0ktp7IGsMwvKzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478763; c=relaxed/simple;
	bh=nRD3dR3XiS4O2pkMTYgKRZdJOJRmKsBkVoKSFraFbCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVnl8tItWFTw7zbRa2WYP/DP3PuGzaBbxojj0fukV0MY2YteyXL5LA5hYdTBXfg/h6piXIIcLF8/yX5c+5vaulIIuRPIPPaHl+k4uyba8VRUbiSM7fsiaD/fu7ZPR15iZnZ9dcGpXJoURToxWt9/oeRQyAXHavFURhlrWsbfM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvvdYvaH; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51e1b9fba81so1610569e87.3;
        Tue, 30 Apr 2024 05:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478760; x=1715083560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXZzTP12Y0hh4c4gYikxBkSiOjWjQelhhWRiIzMHGTs=;
        b=HvvdYvaHsVXAuN1zYbelFwbvwAnmYwP3xCEJloO8gipAB/Yp6hXUk4Et5XpmPmOTb1
         o1KYv1Cr1u4i4aS3Pcj4MWF49KmFFH2vbnkgMEC1OySoh0xjGqOTTbSVLH6DKIP+4Mhq
         kA2uBHw9TORn0+eOyiO5IKQHNv1bNM/95yQG2bB9TUvxJcAurcH+pYS5afJApL7zk0yB
         QFzauopdsX852skMpWMazIatnAgnKwnpufuZo8K4affToyYd7N5Gkb6Dtu4+OPUsIygn
         Z9UjEIRcHnB6qH0dZGSP51XhffEGdAAZE5BE+ubOmmnFTPpB//Ct++frmAADIpydlwPK
         S+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478760; x=1715083560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXZzTP12Y0hh4c4gYikxBkSiOjWjQelhhWRiIzMHGTs=;
        b=T1zh/XZUvPxS6aNU6RS6fzzAdFR/C/VPVLNIKoXBhWrW88177xz3Fn5nbvG2+gBsxA
         PXJM2/wOEfugffgS00MZHpPSPuW4IekWK/g8tCWmdhsQUF7HyMHvjI6YeZMKny0vuT+W
         7I48zx9LNbK28LuIz9Ke7Bv5s63TiCnZ5tPuZNVy82mT92tM4SvmwJTt22i/9XSH3UjP
         i39B5ZXxRTNpa/ZMfzK18PJKZ272yNNJJEowa4YsUXaVocMq/pJDL1UqJaqPQ15w4ATt
         WvS3d4uKncNJLHDABcd+FbPavt1xbKj4ge3Ko7BiTmpozdQhw1667zJu9JGSL8ctSOKI
         7bAw==
X-Forwarded-Encrypted: i=1; AJvYcCUkV2hBuarJQlS1ZfetzQQhr5cTwyv81PhjDk4PCN9wIaF2w2NXhZ9O24EXpSaaI4zMfZRcPgrKRvP6xcYqlc5uGuo/EwIsHqiWw7cPi7xeeoFcps+eejQBgcZtsY2MnIt2kO3yvd6C
X-Gm-Message-State: AOJu0YxwdQifq68EWttDsQslDcBxZkd0giV3l6dRpjj+XUqclewE1GXV
	9s9aYaayqhUXoviuHwPCeoVFvVzSaTFebwMsDvGy0Ls5P3BMtvAC
X-Google-Smtp-Source: AGHT+IEOERiyJM9ihi0i3SchdhZahYeOxvdDGTzEg0Ou9/KbolawOiew6JV38L4WA7hzczR15+SlGg==
X-Received: by 2002:a19:5219:0:b0:51e:2e0a:c38c with SMTP id m25-20020a195219000000b0051e2e0ac38cmr2248733lfb.45.1714478759717;
        Tue, 30 Apr 2024 05:05:59 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b0041bf45c0665sm11054324wmq.15.2024.04.30.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:05:59 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] iio: temperature: mcp9600: Fix line exceeding 80 columns
Date: Tue, 30 Apr 2024 14:05:34 +0200
Message-Id: <20240430120535.46097-5-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430120535.46097-1-dima.fedrau@gmail.com>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix line exceeding 80 columns by introducing new variable "dev" and
apply it wherever possible in mcp9600_probe.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/temperature/mcp9600.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 4003bc8c83d3..cb1c1c1c361d 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -89,19 +89,20 @@ static const struct iio_info mcp9600_info = {
 
 static int mcp9600_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct mcp9600_data *data;
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
 	if (ret < 0)
-		return dev_err_probe(&client->dev, ret, "Failed to read device ID\n");
+		return dev_err_probe(dev, ret, "Failed to read device ID\n");
 
 	if (ret != MCP9600_DEVICE_ID_MCP9600)
-		dev_warn(&client->dev, "Expected ID %x, got %x\n",
-				MCP9600_DEVICE_ID_MCP9600, ret);
+		dev_warn(dev, "Expected ID %x, got %x\n",
+			 MCP9600_DEVICE_ID_MCP9600, ret);
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -114,7 +115,7 @@ static int mcp9600_probe(struct i2c_client *client)
 	indio_dev->channels = mcp9600_channels;
 	indio_dev->num_channels = ARRAY_SIZE(mcp9600_channels);
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct i2c_device_id mcp9600_id[] = {
-- 
2.39.2


