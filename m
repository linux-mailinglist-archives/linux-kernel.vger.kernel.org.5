Return-Path: <linux-kernel+bounces-45450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C58430EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D39E28694D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C36383BA;
	Tue, 30 Jan 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzdx5W8C"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8289E14F61;
	Tue, 30 Jan 2024 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656440; cv=none; b=f7dE+Oil0QmDZnHCcy+M3WUu0cB0L4CNDGyzy2XmgKCALQyVQKPOvSK0blCdoYXj7hjbUQbv2fpUyPqQo+PqULUF5qkCNym2yGKWPfXgJPzHu+bOKmxTVhlv/8qhk5RqTXcejQx/jhfjP273CpeRDUoU6hkzHL3zUS5oIf28t2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656440; c=relaxed/simple;
	bh=Y5jGGDlLgAonKzkU6NVcSUwqWvsy5Icz/yfFUKvOxxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CXAjs3+Hqy7MhkBfgMjqryQW60LC7Eg5CaggFA16VEQ513wHArNKmQ+k/wrXOjfJ5JDQXvyOWiDnCtKfTe+nOugRxMuVkkD8wEd8Njn9bwHlEpWsREuMsU76cuV0eyNu6o/dPrACx6Xh1rUOZ8Nzg7ZfTS8c2zPf0nkhUxoWwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dzdx5W8C; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d8e7ebbbadso16095555ad.3;
        Tue, 30 Jan 2024 15:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656438; x=1707261238; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MkfxBx2+nJc0jJHOpNpJS4dT4U7h33tlBnDjr2cNZfg=;
        b=Dzdx5W8CwgNWiWzicA6WUQOJVwTfcFoBaLVrj5FQ2vmS+Br7wKgddy0NHiSJKJxWNb
         /IHVs2/TKai0MoB8UcN8H8y0v2QI84W+X0ULZXRxTB5jeJFj2wfa/S5aJKkaT0hfPVII
         nJHo+jYh78Cv5x82Vr8CfLFeM4suQcIJ7JZKacTAyiSL4AiHjlmGsjsSbgA4vRRfjX3W
         zU0iplt2aZgCxem+qMC4d6ePbNjhC9qwPcX0MDt1IGEVabbC/e+HzJxa+pt1LdZqhQp8
         r6RTGnlnXyL/m92ooFDts4P/Dtf3pXe/QPNw3OPE10uj9b/5QL7mq91wpwC4ZGoGtAVf
         qYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656438; x=1707261238;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkfxBx2+nJc0jJHOpNpJS4dT4U7h33tlBnDjr2cNZfg=;
        b=Y0vVL7Lj9xQNVTLlCuM/4bqSdJarL+Kmf1SJsmr9iufrL+l2rkkRBjVgooDxTf4H9t
         pcTipe2rPcUQzSovmMCux44slvmAVhQWGYuJB2Pcn2Pti08AFq75xLxfXkQjWfA4EC8t
         aU4IfCJncbso2ZZDkKAqBSjg2OVaZzSzPQ/4LnpmzJgiuZecGuEVhB4AzMPv2nYFQwJw
         2uFxaqLYQPY7Cy/BrwaBtl/CYsslrihxupLejAoAG2ZYAbWmOwrwaLczIZLSEZ3NDatx
         y9ez2PkTBnWcrggTIVMSBBD/06zWPahai+/Oq3UrEISJYY9Rm07mg1Jv4SBVpo615jFt
         Z+kw==
X-Gm-Message-State: AOJu0YzLFKz59wuXbm7jh6W30DT6lzTviVz15MV7H9R7AAjJFfxMR2al
	mZZHFLdBrGxwlxUWDHP/P12egUjym5jHveGi8mg4SSeZx6jiPXu9
X-Google-Smtp-Source: AGHT+IGYUI5NO2j8F/oi4bDNPEUcHKSPtW3OrBSKC1any2PxVxnkxiTvBLS0oIeVbRjrUrZzzDb4/w==
X-Received: by 2002:a17:902:f7c6:b0:1d6:ea06:9432 with SMTP id h6-20020a170902f7c600b001d6ea069432mr38337plw.87.1706656437692;
        Tue, 30 Jan 2024 15:13:57 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d8f251c8b2sm3473203plb.221.2024.01.30.15.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:13:56 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v5 00/11] net: dsa: realtek: variants to drivers,
 interfaces to a common module
Date: Tue, 30 Jan 2024 20:13:19 -0300
Message-Id: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+CuWUC/02MQQ6CMBBFr0Jm7ZC2QlFX3sMYU+sAE0tr2mKIh
 LvbuHL58v97KySKTAlO1QqR3pw4+ALtrgI7Gj8Q8qMwKKEaIVWHkYzL9LyVM8VEKO9aKNkchT2
 0UKxXpJ6XX/ECnjJ6WjJcy9LHMGEeS+C/uFey1ULXSndSo0Q388fN1pyHybCrbZhg276ZMoYYp
 wAAAA==
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6247; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=Y5jGGDlLgAonKzkU6NVcSUwqWvsy5Icz/yfFUKvOxxg=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBluYKXaf6u+492KLQrXuxH6yPOJn8TTXwpzTovy
 2/G5e0HSHmJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZbmClwAKCRC7Edu60Qc7
 VhwmB/4wkQIbBw+YP/xxQdbaoDv+hbRPD1XUrQr31x/K5+CcMJ/uVaqySmqjllKig3/ua/os6NI
 dRNbA72fYKMsGuRta9Gank9U2PuPIdf8PW7LYlt1lmUsRjc9yT46/a82pBV2GA1TjjXmkyVSYC3
 DwWVPcHhqvuKafJftbhhcAfon1hd8CVG8WCU4FmOvvc4GLzL91dCaQzAX3aYdc0Kq9irABKqrqy
 MAUjMHLkbCev6Tbyq2oM6fpY0j6L6Z3/eHZ2gwbcSU2jDQWiZieEi23pjEPZyol7vF4caJO9vaH
 DKm8vjFXeRwQQq2yUrrGErh5P8t7OeP4QpnA+8m7bE4DZzP+
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

The current driver consists of two interface modules (SMI and MDIO) and
two family/variant modules (RTL8365MB and RTL8366RB). The SMI and MDIO
modules serve as the platform and MDIO drivers, respectively, calling
functions from the variant modules. In this setup, one interface module
can be loaded independently of the other, but both variants must be
loaded (if not disabled at build time) for any type of interface. This
approach doesn't scale well, especially with the addition of more switch
variants (e.g., RTL8366B), leading to loaded but unused modules.
Additionally, this also seems upside down, as the specific driver code
normally depends on the more generic functions and not the other way
around.

Each variant module was converted into real drivers, serving as both a
platform driver (for switches connected using the SMI interface) and an
MDIO driver (for MDIO-connected switches). The relationship between the
variant and interface modules is reversed, with the variant module now
calling both interface functions (if not disabled at build time). While
in most devices only one interface is likely used, the interface code is
significantly smaller than a variant module, consuming fewer resources
than the previous code. With variant modules now functioning as real
drivers, compatible strings are published only in a single variant
module, preventing conflicts.

The patch series introduces a new common module for functions shared by
both variants. This module also absorbs the two previous interface
modules, as they would always be loaded anyway.

The series relocates the user MII driver from realtek-smi to rtl83xx. It
is now used by MDIO-connected switches instead of the generic DSA
driver. There's a change in how this driver locates the MDIO node. It
now only searches for a child node named "mdio".

The dsa_switch in realtek_priv->ds is now embedded in the struct. It is
always in use and avoids dynamic memory allocation.

Testing has been performed with an RTL8367S (rtl8365mb) using MDIO
interface and an RTL8366RB (rtl8366) with SMI interface.

Luiz

---

Changes:

v4-v5:
1) Removed empty line at the end of files
2) Multiple kdoc fixes
3) added rtl83xx_unregister_switch and rtl83xx_shutdown
4) moved include <linux/regmap.h> from rtl83xx.h to rtl83xx.c
5) moved dev_set_drvdata to the end of rtl83xx_probe()
6) changed mii_user bus is name to devicename(switch):user_mii

v3-v4:
1) Changed Makefile to use ifdef instead of dynamic variable names.
2) Added comments for all exported symbols.
3) Migrated exported symbols to REALTEK_DSA namespace.
4) renamed realtek_common to rtl83xx.
5) put the mdio node just after registration and not in driver remove.
6) rtl83xx_probe now receives a struct with regmap read/write functions
   and build regmap_config dynamically.
7) pulled into a new patch the realtek_priv change from "common
   realtek-dsa module".
8) pulled into a new patch the user_mii_bus setup changes from "migrate
   user_mii_bus setup to realtek-dsa".
9) removed the revert "net: dsa: OF-ware slave_mii_bus" patch from the
   series.

v2-v3:
1) Look for the MDIO bus searching for a child node named "mdio" instead
   of the compatible string.
2) Removed the check for a phy-handle in ports. ds->user_mii_bus will
   not be used anymore.
3) Dropped comments for realtek_common_{probe,register_switch}.
4) Fixed a compile error in "net: dsa: OF-ware slave_mii_bus".
5) Used the wrapper realtek_smi_driver_register instead of
   platform_driver_register.

v1-v2:
1)  Renamed realtek_common module to realtek-dsa.
2)  Removed the warning when the MDIO node is not named "mdio."
3)  ds->user_mii_bus is only assigned if all user ports do not have a
    phy-handle.
4)  of_node_put is now back to the driver remove method.
5)  Renamed realtek_common_probe_{pre,post} to
    realtek_common_{probe,register_switch}.
6)  Added some comments for realtek_common_{probe,register_switch}.
7)  Using dev_err_probe whenever possible.
8)  Embedded priv->ds into realtek_priv, removing its dynamic
    allocation.
9)  Fixed realtek-common.h macros.
10) Save and check the return value in functions, even when it is the
    last one.
11) Added the #if expression as a comment to #else and #endif in header
    files.
12) Unregister the platform and the MDIO driver in the reverse order
    they are registered.
13) Unregister the first driver if the second one failed to register.
14) Added the revert patch for "net: dsa: OF-ware slave_mii_bus."

---
Luiz Angelo Daros de Luca (11):
      net: dsa: realtek: drop cleanup from realtek_ops
      net: dsa: realtek: introduce REALTEK_DSA namespace
      net: dsa: realtek: convert variants into real drivers
      net: dsa: realtek: keep variant reference in realtek_priv
      net: dsa: realtek: common rtl83xx module
      net: dsa: realtek: merge rtl83xx and interface modules into realtek-dsa
      net: dsa: realtek: get internal MDIO node by name
      net: dsa: realtek: clean user_mii_bus setup
      net: dsa: realtek: migrate user_mii_bus setup to realtek-dsa
      net: dsa: realtek: use the same mii bus driver for both interfaces
      net: dsa: realtek: embed dsa_switch into realtek_priv

 drivers/net/dsa/realtek/Kconfig        |  20 +--
 drivers/net/dsa/realtek/Makefile       |  13 +-
 drivers/net/dsa/realtek/realtek-mdio.c | 207 ++++++-----------------
 drivers/net/dsa/realtek/realtek-mdio.h |  48 ++++++
 drivers/net/dsa/realtek/realtek-smi.c  | 273 ++++++------------------------
 drivers/net/dsa/realtek/realtek-smi.h  |  48 ++++++
 drivers/net/dsa/realtek/realtek.h      |  12 +-
 drivers/net/dsa/realtek/rtl8365mb.c    | 125 ++++++++------
 drivers/net/dsa/realtek/rtl8366-core.c |  22 +--
 drivers/net/dsa/realtek/rtl8366rb.c    | 118 +++++++------
 drivers/net/dsa/realtek/rtl83xx.c      | 299 +++++++++++++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h      |  22 +++
 12 files changed, 691 insertions(+), 516 deletions(-)
---
base-commit: 2121c43f88f593eea51d483bedd638cb0623c7e2
change-id: 20240127-realtek_reverse-1b6021490c85

Best regards,
-- 
Luiz Angelo Daros de Luca <luizluca@gmail.com>


