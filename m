Return-Path: <linux-kernel+bounces-89708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D9786F47D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EF72835D3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE70EBA46;
	Sun,  3 Mar 2024 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yyGQN/T3"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51419B64C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709462942; cv=none; b=QfVMazjRYbA0G6OYGBWLSgR/4QETXhDdlk5IucEkrn2d5byirH4bk8+fUuvaCp2uqo6Qx7/7x+aYUXVTvG8/WkFumWVJSyz4uSNgllm2j5kY81cHvA5i+a0dsed7CShtAelt8xIDoJb0CclktWlswBE0R0PX7tp8DOhlFjn41qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709462942; c=relaxed/simple;
	bh=wdMZvlY9a5pjvdej/k7MCIk+lVgoJHMV1KhOOpZkf8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PC2/BUSjIeKn+muSlrZhcEsxgQo72CTiagNIJuQYWrZ78WQV4xH32p6umfDwQs5pZANlB+qQbl8Uu8tEt3YzbUfPm+P5gEhKiMnB+oPGKZbB7LHlSxCEYlB0iO13K6xu0OLVu+O7ukmTUcTcsfQjCm/3vN24id2WjO9WxKNmcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yyGQN/T3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a446b5a08f0so403098666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 02:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709462937; x=1710067737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qntDsCq8rgJuk7hdQSQYmfEUmAPY9qw4QwTul/rj/lU=;
        b=yyGQN/T3j++gHMHFi+q96mX9ZYpLRXZHUtxxVLrSfY4jPIzs4FBiHMO7v27ugR4dAM
         1UjVs383IAWeFD7qt4qIdbI8XBzLrlTtvhYvS34X01jFQLeXA4UZOpaciWbQiKWPtKey
         aOBLp8NkSH6Noh/5qAywHzIh4gVpnluzTbVTIySJdTjoy0fxQDknTqKVYepxt8v/Vl8z
         R3lvZDhnBd1I+cDwEZiQvTS+DswITDf4n/1T7UvsbT0RuvD8IVO0onooq6XKdXkGQ431
         YsZWai15/A4qYLmnfVfy4mLbL8JPh7MNgpG6QLBrSVnZ6Eo8xk/P57k8mXyLpLFYIn8N
         VRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709462937; x=1710067737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qntDsCq8rgJuk7hdQSQYmfEUmAPY9qw4QwTul/rj/lU=;
        b=dTYmLpB2/ffi884BMVnJSzIwKD9stJe3XZ4kRtMi6efzjJ3LkX5aUAYbVzLiJ2g8FP
         mnZtMccc1LQwBAFjvCy16ukpBhzHZPsDrEPeJc3bD7lw/GZ6UfUJ0bpwnLlAgfZL9mO8
         tzHYjojBD0jInFU1EaKuxtR0qz361ej41J7hGTUxQ5qxF4dndpeCMP49wHkuKBz/+xee
         I+CySf5NuvrnVwaP+hvOtU2qMJGkyoJICWq2ATMCo9ymNl6q+qv2uyowHtWEhCyYl5jp
         n54bG3+YhyoCjdbmjZY07mV1INUgAW692mgbe9mErk3/qcFzeymC1Xe4RCDFSd0Ld6lT
         02iw==
X-Forwarded-Encrypted: i=1; AJvYcCVQY056skEZItmD7PKa2EUVx0wTvfjTgM7tkoTogkIT3RzObpm70R6jf/vI84oE1Acrif4WVO/WGzUHwQ7OI+2Oyt3n/zNnlI2QdU6m
X-Gm-Message-State: AOJu0YxfhuC9ZNtSBOfMtWoLshVHATFrTd3qsiMFi3bewYMOXvA7LMpM
	Kg+Yan4s5CIVC3HMfPtysnnb8aTvzYyoriO++HJOWO6ooBcmNtdHYlrgZR/veLs=
X-Google-Smtp-Source: AGHT+IFpd7/0A8HZA8X0BaCKoqokGmayqMEq28RDQ2RuXymWMt5xBJCQfQZs2Qv/VI3r31VlyOkWcA==
X-Received: by 2002:a17:906:6c97:b0:a45:2cf3:6c65 with SMTP id s23-20020a1709066c9700b00a452cf36c65mr445528ejr.25.1709462937430;
        Sun, 03 Mar 2024 02:48:57 -0800 (PST)
Received: from brgl-uxlite.. (5-226-109-134.static.ip.netia.com.pl. [5.226.109.134])
        by smtp.gmail.com with ESMTPSA id he44-20020a1709073dac00b00a4323d1b18fsm3582303ejc.34.2024.03.03.02.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:48:57 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] of: make for_each_property_of_node() available to to !OF
Date: Sun,  3 Mar 2024 11:48:53 +0100
Message-Id: <20240303104853.31511-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

for_each_property_of_node() is a macro and so doesn't have a stub inline
function for !OF. Move it out of the relevant #ifdef to make it available
to all users.

Fixes: 611cad720148 ("dt: add of_alias_scan and of_alias_get_id")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
I have an upcoming driver that will use this but which can also be built
on non-DT systems. I'd like to get that in as a fix to avoid inter-tree
dependencies later.

 include/linux/of.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 6a9ddf20e79a..a3e8e429ad7f 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -362,9 +362,6 @@ extern struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
 						 int index);
 extern u64 of_get_cpu_hwid(struct device_node *cpun, unsigned int thread);
 
-#define for_each_property_of_node(dn, pp) \
-	for (pp = dn->properties; pp != NULL; pp = pp->next)
-
 extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
 extern const struct of_device_id *of_match_node(
@@ -892,6 +889,9 @@ static inline int of_prop_val_eq(struct property *p1, struct property *p2)
 	       !memcmp(p1->value, p2->value, (size_t)p1->length);
 }
 
+#define for_each_property_of_node(dn, pp) \
+	for (pp = dn->properties; pp != NULL; pp = pp->next)
+
 #if defined(CONFIG_OF) && defined(CONFIG_NUMA)
 extern int of_node_to_nid(struct device_node *np);
 #else
-- 
2.40.1


