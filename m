Return-Path: <linux-kernel+bounces-14711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F9582210C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC8BB21CFB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B416412;
	Tue,  2 Jan 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJ4FiqBd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039215ADC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a27db7d85c7so192182966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704220209; x=1704825009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykReJz00WmQKhPL+wSZj+JUkHyR0oNkiCFb2BoaQ4VA=;
        b=jJ4FiqBdYNQCbWjKvbGcpVs/arx7vXjZdLvEf/Ye/x65yPsiuTXjicLOGpbg7TvU/G
         fP/FZAS3jv0wkIFIaeqlkNrL0KZp+tg0rcMD+wDhHejbwoBWzERCL3SESLEN0Lddwq9F
         91qPDA8v3RT1XCeSZCRU9oLagiwHAJeJQPiG3aEwmN7O5Iy5wFrEOURlkukg6F26BcY+
         f7WaxBpn1fMN2vW6gALUvA5uwlBtjgtdtp6+6HmXEbH5ixGjXJysA2AzcBWPQjx6wQ5B
         imaEqNmhdZEp4/vKfUntpchwCJ5nAB9Q8dUYI1h2cR03fqt1zoSlMbbZuENtvxrdu+vp
         JNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704220209; x=1704825009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykReJz00WmQKhPL+wSZj+JUkHyR0oNkiCFb2BoaQ4VA=;
        b=DmDm8rOmDs+aN6kB4E9umPUz/vk55ZkKGef+RfVqDGmc/kR5nVt6Ijm4Ys1inW1s+v
         hhFIlZxMtnF8zNH8WOuQ4OzO5i5/ColJ3U28sy/Bn9er8OVg4+zsEQv68bw6Q7DUtuc6
         M2sS39FUf9/ycVlsEABXEebPALJGMo1teqFy5zN1Wzgas+8L4Q+ZyOBb2qWbibkTqkGj
         FFN+edVouPGppNwqPmvpcHJvfYqKJhUonPdr4HegbNE8xZsqv3EfLWfoQWf24PjAl/T6
         qwUaSRV4nRSlsgEK/2KTCjX1LnYIer27EWmjd1mWot1pGzUs+Bu6LzKFFOYJXe4LoRiQ
         AuQg==
X-Gm-Message-State: AOJu0YxdNKJ3NNQ2q1886vrBH29SDrUnxoVXW/YVPrBSgV5/MHpI0ztQ
	zvpe6Zk2tKhsN2mO5U6gXreqezQOds11gg==
X-Google-Smtp-Source: AGHT+IGWsTJkMu+G43lzoPq9JY0yc1JzKw4F/ULg3128ibBpXXnePAeKYJS9Vg0krswjEP71UMonZQ==
X-Received: by 2002:a17:906:5181:b0:a28:893:64a8 with SMTP id y1-20020a170906518100b00a28089364a8mr1298630ejk.85.1704220209695;
        Tue, 02 Jan 2024 10:30:09 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id et10-20020a170907294a00b00a2699a54888sm11968835ejc.64.2024.01.02.10.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 10:30:09 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 02 Jan 2024 19:29:48 +0100
Subject: [PATCH 2/4] dt-bindings: interconnect: Remove bogus interconnect
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-topic-x1e_fixes-v1-2-70723e08d5f6@linaro.org>
References: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
In-Reply-To: <20240102-topic-x1e_fixes-v1-0-70723e08d5f6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704220203; l=3092;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NPuCT7zmHc1LyvgFc2ZzbWoHNtv/ZUIjfd1BvzfKmKk=;
 b=Bs8cE1QNbc7YB3Qe7cprzsSBnjqrn3LNy1CHW2Gx1DmO66cAcVrv5B/lW7QsCdr2IqESRHVrx
 IWbFrTLxfUkCTJV1HbAtUK2uySDKxg1U/cNEpNrbFE9pfEkVj/Y0ROv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The downstream kernel has infrastructure for passing votes from different
interconnect nodes onto different RPMh RSCs. This neither implemented, not
is going to be implemented upstream (in favor of a different solution
using ICC tags through the same node).

Unfortunately, as it happens, meaningless (in the upstream context) parts
of the vendor driver were copied, ending up causing havoc - since all
"per-RSC" (in quotes because they all point to the main APPS one) BCMs
defined within the driver overwrite the value in RPMh on every
aggregation.

To both avoid keeping bogus code around and possibly introducing
impossible-to-track-down bugs (busses shutting down for no reason), get
rid of the duplicated ICC node definitions.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dt-bindings/interconnect/qcom,x1e80100-rpmh.h  | 24 ----------------------
 1 file changed, 24 deletions(-)

diff --git a/include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h b/include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h
index a38c3472698a..7d9710881149 100644
--- a/include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h
+++ b/include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h
@@ -112,11 +112,6 @@
 #define SLAVE_GEM_NOC_CNOC			12
 #define SLAVE_LLCC				13
 #define SLAVE_MEM_NOC_PCIE_SNOC			14
-#define MASTER_MNOC_HF_MEM_NOC_DISP		15
-#define MASTER_ANOC_PCIE_GEM_NOC_DISP		16
-#define SLAVE_LLCC_DISP				17
-#define MASTER_ANOC_PCIE_GEM_NOC_PCIE		18
-#define SLAVE_LLCC_PCIE				19
 
 #define MASTER_LPIAON_NOC			0
 #define SLAVE_LPASS_GEM_NOC			1
@@ -129,10 +124,6 @@
 
 #define MASTER_LLCC				0
 #define SLAVE_EBI1				1
-#define MASTER_LLCC_DISP			2
-#define SLAVE_EBI1_DISP				3
-#define MASTER_LLCC_PCIE			4
-#define SLAVE_EBI1_PCIE				5
 
 #define MASTER_AV1_ENC				0
 #define MASTER_CAMNOC_HF			1
@@ -147,8 +138,6 @@
 #define SLAVE_MNOC_HF_MEM_NOC			10
 #define SLAVE_MNOC_SF_MEM_NOC			11
 #define SLAVE_SERVICE_MNOC			12
-#define MASTER_MDP_DISP				13
-#define SLAVE_MNOC_HF_MEM_NOC_DISP		14
 
 #define MASTER_CDSP_PROC			0
 #define SLAVE_CDSP_MEM_NOC			1
@@ -156,18 +145,11 @@
 #define MASTER_PCIE_NORTH			0
 #define MASTER_PCIE_SOUTH			1
 #define SLAVE_ANOC_PCIE_GEM_NOC			2
-#define MASTER_PCIE_NORTH_PCIE			3
-#define MASTER_PCIE_SOUTH_PCIE			4
-#define SLAVE_ANOC_PCIE_GEM_NOC_PCIE		5
 
 #define MASTER_PCIE_3				0
 #define MASTER_PCIE_4				1
 #define MASTER_PCIE_5				2
 #define SLAVE_PCIE_NORTH			3
-#define MASTER_PCIE_3_PCIE			4
-#define MASTER_PCIE_4_PCIE			5
-#define MASTER_PCIE_5_PCIE			6
-#define SLAVE_PCIE_NORTH_PCIE			7
 
 #define MASTER_PCIE_0				0
 #define MASTER_PCIE_1				1
@@ -175,12 +157,6 @@
 #define MASTER_PCIE_6A				3
 #define MASTER_PCIE_6B				4
 #define SLAVE_PCIE_SOUTH			5
-#define MASTER_PCIE_0_PCIE			6
-#define MASTER_PCIE_1_PCIE			7
-#define MASTER_PCIE_2_PCIE			8
-#define MASTER_PCIE_6A_PCIE			9
-#define MASTER_PCIE_6B_PCIE			10
-#define SLAVE_PCIE_SOUTH_PCIE			11
 
 #define MASTER_A1NOC_SNOC			0
 #define MASTER_A2NOC_SNOC			1

-- 
2.43.0


