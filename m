Return-Path: <linux-kernel+bounces-122847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4887B88FE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CE8293BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546897E574;
	Thu, 28 Mar 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xT+f5pgy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C0B2E419
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626592; cv=none; b=MK+6q108/Hw2jkrckRw9L3Qr0T+vt7xGLsM1YB/UFRw4w7nnD8zGPj67PxUO4iSrXhLJY9XQ8aCTyNSVm2FAmJ8n3S7X5s/F6malyqFYr3Gj5lWm2q8dYB0Znwb+1f72TItEqKFdlheXqf8DM6FFA1qbYL5gzQ5DHTOnZ0gNkM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626592; c=relaxed/simple;
	bh=TzxfchxKF1g1YLWqQ7EsptMXtq62lqT0fTbIsNNR3Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drGlfq+lPlRICEnC+6cQkZvt9SmhmPL6IF5zu5e5q8SRWowVIk8+/ONgGhs9hsLkam30zhEekof5d1DHKwHla4ZuqA+MvbKelMX/OWoj/Uc3umQs93tisdARYRhWHlFrezhZk2EsEgonA87chWGxdoH2AH2HlxpMpCPzTfP76z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xT+f5pgy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711626589;
	bh=TzxfchxKF1g1YLWqQ7EsptMXtq62lqT0fTbIsNNR3Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xT+f5pgyVtmLKfUpZ2gqo7EFR/4xYwwxj3nQ8ImaOVyLzT7J/U40y4XEzNdESN6i9
	 2pfS8F1Xqo9J2NfqVjY6GoifUKWESKsbN8dliC7gPrPFJRXDMhUSlVq04JWgTa/UcQ
	 lFlKUTsi56GGOkbKXWuKlJZ0GQ4V0tgqegfXAmW1Grnj0p7E6rwGfaNGq6AbFOcARo
	 RSDMN/p1cSgELO0JMe1RKLBCVXkDS/5YYMAE7TUiiWRfh7anyzLQsHujAq8o32XM8g
	 oqme/YhOKr3wdLN2yYTIQjLXVMkU1dt/plYF0yQfDGru3gU5DCbPy3EQzeJ+d1CcRl
	 PwGagJKI5Wmng==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EA7E7378003D;
	Thu, 28 Mar 2024 11:49:48 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	tglx@linutronix.de
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Thu, 28 Mar 2024 12:50:15 +0100
Message-Id: <20240328115015.36646-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240328094433.20737-1-laura.nao@collabora.com>
References: <20240328094433.20737-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Hi Thomas,
> 
> I ran a manual bisection to track down the root cause for this
> regression and landed on the c749ce commit from this series:
> https://lore.kernel.org/all/20240212153625.145745053@linutronix.de/
> 
> Do you have any insight on this issue or any suggestion on how to
> effectively debug this?
> 
> Thank you!
> 
> Laura

Hi again,

I actually forgot to quote the previous message describing the issue:

> KernelCI has identified a mainline boot regression [1] on the following
> AMD Stoney Ridge Chromebooks (grunt family), between v6.8 (e8f897) and
> v6.8-1185-g855684c7d938 (855684):
> - Acer Chromebook Spin 311 R721T (codename kasumi360)
> - HP Chromebook 14 (codename careena)
> - HP Chromebook 11A G6 EE (codename barla)
> 
> The kernel doesn't boot at all and nothing is reported on the serial
> console after "Starting kernel ...". The issue is still present on the
> latest mainline revision.
> The defconfig used by KernelCI for the boot tests can be found in [2].
> 
> Sending this report in order to track the regression while a fix is
> identified.
> 
> Thanks,
> 
> Laura
> 
> [1] https://linux.kernelci.org/test/case/id/65fca98e3883a392524c4380/
> [2]
> https://storage.kernelci.org/mainline/master/v6.8-11837-g2ac2b1665d3fb/x86_64/x86_64_defconfig%2Bx86-board/gcc-10/config/kernel.config

sorry about that!

Best,

Laura

