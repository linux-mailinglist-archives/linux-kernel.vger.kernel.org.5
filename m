Return-Path: <linux-kernel+bounces-45671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223028433D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EAF28D906
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9464F4FC;
	Wed, 31 Jan 2024 02:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqXjpqcx"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318CEFBED;
	Wed, 31 Jan 2024 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667998; cv=none; b=IwW2/OD7eSBoZe7X2Q1ahlI2CDsJitCPcsWXN6tbwpKsuIsF5cmAh/GEmclwpawwxsXr+NrbJSKtSh43UKVQ1lj3nrTsa2zrcuxJH5VzZP5FP7Rv8it35asDX2nT290RiAzxsg8HLhF1w3kWjLQ9yKhG3m2+0WZHe/Kxud/AFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667998; c=relaxed/simple;
	bh=EWl5WJhyGhHQRYYPH3ZG3ozKOxHrsOuIxslPmZVW9No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCRSEh4zOmss4HVkSmXu3uW/oZoyqcZZ7xCsroh1pg4Ptinp4tWVHinYhF3a/FzWrhvdAuhWyCzIRwjVtt20hN2QQDqDrTig5a5HJva/dlD8b1+hPsjry/Fwig7rtyhkjRC0OTp1RKdJKA3qUTpibQ3M/CRqs0Uf4Ew9NfBUpPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqXjpqcx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so10862115e9.1;
        Tue, 30 Jan 2024 18:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706667995; x=1707272795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD4Rxo3u2FKJPesJyRDxNog+LphdfZ0gkglhIxv3bHg=;
        b=SqXjpqcxrks0531w27MSGU5zgEQoCo4vWpY1VZUtv4xZhZcez2swNFRhK3ZkRF+Bfp
         uLHt6VeXMZ0pAFkr2TK8cGE9Qb1RRayZTOy2w8z9GYQLcFSdD3wP3/154EsvAWdKgEhF
         gODxJWY3del5AXGwi65ZSP87N/20sm9l+D9cPzg4SRkpN5qbSEBo82B3iiIllPEz1Zq0
         LE7gXLm1vB/xqrxbudzZ3EzLeq1FrMh04e7Tz2mBxi5+HYQ9H3Yy7m7y0nDrrP+zaeNL
         GW2T0yvGUZKJi8+mGRloeu/OwHayt9eGTQdk0ser9GgKstIUeOUm8wI/S+5X934dZZpB
         n6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706667995; x=1707272795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iD4Rxo3u2FKJPesJyRDxNog+LphdfZ0gkglhIxv3bHg=;
        b=ohGtt71Z9IU0LVtist/XteyCYcJ5Pyr8511R2N0ecrmZjAJm99jdhMWZ/naJ7rdaQ8
         Wr7mmYbH4O1zLsO8C5cxxlQbm74m1g5oSBGS+2L3Wr7qV5mk73qPgSO9HLUbjDJelA74
         pux9tsEFDGgUPRowwkJi0ojJO6OrHoijtcgGXtobqnCcqwvX6MmsDePE3f1Nod5icrt8
         BUx55HiH/TcMMAOdTcn31gmbBwi/efYnt8KxeVWu56bXYw8UOLAmApk8M/5B+4tEDRdo
         zZ1n6GZWgn/+C2OGVTjZENcY6LWaNvIcMTVeI69uwIjm7dDkLogZFWvvkJ5D5IJQ2wDW
         fFxg==
X-Gm-Message-State: AOJu0YwRbIiBfRqr0Pcxl1ZPyeNcx1qwNPPNw3zHptDXmcKHjQAJtyy0
	auzjgnpCpKR9pkdAcjQcWRSqWKkKS1oLnph1q8z8Ws1/NCuQ6mF7
X-Google-Smtp-Source: AGHT+IGSgXgTXkG3lfD32ROW9sJ2J8yuS6WwuxAlSGlz5k+csgshwEQfQI5rgMyCVbU/gf7s257jsg==
X-Received: by 2002:a05:600c:4fc6:b0:40e:c2b8:ad3c with SMTP id o6-20020a05600c4fc600b0040ec2b8ad3cmr183006wmq.32.1706667995065;
        Tue, 30 Jan 2024 18:26:35 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id f22-20020a7bc8d6000000b0040eea5dc778sm757722wml.1.2024.01.30.18.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 18:26:34 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v3 1/2] dt-bindings: net: ipq4019-mdio: document now supported clock-frequency
Date: Wed, 31 Jan 2024 03:26:03 +0100
Message-ID: <20240131022606.1532-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131022606.1532-1-ansuelsmth@gmail.com>
References: <20240131022606.1532-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for clock-frequency and add details on why this
property is needed and what values are supported.

From internal documentation, while other values are supported, the
correct function of the MDIO bus is not assured hence add only the
suggested supported values to the property enum.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../bindings/net/qcom,ipq4019-mdio.yaml           | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
index 3407e909e8a7..0029e197a825 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
@@ -44,6 +44,21 @@ properties:
     items:
       - const: gcc_mdio_ahb_clk
 
+  clock-frequency:
+    description:
+      The MDIO bus clock that must be output by the MDIO bus hardware, if
+      absent, the default hardware values are used.
+
+      MDC rate is feed by an external clock (fixed 100MHz) and is divider
+      internally. The default divider is /256 resulting in the default rate
+      applied of 390KHz.
+
+      To follow 802.3 standard that instruct up to 2.5MHz by default, if
+      this property is not declared and the divider is set to /256, by
+      default 1.5625Mhz is select.
+    enum: [ 390625, 781250, 1562500, 3125000, 6250000, 12500000 ]
+    default: 1562500
+
 required:
   - compatible
   - reg
-- 
2.43.0


