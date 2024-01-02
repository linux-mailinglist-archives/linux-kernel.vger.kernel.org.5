Return-Path: <linux-kernel+bounces-14021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DA8216F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E171F219CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9682594;
	Tue,  2 Jan 2024 04:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYmJrX2C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F61FD2;
	Tue,  2 Jan 2024 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28cc07d8876so368245a91.1;
        Mon, 01 Jan 2024 20:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704170777; x=1704775577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pegTGAgIl7701EaFNdsQSg89lpjeCGj36MeNrr3t5wk=;
        b=QYmJrX2Ctn4Ul+pB+n2RLGr1NHyZtG1jpNJ/eTdzZCTgc0a8k1Xwx/WsA1HUk7vK3r
         A+m9jT2Lal589uc9aVpBZT9eAJB7YziqEh4eutXh4cmn7lzrHKURS/SHlGEgupdVzjNG
         fOnkWc/WF9NO3eGOJq7cDc2Tfgui1dtdT93uX9M9ETdGhZjdZdbtWCwdhIOkTDikXQcP
         ijlMV8bx2KCdIdjPFRr4RtRTuTpnMOD7k3wyEodW5l3a0C6eY5oBCM80haZBlQdYxVSi
         VPOh63qqPXlKQ2QOinDWPeDjWqwIPpJthFoiNERqiTZUwWYhMQW9TFwx8JuwV576Juzc
         iujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704170777; x=1704775577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pegTGAgIl7701EaFNdsQSg89lpjeCGj36MeNrr3t5wk=;
        b=ZhKOfk+j9X/WZLNtuArMq2EatU+i2ouDxvO4Jpamrc3rqz82evgVyPweyAXegiEYci
         kk1yfsYaI7j1ftvxJ9CJc/rq7/FvKow5CYbxlzJmOKnVrUOlqYoBEFyb5+Z07X0AIJKZ
         AjWk8+lBimjnZ+NH27QYQxnKiue5FDtcD3qpFNJ/9W11fkllt1Z9NsIH6kCnxpq/b64t
         OieOF/jyuoWNJswwqOed5eB+gURTtE6pmzbUaQPeXySoHSdnr8vbLjO2CciqvP7Zdw/9
         vOIRXO8reMDD9sucfY8hwQPBVjts4w+HrLwCRbmtDfLRHONCWvrQJUl1TIg1I/eDj/cO
         7ZQA==
X-Gm-Message-State: AOJu0YxX+lAVDCMZ8Yb5IUR1beFgig6JbYEYAjZP3yylbJoIN6RblVKg
	m/yJbzbJhGFBdcK9gWCuqSA=
X-Google-Smtp-Source: AGHT+IF3LqXMu5rUi/ayumGisrNXTGKX7bcbdyYwyFjHp54a4fVsRcuAeq2mGkGmVOteQsOtxFRFeA==
X-Received: by 2002:a17:90a:f98d:b0:28c:843c:105b with SMTP id cq13-20020a17090af98d00b0028c843c105bmr3699238pjb.27.1704170777666;
        Mon, 01 Jan 2024 20:46:17 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b0028c2b2b76c0sm17308392pjs.22.2024.01.01.20.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 20:46:17 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
Date: Tue,  2 Jan 2024 12:44:06 +0800
Message-Id: <20240102044409.3810873-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
References: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change routing to match SOL(Serial Over LAN) settings.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 8a173863ef24..a0056d633eb1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -12,8 +12,8 @@ / {
 
 	aliases {
 		serial0 = &uart1;
-		serial1 = &uart6;
-		serial2 = &uart2;
+		serial1 = &uart2;
+		serial2 = &uart4;
 		serial4 = &uart5;
 
 		i2c20 = &imux20;
-- 
2.25.1


