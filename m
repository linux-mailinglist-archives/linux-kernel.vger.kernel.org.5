Return-Path: <linux-kernel+bounces-162067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C44908B5578
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BEA1C21F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8222444C87;
	Mon, 29 Apr 2024 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SldjUTq9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C350C446AF;
	Mon, 29 Apr 2024 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386958; cv=none; b=Uyy5caUNEpdud2i28Ok9cQVTuql6NdEzJsQaER1wtV9ku/jfGbRbbnZc/6NT+PMzxuATs8eoVEZXOz4XSZIG3h4g36UAyux8Que1SQUTxIw5tOthyZ5uxcb6frE6FJ+4LeKRtdO1J5Eh8n4ojbXoUNDDaJSpIoUYkIDmuG0jZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386958; c=relaxed/simple;
	bh=8L5ew9A7WdOChCw8/SB9gDA9/eCczR5FVrYTu73V6Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B96m62Gjc7gayi3IIo1QvDLeOJVm7rcbypuiAP7Nrh2D6MLOxOrMs2e9Rf+lMK29X+IGoBPrDTkLazWWab5X8yem11NWCac9QL70bY1lkJxHzZY/NqhJAeyc4e6Flx4/WqkUCBSNc1hib1ZPkXcSCsWK3SCE0x6movspTGoN5sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SldjUTq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC12C4AF1A;
	Mon, 29 Apr 2024 10:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714386958;
	bh=8L5ew9A7WdOChCw8/SB9gDA9/eCczR5FVrYTu73V6Hg=;
	h=From:To:Cc:Subject:Date:From;
	b=SldjUTq9X2Iy4FQI7gYxJAXR7qAFxjlWl2SMtO7G1Lee8bsY1ID6LrGFuHeIyLBoa
	 xqltKQ0dEikzSUZXAoN/rq0tpPOTv7RahM25Jer8HDvfuU5Fw7JuYRLkl26hJ/Pr2N
	 ZGFvMaI9pQ9UCRwaukmq6IeP9GJOSqHVzWl+um74=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.89
Date: Mon, 29 Apr 2024 12:35:49 +0200
Message-ID: <2024042914-steadfast-skirmish-6b76@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.89 kernel.

Only users of the 6.1 kernel series that had build problems with 6.1.88 need to upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                           |    2 -
 arch/arm/mach-omap2/pdata-quirks.c |   10 -----
 sound/soc/ti/omap3pandora.c        |   63 +++++++++++++++++++++++--------------
 3 files changed, 41 insertions(+), 34 deletions(-)

Greg Kroah-Hartman (2):
      Revert "ASoC: ti: Convert Pandora ASoC to GPIO descriptors"
      Linux 6.1.89


