Return-Path: <linux-kernel+bounces-72879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD40A85BA02
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925FC1F24D87
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0586867A11;
	Tue, 20 Feb 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="koK9s9Ky"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41807664BD;
	Tue, 20 Feb 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427455; cv=none; b=LWoI9Ih/ONgODsUgbAPz7hxmaJjmdW3kEIm443t/Hqpfp5I2qF7TQD9RJ4zaz1StH4hRQvBRy3UMaK85fzq65SZz+SFGbX5kMdwqhZUhjnUy1OWrYOWcUhn7eALfGJwNPDgzVdGAC2xMFhwbu58OIdXnDYiQEe6AG8VR7uS+wPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427455; c=relaxed/simple;
	bh=nQVe8DG/JFvnv0ImgA+YfJht7R4QvcKwxqiAmqZnr+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gehk9oBQFXF8b9mszKA29sYM3dQK84SCLFsMmju439JuNTPj3lbRgQEyy+AcXJosA5W1zOYfYkJMk36kvwQGiypfQ2mdv5KorP0KQcfcuoAJRoAQZHq0rndzvxyxQh8uuUV+n3fBD5xhBFvOrzduRgbt5MCPw+zVRFpJ39M79Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=koK9s9Ky; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id AD00E1BF208;
	Tue, 20 Feb 2024 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708427451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sfY3aVHkl2j7c2MzxUss4oqt2z8IPUj4t/sMOG6NTB4=;
	b=koK9s9KytA1AMTKWb7dPproZyDMrcXLLzbHhXIJhK/jPVJviAcgq0byr+E+osPfuCZeERg
	5c4vcvFX6DQ9GxTsYaUSgmlDIbCWvVeb5F7yYQ8zG1y1Nf/BIP22tv7rzZaCLf6F/4jdzu
	nCmLcxUNAMAES6XK1wNknbTBILbI2qwh2Nk8GPEVDOEo8hKl2OCmRi8gNZpAjfObzIkvmC
	4pBer2VCyjHAq52wJ1uV9NxCotUft59audbr6xXddjOY8l+jd6w+Wg0LYQ77SDsoFI6+S4
	eHJMw8xbHe8/jIIRrRvSisU79/o530yt2vq/c1XqEiJzxnCQXmhiLGvJ7b8qyg==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Wolfram Sang <wsa@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 0/2] devlink: Take care of FWNODE_FLAG_NOT_DEVICE in case of DT overlays
Date: Tue, 20 Feb 2024 12:10:35 +0100
Message-ID: <20240220111044.133776-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Since commit 1a50d9403fb9 ("treewide: Fix probing of devices in DT
overlays"), the FWNODE_FLAG_NOT_DEVICE is set on nodes present in the
overlay. Having this flag set leads to some wrong devlink links.
For instance, some links can be created with a supplier set to a parent
device instead of the device itself.

This series clears the FWNODE_FLAG_NOT_DEVICE in some specific location
to fix the wrong links issues.
- device_add()
  When a device is added, the related fwnode (if any) is populated as
  a struct device. It makes sense to clear the flag at that point and so
  avoid differences between DT used with or without overlays.
- of_link_phandle()
  If the supplier device has a compatible string and 'is available', a
  device is going to be created soon to handle this node. In that case,
  to avoid a link created using the supplier parent device instead of
  the device itself, clearing the FWNODE_FLAG_NOT_DEVICE makes sense.

Best regards,
Hervé Codina

Herve Codina (2):
  driver core: Clear FWNODE_FLAG_NOT_DEVICE when a device is added
  of: property: fw_devlink: Fix links to supplier when created from
    phandles

 drivers/base/core.c   |  1 +
 drivers/of/property.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.43.0


