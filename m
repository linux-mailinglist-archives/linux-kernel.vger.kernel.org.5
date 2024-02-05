Return-Path: <linux-kernel+bounces-53155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F16D84A166
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5102848FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11AE45961;
	Mon,  5 Feb 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CETpZFhN"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834A45946;
	Mon,  5 Feb 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155536; cv=none; b=HhCOKzt14sk8Na5Yz0WeEpxAorYabeb49g4dR8DrSSjUjeqWS6B0qD6d76rQmo4rUuhsM1U4iPpkdSHDPDEbZmo8XCr7BzSnsNYcioKNOggrb+DS/KOyVZ3KQPJWflFpkFcxuFd/eu+eiaQ4PV9FZrCMglnj6mWT1Jum++Uc9TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155536; c=relaxed/simple;
	bh=kxfhbtqhJ3yntShLMRf4OOUu8N3qaq/tFvyQQvEDDyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jPOoFtvhOkUiGaOgtEQA+Ar7TSD934ts6wNOt0r436t9m+QokG0+eTRcTgGMN+UQJoPficnQfA+ZCWyva33PArSqh6wY0s8fXNtCTXw3IXD9r4IT/rz6HDUFKX5zSl0gQ14Y1zaE7R5scy/MznjEHLL9OygFfRp1XUC3QeObVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CETpZFhN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so10586205e9.0;
        Mon, 05 Feb 2024 09:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707155532; x=1707760332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WX0ERGmtVkwESE6iHlas7SOT5xD03uKdoOZi6U2MWfA=;
        b=CETpZFhND80FoJyXGo8iqPpvlJ05neK0I/GpUrPuDfH/NIXan41a6tBqm0FajhT54f
         5KMRKMWLOMpgioqyhWo/pWL4B/cPBF68JsYnYew9CMnqU+2d7hb6UdWVLsT4gBR7Ju9Q
         9pTwVkkkrLNdRVFaL0GeZTrzdmazsEt5/LczoH06oNpsd0csKRS6Do5o7aVsZU4luaXO
         genhsxw5PNbY00jYSGx4jLXfrAfbplLHsnmeOyeSOaEc+wjkhwA+sk9F0NFACQ0LRx1G
         8pbJEwGIY4iuzaKF/r0+tK08eMW2whkjgy0wYIJc0AYZJxvhWhCwubQsINJKuMMt09Bv
         8VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155533; x=1707760333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WX0ERGmtVkwESE6iHlas7SOT5xD03uKdoOZi6U2MWfA=;
        b=W3ypPfLy9gD1rVW6Lkw2BzaiAf73fXSw17Apu30boGfrHf6/shBIquiwHXukS8i1G4
         s3VneZjGWkppd8qOBLPTOeO11uBQ6vXWajm+uuv8N0lqr40iWfg7ZAyfJIIs437kf5hX
         D6jndNk3sWkko3ObM5+GZOc3UQuDqOpZuS/jByGtoDgIfp5P47uARNQ3gbJOzq/7pysk
         fauIe3r3KHFS22b2UpGXbwJIJG5TaAmUKRqFk83Uw/IIsA8T9ftoYhaVAogwsh+y7nBO
         8LEhbXGS7d/jS5ayXyzYEcvXAFX6n7wKbF/Nsoqkn1TnjybqpfLd0IyszMxDDSpBW9FI
         7SRw==
X-Gm-Message-State: AOJu0Yxnv63MPVny06wsxEY4fW5SzOgt3j8hZ7mjhMVpEZkL+S5/B5GL
	hYacOyefbS/fReNbi8Tfz1Xn+r2xySqwVsTFs26qVkbbEmTkA2d4kHQMssQd
X-Google-Smtp-Source: AGHT+IFpITN6/P6MXhEYrL+fds4E1ZovRKyHWNa++diJ+Ns6XkBzhUhDTE0OI2/vJbnR6aX8te/QqQ==
X-Received: by 2002:a05:600c:1c08:b0:40f:ba0c:4e83 with SMTP id j8-20020a05600c1c0800b0040fba0c4e83mr289998wms.19.1707155532448;
        Mon, 05 Feb 2024 09:52:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXu3l6olBNVCqIoGdn1w+mVwtWq24kT1ZNTF8ZR0PzaOLAL3T6uSxsZZJERaHEmmI3iGiyhAvHxwYcmIm9vM4MGs3m2QmrzOm4wtzdFEHkesnrOfLjY3+HcnvXWVbchXrKD4PQy
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d4b0e000000b0033b3c2e73e2sm116904wrq.113.2024.02.05.09.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:52:11 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] intel_th: Remove redundant initialization of pointer outp
Date: Mon,  5 Feb 2024 17:52:11 +0000
Message-Id: <20240205175211.1840927-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer outp is being initialized with a value that is never
read. All the reads of outp occur after outp has neen set to an
appropriate value rather than using the first value is initialized
with. The assignment is redundant and can be removed.

Cleans up clang scan warning:
drivers/hwtracing/intel_th/sth.c:73:15: warning: Value stored to
'outp' during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hwtracing/intel_th/sth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/sth.c b/drivers/hwtracing/intel_th/sth.c
index 9ca8c4e045f8..87c1c751d183 100644
--- a/drivers/hwtracing/intel_th/sth.c
+++ b/drivers/hwtracing/intel_th/sth.c
@@ -70,7 +70,7 @@ static ssize_t notrace sth_stm_packet(struct stm_data *stm_data,
 	struct sth_device *sth = container_of(stm_data, struct sth_device, stm);
 	struct intel_th_channel __iomem *out =
 		sth_channel(sth, master, channel);
-	u64 __iomem *outp = &out->Dn;
+	u64 __iomem *outp;
 	unsigned long reg = REG_STH_TRIG;
 
 #ifndef CONFIG_64BIT
-- 
2.39.2


