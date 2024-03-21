Return-Path: <linux-kernel+bounces-110560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD38886099
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771AD28618C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAA5134438;
	Thu, 21 Mar 2024 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jANCOR/X"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A5133423;
	Thu, 21 Mar 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046042; cv=none; b=gpmsH8QnVQAuA7hbKAPjoxVPqSBcpEZvdm2J9HU9eyI0dEMdNf4JpdjA3KaEAU6wJrajpZwzpNisomguEGTF1H5YZfpz/AUbvoNP6EypeJxSPyMlkM+N1nwezGejoeFJoF50kw5Mx+cVvIWHreeXE1EhKhLDrUWCwU8v4+Jm0/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046042; c=relaxed/simple;
	bh=7xiP7a7c+JxaaenvtRnKz3pbYlEuJfkFC57nCHzqmio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKPWQCC1Rh4GgqHbMTYeXFoDMABSpNOg0Z4O8VWsg/2RrFiyRkTm8gi3TJB/Yez39EEIcW0GQn177QMQfAZMq8JTBzEiHDBWVaZZy4Iv/rqIarDmTGi9pFVBZ0tZrmNNDQcnKjBCg7Df+0bqHpvLdEnypGnzeLKmHF0OuCiBQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jANCOR/X; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44ad785a44so162317966b.3;
        Thu, 21 Mar 2024 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711046039; x=1711650839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wjCWlFIYSFB5yCG74NtFNwwkx6eRRKsau/wQBzaYZI=;
        b=jANCOR/X7OM1UIZRsIxLa6UbE4LLJ/4B2MPE+bZUu538nuT+aX0/o+2u7408mOzbvh
         nRtl0VSPMSEyy7nPnKRRE5n3d8pN0EjBxBz3tpBJAYUv/bjtOU2TenKLmiakPiwjJOg5
         fRRdmUXwp2dibXm3mcOegylw3V9nEUIbCwwzoddEABqzmIGnYAHemvIWg6/XrH6W4uJi
         Esdg9/i45t7n86AA3Lzi7xHOL8CcRhnq5dbNw5oau5thMUceCb6wpDzj9oiUOWS32AEQ
         +5g5wnEgB+TcCmDCvnuocVPCbkk9xj97S8Y2E6KZMZ67uVJUHoIOXdTTgciEihRhujdV
         3q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046039; x=1711650839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wjCWlFIYSFB5yCG74NtFNwwkx6eRRKsau/wQBzaYZI=;
        b=N87+dtHVg57Fb2OMut3UrqtNuw6IODb3AR0R8Pgm2bTwk+oFyta+bH34t3t2lDtd1n
         tKeqbjsFneexJwD18qulA8QxttTfUlEVpsLZThc4ON7CUp0EsAbb0F9D/i9DuEpT7aXH
         77QM7ySFDl5GWs6PMEU2ST6s2B+0nA1j0hScVX14iHWOSMETDtXyK77k+PQv4CiMctNd
         cRBDiO8p5evfS3uZbJ266zczOK5X5yYvW4QahfGK2DSIsJWpxn4DHqFAzfHGvLRRwBLl
         ox0swRNqbtg32wwBPkC0Pk08KwdRb6AuKI7Xsj9hiIMcrsacUjOJTLaKztqSHCZ4OmHH
         6gIg==
X-Forwarded-Encrypted: i=1; AJvYcCXFPpwsldBmDTMNR/1yly8StFRq8YfaetUwujBDcbxCzIr7Ljj/zj5BwdeWJ7602Zcqk+vjXRGnMTbCSFkpYg3UroXukx588eueEUUiPHHDYwvrNIUh8R/JeNX/NF0SKqImnlGWb8tYNQ==
X-Gm-Message-State: AOJu0YxWDdUOWuWW8HANCAj0ry654mHWJ7usNOkKRAR3+tOLFs00dL+n
	YV1nAbPnqcBqBmghstBYvFSFhRgB7ySdCwNNoJgHWiR+GQxf7NxkMorJsDofsQo7bA==
X-Google-Smtp-Source: AGHT+IFf8Jg9aCrejcgaXxXMXUX2MxqCqZrm7ikC89u/wfAcOtUALsq0zG+LKzRZnCQHjZQIH33RQw==
X-Received: by 2002:a17:906:39c9:b0:a46:74fe:904f with SMTP id i9-20020a17090639c900b00a4674fe904fmr186915eje.26.1711046039590;
        Thu, 21 Mar 2024 11:33:59 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7db2-5855-2c59-b89b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7db2:5855:2c59:b89b])
        by smtp.gmail.com with ESMTPSA id hg18-20020a1709072cd200b00a4661caeed7sm191511ejc.48.2024.03.21.11.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:33:59 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 21 Mar 2024 19:33:49 +0100
Subject: [PATCH 2/2] iio: health: max30102: add support for max30101
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-max30101-v1-2-00b83e966824@gmail.com>
References: <20240321-max30101-v1-0-00b83e966824@gmail.com>
In-Reply-To: <20240321-max30101-v1-0-00b83e966824@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Matt Ranostay <matt@ranostay.sg>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711046035; l=1134;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7xiP7a7c+JxaaenvtRnKz3pbYlEuJfkFC57nCHzqmio=;
 b=GqM8SG4IKmQSjjGx9ANWhEXgwQF1sKrh9nP3LExH/gTWzHVrz6e+htgtkXace0BnMO9mHirKJ
 bGzdnPEfsvkA0lZ6xd3B0dAXrIm+Te3xV/VX5DXqAgvX0d83IFDF2nS
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The Maxim max30101 is the replacement for the max30105, which is no
longer recommended for future designs.

Their internal structure is identical, as well as the register map,
configuration options and sensitivity, which allows for code recycling.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/health/max30102.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 37e619827e8a..6616729af5b7 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -613,6 +613,7 @@ static void max30102_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max30102_id[] = {
+	{ "max30101", max30105 },
 	{ "max30102", max30102 },
 	{ "max30105", max30105 },
 	{}
@@ -620,6 +621,7 @@ static const struct i2c_device_id max30102_id[] = {
 MODULE_DEVICE_TABLE(i2c, max30102_id);
 
 static const struct of_device_id max30102_dt_ids[] = {
+	{ .compatible = "maxim,max30101" },
 	{ .compatible = "maxim,max30102" },
 	{ .compatible = "maxim,max30105" },
 	{ }

-- 
2.40.1


