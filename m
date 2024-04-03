Return-Path: <linux-kernel+bounces-130072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F12C08973CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9F41F2987F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F1414BFB6;
	Wed,  3 Apr 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeNKtqii"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111A14A60A;
	Wed,  3 Apr 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157309; cv=none; b=BkbftcPeTOjHIKrCAg0aU/ms/3L1xUmnrvOhPXP2xyobCS/hatZ0Egxt3Dc/jWCjI3WFhgBs47j37gN18hKqT/HwhxKtjv0ULHyZYMLDwrMocezIG8UQMADpaYGemmegdethjwuS5+04vWj2xCCUDGmQu+D0mYSwNGnPZzHed4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157309; c=relaxed/simple;
	bh=ojPSlFbdpLpb3Lx36s9cTAlTP11v33uMUFmCosQmlco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NcNIjgk5Gpan8SxDXV8y3lM9M/NfYSZtUneJsLLHV18w0lURM7hkRbp+lLemeDiruwD3EW1VmQ0QnTpTOpN606UAIWodHr7Y67UNduEI8yadRfJkIPhSUWXIYw+4CBPQFqGliuquH0Dzzuqwr/FEY3tXvUN2JH0+q0DqaVdWXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeNKtqii; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516ab4b3251so3385369e87.0;
        Wed, 03 Apr 2024 08:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712157306; x=1712762106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0UnXIFWFvFekuBRfpEmUMyu/jbDLvMT34GdY2MCbqY=;
        b=YeNKtqiiJQmqkckVtflMBv8kPsaBS1seL9IX0uM6V5W1fREnWirXSIzd7zQ4/v02FT
         ePO7AhpPNrGXsHv4yV0+X2MWFr7Qzg+sTZ6lVIsuOh7jKDr+QZ4/gH1VAHyX5CF/oESc
         yXopyQaIqNZzrM852Qpd2JXZG9AL7SRUgSpgNXWnkBuLsdrwJyExJax9Gy1SE2+PHpZm
         xALWWOVooecbJbgwOqllZu5NggNbVBjpvU6pz5s1C5vyBp6PP858JROkivIit3cDlhkX
         GsQ5N12K6dlJnM8XpvoRDMfIsRgMwNBqc3AniT6Qykxwnc3qNXWt6DledumY+KfgyZsp
         OtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712157306; x=1712762106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0UnXIFWFvFekuBRfpEmUMyu/jbDLvMT34GdY2MCbqY=;
        b=ldEP0N989Dy8s5ozEmNG54eRD9kjqlUoQLDmZ0oRXSn5YXMr1hKts90lifAvgKjOYT
         Yop5XmhFfVWMExIhBpuz+pCiTABf7m87E5FBK+xFYjXowC1D5AlMUwBQ67LLepaGGTyY
         aLc+NnWqKT/uvD4Zb2a8PpqXP/lsDMGhNgIicWIdTGvj8HDG6z/g52vAmB3AwvBLnECV
         1/fOPkhbq7Lc1MHZztO97MD+6qEpQOMLcLZlRVqkHJPnPruFqL3w50gWyHjcQB0lC4cD
         kCctA1foi/76NPPKR0Z/fRfqboa1xAb4TODtvFr2C+tDVsyhCZw9ThvZQL42I29/HY58
         4EGA==
X-Forwarded-Encrypted: i=1; AJvYcCU60C/ogYhq2LEjglMQDP05Lfh3Q9UKOP5U8LNA+jah0RT5dahMP41PBadelKX3lX0Xl0IWqq9C8QVTxIn1LZ+TGZuTfOqaOpsTjLVxKrCmMkNhqGQ+rjjSnmKevBcQlf3KX9vUc4BICQ==
X-Gm-Message-State: AOJu0YyCd8zvhR1VRNQWjDmkafCkIyJNhvcilyjB+lddrfnzAZQhLpY7
	jCasXuuoYdzywE+Qb9B/d/rqoWy85947VvkTmT8+0pgoSiKe4Lh6
X-Google-Smtp-Source: AGHT+IH75StaU8ogu0GxyZE3WtrOvlufmCkqvJQSA5reLsG08AdbtTHZDIDj5OVE1GjN2uAQANQggg==
X-Received: by 2002:a05:6512:36d2:b0:515:c17e:ddb1 with SMTP id e18-20020a05651236d200b00515c17eddb1mr11784578lfs.50.1712157302621;
        Wed, 03 Apr 2024 08:15:02 -0700 (PDT)
Received: from yoga-710.tas.nnz-ipc.net ([178.218.200.115])
        by smtp.gmail.com with ESMTPSA id d6-20020a0565123d0600b00515c1b1fb85sm2055092lfv.233.2024.04.03.08.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:15:02 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH v2 0/3] arm64: dts: rockchip: add Forlinx OK3588-C
Date: Wed,  3 Apr 2024 20:12:26 +0500
Message-ID: <20240403151229.30577-1-dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add support for Forlinx RK3588 based SoM and carrier board.
Devicetree split into .dtsi (FET3588-C SoM) and .dts (OK3588-C Board).

v1 Link: https://lore.kernel.org/all/cover.1710506373.git.dmt.yashin@gmail.com/

Changes in v2:
Patch 1:
- no changes
Patch 2:
- rename dtsi to rk3588-fet3588-c.dtsi
- reorder regulator nodes
- reorder properties in sdhci
- drop regulator-always-on from vdd_gpu_s0
- enable tsadc
Patch 3:
- update dtsi include
- set more generic names for tca6424a, nau8822 and sound nodes
- reorder regulator and nodes in pinctrl
- reorder properties in gmac and sdmmc
- drop vmmc-supply from sdmmc and update max-frequency
- enable gpu (depends on for-next branch)
- enable usb_host nodes

Dmitry Yashin (3):
  dt-bindings: arm: rockchip: add Forlinx FET3588-C
  arm64: dts: rockchip: add Forlinx FET3588-C
  arm64: dts: rockchip: add Forlinx OK3588-C

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-fet3588-c.dtsi   | 558 ++++++++++++++++++
 .../boot/dts/rockchip/rk3588-ok3588-c.dts     | 409 +++++++++++++
 4 files changed, 975 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-fet3588-c.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts

-- 
2.39.2


