Return-Path: <linux-kernel+bounces-27906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB4282F79C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B112883C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D68E85082;
	Tue, 16 Jan 2024 19:48:54 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B10F85064;
	Tue, 16 Jan 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434534; cv=none; b=UGwxg/sNt7M1gIsfJg3gVGhxYRSewtR3nF2kGFgBZ5M2rZMExFXbuDV0VV2hAaNu2ztyP0kL01JiH7WBrQwM1186hZTPclp96GrGCMAN28dMOE0UgUqlVcQxSf5ibnefj/Ry28mYUFAfKa9wM24O0adYvNqDhaVW399EbF9jiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434534; c=relaxed/simple;
	bh=CA0vCO9ybW7xD4CR7TmCTvb11f52UpkjdSFMQOz4Ss8=;
	h=Received:From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key; b=FEZwhBMoskLgsq1Xxrh1ondEmytrj76Nlj8oskECTmxOCM1a1uvSGKr+h0RR0M6cW/miyQ+DDyHez+fYuanYVYeJpeC4BGaecQ8pyD3GAXbxT2lMc4wwo8Ya/QF5GOZk8M06iHL/54aTlKcgpILGr9XUyJNvviHoGygpv8DeI+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 331878C39D;
	Tue, 16 Jan 2024 20:48:48 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH v2 0/2] input/navpoint: remove driver
Date: Tue, 16 Jan 2024 20:48:05 +0100
Message-Id: <20240116-navpoint-removal-v2-0-e566806f1009@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHXdpmUC/22NywrCMBBFf6XM2kiemrryP6SLoFMzWJOSlKCU/
 LuxuHR5DtxzV8iYCDOcuhUSFsoUQwO56+DqXbgjo1tjkFxqLviBBVfmSGFhCZ+xuIkpK6UZtT0
 q5aDN5oQjvbbkZWjsKS8xvbeHIr72FxN/YkUwzkyvHOreaGfVOT/ihHufYKi1fgDlow+mrwAAA
 A==
To: Russell King <linux@armlinux.org.uk>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=CA0vCO9ybW7xD4CR7TmCTvb11f52UpkjdSFMQOz4Ss8=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlpt1/40WRVFcqgQnJ8S1c4Ueir+poE9fk8biHN
 71ndZEWjNeJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZabdfwAKCRCaEZ6wQi2W
 4U/EEACOzoDCEfIOuSr9ni1GXvcXyHunQpqD/1hZNEn3DuoRi/JF20A8ZGPVNWIdQT/H5MswUyA
 ivxZYtnmgbSLuioTVlHbumwq2lh3NoJIEBr7Ztrq34HfOHXnWwVv8nKqW3RyXzEVRCft5G/+ELV
 /SKa3mgfY2kkYS/LfRgb05yQOMSvSTAQgKIYjIwVBJ8oSScIeWhDRRbAGv5Z19NZULFJTzFNzxT
 lQ3ClvtkYErQ9IKqpNLpqjlMQN9ykKbbe+buFZhz3JXgQgTQsOsLKNjcyY6CbAM/CUnrVHzboj3
 2eLhHmhQ5Rn4ly1VjIHSxyvFYrrdG7+fBFYV18Fr/iayUFHT/289VIF2+z/szlE26OT4y2qsBC1
 6YwpaTFL0awSGj63xkN66UgBt+Xsas9mdeUxzbnsnZFRxktxDf96BOCKkHaFWADrqvX3mdgZ6U6
 f9a05ImTD2Yaxhj0V1LPBZb8gNVm8s6Fr+SKvZcoJRB2BPOiWBwTZ7o60MsbhIIxEw5+iNY7fOR
 8YIziSJeFXd9SorxZxEyZ2pB90RsVkr+nFDHyn1e9WG16mDn5fKiO/Q4jYNckfPu4Rx1Kyezm65
 RPl7qUqnKBMO643K81WfnvWfK5r/DhUszbuJLPd+quL10sylOcs3ABLRYqQ0HnF8kyTlIK3CGkw
 u6ZUtqWQNhdQLuA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1

Hello,

Small series to drop the navpoint driver. The rationale is explained in
the commit message of patch 2/2.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v2:
- Rebase to input tree (also edit commit message to reflect GPIO cleanup
  done there)
- Mention hardware's apparent exclusiveness to hx4700 in commit message
- Link to v1: https://lore.kernel.org/r/20240116-navpoint-removal-v1-0-593ae4954a83@skole.hr

---
Duje Mihanović (2):
      ARM: pxa: drop MOUSE_NAVPOINT_PXA27x from defconfig
      input/navpoint: remove driver

 arch/arm/configs/pxa_defconfig |   1 -
 drivers/input/mouse/Kconfig    |  12 --
 drivers/input/mouse/Makefile   |   1 -
 drivers/input/mouse/navpoint.c | 350 -----------------------------------------
 include/linux/input/navpoint.h |   8 -
 5 files changed, 372 deletions(-)
---
base-commit: 52c4e5985a730796a3fa555b83b404708b960f9d
change-id: 20240106-navpoint-removal-38225f48733a

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



