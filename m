Return-Path: <linux-kernel+bounces-69076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBE185842C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416C1286322
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9989E1332AD;
	Fri, 16 Feb 2024 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnTC8DHi"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611271332A9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104909; cv=none; b=oXjt/w0hf2R9dF4hSPD7pYRvAsxD4VzBoqKkKdxUFqSztB2MiFWNnX/oini3p244Orotsnxmx5z5hqg3OXddf5bumJlQyPDZ8Y5svt+oR+hedZLuk1ttoLFUkkxPu+dE+3AxorZdhFmqzl4l2qAuVV7xOumknv+5iYleCay+sng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104909; c=relaxed/simple;
	bh=RekqSZtiSMFVKlk/3EkQASVDRUVZ9OTERPK+baLtHhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2BjFD6RhvQQVY9N4BHm+fFavkcl3LXsMQU7402lJWIziNLrzhzvMAogQQYjuRylEddVbDdPSqtkJNeZdmMq/G6Hyp/zi3DOoEVwsm3iweW2WbQ7/UpzAbvQzEvrGk9Eiwv/ioL/kr85K+n2Vos2c2U6UczkmNK0ezsCdineM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SnTC8DHi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dc20645871so1540846a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708104908; x=1708709708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xammFEIqB1ELfrS5tvbq4AnuR2HTos7f1tV8KUMgLV4=;
        b=SnTC8DHi8I71gGjcwEPoaKrPkZvZAWtmV6i8NjTj9MOAnu+mnaWWtG0Zq2ZWdxxzO/
         Dm3aEwaCFM1yUWzpyDt5RweJEL0u/QwYfTw9YWjvHV/jaVvGlnhJzqnw+WqmcBqC7Xjp
         /czWeScNYfXLg5nMFE+YyXlej2plo9iNBbHNol3XpEwFjbj+VTGWIp7HZS8BdOOiIOwa
         1Ut6Hpxi0Xcg6TZnLEofymXPksrWMMbEn7qy9BzJ/P9AIVDHuwXOrrjC72S/h7sKB/Ya
         Cl0pY3Cq2/P3z5ld4y7x/WhyHPH1AeiE7v+GuN2IqmMalpugDHjT3R5MZESEgx8MF0T4
         3tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708104908; x=1708709708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xammFEIqB1ELfrS5tvbq4AnuR2HTos7f1tV8KUMgLV4=;
        b=qh8TmrAnJmM0mtobh2wlKJlUknjY5AYdfdQNQCV/12BVXLdpnY9gYybNcfaMT3fCQN
         Qsy5YPQziCZZrcfQlaYILmUG8SO1U9Vq4hgQOuCL1OoyHxk+RJ0oWIfijn6cF5gC7yt3
         0OGY6xHksbsafdeAJWMuDvk9ZlStKQ5jPdDBKwFZhvFUmdzfhwU9t6XFcyEGPETB08xt
         SkhVH2Z/dtn/SuL8JpNf3foC7D9W9srU4b/8Wpv4X/fDaMewHBtWGdcWxG/q5U5R7b0e
         UCXPe+2z/fuIJ/CnFRpdGaiKnrqLoNvbL7mQAT2U/g5VTOnWm0Ru3ExXuCKCvkwLPpFP
         JpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzm7omKMID8Fxzt93QlcqeuAHc+WTCsjKtdXOpCVywd3p5akRJXwdS00koEq1EXdgVDzar7ACY8GngpKpKA0EqHt4RGcH6gb8ZOuRk
X-Gm-Message-State: AOJu0Yw6Zuf6/Io64lgoWcXOV2OnIGbOUj9WsiRCb73PEvB97oi+jSKK
	k4pOW0MuFtL8i6LWhcTEg0TfOqrF1rlmfeBk4WAftgJo7IfDR3rp2wfVv5Bg/Q==
X-Google-Smtp-Source: AGHT+IFzBAuuPuQuLTiYxx+j7ldGM84RTYsglDp/i8J5dfiqMg2Ng/LJlGXbzuCaWcmDtmPzmK4jeg==
X-Received: by 2002:a17:902:dacc:b0:1db:b8dc:a016 with SMTP id q12-20020a170902dacc00b001dbb8dca016mr1379120plx.7.1708104907726;
        Fri, 16 Feb 2024 09:35:07 -0800 (PST)
Received: from [127.0.1.1] ([120.138.12.48])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902b7c900b001db5241100fsm118592plz.183.2024.02.16.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:35:07 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Fri, 16 Feb 2024 23:04:41 +0530
Subject: [PATCH v2 2/5] PCI: dwc: Skip finding eDMA channels count if glue
 drivers have passed them
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-dw-hdma-v2-2-b42329003f43@linaro.org>
References: <20240216-dw-hdma-v2-0-b42329003f43@linaro.org>
In-Reply-To: <20240216-dw-hdma-v2-0-b42329003f43@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=RekqSZtiSMFVKlk/3EkQASVDRUVZ9OTERPK+baLtHhE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlz5y9/dWOuITX0EUn0FvBzx7o7bYPq2sZ8rd6q
 kD80Y0LWmeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZc+cvQAKCRBVnxHm/pHO
 9fm+CACfgHz+JvCH4MmxxLzx+X9AeL4F72MbLIqnXLvjCirHbczvAebR7r+yhtXRUQZrW8pABKb
 dEEbsW9yeC4uZGj8aeX9HLzfyUS1eCLIefMV2CTm+K/OiV0HlsY9xvWwxuxmqfEb/71eo1hnSXU
 d4QqxAFnw+JMN6csdpz6mood7odPKeTbAlxDnbdSuYw9lHzACeDXsVMjyANSnLAwd+B6LK9JWAV
 +ClaAClq6lmt67AY+JMZ5yOjztGgnPBYaRarTTfAUa9rY8zVpjrh3UbcO01JVFb69+DQ4wmKgIl
 HI/URt8Q7o0QamMyaBg2ZyFodnp5SjhvSt8jJg/Vg47Tej2w
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

In the case of Hyper DMA (HDMA) present in DWC controllers, there is no way
the drivers can auto detect the number of read/write channels as like its
predecessor embedded DMA (eDMA). So the glue drivers making use of HDMA
have to pass the channels count during probe.

To accommodate that, let's skip finding the channels if the channels count
were already passed by glue drivers. If the channels count passed were
wrong in any form, then the existing sanity check will catch it.

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3a26dfc5368f..d07747b75947 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -927,13 +927,15 @@ static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
-		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
-	else
-		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
-
-	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
-	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
+	if (!pci->edma.ll_wr_cnt || !pci->edma.ll_rd_cnt) {
+		if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
+			val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
+		else
+			val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
+
+		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
+		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
+	}
 
 	/* Sanity check the channels count if the mapping was incorrect */
 	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||

-- 
2.25.1


