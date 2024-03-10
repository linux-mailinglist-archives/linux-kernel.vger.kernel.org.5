Return-Path: <linux-kernel+bounces-98192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A91787764F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD061C20AEC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA672030A;
	Sun, 10 Mar 2024 11:32:05 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BCA1EB25;
	Sun, 10 Mar 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710070324; cv=none; b=Hd4DsXykttpgv0YW75C2sRwx+LXs79KB1tKN9Yz915e+soLQvK6NdXWERpJ0hX5OudRCb8X5/fgU+UA2oymYTe3Xm8QrM5eeSuKXFIxTPDRUrAdC59ToBLa4pCeNpZwn5qJmT7AXV9c9bc/foaH6okIK9n8NchilC8fkKWwCCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710070324; c=relaxed/simple;
	bh=YchC4Jus50krrCPc6Kl0ip+CMbfwroi2I2+N25DVqa8=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=BwT06wRI9+APuduSgqn5IDbLoXYUnMKHsb01n99NcTNM8cMNXGNVGcbCkxf/lVNDKHk1EE5qeGpIkI80tKds8gXFRbNYoJhSLva5YSrQ9VlE1kwqerxeSd79gXx26hjtGHffPBkTwQCdUW8np2cj4/f7c0djIoC/U4gyDrq89NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b693e7.dsl.pool.telekom.hu [::ffff:81.182.147.231])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000769FF.0000000065ED9A2A.0020EFC5; Sun, 10 Mar 2024 12:31:54 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 0/2] map Fn + R key on newer Lenovo Yogas and Legions
Date: Sun, 10 Mar 2024 12:31:40 +0100
Message-ID: <cover.1710065750.git.soyer@irl.hu>
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

This patch series adds a new KEY_REFRESH_RATE_TOGGLE input event code 
and maps the Fn + R key to it in the ideapad-laptop driver.

It affects two WMI keycodes. I couldn't try the 0x0a.

Regards,
Gergo

Changes in v2:
 - use KEY_REFRESH_RATE_TOGGLE instead of KEY_FN_R

[1]: https://lore.kernel.org/all/cover.1708399689.git.soyer@irl.hu/

Gergo Koteles (2):
  Input: allocate keycode for Display refresh rate toggle
  platform/x86: ideapad-laptop: map Fn + R key to
    KEY_REFRESH_RATE_TOGGLE

 drivers/platform/x86/ideapad-laptop.c  | 4 ++--
 include/uapi/linux/input-event-codes.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)


base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
prerequisite-patch-id: 66a1ec71f181c6468a8226430af7ee917f40138a
-- 
2.44.0


