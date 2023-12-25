Return-Path: <linux-kernel+bounces-11030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0C281E048
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294881C219B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBDE52F9A;
	Mon, 25 Dec 2023 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/7XL4M+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094A6524A8;
	Mon, 25 Dec 2023 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d514cbba3so19785635e9.1;
        Mon, 25 Dec 2023 04:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703505818; x=1704110618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Gxdj5UfxaQ2nq7Garedy2IKp2jkZmEQCBZViAgVV5Q=;
        b=k/7XL4M+8SlHTtX6F6Vj5XAWc3YnY3A4Nr5H37A4UsB25D9ONSxGCZDXgEduV14JGm
         SsomcfQFUHNDekgcSDainBw8i8R6XXNKdtALXICHp0z22naoGQpUAGzf63I3+3Q1vdBv
         I3SBlfFQUNB/Aof7NN9T2Kipw19ObeaTbJHmOssVJjM6/AfmV2Ru9Sh+dwOLlhcpTCIo
         s+hLshb4KUyZgeNP7SaZ2VEGD/QdX6r0LDOceQncJ6fl6XyJORd5bKY9nzpw/T1q95BD
         wyL1I3/W/J4GzkBJNsJkCm7azc7Zm7HvvOBOp2mlYvjbJ2rJ0ighfZa1qaECpLEpwyou
         0okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703505818; x=1704110618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Gxdj5UfxaQ2nq7Garedy2IKp2jkZmEQCBZViAgVV5Q=;
        b=FwHdWlQ6yCC1SnHdAmQfXGBy3Qx2XbiGfhwyfNzcW3tvzcE237FWp4PfQN9q9phCEh
         ALEyan2qP/b2qNc4KoVKgIoTPqNFHOAUjjuTjrOrxJfvVlksViXCbUUFpFIRABYtJpEs
         oNC73uo4QHOUpEoG6y/Nd3Q2ucnpu8ack06igsGMr2zFZDC7drrHkfufg/QG+FMSnZZg
         8gjN6YkiJjpl2x6omehw8SCpSmIdu1sLo6xKOHQL693FHDqElHHZ0xh2AJTbAAgWoExo
         E2Anzr8GqOPSvPYihS4exNRc6LUcqdTDvmE7Ydb/1MXqZOkF2kt5aiZqAgRljQRGAySY
         rAFg==
X-Gm-Message-State: AOJu0YzOfeEfOXe6TFq1YgoohKgmFvd7AQIoI4/XQkWoPEg3dnk5vsQZ
	xPWObGQWW8npUhpcCuEYOiQ=
X-Google-Smtp-Source: AGHT+IGLVJrESYMJwVtRrpww8sntaJmSBENn5rNt/9kodDNpzCduK7JfelgPVdm4oLgRlJyH/+NfAA==
X-Received: by 2002:a7b:cd8b:0:b0:40d:2f89:2dfa with SMTP id y11-20020a7bcd8b000000b0040d2f892dfamr3349971wmj.50.1703505818162;
        Mon, 25 Dec 2023 04:03:38 -0800 (PST)
Received: from david-ryuzu.fritz.box ([178.26.111.208])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c020e00b0040d23cea7bcsm6349456wmi.1.2023.12.25.04.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 04:03:37 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joe Mason <buddyjojo06@outlook.com>,
	hexdump0815@googlemail.com
Cc: cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	David Wronek <davidwronek@gmail.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/8] dt-bindings: phy: Add QMP UFS PHY compatible for SC7180
Date: Mon, 25 Dec 2023 12:59:56 +0100
Message-ID: <20231225120327.166160-4-davidwronek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225120327.166160-1-davidwronek@gmail.com>
References: <20231225120327.166160-1-davidwronek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the QMP UFS PHY compatible for SC7180

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 8474eef8d0ff..5faa1cb3a12e 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -19,6 +19,7 @@ properties:
       - qcom,msm8996-qmp-ufs-phy
       - qcom,msm8998-qmp-ufs-phy
       - qcom,sa8775p-qmp-ufs-phy
+      - qcom,sc7180-qmp-ufs-phy
       - qcom,sc7280-qmp-ufs-phy
       - qcom,sc8180x-qmp-ufs-phy
       - qcom,sc8280xp-qmp-ufs-phy
@@ -102,6 +103,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-qmp-ufs-phy
+              - qcom,sc7180-qmp-ufs-phy
               - qcom,sc8180x-qmp-ufs-phy
               - qcom,sc8280xp-qmp-ufs-phy
               - qcom,sdm845-qmp-ufs-phy
-- 
2.43.0


