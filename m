Return-Path: <linux-kernel+bounces-48374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 239BD845B21
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CFE1F24670
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A662175;
	Thu,  1 Feb 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcqiC5DE"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6745B5F48C;
	Thu,  1 Feb 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800696; cv=none; b=LNbWeVonHRQz9baQob6DbYHvs3eDtyr1DZMCtOX3munDpPhJoSOnhmV0TPdfchVTbrLXVpqbYTI2U9QjvmT7z0uUoEzRHCirAsyYW6w9idO8bfg3bTPp7+QFNF3tGU3h2sHtbLeLz6KEi5Pthhnx/YiM6QttVgrohzW7mjrBlwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800696; c=relaxed/simple;
	bh=p2zjvsecwqsbWVxX3y98V4aEVEIewA84Nqu+biKQYbQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=O5L7mY0gsZkkDHYEDoG+7M9fd7Ls1QSEr8en0cFoLs+plf19JZXqONaumIkAMfh2m96fzgkBBjkZH4vE5cu/wm9AO5PVgvz0zQquY47Ub1gKI4Y1yLmCD1rPAaMQh6bsxO+vpEdjl4TWKfvpbrdkFYYDuWLYsu0cFvPuLU1pttE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcqiC5DE; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cf588c4dbcso13768371fa.1;
        Thu, 01 Feb 2024 07:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800692; x=1707405492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FgF7oqxYUKcEdySx4Ly0ihobldR/JZonk5s5GnUnAk8=;
        b=XcqiC5DEWtWD86+McEu4fimnsuqqKqhDizsw4Y5bEtZNhURMK2fKyUPJwytpah89EE
         PkEC+aNlsRlA3RJBTxNODPhTYYoEe0ZlH7PXWlnXRiCnusCXswPZdl2FGliMjWGj0PZ1
         z3z+QPHPN06J8I0uZXgxCKaeyUqhfoiFdITf5nYhNGPJZVPwvLdOi3a8fy5IJy30Y+9V
         JWZ5FPBSOf+04U47KvE3rayn3q5JY6h3uoQEVQKbnWNx1Xlzdew3L3oV+djv3MqohtDN
         F7TW0Ga4sU7WodKsF3RjYfiCNZIzAYlYnKpZFnWw+F716uPOGg2yNZIZAVg4z0vDGsnJ
         /SDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800692; x=1707405492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgF7oqxYUKcEdySx4Ly0ihobldR/JZonk5s5GnUnAk8=;
        b=UFAsbWUZbc9idDakVjtE3/1Qs4Qdvw74IPY5Jl+7VVWf2xFc/gkZ6D2TKVhp8dmAVy
         qjTdawxc+aT39f6qZisC+ePSgZ7C7qFp9JKm85i5bi4qnDbhF34Gdph3lvwIbSNgrJG/
         +pBLkEn2SHBEjuERNX2xFpQo9ifFh0D7LLjYPoHARRiXawgPYShuAVTXRt9Gy5f/TlE/
         xJbsikVHJJZKoFd3zRTVP/6VsaERa3nLtfNw+w1pf/bDZ00nB8f3SUODdmM4gYz2DwTb
         WEpsKLJ76IqWKt+8VO+cIup7I17yNXM7l/WXgflw5F0YxQeuygtGeHfy5cdvvhh8RLgl
         fSpA==
X-Gm-Message-State: AOJu0Yx86ahwwcrJaOUEN9oTgOIRpanejVhcvk8Jn2t4ccPMLuE4tBf9
	6t1os94RCQBl3xPYuOiU+6vFkFAgFkLuV0hIKICc4D2BkWAHpihN
X-Google-Smtp-Source: AGHT+IHuKMs0rC8AkpcPGwT8fMwy0LIUxBFrs+y8Uu3OWZxqcjMrsHYxgkW2zzSGkZzhoMhHHUqREA==
X-Received: by 2002:a05:651c:b1e:b0:2d0:6c48:8777 with SMTP id b30-20020a05651c0b1e00b002d06c488777mr3912995ljr.27.1706800691924;
        Thu, 01 Feb 2024 07:18:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzHo/BMpbXlwq2Bb7Cq+XwG1cIAz96p6MJ56TRJ5l2LjvHtzPfIaCA7tT8fifrSavCHK6bOlKnwPnbrP7SXuOe1FtMAxEcTbQbNoq88YOMiDQODa3fSTnMxfEpmhpYRnYHEm0oShZxcSPqGKsjclh4E64Vow3kHQzTmrlNCljJMOHGWoCV3ZHcUcqEGQ2asyqUqgAV3ZVkELRNVlYlKvU6M65psnvm3FyFsO6FdKJEu59pbjMUJu/6XrYkgDym53tUdACQBmjBlAmCfYac8eF0O5GCcBwGLsKeFJsYIeBxryBeADJfJSC3Yyr3wP8OShbN/BNFmzFNBb81LdbqsHdD4T+Bo3ZdvZvcgvh+fzTSHIZWvg0tloVKz0ClBTv+682coao6Nbf2vwUyPrMe7Nh4krQcIRc0PBEU8sbdY63jpZY3l0iCIoKM/oxZY4384VWAdBZ/TwugAjouULZZ0SZUu6DOuYD9T+E+TXVGaxuzt2n0asEw/XmKR5WYRAPAPhKVkHH3cVTJNTHrtMFcneq84ySf8dPrurkahyNHVva8udsz+YbOCEHVZ4C4GUH5NcjUyFjOnCUgALMpyeVXB4lXTRmvtmbv/aywtnJ3N37sb2PabspxhpXb
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id z9-20020a2e3509000000b002cdf37ee19dsm2437978ljz.7.2024.02.01.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:18:11 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v5 0/9] net: phy: Introduce PHY Package concept
Date: Thu,  1 Feb 2024 16:17:26 +0100
Message-ID: <20240201151747.7524-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Idea of this big series is to introduce the concept of PHY package in DT
and give PHY drivers a way to derive the base address from DT.

The concept of PHY package is nothing new and is already a thing in the
kernel with the API phy_package_join/leave/read/write.

What is currently lacking is describing this in DT and better reference
a base address to calculate offset from.

In the scenario of a PHY package where multiple address are used and
there isn't a way to get the base address of the PHY package from some
regs, getting the information from DT is the only way.

A possible example to this problem is this:

        ethernet-phy-package@0 {
            compatible = "qcom,qca807x-package";
            #address-cells = <1>;
            #size-cells = <0>;

            reg = <0>;
            qcom,package-mode = "qsgmii";

            ethernet-phy@1 {
              reg = <1>;
            };

            phy4: ethernet-phy@4 {
              reg = <4>;
            };
        };

The mdio parse functions are changed to address for this additional
special node, the function is changed to simply detect this node and
search also in this. (we match the node name to be "ethernet-phy-package")

PHY driver can then use introduced helper of_phy_package_join to join the
PHY to the PHY package and derive the base address from DT.


The base addr + offset implementation adds additional complexity to
the code but I think will make DT reviwers happier since the absolute
reg implementation might make things confusing with having double reg
in the DTS. I'm open to any alternative implementation and also to
revert this to the absolute implementation.


Changes v5:
- Rebase on top of net-next
- Change implementation to base addr + offset in subnode
- Adapt to all the changes and cleanup done to at803x
Changes v4:
- Rework DT implementation
- Drop of autojoin support and rework to simple helper
- Rework PHY driver to the new implementation
- Add compatible for qca807x package
- Further cleanup patches
Changes v3:
- Add back compatible implementation
- Detach patch that can be handled separately (phy_package_mmd, 
  phy_package extended)
- Rework code to new simplified implementation with base addr + offset
- Improve documentation with additional info and description
Changes v2:
- Drop compatible "ethernet-phy-package", use node name prefix matching
  instead
- Improve DT example
- Add reg for ethernet-phy-package
- Drop phy-mode for ethernet-phy-package
- Drop patch for generalization of phy-mode
- Drop global-phy property (handle internally to the PHY driver)
- Rework OF phy package code and PHY driver to handle base address
- Fix missing of_node_put
- Add some missing docs for added variables in struct
- Move some define from dt-bindings include to PHY driver
- Handle qsgmii validation in PHY driver
- Fix wrong include for gpiolib
- Drop reduntant version.h include

Christian Marangi (7):
  dt-bindings: net: document ethernet PHY package nodes
  net: phy: add support for scanning PHY in PHY packages nodes
  net: phy: add devm/of_phy_package_join helper
  net: phy: qcom: move more function to shared library
  dt-bindings: net: Document Qcom QCA807x PHY package
  net: phy: qcom: generalize some qca808x LED functions
  net: phy: qca807x: add support for configurable LED

Robert Marko (2):
  dt-bindings: net: add QCA807x PHY defines
  net: phy: qcom: add support for QCA807x PHY Family

 .../bindings/net/ethernet-phy-package.yaml    |  55 ++
 .../devicetree/bindings/net/qcom,qca807x.yaml | 142 +++
 drivers/net/mdio/of_mdio.c                    |  75 +-
 drivers/net/phy/mdio_bus.c                    |  44 +-
 drivers/net/phy/phy_device.c                  |  84 ++
 drivers/net/phy/qcom/Kconfig                  |   8 +
 drivers/net/phy/qcom/Makefile                 |   1 +
 drivers/net/phy/qcom/at803x.c                 |  35 -
 drivers/net/phy/qcom/qca807x.c                | 832 ++++++++++++++++++
 drivers/net/phy/qcom/qca808x.c                | 311 +------
 drivers/net/phy/qcom/qcom-phy-lib.c           | 247 ++++++
 drivers/net/phy/qcom/qcom.h                   | 123 +++
 include/dt-bindings/net/qcom-qca807x.h        |  30 +
 include/linux/of_mdio.h                       |  26 +
 include/linux/phy.h                           |   6 +
 15 files changed, 1648 insertions(+), 371 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
 create mode 100644 drivers/net/phy/qcom/qca807x.c
 create mode 100644 include/dt-bindings/net/qcom-qca807x.h

-- 
2.43.0


