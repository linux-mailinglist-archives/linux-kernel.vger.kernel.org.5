Return-Path: <linux-kernel+bounces-53807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA984A6C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2B81C26718
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E93053E2C;
	Mon,  5 Feb 2024 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdYVf65x"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE6B53E0E;
	Mon,  5 Feb 2024 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160725; cv=none; b=Aod1rkJ42yqxYKVrd0V/XxcmAO1tEJh9O+enQwpGUSWHgrmiaoTVTwfcezcffhhgh9LchHo0ilK2jmdV+zOBObzOjIsrdi7gGA2grUmhVIaH79c3/Bzq3HIFeKeUZCL2ngJkVH7zcreAU45Ynnmi2hz3d/QzDAyXPoRZ781+mpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160725; c=relaxed/simple;
	bh=wSWjtqqjivUoa0CG3qdFK79yHE097JXhev5z205E/nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QYEy8x182B4aS34aRzWAkwgd6WfKjnx3TFfl2afUyHNJeK3jqEYNowN8RgV/NF12Nc4sqE4f/HI1DgJs8WhQhJDhE4igoNpJNcFECNoKMhoKw0z0AV0MD3Y+nP9p5wl+2kEnJn6mKZxLzPY62N6+RfuTtjzJ3jtBs0v4jed8VBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdYVf65x; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so641352966b.0;
        Mon, 05 Feb 2024 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707160722; x=1707765522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xt2AM3jB+7aIDuoutfkr3xbhDhpMe4Sp5icdbuMaEx0=;
        b=ZdYVf65xNyEsfG38OMGHlTYNeXWCyKuVvC7S3r3PLKnry6QA8Ui/qCJwscEko2X1Ug
         ogAxn8mRcCTgk2alC6OT6PbbZBvNLCx0txbJCgEg8OXG+cFWeRvETB/50cxDan0SLwGq
         YMZPYPWIcU9tjq18pGtABnRMbIQF8JeTCBb7N9e8wTsdbWHqWwWK8v8PciA7BFh7N6b/
         OFc+KC3/F0SljTz8XYeyvdBLfFmVq/n0rE+NNEQm3I7vyWZ8CGE3H/8Ej6B04cFOzwCf
         1qZLde7qZ4ictDcf2dW5iQmuSKlU6PCO2f+SvEl/7N4p25eokBJLmmWE1ObWoDFUgyu9
         NZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707160722; x=1707765522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xt2AM3jB+7aIDuoutfkr3xbhDhpMe4Sp5icdbuMaEx0=;
        b=nNOe3CO51LBCnsvBnmuKVCbFmHV92cgLjS6YVWU5TBD1dgcfZGvY7Wj7Jfx+WmA8OL
         1r+8Y4bFswwdpOjhnfRcTkrpK7jnXv+FisilwFu7bG0eR9kvL4MDhJQb9lkqCtYRtiZM
         UScyp8+Kfn84lTJz0nL5iDMOeYX2HnaTT0S0I84g/+WgwGFj/ubiYDQkxXSpPbktgnRk
         /qj8giS6q8w906SOpbuiUUxIQr3Y1JPBHxWGoPLANc1LlzAz4hG3ui2bpiFQFJxvUOOj
         JFgiWTwTtZfv0a5VOXS08rhrQTEaXACIu9babh3CxN5v/lCM9HSPtaokE7ZQwCNkJwtU
         DswQ==
X-Gm-Message-State: AOJu0YwWILUBwcqOlKGkeievA96gLbsCHsMTZNCTdajB+4hkJ2Pnxedt
	jqpOnlDEwqGFk+3umHJjgI24/a4ieiE0s7t1boId2yZkXZO/azU=
X-Google-Smtp-Source: AGHT+IG4wF8iaEnBHgtHjpUifdLRNA1cVilx4dlEMFlUS0xgA9xF8vq3w8GfGaDNY5tECLSmiWgXEQ==
X-Received: by 2002:a17:906:a450:b0:a37:2cc5:eb5 with SMTP id cb16-20020a170906a45000b00a372cc50eb5mr275749ejb.37.1707160721668;
        Mon, 05 Feb 2024 11:18:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX+srCUJepnmGBfhQh3VwmvC4c3f+qcHLeahjCT5GqVb5uFPtVfcY3FU3IRTBCSrUf6AuiGjLjg9qG4Z0FolYncj8zbA5gevI4qNo6ESjgTM3CnIlMwzzkzHvkO2Z/gNE7+ig43kUh9OEakDIy4vFa4Rc7/qai0twLVGRZwN+2dG6Vk3wlnDxUxGMjj79iQmupjMrCIA8zmL/YUdax4eCg3rFENqZc0AxnR/6128who6sMYpc0dvitVvI+P4Io3ZuGZmQKdhXXVlewGSJq4Gj0/PZmhXintnfsuasqSpk7c876OD573L1nMHemMqKF8BlkGYG8F4URIXKSIcTh7QnvqJruUfVLIGJWSTxJ2XTRN0o0IGKpiMxtJvCTAkvuzEEDNS56+j9FZES3tiakcImRJRl56UWc/3g9QbYNX+9KlQGpvudMH3jYmoIywzHFStsG5TH2klszsi+njBgtHrcS3YcY3g6f9qNEbvgIoYyafN9YMEW2EzsVi8hZ57IERtWHryIAhRz2MkAHsNeJeXVQlwQ==
Received: from frutis-latitude7490.lan (public-gprs393011.centertel.pl. [37.47.166.116])
        by smtp.googlemail.com with ESMTPSA id cw9-20020a170907160900b00a36f9941d6dsm157049ejd.112.2024.02.05.11.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:18:41 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Naresh Solanki <Naresh.Solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Fabio Estevam <festevam@denx.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: trivial-devices: Add qca,spidev
Date: Mon,  5 Feb 2024 20:18:24 +0100
Message-ID: <20240205191828.998783-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Qualcomm QCA4024 to trivial devices.

Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 79dcd92c4a43..50efbdf2a735 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -309,6 +309,8 @@ properties:
           - plx,pex8648
             # Pulsedlight LIDAR range-finding sensor
           - pulsedlight,lidar-lite-v2
+            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
+          - qca,spidev
             # Renesas HS3001 Temperature and Relative Humidity Sensors
           - renesas,hs3001
             # Renesas ISL29501 time-of-flight sensor
-- 
2.43.0


