Return-Path: <linux-kernel+bounces-139736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C3D8A06FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E75D1F23C49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392EE13BC11;
	Thu, 11 Apr 2024 04:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G64B+6+4"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA972A1DC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712808829; cv=none; b=DaKMTiOfnxdS5IRhbI6sFcksPPU5xDqS6f5jpICkJRWaUzHdyjYW943ej/Ooy0JTzq8D+0fK2hMe8H9jrt94c+4jF1X7myQabBmEw9+SSgiZ6ar2K8TE8gihCpdxJxj8wSPJo2ajhwcafkZ9/F3DYYmOKkqmRlJBi+B/vGyEF8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712808829; c=relaxed/simple;
	bh=MdLimc1VVEIqkpf1byy4oeqotrbg+umpLQZtbXLrUWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vo7Qon/RedLsvrqN1kd/SyCz3Nq1/PpCeqt/KluwOx37nHMbSrTlKey2rq2ODaMOrtw7x752NMDbg+JgJtppISBGHHrYMQNI+1rW42c28zaESa2w5NY4JRF5qzOlGlNmewPUveWxlHfYqMREsSI2gCiz3yiLWLS8JK4jU6I2Eq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G64B+6+4; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa2551d33dso2527395eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712808827; x=1713413627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYcmv2VvzI7+2d+qhmj/e0v1OMqNE1Xhk0SbGTMHKkw=;
        b=G64B+6+4g9aYxbxifNYqQUbQDiA/+B5gHYu9MFsO/lO7ppk4afMp+yJHede9Y7u4wK
         LR4dm/qBzEQC7zgjb+kMamnt2fEhLUDhcjlZun5hF1+vo40qnhzP0fJjnEF7oYmjSHeH
         m4+v86SwISNzi3Ys07zJWqt8RG7+FRlXNWLiP4sluoTrDv6AQ1YHbL5RclSVNsByRBGF
         8K4YiGygHEU17k/2y5zsFOs9L9kKun9Xgpq1p2jY3CFVIYRaGksdx3Un8U7VwC/Yeeu6
         HCAm0f0JzNTnnHrfeVqivJjVtHbmlc+9z61N9VsNhOggI60qEr3RbbSVIqnzERYiqk8N
         n9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712808827; x=1713413627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYcmv2VvzI7+2d+qhmj/e0v1OMqNE1Xhk0SbGTMHKkw=;
        b=N16sL1od1sGZbDtm+AsGYz1bDxGtHJ9u9A2K756cKytvKLsscaZeWg3zOjbpyUMd4q
         y1z5TCH3xRidkPZBL6u3Qil7yqkiJCAYX2fuDY5QrMdkuXxObt8AX80MYAW9/wjoaZih
         IfvZPLIVEcRyRQuOzxtfOj9bn3UWumzNjyLMQtZ6DWm8dPuI6jrCxhzQ93eM8HmoH8F1
         IpojDOGw4jWh/mVumLeBaDnJCsAaM6dvVYVxbZLdRtLfPiMZVXwxVeN4+7EMlk0piGQO
         yWc29GGydR9eWKij66GCJs1LB8YZ++FC91Y2qGgAzYgxXuvinLNlqt+l9vZAV4XhA0xU
         MBrw==
X-Gm-Message-State: AOJu0YxJqLqJAJtBse+aE2pTHUZBLAHpE8f+R3eJkJG3Z9R6PynQHrdi
	VuFu2L1pIgOcMplp6v0GU5NeCjN5AFvRsjCO23dLfXwKr9bKNfP/AwjZUr5r
X-Google-Smtp-Source: AGHT+IGF4uRsN0BsWobuNO5in8Zod9efmRLvt8e+R5OVTymNgpXeeSshIwpho+znYQjCmu3mRLUhyA==
X-Received: by 2002:a05:6359:4808:b0:186:2720:2122 with SMTP id oj8-20020a056359480800b0018627202122mr4728249rwb.2.1712808826927;
        Wed, 10 Apr 2024 21:13:46 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id h4-20020a654804000000b005dc4b562f6csm278589pgs.3.2024.04.10.21.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 21:13:46 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	Tejun Heo <tj@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krister Johansen <kjlx@templeofstupid.com>,
	Changbin Du <changbin.du@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] init/main.c: Remove redundant space from saved_command_line
Date: Thu, 11 Apr 2024 12:12:00 +0800
Message-ID: <20240411041200.225356-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extra_init_args ends with a space, so when concatenating extra_init_args
to saved_command_line, be sure to remove the extra space.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 init/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 2ca52474d0c3..cf2c22aa0e8c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -660,12 +660,14 @@ static void __init setup_command_line(char *command_line)
 			strcpy(saved_command_line + len, extra_init_args);
 			len += ilen - 4;	/* strlen(extra_init_args) */
 			strcpy(saved_command_line + len,
-				boot_command_line + initargs_offs - 1);
+				boot_command_line + initargs_offs);
 		} else {
 			len = strlen(saved_command_line);
 			strcpy(saved_command_line + len, " -- ");
 			len += 4;
 			strcpy(saved_command_line + len, extra_init_args);
+			len += ilen - 4; /* strlen(extra_init_args) */
+			saved_command_line[len-1] = '\0'; /* remove trailing space */
 		}
 	}
 
-- 
2.44.0


