Return-Path: <linux-kernel+bounces-132358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 316D089938B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2521F23983
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057891BDDB;
	Fri,  5 Apr 2024 03:05:59 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7795B125C9;
	Fri,  5 Apr 2024 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286358; cv=none; b=ZzIEsUUtiaKOu/YE6dtF90nogvIzcxFse8bHpkFAYeSbpa+HXSMjaDBzMWbLpVZ2AanHWa3s7up2FukgYEqX+QMg381/waolzm95TmY4FRAS4e88fVbNDyzl0TVTNMOEYZ+jkDzsAtDvG5VWrAsGzEQrpenvzHGuH20J81vBAD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286358; c=relaxed/simple;
	bh=8RuxM6J8Cm2RSk+vd4fvxUTuSbBohuHlixB97Gvdd+s=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=ZNDskeumvSsftz0kLrkwHGUVYm1zXzdeVyJweikyFj8qkK2TAnm38SroFBx4/hV35hDGHO2Imc/s9qFpbJ/OiwK9yPxbuLEZl1sO40gUvpLwaVW2EaoXW8ykhawWbQFJ2INBQQLJv2bZgIS4OTCM5FEH7SlZPE51vEO4ixGberY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F204.00000000660F6A92.0025A893; Fri, 05 Apr 2024 05:05:54 +0200
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v4 0/3] switch platform profiles with Lenovo laptops
Date: Fri,  5 Apr 2024 05:05:27 +0200
Message-ID: <cover.1712282976.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Hi All,

This patch series adds a platform_profile_cycle function to the platform 
profile module, which allows modules to easily switch between the 
enabled profiles.

Use it in ideapad-laptop and thinkpad-acpi modules.

Best regards,
Gergo

Changes in v4:
 - move the cycle to the platform profile module where it can switch 
 between the enabled profiles
 - add a patch to use it in the thinkpad-acpi module

Changes in v3:
 - add dytc_profile_cycle function

Changes in v2:
 - only switch platform profiles if supported, otherwise keep the 
   behavior.

[3]: https://lore.kernel.org/all/7c358ad8dd6de7889fa887954145a181501ac362.1712236099.git.soyer@irl.hu/
[2]: https://lore.kernel.org/all/797884d8cab030d3a2b656dba67f3c423cc58be7.1712174794.git.soyer@irl.hu/
[1]: https://lore.kernel.org/all/85254ce8e87570c05e7f04d6507701bef954ed75.1712149429.git.soyer@irl.hu/
---
Gergo Koteles (3):
  ACPI: platform-profile: add platform_profile_cycle()
  platform/x86: ideapad-laptop: switch platform profiles using thermal
    management key
  platform/x86: thinkpad_acpi: use platform_profile_cycle()

 drivers/acpi/platform_profile.c       | 42 +++++++++++++++++++++++++++
 drivers/platform/x86/ideapad-laptop.c |  7 +++--
 drivers/platform/x86/thinkpad_acpi.c  | 19 ++----------
 include/linux/platform_profile.h      |  1 +
 4 files changed, 50 insertions(+), 19 deletions(-)


base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
-- 
2.44.0


