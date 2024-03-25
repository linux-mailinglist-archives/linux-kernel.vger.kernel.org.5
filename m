Return-Path: <linux-kernel+bounces-117486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A472988ABE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CE31F65EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FE21422B7;
	Mon, 25 Mar 2024 16:39:40 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6113D51C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384780; cv=none; b=MvM+0kENlTyNLyB2k09wEKEV90ds6YKFHn8+9uDiJyn1SHTn8Kfs8dFDX2Kzh/W7rLL7wT+POGh1CmOJEhOVD3E+/D1juiNuDX7rWqkVU11rCsZCWdVqdFdiJgiu7kKJTOznrzp8UIYN+3SexasIzWaoaMd5uDhbUFLEOeg9RSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384780; c=relaxed/simple;
	bh=NBQoREtiEUBmKNw02sG4gclsFgAU8fZ+QRNJuscIipM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3FtEEbswJWdK+qw0bpnVtuD1R/TdiUhXb29XW2sU+q/jL/oVvNVVDST2jNbWjF0j1A/Xpnkd7ypIpNSDr6gE6Ssk9rXjqyYb9Drsa8ptNccXJ+omIbF+abgCM2ITq0+tz8xdyhOqZFieERlGM9bpS+KDXt4Th3fiudCxsC2+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4148c607f31so2077435e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384777; x=1711989577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9m0SyyYCsLlNalZH2dIzOESp0Bcn7Q/hayzCxRbDd2Y=;
        b=DzfzlDxFY+DhIiURyF44efXQbJf0+TrCVyQIPhvsBc+R1nct9wPyGqk0hxRCBxJ1hU
         kOJoTw8z/ybkkJ+Or2K8HUUNjs5wGw4Zz3HPh2yevTRswgpp/DEbCCM8q5Yw5z504jle
         oQcqGWVzN+A+afoSO7MNFr7jki/6cBA6kqCVfpq4iPM/SZ75VkUs02e3Oku/DOQhcwjb
         aMSerirIO0K/NWGNast9EaIRyPdO/TIKulW9y2S/iWu0ODI0EXZjKpeZl+YUJFn9zmU4
         7RdJczGjajQCY1K1epWMrxWODDfxT3m8qH4J+koLcvSSVrmNeaIXmWnrJ0Y1ogxzObbV
         QUFw==
X-Forwarded-Encrypted: i=1; AJvYcCXczU130C3n3H6vibfH5pa+yznYWn4EgeehIJv6zdiHGuclHhffWTVmojb1i2saackb+7qyGIsvxa2sjnKxEpufRrOrgnmlWuI7KwvE
X-Gm-Message-State: AOJu0YwbSd+PxMZg804VnBYXZ0V1iS5puft/uFhunMCn3gynLquRx+D5
	6tejtM06c55LC8bpwjRPeu7VbtI4fg4rXl4oCZr8S37i/aTDH64O
X-Google-Smtp-Source: AGHT+IGTh9czdktHrja2649D11zmTOpdfYc12T/xNGt7U4utapNSuxeRCdCELYyRYFfM6zPIU8S1vA==
X-Received: by 2002:a05:600c:2201:b0:414:71b2:73c4 with SMTP id z1-20020a05600c220100b0041471b273c4mr6113308wml.12.1711384777272;
        Mon, 25 Mar 2024 09:39:37 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:199:77f6:a8ab:cda7:7ac6:c85c])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b0033e756ed840sm9898238wrb.47.2024.03.25.09.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:39:36 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] cpu/hotplug: Fix typo in comment
Date: Mon, 25 Mar 2024 18:38:10 +0200
Message-ID: <20240325163810.669459-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 include/linux/cpuhotplug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 35e78ddb2b37..667adc31d3ad 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -27,7 +27,7 @@
  * startup callbacks sequentially from CPUHP_OFFLINE + 1 to CPUHP_ONLINE
  * during a CPU online operation. During a CPU offline operation the
  * installed teardown callbacks are invoked in the reverse order from
- * CPU_ONLINE - 1 down to CPUHP_OFFLINE.
+ * CPUHP_ONLINE - 1 down to CPUHP_OFFLINE.
  *
  * The state space has three sections: PREPARE, STARTING and ONLINE.
  *
-- 
2.43.0


