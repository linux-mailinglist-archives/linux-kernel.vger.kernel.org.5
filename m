Return-Path: <linux-kernel+bounces-102358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CD987B11F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5398C1C28F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E20473183;
	Wed, 13 Mar 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMa/Sr4v"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485767317B;
	Wed, 13 Mar 2024 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354352; cv=none; b=Z2LrCjzchYL2Lkme1UQgyZMI/n1OI7bka1KysU2o7fsKGaLp1ywJNkJtwDIBNFGfvdvCV2lzWiiHlqsxNN3w2gpcebVoRiTc7VDNh4/27+H+vRy9pm/48ynFIMDWm1CuhQzHC9hwCx6di9/fQyjqazr2LVoZNMYPTcDtJkbT1EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354352; c=relaxed/simple;
	bh=eZziATLAx9xM6tiTewCrYD3yYMyhh7uYKvQbwCLqTw8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hlknBqZr+MGdFv0OfejOacaOv5rLdXW6FSZbhtU2k7JgT+Np40/k5r7sCID4FvmqE6mW+6E1EQQSSeE+Ff1IN7umh1gZFZ95ubmAbIcVpOoJvhvrT59UnFPK75fpPWTUA+BgKhY0Q4iWPU+fAZNHPw+4Iq6CCz7kZscS2+1t934=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMa/Sr4v; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so1227601fa.1;
        Wed, 13 Mar 2024 11:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710354348; x=1710959148; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9Ul/Adof/r9QcGQtTSvJxfcp66lXiFES1sAN0k42Ug=;
        b=NMa/Sr4vJBV+XxYiCxBWE8FLcYmyHyECMRuMwXKIuLkBrobPWoKxR4Bjs+IFxR7fOf
         urvYqBQ1MhB1hrrXPLTmVCuTDVCrq2brNBD+sDvzQELusbn+389rysAShKCa6Cmz0P/E
         e6/GmF1AMKbDmYELygYs9RZE9OuIo2WAjWnaVQrSEGmCh+/QP+CpOpr93zOkXQKfhlNo
         fMLbOqB2bvnASRwXx65uzVYgtNEjrHMaH12EGItvERJvVhdyM78cXUwmTFtsUOGrNy7u
         aui0B390V0eqo9BGfGr753QQjq5thz2VvKKz+wUOT4f1ONoyFfW9I7ssizNq+GF8z6Yn
         BIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710354348; x=1710959148;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9Ul/Adof/r9QcGQtTSvJxfcp66lXiFES1sAN0k42Ug=;
        b=saU3m44xpYEdlrWCVW67wcgrbLaVsFqK4sEkEDZ9X3NQnlXhWuwFEx6qpX8NOOwf6t
         U57wrwUVHanZOUj6zfVmCZG8KMFcqTpSOWwttlCKBxlvsAhffkUBP31uBMcA3K0ELn8j
         k9VpFO1DDHeuiIe5NXvbPjVcg9bej8bgzZAOXnG4MNTrrtb3iunXh7184u4CuFXg0OhC
         aLA7JamClXojePfsyv6dlKbN1DZOBmkOjkKgxTQsUn0/Xniw9m9pbm7l4rX0jphNuamR
         ncZfNI7HO+vw1wcr1wQbxfqTZX4ydASQJZzjeypSjdZ/4rf9R/KFDyyLGTgvWktfrJRU
         6nxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2X4bkrftHBrFZVY+H8wn0ogdvq5izUhJnx/PU+5TCgeTO2XdiHHzuXVaNNfkgbnZnwzd0GnvbtsrAO+6qcjHZ4WwYJn2LQOpNR4E/DJ+rLYc41HVo5Ql0fnqRN4RIZVTvPrivBunDLw==
X-Gm-Message-State: AOJu0Yx9cXlH/4MTu+1Okh+j2CqFA3j11BMXpC3uOYLExeODNyaiCOXM
	v/XowE54o9v1HHJ5jkSz0kgz0SfI2yTM5sYYWL0CSR7gWz7TSaWrlNGVkS0pnKQ=
X-Google-Smtp-Source: AGHT+IE5XNZtl9AGVeTfzRu3cuOWaMLG7PRjjXA4DeC+1cYWZcvt+dRgGV9oB+mBZRf8gjV1NQewaw==
X-Received: by 2002:a2e:6a0f:0:b0:2d2:3041:574e with SMTP id f15-20020a2e6a0f000000b002d23041574emr2718773ljc.4.1710354348207;
        Wed, 13 Mar 2024 11:25:48 -0700 (PDT)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id k15-20020aa7c04f000000b0056864cde14dsm2827390edo.68.2024.03.13.11.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:25:47 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v3 0/2] arm64: add minimal boot support for TP-Link Archer
 AX55 v1
Date: Wed, 13 Mar 2024 19:25:38 +0100
Message-Id: <20240313-archer-ax55-v1-v3-0-cd9402efab59@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKLv8WUC/2WMUQuCMBRG/0rc5xbuTjfXU/8jeljzTgepscUwx
 P/eFAIp+F7OB+fMECl4inA+zBAo+ejHIYM4HsB2ZmiJ+SYzYIFlgciZCbajwMxUVSxxpgQ1mhu
 trCTI0jOQ89MWvN4ydz6+xvDe+omv7zclflN5BdPa1c6gFXVVX9re+MfJjj2sqYR7Xf7pmHWhl
 KS75K4UuNeXZfkAqe6Xj+sAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3

The purpose of this series to add minimal boot support for the
TP-Link Archer AX55 v1 dual-band wireless router.

There are two patches:
  - the first one adds the compatible for the board into the dt-bindings
    documentation,
  - the second patch introduces a minimal device tree source which can be
    used for booting initramfs images

---
Changes in v3:
  - change pin configuration to use "gpio20" and "gpio21" for UART pins
    in patch 2/2
  - rebase on top of v6.8
  - Link to v2: https://lore.kernel.org/r/20240226-archer-ax55-v1-v2-0-3776eb61f432@gmail.com

Changes in v2:
  - reorder pin configuration properties in patch 2/2
  - add 'Acked-by' tag to patch 1/2
  - Link to v1: https://lore.kernel.org/r/20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com

---
Gabor Juhos (2):
      dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
      arm64: dts: qcom: add TP-Link Archer AX55 v1

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 132 +++++++++++++++++++++
 3 files changed, 134 insertions(+)
---
base-commit: 0becfaedccee979a5f270647e573b52668669a4a
change-id: 20240221-archer-ax55-v1-73ed91a97c6e

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


