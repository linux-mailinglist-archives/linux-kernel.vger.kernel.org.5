Return-Path: <linux-kernel+bounces-12288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD10C81F25F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF8D1C2254A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C34495F7;
	Wed, 27 Dec 2023 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvL3cTvl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036448CD3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5555ac4314eso936986a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703715460; x=1704320260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qv1f3IGwStmHyloSnSBvki0PIRsmiqgftIEyyglb5rc=;
        b=fvL3cTvl8xoQCcbsfR86wsmEn3TW0hbGFsoXD5wOkUN/O91Gq+IjY3n+vxgnyD2ZDX
         qhA8lbuU8qTUBgtDmXRwb4K6qSvNTNnQZFcFffdhxqBCQSEm8Ak0ASXdfFzseSxMe/39
         YixBJLk6UVKHE1MNC5k2eqtxdHlr40LcvhmLTWvJzXgfOK1RYfbPjD0nwquNmhUNqqcm
         IAc+V8mAR5LCIENEd5iWa6BCIDmyIIv5sdJRI5yXSgRte0sE6RT1fWPh5GEFB6hCSOYX
         nYxTh+0k/LgkUKkwfJmY7+U/jDwCZW5EwgyN1X42xnVEb+Dv428kcPO/NEWZeCN1TIJu
         T58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703715460; x=1704320260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qv1f3IGwStmHyloSnSBvki0PIRsmiqgftIEyyglb5rc=;
        b=twCFh+teWGiCfWURKB8g+CC/nwY1CsBbsOzrudN2vPxo/h3+mTbP3jInDowM9Rk/gv
         tDDQLldGyPmXdxbUHjoOUH1i/31hCCJM2q2oeD7B/Vx7wRhRI1AOma+RbOHsWVRqBmxP
         UPA3IEdSz300TMqOFauWeKZ2SW7ikUc13RuH6ENrSvfThh8NOaGGZzdFBG1C+zi7A+V9
         ImwFOMRkIodPGBuQF/aG+d/zdh6aDY1wES4Y4t0SsgFFLgF4+WRG8TWeNfXe3MDstJox
         HyhSKwqRN7gazDk2zT7XhZFp5RyvX05FcuQ28wehw8y2wmj8T91gbnaUCJpNnZ9EyjNS
         uf8w==
X-Gm-Message-State: AOJu0Yx1NFhDL7xqJ6Azg4XMIZdwn+LCn1iXqRZU9EbCcKG2ZTvt0lOD
	BjWM2JkVxlUz3zBKQDpukTJJNQEcfSFIZQ==
X-Google-Smtp-Source: AGHT+IEjDQu21xE/LPMlU62SFkip9Wm7Icngx8+XC8yCL5jhIVQvu5IRS8ODafE/Dqc3D1LdIZBM0Q==
X-Received: by 2002:a17:906:6dd1:b0:a23:67d2:917e with SMTP id j17-20020a1709066dd100b00a2367d2917emr3472572ejt.49.1703715460247;
        Wed, 27 Dec 2023 14:17:40 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id ka12-20020a170907920c00b00a26ac57b951sm6245712ejb.23.2023.12.27.14.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 14:17:39 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Dec 2023 23:17:21 +0100
Subject: [PATCH 3/4] PCI: qcom: Read back PARF_LTSSM register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-8280_pcie-v1-3-095491baf9e4@linaro.org>
References: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
In-Reply-To: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Stanimir Varbanov <svarbanov@mm-sol.com>, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>, Vinod Koul <vkoul@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703715452; l=809;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=SCdDoH6C4jQKG683KeNay0sGQ+ywn+l9rUD6/n0edxY=;
 b=5d7QgU89R2lgV1XIURi/gtDcJ2KsWZR9axUKhgApYl0LlE+UkpwW+FizXcSBfdubNhkkb/oop
 XAMjodXAI+FB9TyZR5HK4o5sVnLxz7aenGFYtzPk3DTqzr6bSb3Ntru
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

To ensure write completion, read the PARF_LTSSM register after setting
the LTSSM enable bit before polling for "link up".

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a02dc197c495..3d77269e70da 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -540,6 +540,7 @@ static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 	val = readl(pcie->parf + PARF_LTSSM);
 	val |= LTSSM_EN;
 	writel(val, pcie->parf + PARF_LTSSM);
+	readl(pcie->parf + PARF_LTSSM);
 }
 
 static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)

-- 
2.43.0


