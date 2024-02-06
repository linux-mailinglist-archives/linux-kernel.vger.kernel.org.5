Return-Path: <linux-kernel+bounces-55381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18684BBEE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAA91C23A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04286D517;
	Tue,  6 Feb 2024 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI+qmq7g"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168DDDA5;
	Tue,  6 Feb 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240737; cv=none; b=VzhbbwD5+qAlwQ/wVQW6iKTdpYgsdP0Y+Gio0jESX/mbGBERAVnWtCSi5za0gK/2OpORu8hSTCWqUdgQU+jfEhby2iQ8YIUoZo/GSf1/IGCUAMAdEFgJcPL7ZuqoO9Bdv+qqfoqsywpNJBRmm+WWjMbt8oo2xoVAjHt0R938Hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240737; c=relaxed/simple;
	bh=3EeqJRLIoyYWfkrLk4PEQiIIv5w+frMQJAaL/cliLXA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PXUnzAKm2iCK5E9iBLk1xeQiasA7tlI/fudQGmxpgQXyHhnx1ffutrvhdTKRfl626PrzhZsAcLM5+JSPhfybFnh6POYGuGJS68jgAjdAKykUEoyHNHLVll/VNSGvMgptotKzVOQJ713ZBRmvNHEACJPdngxtKhz+k5spMPRnSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI+qmq7g; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fd72f7125so24162135e9.1;
        Tue, 06 Feb 2024 09:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240733; x=1707845533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V70bM6HDNj3Uk2T0tooI4Z/8UV1Jdcvl7ssqvAQfxw8=;
        b=XI+qmq7gXzwpMY/x2FbD4pqDzDsvTH9yJ67c7NOUAzLhxKFU+flFE/LwMEbdV4XYGr
         TiLUw3OS+q0jRvuyGfXo0ufHWZREheUu4bRo0qdB6FuywtbIucICE2SjpED0e3DIY/vb
         90yIkwwLNHNC/pYarPD9+lnAkihIUGe5DZFKvngCsTyW1+k2jhsgsQ/TMPXNRbdaUaur
         HJvyrEKI9YXWhKmfbcJ3uaDm69Fo231Q83xTTn+irg6JPWCVdPGMFsdmdVSWmhJBTJcm
         ftjqbWXHN0oi0V4YSt2We4PvOdAcrd9Ow60Y86WoF0dMF3JtCaiozQQbPo7mgiCI2E4W
         PkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240733; x=1707845533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V70bM6HDNj3Uk2T0tooI4Z/8UV1Jdcvl7ssqvAQfxw8=;
        b=YsgqQMftibK6alAz86/+MdZd2s058IGPSBAQNmkXFRbiXNZUm4PkEtxicPFb2A/1Ex
         aPT8rsyrdcWwlopElM0VizLVdgl/h6G/adlJZzuhjfwji/bvGWTsXMkLa9iFUwI+uETx
         CFDaH2pHlfAKrMidcKj9eILgJrg0LwQ3dkra+/tJJKZrGWATgLxVtZqnLycdGclfTeg0
         YUa0IXs65VeY6K9oyAt+o+dCHQN5deTR/quia1he/knLIyihTNROxAA46sp7hQT02XSK
         dkXIXyw++MnpYJwMx2cCKhoKsUW7jaSpiKvyyaXXbhhOGW1SX87sGyB1z8+NybpgnRjN
         UC4Q==
X-Gm-Message-State: AOJu0YyMKjE4sbR28bz8zLEWxx9dnh6rtqoQ3ImtrsPTlLNL8eFi+9G8
	LCe9Mmw6pxym79a4b/t5hZTM0ZrEZ5jL4l/ijWAhJbUp38AdqQmA
X-Google-Smtp-Source: AGHT+IEMwx8Lk6oiSspl5swxW099g50M8+BAg5/3So1l1AliwRcW/NIn2wnSplLRUrqwLu5d6riV8w==
X-Received: by 2002:a05:600c:4587:b0:40f:afdd:40a with SMTP id r7-20020a05600c458700b0040fafdd040amr2659546wmo.0.1707240733446;
        Tue, 06 Feb 2024 09:32:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXDvJOZ6skEQke9aWfAmCIifEAZLSqQhoQ3dK/YZASnpDsgHhFARn5wvKyaCeQJ+s8Mpmngwt8lhINKdJVp2vXL5RWBf9nq3H6yCedz2M1lOHr+BpXNnLM+bQu4HUyNT2uepjBM6+N8bvWcNOLPAX5uIYlHo1pCO5umAbDCZ5kgmFiEuq//mg/pqiwkj4QB173eXcTPqItIqKvlQkNljRaq6jYbjfoOk+ORXfdpNNgbPsSZJbhnY1GrWxU++pMYWoKMXEdt2POh/p79eDiCtnqbb6mMvKXaMdpYX8Wq4HpKLa4t8MojZ7sWIIOEazyuYXx2fMDb6So0MzEeZsqmz7rMXrHHKtZRhe5BrMnFsUL4IsOb5L60OchnosgA9vBf8OMT/RKe1LYaOTe7HoJWuNt8TurM9eNRalrhv4KdAZBvQE+47zhzZD/QEqnirqU1Av2NcShSoSh3JH66ljbPsGd1RlVQobeFFzFRVQSX5nkJvaLOOJ36TKVSO3SWcJQAlZi38JtWrmXLfoKTAKadWxrVyDTMxcCJPr87t7xIY/QVjhz7YVbSB81sRjwESZvPJEWzZTqw7BwJmSOOAWe1T6vnru0eDjSUZ+eqDzlat5aZA6dPZ7lBkqFEbQwzb4ZiD6qqj0eQYhuQGmGOkzH2/JmyOCxuMZRK/1l6aBxsvPPEN9X8mX7P8w==
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c4f0e00b0040fc56712e8sm2621215wmq.17.2024.02.06.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:31:39 -0800 (PST)
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
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [net-next PATCH v7 00/10] net: phy: Introduce PHY Package concept
Date: Tue,  6 Feb 2024 18:31:03 +0100
Message-ID: <20240206173115.7654-1-ansuelsmth@gmail.com>
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
            compatible = "qcom,qca8075-package";
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

Changes v7:
- Rebase on top of net-next
- Add Reviewed-by tag for DT patch
- Change tx-driver-strength to tx-drive-strength
- Drop driver reference in DT
Changes v6:
- Back to absolute PHY implementation
- Correctly drop refcount for node on error condition and on PHY leave
- Drop DT include patch in favor for 3 boolean vendor property
- Fix Documentation problem for compatible and missing type and
  description
- Drop redundand gpio-controller dependency and description
- Skip scanphy with invalid PHY Package node and make reg mandatory
- Rework fiber read status to use more generic function
- Split qca808x LED generalization patch to permit easier review
- Correctly return -EINVAL with wrong data passed to vendor property
- Drop removing LED ops for qca807x PHY driver with gpio-controller
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

Christian Marangi (9):
  dt-bindings: net: document ethernet PHY package nodes
  net: phy: add support for scanning PHY in PHY packages nodes
  net: phy: add devm/of_phy_package_join helper
  net: phy: qcom: move more function to shared library
  dt-bindings: net: Document Qcom QCA807x PHY package
  net: phy: provide whether link has changed in c37_read_status
  net: phy: qcom: move common qca808x LED define to shared header
  net: phy: qcom: generalize some qca808x LED functions
  net: phy: qca807x: add support for configurable LED

Robert Marko (1):
  net: phy: qcom: add support for QCA807x PHY Family

 .../bindings/net/ethernet-phy-package.yaml    |  52 ++
 .../devicetree/bindings/net/qcom,qca807x.yaml | 184 ++++
 drivers/net/mdio/of_mdio.c                    |  79 +-
 drivers/net/phy/broadcom.c                    |   3 +-
 drivers/net/phy/mdio_bus.c                    |  44 +-
 drivers/net/phy/phy_device.c                  | 107 ++-
 drivers/net/phy/qcom/Kconfig                  |   8 +
 drivers/net/phy/qcom/Makefile                 |   1 +
 drivers/net/phy/qcom/at803x.c                 |  38 +-
 drivers/net/phy/qcom/qca807x.c                | 849 ++++++++++++++++++
 drivers/net/phy/qcom/qca808x.c                | 308 +------
 drivers/net/phy/qcom/qcom-phy-lib.c           | 247 +++++
 drivers/net/phy/qcom/qcom.h                   | 123 +++
 include/linux/phy.h                           |   8 +-
 14 files changed, 1676 insertions(+), 375 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml
 create mode 100644 drivers/net/phy/qcom/qca807x.c

-- 
2.43.0


