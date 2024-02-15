Return-Path: <linux-kernel+bounces-67389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F18B856AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCCC28B974
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EC31386B3;
	Thu, 15 Feb 2024 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZNZQkbr"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DC313848E;
	Thu, 15 Feb 2024 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017481; cv=none; b=R4RDpq9oeIL5AS0fP1OWVU+XdGIBHVkwQYUdbcrpUBPnljjpdj3RTF1bDfO8LdwnBTS3f3ULi5VD7pV9giB/b3Jnwx9uibDiT322G99OGKkRYyzQyddet/pR5V/QBxZAc5UIFhuvz+anULRuhKWLYWu/IyOtg1zmQe/OnPcsz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017481; c=relaxed/simple;
	bh=3niBVDG2P9zo7HyZa3mOAK6Iv/Wd2/y/+iNeqLtGf9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivDIErb8YQMIe+Er1oR/riwRQKgtyEvcXehuWHWUswGhMDtIb3HM1BztJSZayAEKafBLV1B54WirmZAna+jtyenImyqA3BIBaBVQY+bCfkdV/jC9QtCTL956wSnbUOuJohYREz2oPHTO9biYZTIYqO6Oh91Xan0PrXPz/nwwR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZNZQkbr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5118290fcd8so1323199e87.3;
        Thu, 15 Feb 2024 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708017478; x=1708622278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBvrFBfn8f9ygHbETBGRtk4r0X8Ogb6B9wjwrJRvRzk=;
        b=LZNZQkbrB1i8LwT1am5RTu/Ps+KnQDPOLUACX3UkrPXPD9Qu/ttnYPZ0/dWG19yJ/w
         HjTDNZbFevgWplS9EtKsHQ37PjX1k7AtSuSDTSWOM094K8QLei4af3ka71OGkQYNZbkU
         VO7UKZcETrkQ/Ez6hxJBUN4pz/9Ev6q0rj86LuZ+C+x0xwavf3zvH+L2puyg5OvlaztM
         8uVeMa8GcjGKLbDqK7rftJeXWmmFJybROpMMBTn1sswVkwYgrbRmFj4iq5TosjzRS4Wa
         pki7SeJru/II2iyjj5tmaRb3FtGiYariu/tkQ0HpWm1yqCGw9QwlYi8kudezHPaNAH17
         yHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017478; x=1708622278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBvrFBfn8f9ygHbETBGRtk4r0X8Ogb6B9wjwrJRvRzk=;
        b=nx0EAIZ7Psjg6+HcES9uAD6wFVNPKPKd2m138crwXDjWMZd+OWQAiHGusitSNUcvRr
         qMenPrbbNhNEYD0CCJrQhgfKc4lcjvrMX5dRI74iwP/K2DxHTY+ig20TFalfOZvM/0NF
         RGh5PE9ypYbBeVQw0pFhWGMm46ZMpauM/FpyZGG4WKnZxrcUkEtTk5bFBZ/v9sJOGDFR
         L1l0McOwoP2S/frEcSI9Cej1HzAxukdM2IvkvcTOY68z7S/aHnKtqXBFo4fWnKxRJoG7
         EQRPEqGcAhkbR+WR6NLn6aYBrf23+UcL3KFkumRwaY1mhbLGw5ipQ0sPn8t//f5tHd7G
         Hmdw==
X-Forwarded-Encrypted: i=1; AJvYcCVEElUU9jbDAJhGRrell0mN9W+Y00F6vmOqXxy+9s3+8z3YAZB07Fn+xAFQyZ2graeoFDe/TZvEpq9ODDq83ixs/+EV9frZsuEMLrFViIIjs/mr0qk3+8v8RQzFW5wAPKTwtKo32R3GwKj3lwQihdxyp90HMBf1c9qoOqXsrhTEufSLHtXWzQ==
X-Gm-Message-State: AOJu0YxnLZbLgZ37JTAbKYYgHW7opqiVfxZu/Cje3teO0drk5maugv4u
	dp9vn/q9jyBFhZTFjxMiJuHMSQjbmspFDvGkQ9GiMFMz3Z9huB9X
X-Google-Smtp-Source: AGHT+IHRq81umpSNWlY4tVOq5fL8rl3vkqUJ1BPGXG8FJFRYOTGILq0K/V+l/UgBiY7XhIG+BMh8HA==
X-Received: by 2002:a05:6512:1289:b0:512:55c9:6aad with SMTP id u9-20020a056512128900b0051255c96aadmr2145079lfs.10.1708017477781;
        Thu, 15 Feb 2024 09:17:57 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f4-20020ac251a4000000b00511ad5c3487sm309263lfk.276.2024.02.15.09.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:17:57 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Stephen Rothwell <sfr@rothwell.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] tty: mips_ejtag_fdc: Fix passing incompatible pointer type warning
Date: Thu, 15 Feb 2024 20:17:29 +0300
Message-ID: <20240215171740.14550-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215171740.14550-1-fancer.lancer@gmail.com>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mips_ejtag_fdc_encode() method expects having a first argument passed of
the "u8 **" type, meanwhile the driver passes the "const char **" type.
That causes the next build-warning:

drivers/tty/mips_ejtag_fdc.c: In function ‘mips_ejtag_fdc_console_write’:
drivers/tty/mips_ejtag_fdc.c:343:32: error: passing argument 1 of ‘mips_ejtag_fdc_encode’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   word = mips_ejtag_fdc_encode(&buf_ptr, &buf_len, 1);
                                ^
drivers/tty/mips_ejtag_fdc.c:216:24: note: expected ‘const u8 ** {aka const unsigned char **}’ but argument is of type ‘const char **’
 static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
                        ^~~~~~~~~~~~~~~~~~~~~

Fix it by altering the type of the pointer which is passed to the
mips_ejtag_fdc_encode() method.

Fixes: ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character pointers")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/mips_ejtag_fdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index aac80b69a069..afbf7738c7c4 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -309,7 +309,7 @@ static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
 	unsigned int i, buf_len, cpu;
 	bool done_cr = false;
 	char buf[4];
-	const char *buf_ptr = buf;
+	const u8 *buf_ptr = buf;
 	/* Number of bytes of input data encoded up to each byte in buf */
 	u8 inc[4];
 
-- 
2.43.0


