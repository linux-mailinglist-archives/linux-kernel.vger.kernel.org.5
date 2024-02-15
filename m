Return-Path: <linux-kernel+bounces-66964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32195856424
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE85D1F2992C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB0912FF92;
	Thu, 15 Feb 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC/fPhSz"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48012CDBE;
	Thu, 15 Feb 2024 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002968; cv=none; b=bpqJnC2yMSdEgiyjKnQBHXl3PkevbfzIWOlma9zj2toIziNvj6S/9ViA100gTxcapS2j+1ne5paEb3kYacAgGKvke5YG/qL+ry2YX8+S6QfiX8na9RtA9jYUMpjxSSbpkRwnBaiL/DcntxqBK/WssqEfzsaV24Vvl3z4I1p427I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002968; c=relaxed/simple;
	bh=ZMcH2cl5HrhWXR1rAuN3t1R9ANzFaFtZb+vIKIdyJjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nyvCLuYYyZ6m+JK6mGi8wiGCppezcoVf69ND4nvVbjtkkh67XsqNbwIJfJwqTP38sjQQaXkw2o69qjSWDcoj5beCR5CMqf6tmH/gt6qUYtLw7nVtzBMa/4oJxCKipc68jcm5sHAgWvJ0Jdc3DSk/Zl76fpjNjhJfSmCJcdX0aYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC/fPhSz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-411e5f21c0bso7381605e9.0;
        Thu, 15 Feb 2024 05:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708002965; x=1708607765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IeBmJwr+NavRsk9se4OE6Y3WMAt4IgfjmriUd2t4/J8=;
        b=FC/fPhSzmFYwocM5/rRGynGlOuyg3CLsaBj5jhFj7okhsDU/wZtjqS1+lOt49PV/vx
         wZC0P/6kNLmEryT4jkOS6+emGQULU3gXAfKoc2/ZpF/Y5UmA6YX9k0QAS3fUOscLcEBu
         Qab5/O4Z/6nqtq2pk/t50drRCAEOMfL2T4ZFzMUkq7ZLAEZjhlJGukqA21NVl6SiNKO9
         +MWI3aNbw8VFo1PkQDSzPP3JgifEvgaUN1vt3J3Aq3oU/emm4g4/Y9SED01hcMSQ5AOj
         b0ljT02Fi4PZPppQxDlkOLeuN+Jdku2sCIiaRLCmx+iwoXFD+/+W5PIUgEZ61CZuCk18
         Es5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708002965; x=1708607765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeBmJwr+NavRsk9se4OE6Y3WMAt4IgfjmriUd2t4/J8=;
        b=vaiTXGuXSXaI+rnj5dPc+2xVt37PffGqar/kEjGOnkKjTefAZG9etNfMoJhWLPQhre
         v3ELrTI74xUM+b3joaBpmFEtMi8J+9tw18teRHV35vVxCZR+u9BG7dj+MpTvWjp8Pyhg
         yboYkXUgF652KzVo3X7IpO5nsdCUaPdACbgHdjlLyxwRZOR1dWBMok+nqRJWVLE1Ls9F
         Lc9miKWHdP4oFpxduLpNkMpOIo8egVQIdbxtoy8pILU4JeWDEu+FIx5ZcmSGfy0HcxUU
         qhKBCyHZifRPTstQ0nsPh2FXnes5qVBrLXPcLZnp4ngD+CzsNdOdGA2HAEBX7QFAxpLg
         0O6A==
X-Forwarded-Encrypted: i=1; AJvYcCXj91uNSe8Jc6L/RzxU9dnmh6voWJAkrRdqwvzVeRmCfgA9MNCPS8PFLqTlYKLFkdWDpxqR28DQH7D5Y89BFkqzIW0PQKW3Biz4T6SmuMxwQbvP2949idkT03mno8thnVtdPwPbwUQM
X-Gm-Message-State: AOJu0YwcWIXW0aOI7/ibykcV9MoOJzBHi4MR1lkKqBfiQvuMudrDVzIi
	k7y9kso6k53xusoFNvXYzUBKBw69kUxQ85GubjQ+u/DI8NDcdLGE
X-Google-Smtp-Source: AGHT+IHbRc99z02i6FWnbm8IHOkzsWaPAjvDKMTyyG22n1oYGUQohBURcNvbbdhi4AcrDHd6DcT3Mg==
X-Received: by 2002:a05:600c:46cd:b0:410:cf60:d857 with SMTP id q13-20020a05600c46cd00b00410cf60d857mr1331806wmo.18.1708002965162;
        Thu, 15 Feb 2024 05:16:05 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b00411e1574f7fsm5011002wmj.44.2024.02.15.05.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:16:04 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: dw: remove redundant assignment to variable len
Date: Thu, 15 Feb 2024 13:16:03 +0000
Message-Id: <20240215131603.2062332-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable id len being initialized with a value that is never read,
it is being re-assigned later on in a for-loop. The initialization is
redundant and can be removed.

Cleans up clang scan build warning:
drivers/spi/spi-dw-dma.c:580:17: warning: Although the value stored
to 'len' is used in the enclosing expression, the value is never
actually read from 'len' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/spi/spi-dw-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 0ecbb6c36e23..f4c209e5f52b 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -577,7 +577,7 @@ static int dw_spi_dma_transfer_one(struct dw_spi *dws,
 	sg_init_table(&tx_tmp, 1);
 	sg_init_table(&rx_tmp, 1);
 
-	for (base = 0, len = 0; base < xfer->len; base += len) {
+	for (base = 0; base < xfer->len; base += len) {
 		/* Fetch next Tx DMA data chunk */
 		if (!tx_len) {
 			tx_sg = !tx_sg ? &xfer->tx_sg.sgl[0] : sg_next(tx_sg);
-- 
2.39.2


