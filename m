Return-Path: <linux-kernel+bounces-89799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD9C86F5E2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727D71F22BC6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462D367C7C;
	Sun,  3 Mar 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ajFz9f3+"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485A679F8;
	Sun,  3 Mar 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709479892; cv=none; b=sTfwoPt9cHpOj0p4O2zhAWmvt8rsY7xPHuIrmAiy80k5PzSRVvUoxTrNWNQR9eAdq9Jc1ofJhONjdh++g59Y8m0hgWlteIAAkLugnQpj5CHVyTtzaaDQ66V0ceA2ACR4PscNxLqsNjzYWEkzPRJiFPrAcVOcpd+uPh/XGE0huZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709479892; c=relaxed/simple;
	bh=BMCjTdC0Fu2nH2LhHAv4BwNh5+V6v1koWf/3R/NO2HY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L/cnQlvWZLsrbUY15qItfiyxJj4iLCh/3KIX85DZLy08Y1EgGHcrB0HeLq19Gp8RFQfQDzMBY6fhlksQ63AZepDGww+m50FquzFySkYWKx7B7tNp0AHGc0g/5bQuP1f9mJCySa0JOPESaBKHoVUgKvDw6ASZHgAUh54LzoDhz2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ajFz9f3+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1709479880;
	bh=BMCjTdC0Fu2nH2LhHAv4BwNh5+V6v1koWf/3R/NO2HY=;
	h=From:Subject:Date:To:Cc:From;
	b=ajFz9f3+epov5O4TR5sYDNHUIyCrVUL29B8ronMM4c5yFRIOgarIy+RJmcv1rQVyb
	 Jdz8FlQVKuHqWjzOR++3gPzSLKQSiOYeECcgFi1mnAP1Dbzt36kBWp02TclihwW6ug
	 ncPInUdrOyKg2+RQwBYq1ecQpcapPR7MCY2PtO/o=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/4] power: supply: core: align charge_behaviour format
 with docs
Date: Sun, 03 Mar 2024 16:31:12 +0100
Message-Id: <20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMCX5GUC/42NQQ6CMBBFr0K6tmao2FhX3sMQgmWgkxjadKBIC
 He3eAKX7+fnvU0wRkIW92ITERMx+TGDOhXCunYcUFKXWShQFzDKyOAXjA3PIbxXmS9xwOaFrk3
 k59iE6IMswdq+M7rVWossChF7+vwizzqzI558XH/NVB7roa9AQfWPPpUSJOhWgTXXW2/0Y0FiZ
 utmdx5xEvW+719gbi9P2QAAAA==
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709479879; l=1906;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BMCjTdC0Fu2nH2LhHAv4BwNh5+V6v1koWf/3R/NO2HY=;
 b=NWAd8gl8NdXAXW/y8qaCv+zgnHRRG382XqOuVLW5lOlIiHDcmx9h56SiH8dC+3uzGWNI5uFg6
 1iPIwDrn7wEBvPcHQNr821G+DnXFhR+tLW+wBxo0sTYRu1oVYqsWWHi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The original submission of the charge_behaviour property did not
implement proper formatting in the default formatting handler in
power_supply_sysfs.c.

At that time it was not a problem because the only provider of the UAPI,
thinkpad_acpi, did its own formatting.

Now there is an in-tree driver, mm8013, and out-of-tree driver which use
the normal power-supply properties and are affected by the wrong
formatting.
In this revision the handling of CHARGE_BEHAVIOUR in mm8013 is dropped
as it is not the correct API for it to use.
That change was not tested by me as I don't have the hardware.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Simplify the backwards-compatibility logic (adds a preparatory patch)
- Extend test-power to also handle writing of charge_behaviour
- Drop incorrect CHARGE_BEHAVIOUR from mm8013 driver
- Replace special CHARGE_BEHAVIOUR_AVAILABLE property with bitmask in
  struct power_supply_desc
- Link to v1: https://lore.kernel.org/r/20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net

---
Thomas Weißschuh (4):
      power: supply: mm8013: fix "not charging" detection
      power: supply: core: ease special formatting implementations
      power: supply: core: fix charge_behaviour formatting
      power: supply: test-power: implement charge_behaviour property

 drivers/power/supply/mm8013.c             | 13 ++-----------
 drivers/power/supply/power_supply_sysfs.c | 32 +++++++++++++++++++++++++------
 drivers/power/supply/test_power.c         | 31 ++++++++++++++++++++++++++++++
 include/linux/power_supply.h              |  1 +
 4 files changed, 60 insertions(+), 17 deletions(-)
---
base-commit: 04b8076df2534f08bb4190f90a24e0f7f8930aca
change-id: 20230929-power_supply-charge_behaviour_prop-10ccfd96a666

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


