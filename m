Return-Path: <linux-kernel+bounces-149172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CE48A8CCB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833C1281698
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E71374D2;
	Wed, 17 Apr 2024 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M60UwMkl"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640A381BA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384702; cv=none; b=lIBGIJjiVw5maSaMiS0nlUC1HjwqQOR2yPW6IpGjpU391xW/IjqqihFLoafyGgEEg2kM1HZ3Kmh4P2rXGW7pg1AeKfAqa0GFbuYMNLI0wFCji2eZYISbAMyRIYzvYMb2OrdsXquxD0o6arzKgwNryRJ2Oafa7R/mZiAE3hGeK1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384702; c=relaxed/simple;
	bh=UxcBn5qTWOKxcALlk6iE/TRzUBJWa3dvUXVgi2A57Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ro/JCJ8hhfKKsMD+x2DI794/a7h1Ukp361S0JP7suR7l70O5Pt2EB4XagdaCMJrJ5dS0RSsFX46C4Wz4e0JYXF6GM+BEQ+M0aS2LgfUuqmCH9WIVTZb77waydOczX88Hb0UCfjcKX//3o9lZbJgosWbV4jZBdzB4Qb/GqopgS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M60UwMkl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so109724f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713384699; x=1713989499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZKIGJkS/DiIjyP+xZB0kivHqw9/JhVCgwEUHJq+58E=;
        b=M60UwMklStZuAAqnU6lEeY3M3oY7wF6/SqHGAAQkTEPHHD34N2GZE3Vt4BWOcLW1OY
         5uQ1M/xAQ7L2IABjn7/JitTpmqMytCIz4c2IGwW2ukvgTVwCdApnNvrDijlSbbZBa9K7
         88hv/xVLcpzGfABfP8+88CP7dbaVNTdKOOgrelCy8c2ZIBkhiFbhCnPLnU4//2Ve2S80
         Lp8cFVNjc684bXO4DaQe4r/Bk2Bm1q1K7ORQ2I/i4TZTV1FgIJZw9+iEOME6GSyt3Jb3
         a1rgYeyAaMK5NTqTbaMORRyovKF0+n8/1Jh7I1bt9Ne5DTMOJSnpTjYnc4Ix8H4g5cdb
         kFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384699; x=1713989499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZKIGJkS/DiIjyP+xZB0kivHqw9/JhVCgwEUHJq+58E=;
        b=hA3klp2QHtiICCZmTkzaPn1ZxUwRiDbzge37jjzXOWlUOQyGaufPJDrpoypMioMFBC
         Kw7URbv4g7Zb5YlSjzDpxCGB9+TO7iSaViXSBY1afbIhAu1+zXePANzDBFxEJ3SFVfmB
         xD7pf/iwG1olTs4hSQVZ4QsFcQGTDTzIlwPYUA21Q9HWVhGRzlFQl6G6rMcnr3kz1WYa
         /2somNUO/HkDSIVcpXmhNp1jizTIZqaUkeA1xw/5oubtlN1yjcGSbpPDqlMRxOEKPwpZ
         ay8g4jywIyvsA9gDvl9nS/rRJ1GZ8HdOk0EjE8eCq0h290I/IVKvjU565oyl/psGWZCh
         wnXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfiyquR78SYhxzCRr8KbIRlAmsNa/0JXiJ3xh14qd3qzBhOQ1fdgXD6K39938QLX4dLQb4rqL+zSLiO6UwxyJaS8WjW0NqPNGzc8n8
X-Gm-Message-State: AOJu0YyZLvdBRT/Qb+DGy4l69+YchhAuqxY4AthruF9feYirwt+/h02C
	NVrbqtk4a127SYdXqMBEkazZKJ6rBfMX4nuz/cxOlCDnzDQT5wo=
X-Google-Smtp-Source: AGHT+IGh0r932xxvbereGODL++VtGHYsFzZ3frQ+BoivFAe5oQIahlNuPTlJX+AJ0x5Fw/RcZSanOg==
X-Received: by 2002:adf:f041:0:b0:349:92b7:c248 with SMTP id t1-20020adff041000000b0034992b7c248mr289867wro.29.1713384698885;
        Wed, 17 Apr 2024 13:11:38 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.238])
        by smtp.gmail.com with ESMTPSA id q4-20020adff504000000b0034635bd6ba5sm18179673wro.92.2024.04.17.13.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:11:38 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: adobriyan@gmail.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpumask: delete unused reset_cpu_possible_mask()
Date: Wed, 17 Apr 2024 23:11:23 +0300
Message-ID: <20240417201123.2961-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 include/linux/cpumask.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1c29947db848..04536a29f10f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1017,11 +1017,6 @@ void init_cpu_present(const struct cpumask *src);
 void init_cpu_possible(const struct cpumask *src);
 void init_cpu_online(const struct cpumask *src);
 
-static inline void reset_cpu_possible_mask(void)
-{
-	bitmap_zero(cpumask_bits(&__cpu_possible_mask), NR_CPUS);
-}
-
 static inline void
 set_cpu_possible(unsigned int cpu, bool possible)
 {
-- 
2.43.2


