Return-Path: <linux-kernel+bounces-30424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83797831E79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C743282DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33862D05B;
	Thu, 18 Jan 2024 17:33:35 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7E32D78A;
	Thu, 18 Jan 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599215; cv=none; b=uT9EFRjfzGIJ/nAkCvUspR0vlR5O+uZMLqF95/bSBkStH2sfMLSsCbtZiqRmwwiDsFzQsrDMzWJPkaQpZECi0ez5d4h77+eUUKcqwpfca573JTEYqkAUJd1Um9tGqJrq78+Yt/PRUsRhMBfsmxqB2CCRmRoh180j2xbjMOk7SOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599215; c=relaxed/simple;
	bh=zSojkb9oa18GUBW1ZjAD4v5bdWLOPJhL+eDSN4oBcHs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CIge7drM6Hz9k5G95LfIyliIAeXFsDlfDMmRxFqBkDtg0ipgzW5457pMsvvS0q0lFimpBcg5ZDn7rwTDGqLfD+JOMK0za/fxQu2rtQeqAR5Cm01pVrqQTL2VCJ2smbc9ekgLcQcundi2yLU7srCHT1N4sCsoZiGKwRylz3sMRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 344D3866EA;
	Thu, 18 Jan 2024 18:33:24 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v2 0/2] Kinetic KTD2801 backlight driver
Date: Thu, 18 Jan 2024 18:32:37 +0100
Message-Id: <20240118-ktd2801-v2-0-425cf32e0769@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALVgqWUC/z3MQQrDIBCF4auEWdcyaiymq96jZJHopEpKDBqkJ
 Xj32kC7/B+Pb4dE0VOCa7NDpOyTD0sNcWrAuGF5EPO2NggUkiO2bN6s0MgZTlJraUbVWYT6XiN
 N/nVI976282kL8X3AmX/Xn6H+Rq4Ma6WxWo14Ed1wS3N40tlF6EspH+mznb2dAAAA
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=zSojkb9oa18GUBW1ZjAD4v5bdWLOPJhL+eDSN4oBcHs=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlqWDBb2YGGpgsgix8UXpwxFe4Vyv+qY/SOJaLM
 g8Eq0fu96SJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZalgwQAKCRCaEZ6wQi2W
 4SPlEACZQl6p/zx4TzYIK7kXZhjzDR2FDa/QIbn50ad9nnDfWy6jkRd+lDv5gXm8ZVBjD01e3FK
 ECgsBBs9oft4nrZ35uY6iNTcNgyCwDL8fSbqZfuTye1yUP1yy06nPrUNmFULuyJ5HrcbGQN6We6
 m4uEfEr5Rn7vLGviVuwK/rj+9YZSWAI2Wd/rqNd39yx8/MGo4oz4VnC9JbQhZhBw7PMtDL7mWUV
 ptjS0gmRx5sJK7YiOWhj8IC95h5U97ShkeUMMaVkvgoPpUVjQPpdTWVIGZ1x1BlJIDdh3RYjhHE
 DpiTjcvNWGxRa99NdqXb7Cb47auZTC/Z5Bb8N7jPH5N4WektAg7H+M9yefS8tkP+N3fJC142eYq
 3IW0gwnZEghHWXxZZ6/My/wsElID+ykQbVY+YnNrmcfl0pjuogDjMOmlsRrvxWp79FetLSNG8CE
 zwOneEqUnD3SipnO4B8k85rIwGiIfE4IILfl6STltOpjnc27aRmE62HGgJ1iY2semAdicA/4gR6
 s39lseXtoRyHYp9b0n/y7WNj3sCDykDybv0yMr0vz8AytVMgTu9bKM1RSQ619r2nVOMQfRxKsh1
 Y7ZJFiUU9VozU84WtPsqHIEXHz6tU+bDIBNpqp0ok5Db4G8p7xf64JsdgPqzKu/x4Ylw5yDq70i
 lgpHmR+3Ow8kDqg==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Hello,

This small series adds a driver for the Kinetic KTD2801 backlight IC.
The driver has been tested on the samsung,coreprimevelte for which
support is still out-of-tree.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v2:
- Address maintainer comments:
  - Drop MODULE_ALIAS
  - Rename enable-gpios to ctrl-gpios
  - Rename ktd2801_backlight->desc to ktd2801_backlight->gpiod
  - Give time constants more descriptive names and note their origins in
    Samsung driver
  - Convert to GPIO_ACTIVE_HIGH
- Update trailers
- Link to v1: https://lore.kernel.org/r/20231005-ktd2801-v1-0-43cd85b0629a@skole.hr

---
Duje Mihanović (2):
      dt-bindings: backlight: add Kinetic KTD2801 binding
      backlight: Add Kinetic KTD2801 driver

 .../bindings/leds/backlight/kinetic,ktd2801.yaml   |  46 +++++++
 MAINTAINERS                                        |   6 +
 drivers/video/backlight/Kconfig                    |   7 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/ktd2801-backlight.c        | 149 +++++++++++++++++++++
 5 files changed, 209 insertions(+)
---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20231004-ktd2801-0f3883cb59d0

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



