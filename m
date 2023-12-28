Return-Path: <linux-kernel+bounces-12860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1139381FB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 22:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA51A1F21F86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFD6107BF;
	Thu, 28 Dec 2023 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD2cP4DQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF622107BA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d5bc68bb7so22707375e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 13:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703797743; x=1704402543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VD8jry2n9oYnQroBp/sWVFb9m0Xy1NNznk93zWH+cWg=;
        b=OD2cP4DQVpw/C3vPWmWlmJxQuDVphnQQr7iR3rVmcBYuaexmBYWsaMUps8mE93FOw/
         o0664X3XvCz9cAaN8XozSnR4A3IbferCYoMWo1oYja8I3oNVxB88f001estfPxQ6xU4N
         9tpzsPc7SJVFhHYG267cWjuqnVeDQJwBDvs1DxZJ3c66tDszdaPxdN3flEMvl3cGCzOP
         UZWZ3Xishtpx9D5m3qYM2UA7DniN3E5ASqXp7JiT7GQVwb3LknFEKGiasbexop+7/33K
         Yz5sXZMHRkOY+20kL5YRgzgHMPpZrc42OKcCQ4WBsuxOfXe8XCP+UU6mf8ZdA9edpENx
         1t+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703797743; x=1704402543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VD8jry2n9oYnQroBp/sWVFb9m0Xy1NNznk93zWH+cWg=;
        b=uNOpfMky4YqNhL+I+ItgbXzV4a/eFPgJUsx7+ey/S0PbeF0jXOHxlSBBB8nVCgvYjv
         ZAJvzXwprAMGW13xuFilV9zh4TUgZh+zjcf++xkXt8hDZS9d9JYlD8+gu1J9LmpBzLUB
         PfI1JJMmyEnRNpvejXP8P+48Q7nWQk6Bd9AN6FJxssvsaxwPIqAbCKiTkpAP7Y8rXv24
         x1xtzjR/UTuNWIurLQjqj0N+R57EW1KYHP0bu+YNhYBp5srraD+eevenxvs1cnN0kGYU
         5ZKrX+OGYOxvktTwtpy8L1uPQQK0eYWXNLJiA+r7/aN8uitzZAQ4LzKuofN9rUdX+wsk
         fQaA==
X-Gm-Message-State: AOJu0YyW8V0pync7x3ke3qXjd20aqECG4T+ASLrLzufpZfc7k8mxb+/7
	fY7n/4s7RQwotbxHA0hJnbY=
X-Google-Smtp-Source: AGHT+IEGqr8CxMU0xGwyaZ7Coe83v9rC3MJEk2VvoaphTLzRuFJZ+zzAC0/oc9ZKeIh6Su7HapLkbQ==
X-Received: by 2002:a1c:7209:0:b0:40c:a12:d626 with SMTP id n9-20020a1c7209000000b0040c0a12d626mr5912439wmc.103.1703797742977;
        Thu, 28 Dec 2023 13:09:02 -0800 (PST)
Received: from localhost.localdomain (bl17-216-113.dsl.telepac.pt. [188.82.216.113])
        by smtp.googlemail.com with ESMTPSA id u2-20020a05600c00c200b0040d40469cf6sm9278273wmm.0.2023.12.28.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 13:09:02 -0800 (PST)
From: Malkoot Khan <engr.mkhan1990@gmail.com>
To: ogabbay@kernel.org
Cc: fkassabri@habana.ai,
	ttayar@habana.ai,
	stanislaw.gruszka@linux.intel.com,
	kelbaz@habana.ai,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Malkoot Khan <engr.mkhan1990@gmail.com>
Subject: [PATCH] drivers/accel/habanalabs: Remove unnecessary braces from if statement
Date: Thu, 28 Dec 2023 21:08:58 +0000
Message-Id: <20231228210858.114111-1-engr.mkhan1990@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coding style in the Linux kernel prefers not to use 
braces for single-statement if conditions. 
This patch removes the unnecessary braces from an if statement 
in the file drivers/accel/habanalabs/common/command_submission.c, 
which also resolves a coding style warning.

Signed-off-by: Malkoot Khan <engr.mkhan1990@gmail.com>
---
 drivers/accel/habanalabs/common/command_submission.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index 3aa6eeef443b..39e23d625a3c 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -1360,9 +1360,8 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 			return -EINVAL;
 		}
 
-	if (!hl_device_operational(hdev, &status)) {
+	if (!hl_device_operational(hdev, &status))
 		return -EBUSY;
-	}
 
 	if ((args->in.cs_flags & HL_CS_FLAGS_STAGED_SUBMISSION) &&
 			!hdev->supports_staged_submission) {
-- 
2.34.1


