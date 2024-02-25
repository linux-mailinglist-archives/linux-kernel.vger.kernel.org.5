Return-Path: <linux-kernel+bounces-80126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA6862AF4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFEE91C20E44
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9C614292;
	Sun, 25 Feb 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkWiVz1G"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74912134A9;
	Sun, 25 Feb 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708874080; cv=none; b=mozd/zwTv1a0XqWFgRfOWmAo8URwF7jnTJ4LvFFLht0A2ujLswWxjzwOO3NTmt3ziNF6eV5cRoEeCrQFjoV+q5z2d7J9+VPdZW+dpogBXMn1+ka6QHJJPF7JlEew54HKlgO4vDGMj2PW/4mOg+AMvDKsQjN8dy2F4l3wIEEoZg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708874080; c=relaxed/simple;
	bh=TpyL4kQVxe3uBdq1klt+8d1vmiRINhKLOGIAiZVoUdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R20ZRuakLYyQE4xJPKab80UZF3jB+WcN5uUhFJd0/S/iTgOaipJhLsvvOhduq47irOwH1HtaFRgL6jXGAmQNB92kaQZMKFtca+I5iEr9xmdaqVlcQBBKVxOtm31BCOsMtxy+IHpYrPmFk232rR7jkr0uenhvASHOrJx/xrmR1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkWiVz1G; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d09cf00214so36997431fa.0;
        Sun, 25 Feb 2024 07:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708874076; x=1709478876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1WcXyxSf5IgU8jdpiPrHseEASR6WgEzsyYofdlCO6+I=;
        b=fkWiVz1GZ2fYkMBsTpiP3pntkQIb0wpMTi2NPKFxPIoZhGcRUujPZjxQnGutmrGIDi
         WtCq7AwtclfpT4xEyXDJpjQEuVV8Hy6ys5A3EVvKJHARzun7Gddr3NlolQ6zgZOLrULJ
         VmxnTaKpd2q8wn7qp83vK+7Wq/Sqwp+TpEvA4ncvrCa7C1YkkSQbF87kCzylzF7AxVyw
         zTvZUbAI2Chc9UppWyAmeuIhEtG5TnLDo1/vivB4HW7ErBW6pqA8fWbT835nXRo5GF53
         S/syNlWdiWiC/yAqhf1bNg82zp4j8DfYr0Pa6I31NSF+zNL8Apg/a4d3HUmVY1y9Vl/e
         EbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708874076; x=1709478876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WcXyxSf5IgU8jdpiPrHseEASR6WgEzsyYofdlCO6+I=;
        b=wSqgOGz+ge9qBG7TWpCkWd2bDttgC3yA6ViXG1/DjYv6I5oyitDYOAS4KQw04yvpoT
         8OZ0UUSmR9zcim/OdieFkB3halPf2ruQAKveXcieoFN4cR4udTZ+rkwOh6c1Bw5eABFp
         BfcaNLa106ynEWT0RO37AiVK6yODlc89/uZmjGYDfTVwKG5v/2FSNHKZ5Y11L2pul1DY
         nOtuPXYEzFaeW0Lw3bYOO90vw8OKc/v4NKFyKtoWoxdLlokCt+CvJk2D1oWGdPEeAYBP
         OFH2AvXC3JaRCX2oUXaFrqK1pSRGzGK+UXFzTIWL5u+QsUQUIsSHZgDKmkSGOgyTZk4N
         F6yg==
X-Forwarded-Encrypted: i=1; AJvYcCXxTCvjkoMBZ7kr684OCt2sopcNLa7OoDUqu2iEvKBGvx10fjXrhN6hpxRdzRO/LLIJinL6MzSgIVCV07OXrpIzakECxK1iMiED68J9
X-Gm-Message-State: AOJu0YxA27gvyE2jFX7K6e76bwFjxR0wZQeGSPaTcRIJBttVY91+BKhK
	tMKMSN69z9jSxJtSZX8n0yYTHT3kg1ofcN8ZZdzaixTplIgBYZpVQ99OXEzy
X-Google-Smtp-Source: AGHT+IGwRu9t58O662cNWh7HIbYa2m5/h6TXMcVXKCW8V1EBpoKyYaTm1oJOrVYN4o1vH4MvArjQxg==
X-Received: by 2002:a19:700e:0:b0:512:d91f:2e57 with SMTP id h14-20020a19700e000000b00512d91f2e57mr2453525lfc.55.1708874076216;
        Sun, 25 Feb 2024 07:14:36 -0800 (PST)
Received: from localhost (dslb-002-205-020-122.002.205.pools.vodafone-ip.de. [2.205.20.122])
        by smtp.gmail.com with ESMTPSA id s1-20020a170906060100b00a3d9e6e9983sm1565616ejb.174.2024.02.25.07.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:14:35 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 1/2] serial: core: introduce uart_port_tx_limited_flags()
Date: Sun, 25 Feb 2024 16:14:25 +0100
Message-Id: <20240225151426.1342285-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Analogue to uart_port_tx_flags() introduced in commit 3ee07964d407
("serial: core: introduce uart_port_tx_flags()"), add a _flags variant
for uart_port_tx_limited().

Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 include/linux/serial_core.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 55b1f3ba48ac..e25e20034a19 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -825,6 +825,24 @@ enum UART_TX_FLAGS {
 			__count--);					      \
 })
 
+/**
+ * uart_port_tx_limited_flags -- transmit helper for uart_port with count limiting with flags
+ * @port: uart port
+ * @ch: variable to store a character to be written to the HW
+ * @flags: %UART_TX_NOSTOP or similar
+ * @count: a limit of characters to send
+ * @tx_ready: can HW accept more data function
+ * @put_char: function to write a character
+ * @tx_done: function to call after the loop is done
+ *
+ * See uart_port_tx_limited() for more details.
+ */
+#define uart_port_tx_limited_flags(port, ch, flags, count, tx_ready, put_char, tx_done) ({ \
+	unsigned int __count = (count);							   \
+	__uart_port_tx(port, ch, flags, tx_ready, put_char, tx_done, __count,		   \
+			__count--);							   \
+})
+
 /**
  * uart_port_tx -- transmit helper for uart_port
  * @port: uart port
-- 
2.34.1


