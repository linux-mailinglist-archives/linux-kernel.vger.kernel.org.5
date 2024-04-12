Return-Path: <linux-kernel+bounces-142371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F04A8A2ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B11288538
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1D451C30;
	Fri, 12 Apr 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi193vrA"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE304D5AA;
	Fri, 12 Apr 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913490; cv=none; b=SIrFMIAOYtz9sQ74UpdCvTluxvdvzolyLC3KsHUTDfkOwVw4HKRoV9JyQHHrIdbUUs/yz9mr+EmPt7ul2lmrKec4b/IJZCPxrcQyxWLTv+xH6hgXWG8ISEQZk8LakQoNX/DGB87ZeyiNGNJ32P+60lBiZvR8RDrJdSAalX34jH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913490; c=relaxed/simple;
	bh=jrZsfxGFb5OwlFxmHPa2McZe5EXAS4Q4p4WkXFyXdAE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLCE6/pmRR6rbXgydoiCkZ+WbIMoicqn7vs0UI43erXsAv1F42zL0O+ek+DwpLDyhNqkVQIdsMuhWaZHTiwTBKfnuQHtlT4Lif3cjxjwADIlvEL2XCyXUpDYwu8TxTcELu7EOWkQhSd1CPP1DGkkxVxUUXerR6OhkREnGRlZb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi193vrA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6eaf1005fcaso505832b3a.3;
        Fri, 12 Apr 2024 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913488; x=1713518288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9gw/r9/c3rfzTKOctHkkj/jJp3NoZ5uGYQMJ7KvSBg=;
        b=Xi193vrA9Sbowxx06WE/di+gKSER5yUqe4Kd8P79xEXdoFfGreSfAI0x/v8j1nPGJM
         hl++b4MFDZrm7R+cjJiZ6nB4Zac3kyCtnd/1efj9rPWrS6J9f1g7POrhGJIEugRnnKyR
         823jTu0qCVNZSrzFXAoS6EoQ9Fgd/muBUShfYKuyemiGFbnlhlE05XVwSL4tlfzhaKTv
         dhTbcBW+sYbXCvGr6KMEtt2k/W461eHu26vtRiboSIoQLuTBGFsw8YAdsGCPNPeWWDY1
         MnVjWndF+dNH34TB6Xq0ChPE9aFDmCc93oqpnEXxzCtHco2EbI7017JWGMBKLWzcpmZq
         toBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913488; x=1713518288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9gw/r9/c3rfzTKOctHkkj/jJp3NoZ5uGYQMJ7KvSBg=;
        b=RaoOt2FvmsXZK1B3F/yJxsvam+0STXIfCxN1gKpoWI8RGRmlDVkqdHp1phCTBcZUNI
         zvy90d35C9vG/X/DEOdtra+Fgz4ha8OU5WNV/MShicZ5MWGo3AihWblGhHcYVdMxaVsI
         ES8TIK/c8DpJhwM7eC1/RuipqFyKb/SCE6iXplEANIBmV3Nfa2ishy68avci9zpysT3n
         mrlI5i/3WclfadcJ80Vw6RZBF6sXmuxM7tvkx14V6FYIQetRKfaKXHzufLBx+xToigOp
         7lzulgr7R9abeAZsVVoCjbWWoGOQb9/xzI/K5MWdu2CDXUuL5DSe+TTfG/+iu7sMlr15
         SuTw==
X-Forwarded-Encrypted: i=1; AJvYcCXbNY1yqogxg/zS3YTp4wdeB0Mnhjna46BnwfDujj4GVLq6ke0VOETjOZB+PVSZcfQYEhdYLbMAxFctK/VaaloperF1lW34xGVbwYZlH40EyeTpw6pTF2bWA5xRcJTO4F5YaNIafc79AQ==
X-Gm-Message-State: AOJu0YzHLPHFOhhP/IuU/vyqEe6ZcuJYdJxipMiEZNVymWyiGjN18qWS
	ghzFhkE2c+70vyWMQYMZPHnpV791LoOC6nbFQEtvh+VXWrn9aQpdncz8TQ==
X-Google-Smtp-Source: AGHT+IE6BE5us6WituvhqAzwCK8bMxEiztNY2ednF+FJg33Ns5kiepLJL7m+WKtePVeLcDcoLpp94Q==
X-Received: by 2002:a05:6a00:4686:b0:6ee:1b6e:662a with SMTP id de6-20020a056a00468600b006ee1b6e662amr1608206pfb.32.1712913487570;
        Fri, 12 Apr 2024 02:18:07 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:07 -0700 (PDT)
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
Subject: [PATCH v5 01/12] ARM: dts: aspeed: Harma: Revise SGPIO line name.
Date: Fri, 12 Apr 2024 17:15:49 +0800
Message-Id: <20240412091600.2534693-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The same name as reset-control-smb-e1s
change to reset-control-smb-e1s-0 and reset-control-smb-e1s-0.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 7db3f9eb0016..8a173863ef24 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -505,9 +505,9 @@ &sgpiom0 {
 	"","reset-control-cpu0-p1-mux",
 	"","reset-control-e1s-mux",
 	"power-host-good","reset-control-mb-mux",
-	"","reset-control-smb-e1s",
+	"","reset-control-smb-e1s-0",
 	/*E0-E3 line 64-71*/
-	"","reset-control-smb-e1s",
+	"","reset-control-smb-e1s-1",
 	"host-ready-n","reset-control-srst",
 	"presence-e1s-0","reset-control-usb-hub",
 	"","reset-control",
-- 
2.25.1


