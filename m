Return-Path: <linux-kernel+bounces-82561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA976868662
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DB51C26911
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175A455764;
	Tue, 27 Feb 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlnFHOWD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6BB54F8C;
	Tue, 27 Feb 2024 01:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998472; cv=none; b=S4mzOxfI1ViiSRir07gWfYcoHzb6NNtZfpT9fUJGjlVvar1MWh8fK812ZwOn6SHX7SbZJetd+Ijsoij0VDr/biCqf+35DLua+gxUZodvsc2X2/yIkfW+5AmuCZ4U9m1E8va9743NM036nzTFUpIjRUDc2Kijb6gNpepNuCJvk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998472; c=relaxed/simple;
	bh=t8JcB3RZX13P1Si04c29fA1T7OnQW4aKxCQBN7Uqsgk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WOzuoDcfeg7umthavqI/dJ6JR6EPXZBv5UOxHXhGk2KqIToFXb1CqLiIO0Y3DlaO2J+k92ChnnuYCSL/ULkM7duBQZIPXap0TJ+B9ZwL+g9oXkYAIC354hEQzVxZTiMe98Y8Pdim+N/PsiQ8IkE78Nxlc5i+TzSsgvPOlVu5acQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlnFHOWD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d94b222a3aso38402185ad.2;
        Mon, 26 Feb 2024 17:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708998470; x=1709603270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aW3rP8p4z3TO0Ihdn0FuHfBWSAl8GOUADIxx8TKfnls=;
        b=XlnFHOWD1kVSQ6XlVX/0vjyuS/NmqvFE9vb3Iw2JHBKlv8PPF0A+59IetCVOK9tUJa
         zcwEuZVqx6bcu0DppiYwkraMP+rCP1wO1gjwccajfuU3kvnjZhBCBOLX2R+5RJl74Y2b
         7jbIQoicSVN3fhB1DLzibjvr7XbWSKYDOLzxblIX7bWaJXeRoAOHVNP/IQ8/tiiQm8fH
         QitVqf2rxwjfuR+vdYHRsCwfw3iq7OCqao2+pC7WSHPlPhaoYR7ajUABbguAUID7Wz8u
         G8DvnO1UmU1gRHe402lBruWSvj+KVZ4K1qcHwEGuNg/6n80g1rEwheEC/ei1LgtdJwru
         22wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998470; x=1709603270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW3rP8p4z3TO0Ihdn0FuHfBWSAl8GOUADIxx8TKfnls=;
        b=Vmon4aVcVBWuHh/iAQ0ENzqNISi2lLJERpnV/73/YFYBfkknEuW1LCvQO8JMfZDJoo
         0ts8G028lqwzily1mCSG6g3UbYJRslmRIBJsLdquGrRyJX5SVVnjnTGIKgCYotsLFAvv
         eoKVNwqYUmLY1eBAdvfH4bldl/jzI8Zo6HPzG0870eV9yvui7M4nTdHkMFCxkzPgUCx+
         sb6si/Bp+o/bcKj4tauayd4Xs1dJzJZYBo/8cLM8jDwp6Quq1F6O207ABV7bDwSjXPuw
         bAjH+BMMIUvPm/+m0wwERzEllSBiWkkbZmfmV+quxP6yw2YjVA897HoAWMtN3NRiLzTJ
         BH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhY7ZNpmcCGQzvn1skQQEMdueGmTa+/d1KeuZu1r6gxSFDRVMm7GvUwme8NdrosezdEC8Go1IFRPE/atZ7LYkZd39Ds58V2LP+vUga6RpUicyJRG8MuNe8k0kcMLJYi3YUkY3DBrqPXg==
X-Gm-Message-State: AOJu0YwaDtleiJLeqR+Ojw7xPLjX8oVg7bKFuQR+iy2AF5iSywyEnUhM
	L5z9HkvZ82mDD/m7EOlcT5YlqUsARu4s8I8cNLlxgZaPyVKFXPxJ
X-Google-Smtp-Source: AGHT+IEBX4FYb4gOFGZPwQ743sNbT9oZl7lMS6oM4vUbM7iuca8bfrna2+jJ549qvM3NYZaT4J9nHA==
X-Received: by 2002:a17:902:7613:b0:1dc:63a0:8c6d with SMTP id k19-20020a170902761300b001dc63a08c6dmr9180109pll.40.1708998470559;
        Mon, 26 Feb 2024 17:47:50 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e381-af24-f369-7cbc-56bf-1d54.emome-ip6.hinet.net. [2001:b400:e381:af24:f369:7cbc:56bf:1d54])
        by smtp.gmail.com with ESMTPSA id kl14-20020a170903074e00b001db4b3769f6sm318893plb.280.2024.02.26.17.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:47:50 -0800 (PST)
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
Subject: [PATCH v4 09/10] ARM: dts: aspeed: Harma: Add ltc4286 device
Date: Tue, 27 Feb 2024 09:47:18 +0800
Message-Id: <20240227014719.3037588-10-peteryin.openbmc@gmail.com>
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

Add ltc4286 device.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 6e9e6e559838..7dd48c384a4d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -271,6 +271,13 @@ temperature-sensor@49 {
 		compatible = "ti,tmp75";
 		reg = <0x49>;
 	};
+
+	power-monitor@22 {
+		compatible = "lltc,ltc4286";
+		reg = <0x22>;
+		adi,vrange-low-enable;
+		shunt-resistor-micro-ohms = <500>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


