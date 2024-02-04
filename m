Return-Path: <linux-kernel+bounces-51936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEE384919B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 00:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEEE1C21CDA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734E12B74;
	Sun,  4 Feb 2024 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpke+rAr"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9D1119E;
	Sun,  4 Feb 2024 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707089275; cv=none; b=lXOOctjb0TEeg0T55fmlbjw4BzTVvOJR37SuBKf7/wO/ViSdKsqLvkBbY09LXej8MkZptfjv96Pi96ysCaPGdo08UGrwRGnA2JOFwK4JbbyDbeqlP/xjQFQaVj8/UhMe8ETxxR+K1VZLhSEtA2L1ivT7tPS0iFjzvc4IQ3PCejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707089275; c=relaxed/simple;
	bh=qGWD47VTrNcesmAj59l+UTUDiBiGiGqqP+srzQokYsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHEkGv+hpUMSBCOtfm5qw2WXYJn8cuVAemkjmTbG2cjiD1HiR7JgDvl+Gm+TAYCchmQWSEQLWmJM1TXADCzaPt+FkC7pyvtWWrcSuTmwapyCEpgHQfQVrFVZF9fb2jc7wfoVTM+ww1PulobBxk9GVPMBko3xn7iTE+eL0AA9CY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpke+rAr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d98fc5ebceso2335905ad.1;
        Sun, 04 Feb 2024 15:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707089273; x=1707694073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Kwlgi9du2mr3JfC5Qx8s/vu3NEAYyLKNOcT6HYFr8o=;
        b=gpke+rArZcEBARY/Kiik9XvJ4VkMxyCrQ5YIgrpY5nbwvliEC6jyP6ZsCgXLMdkMNC
         nO+Nh+8gOaxLnw3CXvYE4Aipxdj0hji/pdkQG8/R2meDQ5qcRERiWjNgRiJjo0PMbPve
         XS36A4S8ExsJg+mj0xa9gMbfY8hIfqYalYr0pCoSUaeR52CF/1bhDAOXlzUhSHlibMzj
         LdV+/iYaWa+kqAGjBUmJz/w1FGs3bzydGEisypecDNhVkVgo7kfVjvkfO9PAp7eXAJ5j
         IKK+zFb8rK3XVHSfQDBI0OnBfVZ/LGZwC5Pcq1fNokRdcEG7Z9CvzLVfs2zoQLoKdkEL
         /gkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707089273; x=1707694073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Kwlgi9du2mr3JfC5Qx8s/vu3NEAYyLKNOcT6HYFr8o=;
        b=VlKU5I7vy+utn/94Z6O+oYl2lplMP6VOqQ7lteQWuWCuIQHnwxvzB6n5G4Vlv3+3FE
         3guW0SOCq7N6cXOnOYu06pnFrb78hi4c4VUyruXqx7In6A+Gk9WWAsNyowHSwAo0mPrb
         7iUvF1norRm3cuDjPYQ1ynKtzUKtWvxDfInfF/FuLsKyviPBsE2Oem7LXPKZ8IQA8scR
         tJku7x3/lcVAB7DFCQsxJ6sAYKjxjwBssi+vjXBx915DoZtfDZFURWEE7bqUWnoqlEA6
         m1ihY8xIOK5FmocJ71XZYG/jp5CB5pyf+FTa3U1nSeLCeVQrmqlmCe8y7ssO4Havmw3j
         R6Sg==
X-Gm-Message-State: AOJu0Yy8CAMi3wS8N28UW5t7kDm1bCYzTTiR75zbCypFeOb/lJyqFK53
	tZRo9jHaiVnQ9Q2UKcZSubZg/F7DhRHwjwpKRcOSTtcGB4ySzWmV
X-Google-Smtp-Source: AGHT+IEfk3q7CfS6xsNZVMJFDkQMWlnxE3V/463/Jg0wI2EcBXJTMDJ4kMf8UrCuYK/HTit1/DXpQw==
X-Received: by 2002:a17:902:708c:b0:1d9:63d1:e619 with SMTP id z12-20020a170902708c00b001d963d1e619mr7665779plk.29.1707089273212;
        Sun, 04 Feb 2024 15:27:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHe0X5O9U+ZSKP9ccZJOEnT98l3yBfdJLBUlvtCx61YCFcjmV/9kco4o/6MDibncCx+IDyQp5hYsI16FNLQI4hf7jqtbBa9REJciSFziw/S2RRtRcv09iYnmmPA6OhEbn/uZHH4xhLod3FVz2SwtqSjHqm3ZCNK7rIHORC01JiJMw6O4ak
Received: from localhost ([2601:644:9380:8cd0::7fb4])
        by smtp.gmail.com with ESMTPSA id mm14-20020a17090b358e00b002962057028asm3684226pjb.46.2024.02.04.15.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:27:52 -0800 (PST)
From: Matthew Wood <thepacketgeek@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/8] net: netconsole: move newline trimming to function
Date: Sun,  4 Feb 2024 15:27:34 -0800
Message-ID: <20240204232744.91315-4-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240204232744.91315-1-thepacketgeek@gmail.com>
References: <20240204232744.91315-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move newline trimming logic from `dev_name_store()` to a new function
(trim_newline()) for shared use in netconsole.c

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
---
 drivers/net/netconsole.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 12bfb7eaae7f..e6c3b15fe95d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -230,6 +230,16 @@ static struct netconsole_target *to_target(struct config_item *item)
 			    struct netconsole_target, group);
 }
 
+/* Get rid of possible trailing newline, returning the new length */
+static void trim_newline(char *s, size_t maxlen)
+{
+	size_t len;
+
+	len = strnlen(s, maxlen);
+	if (s[len - 1] == '\n')
+		s[len - 1] = '\0';
+}
+
 /*
  * Attribute operations for netconsole_target.
  */
@@ -424,7 +434,6 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 		size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
-	size_t len;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -435,11 +444,7 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 	}
 
 	strscpy(nt->np.dev_name, buf, IFNAMSIZ);
-
-	/* Get rid of possible trailing newline from echo(1) */
-	len = strnlen(nt->np.dev_name, IFNAMSIZ);
-	if (nt->np.dev_name[len - 1] == '\n')
-		nt->np.dev_name[len - 1] = '\0';
+	trim_newline(nt->np.dev_name, IFNAMSIZ);
 
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return strnlen(buf, count);
-- 
2.43.0


