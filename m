Return-Path: <linux-kernel+bounces-136683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F1089D70E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55B91F22163
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD03D80629;
	Tue,  9 Apr 2024 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Rz++QTeE"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1886FE35
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658912; cv=none; b=as/MPnJxawn1ObX/6aCMvUpIfghFAtMZaIxmu8pFb3ApGH6+5AP291ilnoHdvPa5u6IE4Nn3ubTvB6rzFNI8lkEngOXRaI2j4BRkJTc2uuk1MUJLpoGd6KcioOmubA0GeKC2QDJWJgH6oD1N5xxt63qIu8lARAmVyPEJeFWhr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658912; c=relaxed/simple;
	bh=1AHrXbIZ3eGQQR47I0qE8KEMGPbucn2qvMQSr69WzXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DvH4O5ldnfuH8UtzgxzkRLYB+tjXN0MBVNl1mR1+mU2sYEJrH6N0B5a2WN7L9RUgXiT4tpdm9CVW+kgEJpLrFYfqCWspRVvn7E3RA2MDk+g+PxoShIhY6tON/Hd4xj70ACHpVJmQHctUoJpiV9WX3+UC+2AmH+AU09tkacNi6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Rz++QTeE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a51a1c8d931so482961066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712658908; x=1713263708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtYVHN7iPlZaeHuaYSOGLo5JJa2pbdnexsUotoq1x28=;
        b=Rz++QTeE0vUoRsCBBv64iElqiMJx0ermxGPKf+uCzpXijMQXgwPAwyVQ5Hal5H/D1I
         Fhmvxz/7J5XG5iE1w5DcWMksEecA1ogk4eg1yfVAP/RxMNiY1NMID6vmVZoErIKGenrn
         gUtcUhG/O0//qwa0N6Ks5zsPq4VSQJ6Z8jmP7QuIaG5l/kBdwRILxzgnJY3RT/OKPEiB
         xKRffs1slpKurTdRZIK6rEzyXFg9eoOaxjjz+sMa68eSSzKdvZKC8tQTrR7ClL/yGWNc
         L349e7UH1TzfvyXIGnVHVuGrtYOKvNKZYqTWZLp0aQLxpymME9bA9jDp/c54pg8I/rgI
         HZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712658908; x=1713263708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtYVHN7iPlZaeHuaYSOGLo5JJa2pbdnexsUotoq1x28=;
        b=OR0DRTWoP2AZiA+Wy7JzvQxpJaoZJWnlpHtXkiLtr9J7mm9MFSb/DkD0UQTrV3CAAS
         aOFys+lGMpkg6yA0zQHD1hy9Cr9VitGz167t16e9iYFBPfV3FXJ1Lah3RKk66pPbJAdN
         zhYL7J4gLSFqaRKC6SfHsy7UBKkM5APUct5YvP8kfBPG5FvqInjyU/pJEpG/KB1MUTmJ
         LLcEXgC6bR/3s68STHCJSkACxmfZBEnLScvxqMt5leb/1CdRm1A/jfB3OceBOFNwz1sP
         AWPrlgTt5R1+u6HXn1sl7viEPjBd2GgXbov1KFObUoumYJGo1AZS9BIXjZ+GEN6VIZtx
         aDwQ==
X-Gm-Message-State: AOJu0Yy5hqVfQO5NU67lGtG0s4VCFooNpkO0Wz8ScvSSTkvHD4mQ07wI
	KwxdoESPvX94DKiy/t0YyrW3LhBMLXhzIgSzeDGIfEVJ5REHg68UdjGwDAxFCdw=
X-Google-Smtp-Source: AGHT+IEPU/tRTIXzOBmObS4jAZfLz7xPbAoVVG7G1adP2HccyRh9T7Wb1nKjtFgUBWo4XYI9T9pcew==
X-Received: by 2002:a17:907:d8a:b0:a51:ce92:1e1b with SMTP id go10-20020a1709070d8a00b00a51ce921e1bmr5577555ejc.72.1712658907862;
        Tue, 09 Apr 2024 03:35:07 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id q19-20020a1709060f9300b00a51983e6190sm5484590ejj.205.2024.04.09.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:35:07 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Michal Simek <monstr@monstr.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] microblaze: Improve data type of return variable
Date: Tue,  9 Apr 2024 12:31:49 +0200
Message-ID: <20240409103144.175377-6-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since restore_sigcontext() returns an int and err is its return variable,
which can be negative, it should be of type int instead of unsigned int.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/microblaze/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index c78a0ff48066..51f718a42e2c 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -57,7 +57,7 @@ struct rt_sigframe {
 static int restore_sigcontext(struct pt_regs *regs,
 				struct sigcontext __user *sc, int *rval_p)
 {
-	unsigned int err = 0;
+	int err = 0;
 
 #define COPY(x)		{err |= __get_user(regs->x, &sc->regs.x); }
 	COPY(r0);
-- 
2.44.0


