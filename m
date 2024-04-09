Return-Path: <linux-kernel+bounces-136796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2D589D845
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04076B25320
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5FD12A169;
	Tue,  9 Apr 2024 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="v3+SeUt0"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69112B16C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662862; cv=none; b=eNKvNW99IFqQMqbBPnP0YugtH1Ujv5gr6SD11mOmc4rv0fhCAMroWW4ji479LNMtTa3npOiKb2BFty83ZfbeT64jHKXIEw/00QJqh+fgIHT4xIM/SKS8AF+rBCiz+e0M2vLNRw/J7g/qJmaY4BR9QjEmI9tt5UUT9puCw8ZSUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662862; c=relaxed/simple;
	bh=rkgQpPAjwBulfGsgEC7S06810blh43cxTegTVfjicmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToUksey1kFhi1t9Ihu37aYjsYh4om3sCDBb2K4MVsOex9ssrCmmKEtRFLN6HE6BcLThHbQlkMLH7BMGgU99Iz0OnxumuKzMScncJTzhuRemCN74xuqF5EJ9bXOEMBYmQNRXf3nlcI4xL4g3wp3FEXSxx6XsQKGipZp/EOxLlNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=v3+SeUt0; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1e3c9300c65so30419875ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1712662858; x=1713267658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nj69Gf9AC1113GLKMXeajOz51G86hh4wvGeZBblnNV0=;
        b=v3+SeUt0tthzwOK2BfAl2qYleI0rlyIz9JEziQKb9bZIJINjVqJ90cbu5770NrwoGz
         CkwDibUtqHp1s7W/HVIo9Aicd6IR0ejQOIqns1HDAq/9aXee7ve03ugofwvyUdfcbKYD
         ZZnT//QzMJRwzMDgRilW+3SOgOQEjC3Qc8rfWZmETQz8PmZ/yGH+Zy4tX/w4XmWHPEJS
         N3KTTNqIAJ/bdALZnj0XBA+KZ+TNCeyGD6SeFvjB+zuRt6Z5r4nbC0g3itm0oRNfK924
         J6hYDqGLCYd7eEYsjSO4hDmJSabvY6RayFwS0JO9NppYnw8NSC4JuXIl/RZ4S7Nc+Yar
         hwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712662858; x=1713267658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj69Gf9AC1113GLKMXeajOz51G86hh4wvGeZBblnNV0=;
        b=sKBTglHoOrgMCN8Q4J85LstqYtRnC8eJ330XkXg18cAygJMF3mejv7c7s+xls+WMLd
         /owlEmLm5A8TE+6jbePvmDG1pfkd77mcnoBJfaXdv1/bN6CrHuhjLbGwQzKZMsaO/7j+
         9zLwYzQCsS4H07PFZXSVRiMtYRPmqf/feRCrYUn51qsC8nYnhoarTN9RVEi3m2BGDeyG
         3XzRt9cwlm6uDH04rg1TfSYNJApx0E2d8ZwdSUKWudoupuO7GpKm1L2+T/xN0PlMb0Tc
         q5RhV1JE/kJ9J7+T/R+MqhkbrJJV10Q09E1CmHXFWNvsJn/00lB43bPwleLbgG7BXPo1
         T6bA==
X-Forwarded-Encrypted: i=1; AJvYcCWkSzuPOVcLYYTbB6naEMNu6G39VQyZRmHYCYyUERf3oh8AEcsWYRPy5dYAIN1vn/HWgoGvCNiw9T/XXuu3O5IqJanNq+XWdaHMn8Vy
X-Gm-Message-State: AOJu0YyH5wqLXK5SJK5qQnm2/DPWQ+Q3JMDYrTmPvEeoKtfunYScXo2T
	6KHraRGOYGkRvhliy25+Vne4fVEzXnxrULPVYXZm4j+HvpMYvuGYQu7GtR7IAck=
X-Google-Smtp-Source: AGHT+IEuUOF47jKaqXVe/uBd6Zq5NWnJYAKUjbTQwvwDQJ2Yh5Jgk6dEzXqV81OERcXTuKz1rxopmA==
X-Received: by 2002:a17:902:d386:b0:1dd:6ce3:7442 with SMTP id e6-20020a170902d38600b001dd6ce37442mr9487167pld.39.1712662858534;
        Tue, 09 Apr 2024 04:40:58 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:18bf:c025:fe8e:1e4e:c180:47a])
        by smtp.gmail.com with ESMTPSA id kp4-20020a170903280400b001dddbb58d5esm8617530plb.109.2024.04.09.04.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 04:40:57 -0700 (PDT)
From: topcat <bfonseca@ime.usp.br>
X-Google-Original-From: topcat <bfonseca@ipt.br>
To: Marc Dietrich <marvin24@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: topcat <bfonseca@ipt.br>,
	ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed spelling mistake
Date: Tue,  9 Apr 2024 08:40:45 -0300
Message-ID: <20240409114045.13872-1-bfonseca@ipt.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/staging/nvec/nvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 282a664c9176..b4485b10beb8 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -712,7 +712,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
 	 * TODO: replace the udelay with a read back after each writel above
 	 * in order to work around a hardware issue, see i2c-tegra.c
 	 *
-	 * Unfortunately, this change causes an intialisation issue with the
+	 * Unfortunately, this change causes an initialisation issue with the
 	 * touchpad, which needs to be fixed first.
 	 */
 	udelay(100);
-- 
2.43.0


