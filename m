Return-Path: <linux-kernel+bounces-43677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D634F84178F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153E11C22D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2113236AEB;
	Tue, 30 Jan 2024 00:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/Ge8NMV"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0DD2EAF7;
	Tue, 30 Jan 2024 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706574968; cv=none; b=Xwps3OCyFt1BxA1TXR5LsI3fl86IUfI68CQ1WRQXVSSDaW8My9MtEp/RP2HihA+tKeNxBIAHOibveU5/7AD1gqPlfu02E0U/mRBS3eLFInwCotiQjs3+HodJGMmbprUWVLnK7aeQ1tTRxk3Px48thtN/39xaKx+NYtysM+oOxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706574968; c=relaxed/simple;
	bh=AOE7n0KnewlaWwxbj8BBqxz1kEl4nUkcJEnkd3Rd1CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0L937mNEwsDNSf6FeWYUfL946dDVlvHch9mV0bNNJ4vp9bXdQWQRFXT9mAQWYbGmo6CI0d0DjCPRiweCUci9saamYEKorFni46fplJRdzV95Xr5oPYgbNjsQOIWPqA/odiwwUVfpZdE5wmChb+2IFm2lqNs7a2kK9Ijht8qHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/Ge8NMV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33926ccbc80so2048066f8f.0;
        Mon, 29 Jan 2024 16:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706574965; x=1707179765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q3Rs7PU6VZ7DHw5oiGFQEWFBt/lSJt0fN7k2NTIpww=;
        b=j/Ge8NMVfqOkF9L3ThouhsrkEhlfdGjAjq5biANy1aSk/6XzOAaQHnxgm7dXlvMUMs
         nVx80SpIkemvxiIoqOkS7YHfLcAf4h6dfNi4swY2PeuiheKliWXfD3QAErx751XBS0Vv
         7Ja/SnQLi0FW9sS4mYeDjmWX1GKdvsLWG3h+wsauI2iyWqJvZohwE9AoYVrT4LSpDUHn
         56ABsZNngxy63ODFgwFssjtsnu2xzOcYgNX0a9gJRkrpWnEz7mNRresd15AqGmub/VUI
         DgcAfvAw6Ekr2xv/oSYVul5YAGkXlV8Z1Q84P8/M5CRiuYgHpYm20opo3VAb3/zEFDNB
         easg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706574965; x=1707179765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Q3Rs7PU6VZ7DHw5oiGFQEWFBt/lSJt0fN7k2NTIpww=;
        b=G8Jh0A1oqycmf2reUM/OBHKtB9/yJffGgjYFsOvFgMlnztplrJa/66VDfseMWJjZau
         P3TZhkCb1MkV5NhF+NtUbpLoLnU8RQeLVzD45VTGea8sAz+njKZbmYaCiZgDqgoN0IrO
         5gVZuO9zjxQOUOAAa89KWgOt4A+1mBgyg5F4deHT4BNDdvWHosnJKiR+FNbZn8fbGR+D
         ae59cl/j2SVwU67q8qtMKNqymA008gXTX80r+HClmE4y4LgbmEJYwWZ1n5rMJfGbBLfX
         YlYW7pzJpTjMOsiJy+zmDtyr5j8FQPCpuFbio9663Prv1q21H4JOdzlrqXSXv04QCM91
         gbzg==
X-Gm-Message-State: AOJu0YyTIKNGNEMm3UUItiRdy69YL4As31XXc7i5IxsW0cWQrw9x3GSz
	Xq/+7tvJlTkgOnN/kn0pIxtJjS9+84RxLRhZFTPjBViSwWWbnm+p
X-Google-Smtp-Source: AGHT+IFbkckzAqMPlJhqybLQRcsbZiE3mq3fxUSAmWAwpLn5s5XQHbQ1vg+/EC6MwAlk8uRjqyRSlA==
X-Received: by 2002:a5d:64ed:0:b0:33a:e39a:1590 with SMTP id g13-20020a5d64ed000000b0033ae39a1590mr6412578wri.53.1706574964763;
        Mon, 29 Jan 2024 16:36:04 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l10-20020a056000022a00b0033af350fb88sm2542167wrz.25.2024.01.29.16.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:36:04 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Jie Luo <quic_luoj@quicinc.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 3/3] arm64: dts: qcom: ipq8074: add clock-frequency to MDIO node
Date: Tue, 30 Jan 2024 01:35:22 +0100
Message-ID: <20240130003546.1546-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130003546.1546-1-ansuelsmth@gmail.com>
References: <20240130003546.1546-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clock-frequency to MDIO node to set the MDC rate to 6.25Mhz instead
of using the default value of 390KHz from MDIO default divider.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 2f275c84e566..08ddfeece043 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -264,6 +264,8 @@ mdio: mdio@90000 {
 			clocks = <&gcc GCC_MDIO_AHB_CLK>;
 			clock-names = "gcc_mdio_ahb_clk";
 
+			clock-frequency = <6250000>;
+
 			status = "disabled";
 		};
 
-- 
2.43.0


