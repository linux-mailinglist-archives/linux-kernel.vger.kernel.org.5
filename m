Return-Path: <linux-kernel+bounces-37701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B283B417
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11A72835BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014FB135A52;
	Wed, 24 Jan 2024 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFPBcz8b"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6E811E4;
	Wed, 24 Jan 2024 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132219; cv=none; b=PN2SjXyP3ImAaCbzJv7ZqxjF2jk85vHncDGsrYebCtRJyY2FfVGrtQwk362HFJtTPypgh31dQn9mx0y73lDRYxHYUzAWDX6FcQ3XU7WJhDyP83K8jG+fAbRY82J6xrAaC2eW63xZ6kwXi6Jrr16MO/4VNhPZGI9qs+O8a4BF/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132219; c=relaxed/simple;
	bh=LkgiOKbVbZHSpnFJNp18qgcVvmZ/V59WoL8f6sQ6vis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTJYTcbRniVJ83kaY/Gj+riUlXvRtpaXfhRpzMXFloPEr+LHoA7slVhHaB17AOyDjPPxi4yQODNdRM8d6R5+v12gHtE1ZyWg2bT2fv22svBnWOOd7V7lXE856bxddT6k8Inx0D0n0Ikk0zDEpx1heSowMdvkopTtdcxpmKsYKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFPBcz8b; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso66154695e9.0;
        Wed, 24 Jan 2024 13:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706132216; x=1706737016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfBInK070elHEyd7RCJMLjds2r5H4aJYPkSFaIcdwCY=;
        b=jFPBcz8bIC9mM1tWiihj92WeTSoUrjgiq68lQMKdq7DZaKDUpps/pGfgKVe4hG4Q9O
         i4yxv99NFneoviBccueuh/X6gZDqtuh8nxoUcsgf5xRq3F1ngYnZ3ZhkYLugBfwMyhRB
         ScKyQf7QWG+OeH6UkU6eAgxLsnU83CVzTd2C15ouA1GGtB7IN3cKNxreKPl7rDnj5R0N
         1SMfQ/81Mij3xvMv7mbf7BIxL702ylFD6SVEVLBWSOrI0CVb6pcrJPjNxgfKbiPj/1nC
         bi2/zNMa+bIDOf0A5LxNruNU46uiHTO4VNT8U8hWvsRvVfdKHdwM3izDzhIDsJjWzbXo
         R/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706132216; x=1706737016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfBInK070elHEyd7RCJMLjds2r5H4aJYPkSFaIcdwCY=;
        b=WM7udRUwOyyY3YPIUtE476Jk3iKr9l8YNY9gDHmEkarqNNEN4c6XLrnS7adq/NXXNk
         nKg3ZJpaPkH9D0apyKg6VJeuLt7LUzfSWVFIJoeGFZRVuVSgga4eMgVcSj2jXqErLUS8
         mDOvStaLyLhKXmgrmDtvUkDyDBtdvqmnJOaVZ4JWv4wOuvuDlHnQQH8moucK1wT2KuiS
         UHHbuJ94NM7HaFhAS3CxGpCxWR03Ua+tWicjK15OotVa+Hg1BDAupDSfmpkYngMVxAML
         71aKUge+7H89Tfaq7Idrr3iIUU5UOT05eb1jzckUkoRwQv6iOYydJ2w5FjY/3nA+TAOH
         igRA==
X-Gm-Message-State: AOJu0YxC0SB0Lr5k0rLatSt1jn5vVei4OeTMzKBayMJUqC0o3vR7XO+1
	3Kiz74evEoRD+8KxnhVdOuajMKp6EUwlrlj7wweuYVCaqGM+qDwG
X-Google-Smtp-Source: AGHT+IF19RqTwPTvrBrM5bPGMjQC6Y5M1PTUboV2gfXzfRxBkQcLXuT9E2nScJ7Aro0EQinApTqmOg==
X-Received: by 2002:a05:600c:a03:b0:40e:7485:daee with SMTP id z3-20020a05600c0a0300b0040e7485daeemr1576328wmp.90.1706132215817;
        Wed, 24 Jan 2024 13:36:55 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q13-20020a05600c46cd00b0040e89ade84bsm339466wmo.4.2024.01.24.13.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:36:55 -0800 (PST)
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
Subject: [net-next PATCH 1/3] dt-bindings: net: ipq4019-mdio: document now supported clock-frequency
Date: Wed, 24 Jan 2024 22:36:31 +0100
Message-ID: <20240124213640.7582-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124213640.7582-1-ansuelsmth@gmail.com>
References: <20240124213640.7582-1-ansuelsmth@gmail.com>
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
---
 .../devicetree/bindings/net/qcom,ipq4019-mdio.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
index 3407e909e8a7..603dbfb95ac9 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
@@ -44,6 +44,16 @@ properties:
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
+    enum: [ 390625, 781250, 1562500, 3125000, 6250000, 12500000 ]
+
 required:
   - compatible
   - reg
-- 
2.43.0


