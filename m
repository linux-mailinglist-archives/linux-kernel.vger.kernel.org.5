Return-Path: <linux-kernel+bounces-149587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2118A9329
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A263282008
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AA363C;
	Thu, 18 Apr 2024 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ZL4kamYD"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07610A0E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422239; cv=none; b=MnMjueX1CXIRTghUfj/CLmmPlU57TtzMMV1mNyRQAsNI6jCb6xh+dwRf1k4q9lmrrs9VBH6iOPRPuK6WGYf9H7Xm5s6AHGOnMXoDpbnCAovzpwCBvQf3KcMCSZKF8j6fP7MTDoXILKMigji9k1if58Nn5iAkejXNr65cSyl/PCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422239; c=relaxed/simple;
	bh=AZORWu8R8zYeP/ZFHg4EUePNoeAt6LSIC3aOkhrqNuU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DRNqi7Cnv39hJeXVKtHWffXb3Vvx+Ogc3gZE6032hDsoHBA3EXnsBhnE1SKjVvXD8X7VMcID/GhCpnMkNTZFKVeXPUj4cabILjZgTvwwDo/g/pZMT4LrTHtCirAv3oozbb1I2G6O6r3xA48SQIxU6RtI7fcwNrQ5qivcSPACX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ZL4kamYD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so677678a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1713422236; x=1714027036; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llTPKlZu+m+rPiTyn8KmBYZdyOU2ppQM2B/d4Fcas6w=;
        b=ZL4kamYDnq4I/3sMTFRWPqRnenMQspeDCSZhKvoKuMzWRBpw2VAdwPRYk6btSq7z10
         noUn2UqPQDQP7NcimdPyyoZQt45m93n1wBW+7D2kH8txQn38uuDCIfqwqJ0wom8oRoBG
         DXS+c5cEKf9QGI0dLFSfnsjsyJ0WhhugUYT6kzI/4GCOxkimfyy7ifGgtRiAfYJu0V83
         SqolXRS0glH1a0EVXhy6YTIrm4Y9r5rpwgALSqISGlqklEVTfCCE6RPnV6vWms91KkdT
         Y5xRUVlhIZYi6CkXmShKsFJssd5pWkCxwlx97HMYGr46cluuew+duQRzfc44rbR2W5kn
         Nb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713422236; x=1714027036;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llTPKlZu+m+rPiTyn8KmBYZdyOU2ppQM2B/d4Fcas6w=;
        b=MAC7YU7b/rF8F+cQ56BVmWOIpfdhjfeksasqhRhq9HCCqNNsJE8RL8C6nxCsA7OIX5
         vFBuCVdhU4nHoHpl43o9edECQZz+81xUhVPDrAIuccgfAf4ysh/R1jpO5LKiTqg4oGYv
         LgHDMgMbhD4ALBs5LFyg6kVHELZn5gVgMSS8C32TowPV/4FUWEycBrXIGpsTmk2/kSnQ
         8etTdr4IGDAPAZMROSGZgz80npp0vMwl8rzUWyQZMMfT/2atNh2gLPDgOIB2q0NPe+xF
         oWmrEP9l170egxjHag52dRNc3Fm7VKnd1eIoKMQ/RjLf1XiGaRaIfQi0WwgT56P1iViE
         idZg==
X-Forwarded-Encrypted: i=1; AJvYcCVmu+dC0OdSV/0rjhjaoZwEwjKNyzbjc9QpH6rK5s1QxqQmkWHGndXPYpqOUHio720C/kkhVR/zx7wI7jY6sTyi5Kl378k+yVx4F6RV
X-Gm-Message-State: AOJu0YxwPaIDUCoCm1Ql+Tu0EcN3Q9j58bQYjFoz8NIgWAcW29peF5+j
	AeQDWTcyAhU32Sq6LeRr0eIc1UWuDmHKh1Vazd4bI+S014qQHDoFx0JDOgpOzGQSIK6AbmLaq+R
	D
X-Google-Smtp-Source: AGHT+IHqtCV++Wsw9wK28VHIK6gcb8fIo2SrGPjBtDGKkrvJzKQWMEY51hHoxq1zqO+rtWtMTTyGHw==
X-Received: by 2002:a50:d514:0:b0:56f:e7b9:e67d with SMTP id u20-20020a50d514000000b0056fe7b9e67dmr1671298edi.12.1713422235845;
        Wed, 17 Apr 2024 23:37:15 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b0056c24df7a78sm472277edb.5.2024.04.17.23.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:37:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/2] Enable vibrator on PMI632 + Fairphone 3
Date: Thu, 18 Apr 2024 08:36:53 +0200
Message-Id: <20240418-fp3-vibra-v1-0-b636b8b3ff32@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIW/IGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0ML3bQCY92yzKSiRF1Di2QTAwMLC0sLU2MloPqCotS0zAqwWdGxtbU
 A66ZMc1sAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

With the patches to add vibration support for PMI632 finally applied,
let's enable this for the PMI632 PMIC and Fairphone 3 smartphone.

https://lore.kernel.org/linux-arm-msm/20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com/

Patches have landed in the input tree:
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (2):
      arm64: dts: qcom: pmi632: Add vibrator
      arm64: dts: qcom: sdm632-fairphone-fp3: Enable vibrator

 arch/arm64/boot/dts/qcom/pmi632.dtsi              | 6 ++++++
 arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 4 ++++
 2 files changed, 10 insertions(+)
---
base-commit: eecc5d90861b551d3b8fbd0d0e6f25c40496f3c0
change-id: 20240418-fp3-vibra-18c400889853

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


