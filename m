Return-Path: <linux-kernel+bounces-52838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2FF849D47
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68541F237D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CD42C684;
	Mon,  5 Feb 2024 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWHy6oq6"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5302C1A3;
	Mon,  5 Feb 2024 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144281; cv=none; b=dbaetZ4UUlPpp9HKlJ/jlgW3vz6m9F3FIeydbkfySJHreoYaK18oQVsOKz4PNZgqY1ddqfVXFApnksImKkNdb6yG7t+ZWGXJXfZJ4CYUaftNErgCrg8B6YLgei89QnAL/weQlj9ONAt+Cj+ZP8DXLgLktGlhokpv4/ZNSj1WY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144281; c=relaxed/simple;
	bh=7LvILnsBadNWbwYwwiQrMvYOk3+TYCx4iAkhkxCKqks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PsLVXRUu2kWwncraYv9bSXbchXzNxQWvAHnOEquOyRDhnL1pzVIK1tEU24lrWaUBTAeQJ05d0Ny7aoBgG/d/wUaSYwjAeGylutzCIXpXi1WopkbdGgB4zGi+l2uqU3na+8MACYAlCypeqYSFry/nfyrpCOLTidrOreOkI3XyaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWHy6oq6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so40749835e9.0;
        Mon, 05 Feb 2024 06:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707144278; x=1707749078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ES+CplXItxCRq+EKXaIwvxyC7cNppFHRUYEO12KjReU=;
        b=nWHy6oq6B4d7JQl+CFKU6KwusM9P9Ka5XqKFL1CPmTcx3Tz6G9J0awmmKDIeNgBFRD
         0CHGL5MnXx5Ozchjr3Z0hEf73HJuRlxqTodUrnqTj2yHwUqzciKu4WfM79JciThEEB/r
         EdAncgcrw3Kdbr7iUmCXxZEVLWoW2NqT4w3G+794nlLHlcLxlWuJ8oJrn6UPk1a9Ykmj
         613nbQkISVrXfMjxG8B82nshKh0VJC9/ablafx5CDGJ2RdXr4P5r0tGS83oyELuUkHy9
         j0cvfHtJlvAUoB34DeEWd6AD613uc3knTebQoUyZXw5+rZbVueSdTIg+/6bK4HoLb/qc
         wKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707144278; x=1707749078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ES+CplXItxCRq+EKXaIwvxyC7cNppFHRUYEO12KjReU=;
        b=lIQDvgIlA0v5AUC1sKpuSMLkoK/N7/uvQJHuBRZyi2ENnLRNFdzmqWlnqvxGDnNe3u
         e3qFsZ1E6JIDFr2VrAgJ3XcfCqSUsMmt9v+EGPr/7K8XKywdnAqJtAmcEJFYEz/vSgVZ
         /wLKzRco2crMy5Ft0YnPCswZY+wQ7m9PphARzE2uVq6wUA3gH1Qx3cghqHn2TWvGaiD6
         M2KRe15/PRBPsRd3CMDyUvmI6XZq2r8AlByD822c1+x9NG+9iQ3LCMFvWWNUkX0BoJO4
         NSKZDcHIw4fD8b4lUJg0CfODTInEMNRf97IQDrL17qicKnnp2emJuTL6wtoMuSb5Pegx
         /rLQ==
X-Gm-Message-State: AOJu0YxUFH3wJtw1+n3yhlDoz1vE5ov3gtkARpGvQcpDEnlR+Q2nCxCj
	c7MMZ2QJaYzd51441y4geAOcaMe6KI5MDggdj1DqW06xk86TJoSE
X-Google-Smtp-Source: AGHT+IGwJ+URmBdaiBiOhlVIBJid7KKOXpt5YkXD51CKGFtakYBmyVrBzZGnoL/vc7UvPc9wip43dw==
X-Received: by 2002:a05:600c:444a:b0:40f:ddb6:a63b with SMTP id v10-20020a05600c444a00b0040fddb6a63bmr1271528wmn.24.1707144277953;
        Mon, 05 Feb 2024 06:44:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUq+udfCWhKtCitNhTXCc4sd2iNfcAkZSLZlu97q9ZfnAv93pPzwPPh54dyVuwX5DfApBK+e5V37qBnwBAyHhFc7QTf/7tMW/knV3wz0n/jQiLGhtlZbMiYOmJ7GH3/OAyr/JYgVqyrC1H3RakSxJoYj0y3yHNvtCTsTYqJ0QVoTx9o5fx/w1/+jZKVsluOoUMpnckAaD9sfsN/J1xSM96fC+gSxjAMvTJSQ5RhNhtdx3hcj8ZtAPWU9tuNXDWICVY8vEr5cpZhdK0AyV9OOIe7dt21GzxCkCkcATgjrpfA40thuC1HoVHp/n5Yt7wiZLaInX2CVHABJ+8fgbqRCGqLhTLjiQsOE6CdhhXx2sn2u9Kaul6Q4/wmELvqpaZfG9/Oc+7fktsakVKquy2SaF/PjaJo72AJm6ylcYmfXWvZ8icaGZP19NkJQD4ze7gbVbtndf11TstczFFfZB1IKFMxohBufOxFzlU0V4i4bOM=
Received: from prasmi.home ([2a00:23c8:2500:a01:8f3c:6ff8:96c9:c9f0])
        by smtp.gmail.com with ESMTPSA id u7-20020a05600c19c700b0040fdf2832desm70272wmq.12.2024.02.05.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:44:37 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/3] Renesas RZ/G2L family and RZ/G3S add missing IRQC interrupts
Date: Mon,  5 Feb 2024 14:44:18 +0000
Message-Id: <20240205144421.51195-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series aims to add the missing bus-error and eccram error
interrupts for RZ/G2L family and RZ/G3S SoC.

v1 -> v2
- Updated commit descriptions
- Fixed review comments pointed by Conor

v1:
- https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240202093907.9465-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (3):
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update
    interrupts
  arm64: dts: renesas: rz-g2l-family: Add missing interrupts from IRQC
    IP block
  arm64: dts: renesas: r9a08g045: Add missing interrupts of IRQC node

 .../renesas,rzg2l-irqc.yaml                   | 44 +++++++++++++++----
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   | 12 ++++-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 22 +++++++++-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 22 +++++++++-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |  8 +++-
 5 files changed, 93 insertions(+), 15 deletions(-)

-- 
2.34.1


