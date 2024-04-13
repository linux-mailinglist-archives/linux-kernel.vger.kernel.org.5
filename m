Return-Path: <linux-kernel+bounces-143737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9239D8A3CD6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B7A1C20BBD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0908841A85;
	Sat, 13 Apr 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia918xRM"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990D10957;
	Sat, 13 Apr 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713015550; cv=none; b=DFFpcFBzU0zFA2RHkFr3nCEWQKu9853YfcoU4+IqGSGc/A/1JdTsYC1QGq1HpJ+S/5P9fAP7Q7O4K8KIFel0zO7mcPWIrHE0WhNHSeenootmJSE++CQF4fNemDAWEvgtxt3HbOi0T8AwMp3kTl2H0Bho3riMku4aHLq75op6CwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713015550; c=relaxed/simple;
	bh=Ze1xfZIN6wNw7JmEjgb1dfY6gmHTcJJ8WoYhj7Njx9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bAKREMM5t1iQvFElNWCv9oIQe6Ct40Rb8uRP6D4VadQHpy8UAhCxgjJTdoXunspO2cOraAdEPRGj5NWPl6rO83BOzazMZ+w9leYw04vVp3UTBeemph73r5GIl90tuLhVsNXx0io0uPFyXdBG8YDhbW68CB7K0gBeDeOx3aY4vtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia918xRM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso1733507b3a.1;
        Sat, 13 Apr 2024 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713015548; x=1713620348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6tiY+FBmLxyUYa2kT0SSPstEkuWdpReq4oHjrUPWvw=;
        b=Ia918xRMYXXudZ0SNpxjpQ+45/2VEFiYh7dzit2iUTgzyRA86meXc6Z80KNUWMa5M9
         lx0OXjRrg7Gyl5yH3QjJpXrJ6aNtTnMYhyU8/6DP8rX5oAcD1jCjRt+60SHmc5lEB3d8
         oHTVOSOcZRqy5IVIAElO5H+EtJNPuNDGBiP1vJ59r9iTz9lRmQpwlx1WEcUDprLnUunf
         xEQ5H2hKERgJMekN6eh0YcxfQDoA26ZUN6GsslGAiUwWg1WtlDzGq4/GifKsgiPxBSyM
         326ZlOLP8x0pMhW9p1YzItEhLfeKMv/k2cH0jBqTdYaV5bjoDDaJgJt3Hb0qwjRmZLXb
         68DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713015548; x=1713620348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6tiY+FBmLxyUYa2kT0SSPstEkuWdpReq4oHjrUPWvw=;
        b=TDUWG5NsjZsqBOd5uUSGOO1xXNt5o4fMlOcMI9wIVNlvl2Ju7D7MOi18LCeuXL8psk
         w7Cf1+jJ3Z+bxa8MXvQAChcAYqR/bp1l150lWPEypelzAgcBFeaZ2yhEnJ5ShmijGlJ4
         6mRU2J5aTaoQiq8HUY+VcrxOvdm6Ph7Uwf15Z/7HgUzBA0cDaADa/JKX1yNsUKjMFt0/
         EIro7Wtx0D+pjelVidwqWvBH8ua5689IdTRGT4L3yKCWzGCmqV5E++A5XLrBwDSSwNis
         PGTEkoEvu0KEqNETiwqyv9wpJVnsUyklLxcuXudlWBmFUtPGgJnST+74gQYcQmrwHSD8
         W4SA==
X-Forwarded-Encrypted: i=1; AJvYcCUO2D2JBfJaLZav/uA6iqPzAQ+Q9U81XPn6pFO4wFdLJ5H7d3WYQeMLUdX5MI2huxC4tA5sIJfjsgsv50ltHb/aixL0B1muEOLXwVhy
X-Gm-Message-State: AOJu0YyVUzBE0i9kjjJ8A3/e8mpFDhr8SwwDDyYjxRQRvCJjUnplNQZp
	eWPQVzzr2s3tE6S/MTFPDJEN/HOkVfT5OOOs5xWsZ6udmfCVU9bl/AStPA==
X-Google-Smtp-Source: AGHT+IGVyzG4d+yaQMN6r+ftpkS2WT7smP2By2FhhLa3VbK6wXiyo6YILDKTou4/mjaYsH02VuztGA==
X-Received: by 2002:a17:90b:11c9:b0:2a5:3aa6:caf6 with SMTP id gv9-20020a17090b11c900b002a53aa6caf6mr7386353pjb.6.1713015548313;
        Sat, 13 Apr 2024 06:39:08 -0700 (PDT)
Received: from galileo.. ([133.106.194.83])
        by smtp.googlemail.com with ESMTPSA id l9-20020a17090a070900b002a63c29d3c8sm4630136pjl.41.2024.04.13.06.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 06:39:07 -0700 (PDT)
From: tskd08@gmail.com
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	linux-kernel@vger.kernel.org,
	Akihiro Tsukada <tskd08@gmail.com>
Subject: [PATCH] v4l-utils/contrib/gconv: fix conversion errors on ARIB-STD-B24 strings
Date: Sat, 13 Apr 2024 22:36:01 +0900
Message-ID: <20240413133601.66531-1-tskd08@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akihiro Tsukada <tskd08@gmail.com>

Some ARIB strings in operation requires that
codepoints from the 'extra symbols' charset fallback to 'kanji'.
Remove the range check for 'extra symbols' to accept those strings.

Signed-off-by: Akihiro Tsukada <tskd08@gmail.com>
---
 contrib/gconv/arib-std-b24.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/gconv/arib-std-b24.c b/contrib/gconv/arib-std-b24.c
index 6a2e6292..18f06283 100644
--- a/contrib/gconv/arib-std-b24.c
+++ b/contrib/gconv/arib-std-b24.c
@@ -494,8 +494,10 @@ b24_char_conv (int set, unsigned char c1, unsigned char c2, uint32_t *out)
 
 	    return 1;
 	  }
-	if (set == EXTRA_SYMBOLS_set)
-	  return 0;
+	/* Some ARIB strings somehow require that
+	 * EXTRA_SYMBOLS codepoints fallback to KANJI_set.
+	 * so just fall through here.
+	 */
 
 	/* non-JISX0213 modification. (combining chars) */
 	if (c1 == 0x22 && c2 == 0x7e)
-- 
2.44.0


