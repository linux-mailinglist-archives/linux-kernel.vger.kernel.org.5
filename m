Return-Path: <linux-kernel+bounces-12285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557F81F256
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55E8283EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544D8481D9;
	Wed, 27 Dec 2023 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lFD0vFg/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33B481BF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5552579335fso1809650a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703715454; x=1704320254; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PNu/Hibw+A4NmOwrD/KUQB5a8JfK056fiWwU3utcXx4=;
        b=lFD0vFg/pkMF3icjz4TOo1KofM0J8sh+qbzvB48cEe2JTxrHhUjpWyJf9+grFzXfQZ
         yHSauMST/pRHVkCn48Td+2iJ6UTUIXJV79CvwAujjE1y+XowETLJZG6KNCQSnYTILiAs
         O4J00xsrjwkKnRP6LMjG7H+D8ne6mMHrqxkwXkHMgjY0p5QL5bEkvv4NvxzxvP0XX62T
         0Wkyr423xUht1PNExPpsBJ6nmvwVj20cC3lsGXZrtWf8QQgsMveyfe4kWeicyhTNDteA
         xt12rhCmAaV2L6C8VsR0xGtu1sLjqbLkE+HQHNBy+mrZruVbPLCyfoue26cAwNsy9x64
         /bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703715454; x=1704320254;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PNu/Hibw+A4NmOwrD/KUQB5a8JfK056fiWwU3utcXx4=;
        b=pxVJXfEpe3hoHMjTQpkkiIrw23pmzzQGzNpq/8AJ+uZ0ljytmqPzyvC8snInVrDzL5
         a2knZZk+pmUtPmECo+UVUGQPJ4vCdL0QorfCqO+2dAHZ/GZuxdKgvd3CKR5PiUw4Ggz3
         1bFHQSPWdzZ+B3J9NHUDT8fJZEU9HkXBsLBlS+/ZfsedTlQJ5LFk/87wYVZ163nt08dD
         r+Z/HPMoCWlAM6SlaZz4GsJcQKmo8bklfHvnLgWU4VzPlxieohkb5dMDjTgFytG62Ic9
         fUoFKC89S27WpVeepwjQWzjiweFcorhvHP5caH4t79I/Vz8jwTfGB6USlYEOAvOc2Tcd
         3Oaw==
X-Gm-Message-State: AOJu0Yx1sZgx5vrXUC1IuAwEmPtpZVZXwdz0cxpqW69rIlTRFZtDzAHc
	BJ9Z+Q8XgZPw2Vq1eZ0/NNwWlWXLsVlhmw==
X-Google-Smtp-Source: AGHT+IEhrJKQaqxQcDxDiFWu1GsD+/kBAspq1WlaGaHdfvd24+0hx/rKrrCeYR5Mu5B8GmS3/0zhjw==
X-Received: by 2002:a17:906:c143:b0:a26:a51e:4313 with SMTP id dp3-20020a170906c14300b00a26a51e4313mr4713907ejc.99.1703715454453;
        Wed, 27 Dec 2023 14:17:34 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id ka12-20020a170907920c00b00a26ac57b951sm6245712ejb.23.2023.12.27.14.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 14:17:34 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/4] Qualcomm PCIe RC shutdown & reinit
Date: Wed, 27 Dec 2023 23:17:18 +0100
Message-Id: <20231227-topic-8280_pcie-v1-0-095491baf9e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG6ijGUC/x2N0QrCMAwAf2Xk2UATH6z+ioh0MXWB0ZVWRRj79
 4U93sFxK3Rtph1uwwpNf9ZtKQ50GkCmVN6K9nIGDnwm5gt+lmqCkWN4VjHFSCQhXzkLCXg1pq4
 4tlRk8q5859llbZrtf2zuj23bAXignCN2AAAA
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
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703715452; l=746;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=02WWBUP4VI09LIYAqAaCWpT1VF+UeeRG3z0iQXnSq4k=;
 b=tBfut8NqDlYh7+Da2duoRNkj1XPLP1jm5yMzMTw+TWzl8uPNTQYxVXDF6QkJR88VepC4fiinP
 FcW8LeGpAUUDXcAbpR/Hs0fpWQ7x0hA/NJhGnlGeU/E0+Wyj1NIp0Im
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

This series implements shutdown & reinitialization of the PCIe RC on
system suspend. Tested on 8280-crd.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (4):
      PCI: qcom: Reshuffle reset logic in 2_7_0 .init
      PCI: qcom: Cache last icc bandwidth
      PCI: qcom: Read back PARF_LTSSM register
      PCI: qcom: Implement RC shutdown/power up

 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 159 ++++++++++++++++++++++++---------
 2 files changed, 120 insertions(+), 40 deletions(-)
---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20231227-topic-8280_pcie-811c0f92fc1c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


