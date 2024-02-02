Return-Path: <linux-kernel+bounces-50324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCED847768
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0831F24EAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7280215098D;
	Fri,  2 Feb 2024 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fuVe7HEJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5014D452
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898429; cv=none; b=dLNL9gX0INcWFmo8ZrNfOaaqocB+KXqaNUEVIyaZb/MRi0YYjms7rVvKbmCny4bIBH4WUGU3XTdULpb5SGVvaYMBBN2vhzVfTvVfsPJWHGrowGiAukVlvhb46FEbIIwsF0XRpx1kd1B57Rhhn58cYyArTrV4J4uVNs9tZCu4Rjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898429; c=relaxed/simple;
	bh=Sn+hTApo66RXRFFOejZkbYq/NBLDpDqua+YrtbrooGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gli9uac4KeQGj16ta8hpUfPq+SixAgxdHyckR6Y8pXiaco39UMGrUfmSgKrcjNFGfoenwr+hIGlIGlCWJahZrUjaxpLLVH2u4RNHP8M2B0KQF9ziBv4iDskPyW6cx+841RwPHrxVHltaEkJsZ/S4SGd8dJNmlE7MKOleSxIkeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fuVe7HEJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a370e63835cso115735666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706898426; x=1707503226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhcdvKEbv720I24gdx4dqUT7cWiwM4tuBobtp1tISMw=;
        b=fuVe7HEJSWQB8koiKDlhFuYhR+Fg24XkM1tolm+pdpH/xHCOC7oz31YtucfGFaTidy
         5F2ZqCcfzJOcunbbwqtNNdH5/SAjoHrnU5Fu0CHjTQb71ICaPnwSFO6jrkhBLgH/FGTl
         fc4f+BoD4r2nn1gAeKdyNAbRWvcAvfzbTgAhBTYKQYgrS6ZMeoQlXaozfndhU6665V4p
         j7+5xyHFQOOPKw4Phzb3BGo7O2IGfkJHbcBTLhg9DpOzO8r5srzRnY4r2zuwo+76sfrp
         KYJ8IppiY0ML2i0RTC0xr7unzdYQ5/rUSv3hCnsEo6N4n9MzuWBSnajr5K5G1ap84pT0
         /bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898426; x=1707503226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhcdvKEbv720I24gdx4dqUT7cWiwM4tuBobtp1tISMw=;
        b=ojRLeOmhmJk5dsApj1wFlQr7KV+KfTZTR8CYiYSk2b7nDP45F1bXiS160D6o+r+9p/
         dHfgZ+44b4Db3gMgqd0kurZq6UN71yFBTJcy5BPNnMIlp1gfBQxCy+VWv+yJgyCf5tu0
         Yw6XDiGtguqjSo5+LiX7IPaByhAhs29788y05Ly3rASSkpeg5hCV5uzTj7qoGrZvs+nS
         EpGRDrgZQXAK4qxYHNx7DVMYZfb4A95Y1/NuzFcAwLjufRMK7utrxMmUXNbj/dEkAISS
         kYkUwhpoERjJfzNVuuvYE9N6eTYPri+9190kHOCkXFePaWfMfTjG23nB+h2D9bERouj+
         OmqA==
X-Gm-Message-State: AOJu0YyZt7APFe+tMLEXaI9KcUmHdiwcpLKjQ/Nrf01tD9ED69fOfhVW
	a5NqipJ6hf2Shua7EKDSGN8oEz3nZBTBq9MOLO4d58caJ3TGaEg2a00BHTl44ic=
X-Google-Smtp-Source: AGHT+IHBX1JMM/s8dsNJTujZ0q3ZJESyrJhoSQXSTNl6l6heFx23mldut/wxEY987rmgwZJEig5TFA==
X-Received: by 2002:a17:906:5f8b:b0:a37:3288:e519 with SMTP id a11-20020a1709065f8b00b00a373288e519mr526510eju.14.1706898426150;
        Fri, 02 Feb 2024 10:27:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUG1xLzHnH126uJwYAp7JB492EAnPE2SObwA5XlUM4xUMisG+GLFdUIR5x2jJw2qoCZSRlWaMMOrMtSrbDuyJRfnkB6Z0xCBNihoIH+ifgXz4FhPKIaga8Y1Egt0tTIdvh1R7pzZFnZ/ObaS75IibULI9O5PwBJfFywkZCqLRBm94os16k7+mJicHE2oV/QojqJmYvcrrph7hRt2Ex5ourKayyA4pytYcIe+If1f5vnCdpVxi6DUQKpgrhdhJugL20GAYsYjvwcMQks6/QxszVe2v+9b11/2NI15lEdNqUdk45Ql0wUL61PAMYWDh4bdJs4xW8z6n2oCvcmpwXIHCV0C37uoia7aZ/nfYil27JppECeym3HWVms3nHG9/UcbkiE+cmZtvvjvWS5ZKCBQujfMAqDCXX4bUGvWoUr4CCaBHFPk9R/pIZYk5j3jNmUgkJkp7PUwSFtNFNU238=
Received: from [127.0.1.1] ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a370e130fc0sm791796ejc.59.2024.02.02.10.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:27:05 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 02 Feb 2024 20:26:54 +0200
Subject: [PATCH v3 2/2] PCI: qcom: Add X1E80100 PCIe support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-x1e80100-pci-v3-2-78258e9451e8@linaro.org>
References: <20240202-x1e80100-pci-v3-0-78258e9451e8@linaro.org>
In-Reply-To: <20240202-x1e80100-pci-v3-0-78258e9451e8@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Sn+hTApo66RXRFFOejZkbYq/NBLDpDqua+YrtbrooGE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlvTP1MQ2iuUksuuhWRRhYZuiOu0LbFDwFzA0oE
 5DIByWPxAuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZb0z9QAKCRAbX0TJAJUV
 VhHDEAC15XElaERHlm3pWU0ByNfdo1BXBLF9IHN4WwvjSrXlE1cMzF2P/fz1Wqi0JHUFOf5ZUV0
 NfeeC+ld5L5spKPlYGN8Mfpxuanov2NW4JELdZ5bkOHW/4+oVTg4wM3uH9D1BX+fiQeUOd4kWlc
 Wn7ypNhxnJ8zuFc4dZrneEAJrRPHbvunGNtcrQvPNcMbxIEUEwOX9owFIgbFv4kI10iPrgvLNgY
 crqN39boRa6y+PySOx2QaNCxh641TERxakQtAl6GMlbJjhBBag4XM7Key6o+5ksCY39Ih267ZmY
 HkyQDyQhIQcjoADDu1JFS2uVfM2YPgbtj4/gw3RqC9PBkA0QLIAORkWI9ZWENsNjivyE1cqkyJr
 1YTrsSvh+Gvs137k68rkFQXkArxuCMmYc703A2pOGAaWsPZOFc8NwBfu7GXcjdAkwKG548PWAp7
 nNHW61GzvC+TauisNAcPWBRX67xA57dva+0OqjeiRHhS8VrLDdy6IColHKYM5lXg3wm0UrocLP8
 G5Hs8ncMLxNqjYeKqjaNdJ7pXjXOAI5xZsu3PQUfQaZM7lt7R7yRswqIr+Uh3j97k61E8dzk27G
 XRSt6ThPqXGaYO8eBfCRYNQO16bIn6xXZAXdTheUrvijIbDHOC9+u90O4aXdL1NVYEYd2powJ6v
 vLZXECpF/SaQJIg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add the compatible and the driver data for X1E80100 PCIe controller.
There are 5 controller instances found on this platform, out of which
2 are Gen3 with speeds of up to 8.0GT/s, while the other 3 are Gen4
with speeds of up to 16GT/s. The version of the controller is
1.38.0 for all instances, but they are compatible with 1.9.0 config.
The max link width is x8 for one controller, x4 for two of others and
x2 for the two left.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2ce2a3bd932b..b7467f9dfea9 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1642,6 +1642,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
 	{ }
 };
 

-- 
2.34.1


