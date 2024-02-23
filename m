Return-Path: <linux-kernel+bounces-77906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1263860C04
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCE8286997
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4453717BC1;
	Fri, 23 Feb 2024 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlegUi1U"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817A17552;
	Fri, 23 Feb 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676305; cv=none; b=K/02zjzDM7JzpsjweNlhkNCDcJ4nLuTOK+kG+8q5tkckPRV0EmECZVo+g68XdIyCp3S2/RFPbXnWYnG2pAJyJ9VKbOmP/8MM6Y8xx9TdCecdIa1Qf2iqAYu6V2cusDlzV9s3i/+xis/fXxD/EVhzbqQHhLalmzRp7IqQyiy5cec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676305; c=relaxed/simple;
	bh=ug3cPvmnKVetmcBZDFjj4gZ078LGP+sjMCB9DqO99Vs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bunsu7EdC9nW/zaWd8GZo4RjDrFW7KtiY1Iw3ez5jipSVsfE4mLXOY3ZEmvua7n+veydJH0ZvvjdQANWWSdfPMNu/Z6KUuoQq3+ZlaJpFNIO/QnCseG6W8nmKbDHnryPrkwRuo7hbYUPa/CZtk8vNQr5A06g+zJ+YI+uCTIsfBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlegUi1U; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3ee69976c9so16353266b.0;
        Fri, 23 Feb 2024 00:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708676302; x=1709281102; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kZBPlnvy2Gcjm77bNjlSq48EhGpe5bOoFbicPmusNVs=;
        b=NlegUi1UcOOjrY3x0Jiu98zEe1YN9uSt+9Z+G3JrEC7sohZdOxZVi418p70pEN1UtR
         6LCaZlgsC3su3KYqBqrOsV3NB4/h8NzZRhOTodPYS2s3nT2/bTX5nGQrB8/L7ubrJrLc
         R4AuQfrNAAy5d74UTAuQYFEfObFkRCjS8jg+IhD1Iob9PJ2m6SUup3x1Gtq23y4QzEKc
         iyJHYh8qiQyRxJcDaXROHfTE/ftudGMUUxXQFiMZ5HOZUxjoSC4+2gVonDfkCXCLBpRW
         54v+R2WBK3pfZPYEt+W1ctv3/5w5ckpBxvRl40OX1GHtvwwmTA1Bsm3Lb4/hLnlDckr4
         WtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708676302; x=1709281102;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZBPlnvy2Gcjm77bNjlSq48EhGpe5bOoFbicPmusNVs=;
        b=wjjg2sAeFsPZx73HjQzkMrOlolGN5GOwq+SNSgp3FBAVY6blVKaaWp1k5eYDB5C5Pu
         I/VXwUXE6lGLh1QxZQOGO3x7ubmErlInXzqoZoFXuslG53evxK0Rbn7e4o4Ta3qTnE7w
         6pxi9PX56pDRPVDq19z6bUL6GymQHA4/8np9fHwXYJmiLumNmcqlxwJR9ZEEsAGay4cs
         41lJXwww4txt3YtxwMrjMeVR2jOTezzUiYMMSn6GGUvTgkyevEgy1T9lV0n6+KAdlbft
         YlFoNHV+WNclG33BQae7WwPqpjduDgPmQGyxjnIZFMUyGUAyhnt4VjhCADS6KMrpJvFE
         TxfA==
X-Forwarded-Encrypted: i=1; AJvYcCXYLny243mmhQxO30toQJjSP1ru+JITczfyvFco1uPogGI1u0NMmeiYf/i+AOLcP5gXEOXpw9RVt3/UKz1cv1xuyKwJlsaWSpY00cbQXzJ63gAXdOGnaWXp3DXQKsL6Lg7NlDDX49niiw==
X-Gm-Message-State: AOJu0YxqwychaBdzuz4uNTf+Xd4n8QxMV2HenCy3jTi3fs/u3C/co2SM
	i8xeB23730sgIAj0EV8mqueU9OL73Ni6gn6hyjt2VV7vRibmak4P
X-Google-Smtp-Source: AGHT+IHIrzsKe05GOqYZtf1faRDlK4ZGjIQkSVyxmUQ4PM30MiwY0s5q3otZvlV0MIGuRwFU/03oGw==
X-Received: by 2002:a17:906:aad8:b0:a3f:5040:9d10 with SMTP id kt24-20020a170906aad800b00a3f50409d10mr679998ejb.66.1708676301999;
        Fri, 23 Feb 2024 00:18:21 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id n16-20020a170906379000b00a3f6c5bf929sm1633346ejc.18.2024.02.23.00.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:18:21 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 0/2] arm64: add minimal boot support for TP-Link Archer
 AX55 v1
Date: Fri, 23 Feb 2024 09:17:43 +0100
Message-Id: <20240223-archer-ax55-v1-v1-0-99f8fa2c3858@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKdU2GUC/x3MQQqAIBBA0avErBtQy6KuEi1Ep5yNxQgRiHdPW
 r7F/wUyCVOGtSsg9HDmKzXovgMfXToJOTSDUWZUxmh04iMJutdafDTOA4VFu2X2E0GLbqGD33+
 47bV+R+UwhGAAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The purpose of this series to add minimal boot support for the
TP-Link Archer AX55 v1 dual-band wireless router.

There are two patches:
  - the first one adds the compatible for the board into the dt-bindings
    documentation,
  - the second patch introduces a minimal device tree source which can be
    used for booting initramfs images

---
Gabor Juhos (2):
      dt-bindings: arm: qcom: add TP-Link Archer AX55 v1
      arm64: dts: qcom: add TP-Link Archer AX55 v1

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../dts/qcom/ipq5018-tplink-archer-ax55-v1.dts     | 133 +++++++++++++++++++++
 3 files changed, 135 insertions(+)
---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240221-archer-ax55-v1-73ed91a97c6e

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


