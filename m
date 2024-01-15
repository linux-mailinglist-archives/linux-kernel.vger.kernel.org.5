Return-Path: <linux-kernel+bounces-25849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DFC82D6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27481C216F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA931E865;
	Mon, 15 Jan 2024 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D16O8uQn"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E11E864;
	Mon, 15 Jan 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-20440084f25so3191339fac.2;
        Mon, 15 Jan 2024 02:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705313142; x=1705917942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOCn5sPGUNxptqZ00MTz/CtUGz7wrqw8h72sOugpjK8=;
        b=D16O8uQnbKhyd/nmKTDGXklK2tQTKbBCJvdb36uooYTaz7VCLm+lvWUd6OAOJjxGvq
         tobr87HP0bJ1OzHbGsldGsgjpiGzJNjahQfeenY2PWzgBJDFUOZZvLQ+BORPRcvbEtyC
         G/GSMgGxVInnT2xkEnr0OuXGp4jApHXhe+E2ojjlfvHuOOBhPG/GwqAIKnG98VxbtuvN
         y4UqdiNrXBdIvnkdwJRe2FbNl68+MlKjGecqOtYHG9tIosxfOTFJgeq1jY2hHMLzv5kr
         E7si4YR9ps3mv3H+ynmVfF8UU+RNr7UGWQMV1avNJZEWpPKT8PbIqIPn2G5hyx7P3zkf
         bS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313142; x=1705917942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOCn5sPGUNxptqZ00MTz/CtUGz7wrqw8h72sOugpjK8=;
        b=lO+9VySOx69XafVessyG9kHJvUE9OZPcr0NFzVDv1yInaTNuY6LujsG26SeODe3L0t
         TJwgN3GCDI4D+FEfLvSp6k105HaPXVr1A5ZOBTSSgTspI2l6z+ZkILBcqWjKwlpVGUSP
         dQj4MWNmsbGklWnEDMsCZBsyIKURTta7+dyr9zM6ViIyls7iHkIVSl8Ce+ya8leYTrxG
         J+ggj2DBVp1WdbYKHeDlRJi6cxcH1zUhnYxrd4NI3hxv6xPdL9ZAS8pqsymIDBdkh1+D
         yJ6T/TYjLwqHOQ2S2Stg0LoprEuYKgmax28w0dgN3rtPCxkzTMMKTqBWTVCO2Py5JQPW
         xSzA==
X-Gm-Message-State: AOJu0YzYFTt4VSfooNJHtoz/Te6d3nq6AxnODmAz2XDvQ3UsQNfQRQlK
	c5LYzgGsBYZiBtdLx2qaPQ0=
X-Google-Smtp-Source: AGHT+IH90cZk7/t7gvO6UHNUwUEJMLal0zaXOhmy9g5PvC/vQaF8bs+d7oYxGV62xy504qOE0jVRGA==
X-Received: by 2002:a05:6871:5229:b0:204:103a:fdc6 with SMTP id ht41-20020a056871522900b00204103afdc6mr3240449oac.99.1705313142676;
        Mon, 15 Jan 2024 02:05:42 -0800 (PST)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id d10-20020a65424a000000b005cda7a1d72dsm6870712pgq.74.2024.01.15.02.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:05:42 -0800 (PST)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	naresh.solanki@9elements.com,
	vincent@vtremblay.dev,
	patrick.rudolph@9elements.com,
	luca.ceresoli@bootlin.com,
	bhelgaas@google.com,
	festevam@denx.de,
	alexander.stein@ew.tq-group.com,
	heiko@sntech.de,
	jernej.skrabec@gmail.com,
	macromorgan@hotmail.com,
	forbidden405@foxmail.com,
	sre@kernel.org,
	linus.walleij@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	chou.cosmo@gmail.com,
	cosmo.chou@quantatw.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 2/3] dt-bindings: trivial-devices: add Astera Labs PT5161L
Date: Mon, 15 Jan 2024 18:05:17 +0800
Message-Id: <20240115100518.2887549-3-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115100518.2887549-1-chou.cosmo@gmail.com>
References: <20240115100518.2887549-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for pt5161l temperature monitoring.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 21d1f066f875..db3e585962e4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -47,6 +47,8 @@ properties:
           - adi,lt7182s
             # AMS iAQ-Core VOC Sensor
           - ams,iaq-core
+            # Temperature monitoring of Astera Labs PT5161L PCIe retimer
+          - asteralabs,pt5161l
             # i2c serial eeprom (24cxx)
           - at,24c08
             # ATSHA204 - i2c h/w symmetric crypto module
-- 
2.34.1


