Return-Path: <linux-kernel+bounces-165045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0881E8B8704
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD609281D06
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BF150292;
	Wed,  1 May 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekMQ6Sr7"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7DB39FFB;
	Wed,  1 May 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552901; cv=none; b=UN3iB1qNzZL1b59XdaLRWcD5WKeAZUTuoKW6ymjEIoHFybcHKXlPn/CwdBh9A0tS5BK6lykPzIxS2dp0MwmF46UNIRqYG0CuqeKqH0IeqkReg/qwjefvys9RH/UbnF0qmjhJKsBi2kbCwHm8CpFgOMk1Zb3BbeAsBtU5qgZ3tsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552901; c=relaxed/simple;
	bh=1rBxLhkgeuavduZH//Lz0Tf/8rm0k3X7h/lFl7E10qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5AnS9qeJVgQ/Fkn17BrMWetlg7u9G2r3u+LYBEAPOZWQ/kr4nQFzBM1obe+Pd6R4tBU6CJ8LPm9N0s3puWgWvkbyc7KF5fKT20704iDJWgLhRZr7qTk3QMSmj6N+fPYZPAM8MFEELvAR0yvl1B90d75oy1+Jqp8npOtLrHPbtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekMQ6Sr7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso5765088b3a.1;
        Wed, 01 May 2024 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714552899; x=1715157699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk32MppqLYyzvvpjGhxvJDk9rGDas0edOjH8vlcv3TM=;
        b=ekMQ6Sr7LJXqyMSkR8ThCXXoLixwrX01Ue3B4+GmfwaNHrsF/YOhRxNP796gJRqx06
         LTu4pcddaVisuvbW6aR2HEOFGrlaBOdAp/PbB2FLvzSlIFuddZlR/8C405QF9JLCvCaP
         aDVGABdPRgw7tg5Op+IFmhSjLw3ma5byzNWj9nHvcbRkUjrClOVTvOmgzYCSz0Rbi1Hv
         zfhcWeM+rpstT42jInQg8iA+jduFQ5SrB6CdbbQrAkkvbiIaCQxv6FjlPg7YcfInsv2Z
         1DpP19FszTP/ELF9CjkmN66YnKY8wIP7hCwbmb19xTllKKnl/qgcgJPh2Mub7TbEx+vt
         yPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714552899; x=1715157699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nk32MppqLYyzvvpjGhxvJDk9rGDas0edOjH8vlcv3TM=;
        b=kPQfx8FdFFzzBo12X7JETOFmd4oYzaDnwfFMUeh72UV0Dk1FzPbbhezabvbL+ME8ON
         wiTA0OCnnAqkV+n/+uL4O5Rueeb1CI6ilq2KbTABfieyTdZutOX+UXiPvM8gpqHlJQnc
         GRmoqR0t7422ti6KzZGXWUqpZwqQhQkfgeOONWsxr5hi//Fo4uyAMPkeVZoB0OTOWwjF
         KEtmfzvGOzpPeoUD8H4TuSlv/FBXLNH1+wRJVSc04krS73XFpvfRmliB1y6D+hhj078F
         +nRQJ0eitKP655ohX58mQXGhVDXcMdaRVc8ir1jZkn07OwcTfBv8sI3ueFwKwdzB+cg/
         aeeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZbFTRK9BaBYdv+TZ/W4Ie2F3xdB0DhBmBEB10CDWvi9r5PQuYzbxdAFRPbm47sWOlQlN0fLws4oi4Hn0A0tIIYpOIxvIM0pVsz72ud1RpkbZ+TjWdwOYnhjx8eofuBb72Qpn2r7/O7E+p
X-Gm-Message-State: AOJu0YwEA6McAjwyBzWGMuVM9TC/scN+LC5OLNK5hYf1lMgPJtuSroQ2
	C6M96iXtVMUU9yyqhAfDznYho2vUn+YFi4Qh9IS/tnn+FzyQhe3U
X-Google-Smtp-Source: AGHT+IFdMgsivwUAwFkQnIOUgQV65FC8VM+NDSAIMsU5iviWctfVG1fGtAfk/j8w5WdwVR5ohOw/Xg==
X-Received: by 2002:a05:6a21:788a:b0:1a7:bb6d:6589 with SMTP id bf10-20020a056a21788a00b001a7bb6d6589mr1745740pzc.29.1714552898848;
        Wed, 01 May 2024 01:41:38 -0700 (PDT)
Received: from shresth-aspirea71576g.abesec.ac.in ([139.5.197.146])
        by smtp.gmail.com with ESMTPSA id li6-20020a17090b48c600b002b0dea23239sm878052pjb.49.2024.05.01.01.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 01:41:38 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v2][next] tty: sunsu: Simplify device_node cleanup by using __free
Date: Wed,  1 May 2024 14:11:11 +0530
Message-ID: <20240501084110.4165-2-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add `__free` function attribute to `ap` and `match` pointer
initialisations which ensure that the pointers are freed as soon as they
go out of scope, thus removing the need to manually free them using
`of_node_put`.

This also removes the need for the `goto` statement and the `rc`
variable.

Tested using a qemu x86_64 virtual machine.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
Changes in v2:
    - Specify how the patch was tested

 drivers/tty/serial/sunsu.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 67a5fc70bb4b..0f463da5e7ce 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1382,44 +1382,29 @@ static inline struct console *SUNSU_CONSOLE(void)
 
 static enum su_type su_get_type(struct device_node *dp)
 {
-	struct device_node *ap = of_find_node_by_path("/aliases");
-	enum su_type rc = SU_PORT_PORT;
+	struct device_node *ap __free(device_node) =
+			    of_find_node_by_path("/aliases");
 
 	if (ap) {
 		const char *keyb = of_get_property(ap, "keyboard", NULL);
 		const char *ms = of_get_property(ap, "mouse", NULL);
-		struct device_node *match;
 
 		if (keyb) {
-			match = of_find_node_by_path(keyb);
+			struct device_node *match __free(device_node) =
+					    of_find_node_by_path(keyb);
 
-			/*
-			 * The pointer is used as an identifier not
-			 * as a pointer, we can drop the refcount on
-			 * the of__node immediately after getting it.
-			 */
-			of_node_put(match);
-
-			if (dp == match) {
-				rc = SU_PORT_KBD;
-				goto out;
-			}
+			if (dp == match)
+				return SU_PORT_KBD;
 		}
 		if (ms) {
-			match = of_find_node_by_path(ms);
+			struct device_node *match __free(device_node) =
+					    of_find_node_by_path(ms);
 
-			of_node_put(match);
-
-			if (dp == match) {
-				rc = SU_PORT_MS;
-				goto out;
-			}
+			if (dp == match)
+				return SU_PORT_MS;
 		}
 	}
-
-out:
-	of_node_put(ap);
-	return rc;
+	return SU_PORT_PORT;
 }
 
 static int su_probe(struct platform_device *op)
-- 
2.44.0


