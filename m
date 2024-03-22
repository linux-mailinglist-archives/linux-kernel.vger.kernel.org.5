Return-Path: <linux-kernel+bounces-111092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9288867C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C492A1F2151D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CE717BDF;
	Fri, 22 Mar 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="M2NDnUwS"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8DF1756D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094510; cv=none; b=R5RXdI+oJEWZAzA44FFxWRE/9d6rQB/qk8RhWKYux4GD9oG/GwzlsT1wImiENIuwGsHx3u4+Wt79ye4zU77oJVe9GFf4Bm8zB6d0KXuch8+EREw32F/lSQG/bLfeOtaBj4g9ugvoomRPo/2acKcRp+EuARPX9AmDkebmmMPi8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094510; c=relaxed/simple;
	bh=OcCTfSnKi/6290AehwO9HrZ6nco3Bexct5Xndhm7ZeA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pk9LFHhcn6TpYzXYwNW9FSLxWSl2Z3Q+n47uUHyqz4SDpP7VgBNT2Wyk5l/C6YBSCbu+tDNEQXBjaVQTWLGEMR18/1BXB9Qy7Q5zfdqDE2E3rMUeMIm2VpzxnRnQmEctOD8aya1S1H5EhDsBbVtfAu8u0dB8wEpk70BMM5wkEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=M2NDnUwS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56ba6c83805so2187943a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1711094507; x=1711699307; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw51Hyw1DS3v/omudVbOcyBSsqWjCMOpfA2RADZ1/mI=;
        b=M2NDnUwSPkyR9bkG/CCnZ77cvLXk4Jk2vN0vVkzxolYAvB5j9hFd3CH6EwtcxnI2F+
         4HKRFYsduxMCJ3jyyXZRfjyQlnZOPoMtXYvG4I4RZPPs4l2doQ4IQrjKveFARbtSeD8d
         fws6+qE90ryS/z4Plrch3GyhEaag8SPXBnBKHE+gbSsTKPQEh6f+2xC5LmKcONbWcF/E
         410hw+Vh0pTbPBnJugrrmEMFjn9iDMOWu2K2VdUnprVxrkj5jaSmEvm+CE7BqS12cRhq
         YZr+o2a438QtBWEi+nLXhXWTwansYS/+kCNLhpUdmSBeL5uc3pHJEw1btLlMLT1+M7Ak
         UeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711094507; x=1711699307;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nw51Hyw1DS3v/omudVbOcyBSsqWjCMOpfA2RADZ1/mI=;
        b=J0TCiJSr3Z+V1q52kqVc1P8blSyTlH19fe2jRWdt7X/l7PKeHwuChBsjFp7lrgWLMR
         RdRxg081dOiVv8bg1AYU/f74jtveDgE3KKLGyGhoy1CeK4RzPNyMgA/ld4UhH/owO5uc
         nj+nN2bKj/ij1Cu2J/xXxAyGvZmTqeRXGm2oYTHG5q6PGpnvFKIEav9iGTOSckiasuwH
         OCOcMqho9J2ARDH/vbyOEVUNZ1eSZcgc87+E5RNjPhnMB1O35GQAjZ/f0jNfRKMK12q1
         o5a5sAxS2onWBFQ768GKWXqPSGHi1relMSkVeuOZ6urZiIBuukFf2iwcPoF2cLTPeFOm
         a7MA==
X-Forwarded-Encrypted: i=1; AJvYcCVfJpuK9LsDJG+xRdhV2NVuIngzGnkJSpGlZAjryQS8ulWPpQqr6DArJzO0fygumXUlKey6p1D2K7nyWAuJdKEUk3QoH2rN4+bxrJ2l
X-Gm-Message-State: AOJu0YyhE+j9vtyKTtOA4VBkai8zwAvdwoWwKZBjRxlwwj1oJqiHCo9V
	TCVtPCxMq7VxOJq3D6YXUfZjupKFbqU2HT7S24DoxqxZ7jsHX44QPkn+qpFJ6eY=
X-Google-Smtp-Source: AGHT+IGAZ3waKKPaYy2xxvyD7WhqjmG11BTbAkT6qM9SrttDMCln6Si+o3oo7ZhzrW9z0K1FdtPldw==
X-Received: by 2002:a50:d598:0:b0:567:4694:159 with SMTP id v24-20020a50d598000000b0056746940159mr899375edi.26.1711094507002;
        Fri, 22 Mar 2024 01:01:47 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (046125249120.public.t-mobile.at. [46.125.249.120])
        by smtp.gmail.com with ESMTPSA id p29-20020a056402501d00b00568c613570dsm739889eda.79.2024.03.22.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:01:46 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/5] Add TCPM support for PM7250B and Fairphone 4
Date: Fri, 22 Mar 2024 09:01:31 +0100
Message-Id: <20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANs6/WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMj3bQCE92S5IJcXaPEFDOL1DRTU2MTMyWg8oKi1LTMCrBR0bG1tQD
 FEownWgAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

This series adds support for Type-C Port Management on the Fairphone 4
which enables USB role switching and orientation switching.

This enables a user for example to plug in a USB stick or a USB keyboard
to the Type-C port.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (5):
      dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM7250B compatible
      dt-bindings: usb: qcom,pmic-typec: Add support for the PM7250B PMIC
      arm64: dts: qcom: pm7250b: Add node for PMIC VBUS booster
      arm64: dts: qcom: pm7250b: Add a TCPM description
      arm64: dts: qcom: sm7225-fairphone-fp4: Enable USB role switching

 .../regulator/qcom,usb-vbus-regulator.yaml         |  1 +
 .../devicetree/bindings/usb/qcom,pmic-typec.yaml   |  1 +
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              | 45 +++++++++++++++++
 arch/arm64/boot/dts/qcom/sm6350.dtsi               | 25 ++++++++++
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 57 +++++++++++++++++++++-
 5 files changed, 128 insertions(+), 1 deletion(-)
---
base-commit: fa564eb0e6faf40ceea92b2e5ba7a08d0a79594c
change-id: 20240322-fp4-tcpm-2ad68ef55346

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


