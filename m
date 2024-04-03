Return-Path: <linux-kernel+bounces-130750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D555897CB4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B41B2AEFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA0915531D;
	Wed,  3 Apr 2024 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="snW0wFie"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB7139D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712188112; cv=none; b=ttDFJkdYJ7c3BrQ9Sdk7u19/tWmjEqad/NO22wr26ySB8/1ROWXzkXolmHf7daTwQqzZfCFVp8VIxKyO6htlWS8ew2xlpN7pjLYPqoV0cUup4lof2x0A2jwbB/B0ezToZu6h4mV2zZL6nZlw7Z1yyODVGfha1h7jBA8pz67QV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712188112; c=relaxed/simple;
	bh=whGfHs27slueugGyED6fbvzc6tFJFZGWIsW0JD5Q82k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fF6zc0kAGaVyxt9OvBXpeb3Gc5pjMka9gTYoklunt3M2BZCKrUsLQjvEhqXHYTiFLwMexnPa9wolNsXYpV/jWL0ZGi7M9BaD9pNSYS5qWuZHF7V9+VQsECBdIHFxy9foTb6MNNf1KP4Z1FX+jHr4HcTM61+pPOiDZGm7CG0ECVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=snW0wFie; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4644bde1d4so54914266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 16:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712188108; x=1712792908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EQVBORnWDSoSM/9COY0BSXBaL72d0LXDp6zNT3sTSJo=;
        b=snW0wFiebLzhsTxh5fipDby85/SIs8Oq6ThdRKKVBV0P581LGe7S2vGkfnC+BCoTVj
         DPaOEQFyV3ahGqAORpXaVIMyGaIKx21eVQwVOkB2oltv1sv/r8pHW35CCWzGCtdBh9GO
         uzgO5thSRJqLGmwpFnTZRp5M2iuBT3nDSKOVqFp5LB1I2jXb6rXJMw20BN8xgbFgyOyW
         Jmd6cwYxJWODdXL/xgwt5HHc883vRGve75775a7zUjfCM8i0g08q9O42Ap5lnNuv+OO+
         nDaw1Hf5VzXm4EVfmft3VM0Uqmdo/zL4dZz2aKKdVADcpUC2eflJTX2X56gbJfgAW1pJ
         RAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712188108; x=1712792908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQVBORnWDSoSM/9COY0BSXBaL72d0LXDp6zNT3sTSJo=;
        b=vugJaMbTDXYMzGmHim2T7YwX3ygG6k8gafgLE2qCYmlbaDFmm4YuVj4jLT/+41GqWt
         jeuFnLOjEfI1xE9z8QZ2r6wswyjxCs01T8HnNmVL0b/YeibHBWK5J3sTacsAEsB5Kepq
         nnbfB0lJfcDhYUMEGq6VV3cfUIl9fWP4eS9DjCU0rlFQO3JWdEZC1JHFRFqNl7NRZuPj
         gg3w+AFHNn+TisG9Y72rsXKWlKq2aMEG2TH9lYJSrGp1kzxb+6kI3S/dh5zjs0HNTsWM
         5gByZSnUePBO2lKXfgWtChxxxRn85jVptK4vLBpThkxiGj4BUIeWBE0qLuGZ8RbA/yjo
         pCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUon1s8j6pGgUbZhWZ6j39HyGrnGcGR2lbi4w8cdT/Vyc0iHIOHAXNS/APHpbd9XnrOrdkFtBnh3Qn80BcFBH0Lkbo/d7gDmVhQw5yD
X-Gm-Message-State: AOJu0YziOx4Ttzu8GqOpuUJKgszkZK7RKkHKT3SVlVPKDeECD9fgG5LS
	EJcrzA+pW37jBhnjtG2tKvNRp69U04QFmUD+yEL+pFCHCDopkgsgeLIpWjXVfFQ=
X-Google-Smtp-Source: AGHT+IE9gvDh81ncmkcHiv2y5XpGL/ySRovrAP1rZ87z7XQgvFEbpbWpWCF+Uh76+Xa5zl5A2yyl3Q==
X-Received: by 2002:a17:907:2d8f:b0:a4e:2ad3:60ff with SMTP id gt15-20020a1709072d8f00b00a4e2ad360ffmr556549ejc.47.1712188108518;
        Wed, 03 Apr 2024 16:48:28 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id q17-20020a1709060e5100b00a4623030893sm8158308eji.126.2024.04.03.16.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:48:28 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] tty: xtensa/iss: Use umin() to fix Coccinelle warning
Date: Thu,  4 Apr 2024 01:47:30 +0200
Message-ID: <20240403234729.175168-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use unsigned size_t to improve len data type and umin() to fix the
following Coccinelle/coccicheck warning reported by minmax.cocci:

	WARNING opportunity for min()

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/xtensa/platforms/iss/console.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 8896e691c051..b493fc50933d 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -167,8 +167,9 @@ late_initcall(rs_init);
 static void iss_console_write(struct console *co, const char *s, unsigned count)
 {
 	if (s && *s != 0) {
-		int len = strlen(s);
-		simc_write(1, s, count < len ? count : len);
+		size_t len = strlen(s);
+
+		simc_write(1, s, umin(count, len));
 	}
 }
 
-- 
2.44.0


