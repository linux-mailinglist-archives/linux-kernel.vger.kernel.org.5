Return-Path: <linux-kernel+bounces-42299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFF983FF49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B697C1F23213
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314DE4EB3E;
	Mon, 29 Jan 2024 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jU+pRh35"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086BC4EB4B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514744; cv=none; b=cDuVrWCJ8Sg4NRDUlz+kQ//9vY1MMgnkX+9spwQVYg6h6OhvxlkuR0nWiLS8uyPBqc/QBBZmglJze56+ZPhpmOTG1UxTovlt6DKfAHq8AtnUWdQe0khABmHv9ccOedLisfloe6SEnmLxZ/fj2bMBVVdrQOpqIRC7hlXo9G0mIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514744; c=relaxed/simple;
	bh=zsixOtgoxOAaktuLOVRNS+8gFKTlnwz3zGLUZ3WnNGo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RJ+jQZuOoa/0oCyalR+3i2kyCMNeUK1h104TTkcl5+0ckNHrwR1M+w0S1mW/QeyXJkKwjane32R8UFzMbZXpP4VoH6QTMuUlSo6HHhw4GFRp8WG+ngN+oXJ/t7/9foCG8UmdmQzxpEIFftGAisF7gxyd8qxxUEutU5Rk7JAsciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jU+pRh35; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6de0ba30994so1238115b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 23:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706514742; x=1707119542; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNguBtqcgFqP7NZKo6lpCS4yOVt7MJ3Er1hgEXdMUg8=;
        b=jU+pRh35erKYerFZJlVghxYfHwFqEALAxQuSONfv141q3V4zT16f4ij5FyiVY6/xKd
         4dJWBUyOkD1c+feluQtL1EswghR12syxUjA0MkR+bTPOpWOkGUQHcp6WsGiYJ9gjp8qX
         9b6igq0EwvySW6CLMBIJ5qp52xV5i1sSn2lhJghvsT0gFteRpxGIR7EpHJHlG/RMcSx2
         g9M3ywj1uQ3McMMyFAiaW6Pq+eshV4KNHxSKQU4doG6tDFPfprp7x+6VHoWbCPMry5Ek
         tDrZ67qJ5M04JA6Fs013OkSjs0E/yWIEt3hPp+ZTHuIYSSJSTd2/ZEFuvafkxtNzOsYN
         8iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706514742; x=1707119542;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNguBtqcgFqP7NZKo6lpCS4yOVt7MJ3Er1hgEXdMUg8=;
        b=GyaJ0GmxqG8GuS0jmBZ3A24QZAdVDRVOpy6sbiyUbLKOeFLtCqkdkNp4rY/8NIWytH
         rSbEovHaN6/NTBC5eWOpRg53vLAcebNT2XPL7lZA9tidCmwWtsDlmwTmQzrQKaoGyX1+
         DzEVCtinP15qbfvKL49pcqm4Cd00xO+ttW16z/+8tgb8ku7r4FQpAhANVkQmOF4yet+n
         mM68vlNuXjtJt0pXDI20PSNoraqua+/9lwf4wv8iKKDoML5ohAeUgPMedUz1lqw1IEJi
         6NNWurbExv4jXCjgQf9dpdOy4HACz0ulSS5W8SQ/8wtBLgPECmCKqZOI0/0lNTZtSj2S
         G9oA==
X-Gm-Message-State: AOJu0Ywjul6j+eCCGuY/vOO2Hfr+cyMWvcejOEyIDo3EPuobACEPs7vD
	h/io5eqZP4ZRmi8xnLZoOf1lXKG9j7c6KKtGNn1L+XPiKNfxQ1/unVWbb0jZ47NfpRf3Y9Y5m4g
	=
X-Google-Smtp-Source: AGHT+IGLj5HGoGuy0l3yI/NV57KQmeoJRLi2YW0sBBeEqN3seWdetPb4xNwGFcfa76uqzDgLcB640w==
X-Received: by 2002:a62:b60d:0:b0:6de:1095:4b9b with SMTP id j13-20020a62b60d000000b006de10954b9bmr3538877pff.7.1706514742083;
        Sun, 28 Jan 2024 23:52:22 -0800 (PST)
Received: from [127.0.1.1] ([117.193.214.109])
        by smtp.gmail.com with ESMTPSA id t19-20020a62d153000000b006dddd685bbesm5467329pfl.122.2024.01.28.23.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 23:52:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] ufs: qcom: Mark "core_reset" as required property
Date: Mon, 29 Jan 2024 13:22:03 +0530
Message-Id: <20240129-ufs-core-reset-fix-v1-0-7ac628aa735f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNZt2UC/x2MSQqAMAwAvyI5G2hLKehXxINLqrm0kqgIxb9bP
 M7ATAElYVLomwJCNyvnVMG2DSz7lDZCXiuDM84b6zq8ouKShVBI6cTID9p59dPsQojBQw0Poar
 /6TC+7wdFQJPqZAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Andy Gross <andy.gross@linaro.org>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=zsixOtgoxOAaktuLOVRNS+8gFKTlnwz3zGLUZ3WnNGo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBlt1kukOiTQDGcIeoelZVUHLMR2QZqqCSV88qj/
 CmxdYiFC9+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZbdZLgAKCRBVnxHm/pHO
 9Y1IB/0ePDpYszqZJSgILa+x2JyZQMEuYoiet03wzEowK3tUc5prM87SkXDuBsTGDGXuU6ircTY
 BOqsSZnJzbZGCQT6a18kHAUKdd9hRzqUjNWFARhLdAydYDkMZxViId3LmeRhfZ+0RjyfqMPTtv3
 drA+inetP/z0Ly7WZhLNrmsDbId9xkp0NbhYuXgfx+JlrT0Jy0yYMXe5Vin3piNw/qLQ5CtwR+s
 +w/n2c6Fvrbw0X8RSBiR9PaM2OPe2zhuDbR5XIatxo0FZOBDxKR9hIAKk43DhkR6KV6oZfKOKPw
 AdhOnaLI7cYEMBVW9CeKsC8CIM+aZBrycpik9ckgYg1pfXbY
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

As concluded in [1], mark the "core_reset" (UFS host controller reset from GCC)
as required in the binding and also add the missing property in MSM8996 DT.

However, to keep backwards compatibility with old DT, the driver cannot make it
required. So it is still an optional property for the driver, but a comment has
been added to clarify this.

- Mani

[1] https://lore.kernel.org/linux-scsi/190651ad-6aeb-69eb-89c5-ed18221b5a7a@quicinc.com/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (3):
      dt-bindings: ufs: qcom: Make reset properties as required
      scsi: ufs: qcom: Clarify the comment of core_reset property
      arm64: dts: qcom: msm8996: Add missing UFS host controller reset

 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi               | 2 ++
 drivers/ufs/host/ufs-qcom.c                         | 6 +++++-
 3 files changed, 9 insertions(+), 1 deletion(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240129-ufs-core-reset-fix-1bd4ab266f64

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


