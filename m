Return-Path: <linux-kernel+bounces-148611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8606F8A8512
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258B41F2148C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F29140362;
	Wed, 17 Apr 2024 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="glXCo5oO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XtLLDOKl"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3A63A;
	Wed, 17 Apr 2024 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361457; cv=none; b=AJuNKDLoUy9rvVN8ePCaQr3+JKIVyTEnqI55HfyRGxHQjq3oTQAw2hH1vcD4B/YrUeIzLqdPcrqgqciLlBrWy9ujm56DbucZnFEeFoPABtDIoTrp7Du/Sw4idrTdB+YT7ovFu39ipKymZlba1VeVK2OyFUxfCNtQyVaFE1Z2ygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361457; c=relaxed/simple;
	bh=E4jdcpqlpHV649PBxrqAo3I4iZRovg0Rv/OBXC7xv2A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iUP1UaA5J9MhZ855nxAV3hHnjAARMorgBp8ujVC5aO3n7coXfj9PQayCDZsPGXlTONYluFN+O0scrSX2uDqEMVJz+JjUij/aSXNSm5nCfVTiJIHvoJNBZEI4IVsMuk+JAW22dK5ne+U0eHZfj6IRn8citdcYEeAoOo28Ke8LxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=glXCo5oO; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XtLLDOKl reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713361453; x=1744897453;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=m3xYsRh6qs7oYoZ7K2b3HT0rgOW+vV21BP4CnhGFoSo=;
  b=glXCo5oOJ7xb6y6mDb+ifZZavg3ekyEdpp4zyLtn5qa+O6BFC9wBW06Q
   Rf6+Br0YyM0J5iU44VOyLHyW8EPXwS2EVork4sCkUo3aofCPs0PbBhgAn
   MatU0XgdzvFDH3lrPGjVBmdXxwIdCLuV8b4FOUgyZpTAPzgauc28ofzSi
   +BbrW4jispPlocc8uBUdvFFpPkFy7DdXoah5LH1yDOqp3DeurboH+RhCW
   G17fuhsQ/Ht2Zr7SadWHf9OUSiZku4uJNeGTK7eJYbZ8N+PST8RAjoJ7H
   tewtsG8KoHErasXlw+Juq4sBWn32JWbfiPXXvYGUKEFdDBM7KvoCkz2YH
   g==;
X-IronPort-AV: E=Sophos;i="6.07,209,1708383600"; 
   d="scan'208";a="36469970"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Apr 2024 15:44:09 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FD6E1724AE;
	Wed, 17 Apr 2024 15:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713361445;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=m3xYsRh6qs7oYoZ7K2b3HT0rgOW+vV21BP4CnhGFoSo=;
	b=XtLLDOKlUDRd9Ri93lSm2Ok1WDKmBfBEhWYNNdou4TR4ABN0UufAYxyMaw6QjMufA69br4
	woEKVtr/IYrkXOwi2JlZynWNxJMJD60Jm7uHzxHGUyx9eWg2dS5Ke3QfM2ww6Da6k65f+p
	E29p7r7itoPoljFchashf9yDcSFPM8frak7FoxBNf5F+kSfHb0xjOJPY6c9RZRIdAtAvgx
	UkwMX2niFChYc5tz78yZPLzVc33VaidfqPyEWW0by58LLrOHIYZpuV5xt8vnlwADTR9+Bp
	9SPdotPs6ylblVSOoDMzYeAC4tXWfMwMDlSY27HU99LCyp+PT7Rw0JmNi+PpDw==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Subject: [PATCH 0/4] can: mcp251xfd: add gpio functionality
Date: Wed, 17 Apr 2024 15:43:53 +0200
Message-Id: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABnSH2YC/x3MQQqAIBBA0avErBtI0aKuEi3UxppFJVoRSHdPW
 r7F/xkSRaYEQ5Uh0s2Jj71A1BW41ewLIc/FIBupGiU63FyQWjx+xiXwgZ7MeUVC2RthfWuc1Qp
 KHCJ5fv7xOL3vB8SEOixoAAAA
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com, 
 alexander.stein@ew.tq-group.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713361443; l=1700;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=E4jdcpqlpHV649PBxrqAo3I4iZRovg0Rv/OBXC7xv2A=;
 b=Nl3dVSjF1oazke2Jn82kPOGpEMq/E3cQyke+iD3PQGE7zTOA7HrI/Ig+xz+6KAzQDelpiNLIV
 UPpWjT8l+0bBbkQfP97ehIPhLGUCd7pQOXewMKyvX8JIfojWNbiR8J/
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

The mcp251xfd allows two pins to be configured as GPIOs. This series
adds support for this feature.

The GPIO functionality is controlled with the IOCON register which has
an erratum. The second patch is to work around this erratum. I am not
sure if the place for the check and workaround in
mcp251xfd_regmap_crc_write is correct or if the check could be bypassed
with a direct call to mcp251xfd_regmap_crc_gather_write. If you have a
better suggestion where to add the check please let me know.

Patch 1 fixes a unwanted wakeup of the chip
Patch 2 is the fix/workaround for the aforementioned erratum
Patch 3 adds the gpio support
Patch 4 updates dt-binding

---
Gregor Herburger (4):
      can: mcp251xfd: stop timestamp before sending chip to sleep
      can: mcp251xfd: mcp251xfd_regmap_crc_write(): workaround for errata 5
      can: mcp251xfd: add gpio functionality
      dt-binding: can: mcp251xfd: add gpio-controller property

 .../bindings/net/can/microchip,mcp251xfd.yaml      |   2 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     | 139 ++++++++++++++++++++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c   |  56 ++++++++-
 .../net/can/spi/mcp251xfd/mcp251xfd-timestamp.c    |   5 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |   4 +
 5 files changed, 200 insertions(+), 6 deletions(-)
---
base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
change-id: 20240417-mcp251xfd-gpio-feature-29a1bf6acb54

Best regards,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


