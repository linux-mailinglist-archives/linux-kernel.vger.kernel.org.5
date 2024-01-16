Return-Path: <linux-kernel+bounces-28300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5447482FCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E653A1F2D407
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C3F5C8EF;
	Tue, 16 Jan 2024 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="jCCK2qF/"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ED734CEC;
	Tue, 16 Jan 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440621; cv=none; b=rYiqdVrd4SevuUU3g7JrXb0Ywc6a7KBNFGRC2rlRltiMdTZX1EhHDOA2TpQdlhA6cyGniry0UVzcWueoT4eC/b5svCqonve7bnDSp96ikTVb4vFE4YY9AQyUOdCcwJm31MFuM5udNTmkUob79LOMDS4dqBIZDt2LEVDUts39lZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440621; c=relaxed/simple;
	bh=gK8TqQrUUOxfnpjirxEvhZSb+YCDUxqynDa3eMkM00I=;
	h=DKIM-Signature:Received:From:To:Cc:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Report:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned; b=XkB5Fytg/qVHoxJsO0SEqxNgzjG4Ms2UVF5qWg19YtOtlwp3p38faZtXAABdiuJ+weZeWvIh78HUWuZO3chduXM3rWCV0WQSHl8DDRAtrFygE4Z46Egh+zIyIDNo48/I+UQ8kg+GQ1i+JnfrdzsYUrquBX7/lLeEAZe1TWTt1AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=jCCK2qF/; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=hj07P7OtASHgv5BoQvnnERYryDretN+kpG4Xqn1gXT4=; b=jCCK2qF/EVfuA+66bqZM0/2BI7
	QBquAr3a0uA2a2zJ9DkQkJUH4wqFVk1R4WRcoWV5GHSP0a/hDEJ7y3lHGaEQh1Wx/vTPtnuGkP0gS
	izTZqzHJFz44j0lKcTeTH7DJJnCRl5mqwWUjD/Uvquj5pdhWB0Vl68CD9+eyJjFMgLsQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:47418 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rPr0W-0002ia-FZ; Tue, 16 Jan 2024 16:30:05 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jan.kundrat@cesnet.cz,
	shc_work@mail.ru
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 16 Jan 2024 16:29:57 -0500
Message-Id: <20240116213001.3691629-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 0/4] serial: max310x: probe fixes
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series brings a few fixes in the probing of the max310x driver.

Patches 1 to 3 could be merged if deemed necessary and to facilitate stable
kernel backporting.

Note that I do not have access to a board with an actual max310x IC on it,
but I have tested it by using i2c-stub to simulate the four ports on a
virtual max14830 device.

Thank you.

Hugo Villeneuve (4):
  serial: max310x: set default value when reading clock ready bit
  serial: max310x: improve crystal stable clock detection
  serial: max310x: fail probe if clock crystal is unstable
  serial: max310x: prevent infinite while() loop in port startup

 drivers/tty/serial/max310x.c | 53 +++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 10 deletions(-)


base-commit: 0c84bea0cabc4e2b98a3de88eeb4ff798931f056
-- 
2.39.2


