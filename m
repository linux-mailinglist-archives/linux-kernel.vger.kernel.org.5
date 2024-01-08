Return-Path: <linux-kernel+bounces-19948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1B182773F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B341F239CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833255677C;
	Mon,  8 Jan 2024 18:17:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66F55674C;
	Mon,  8 Jan 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28ee72913aso544404066b.1;
        Mon, 08 Jan 2024 10:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704737822; x=1705342622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQtADok9+nhktsD5crnT/VahBaHraAQi/Q07DVzqaA0=;
        b=adfNHgQKkk/B/uWEc0nsLJFy5u+sVpVb/scJbTOQXSgQ6i4Z/1r0iogszXWzY9FPuB
         xiPyCPRsvtB5Dtgwt4wyxf8tZ9/hgZ5KbBEoP/KcPIxItgis11aW2vexg/nwdzZemdr3
         tIQE9Zyeb/k3Qpvl4Srs7J2kYuiLkehwuSctvjyS1JIyoSEzssn5cO4HkoznhDERDY3E
         oaQMT8PCfxFl9cuzf2JhFOwKOXGesJlBNf9IljF7Iq00vdS3OievbsQ1ivsFKGu1/LqI
         uoV4VQkSx9jJD2I6odsxNluM8q2RtIfzeQHNupgapn+ajA57WykxGujvm6t8RQAEfL1C
         q/Jg==
X-Gm-Message-State: AOJu0YwtDAjMpI1FKAIXcoSve4Zo48AS1zUiEz/AsEf8VchNPO5Dat0A
	BVA+OrbLpUjSN1UKTNyXaHM=
X-Google-Smtp-Source: AGHT+IEynJEdpWU9m1uVO9Y2W+wmvUWuCSQqSCr4xtHkgFcLgXINIBHyUGFlEhaUbBCKVk5p7YxfDQ==
X-Received: by 2002:a17:906:25c9:b0:a28:e58b:4cc with SMTP id n9-20020a17090625c900b00a28e58b04ccmr150978ejb.76.1704737821776;
        Mon, 08 Jan 2024 10:17:01 -0800 (PST)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906595100b00a2a4086c6b0sm132816ejr.82.2024.01.08.10.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 10:17:01 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jon Mason <jdmason@kudzu.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 09/10] net: fill in MODULE_DESCRIPTION()s for s2io
Date: Mon,  8 Jan 2024 10:16:09 -0800
Message-Id: <20240108181610.2697017-10-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240108181610.2697017-1-leitao@debian.org>
References: <20240108181610.2697017-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Neterion 10GbE (s2io) driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/neterion/s2io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
index 61d8bfd12d5f..55408f16fbbc 100644
--- a/drivers/net/ethernet/neterion/s2io.c
+++ b/drivers/net/ethernet/neterion/s2io.c
@@ -414,6 +414,7 @@ static const u64 fix_mac[] = {
 	END_SIGN
 };
 
+MODULE_DESCRIPTION("Neterion 10GbE driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
-- 
2.39.3


