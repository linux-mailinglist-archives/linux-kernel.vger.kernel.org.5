Return-Path: <linux-kernel+bounces-69079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8922D858439
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2B71F22A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ED4132C3D;
	Fri, 16 Feb 2024 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPrPgQZM"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E107A13475F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104926; cv=none; b=hYB3k3IhKLHDyLzlI+PlgzzKUwIhNhhXtjotKtP4BEErwQ8Ea8QKZn5WmcLgks3PZ0tWlnlcSzmUCNwRPkB64cTfGnMA99+uUAZWYqlQbDhka8S9YpOTAPkaiwdX7s58MmSuR9Gck+O3FJEpoo2/ilnup5WTU4ruZC6l4LDQnW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104926; c=relaxed/simple;
	bh=R1GLPwlYfMEGgtPbyaSg7QFWg/JNBX3HH10DnKKcCK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvwPDV/jp5Sdqapww8ws1Km6HkIsYXt4OJue8AkrGYDpN9+ld/9CZwwdGfI45CuTzn+o+FlkaM+DWuB5zICMJ2/ApGy6WloDGldBK2z38m4XSqTHiqzPOyQlZqQU7qH6Uxxfqf+ymWwBPOVqplLzoZJhiNv6+L5+CQ+NWZ41QBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KPrPgQZM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d71cb97937so23933615ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708104923; x=1708709723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWuu4IaCb+ecu+2X4FcUxgf2SPat8siMwG6Oun2YK2w=;
        b=KPrPgQZMwL1HCPXC7wBU5oYFvj++78+R55108VsQBi9jWS3x1PBHwgZBUJwMGjt/Xv
         WVjSaOp7tOYhLOP8O6I0ZLqJ4/Wu4fg/CkBFN8IyfO5ycTtacmT9czYIuhMMhjPKJVia
         4h95pCe9D530v3bQIKJ+XaL0xamOufrpXZUtpbssjW+t8I1RHatNGdiudZkqkMjtW9q6
         VfT7l2oCkFqsAJEa9U1KrPRxjlj+O9vPKqtcpRA58/2JEf5wlDoF0ry+Opw7fH6EmOin
         32bAYoR8TAcbdnquUDA6xZeNuJnknd9ZgmUAebdqOR29ir+Rdega9Q9mrcqdCcXQatGd
         QPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708104923; x=1708709723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWuu4IaCb+ecu+2X4FcUxgf2SPat8siMwG6Oun2YK2w=;
        b=PKd7iE81YRydd3QoABZTL/Ru2LmPS994YjTiekwIHGcGHQ4Rj2g+hGYWTo5UtM8NW2
         /w0eoiVU2EA1VymEGdghokfeVCsD1CpNvC98Eb9kK9QPfVtmmHTCwLVpj9+Zbsuh2C8I
         ibAFg4n94ul4226pAKQEw62b1y/t3yE5z6OlPIh9aDxMU5SjpZg297EdtqR/PpF+oJEs
         mygBUutiMR7afet/z3yQPgP8Sww4DCbL/NeoSDIbVsdcXmqoVHqwwerQltevPDVlu1W3
         /gKTV8q5dIdNVQv5xpbeO18VSuZnHVTSTfFJ7hviYvj5KteECXEuEAQPSA5DRv+haB04
         L3FA==
X-Forwarded-Encrypted: i=1; AJvYcCWaqoe3dHulJotWxVREaqNgm+19SWwmqZ/I0gQSIX45R6I1kC6Gt8KSPfFI1zgcf8ZOC/rPIgq3Ytrc0sORg5ou3hhUWmGvwvlpO+CF
X-Gm-Message-State: AOJu0Yx+z39vD15pBdyrDl3dMr6KhA3xHzo2J4qwWQvXEFNgWtog8XUT
	uHAuWgZF4H4WlX9bg7hFUXDE8MKiZUeF87dIw4MqQq1IWItMNCPa9JbdBfvuYg==
X-Google-Smtp-Source: AGHT+IGdCXZredO/BC7qQxhRij/KCAb3j/MIg4DPBT6lo3YCmbYRREkXZE3AZg1N6MirSxETbxerBw==
X-Received: by 2002:a17:902:ea12:b0:1db:ae5f:a38d with SMTP id s18-20020a170902ea1200b001dbae5fa38dmr2114924plg.5.1708104923231;
        Fri, 16 Feb 2024 09:35:23 -0800 (PST)
Received: from [127.0.1.1] ([120.138.12.48])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902b7c900b001db5241100fsm118592plz.183.2024.02.16.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:35:22 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Fri, 16 Feb 2024 23:04:44 +0530
Subject: [PATCH v2 5/5] PCI: epf-mhi: Enable HDMA for SA8775P SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-dw-hdma-v2-5-b42329003f43@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=919;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=l9TZl5f3ruMfAhDvync60x+vuqThCg8E95q3H1HbSYw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlz5y+NwBcDBvMsgLY/9ArhUeU4RtpAOkSNOPA0
 cL+6HT1tTCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZc+cvgAKCRBVnxHm/pHO
 9YdiB/9TA+DKLXxIZYpi/4hnMyIkUsM2WJIWyQ6w7vRVyPe9xkvRVouAEDo3kakdlZprxiUhdRE
 RVaU7JFkgelmHQuyS7am0hGDZJpDmEmPrmuGigJlrygDliRLE85n5WP2vnnN7WKQuYN+W8HQnv0
 l0f9zuR0+G+HEp9D1og10j/2BOueS6fmgssxK8rtfpi2VW+6FgY0KiiqpsWdUq7od5/Ucw2nR1F
 NbjzPj1POiJNg12Bi3HrhcTLZjvb0KwfS/lV5Mj1NKvbtl2anyrbqaqqbejjAuqCSzx91cCovSW
 ddbe/L2NDfdpqcgHjOuBkoP+92IIH3SP4KN6C52nTmQjmNqV
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

From: Mrinmay Sarkar <quic_msarkar@quicinc.com>

SA8775P SoC supports Hyper DMA (HDMA) DMA Engine present in the DWC IP. So,
let's enable it in the EPF driver so that the DMA Engine APIs can be used
for data transfer.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
[mani: reworded commit message]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 2c54d80107cf..570c1d1fb12e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -137,6 +137,7 @@ static const struct pci_epf_mhi_ep_info sa8775p_info = {
 	.epf_flags = PCI_BASE_ADDRESS_MEM_TYPE_32,
 	.msi_count = 32,
 	.mru = 0x8000,
+	.flags = MHI_EPF_USE_DMA,
 };
 
 struct pci_epf_mhi {

-- 
2.25.1


