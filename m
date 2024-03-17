Return-Path: <linux-kernel+bounces-105589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2318787E119
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9351C20B8A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5B219EB;
	Sun, 17 Mar 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DWIo2AnZ"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E114B208B0
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710718230; cv=none; b=pCGxD9WDvpBRKROhT6UaePZrp+Q9z0/a/HD++zrBbSg5SZZ0IVyg0oPLSWY78uS/0Dp5dbOA5YSi+zmJA810dLl9Q3tohbdu2eUOZeOcK0jt2EkV0ZR6b1KPYFfaGk8ZqJ4B0Y1Qr42lmAfKU3wWLGmLIDvixdDYqKQU2MnhHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710718230; c=relaxed/simple;
	bh=U75otsaamijrV2NAmRD0P2IsQSWXPIOQDC+dVt2vt8A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RHHxEbczCABPkMT9PexAjtj7snD65YkDmKwUt8oBYCyRI+56Ya0cxoXYOJQL0s4uOtd2gaxC8MDVqwz7UJKop3tlrzy6qjdpPDv958weXRwEwVl+KxmoRAaflDsS0F+0p8PsQTK+OeZaadD9z8Z1MQQgaIfn+b5ghJt9RDpHxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DWIo2AnZ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFFDF20007;
	Sun, 17 Mar 2024 23:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710718219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qUhKoh9x7/zlcPWHn7hoEfdM/jkA+eVywgtcxwW2dlw=;
	b=DWIo2AnZrKGlhAx/y4JpoVgijRc6hTTwiMg1TY/Pb1p/wT9ODoufJwNBW7rqwzuQzbADiD
	ycSSlX3nd8RAlVx2/ExQBR0nCx6iCBMG4VqXIH3khjtA/z5J5UcHJdD1i/pOnBzMDwafBN
	dhTFnwfKavzS+3wR27p5Q/UpBZ4oHYmjyEq6fjAF71j923k+4iFjd70jFeOpA0lYet5gUZ
	RnuCsrp4YyZaYEjQ2IL+W9qlGiDbLYs5+oATxQStmX4WuT/RlFlDh9a1JM+DcLRUL0hrAo
	9q2JBSEsMOMU11okSfaF39UOHZgB6iUsFvSSuwfWsZ0/FJJ8UBLCUngHsCmouw==
Date: Mon, 18 Mar 2024 00:30:17 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.9
Message-ID: <20240317233017c4c35cab@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello Linus,

Here is the I3C subsystem pull request for 6.9. Not much this cycle with
only 3 patches.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.9

for you to fetch changes up to 8f06fb45853900b4deaa52e2a9e16f3d9550b011:

  i3c: Make i3c_bus_type const (2024-02-19 21:23:28 +0100)

----------------------------------------------------------------
I3C for 6.9

Core:
 - i3c_bus_type is now const

Drivers:
 - dw: disabling IBI is only allowed when hot join and SIR are disabled

----------------------------------------------------------------
Dylan Hung (1):
      i3c: dw: Disable IBI IRQ depends on hot-join and SIR enabling

Krzysztof Kozlowski (1):
      dt-bindings: i3c: drop "master" node name suffix

Ricardo B. Marliere (1):
      i3c: Make i3c_bus_type const

 Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml | 2 +-
 Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml    | 2 +-
 Documentation/devicetree/bindings/i3c/i3c.yaml                | 4 ++--
 Documentation/devicetree/bindings/i3c/mipi-i3c-hci.yaml       | 2 +-
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 2 +-
 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml | 2 +-
 drivers/i3c/internals.h                                       | 2 +-
 drivers/i3c/master.c                                          | 2 +-
 drivers/i3c/master/dw-i3c-master.c                            | 4 +++-
 9 files changed, 12 insertions(+), 10 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

