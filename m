Return-Path: <linux-kernel+bounces-35964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45CD839943
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9CAB271A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D656212CD8B;
	Tue, 23 Jan 2024 19:04:26 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B8512C53F;
	Tue, 23 Jan 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036666; cv=none; b=EaRRd6KsQqLPjL2QMdjUG0H7aCowJSN0YkgC7h1z9TDUx18Nf6x30j6zNs0K5h/30LOanEdO/XCM7CYVNQtMkPV9jHGfytjRnoajBDCKonl6+rexeMKghMbI3CfX9hxGPSqOJz9SP1ftRg4zTafrJkNRpdOaxJ9EwfmsXDNynVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036666; c=relaxed/simple;
	bh=AYzoZA7Oo+dslJ/lV4356XB6dAQ/UV5qLQs44EJlEQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZvQHLaCF59Ib2lbkjhak5kqj2Sb2SIF60ppqf9+6X0CH7yEghCRimXx5c6PQq2L9pAH+ntM18FzSitmaku2W/Z4rYlLCN2BKo+Rwh5qfmLJGhzgMeGhotzsOnlX0P7aVsr6qQgxsna65wbNopQsplgc/1psOpCJ4w76bYFWaOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd33336b32so62172141fa.0;
        Tue, 23 Jan 2024 11:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036663; x=1706641463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hozx63fH37v3yPpbULyiAtnqTUiV0COnClY5PWpJRVI=;
        b=jfoE3b8Albz1W7YGTjiCslU9HDFsVx+OVsSfrhStuJqnhoOMkoQLM88trPNLwgipDW
         u3i4d0ui3jmqoTJ8YVsGhBevMy1L7kuTRs7cYU6uDJsJXhqXxAH8EfsR/M5GIs/9wVri
         4YhtqrzupZCy4cE/CyWgGKp/G8U67yqxkdTbg0dyghMOnz+PbMXoWOVEp9j21QfbUJSK
         UtU6zix6cyzSTjpD/x9qajn9bLoOKCzNwqsie8bckGfC9WgLlW8Msp8CYIGc1hBIhvoY
         2zDvboEpz8ZIjMPdL5wFb/PvRs7q2nuLqktikT+P8HDKG6/avWfbXqdW/MknBMasFcRi
         PJuw==
X-Gm-Message-State: AOJu0Yxl5ZBc56cnzKWCVIbUVacjUbCsJSZrtRW/S8QlQjqBZPGTzIX9
	Kjjfs6X3AFhC75Oh5yniVq3r+V78p4/aO4c4LQzrt6VYRzJ4ZRXb
X-Google-Smtp-Source: AGHT+IFMWsZCAFdev1iMb/WSwMJEiNSpf709fzTmOThAKt22t4pDMIQVoQmALcbvh+s5fP11Cp/nqQ==
X-Received: by 2002:a05:651c:b23:b0:2cc:9389:ca1 with SMTP id b35-20020a05651c0b2300b002cc93890ca1mr156292ljr.73.1706036662875;
        Tue, 23 Jan 2024 11:04:22 -0800 (PST)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id t34-20020a056402242200b0055823c2ae17sm15754418eda.64.2024.01.23.11.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:22 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 09/10] net: fill in MODULE_DESCRIPTION()s for litex
Date: Tue, 23 Jan 2024 11:03:30 -0800
Message-Id: <20240123190332.677489-10-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240123190332.677489-1-leitao@debian.org>
References: <20240123190332.677489-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the LiteX Liteeth Ethernet device.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/net/ethernet/litex/litex_liteeth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 5182fe737c37..ff54fbe41bcc 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -318,4 +318,5 @@ static struct platform_driver liteeth_driver = {
 module_platform_driver(liteeth_driver);
 
 MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
+MODULE_DESCRIPTION("LiteX Liteeth Ethernet driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


