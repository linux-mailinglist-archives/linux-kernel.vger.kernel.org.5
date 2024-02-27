Return-Path: <linux-kernel+bounces-82556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7F0868657
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E50B1C2613B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A35F4EB;
	Tue, 27 Feb 2024 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGPf5/Mw"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78232260A;
	Tue, 27 Feb 2024 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998458; cv=none; b=VLk9I9wI4dIWzV0PZ6u6lPwNUEvbAV6ef9FwFlUOMFL9JmqGL4iYiBKTciVWKF3zPRyK/LJwHb9I3HJ2LggmYT8CTt4aihBVIksWfC9wbnbmdtGlfJyJvbkJT/3F0jADx7SqWMiN0JBeqebloOW0+XFbGvr3bL3i52QERWJ++eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998458; c=relaxed/simple;
	bh=JKiYk0LR7yM+OlGvUuYEMLdDUknawu7uYlYpmKIx9Ik=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRSTmi/ciVlQBbYq0mmzqa5tca8UhTXKrKy+MK5coPXJMvDE0RtbOibX9SURU0NiDC43ik087jMqeSClHJKWq3TIrJnCnksFc4pt1zmEitlBlDMwtC48RhHRxOVn3Lx7XDrXacmBomxYWQU3F+hM2HsqHjVnQOZ2Ql1cN32oDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGPf5/Mw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d93edfa76dso32365615ad.1;
        Mon, 26 Feb 2024 17:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998456; x=1709603256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mmt0UdSDV+w1BWZtmNFxfAxPy3KjCbVYZPCzBNdDlQ=;
        b=eGPf5/MwfBI4KqHjsv2AhpRdjmGsfo5waOUVTMuacoV6Br1f2QvdfarWx+WFNijrQD
         1F7s2LJZ5cRDUo464/1/2wmkDk8R4HLt8M//II17kQyAW7/DaukP0/vC2GlEfD2Dfyzy
         fUC9C1VA5O7tcl36LlxRAmTtWrNbnNZswyVAb/UvtfBJfTGihbYeCzh+8VQ9wRAl3HTN
         aPs3Yn0FZx6WORW1QFGF9npj+Ts6oznok+K3Vc5w22sRIWSiU1eZhJStDwdAZuwp9ozY
         ZO8W7YqdYakvFQK3BJZ3nS46YpHIwRdXF2R/0TtkOGTm8zJAvqN4u/qmRC+FsQKshjaY
         vxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998456; x=1709603256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mmt0UdSDV+w1BWZtmNFxfAxPy3KjCbVYZPCzBNdDlQ=;
        b=mcIfhyO27TAu1k2NYznNN12jydVynF64xAwls5787ip0nDIExfF100eWIpzCHIUL9M
         sKHRFrMip+VZwflgG6Bi9/gkfsy6qg9ITHCLAnJlXLGVsAWNE0qFaI8eqlr9LquSHooG
         NkL7ZQRaqzlhapZ5JRWgYRfJh/Cw2BqWuj8UjP1WHR0YtduEXy9M5eWq51HdItuBtEiG
         N+xikdHbV+lkF44DSEWxn3ubN8jd1Xuf3p0IcF26cVAqpP6ecZXAAM2iHVJXLYzZhvLj
         nYDGGl2bUwAv+uLe3h96zOfcvoUmg36EYNitOdbgO0DlgTEEx6lxTZN2ycnKYpZarCsu
         WuYw==
X-Forwarded-Encrypted: i=1; AJvYcCWPHuGFFOLBAkCjIGWz9a+NVu3yg67SJtyjQEwJw5JpiRRf0AF4gGEcAp/kIjQSF/Wetg0hspsyv8d6CseDa3ePAOA4D4rIWFAb/yFkzH6laxhDcP77QgeFdn+uvJH9lro3ExrQQTcUlw==
X-Gm-Message-State: AOJu0Yxkycpn8JmS5zYj+bTxLSL6fIaPZvzNAKXDfOCDOCyBzMF9XNIu
	hDbgyas1n7cfGoAiVtVvN/Fiohru//tJJELUi6VTAxOwEPbW/ObUQwjql4r6
X-Google-Smtp-Source: AGHT+IF/R8F2vCv8LwWiPNVhtvuPYrnqX7K+5pgbmlEmQC5kMGnDWfZijmTSEK7X7o7tnH0QeGVCtA==
X-Received: by 2002:a17:902:6546:b0:1db:aa46:4923 with SMTP id d6-20020a170902654600b001dbaa464923mr9339802pln.40.1708998456003;
        Mon, 26 Feb 2024 17:47:36 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e381-af24-f369-7cbc-56bf-1d54.emome-ip6.hinet.net. [2001:b400:e381:af24:f369:7cbc:56bf:1d54])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm318893plb.280.2024.02.26.17.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:47:35 -0800 (PST)
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
Subject: [PATCH v4 04/10] ARM: dts: aspeed: Harma: Add cpu power good line name
Date: Tue, 27 Feb 2024 09:47:13 +0800
Message-Id: <20240227014719.3037588-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
References: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a line name for cpu power good.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 5d692e9f541e..36aad01dda20 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -501,7 +501,7 @@ &sgpiom0 {
 	"","reset-control-cpu0-p1-mux",
 	"","reset-control-e1s-mux",
 	"power-host-good","reset-control-mb-mux",
-	"","reset-control-smb-e1s-0",
+	"power-cpu-good","reset-control-smb-e1s-0",
 	/*E0-E3 line 64-71*/
 	"","reset-control-smb-e1s-1",
 	"host-ready-n","reset-control-srst",
-- 
2.25.1


