Return-Path: <linux-kernel+bounces-39203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534FB83CC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FDE1C231F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD713D518;
	Thu, 25 Jan 2024 19:35:12 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188013D4F3;
	Thu, 25 Jan 2024 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211312; cv=none; b=HSA3D1+/oF3pJoxZZtmQwlJ8UIaTS2ljfTpcb0dyuOdvETdMFySLAVsnGi/LVNf6jagQfJ+CfiaB2w01KDoKxTrMRJSBFXGGeasO9jl7DOfpDWxwQFw4lWWYQmqGVkTz98mOvjDo5+aO5fapL88zcd3XsJAkuDOPtbce8ixrSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211312; c=relaxed/simple;
	bh=uh8t6LUvifH8vyCsv0JdPgUlMgY9ophz5h/l7o9N6Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFAtZKEo/SNtEzaHAfV202gPGKtuuTG81wfSUzCU7Vathhr5W4kxXdUZzxSgEntnBqVHkLWRhvhBX/7NrYA//KxB+hF++j4zk97d93zlsM8O5z+70B0Yx6OjkSqiZVrSjT3U1IH2El896vwQFz/WPPLBl6+w9fGCmiuzVbf5qPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so76505415e9.3;
        Thu, 25 Jan 2024 11:35:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211309; x=1706816109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AgXqAxt6b/HLf7UsuchGiNA/0l/ev1PlS/qyb2yk9M=;
        b=aeiqpg8voihjqPZSpR5LxnO1Nkdso6MwAAFAwwPzfJrwtCe7BJqGYLoah9fkGTZTKy
         rSXfdeeCdjitl1DlTQW+7jN5HB48GMk+JxMtmCNSidKL7/lctVhIdVRmUYEqU7jdr3C6
         oJBVRfy8rreiP/KnQ4CX+KCD0h9Um1KjrdvcgAtY9bZUQU2P7HYiJTuVRvXYW3bgyaqd
         CoyTv4L8OEo0i6IMxwu6f780LXLicwhoal4icHM0Dp6kOEl1M16G4sUsWQcJ53TsQtKf
         BVUKp4/rKGQe8aDHaON701/MYPhNVQckHd/CGhi+1VzKiRHBnSD+bDuA8dxzSPFHyG+U
         Ba7A==
X-Gm-Message-State: AOJu0YwZdiV/h1b9p5EVfXk2DTAn5ny6Mv4TkUkKqQ44uT/39L7yrF9V
	mBUTimXr7S3/RENn99VHb6b5qpdkydLWWmzZRUdw/fQM8CRWj4jk
X-Google-Smtp-Source: AGHT+IEMBVbsaO0ABJQa1RD4+dOg8YSwi6gL4N5tabFR4k4/SjWz/xIxgEfHj9mrOzncFm39Z0BMjA==
X-Received: by 2002:a05:600c:b98:b0:40e:50d8:25c6 with SMTP id fl24-20020a05600c0b9800b0040e50d825c6mr141987wmb.150.1706211308689;
        Thu, 25 Jan 2024 11:35:08 -0800 (PST)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id w16-20020a056402129000b0055d063bdf67sm735316edv.97.2024.01.25.11.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:35:08 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE)
Subject: [PATCH net 05/10] net: fill in MODULE_DESCRIPTION()s for dwmac-socfpga
Date: Thu, 25 Jan 2024 11:34:15 -0800
Message-Id: <20240125193420.533604-6-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240125193420.533604-1-leitao@debian.org>
References: <20240125193420.533604-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the STMicro DWMAC for Altera SOCs.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index ba2ce776bd4d..68f85e4605cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -585,4 +585,5 @@ static struct platform_driver socfpga_dwmac_driver = {
 };
 module_platform_driver(socfpga_dwmac_driver);
 
+MODULE_DESCRIPTION("Altera SOC DWMAC Specific Glue layer");
 MODULE_LICENSE("GPL v2");
-- 
2.39.3


