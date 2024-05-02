Return-Path: <linux-kernel+bounces-167067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA48BA400
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9357C2816CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641F4433CF;
	Thu,  2 May 2024 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0e+nUee"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8E4AEE0
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692738; cv=none; b=UqirBTztmJy3INMhtJz6W2PJWLZjgQopEJi32sI9i8ZzC1ApSShEbryk2W8nJ0EyuAT7czPq5N/s6Gjln64tLNn3ekZRJDVeytsLRqn53j1X0312tgNE/8+Vp7zaVDJu1uvItnLElv/MmWpsJhBGGViUXxaQKVt2dYPtz1++dy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692738; c=relaxed/simple;
	bh=vGxye/FU6337p1UzT7aFBq/KUA2R8rfM3m6vHhGjdT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXdk2kqpw5uimH9OKoXoDSdpVEaN2pCDzqfIrCm81e1Rq3dmJ9S89q0NPwQSJIdvIizshGlmaIYFTFJVjDrTfGBFEk4KiM01iGoi/lD6ehPBZe1iG7OGgokTb0FKZKCQjrXwOD1uD8jFk5Inmfo5uPe6nPbAIbB5clR1ieNg7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0e+nUee; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61e01d5ea74so22828167b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714692736; x=1715297536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EMydeMYAoD8bLiiOASQ2pN3/O7edcAgllopuW/8Dwk=;
        b=f0e+nUeeDVoWGpV9kXreQFIS46ksrNKtVYOXF/0INPwG8VAIRa8ceItCY0Ld7ZS21H
         pgmNB/8c0mebyO61m8L9DJhUXUf9pv/LEDOm15nxwIlUOQAvkUf707H860P0DLU71To+
         g1h1hvTDSGxqrBs0zbryXFzKllG1hMzRq4wp89fnK2d+gwjjpnxny8jcQyaxbqXv+KLn
         PbBqsZOZ/ogkEci1Poj+SxKW+ThPxgm7PKKRyNmQ8FhgsKm6rrEmU89emlKtwX6+ay3F
         yfkaI+nGSM6khBrqm/Jjs+al4KhniQaLqdCtlNderuBV8mL8GG2WWbrhbnNagL1AM1qR
         QAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692736; x=1715297536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EMydeMYAoD8bLiiOASQ2pN3/O7edcAgllopuW/8Dwk=;
        b=L5RXTiokM9pR6hMbFld4Jt3yWOchFL8DIF5rTxPtqcnj0UgEjxNhKwqNxzE6O33Vdp
         Df+Yoc/25RuV2GugmjNG/a1reKjviLdSp0oXQf4TTSXs144Rv8BRjWUQJ6D6qAjOhe27
         GyAS1WW10gEANLGELNN7a9Jb/hVvyZei8Nnda/qzyXnG9ASoIQ5ZyMYfoOERYQrgomgF
         tiihBdpNQaAT+al1xLDSfxaYA1a0VVqpBcRI4uW8lAUEU+ZYe+F28sj2NI/WpUVe05SY
         lFhAq3AkPcgd56Lv/ccaxf9dQ3Q07XCudbqjsPqaiaymPul0ME24oWq6+pMabQSiCn93
         +m2Q==
X-Gm-Message-State: AOJu0YwrLHf6g+Lu15oKaZRgFtqd+XV3o3ojAzgpChjziTIL7fLxRIoK
	YXhz7YwXMsx4gqbV7gCNiQFBbF4UTSZUBKHr+XzGWraSZBBwmHnlr9Aj5Q==
X-Google-Smtp-Source: AGHT+IErSjtSElCwfJ4YRpT9SrZC2anGphCNOMBDxAltaBhPPmPCh7iSjcPAOwt3nq5wjcgBaCVFlQ==
X-Received: by 2002:a0d:e2d2:0:b0:61a:ced3:2574 with SMTP id l201-20020a0de2d2000000b0061aced32574mr1071205ywe.13.1714692736209;
        Thu, 02 May 2024 16:32:16 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id ck25-20020a05690c0b9900b0061ad5c52d23sm412698ywb.69.2024.05.02.16.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 16:32:15 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 4/4] MAINTAINERS: add BITOPS API record
Date: Thu,  2 May 2024 16:32:04 -0700
Message-Id: <20240502233204.2255158-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240502233204.2255158-1-yury.norov@gmail.com>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bitops API is the very basic, and it's widely used by the kernel. But
corresponding files are not maintained.

Bitmaps actively use bit operations, and big share of bitops material
already moves through the bitmap branch.

I would like to take a closer look to bitops.

This patch creates a BITOPS API record in the MAINTAINERS, and adds
Rasmus as a reviewer, and myself as a maintainer of those files.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c23fda1aa1f0..0cfd2c5d9086 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3638,6 +3638,20 @@ F:	tools/include/vdso/bits.h
 F:	tools/lib/bitmap.c
 F:	tools/lib/find_bit.c
 
+BITOPS API
+M:	Yury Norov <yury.norov@gmail.com>
+R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
+S:	Maintained
+F:	arch/*/include/asm/bitops.h
+F:	arch/*/include/asm/bitops_32.h
+F:	arch/*/include/asm/bitops_64.h
+F:	arch/*/lib/bitops.c
+F:	include/asm-generic/bitops
+F:	include/asm-generic/bitops.h
+F:	include/linux/bitops.h
+F:	lib/test_bitops.c
+F:	tools/*/bitops*
+
 BLINKM RGB LED DRIVER
 M:	Jan-Simon Moeller <jansimon.moeller@gmx.de>
 S:	Maintained
-- 
2.40.1


