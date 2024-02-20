Return-Path: <linux-kernel+bounces-72278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B025885B18A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25771C21A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F21E54FA0;
	Tue, 20 Feb 2024 03:40:07 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E4535B4;
	Tue, 20 Feb 2024 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400406; cv=none; b=gsfT3TA9j+npYamENbVgABZbePg9OY9z0onurzVRDUJSL11hL0dfQYQmtaD99/PAhMC5sGFSVujwJW7LNeDRLuEZ6H0h9+OGHUiNflennfJiV6O8UUC8eVmfbJitoUO2arqXOMdHqksuXGFub05QOsyYSweWzOhVeCjm/iOVas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400406; c=relaxed/simple;
	bh=DhsKxd0UYvlAjNOP3Fxs14d3du1xy4aJ2UZPCODhw7o=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=hgO1IhyewVaykA4JYS6Z+EHSXBoKQTvbtGpc/1uwR3FRkbBHqAQfhTrG0utsUK4E0Xf1XOPWgXk5r4vr8LRb54BO86aISv2WrkMuqHWfXRxBnInaYBNBjR9djXKSas6/Foql3zoaaDGPwCGU68qyRhNwXKhrs9PDCHdoL3kREwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68dc5.dsl.pool.telekom.hu [::ffff:81.182.141.197])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000735C0.0000000065D41F12.001D1CAC; Tue, 20 Feb 2024 04:40:01 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Dmitry Torokhov <dmitry.torokhov@gmail.com>,
  Philipp Jungkamp <p.jungkamp@gmx.net>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 0/2] map Fn + R key on newer Yogas and Legions
Date: Tue, 20 Feb 2024 04:39:34 +0100
Message-ID: <cover.1708399689.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.2
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

This patch series adds a new KEY_FN_R input event code and map the
Fn + R key to it in the ideapad-laptop driver.

It affects two WMI keycodes and I couldn't try the 0x0a, but I couldn't 
find any indication that the refresh rate toggle should not be Fn + R.

Regards,
Gergo

Gergo Koteles (2):
  Input: allocate keycode for Fn + R
  platform/x86: ideapad-laptop: map Fn + R key to KEY_FN_R

 drivers/platform/x86/ideapad-laptop.c  | 4 ++--
 include/uapi/linux/input-event-codes.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)


base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
prerequisite-patch-id: 66a1ec71f181c6468a8226430af7ee917f40138a
-- 
2.43.2


