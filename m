Return-Path: <linux-kernel+bounces-49312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0908C846891
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA53F1C219EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECEB179BF;
	Fri,  2 Feb 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEl+VUch"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0C179A8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856873; cv=none; b=Zt8hbK1kkPCw8AnhSHhhIUZZHBrWBZBPN/n78nNiBzXQAoPzTPt8iK7rV9UimgI0QCAKuxGeXbK/mnYIPecNulHcvM+wDrw9lNn/PLwfWQWT6GFhZ1FMM4e20KoBLgpmVdUAsvwNA4xKrpJ5hmh3CZxbSdh9zugFcKxi2v8FN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856873; c=relaxed/simple;
	bh=xYjw+OluseaVhWQ3IUAx0cVvhKzCoYdlybhgeyqTDc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gd+6I+yHkjHp5vJuW/ryPc4ky83uNqDV3A/4OIv3is/w5IOyMmJPMo3n+hSeVNphZ9mYYUyLalvJAp5tmpCxb1z6Y81eBUusbyCcDLu8/sfU3P2iH52O3Ht6zvNTk2KmBAPAm/UHPUntFwhGs9W8+G95HxNnOPbLrWCxlT4hj10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tEl+VUch; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ddc5faeb7fso1466019b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706856871; x=1707461671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uk/bek74G0jiMAyH66uTq7eDwpxGOlToIYq9hApo/U8=;
        b=tEl+VUchxT0VEbEc0As9hc80hzkjCRY8yi3xxsZGmMwbdMmW3cmIoHO33XPH+8a6Nl
         qrM1g2tKd9Ag4ef+wAdAxVhmCVmF2XU0vnuGpTNoJe3jNfftnAh/dzsJy7R5NuqcNEUz
         /FXWCI2rdYwan5yJdH8HE9YdTtrEaUj4BhXmr2bKsikkYGdI49fQZ8HgYKOd8zp9upCU
         lyVv5pXKmOMiPotrBquC6pxme0Ccm+HrKI4IrzNQDP3Yoofoigmpf9q40C5AckpsYkXY
         B3sPMSKFXh2S8aFGvnYSs+5wN/K9v93JqTrv6Un0ZR4bwAlDD93QPKSOVCPgQZ5jgb/0
         LYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856871; x=1707461671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uk/bek74G0jiMAyH66uTq7eDwpxGOlToIYq9hApo/U8=;
        b=BsjRz3nvgwMNkZVdn8rCinlJiA3In4fL20IkzR7LygSk0NxojL9idlq0Ya7zUgkMpM
         X6PwjS69rIHRL1aTYI+87VZhjWDs1kTAxpjbrWf6YTbs1z9Kh2a3TSqF4gHKa5Tlizgg
         4yKgsiPeDsO9x91cQ1VqNZfZzw2/2H6v1abKq8ZmNSDMyaKN6y/pHb42+htV3kzvTt5u
         RA176g3eVoa4jzU1J1drGSpyy+o/NMtXT2OVdd0lm9m09XorLRtXUT95EYRY20b0WlxU
         wV9ZrYGY5FLdjq8zrpJSqvL1+IyqP5ldm6M4mFaM5Igjcx5Wj64pHgM0R8AOEow+nV26
         Nmdg==
X-Gm-Message-State: AOJu0YxBGP7Uc41ZQJhli3TaYZkUiq4NpzuRmI1TUM+vihzadfDK5MJ9
	2UDzF9u+RdLV6pqJGKjcEl2a/NljfPtEoXuDxH7HcOA+8YENXZw1QOfRr740sg==
X-Google-Smtp-Source: AGHT+IEKNCWl4LrhrM67/avU3TwzSdvm5qFofsNjiBTjCutqaAt7Vy9rmSoxT7+FPD6XQeQGuKzZvw==
X-Received: by 2002:a05:6a20:2a26:b0:19c:8ed9:7b94 with SMTP id e38-20020a056a202a2600b0019c8ed97b94mr6656445pzh.51.1706856870780;
        Thu, 01 Feb 2024 22:54:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFOQGso3wcZmDDWcgRX3YBc5uxcoc+fXMD50OvsoLNgUWo9Y/GK5Xy4R/J3g1ootKdcYSkcJuiFLDkLZpkESJU1X+jyLXdc2vDFOTYClnqWoqT88vH2ERqI9VHVb+TR3WpdpdijWvyeNAjHoCcpG8Q1b6DamMWK5/QEi+GpEBBYF6Xvj355Z+X3ewVvSs527ppotRJrYtL69AtGO1k2VGrLmvKGiFWk2FW2A8d/lrGAc6Napbk9PV65om0KvaUJz+Vi4hPqfdXI1fS1z0nbF8QsLMT6XOVmpmHxnb+vgni76szR1PEFK0u7rSisoutrW7AhKceVe1LddB3ZmaAxAyRmSnQb/gR2l8cYRiq/aVLFnrtSMNz9nAqFDxwcw28Z06rMd9esHA0fg0+CrU6QFQQn9sSHPSl8/vGJHOZU/pdUnv468b62Q8mJQ==
Received: from [127.0.1.1] ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id r16-20020a17090ad41000b00295f900f38fsm984763pju.11.2024.02.01.22.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 22:54:30 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Fri, 02 Feb 2024 12:24:17 +0530
Subject: [PATCH 1/2] PCI: Add a flag to enable D3 support for PCI bridges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-pcie-qcom-bridge-v1-1-46d7789836c0@linaro.org>
References: <20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org>
In-Reply-To: <20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, quic_krichai@quicinc.com, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=xYjw+OluseaVhWQ3IUAx0cVvhKzCoYdlybhgeyqTDc0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlvJGcsxB5kZn0o16QvDlMle5WSwnkPHe6+RfAg
 ZVMNj0qD+KJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbyRnAAKCRBVnxHm/pHO
 9Sv5B/96AqSxhGvdFRYINn0qXI6I//m9YdiLPDz1KUMSNZ/KMy9wrSif+UWJNsuUjejpB8xi0T2
 t0OqZ/KlnzEzTa8eQZRKNxESHRpPxnZSF/3+Cyo9kgxGD2G6buDxjl8Im+j1aDdET3oIhz/S80u
 kHQX5/HUm79erLggYeqOi189Q/Sc4Zm5e8o7z9ZN9hWztTky/t/PdGh2NIifNytb67sjE7gF9b0
 sDPhkUVLB/QWV9hYFA7cYajeQqot29YY6KvX5dpz7Rxzzkjn2Z8QdMFr2/nJy25waTdFvFba4dn
 7dcHRCcAabBAdRL6eLCB4ixpYsempTbi95CQCKei3iQsJ4Av
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Currently, PCI core will enable D3 support for PCI bridges only when the
following conditions are met:

1. Platform is ACPI based
2. Thunderbolt controller is used
3. pcie_port_pm=force passed in cmdline

While options 1 and 2 do not apply to Qcom SoCs, option 3 will make the
life harder for distro maintainers. Due to this, runtime PM is also not
getting enabled for the bridges.

Ideally, D3 support should be enabled by default for the recent PCI
bridges, but we do not have a sane way to detect them. So let's adds a new
flag, "bridge_d3_capable" to "struct pci_dev" which could be set by the
bridge drivers for capable devices. This will allow the PCI core to enable
D3 support for the bridges during enumeration.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pci.c   | 3 +++
 include/linux/pci.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..8226a65d8ca1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3127,6 +3127,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		 */
 		if (dmi_get_bios_year() >= 2015)
 			return true;
+
+		if (bridge->bridge_d3_capable)
+			return true;
 		break;
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index add9368e6314..161c0acf2b3e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -376,6 +376,7 @@ struct pci_dev {
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
+	unsigned int	bridge_d3_capable:1;	/* D3 capability for bridge */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */

-- 
2.25.1


