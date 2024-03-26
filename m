Return-Path: <linux-kernel+bounces-119711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5655E88CC50
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C17B1F83BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3660C13C83E;
	Tue, 26 Mar 2024 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py2Du6yx"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBDA13D24B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478846; cv=none; b=dIZI/bPLcsQVEDsXAJKhwNxN3StfYCwCL55xlz2IGQmpmTdYLWXhsMxnEZsR1L+R8tCFUPthjMdOTnHW4G+mC1iMJm8e1g5n0m5D/I2f7Jx05q4Bty6kER39D17RVSJXsMUoqUVtnxxcBcbgVqInOAr4t+7Rw+I2ikjYJKV8tTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478846; c=relaxed/simple;
	bh=Tj05ZjgtZ/hOdwZ88gRi5GLXab0H1IMeyOGQoh5qkOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ShZivsrglLhLZnqEp5kKjdPIX4kq3vRQjZzkC4KA+LXCHlbTU6Im8myxQNmLDvwhZH7sJxqUADDbjRR1wqu5irM650oL2wmgvel7I46hmTehexw1GvAoYzEQLeiIMA34I+PhU5uZvPyAEEr70ev/uWmDwKI4PgEyEi1caKJnbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py2Du6yx; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d599dbabso7644208e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478842; x=1712083642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEktcFN4Tkz83zUX0ZQwuJWARcDRCH7/MENDIuUrEqI=;
        b=Py2Du6yx4ErO5cjGjFAf1xLzIG+dHw84oJ31u5RiJJbGvFf29ciQiuaCd33diDu+lJ
         0MyNE2SsEOd/Tsv+TgLfxzoykFOMAKn8eSUm1vlpipXJ0VVw9N8YSrA6YO5Bfdm8ohR6
         r/+7TVLryJ59rBXzSSpm226GMIGAqJizHrCTnIIoD0F45F+UKIlo39dHPxqanDg5UjSG
         4dfMr7t4hdQn/KRzQG50X+80j8fJnvjiRLwjZcPstELHnyk1RiNG8KgWuiRSvJ02hvmV
         H5nyweDJfaHx3vSmjIl2eIC7/by5C/kclSyncvge2lV7Nt8PxTj6POri793s2unhRJzf
         a8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478842; x=1712083642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEktcFN4Tkz83zUX0ZQwuJWARcDRCH7/MENDIuUrEqI=;
        b=tMc/BEY+1CAxTBRXFxIT9ndnc54QcwWgiGe75qF07YW+pfUe6mCaGPuRRAmKllDkpL
         ywTpLpQmiWF2KfFtkUIdS9a+zYgj7nS7YXySC/O4umezMBiBMgSARh9bX5s1AjNWimMl
         LyszUTuEcxHpqWqQ/M4DnUb9fUWL5XH58T3qQRa32MS/f9Yh6JVyQudP9fXzD9Lxh4M2
         k6QhGzhCHBhPF/dTaduF1rc9aDIJfz90mWxn0I66QB9RMC6rrX7fgARREAfWAlx0xltJ
         1rULaiRdf7ybuA3fE9OL0ayrEHsm3Z0uS0+U6ugwIZ1APERkF1PB1Fy4xynRCQyXu3Ng
         wkSg==
X-Gm-Message-State: AOJu0YybzcGdwMMPByg0hcCetEGN+cjyKzo9izWGDJvXVCQKcLd59FuC
	VCsUb9kOOP6Y5/ffL7jFKZePb2aK9uRQTg2D+cGO0ezFvouac6ZwpoPrN5aU
X-Google-Smtp-Source: AGHT+IG1N8/J5GmyJjMCjb4ypOts/sOnJFOBvc3zeI/yn9bwxMSuQPfrXk1SLH2HWJvcN0WLJG/z4w==
X-Received: by 2002:a05:6512:220d:b0:513:d1cd:b902 with SMTP id h13-20020a056512220d00b00513d1cdb902mr9234380lfu.32.1711478842382;
        Tue, 26 Mar 2024 11:47:22 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512014700b00515bb9de721sm122379lfo.76.2024.03.26.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:47:22 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: linux-kernel@vger.kernel.org
Cc: maximmosk4@gmail.com,
	Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: [PATCH 7/8] time: replace seq_puts by seq_putc
Date: Tue, 26 Mar 2024 21:47:18 +0300
Message-Id: <20240326184718.8828-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
References: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using seq_putc for single characters is faster and more appropriate
than seq_puts, since only one character is passed and there is no need
to use a more powerful and less fast function.

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
---
 kernel/time/test_udelay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 20d5df631570..82fe239c3184 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -59,7 +59,7 @@ static int udelay_test_single(struct seq_file *s, int usecs, uint32_t iters)
 			(usecs * 1000) - allowed_error_ns, min, avg, max);
 	if (fail_count)
 		seq_printf(s, " FAIL=%d", fail_count);
-	seq_puts(s, "\n");
+	seq_putc(s, '\n');
 
 	return 0;
 }
-- 
2.39.2


