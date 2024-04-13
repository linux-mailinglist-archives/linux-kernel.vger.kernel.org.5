Return-Path: <linux-kernel+bounces-143819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D018A3DD2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE851F21848
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0894C629;
	Sat, 13 Apr 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foKWkAp9"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6A33398A;
	Sat, 13 Apr 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713027809; cv=none; b=BZ6wlo208IGO5ZPnnhrjSSHWyQMAnoJ0WetlJEvQxvDDPWYFI89NqFkXd/mbkv6IPOM4HvaFWlwe0qCuZ9KaW3WWkjkaZXkyeVOevIR5m2FRKnnCLbnE1xq9AHf9kOA6IRVARFgysWuuAaDjJZ+SymD25fwqci8YOSGFXBxZRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713027809; c=relaxed/simple;
	bh=xJnCgDxI+t/mAuXlIJ5e4YYBLmb1s1Mgp3OKUhHtndo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VYFpmVqjpik4E1JLB9HhhDdqb1lobycIf5lg/B5q4AIOcq915yY7pelg1Wa/hExYpn1WlEPqGhGe4whTwiHMS2WvJmSmX1wEaX5WLb4kmxpA04UbRpQgpUBf6tT7W4SVnpfyObBAThEkEA0eAaXEmE+XG6p+gGwAsExfczigQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foKWkAp9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d3776334so2421365e87.1;
        Sat, 13 Apr 2024 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713027806; x=1713632606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WYudEi4m3GDodeZTDFABc4O454UL/a8BInZ5mbut0to=;
        b=foKWkAp9Sy4DesY94KJNB6XFW5TThPRX8Bl8fo7h+/QT2/00M7j7Ivh60RBm6X4A99
         ufkS0EyPmuzlNT/1rK7fuMv118ctOZ3jHynyHIHwzKfuMHOgTANDetXiXOzJ/WRmqCon
         fzBSsJt6J4ECFrvvoV2fGPoF6A/krPVrXQUnWRjf7AovWN9fOMcMZlWOIBjooF+XI369
         42rcCyFIzOdzEdQ18cI5g2UhNflN6l5c7etoqvBOK0dFVqSPHOD6Z0cDodxUW/BEdcBK
         bnTDis3KRWrfOyVhrjBl4vPs1wSZVLLy1tsfHBAtsEHSPMiugV4kcaKyDrwtjq0GsOPf
         o2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713027806; x=1713632606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYudEi4m3GDodeZTDFABc4O454UL/a8BInZ5mbut0to=;
        b=VChZds6Mo3HbGWsDpVT4nqVtTEsPQA9/QUuCPskEDTVPLk8s/Yiimh93MZgNPDtT3e
         dpOmNZ70XnxkxIpUMasBse/TGcdHrhJ5UNCB4q8XPBk+JykTci6lBdo/RRyVBlOSxsQ3
         ri8wljHosPGy9pzk84UMvPWA6qfe0svnh3wuOB5sVUdT9bXON9VuCcamOWjYF40m5Mvl
         ruigUzP02StiRIza8tMq6k6cAD8aAUowFxvqWzo4QKtesNTeDSsLgjrrDPQ1HAcgNEhY
         93BJ/zcUqf7vl96EGmw/655rtpgqp4E1U7vzqhYD2/tJ6cLRU8MVNkl0x5oyVfptNmI1
         B2kg==
X-Forwarded-Encrypted: i=1; AJvYcCWQelCK7CxMvnP0s0ElUUwG8Qxj2PoYTzIVhbkvBcQlOnTZ4ixUIKHti/MJGujLVL3E7faXaGyZo44HgR0sY+jp5tfE5fOlG1IarzMwxyvwMfUjETHUzUpp+8/lgC96q89t5dQBxthPqhoBxcVXO3wrg5labZMXec5qnfEyfdk/PPedrnW3d14=
X-Gm-Message-State: AOJu0YxlLNhOnLo4ltp9ZJllw0V52ZRDLQB1CuKbx22o0sZb9zVZzOZu
	ZYNFlA0bYAzM/hE5RYQp/LUdzayPNFpsVLQkJAb8/5ZuvSwuPV20LF97Qg==
X-Google-Smtp-Source: AGHT+IFuH6iZysVfgWgasNq+l/TJeRAjXgj9P63jaiVMVdfE1g2DQzDZefgLgNlWc4z5EDje5Gh4/g==
X-Received: by 2002:ac2:555c:0:b0:518:6adc:346c with SMTP id l28-20020ac2555c000000b005186adc346cmr4361845lfk.43.1713027805525;
        Sat, 13 Apr 2024 10:03:25 -0700 (PDT)
Received: from localhost.localdomain (ccu225.neoplus.adsl.tpnet.pl. [83.30.144.225])
        by smtp.gmail.com with ESMTPSA id kj15-20020a170907764f00b00a51a60bf400sm3195967ejc.76.2024.04.13.10.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 10:03:24 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] MSM8976 MDSS/GPU/WCNSS support
Date: Sat, 13 Apr 2024 19:03:13 +0200
Message-Id: <20240413170317.34553-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series provide support for display subsystem, gpu
and also adds wireless connectivity subsystem support.

Changes since v2
================
1. Disabled mdss_dsi nodes by default
2. Changed reg size of mdss_dsi0 to be equal on both
3. Added operating points to second mdss_dsi
4. Brought back required opp-supported-hw on adreno
5. Moved status under operating points on adreno

Changes since v1
================
1. Addressed feedback
2. Dropped already applied dt-bindings patches
3. Dropped sdc patch as it was submitted as part of other series
4. Dropped dt-bindings patch for Adreno, also separate now

Adam Skladowski (4):
  arm64: dts: qcom: msm8976: Add IOMMU nodes
  arm64: dts: qcom: msm8976: Add MDSS nodes
  arm64: dts: qcom: msm8976: Add Adreno GPU
  arm64: dts: qcom: msm8976: Add WCNSS node

 arch/arm64/boot/dts/qcom/msm8976.dtsi | 536 +++++++++++++++++++++++++-
 1 file changed, 532 insertions(+), 4 deletions(-)

-- 
2.44.0


