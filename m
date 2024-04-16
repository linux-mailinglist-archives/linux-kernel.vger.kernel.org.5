Return-Path: <linux-kernel+bounces-146783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD88A6ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2671AB20C94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B608F12B142;
	Tue, 16 Apr 2024 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="L+65zD8I"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322E12AADC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713270153; cv=none; b=PYH+tWWOGitzYwkRGdKlqGfq+PJG7HGVAFCI18CVFxXo2apfyRQRcUnFdZjYQNO+Wxr3dycsWH6oHU26sO/HA4VoBP5exQs+y9akGxrpZ064vAcVB6K19PeykjWTsURwP+/lnKH1TlVxONI1SNsQSEKWLY87lUqBmKoPNt+2qSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713270153; c=relaxed/simple;
	bh=K7xhnvZpmdN2MuOixIDWglSN3H8jS49clJFrbDjMbxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+sAggEGSuCBrRoVJoriFJt09fLlSys7bcu9RnsCKrrwr9UhKO1JgMMyblsU3KgiBuTEv9oXjJ91JeS9jds9Vh5+p8fyrZgIvUl5v/ynJl6cRB0cTPUPv1Nszmoj/zP2/TEbq4wMGGvuYA6n5W9KzZbwNfHcksC0xwwRmuq5nW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=L+65zD8I; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5269c3f9c7so273576366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713270151; x=1713874951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DvoNQ5luSTO7Ksur3Peu5AAvJo33qeP0AozWIJMD134=;
        b=L+65zD8IdKzuZfy+u8xzlxIY74/ItY3Gj6bkDLWExcPvEvl2JAYYG7IHs/HyZfeG1n
         i20sifi0iPznH5mhIpzC4Qy0/nTEnr0FgqzHFNzOw90MWTinrISYzmS0VwdETWJOmimW
         M07fA+79E1/D1PJ5dc41WrEm38Hm4Hf388vd63iNK9uNzeNgDE3PB1vLFwQn9JU6u9c8
         g++qAN0s+Ekh/ABsb4eHQfI/oT7YOwQoNYCx/JvIWqeHx5TkhCEGO9whRs5T41YoUCYZ
         rLbGykMh2GDxDoUovrP0VUKkmaxKyoW2eLXd1ezNy1tfEAA9tBEJwtyyMjcm57sA5UbJ
         pTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713270151; x=1713874951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvoNQ5luSTO7Ksur3Peu5AAvJo33qeP0AozWIJMD134=;
        b=mQAx7Mu2AoWdserV5O5/TQCnY2TVLpGLzi57LK56utKsqXd+OofOun4dU2me6mHFHM
         9qg4H/DrCjnHOIwoXgFVouKHmCFai3W7cpvB433j/SqZwzPlNyy54DnKwwMImKaElMdv
         4b90e5WHu0Hen6Mj41fz1x0dFl17aVa0mBJ+m1QBMPEP4TlqApY8AqNTMPLkGHN12BG3
         pOTKKo8fCRbZaMVrWQ7Cw6gxJQ4jwCx/4SAsj0LFiLAgGPVaJvvN0NWyuVQ1yBb/6Oer
         xaPHcv5PY2Sl4V5eoloHSqgwUcV4FlFCvypCbvb8PyqD+soPxsQVNZk35t7mdOIprK0Q
         T6aA==
X-Forwarded-Encrypted: i=1; AJvYcCWvwA3SJOvxQNg04A9OgS0xOR88/du+U7Hs2i96zeUhPm2kAZegFoCC2CFB820KfjkRtvc0BT2G9/WfuB+nz07ooUUMrClXM5/oPoqH
X-Gm-Message-State: AOJu0YzAE/ItJ/FZQP1XOmQQYledCj2X/pQn6YpX3YPJUfhyIa5SjZ+r
	TvSIJl/0IHdIGzzUjU5xCn9ZLjnyvTzfvajxnG5NhihzpBL6t3K6fkfvwdbJs/4=
X-Google-Smtp-Source: AGHT+IFXMK2JgeE2MzQKKtGuebiKjEBxheRz9qFC8MlOFHALwKnDL20B8xRND/c8fnSFs9gVkB4DNQ==
X-Received: by 2002:a17:907:5c1:b0:a52:2d83:1483 with SMTP id wg1-20020a17090705c100b00a522d831483mr9724208ejb.53.1713270150620;
        Tue, 16 Apr 2024 05:22:30 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id bm23-20020a170906c05700b00a52331dc082sm5844162ejb.11.2024.04.16.05.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:22:30 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] m68k: bitops: Fix typo in comment
Date: Tue, 16 Apr 2024 14:21:56 +0200
Message-ID: <20240416122155.313400-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/Coldfire/ColdFire/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/m68k/include/asm/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 14c64a6f1217..621533b3858e 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -482,7 +482,7 @@ static inline unsigned long ffz(unsigned long word)
 
 /*
  *	The newer ColdFire family members support a "bitrev" instruction
- *	and we can use that to implement a fast ffs. Older Coldfire parts,
+ *	and we can use that to implement a fast ffs. Older ColdFire parts,
  *	and normal 68000 parts don't have anything special, so we use the
  *	generic functions for those.
  */
-- 
2.44.0


