Return-Path: <linux-kernel+bounces-61144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC4850DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4B41C21E65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC04EF50D;
	Mon, 12 Feb 2024 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQQ2zHFM"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213AEADF;
	Mon, 12 Feb 2024 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722350; cv=none; b=IbWZgZFpyEdxafZzyZ4coqR6liNBtL4CoFOKNyecldMNJIDeBIsLJQ8Nij1V1ODvdNJgRA9n170B5MKDmRnnboxG1BrBcVWGiTiavmunT9VUBYHh0ldT1gX5s5gKYcC8JWoXzuqXpVZsRbPZ1hfS1Z7COq7Q2/GHR/ql68ve5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722350; c=relaxed/simple;
	bh=tGkzgsfshKCNTYNBI2JO1PxZmWaw14PA3PJ9RbEK0v4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FyXXvexR0aDUKvSP198GCpHqAxhbLr2js4X7Eoz1mhkPQNUFkHSseW57b6CRNuVVZgiYEWv4PU3jtLhskphNTKF82/Lu/MPWEo/o7NjLb6ne4o3Q/jlUpdQTn46dUJDb42Uc4/mcmoicyPze8rpKiePnzOR3Vt2KZv0ziCQp6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQQ2zHFM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51183b02564so1117967e87.0;
        Sun, 11 Feb 2024 23:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707722346; x=1708327146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pIOSxIN7r278dt0Tf0zy54XV9Mva7+Eu/RjQv3pZW/I=;
        b=HQQ2zHFMDM0BxLdbr4UhOlukSbfl9ySWN+nIR5XDHWewa/9RAVrKFHgnsgS63SuD7L
         ky65gZhLTHiigYtuzmVI2IfLfnzf8xf7fAppxIlzYLHtfBX1U3tFFFqlIguJZMboGen2
         Q/JJx9+Eo3DEX9BFi0B0x/nrvwXdYBptUAVpmbL//+G7slXLOSLO7tW8k4INF1LEBKgM
         0DT0o1bBskWjJ5nydhDaW969WZhGMjvU2xpDzllOB3f2zExgd4BoL9h/A5xeFk+ZGnsC
         VG0yhWDHQi9PD+maLrWmQUUGcm+4pZvYbsi7XrF4POqOKTK7L95MIcfxo5Nx/CMpGxLR
         01PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707722346; x=1708327146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIOSxIN7r278dt0Tf0zy54XV9Mva7+Eu/RjQv3pZW/I=;
        b=wEXSdLclQd7I/YMiQ00emuzkM6SoDWb27IJ+Ktk5k3xaJC1wEePOUi4sppF4LSuNBN
         ChZma9teBwd+zwg1u2dEblZRApbE7pNDzgkrWpdVqXnSiYFjU+YySmT/Ov+V4bSO+hqc
         dt6d5Gm+55hkPwRJoGNEuO+CBI4kHIjDHCLoc2KTbwsVFSg/quX/zY5Hwx7nwrhWwfY4
         mBE8I8whVFIMJRtGJmVksQ6or1eNbq5Otr2syr6Pc0Bzvoxonc6CgemuROzxrHUqODjE
         XHVMDj3LuHs4xvJaRcTXGhHXkMZBAkNgHogW2sTA1QuKs6qzv4Jq5AVWrOHNMob1viAK
         JQ5Q==
X-Gm-Message-State: AOJu0Yzzuvl75GM6logM/um/fYEUDfY0KqvcrVL0Nm2RhkZWbCf+hfME
	E0sTyYhaiom2SXjY0QtZ/XQ5JSA7EfwJw4Qj7UMXPJUKvQzTHn7t
X-Google-Smtp-Source: AGHT+IEiAFgLMJl1NdAOfwNlu93LjoEnlIu8EUkejwTSdpEw3b7Kvjuzhyes+CmiqCFAlTLIKWKgYQ==
X-Received: by 2002:a05:6512:104b:b0:511:8101:baf7 with SMTP id c11-20020a056512104b00b005118101baf7mr4250741lfb.38.1707722346036;
        Sun, 11 Feb 2024 23:19:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWreSjSfwPDIxHurifl74hTFVu0kBWoN2Hz5g1chDxJrXTizxTXPBb4o8SK5cx2WGPg+C0M/uTbhyr6Jr+3AajESn1zRU+hbH9MO5KEbJO9VVGT/bWY53xxbgDrXZZUjAGMHWnXiAboAv0ES1/5i0X+dJ5j1cllm5rRA9dny0bSnMjE5XyN9yOkmft+llwQCCpwdzJDYRGUVIrAlVQoeWqh9kL96ldRq/SerClucYZ4/6O/K9y2R/FF0yQbPpt/D8nxofEGBdC94Lkyx7xBndSBFWKj1YDsuGUiKvAAZnB1b+DAwEUiTPTBPzQp58nYX76Oehuxl1jFuQ==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b00410cfc34260sm2340327wmo.2.2024.02.11.23.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 23:19:05 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Shubhi Garg <shgarg@nvidia.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Tegra114: switch Tegra Note 7 from tn7 to tegratab
Date: Mon, 12 Feb 2024 09:18:41 +0200
Message-Id: <20240212071843.6679-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently Tegra Note 7 uses tn7 compatible and device tree name which is
not quite correct. This device has proper codename which is tegratab.
Switch tn7 in compatible to tegratab and set a better device tree name
tegra114-nvidia-tegratab which aligns with newer trees.

Svyatoslav Ryhel (2):
  ARM: tegra: set correct naming for Tegra Note 7
  dt-bindings: arm: tegra: document NVIDIA Tegra Note 7 properly

 Documentation/devicetree/bindings/arm/tegra.yaml             | 5 ++++-
 arch/arm/boot/dts/nvidia/Makefile                            | 4 ++--
 .../{tegra114-tn7.dts => tegra114-nvidia-tegratab.dts}       | 5 +++--
 3 files changed, 9 insertions(+), 5 deletions(-)
 rename arch/arm/boot/dts/nvidia/{tegra114-tn7.dts => tegra114-nvidia-tegratab.dts} (98%)

-- 
2.40.1


