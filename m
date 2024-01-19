Return-Path: <linux-kernel+bounces-31041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB228327F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15205286F31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC3B4F205;
	Fri, 19 Jan 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoYfnBJ9"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4C44E1DD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661143; cv=none; b=kP6jqSsrcMkqYepStC+x5qJt7nhF4Rh9pA94q0F/BMz6v/oSipqpxC/qLYo7Wbk4c6kcckW7qcRz6xJ/yL7BAd61isb55ELdtJ6jwu82ieiQkWf41hmsUALO0CMTcVmj/+MO+gaucSbJdHsB44gw+6csmOlsgJ4xwkI0WIMAIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661143; c=relaxed/simple;
	bh=8IodzGZ1N5vxfAuWzuMPXTBW5vzjas6eiKlra3jz4ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVoptIZa8ZDv53ALqlGNSeHTxRWzoNzYedBr/aHqStpt7E3UBRFTepAQFNd4TP56Kc2DjKKkHjcACIfoMK+ax3rTpzQSaE646WKavyha2E4yUBQDdoD3fbd4wAZqUZRNgqR6/loC6VOrArUVgRQ9rV1alFDOSVZEngKUaiC3k94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZoYfnBJ9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e9ef9853bso1969105e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 02:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661140; x=1706265940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sk+f6DMfyT8RxC2Uq+wxFTBwK9isaqVwqfpa2TVfflc=;
        b=ZoYfnBJ9+EFpi6j/ttlHMPIZ0beXHTh8U+4yhJvsrlkj5U1UIublpUNDUNJR6mnxEl
         hUOEzAZLAYL7edebw/cYmUwGiBe6boE7iqhwEZJ/X6EkjX7BBz2WbavMr4BTqIZLvXdJ
         PWplINFEqNSpdFdI+716B2ZzP3wUZpQyJiGB166fgOZSPSr37EEtnPUoNzTjW7QlDyZh
         DMJFffVCQpoMyFhgNP7hZpvaiFmgo0YSmcz0aJnz85o/yKLZG3WEp9mUGK0qB/8/AcWN
         838gf90nyYiPWAiOggc/8l403tPxSgLFmJ76tln5rEzNTmnDVnEiyaKVC/zbhXAyCDfy
         TfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661140; x=1706265940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sk+f6DMfyT8RxC2Uq+wxFTBwK9isaqVwqfpa2TVfflc=;
        b=vU4V2Vex8WK/6IcXuBhC950uhLC0+iMS68SOOua4Fpt0kFliDiRiMvOcbR+ZE5O9aN
         NvpZE5SsZq5judIM7WvZouDUshsBO4mCjoPlLzEnFzWSYkyqsyk4zu10Mr/JRcJIJbRD
         GxOYhuM4t0AxqGPKBgwU0MEku2+wAi4IR+6IxAMp1y8NXdJWTHKhIA1hWTHwmQuldYHj
         og3hmUxfe5CEjDdZe3OEVtAmX83b4ryCnFnsUFCuTaY89/KWL2IAw9ImbVs/TVofWdyk
         bXSNAR3ERoZuU9W4C1hSFHAHe+P33PAJMS3H7xV/wQqdKW9Wl+CPg2aX6eBQXvYCYnG0
         y/BA==
X-Gm-Message-State: AOJu0YxRv81cO899BPtjdNayDLT8EWgzbgPl6yug6Bf0yftg5MAX9VK2
	n6UJg+auHWmLPiHRbfiTav4/un5a4+Gu60HPcY1uEvU45kkF9PqXZfex/k5iIhU=
X-Google-Smtp-Source: AGHT+IG8YnM5QzfuxMFX1zhOVACz3KiL73IJvltttYQcWx8JPktpxDFvbwhDtd+mk26mM/jTJgFwfQ==
X-Received: by 2002:a05:600c:354f:b0:40e:88fb:e8ef with SMTP id i15-20020a05600c354f00b0040e88fbe8efmr417899wmq.4.1705661139905;
        Fri, 19 Jan 2024 02:45:39 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:39 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 11/19] tty: serial: samsung: drop superfluous comment
Date: Fri, 19 Jan 2024 10:45:18 +0000
Message-ID: <20240119104526.1221243-12-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment brings no benefit as we can already see from the method's
name, ``s3c24xx_serial_pm``, that it deals with power management.
Drop the superfluous comment.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index b6d34c9f46ea..4bb75b1eceef 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1295,8 +1295,6 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 	return ret;
 }
 
-/* power power management control */
-
 static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 			      unsigned int old)
 {
-- 
2.43.0.429.g432eaa2c6b-goog


