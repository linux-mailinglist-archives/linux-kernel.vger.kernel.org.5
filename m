Return-Path: <linux-kernel+bounces-7202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5672981A326
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889AE1C24314
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C63545C1E;
	Wed, 20 Dec 2023 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpwx24rm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD841C9F;
	Wed, 20 Dec 2023 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9ef61b6b8so4597773b6e.3;
        Wed, 20 Dec 2023 07:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703087538; x=1703692338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac7bRTlD+tFj1q/I5q22nhtbhnHQtfeipFwSuSKMXBU=;
        b=Hpwx24rmr/RDQALzrs1EvBuUVDXeQX538r5NoMSMJzySTfU4brcV+8SMKw0vr0DMZf
         JoFjli+yfnxks00NPjQlDw9FlHykw91wIyFhU/ZTDxxOHSk3ySY4VXYQa96qGl6FMab+
         GqRcVM7TgolMG1z3Kglh8U7HXLvDE0DSCRULDAY/O04Y4ojSxZV+o1dyt/IZ3lVwUkmZ
         nCe6UAFtCln8RCJykf1uSfE1GSlbsrt3K3e0o/Do0mF/+C/fzm77GPFG7mZjbYbhaPdL
         nZ0dbI/8WOmoV1la5XsiLkW7FTa/XAl2+7+bpkQTh5Rq9fKCw3FnLwLgYJwuC1nar3Uq
         UaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703087538; x=1703692338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac7bRTlD+tFj1q/I5q22nhtbhnHQtfeipFwSuSKMXBU=;
        b=LBLzEY8TlYaFlNAEUQhxOSLhxRVsVcHzzF1W8wwj6IV3HN150EiIIccoLCydUUmijH
         2gGifNjlTjSQXBFPSG3XGjznDw09KX1I5eUh0g9fJzAZyRkOZXmHdW+mg1hT2GpDd7Zz
         c1wO+ksSi/0RDwUkUskczPztiBRQ0P3hoeuC3Pv3YSdLJ/G/mh9Zco+IK0/+YLXPl9aL
         qzdndwjxm1pFBjWkf4QHXXfgrmAoGYnBcMZNXfuagnGOJOHKoxKTrygHIXxyAqybqK7u
         yQbs8XSXKWxbmM37hH7KRsMIz0U2zweTuEiulTlu1TWdd8JZ/BzLabKGH9cL/LalOxJ9
         NlHg==
X-Gm-Message-State: AOJu0Yz5CRtZzpC69rbmeE5kZ7Vf2cpKyAuDFjMjAL2LbNMHhb6Rdxlg
	DIOB+/ASBm1Wd8sejPvw+0k=
X-Google-Smtp-Source: AGHT+IEcuPINh6ZC5CVFT+VrkZ5x1B11SLviiebMdIz3vMCdRYPYeLqZh+ebc1f47jXClV6y4S49aA==
X-Received: by 2002:a05:6358:339e:b0:172:8a22:9df5 with SMTP id i30-20020a056358339e00b001728a229df5mr14486245rwd.24.1703087538521;
        Wed, 20 Dec 2023 07:52:18 -0800 (PST)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id y188-20020a6364c5000000b00588e8421fa8sm4840847pgb.84.2023.12.20.07.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:52:17 -0800 (PST)
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
Subject: [PATCH v3 2/3] dt-bindings: trivial-devices: add Astera Labs PT5161L
Date: Wed, 20 Dec 2023 23:51:41 +0800
Message-Id: <20231220155142.3060255-3-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220155142.3060255-1-chou.cosmo@gmail.com>
References: <20231220155142.3060255-1-chou.cosmo@gmail.com>
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
index c3190f2a168a..bc3ab1aedb12 100644
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
             # i2c trusted platform module (TPM)
-- 
2.34.1


