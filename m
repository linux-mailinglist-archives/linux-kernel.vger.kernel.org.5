Return-Path: <linux-kernel+bounces-165876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB68B92CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF29B22049
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BEF125C0;
	Thu,  2 May 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="jfpHIffg"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C77F6;
	Thu,  2 May 2024 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714609761; cv=none; b=j5mpyVNROkRCnW9mhhv7jBx08wQMOUyIRufrt6XVTkJmtcTJ/vLWI/d/XU80fI7VqitkXkSh4t3jec1dD1gygBAi68pyrw1qs8amgEceKhFBJ3/AML6kBtFpHIC0Iqx8gPf3rv5U8ZngJrp8ustTQrpAvs80YwqGa16a0yL4RzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714609761; c=relaxed/simple;
	bh=vPV4f5Bw/dV29ZniJ3tZ2E7sOaQ7mjxeUICLIvHoR+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fNncg2D7YuHmQhbV4Fl4lw33WJ+4kkYrCR6Vn82X1OUSxUuY7SX+uyyMNMQeNcGGmBQmvve1WcZYJBBUNCliGrlLlleV4hz1oBKBVX0dechL08GY0wnZogRVen7Rtip8kbA12uXjhnwIs9IQ5QEDjkKyfwRsN0aseipWfC/n1SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=jfpHIffg; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:712b:6300::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 3C8AD1E4;
	Wed,  1 May 2024 17:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1714609758;
	bh=BBF/i8p7QfyiL3Ij46FTmQUncBo1M1iWRiQsSyVShEc=;
	h=From:To:Cc:Subject:Date:From;
	b=jfpHIffgCrkjoX36/CZ+AxSHvpwFskxPuYdjR+N5cWXDG1RyXwnDgrXI8RKrkbG+v
	 P7nHyZDzdFNfUUgDgBeRU797IolND9ZE9Y9uJ0BKB+WkI7wkDKhZqUkuaE8UF9lIlP
	 TTf/U9vdg1XDg5GBbzKaVt5DwnZs1HllRsnWf4ZU=
From: Zev Weiss <zev@bewilderbeest.net>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Zev Weiss <zev@bewilderbeest.net>,
	Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH v3 0/3] ARM: dts: aspeed: Add ASRock E3C256D4I BMC
Date: Wed,  1 May 2024 17:28:30 -0700
Message-ID: <20240502002836.17862-5-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

These patches add a device-tree (and a couple tiny bindings updates)
for the Aspeed BMC on the ASRock E3C256D4I, so that it can be added as
a supported OpenBMC platform.

Changes since v2 [1]:
 - Added patch 1 adding isl69269 to trivial-devices.yml
 - Adjusted isl69269 compat string to use isil vendor prefix instead
   of renesas, dropped unprefixed entry

Changes since v1 [0]:
 - Removed bootargs [Krzysztof]
 - Renamed LED nodes [Krzysztof]
 - Added function & color properties to LED nodes
 - Added #address-cells and #size-cells to FRU eeprom node

[0] https://lore.kernel.org/lkml/20231114112722.28506-4-zev@bewilderbeest.net/
[1] https://lore.kernel.org/lkml/20231120121954.19926-4-zev@bewilderbeest.net/

Thanks,
Zev


Zev Weiss (3):
  dt-bindings: trivial-devices: add isil,isl69269
  dt-bindings: arm: aspeed: document ASRock E3C256D4I
  ARM: dts: aspeed: Add ASRock E3C256D4I BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-asrock-e3c256d4i.dts    | 322 ++++++++++++++++++
 4 files changed, 326 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts

-- 
2.44.0


