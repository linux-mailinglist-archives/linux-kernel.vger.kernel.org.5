Return-Path: <linux-kernel+bounces-112242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F70887756
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6852F1C2167B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08604C2D0;
	Sat, 23 Mar 2024 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LV4eFyY8"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D06046A0;
	Sat, 23 Mar 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711177105; cv=none; b=AVgNw+oWW/ga9tPW0tOStXhADjQDdArIuQwgCZSOwVG5vCSM9EVxr3ikpd3ifCynFu4e1GaY0k6Zc07Xf5LJ676yL6cJGSB0Zem/3ne8MDF+DqSXKPSTjhC4ZhyLYlhmoBxJ11P1GHH90SHlWWtVqaGmzyStpQcZxREI1LfJC3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711177105; c=relaxed/simple;
	bh=Schhh1ve6wJUNgn1/lfBoSPo6hj6Yunp8gYcjsPdOuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n6Z0DsjnakPgWCn1mRsgQRvk/QGJwZQ1wt+1AY95vypCBBu6EaITWv0sZB6lOvIAC033CyXJMxa6vM6tV3jiYx2L0tTEF3mu3Dvatn5tdnS0e8DtUL4iHr0hd1Au0I3e7CJuJ9P9rf7naC/FBr1ZR6K2lv35Zd2JzTxnP1RjBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=LV4eFyY8; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id nvJZrKeyIixjunvJZrMrek; Sat, 23 Mar 2024 07:57:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1711177034;
	bh=zIEiZSYagjBeVyihcNf+XJegMipzYh1x7R7LSTamGZ4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=LV4eFyY8loUYYNskJclNqY/+asvPjt0rC093GmiXnwldLZOvTY0haDYH9XzPCvI/H
	 CSmr2WKwsIAb1uCKHOGGerrCuRwOAr1toNrFwWJz/R9fJ64ZL3337GrhvQowDBnd4k
	 10qKPLMtozpq8UkaFUseVjxrgbuRPI9FIicMFIvzmfybvFQDW55vZQ23/oJUyCpiII
	 xK3GnY9RxBj1bVsJDzVDXq3kamok5u1rLseZEaKfv66pNuOwrnwzphTmE6S6/b4EE0
	 HI8uSNZZzOgCagKPIytI8gqqd78GztySDKRpXddwVcgSSOgKUPXLqUyLgaXfBBPURc
	 G6zKpQKnP+P6w==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 23 Mar 2024 07:57:14 +0100
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: gregkh@linuxfoundation.org,
	jbrunet@baylibre.com,
	ruslan.bilovol@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] usb: gadget: u_audio:
Date: Sat, 23 Mar 2024 07:57:02 +0100
Message-ID: <cover.1711176700.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is a fix that has no practital consequences in the real
world. So I consider it more as a clean-up than as a fix.

The 2 other patches are just clean-ups to be more consistent with
string related API usages within this file.

All 3 patches are compile tested only.

Christophe JAILLET (3):
  usb: gadget: u_audio: Fix the size of a buffer in a strscpy() call
  usb: gadget: u_audio: Use the 2-argument version of strscpy()
  usb: gadget: u_audio: Use snprintf() instead of sprintf()

 drivers/usb/gadget/function/u_audio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.44.0


