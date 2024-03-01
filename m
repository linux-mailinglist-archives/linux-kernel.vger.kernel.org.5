Return-Path: <linux-kernel+bounces-88784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A986E68C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364BE282496
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552998C17;
	Fri,  1 Mar 2024 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W01qFzYx"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849E4694
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312358; cv=none; b=BHnLN13B+I3M3sidmg0/Ec33bKSwaMEDDUu/tX63E4X78xEk5CbGStJpv5jzvZYBbNYrnN5srziMt8SAGvqleOTQR8T6Pl0lxw/qAeDU4L0o+Z5pl5gV6A3gBDIDdvX5qU0NtrNZj4PVoVbL2GqHxZpDvbj6pahycBE7aBRhcZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312358; c=relaxed/simple;
	bh=Sn+hTApo66RXRFFOejZkbYq/NBLDpDqua+YrtbrooGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2FX0b91+1mizqH/oOSsMbAtKZ7aahZTrKNUQu5sBvcRo7A/7spBaU5IJs4YylvnoL0g7WEyw5e/QrnBlUCE+Z57bO7JqTKikJZiyj9VuKQLDmfle7Qf4S4Qm//0A4PW8mbSoDSEIdyt0b0SayBe52Ycg4Ss37e0TnVo8Cv5Tuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W01qFzYx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so336001466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 08:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709312355; x=1709917155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhcdvKEbv720I24gdx4dqUT7cWiwM4tuBobtp1tISMw=;
        b=W01qFzYx9H+hHKMz5F2p8YpREDIXrozrz3puR9Cpt9lkFVH/iMYwzACFyDxXfRZdth
         M6MCjP8RyDPBuuFzxrRC5LJXlZJ/ml4tmGpJyEctpapBqmJyXW1opjjdhB0I+0gd5WZA
         zAedLPBmIcbBwFooOUKq4kmfW7I2ajHQR7BPZy3skQlcRRfeWH+goSkfYkg1bxYtlEkw
         xkKXQcDcQzB25dBddQ/9eN96f9hQ/WTyRReFdmlC+5JX4YcqQz57UuWjTCT7s4PSsGzV
         DOLw7/qGiPc1K9N/K4BCshNSdOSRr0MMM4twlgeTC/W7ET8fM6f3Xd5UYFyOp5QhDnNn
         V3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312355; x=1709917155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhcdvKEbv720I24gdx4dqUT7cWiwM4tuBobtp1tISMw=;
        b=CLQIS9Aglerphz3T/5ILlA3vRJ2vAr8qAvThM5wWGXGJfQ5x4OX24G2WzZGbN5XH3N
         vPIyXevuA/Ssgqmy50n2vFuV+CwTghgt7Dm++VU9weTVgpIs2ab1TQUmBktrlXKKqsvw
         ImEetEQieWbbkAdzZgur8WIuBMQebBE2KT6A5m5WsCtyDpODWUAm/w0ic8Hvyd3w6XCx
         qEohxUkSfTQK27Yf2kzgjyY4w9pCa/AdeKqmh8ZH7gjGRBwIcXJyD70j81hx9K36srte
         kI32Ae1Ocdms+Sser6cNwSk+A09r4Icokiznnt6UCrKyT1jEV/iIgNNxOcTRnW2Nh91P
         9DRg==
X-Forwarded-Encrypted: i=1; AJvYcCXkRkbiWWu36tGxaSN7sIK9R97IScI/NtNrDwYCTfqb9u328FGyDGkKmBXUeVC30y7NZho+m4HUqO0XC/AQlMFIZcETQaZk+dJF/qmC
X-Gm-Message-State: AOJu0YyLPk42DvI8kZ2RZTXu2x27UNfAgHLCmjGb33xa5Tv5cNWHUgqa
	cYlsWNvpMw01tmA+XZeetBLJw6PPkBoiS66/w0kir6GL1DMjKltTJ+PXv5wVoj4=
X-Google-Smtp-Source: AGHT+IFEoZLKgFS35NpEoXQnuUCTt1vPmUtKm4k/hH5K2S4yx+nBZFXpSZmHjheRGA3fowojRKy4aQ==
X-Received: by 2002:a17:906:1b4a:b0:a44:4170:abce with SMTP id p10-20020a1709061b4a00b00a444170abcemr1693202ejg.59.1709312355292;
        Fri, 01 Mar 2024 08:59:15 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id k11-20020a170906578b00b00a44b405121csm294460ejq.9.2024.03.01.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:59:14 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 01 Mar 2024 18:59:02 +0200
Subject: [PATCH v4 2/2] PCI: qcom: Add X1E80100 PCIe support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-x1e80100-pci-v4-2-7ab7e281d647@linaro.org>
References: <20240301-x1e80100-pci-v4-0-7ab7e281d647@linaro.org>
In-Reply-To: <20240301-x1e80100-pci-v4-0-7ab7e281d647@linaro.org>
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Sn+hTApo66RXRFFOejZkbYq/NBLDpDqua+YrtbrooGE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl4gleCxvPUklGNpOG874P40u75+I5DNMnfyDjj
 vd/BiQOoaqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZeIJXgAKCRAbX0TJAJUV
 VlVyD/9lKC7NRaEQJ4m/TJE6paUcAWXB7HWMn7Vmj9Kd+LqI3gNQXcBxMSCIrdZmBjVUPwcjkiO
 dYRAd0nPrb6z5ynRyT4ubmiw0J1c2tURDnftZ/aTOJgmFH/wH/e0KW76IPaPwufAsQWizNludxJ
 injbECTiw29Bhzn3WrH9YCBIQzBbJPRJyXbsvdUKagLBBljcYVA11wjOYkXEJkDciejA5sNo06Z
 W2fBvpvptqqGsRlnjr0YqUy+z4zUVWSOiu8HxqZ09Dr1Bomqrk9A5a0IcpLrai/bhQ0ymRUMeh/
 O9zETwuAwYKKXbqEBE0EWj7gpGXwBsHEaPzKiY5U718DSQ6KYWApKuS66x++y6KqEr5h2jCqp7X
 OzDopLj+dL4Hs048qj9DjwdBv7qhbLIsSQpzXP+XnYhy4XgqhkS5++L9EwgX9Gk92DD+jKwxySA
 Sug3MXnLNZA0b3QgC8mKiUbYhOi6sreks684KRc1seTRowO7QhFcYvdygjL4Sn/C2BjHlNrW+lW
 /wyj8t91MaRKGKv3fmMt5oshRTAUe3dvHbivBn5s3bslO6LA+O6OHPhXo6H0TInlHyfeJknS6Zh
 6R2pH6xlWmsi1bmeQuoNV6WC/HL7Vrm0xdSuTcwFmqAnRaJtoGKvsHF9rb3mjpQN/V3O7Neq30q
 pdS1hqHkELLi96Q==
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


