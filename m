Return-Path: <linux-kernel+bounces-39205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E12283CC7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408AF1C233D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E22B13E206;
	Thu, 25 Jan 2024 19:35:17 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C57B137C26;
	Thu, 25 Jan 2024 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211317; cv=none; b=b278bf+va9ozuFfmgPHsV/xXCUsPYFw3xnJ3BTUVAPSgbCSL3Zp3fedbLyj2WCa0ZSpSJBuIejNgK7QU/q2qG0HSiugmhsoPFSCusbfGpP+a6zBv4jjQlDqRi6Z+wsBwLg25xKoTRj9LkTykoNJd3mjDqCGRxR9XpqhOq544WX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211317; c=relaxed/simple;
	bh=2FcpcK//gV6t4tbeKRXqr0tCEGpr2xkrWi07ki4Ib+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2FlnT0F12KsicFBlDshjX7dV+iz/jUon5n+o7PzGYH4n8rADBbXrfbKbuIT5QG7tofJd+Zy4VsKsM51BP+e/r+GgmjZsSYIVo8UTaW6O2I6ika0NMTakbryvU4a0nQqbIxB26KZd/nI7n/BJPuIWdxAWfAh7MBInX1z0XbMcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a310409589aso290738766b.3;
        Thu, 25 Jan 2024 11:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211314; x=1706816114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sifsnwJKjbeVUw+8v1vwo1kqKRBi0h7LZ0ZH//xM3QQ=;
        b=D7PfEuaacf2hXLovCQBwv05bdZLZaW39QDmoIXTbNV0D7emRvDqWyx3Gq87g/4lEgA
         jPulwjytHXvX6nsyN9c8rUFbW6xmenRnWcINl6BD1+gv77gxJFs5K5akGd9RvaepuqIn
         uZrE+jK9vuBQCkenUTVm3PE4vTr6Bdp5YaFcRdcpvyltUpLt9q8m5tkY6htBMeITnjfl
         rjOU3IIrgfP/BjWqE+Gc+rW79Go9I6DWtFUp6UobErzrKA9ivvSr+zMo3v4eWdV6dMai
         rphhOY/Y1qYCvUJO+xHNDR4IClGt6t3LvKLDeXR26+6K0lpnRj13O+307pE543N55qym
         zIhg==
X-Gm-Message-State: AOJu0YwL6zjbEf/pH+8gVIMWnNyuk9ik/N5uAfS4zw7EiOiWsvcj5LWq
	wHJT1VmrULmeMu3N4Syu1zZV3SIjySx+wfGuW1wiBVlKZGvBODXG
X-Google-Smtp-Source: AGHT+IH/HtJFxrl8kGqO7V8kZPGAJG8u6/1yMAxb+fxONZq/rFfhVM0gbtjmKnTUIWumYydzMuzhLw==
X-Received: by 2002:a17:906:488f:b0:a2f:7240:4d84 with SMTP id v15-20020a170906488f00b00a2f72404d84mr37492ejq.28.1706211313914;
        Thu, 25 Jan 2024 11:35:13 -0800 (PST)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id gh10-20020a170906e08a00b00a311a360433sm1356509ejb.143.2024.01.25.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:35:13 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Dariusz Marcinkiewicz <reksio@newterm.pl>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 07/10] net: fill in MODULE_DESCRIPTION()s for ec_bhf
Date: Thu, 25 Jan 2024 11:34:17 -0800
Message-Id: <20240125193420.533604-8-leitao@debian.org>
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
Add descriptions to the Beckhoff CX5020 EtherCAT Ethernet driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/ec_bhf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ec_bhf.c b/drivers/net/ethernet/ec_bhf.c
index c2c5c589a5e3..44af1d13d931 100644
--- a/drivers/net/ethernet/ec_bhf.c
+++ b/drivers/net/ethernet/ec_bhf.c
@@ -590,5 +590,6 @@ module_pci_driver(pci_driver);
 module_param(polling_frequency, long, 0444);
 MODULE_PARM_DESC(polling_frequency, "Polling timer frequency in ns");
 
+MODULE_DESCRIPTION("Beckhoff CX5020 EtherCAT Ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dariusz Marcinkiewicz <reksio@newterm.pl>");
-- 
2.39.3


