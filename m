Return-Path: <linux-kernel+bounces-127944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340FA89531B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97B41F266E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A4F7F7EF;
	Tue,  2 Apr 2024 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTNdNq8e"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70F7A151;
	Tue,  2 Apr 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061350; cv=none; b=RrVhOJw3yBKLpR/YA7qgCmcIYSnW4xxbuXXTJTABfXa1dr9DkWCs39IuARvlIDZ2Nbp2SeYR49BRw8Imk19Qugo7xpnhUGdSDhMX3GrDd+oN06Mx6bbzIS7JsKTOnigXnA9MksEyf5NZZhpKYlMS1wjODTB04Ea6u/l32qdFnyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061350; c=relaxed/simple;
	bh=uwUTlxU8g81v8Oi7MvncfpmOGATFapjjVVkxW8ji7J8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WpHC+SjO+2HWAVQGDbovU9qZ3H+2VGjBwlcU8eCGR+vtfqtkF21WzjFt6ih3c5W4nK5RNfDVrmwAeP7dMciPcxV+OFMyEdDMz4acCgHSm6w7lduvT4ZVRqrtth1Sn+gkEedabOe8U4chSslCxbVGbI2B4I3f7Lgbkd60GWKVohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTNdNq8e; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-568c714a9c7so5986295a12.2;
        Tue, 02 Apr 2024 05:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061346; x=1712666146; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1kXH/c9PNFa1w+eQcGwX8G+WvzgPzIA+jQ0AfW/TcTU=;
        b=HTNdNq8eTy4jL5oYf+a45jgz8IHG3FPO0FHr0al1KliesqkBf4nXRex4iG7OiYPjPh
         pmgSKiNsMexuvprMbXMQqAyqDQ+hsiUusH9e8VxaY7IMFxT0Gb8B44Ds8hfoc8ZhQX+J
         IXN837dIau/9LDD5QJDRZ6PKHMNTGcn0IcYt4DXFdRpv+EIqZASCWacJ8FYdcvKvE5cf
         jd7lavND3ta+NRA9bbvC3ZmwpcOHIHQMTbj8m7ehZWcrupd+YS3fU9PZupRs1qyoE+VY
         YR0+xS8b8aLzJltNwztAlsI7HKZ2y0psES76+uz1pbZMU6oHw6dazr1+npfM25WR+Tgv
         c3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061346; x=1712666146;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kXH/c9PNFa1w+eQcGwX8G+WvzgPzIA+jQ0AfW/TcTU=;
        b=OB6e++EnXNEDaNE23vs6dIcPAPFlBivQ4w7lVOyjySVxPacXRmMSrxAmqhYcezzynp
         EVlIBNGNzauiMmwl0TzuwGv/cHGpq81ryytFXWJQJjFy1LWynwKfVTqms0sngeIXskWf
         ZUpR1dvUDLHLfhlS0T3PzhDihCSRimTiRQv/YDwcG45m8GCMyeK875VJVhXB8pknN3j/
         EQAxQnR9/H2/vkCkrn2VHgRsTe85GA5QgHeIJXi6F822oW3oNuIOArf3ZCoVzvMbbDzr
         34T3hn24GklGpb6Dy6BVsny047NuqTBKsirCsYvwrDjoIJoNYdnOuSRbI1baJg35ilLv
         ykzg==
X-Forwarded-Encrypted: i=1; AJvYcCX4i5yCkzr3rJ7zjb1lmEm6oAg91EhpKaXf37pJ8crg1FhDsJcBqgkx1yfdGd+h7qJoLECfH9zmKDB/nK91Fw3fu4pCq3WmKjuAtv1tjW3UO0Nng1PBSTiuNrVnl2GHTYLPu2POtljhZMGiQDTF+ev3eS4CsSAF4q80QfDX1d10CYvVHn+zW1k=
X-Gm-Message-State: AOJu0Yyo1hsb00KNtqp2elkIzRFYO7nZhJMLTf9RO2D0FB6Sj+zsxIul
	uYEfgirScBljiqkmpXgb44zzTJIRVZeFr2CindZ/USSZeVI7zu4T4jvuwj/w7CA=
X-Google-Smtp-Source: AGHT+IHEwKfGVidCzlFMb9tDRyex4pxKe3UcnCo7F3wSRPDL4gYT0ZtBGse98NcxA+0nSIPkTDkLWQ==
X-Received: by 2002:a17:906:4796:b0:a4e:6276:659e with SMTP id cw22-20020a170906479600b00a4e6276659emr4764482ejc.76.1712061346069;
        Tue, 02 Apr 2024 05:35:46 -0700 (PDT)
Received: from [127.0.0.1] (net-93-65-126-18.cust.vodafonedsl.it. [93.65.126.18])
        by smtp.googlemail.com with ESMTPSA id x18-20020a1709060a5200b00a46ab3adea5sm6467506ejf.113.2024.04.02.05.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:35:45 -0700 (PDT)
From: Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH 0/3] This patch series introduces support for PMI8950 PWM
 in leds-qcom-lpg.
Date: Tue, 02 Apr 2024 14:35:41 +0200
Message-Id: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ37C2YC/x3MSQqAMAxA0atI1gbaUqV6FXHhEDULNbROULy7x
 eVb/B8hkGcKUGcRPF0ceN8SdJ7BsHTbTMhjMhhlrLLKoKzsqkKh3CuGU2T3B05FpV1pe03GQSr
 F08TPf23a9/0AyLKhiWUAAAA=
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Gianluca Boiano <morf3089@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712061344; l=1163;
 i=morf3089@gmail.com; s=20240402; h=from:subject:message-id;
 bh=uwUTlxU8g81v8Oi7MvncfpmOGATFapjjVVkxW8ji7J8=;
 b=THaBZudiIx13kFTsWsjMOkSdYCoSBn12xy4LL7Hsvd2vp/hy73n1TtZ21zee+Nh8gjuLqn3pd
 DRGPcdjdXv2BUk3QaYw1nEL5OPotuD+vAQzlk77+wYyd8LAJNxcAFyX
X-Developer-Key: i=morf3089@gmail.com; a=ed25519;
 pk=HsGrEQ3ia8BGGGO8/nUM2K2UX9JKvRPV+nbrVDGrYhA=

The first patch updates the device tree bindings for leds-qcom-lpg to
include support for PMI8950 PWM.

The second patch adds a pwm node to the device tree for the PMI8950. This
node is found on some msm8953 devices, such as the Xiaomi Mido, and its
inclusion in the device tree will enable infrared LED functionality on
these devices.

The final patch adds support for the PMI8950 PWM to the leds-qcom-lpg
driver.

The PMI8950 PMIC contains one PWM channel.

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
Gianluca Boiano (3):
      leds: qcom-lpg: Add support for PMI8950 PWM
      arm64: dts: qcom: pmi8950: add pwm node
      dt-bindings: leds: leds-qcom-lpg: Add support for PMI8950 PWM

 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 4 ++--
 arch/arm64/boot/dts/qcom/pmi8950.dtsi                     | 8 ++++++++
 drivers/leds/rgb/leds-qcom-lpg.c                          | 8 ++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)
---
base-commit: c0b832517f627ead3388c6f0c74e8ac10ad5774b
change-id: 20240402-pmi8950-pwm-support-f591864b1e28

Best regards,
-- 
Gianluca Boiano <morf3089@gmail.com>


