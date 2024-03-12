Return-Path: <linux-kernel+bounces-100407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5855E87970F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FB9281F61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B347BB17;
	Tue, 12 Mar 2024 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hqKXaUDd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uDTsGDlo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F036FB9;
	Tue, 12 Mar 2024 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255815; cv=none; b=WOpoLlNGLAbK8AST3vMZSltfSUsCfmSbvubUq4Z7zQGeHkVlavX/8t8F0VYNGtMZqYJkRuzso0rrh6HMPQ6ni/xrzbhZFjxdgkDhzLH7FZe1JMXdmkDs/1iDPOJ9SWpSo7BS6epg7RAs5oXQS8jvi496IE1TAoYpH7/n/JAiHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255815; c=relaxed/simple;
	bh=l28tzEVgnT4VsaWLszZv7KmGhFGdZxh8WOnKuOepbyk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rw1LrWmyoOcfNKsjz6vJtA5N7Q3seCog+gqR/fPojmT2mAU3Qva7tQdUbmXQpxhgJbqsBq9Gh5oOd0ExLh48qcV20HAn5DakEYwGcC8wEuREutpuJUbaJUPOH2SKRMyzcW41HrM9zyw7VHt0G6dCHgmqWWaZwVSfD88S+U9dVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hqKXaUDd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uDTsGDlo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710255812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IbbOw9jYs8O5M2jfMxNSxGjwmt5B6DUroggxnSMKNjo=;
	b=hqKXaUDdEpj+Dzw7KWRNo0Zse4pFdPauGUc9ag8K+CLJljlO31APVSR275XVQD4t6cy3Xt
	BAJc+Rhfx6/Hv+CWC64FdGf4CLHvu8AVRCUQRnOikp22tDgqH1DGiQqLNFWoPpBWPwBpKh
	GkDNBZYf5I+2/wRW3DUPO8Fwv/mH58T7majE+9pe2UceJpDy0Z57tAtN+mersWOXR2WlyO
	RRGQZ0Etj96XUkA5S5tCMqGtdbZkm5LaKvIS/dHLG4X+9VGCXdyUdVJtGefnDcjbx0lk/X
	0NX8iJCWR5pHZJDX7KoZgr70xGKlEsnoyqxRRpI6yQRBqxm3+XIAqcC0/t8mAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710255812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IbbOw9jYs8O5M2jfMxNSxGjwmt5B6DUroggxnSMKNjo=;
	b=uDTsGDlocUKWbSUve/DZkyQyNWhDW3B09LGLh+Zl6TfA8mV1Qw4Snm20xIqyPHrJibpx7L
	+BExrDNnd1VnWyAQ==
Subject: [PATCH 0/2] gcc-plugins: disable plugins when gmp.h is unavailable
Date: Tue, 12 Mar 2024 16:03:28 +0100
Message-Id: <20240312-gcc-plugins-gmp-v1-0-c5e082437b9e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMBu8GUC/x3MQQqAIBBA0avErBtQK4iuEi3MRhsoE6UIxLsnL
 d/i/wyJIlOCqckQ6eHEl6+QbQNm194R8lYNSqhedFKhMwbDcTv2Cd0ZkKxepR43MRgBtQqRLL/
 /cV5K+QCFnwwwYQAAAA==
To: Kees Cook <keescook@chromium.org>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710255811; l=538;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=l28tzEVgnT4VsaWLszZv7KmGhFGdZxh8WOnKuOepbyk=;
 b=LBmgAr+d3bu17kP5EMwAvL9hthUMlEZnlB+sWUJaWyo/iTLwc48J3Y8mzgeZShEQx/4Q8Y1eL
 p9ftBr67fM8Crt7xfVp8ryAWkY6cPb9a6mJabFlnIFhmMW9Zt0k23y/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Without gmp.h the plugin build fails.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      kbuild: add host-cc-option helper
      gcc-plugins: disable plugins when gmp.h is unavailable

 scripts/Kconfig.include     | 4 ++++
 scripts/gcc-plugins/Kconfig | 1 +
 2 files changed, 5 insertions(+)
---
base-commit: 855684c7d938c2442f07eabc154e7532b4c1fbf9
change-id: 20240312-gcc-plugins-gmp-efab1a8d05c0

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


