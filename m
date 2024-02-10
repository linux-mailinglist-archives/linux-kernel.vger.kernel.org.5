Return-Path: <linux-kernel+bounces-60550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE04C850698
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05BF1C22C7F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34E260253;
	Sat, 10 Feb 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LO8PTBP8"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4E5FF1A;
	Sat, 10 Feb 2024 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707601977; cv=none; b=rWJaiNF+QYCAgPSWQrulBS+sobr1CJ49ExCiIc5tyFLLHjbf8MO7764oJGDn61R2PVSHq6ODNh5KKN9qsZPxDCE+f/Axy3CioiZnzONe+ispzMN0GSimaIrFP7l1U/ntN+3T3SPAe46umFozmcoSonAGIdCO6cWk4q3wGfEcq/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707601977; c=relaxed/simple;
	bh=tYkc4h4Bp8NHCaXbI+vtqrPfsBIKoN0wVgseUk6XCjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7uPQUXcWR0ubs2YrIwvpWhe51myKAZzsZ+ZgLtfsKoCl/JTWiZ29w+HHk7Ecwh4HCkHiUwj6zS1Vti2ghGIKDP4DMAb65t+czJSRXE/+y5eoUK8+fi5vC5HnGBgPeoZGx/Aw5lTd43HHSEPuritE2l2isw4JNljT77T4ZduIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LO8PTBP8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51182f8590bso697806e87.0;
        Sat, 10 Feb 2024 13:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707601974; x=1708206774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVxhkjh/5tBWW60EFdNQVc5luLCi3ZBwXFOGT84jAw0=;
        b=LO8PTBP8YMAc2ZhLCB4w6V9aMGRFP2TG4Arl3XHo4vrcA7FMeYHD/UOvxBqFW/GxrI
         xUEAGBd/gUxK7uPcyyGu2vZN0h7RS+bLEQHo+vuHgyfdyRwL7SaxpLbeAGGUpiSrJ2JO
         cSFeYdXLX8aTfrvTw1EC0tqUkfYE7aEz66mAnMIdBk2k30oiaHiPWOlOPM2CdTS7TGmN
         e4YWXxDJA6X0SBExx6TDSuCedCJie7d3C3GwpEulZghCM8K84CbGud+6OayzkvXK+qIx
         VaHRwV+ZR6W62k8skKf0TJeqOoGeFYc0//59TKN8nUuldlf14STCHlhyFnhUAnPKu8Ej
         tafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707601974; x=1708206774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVxhkjh/5tBWW60EFdNQVc5luLCi3ZBwXFOGT84jAw0=;
        b=jV9e8TYxiMFHRvmXq6C5piq0o/p/eNJmKROY6R3AoLP0oIXT1WRssI22Qm4P2Pjizn
         vALlKgy+N6dkdfsprmNBH7SiPgRpatitG8hxqjI1g0KE3VoGgJSZRm/lYDAvklq4ofu5
         zSbSd/nixulDG8Q8S2RF8dIyugP8qg7VW1oXLO7//8bdxWquNvGDlLj0+Q/VQGCp0YAs
         M/yJo45lLvOGtc8hX3D4fZSja71c0BtwyeXOnaBG8CH4hCFMWxNn0Rt+v06rsM77GaIR
         lKuEhfQgja2VcE4Xzn4Me3DwddshO+0S14GIidoLM8ZXgwBmv1kmBFWxEGwVhFXo4WVe
         PyVw==
X-Forwarded-Encrypted: i=1; AJvYcCUNvPgg9HQf/8poLPcYEeiGn+3k5UgzY4bZk0R7q+4Sn62zacMtregszEl1YVuZIsZsFzFSA1P24FHuMqA1q1L2kukvlxYXtD9MAGQW9FmK/BEcrDa0A5DbWG+Gc1JwtANu8yVfCxI0LIg=
X-Gm-Message-State: AOJu0YzfD2L/DVow3czyejMN/XZPV7xhA3pNcLBUV41SdZllSUzWomWo
	79yXp1WjB0djIqT9RFO/fwtkdQYZ+xmIbf2+vYXvbtdRpJtrZmmo
X-Google-Smtp-Source: AGHT+IFJQUysvruKMIPCXMcKQdErntqFzt0ucLi0pfMC24Ug9r6LTLD+/RH+7IuBLhoFVwvIL/n1Rw==
X-Received: by 2002:ac2:4a99:0:b0:511:86a1:fbe8 with SMTP id l25-20020ac24a99000000b0051186a1fbe8mr726188lfp.1.1707601974290;
        Sat, 10 Feb 2024 13:52:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXc0/2chnx0D0t1iCvdzBQ0haZRG3cbeuWr4bTFtGRlVJhusDLPRwFnCDPIwEQLXvUVinpbCeePa50YHotJZKvrd7u3k7fsJlA4QOpPW3WL1RE1P/GKx2JFariM1jxbmQUrYCVdFCS7QPXoTKN37lzE9vAIR+L6+z+I+s20taQ/FIfiBZu4U+4NyHRtZlGPZDrOe0lHQJPI+Hi9X3hLqFKtrDXft8xyi/zvS/ILeOJxSiz2gizGwuGDYxcHzmfPnlp5PxyUrrHtZ7zO9/WVY11NC2McRyY7PD9KfOZ+jDp1TjTgeEl5gRK0LPiD2YHN+vWJnBuisr4BzG1RpEuX3riOFHOlcko6ISCDCGRumI9/EY6gpbFUtg==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:52:54 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 03/19] hid-ft260: fix i2c driver regression in ft260_raw_event
Date: Sat, 10 Feb 2024 23:51:31 +0200
Message-Id: <20240210215147.77629-4-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix i2c regression in ft260_raw_event introduced by
"[PATCH v4 RESEND] hid-ft260: Add serial driver" patch:
https://lore.kernel.org/all/20231218093153.192268-1-contact@christina-quast.de/

It caused wrong printout per every hid input report:

[21912.237393] ft260 0003:0403:6030.000C: unhandled report 0xde
[21912.247405] ft260 0003:0403:6030.000C: unhandled report 0xde
[21912.249403] ft260 0003:0403:6030.000C: unhandled report 0xd1
[21912.275399] ft260 0003:0403:6030.000C: unhandled report 0xde
[21912.285404] ft260 0003:0403:6030.000C: unhandled report 0xde
[21912.287403] ft260 0003:0403:6030.000C: unhandled report 0xd1
[21912.315406] ft260 0003:0403:6030.000C: unhandled report 0xde
[21912.326390] ft260 0003:0403:6030.000C: unhandled report 0xde
[21912.327402] ft260 0003:0403:6030.000C: unhandled report 0xd1

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index a67c625c9165..a348f11600c6 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1755,6 +1755,8 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 		if (dev->read_idx == dev->read_len)
 			complete(&dev->wait);
 
+		return 0;
+
 	} else if (xfer->length > FT260_RD_DATA_MAX) {
 		hid_err(hdev, "Received data too long (%d)\n", xfer->length);
 		return -EBADR;
-- 
2.40.1


