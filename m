Return-Path: <linux-kernel+bounces-128029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0932889552C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC4B1F21077
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B03B83CBD;
	Tue,  2 Apr 2024 13:21:23 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CA60279;
	Tue,  2 Apr 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064083; cv=none; b=WiXiEgW4RXGxeLSbc6VlwyCMtGjaohDwKSEsTqkcyEE/voLE1Vg7PnU8j8JvbuP9oGBxUB5ID3aFxUGS0VpqyKt0dfNsIIFgF84EuQXsB5fWZwCjhXGkqYsweIn7NJad+a4z5OfMjGMlxf9kqCj022VTakoefgV3YNrVkHB0J5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064083; c=relaxed/simple;
	bh=OLEru2I00joCxyC5cnr0RDNaZ1PGaCne8vqCLRoUYIo=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=SrQj+lNlJg9wYrbioOrloEaWO4tEd5wZlBjI+yE3IDx6wbaquXopxH3nygUa+Sv78oX+KUZalI3FnBDJZIYHO8sP68YTaeHdLTG2OMZaF8MBoQkK2XoNoAOerrThD+m//+T/om+vh8XEztSrRSh+zrJFvOJ7hNn7cYX/VF0GwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000063F42.00000000660C0648.002529B8; Tue, 02 Apr 2024 15:21:12 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
  devicetree@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 0/3] add FnLock LED class device to ideapad laptops
Date: Tue,  2 Apr 2024 15:20:59 +0200
Message-ID: <cover.1712063200.git.soyer@irl.hu>
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

This patch series adds a new LED_FUNCTION_FNLOCK define as "fnlock" and 
adds a new FnLock LED class device into the ideapad-laptop driver.

This helps to display FnLock LED status in OSD or other places.

Best regards,
Gergo

Gergo Koteles (3):
  dt-bindings: leds: add LED_FUNCTION_FNLOCK
  platform/x86: ideapad-laptop: add fn_lock_get/set functions
  platform/x86: ideapad-laptop: add FnLock LED class device

 drivers/platform/x86/ideapad-laptop.c | 133 +++++++++++++++++++++++---
 include/dt-bindings/leds/common.h     |   1 +
 2 files changed, 123 insertions(+), 11 deletions(-)


base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
-- 
2.44.0


