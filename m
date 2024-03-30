Return-Path: <linux-kernel+bounces-125801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BE8892C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 18:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BACF282A43
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7D73D546;
	Sat, 30 Mar 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="xZg1vmw4"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EB23BBC8
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711821521; cv=none; b=aTb6OZ/lTB9EQ7BNmirmeAVYsH1uczPnz03J775nMKJbfFvYzRBMQnKszhJUZV9zUTRbYXyH3N3Pv5n2Ojk/g13aXjRy38tII+snHsNC44SP8X8HhTyevyXQlMspGClER600p4xCu+PwxukX1wfyXuDAHy/pAGres39IDYlI2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711821521; c=relaxed/simple;
	bh=sUrCeSRuN1AgHGz+TliAi2YSUcHKJxlopXa8Nm66Vxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4d5Cvg/Flkc5x1GHU/US1SfS7RLuwZA4HwJiCRSgZWgYHS/Dlp87uuTYfAvzFkJkryv558C+hH5kGLaW6fTZiDCob0Ht9hBkTVaHeZG35kdhiS49CK9l9bKJlnh7IILhLoM7GIOlim4/Lv9WEgKIKxdZW0O84dtZMxQQpTdkSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=xZg1vmw4; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso35555231fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711821517; x=1712426317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ32s1BONnzC61piCM2zghhCEX6pmq6Ffv/Ga55RjGY=;
        b=xZg1vmw4C71q/CcQcWAw/TZZfdVhdgTB6U6LJQxkxZl+9g6rVOR6x74737RoMYZIEO
         TBlKG5ErS6npfnOOBDFRuPWPha7jyzAfx/lWSUjYzZ3ERo5WaLpE3ctPe5OXxlRlbt9R
         AzcxzEI9OUeT64HMjgiPWPUkMYM4m9oZgaGGSaZ4YVUL2SYbXauhNH+X0wYcRCc4WLAE
         hMGwAuAUShDybcllGlRO5X2uvSYQn+WrHTgbsYRCQjgbp90jmJGBjNFt6RXBk2hihOyP
         MRX8xO3oPqfE1KJOJY5qwb80MqFdmp2cJNO/rZgou2UFmeFSxgEPkOsMukneAnkZ/R9o
         4OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711821517; x=1712426317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJ32s1BONnzC61piCM2zghhCEX6pmq6Ffv/Ga55RjGY=;
        b=ELBsKQQ+14jAawk9cB26AdXZgp+sGbw/iPej9xOAi517WWBZ4dlYhaKaBUXWqfLctt
         GvDBQdLqjfEtgvF8CcdhS37T2NP35PaI2u8uqzCHZLX9og60qDHsm9N5K4IZyn7gRneN
         SRZxqpPm5B7vGEtDQPxOc6KsM1BKG/GId5mHva6ZYrj8njLVjF8QPkHeIxFsn3MRYEcy
         qzMGWwsCKIACuZHdLMg+Q2WENKVPj4qob9CvZPgHg0iwUKNYXslvH8au2KAu1VXjTYAB
         bB8joHrazyReKOlT/nlCzSkRE15aJNIORr50pWiRMb3S/vZ8qEIBQioOZiL0VBYHY/m6
         CH0A==
X-Forwarded-Encrypted: i=1; AJvYcCXzYUqdCMk92CIFzXQqXtJoUoyamxCNSUWfsdcSHUe2jnGWlzBm+zxHH35SyRooGg41/fRTpeX9KHQztvZAp9IzYyYpn1laLlL92QdC
X-Gm-Message-State: AOJu0YwBkxEiZxHEqqSSpgNCdEO4m1tIytPn83CtEXSeb54YKZzKLxgL
	Y+OHaJLxZl3GLBu9ArMuyvpOvk2IXzQRDZbgidQAi7AEX98v1cqW8P8mhO0Dn4E=
X-Google-Smtp-Source: AGHT+IEL8I2vsogLCMr0HEwhiqpPqjFAQ1oeM2F5ZdztpgYYmySU9i4qVMxYTBePrrza9FQjnYzdFA==
X-Received: by 2002:ac2:4e95:0:b0:512:b0a7:2943 with SMTP id o21-20020ac24e95000000b00512b0a72943mr3187347lfr.5.1711821517403;
        Sat, 30 Mar 2024 10:58:37 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id fd6-20020a056402388600b0056c53ea5affsm3213368edb.77.2024.03.30.10.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 10:58:36 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] m68k: amiga: Use str_plural() to fix Coccinelle warning
Date: Sat, 30 Mar 2024 18:57:21 +0100
Message-ID: <20240330175720.126122-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(zorro_num_autocon)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/m68k/amiga/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 99718f3dc686..d4b170c861bf 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -836,7 +836,7 @@ static void amiga_get_hardware_list(struct seq_file *m)
 		seq_printf(m, "\tZorro II%s AutoConfig: %d Expansion "
 				"Device%s\n",
 				AMIGAHW_PRESENT(ZORRO3) ? "I" : "",
-				zorro_num_autocon, zorro_num_autocon == 1 ? "" : "s");
+				zorro_num_autocon, str_plural(zorro_num_autocon));
 #endif /* CONFIG_ZORRO */
 
 #undef AMIGAHW_ANNOUNCE
-- 
2.44.0


