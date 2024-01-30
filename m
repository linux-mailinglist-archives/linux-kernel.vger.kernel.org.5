Return-Path: <linux-kernel+bounces-44186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8A841E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6041C24F25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269BE58120;
	Tue, 30 Jan 2024 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsgVOy9r"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58A57866;
	Tue, 30 Jan 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605020; cv=none; b=kY6m0DKzd/n5MxRbVC3yCXpn6I+6y3jEA8GJyGxAUNDA4RY6jtM6gKh8UFbLLspUqbkh1Dd/aI3z0pd5ZmJKqKniLfqsxO2x23JPKNdYUBa6Mu3+/i7Pu1j+/HkFqm/5WadjJbNyXe4WZvasFy5tw+rIMko+vDfwzQZ6+J8eBcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605020; c=relaxed/simple;
	bh=Vj6SzlkAD5KT+wFwS+h9MR3mauREpPgWpqHN84lJoaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oCAxC3SfRvUcWSc4lacxRCZcnYMYeaslbyuORAHvMPDibH7PpQizL7qQSyTFqu5jcb85x5o8BAWiKhKV+G5NCRs/HvraEOWLXynNx0/JhVFJhX65bT1D1sPStaDIEFM8hv0NvNlaXnA2/e4Th/y/0aAFnPy9DhCp4veRejTI9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsgVOy9r; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da202aa138so2243289b3a.2;
        Tue, 30 Jan 2024 00:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706605018; x=1707209818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csHtYc18T35qzB25mdonMqPpqm2KB0P8ynV8OZQpVBc=;
        b=RsgVOy9rDstRcMzC2svkowaacejgwjVf/ZK8TUv1egYexU1RcFVcaGIcxWcp2te8Fh
         gm9SDhPS8TtIlePAMQXlhoLOkQSJx4UEmAVcOKwBTL+xEnM+m1e06K3aH91EMoatK6YY
         FNOTaqbpnVoUD8dxGGRXRABzTsJN5DHtwfHmp7Rwrgd+K4I2vZvs5Ea7cFqA5DDfYk4X
         moetf9nkPMz5CLOfbvGpBHdXs0mo3bshSR/PVgucEh2iKognejo3spwOaT+9KZI8xltL
         g8ytZWUjS6yYZkbwl+HSMEaDquP+PR1722JOenMUBBD2C64E+X9vpf7gxyZg4AWaT1EU
         XowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605018; x=1707209818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csHtYc18T35qzB25mdonMqPpqm2KB0P8ynV8OZQpVBc=;
        b=C4vKNn1SMMpCRRe6vkY5DEcJ1zUTRJQbBtY3dMDfeWqT4n7p/t6E0L2mG++2BKEZlc
         +/SrSPzeBmV8hLP7OD65Ou2x1LMUJJd4bIJ+uuHS9RU/q0wUYCUvfhL4XKWqlteqdMQQ
         miSwmW0aoWvNoVbiKDXFI+z1uRskaTBF6twfJuCp5jNCds2URnyjM76zhTORIPRl1AAC
         H4vxqBc5PjppVGhMHpq48Ivx34xDjOCMxVcyqjWSC5ku1vlGQpM90KVhbVatA4rPPo2c
         rewbYcm8bcG9fDWMVUsHFudNlnyNbi9rEXp1pDtzLfCMiBYlxZesfQxbOu1SRHNTJD11
         P2Mw==
X-Gm-Message-State: AOJu0Yyzg6ayPKFCSGA7Jz4sRouF4ChdAVX9//78jShTLPzM7PXxgFiT
	64uDbofFuodRpuWHFOBzcMnGU3PKWHnrC0GdvRvmd18qE49rtXfg
X-Google-Smtp-Source: AGHT+IEeEh9/BgmgK6L5VDqDZJ/c+zKQ+BgD48oiN1HRyxWZSnWDQGOjvUOykG0CouswggmIuzdQRw==
X-Received: by 2002:a05:6a00:2d05:b0:6db:cd50:a716 with SMTP id fa5-20020a056a002d0500b006dbcd50a716mr7165222pfb.1.1706605018330;
        Tue, 30 Jan 2024 00:56:58 -0800 (PST)
Received: from localhost.localdomain ([124.218.12.74])
        by smtp.gmail.com with ESMTPSA id gx20-20020a056a001e1400b006dde04c10dasm7188623pfb.217.2024.01.30.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:56:57 -0800 (PST)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kelly_hung@asus.com,
	Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH] ARM: dts: aspeed: asus: Add ASUS X4TF BMC
Date: Tue, 30 Jan 2024 16:56:51 +0800
Message-Id: <20240130085652.198010-1-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This initial device-tree provides the necessary configuration for
basic BMC functionality and work on ASUS X4TF production.

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3ff8..80009948e14a 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,x4tf
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
-- 
2.25.1


