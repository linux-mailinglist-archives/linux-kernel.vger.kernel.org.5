Return-Path: <linux-kernel+bounces-2540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEA9815EA6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A597D2833A1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04FE15E80;
	Sun, 17 Dec 2023 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGDjNVoT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5814F7D;
	Sun, 17 Dec 2023 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28a5d0ebf1fso2368188a91.0;
        Sun, 17 Dec 2023 03:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702811406; x=1703416206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpLgj+Aq6CVLom9PNEYmZqsQRdUdLCvYGUYGYFlcfB0=;
        b=OGDjNVoTFvLe3LjjSbfIY5uyYUiRws1Tvo3G4pkG3/UX6wFE8yiBNJsXdhBxtX38H5
         Bb7vpr1m1X3RpbenMToWjZkYCmmoDVeFy2KpSU4OKXD/DWWzxuDNvg09lLY/RYyaI0uw
         rc+JWyUQOoRylN3SonYEmOpL7sOjBaj1I7ZH7VXJ5XvW+volUByRRtJCJyHnrrnjkyf+
         ATHLARrtwj9k9tzuFUwxgMwTfJdeje3sbj0TqC9MLwaCPqOBjJbjbq2obgZzUz4CKqqG
         bbJNg4gviIoU8Vn4MB6fdsfhIkOH3/UxhjdzFBwWMyd2it7LHkhNIK8nRZlQ4OQTdxWc
         VKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702811406; x=1703416206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpLgj+Aq6CVLom9PNEYmZqsQRdUdLCvYGUYGYFlcfB0=;
        b=kzm3aAh+jU4h+4QFfliOrTXkcoEVLYMiK7nFX3WgkWMDpg66NcxRwp3MIpXhfDJspy
         JXC/QFqcRH+WiZzrqy++LExPMx9YVzG8GYw00CjYeUycHEva29agYMvpIncX+swjdQ94
         0Y8BIXHjJOH+zsMvD6hqE9cb32FWtcASq4F10xB9LUkMFVpPYTd/Apc/FZPAHxgMem3K
         sicFrLWO0w8sgyWOaTUOmV3tL7TxCsygoIZ6gK8toIchct4jrKSuaWJqV32pAXFrb9Z8
         u3os9iFQvcRR0GmqlQYrguf7EEJs6eb9nTPUZ6TnDI8C1fdPPNy3e996bnv73tjKvZyl
         XdcA==
X-Gm-Message-State: AOJu0YzBXqsRv1ePbJy29w3EQL6pc6t2cdemoK8XELvZbH1x0baB9dS6
	0UL7i5H+YEGk7jW7GDAPikE=
X-Google-Smtp-Source: AGHT+IGSGhqk36Sb0bNiK9Sn2fYBgsgfe76pjCUWW1+gApLE4Cc0FGCQwd9Te7RuB5CDKuULss5zCQ==
X-Received: by 2002:a17:90a:77cc:b0:28b:5fc3:36c9 with SMTP id e12-20020a17090a77cc00b0028b5fc336c9mr1613224pjs.29.1702811406171;
        Sun, 17 Dec 2023 03:10:06 -0800 (PST)
Received: from localhost ([2404:7ac0:40d7:b2b2:a626:6b41:27ff:87a3])
        by smtp.gmail.com with ESMTPSA id ms16-20020a17090b235000b0028b06464b62sm1165747pjb.15.2023.12.17.03.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 03:10:05 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v2 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
Date: Sun, 17 Dec 2023 19:09:52 +0800
Message-Id: <20231217110952.78784-4-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
References: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the rtc device tree node to cv1800 SoC.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index df40e87ee063..429bee76f677 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -119,5 +119,12 @@ clint: timer@74000000 {
 			reg = <0x74000000 0x10000>;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
+
+		rtc@5025000 {
+			compatible = "sophgo,cv1800-rtc";
+			reg = <0x5025000 0x1000>, <0x5026000 0x1000>;
+			clocks = <&osc>;
+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.25.1


