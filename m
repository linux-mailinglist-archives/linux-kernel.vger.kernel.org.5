Return-Path: <linux-kernel+bounces-55287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE3F84BA4C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AEC1C21A99
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6C3134CC9;
	Tue,  6 Feb 2024 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Glj47lM0"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D286134756;
	Tue,  6 Feb 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235027; cv=none; b=VSzTL3Xesk+oPzFtaghsuvy7XnAH2+st8otOM1Kmhg6kVoLFAHimX5NykdIjSMQIpszq1uOeOO/5h04VOF/Kkm3D/6ULwGDPZF/56Nqyd/7mfDHqYrxe1u3GOhrTOVPW/72kQVfCuuPcBE3ORBUzVE+wCdMsGRl5oVZi9I1ULuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235027; c=relaxed/simple;
	bh=teYxShqIxP/uLVM1uE3oK+u6Q9w7V0gJUpxrElVvNzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=koom65YPtdiiIVUWUTOztd1SehNyrgFcqzXIO/D6o8F5WQq50lHoldKCQdG9eFRltb6BQv/W7iTXWOmS3pOasevxMoBXpuuX34VKX7YDlWL0emzFozIRj4yKZB1Fg7OE4cZYQ8UaVgEda/p2WUYMKe/QYIP+V4HP2YjwebkgEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Glj47lM0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so6768192a12.1;
        Tue, 06 Feb 2024 07:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707235024; x=1707839824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PSGpKzlxYKAshM9BfFGFO8H4EKQPq4yWk4Vf8BFZQD4=;
        b=Glj47lM0yzIVtk/4iilJzMnhZpMcfWeovwbqCWS4btJFVQykHEntwRFLzJs1A4w+BS
         iLKLC3jztyk0W7PyznWk3txIe0xPQssUosK3cMGU8WZ8E9oOlYlinwMzpOd3MePXXOWD
         SNcFHocN9CUANBGOMj7Uxj1n+sIIUAvzDrNG3lp4HCN8v0T7Hlymh27EsNjv2Zru28w0
         k14CCnWYALYTdXiXH6y0VH8teMX1JyAnLE7lsfQWUBLUj4NUMQBlurRHc5cgtcjmJnGx
         60G1JH/66b91AgU8I9GZ+Ah3ZOevav/saS7lfHDcoWz9WgMw3kmDlWtrloqhRB3zG2Rg
         s2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707235024; x=1707839824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSGpKzlxYKAshM9BfFGFO8H4EKQPq4yWk4Vf8BFZQD4=;
        b=FxMAFmoeAsuyMJqAZPegjBZs94BC3QFldo/ZeMFbawLPPQ00u4BHrlPFIktZFQIyjE
         Xivj9Ke2pfspSEWp+A00jMg8ThhmcS75QPB8hfHDe0LTFsTblmnXH7P1BBZzKu4uw0Zn
         cELBmCa4N1Qv/RDcz3GkWk+sHq6rpRTcPynz02HOfwRoZqJF5uAcjns9yLxssTML6JJx
         YucZ2sL2hYFL4GF+b0mDELzrJxgU8s7GrfVTamMC/rstFJScamK5dvw+6CsCB2z+YWvY
         2HXEIJwhR5P1xJmbX1qNicg1Po479Xah6LNuAuY8d4ZMvdXGcbcOGqBGnV7zREVxplj2
         gZJQ==
X-Gm-Message-State: AOJu0YxVXEiampXHxD5NkeWH4NzENmAx7+avOaK3dfqZ29uykh/9YSho
	F1FQPlMrwKXDIkgr9z7nu51rD0inmY58ZpojgXox8b1D27SnalpmO1jqzwVM
X-Google-Smtp-Source: AGHT+IErNoohgyuwuSnvIajwww/bNAqRr3vTucVpLOVuTmb2767RsWVe87TJheblWMpjSpxEtVOxGA==
X-Received: by 2002:aa7:d88c:0:b0:55f:f32b:cd57 with SMTP id u12-20020aa7d88c000000b0055ff32bcd57mr2098125edq.4.1707235023876;
        Tue, 06 Feb 2024 07:57:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFvEl/7pw62WXsSMlx9U03NoIY63KBCSxecTctzPun3JwWSv/zkyU9F153s93rfTCfX6tYMCassjQMr+BQRE2m5VvF1j5g0J+mmsnfdQ47q5BdPLt399wMQzRtJK19EbML+h2minYoFadjdeQPA8tyGZUKlGL+ZmtFhaqvk7qyC/2jlOVmvDSxy37y+QU6wqAy+vt9Wirj/zyPw66tcI0ErqyiSRnDqgjFGDDSPvBH5Q/dnkooFzkEHJlm83wDP7YmOqyzkFTfmCo2kncbfFLycNsRAusbj6yXsZkU+jEvp+T8BOLNvllUGDP4DizIR9dGKC04zSYc0KpJDDI4eduy3/WsE3NiEXWUIVP3zhXXx8hRFmy422vrL6jd+8o8sLaYBA==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0564021ace00b005605716e755sm1149869edb.52.2024.02.06.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:57:03 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/3] Tegra30: add support for LG tegra based phones
Date: Tue,  6 Feb 2024 17:56:40 +0200
Message-Id: <20240206155643.28749-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bring up Tegra 3 based LG phones Optimus 4X HD and Optimus Vu based
on LG X3 board.

---
Changes from v2:
- switched from _ to - in node names

Changes from v1:
- switched from prefix lge to lg
---

Maxim Schwalm (1):
  dt-bindings: arm: tegra: Add LG Optimus Vu P895 and Optimus 4X P880

Svyatoslav Ryhel (2):
  ARM: tegra: Add device-tree for LG Optimus Vu (P895)
  ARM: tegra: Add device-tree for LG Optimus 4X HD (P880)

 .../devicetree/bindings/arm/tegra.yaml        |    8 +
 arch/arm/boot/dts/nvidia/Makefile             |    2 +
 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts  |  489 +++++
 arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts  |  496 +++++
 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi   | 1807 +++++++++++++++++
 5 files changed, 2802 insertions(+)
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi

-- 
2.40.1


