Return-Path: <linux-kernel+bounces-51698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E265848E5B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780E11C214EF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2987C22F19;
	Sun,  4 Feb 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="L/nerkr4"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76C22EEF
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056504; cv=none; b=UC+YCw2oH13Nz7YrRSQR8kzPZLf5O3xHwxEf90Hq6R45AN0qctgbKo1EIccb19T/TolK77hs/8l+iwGamNfmgAPgcX2yR1bmF7jx7HBWObwNoCjEN3ZkFNC14vl6J18xGGJ8mUPLvckdbZ5/IofF3eeCYfn/dZglvRws5fzweSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056504; c=relaxed/simple;
	bh=LbQtBWIpeayzEKkseZGs1TpCkdNEpDoo5qvYZttcz4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h47boYzy4otrC0d0R47OiAxd7mPwjgjawcN+uw+seKfuLyjTUbPpEqF0jMm8cfRtXsmXEfdwWWoircIv0ep773HgWpD81zUS7/omnc/Hi2vCVIqNXlcf0pUpF2WX2NFWW+xcfkpfxMM9d+WVEnM5A+XBUW8+kMP9Zl8RNisn7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=L/nerkr4 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d958e0d73dso17941915ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 06:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056502; x=1707661302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRP9nwVzfqXzZs06/31XhntREIV2z9OIdaJ2cgZOe4M=;
        b=HXmfTqSAnbdo1KmcdAYUw5gxe7ad7l6HFotzQy1hgJ3itHx4jK9UguUiFjP7ztidX0
         YxAxhCUwb+MpJWMxXe4HkvWZpAewDTFh6ruPqWQJDT0Si231aVrWOyLXIFbm2PU+K46g
         Mcwjuse9uvM0XvtSvw0VsnBSP00jxhVRYptCjyj265voO5Cuza+DwS+dFp+9PbYCP/MJ
         4gTqFGSJPAGBkWD6/Z+6Fm97+1wuPDgNsfk9oOrMhzvYEGu8i4xCVRc72khVh/q2aHQy
         oYHGB4wN12wamLFKyoualmuhxLK4qWfL5GA5Y5MR37Yi2gpuiCi24SNkpjzlLWa6wBGm
         wZVA==
X-Gm-Message-State: AOJu0YzVDRw0oa7hatY31UobSdvJapB5k1E9pVo6rznV1SVx6tlQz/yf
	5wL1wc5t5bU7MahCTOH9sj877/iN3TibAFlK5IRbkzXW0IwteAYN
X-Google-Smtp-Source: AGHT+IHlKunJ13MKnUeSB4T2IJo7rwM3+OMf+NJ+cU53g50LtoXKkChxV5/eB7Iw0AsOKY8YcjIPwA==
X-Received: by 2002:a17:902:ecc6:b0:1d8:cfc9:a323 with SMTP id a6-20020a170902ecc600b001d8cfc9a323mr4992402plh.34.1707056501987;
        Sun, 04 Feb 2024 06:21:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWW4FczAcBkmGlHAJ+dvfK68fXImfRdnKSkBOQMt3wW1NpIACutc/k4RSg8GF09gZyVxscPCyO4o3ZPSj0x7DtYC7jujJ47GLmjrPUDeqary7FlMKNGrzSnzQp90nLs/I6e7nDZGnl9KxkRuqzO4hDpEYqjIoW4rKJ2jE2b0sBtsbvdIymBiqrM15LA6b1nTsDpUNryIMp+Oy1tM3Z/fwzLct3WV4Bzv7bBvjVwJdF8ezT1I+mj5KyBnEnVkV+iUxAI
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id mq3-20020a170902fd4300b001d8fc81611asm4625617plb.306.2024.02.04.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:21:41 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707056500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRP9nwVzfqXzZs06/31XhntREIV2z9OIdaJ2cgZOe4M=;
	b=L/nerkr4PmPGkN/pcEGf+K/Adn0fgm/QPUJ+LwFeKoe/A+xG+IrwR6Ud/YxEizC1mhfAR1
	9H8+LN0fv+0ObJVoD0Y+RbOnORdwY29ybiPp0+5A3LlNhcH9td+4fCQbnhAKBZoQI7WM0Q
	YfkR0Nf+fKUf0Sp0ZPPJff7ucCw6qF57J3DoXgrj4H8NIO7xI3pq7V+CfjO7/XjVkMTh98
	euKoBUggBK92t7TRB3X/3pkBE6o6hAhNE4uCdvF+ZZ/rlyjYGA87aZteocMg1SYlpb93y6
	aFpl5s4IONSVXSBXsEdieqRVZ6vKek5QUlFwD5fzkBfPJ6KJ5fEc3NfcjqZSaA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 11:21:56 -0300
Subject: [PATCH 2/4] powerpc: ps3: make ps3_system_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-powerpc-v1-2-c763f0e142e9@marliere.net>
References: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
In-Reply-To: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
To: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=LbQtBWIpeayzEKkseZGs1TpCkdNEpDoo5qvYZttcz4I=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv52JxRO4eDxV10GK+WPJFjLd8X15nJiU9EnS+
 7Ak+fD1TmuJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+diQAKCRDJC4p8Y4ZY
 piDsD/9IzMJ5fF2wreTnLUccAe/wz9zWMeGU9aR9rwr4ggq79drcDnVgH0WRaD7ogxbFbgmbYtI
 7b86UCiuNteVR5s033t9FoJ48Hh5Ej4odBY+WIfDRJdfN3t9+8ooaWougp9EA7pY4PrsvO4Yi5K
 4CNI0fz8ekmBqe8kvQ40AuM1MmnpS0whSjXPekMDtD3tE3CLtXn0VJkJHqtiJgYPWOf2/UoeCYs
 /N1XtUCPDGwa3v/FZmXHQQqQmS/rkiqgTWtWQBHdMN5uMJANgTtyzhgFjT+NUKBgl10Y9X1GTMW
 xb7CW57/X3Z4x+Z/JYaQDvtd4021khd+5DGZZgV7oM0M2J6C32L75iBJPHrzbInk91klXITrpcL
 AVT1qRhNWsi2efhwekJBruQnBBjXYx2u1c67Hy5FTczv4JRoYLumQWZgMds/od91gztiESG2hYv
 K+Sypl0fTuMIcjEuu8FLUwKX8RU0JemVnLa+ZSvY8kNcT6boveUxSe9KQ3GstpdTGLqCrLfT/8O
 0UERmPvdn/0rjMMVt5+XuKF9XbYUgdLMwSrDGbmylAK5BkvgRfb8fYudU0j3ufvrwxocCTBbGTY
 DjRBAVS7Ftu/t8NG0cnEle1v3YXfhg9WzwUpA2H2FSzK7kkEUv9erzWyDn92WBi39/AU39udbc3
 smk0cBahnUJmeIA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the ps3_system_bus_type variable to be a constant structure as
well, placing it into read-only memory which can not be modified at
runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/powerpc/platforms/ps3/system-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index d6b5f5ecd515..b4298e98ffe8 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -466,7 +466,7 @@ static struct attribute *ps3_system_bus_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ps3_system_bus_dev);
 
-static struct bus_type ps3_system_bus_type = {
+static const struct bus_type ps3_system_bus_type = {
 	.name = "ps3_system_bus",
 	.match = ps3_system_bus_match,
 	.uevent = ps3_system_bus_uevent,

-- 
2.43.0


