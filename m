Return-Path: <linux-kernel+bounces-47849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D38453AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF491C25B0D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E160015B102;
	Thu,  1 Feb 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImeK1ZRq"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29DE159583;
	Thu,  1 Feb 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779257; cv=none; b=A11RnBJH1BkLNbEpeDKrh+ZEnHGkUUOi8Ys03NbHsUQlT8o7XVnHw9dF1BmNyCeUm2w9MaDMRzqym2L1ao37mDHbT/gGLSyPGOeGZXu/PPEmp01xO2xcuBdrSbRfOu9EX5nUgAv8t1hbw8LzLM3DEBZbSr1urx6QN+h5P+c5Z9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779257; c=relaxed/simple;
	bh=/4JBp6RdRR+RO2HKrQ1VOWU4efZ7/en2uddB8OR84fk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=COEkfI2hccshaxLPHX3+lpxsNuTg8XlfvXPq8SYrLLI0wYsKSvmlShCvpI6yJXnLHBIDNSJdRz3e1U6PTkSYCYyW4YjiX/lcgGqGS+vCn5zsJ/z6VLsRP4ExQPB8hKeOKHOPJreteQXZeR4o0w8QHiKG/eyjvBC9Ewue3ZgnrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImeK1ZRq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so1001381a12.2;
        Thu, 01 Feb 2024 01:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706779254; x=1707384054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ryBgbtrSDmwY6Yu9s0XmOazzy2CzNjgO7JJxtwEm/XI=;
        b=ImeK1ZRq6mD0+86H1i3NOP3qNVkt8pBNSsLY53qOEXPZwmHP0IWK8r0IN3fCvBOt6R
         YHRaILbVa9RLWSPJO3nPaOLhcVK40CAvCg6AWUqFf0I7xs0skvXLRJJVOGTJc9TtMy1p
         zunHWukS/Q3AyVff4x4dYx2RtaU6jug9K03W1ZF2fTHoyCw46grpOcgKEZ1OrXO4suif
         8m1lvsK0EwEXYx9KNI2JFc1+Jw7BTEr0/qeoPv9DOhcSadGIpcYTSQ2UWQ3IQIkueERn
         cnpTgcNk3ZBzHDcytxZyylNaU1OQj4HVTej2n3MeS4nfB4lkwY7ERZd+9iwAuEk9nKuN
         wAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779254; x=1707384054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryBgbtrSDmwY6Yu9s0XmOazzy2CzNjgO7JJxtwEm/XI=;
        b=GCUnwc2qcYA7ITItXcKR9hPO+WQHvmH0y3rq9zMpwJL6GRTTaj8e87YiR6NQNLEZh7
         OURmvHO4DbBq6Tbp3nW16xO6s3K1p/qHjDWcqhx++rp+rMUSS7bGiRUTn4yD1h+Eeibh
         kOcYs9cCNDH1LtPjKdzHRN8A5mi5Ln/XmlT/QO/mPUB2iSZSEnfFXgnxyql/I3TWHu1l
         Nv6eyi3d2yOKTA14XT81kkni7kMXjzmOVvMenSzmUGo3wX6OtdM9HPY4nrCpUwzm8QCu
         m25vtV+hijoYSsZyV61Tlsw52w2nk6jfB1ALI8shzYp/qZpETRDM/OW/TMHAkw9Dwr8B
         yXJA==
X-Gm-Message-State: AOJu0YwK5pdIFlu59xxRsUy2+AGhzkJvU/OFNmJiXITmiL61EVPnd4VE
	GUywS0XHmvycbh/1xqBFAoEEvlKO1TjOGTBk2vtGh1XKVpwpXCOW
X-Google-Smtp-Source: AGHT+IE4knxyKRtl3kNUAbkR1BtYwgIgJaNX0TMc6IwqoN6HCOt/KSdWEHl9YS0c8TPeL8GewkwFSA==
X-Received: by 2002:a50:ef15:0:b0:55f:6a87:8033 with SMTP id m21-20020a50ef15000000b0055f6a878033mr2826872eds.31.1706779253341;
        Thu, 01 Feb 2024 01:20:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVgqFO2pmJq3R+dVT+XbC1sebjKgWueGufd2b7hSnylDusLR6Xn0bVE4P7JalsnkMhOp2v2U+IJNK25VEWG1Za4cYGS4twfnt9Ka67AaY8U9Pfvl0OI6eHOBL1Kpqp7c+m4xpUi+8NIIqrvi3KsyRNS0ys7FwEp0WMb7NQPu2cGw54URA05F1eGL+Jdfb6GTXK4QLoP2Zx2LpxFrCG/lWkPyOSwdIYjwHsEQ8wjttB6pGY9T4RUyO22rHLuwicS9ca5YyCTQh8pRlr6zdzy1qWRTmDe9aY0pEEihCJiVSPbqGcSiuitYXlvyJwdvm5Wg8X0S6wV/0tCB2lakFYt0DbowvF+BbUBefvlq2l1csetogQwGuULzquS4iFHzRBDT1IeoA==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id a20-20020aa7d754000000b0055efeee7722sm3834832eds.79.2024.02.01.01.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:20:53 -0800 (PST)
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
Subject: [PATCH v2 0/3] Tegra30: add support for LG tegra based phones
Date: Thu,  1 Feb 2024 11:20:30 +0200
Message-Id: <20240201092033.10690-1-clamor95@gmail.com>
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
 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi   | 1821 +++++++++++++++++
 5 files changed, 2816 insertions(+)
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-p895.dts
 create mode 100644 arch/arm/boot/dts/nvidia/tegra30-lg-x3.dtsi

-- 
2.40.1


