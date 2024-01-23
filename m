Return-Path: <linux-kernel+bounces-35962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E569839931
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D190E1C26CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03512BF2F;
	Tue, 23 Jan 2024 19:04:21 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C112BEBD;
	Tue, 23 Jan 2024 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036661; cv=none; b=Pbk6sTuQZAB+XO58/WolEQrVbzPerCWhgBRDD/RGUhBeqX+gCfjXur7YacHseSQWidypajhs+Abso7jWIprjfWqXOJh1bBjq8YxGKAS4AoBbau7nPZWYLEaTW5EEXX8bWy4jcZx6D0Rf6nfADgPQM72G/BSl1mLncFxvmA3dqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036661; c=relaxed/simple;
	bh=8pi7kvFEUnyTgiG6j7H2uwHi7lDLLxNkdXlXyXLhFdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UFrKGvdQqVvkHna02EW4rfQV2rh5oCaZ6BK5XHrYknHmmOqyLPlf7Bn6F+1hgKQWoUywa4JuBQSKtDReZvIJazC67xIiwJbI8wJx5qOOWnWBO2QmkM/wmQkfgEwE3Z9GrWTxqVYeYJj/jDOMQMiLqX+H7XMlysVVZvcFj+Wg0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3392b045e0aso2978939f8f.2;
        Tue, 23 Jan 2024 11:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036658; x=1706641458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn+lepiS7rkhDbbZH7m65f03Ws34UEaqD5c6bON/Htc=;
        b=TEMsb6+B9PktTKyN82naLQtVvwP81d8Dhu+V0nWyFUeQX8Cmr93ZiTx9as4tGKfGUJ
         F4Oc7UYeH3jVU8l5JjzwMadoYM/jzB0kf0jUX7voLxBN/BMHdR+23i/MHMt6tQ6TGWg7
         890a6giyZGnlF4/YFF07r3NcLrY8O+/1SIrvnE5tAPuNZHg+nbaAh3mO/kZCLyi79rxP
         T5z+YWvEi2RLkjHjj1oWNb7a9D99qGujeCJKePTf6TEMSO7U/35OsnfNOC/MTsnXidNm
         0F4zh2yejWIo+oFDnZQp/e5cEqLjlE2R2gL19vDlf8PUHxRzm5Z8au0AJHjseU76SBMa
         nNig==
X-Gm-Message-State: AOJu0YyppzSu6J2awwq8xCW08k68i1wyJpcrWKXO5LWD8ulShtB6bffR
	HiWXwuyhOx31GpVOkUDw3KEbe/l514/b3mzainn4lJNU6dgUq/ww
X-Google-Smtp-Source: AGHT+IF9N3gR0iRPZ2GIMdMCg0e+T6KHVXVZgNKi/H+jeKeR6mElswrc7MXd3swBEazczXpwsbUR9A==
X-Received: by 2002:a05:600c:548d:b0:40e:b6c6:89da with SMTP id iv13-20020a05600c548d00b0040eb6c689damr422571wmb.50.1706036657762;
        Tue, 23 Jan 2024 11:04:17 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709064bc100b00a2c70caccbasm14408942ejv.107.2024.01.23.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 07/10] net: fill in MODULE_DESCRIPTION()s for fec
Date: Tue, 23 Jan 2024 11:03:28 -0800
Message-Id: <20240123190332.677489-8-leitao@debian.org>
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
Add descriptions to the FEC (MPC8xx) Ethernet controller.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d42594f32275..4b0259e9269a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4769,4 +4769,5 @@ static struct platform_driver fec_driver = {
 
 module_platform_driver(fec_driver);
 
+MODULE_DESCRIPTION("NXP Fast Ethernet Controller (FEC) driver");
 MODULE_LICENSE("GPL");
-- 
2.39.3


