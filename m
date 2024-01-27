Return-Path: <linux-kernel+bounces-41221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8383ED96
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA241F22C6A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEAA28DB3;
	Sat, 27 Jan 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrElF2IW"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F7825767;
	Sat, 27 Jan 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366586; cv=none; b=fpAjhygNTO7Qm5kACOa1rUopPAydLUWeLR1mfWoRip8neVzlG3GorO6bcog9JhT645IzEDuAXXkurx1bI1Ji4Dvb2QxZH6yq1K4zRWfUuzoGz27kHqUllyzInJ/PiyfSXA+Usn8jK92fSsOHc1mchsU889b3+AFDYeGCHwWtODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366586; c=relaxed/simple;
	bh=Cw3kFd6oHc+J0PhVziDvOy378ugwGK4UGJrTuOPYsrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mo9Gg7n8a0BNWekc2u+LIlli2V3yF7wcADZTaQu7VM+TyhtSTF9YK6gsNkusMfIfFmATQN6g2ezaIQPUBcN4awg/VZ/fbyVqQy0qKzrxzfTTb5eQ/iBOKY9aSxNbmKtB1wl6zWLN5BjNVvx6cSn12TP9VjGOUKpo/UGV/MtO2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrElF2IW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3394ca0c874so1464085f8f.2;
        Sat, 27 Jan 2024 06:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706366583; x=1706971383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CDLpTvJnsSvmlEnhjS1Bjts57cu2H1aCnEcYrDVMmtM=;
        b=LrElF2IWBsbaZG1UQ/7bhz0UU0TrWijdYfEEm2zVEZyJGWLbqlWXZ/wEmv7o1OnrR+
         fNvDhDg/GUQAN96fzxZ6uYOnJeHYFe0eDzusNxeVFj1t6lFI2PdTJ4Bzl1ALm2g77KCq
         ntYQLykeJ+3khbGFt9WVX5XACbYxpmjUoTflbLnOVmLm8Yjnn8wkx88I/nWFiA50QUAE
         IbO/ZmeT3GY5RcpOYvQg+wch/vccT5OVdyKnZ2wtZhx17jzWW+Qmv4w8QVObPzFuwAQ2
         RvVSc+GxQKKvAEj2EK3Dpe9Wa6PeTF9XSLNb32r7FJ0M/go2EVR0s1bN2RhQDElaPZ2Z
         /rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706366583; x=1706971383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDLpTvJnsSvmlEnhjS1Bjts57cu2H1aCnEcYrDVMmtM=;
        b=T6AZEIGRPV8sla8Jq1n1h9pkH529S+6oSdOIaNEUuiPfPsS3YFBB6OPgC0mEYuJYJY
         sbo5E5olRne/LT7hwBbw10Ea0KUwl5cCiVYQG5KuNrI9F0Ys+L2hLm+icd/+656qZHUp
         1rIyXpf0XhwVm20odRELX2hvX1W+TbDQHNde86WO2QpKn87zoUapkHt/Rc2zkA8fFoFO
         TZLIqtpTFtR3NFPq1gGuJ5DQcktJPWuAJ7SoU+WTDqXi0de/vL4tKLBzILp+boqVQbs3
         x87jcsCJI2tgNTna9MOzNPG4JiLUP4bbZsmNkF8Jlfu4gQaa1xnlUIqmDj1V4oXZIGTg
         jf5g==
X-Gm-Message-State: AOJu0YwdydWen4Ioz0R06haV2oBCLnDW8gwmid27rcALFOWVqGIKDb//
	ankqqn1XS4RzR8ZnD40y1gvLKH5CN48ib7zeVULos3zjuM2GW6/pyZi5Ryfq
X-Google-Smtp-Source: AGHT+IGXicwjL1PPNr2YsC/Mhzj05nvDJTjVbXVc6TtA7AauFviF6/fH2LAlB9dmi2yDbOGYHQxxbA==
X-Received: by 2002:a5d:6a4e:0:b0:33a:e004:e670 with SMTP id t14-20020a5d6a4e000000b0033ae004e670mr1261884wrw.60.1706366582409;
        Sat, 27 Jan 2024 06:43:02 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a11-20020a05600c348b00b0040eef2aed28sm1412590wmq.23.2024.01.27.06.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 06:43:01 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 0/5] net: phy: split at803x
Date: Sat, 27 Jan 2024 15:42:40 +0100
Message-ID: <20240127144252.24767-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the last patchset of a long series of cleanup and
preparation to make at803x better maintainable and permit
the addition of other QCOM PHY Families.

A shared library modules is created since many QCOM PHY share
similar/exact implementation and are reused.

This series doesn't introduce any new code but just move the
function around and introduce a new module for all the functions
that are shared between the 3 different PHY family.

Since the drivers are actually detached, new probe function are
introduced that allocate the specific priv struct for the PHYs.

After this patch, qca808x will be further generalized as LED
and cable test function are also used by the QCA807x PHYs.
This is just for reference and the additional function move will
be done on the relates specific series.

This is also needed in preparation for the introduction of
qca807x PHYs family and PHY package concept.

Changes v2:
- Out of RFC (at808x dependency got merged)

Christian Marangi (5):
  net: phy: move at803x PHY driver to dedicated directory
  net: phy: qcom: create and move functions to shared library
  net: phy: qcom: deatch qca83xx PHY driver from at803x
  net: phy: qcom: move additional functions to shared library
  net: phy: qcom: detach qca808x PHY driver from at803x

 drivers/net/phy/Kconfig             |    7 +-
 drivers/net/phy/Makefile            |    2 +-
 drivers/net/phy/at803x.c            | 2759 ---------------------------
 drivers/net/phy/qcom/Kconfig        |   22 +
 drivers/net/phy/qcom/Makefile       |    5 +
 drivers/net/phy/qcom/at803x.c       | 1142 +++++++++++
 drivers/net/phy/qcom/qca808x.c      |  936 +++++++++
 drivers/net/phy/qcom/qca83xx.c      |  275 +++
 drivers/net/phy/qcom/qcom-phy-lib.c |  429 +++++
 drivers/net/phy/qcom/qcom.h         |  118 ++
 10 files changed, 2929 insertions(+), 2766 deletions(-)
 delete mode 100644 drivers/net/phy/at803x.c
 create mode 100644 drivers/net/phy/qcom/Kconfig
 create mode 100644 drivers/net/phy/qcom/Makefile
 create mode 100644 drivers/net/phy/qcom/at803x.c
 create mode 100644 drivers/net/phy/qcom/qca808x.c
 create mode 100644 drivers/net/phy/qcom/qca83xx.c
 create mode 100644 drivers/net/phy/qcom/qcom-phy-lib.c
 create mode 100644 drivers/net/phy/qcom/qcom.h

-- 
2.43.0


