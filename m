Return-Path: <linux-kernel+bounces-131743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960C1898B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C502B1C21095
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F0512A174;
	Thu,  4 Apr 2024 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OSyq/Srk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5lA2dLfP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6F86ADB;
	Thu,  4 Apr 2024 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245436; cv=none; b=V0A0uENWL/L31yLhaJN7JqeJdBCZN2sXGQR/9VJc5LH0ctrA9ANxFgjPwfsAB4JS96Sg4xr3f7nLmG3vhWiCXxbFNxp+jlaSL6C8TdVaDmGBcI4Vh/sClmVtQhukzWeKg7MzE60J0dzh5UmuCcicFqtVL1H5D3sNqU3UjSeJS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245436; c=relaxed/simple;
	bh=Ts3qGSlroqc0rCsJJ0xFCnRTgL2rVaTIMzZY2xTp8kI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KImuyEL77iiUP/O1w6akN005OknxmCcMvoMSHtCxj+CUVeMl+kq8yhVACPI2GLdjMgaY28bmbdPaMqyd7efepwBsxR6RQSOfg3Xu1NX+ICT2sMTUGpLhoXS8Volwrv2WT3zKkS5bV+97IEmH32zImQ70rnMoLjwSZ/cdCpuU5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OSyq/Srk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5lA2dLfP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 4 Apr 2024 17:43:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712245433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=foU1M3It3GalBGF0iZ+MjM8nUxBRueNGz8SQVeFfg4w=;
	b=OSyq/Srka1J+2O+DtvaOBM9byofUx29yY13ZssobA4RTB59AoEKjHJ2HX6dmmA1hOwJG/u
	j/Xgc47UWBmvZvAyND7pA+3ZEm0/T+Xomv5j7jg/qXHjymcGDPaOXduDoWHXEBjfpSsSxY
	pY4LD2m/a/fs1Y1ng+ERwc2LaLmVzHw0yvmKMBw9t9t5KdKmdvP6wrZ3LAVLgw/NZeFeeL
	jd9AFCGt9GQOiO7kV/bsmyGQ/xRE7c4o/MAFt0YWoAjLnj/0+tawOzy0WfMaeCtFeEwHUc
	70URlFSlvhwE53yHaMRLn2RDVpOXRKvkEihGHstcD+NfZQ6lR9Hz+qv2jhrDKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712245433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=foU1M3It3GalBGF0iZ+MjM8nUxBRueNGz8SQVeFfg4w=;
	b=5lA2dLfPQJoD7e9mCAgbFPdwfQJDdyHoefPZy9xlvqVqawv75CGjf3Aa8MiU24LEXi8T9v
	GFZzrVD5MAZsQ2Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.9-rc2-rt1
Message-ID: <20240404154351.0uUUy1fB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.9-rc2-rt1 patch set. 

Changes since v6.8.2-rt11:

  - Update to v6.9-rc2.

Known issues
    None.

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.9-rc2-rt1

The RT patch against v6.9-rc2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.9/older/patch-6.9-rc2-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.9/older/patches-6.9-rc2-rt1.tar.xz

Sebastian

