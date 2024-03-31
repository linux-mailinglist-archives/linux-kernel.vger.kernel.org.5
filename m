Return-Path: <linux-kernel+bounces-126045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D7893159
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5441F220C1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5AD1448E7;
	Sun, 31 Mar 2024 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="OvsSvFv4"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3F1442F9;
	Sun, 31 Mar 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711882728; cv=none; b=SdZhMmYYj8wDCmL/To68AkmruQXAHK9Un+VfJ5hTqk4uSeuQJq3Zm7O3N4wWM/HvLW3zAnejZUG41MIGy/xCurUCM13BpR69dN5DXlBtI1EVeioK/jwHPHndMlCbzNWkXQfqiQYXvZw++kJt6wSm+KFuvkOieeGMRCIZA/iantE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711882728; c=relaxed/simple;
	bh=t93YFYitOmuzsRrL966Hzq4Kb+YDmIsifWDYidPpN90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csUDQZ+zKTeFAF+cbohbB/ef9qk81ZIjbwE5BKZRYSmEXA/HV2Mi+lQAy2jC2bHZy76EYPZaLdAwGRV7SB5a7LPX1Eur0WnTAf/lcDgQvLhk3wdHJ0PYcxw5Fp/5xfmHDJizzNtYW5JjAV6GbPSx0wkhTxWNtju5JxEAQ6H5wMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=OvsSvFv4; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1711882687; x=1713182687;
	bh=x+wQ7I/sdjfXLmnJE9MBqntMralduAmx24DA6Fuwkgk=;
	h=From:MIME-Version;
	b=OvsSvFv49FkibgnTVvNN6kIC1pcqaEKvnS+JrnRoL6Y7/lxwXRNCMD9dvVbO6DAh7
	 LLhTvB7LoTAN7B3bzTsREXqyWthUDaDL+G7qNhyGqn311cvWXKOl0Ss8YcNLeUXgL+
	 tIACKdsYTKRwMANKg0fJKGjWrIL+VqGagCcdu1kLVyEZyNrCkwjFYHmrOqFK/EOAZr
	 lnBtzXvP4yqnb+QhIoaKyEWyg5PE/0Dvwwra6emZbqeM0a4cdzCZfWQAJ3Y1CHXlw4
	 ZsVDNHn5YcYBhc58GaPQy1q75/xAHUiDUTSpvTnerJr+lQ4ABNuZ16weQxv0Uozgc6
	 eST/6mZgszqvQ==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42VAw5IC095397
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 31 Mar 2024 12:58:06 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH 0/5] initial support for Marvell 88PM886 PMIC
Date: Sun, 31 Mar 2024 12:46:53 +0200
Message-ID: <20240331105608.7338-2-balejk@matfyz.cz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

the following implements basic support for Marvell's 88PM886 PMIC which
is found for instance as a component of the samsung,coreprimevelte
smartphone which inspired this and also serves as a testing platform.

The code for the MFD is based primarily on this old series [1] with the
addition of poweroff based on the smartphone's downstream kernel tree
[2]. The onkey and regulators drivers are based on the latter. I am not
in possesion of the datasheet.

[1] https://lore.kernel.org/all/1434098601-3498-1-git-send-email-yizhang@marvell.com/
[2] https://github.com/CoderCharmander/g361f-kernel

Thank you and kind regards,
K. B.
---
v1:
- RFC v4: https://lore.kernel.org/r/20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz/
- Rebase to v6.9-rc1.
- Thank you to everybody for their feedback on the RFC!
RFC v4:
- RFC v3: https://lore.kernel.org/all/20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz/
RFC v3:
- Address Rob's feedback:
  - Drop onkey bindings patch.
- Rename PM88X -> PM886 everywhere.
- RFC v2: https://lore.kernel.org/all/20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz/
RFC v2:
- Merge with the regulators series to have multiple devices and thus
  justify the use of the MFD framework.
- Rebase on v6.8-rc3.
- Reorder patches.
- MFD RFC v1: https://lore.kernel.org/all/20231217131838.7569-1-karelb@gimli.ms.mff.cuni.cz/
- regulators RFC v1: https://lore.kernel.org/all/20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz/

Karel Balej (5):
  dt-bindings: mfd: add entry for Marvell 88PM886 PMIC
  mfd: add driver for Marvell 88PM886 PMIC
  regulator: add regulators driver for Marvell 88PM886 PMIC
  input: add onkey driver for Marvell 88PM886 PMIC
  MAINTAINERS: add myself for Marvell 88PM886 PMIC

 .../bindings/mfd/marvell,88pm886-a1.yaml      |  76 +++
 MAINTAINERS                                   |   9 +
 drivers/input/misc/88pm886-onkey.c            |  98 ++++
 drivers/input/misc/Kconfig                    |   7 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/mfd/88pm886.c                         | 157 ++++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/regulator/88pm886-regulator.c         | 509 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   6 +
 drivers/regulator/Makefile                    |   1 +
 include/linux/mfd/88pm886.h                   |  30 ++
 12 files changed, 907 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
 create mode 100644 drivers/input/misc/88pm886-onkey.c
 create mode 100644 drivers/mfd/88pm886.c
 create mode 100644 drivers/regulator/88pm886-regulator.c
 create mode 100644 include/linux/mfd/88pm886.h

-- 
2.44.0


