Return-Path: <linux-kernel+bounces-80250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D62862C85
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 19:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EDD1C20B6B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5E0171BB;
	Sun, 25 Feb 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HMNhhX4W"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C78F5B;
	Sun, 25 Feb 2024 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708887064; cv=none; b=DW4iyaui9iGI1DSulJI8NlexQRgFlzQfQR70cChUNzcDVJsLuKodlHB7SYdDwoX7jTQcMQ0juFYy8FU8Avr3hRWEyXYi/AYYKQew9oqxC9QZLwY4Sfl3feWKXwqYqYwaq33k3nWfWHgbroXvh2VjXHAZB74keRmJ+tr2gk4tQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708887064; c=relaxed/simple;
	bh=UgRdhmfh10gDKv2Y5kuVJ6W6bY2dnFiuiGLeicbl2Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T+u5NWmj98i4XWrJ2xhGXdtkIQKGH8XkaE+K8REUu7eqclV+D+WKrSBIfSX7W/OmOAc8YGE1BpV3Dbm5NWxXnlSNHShkzFwA7xOAutaw5M9vkGYK8DYryLh3APX/PyyboCwqZK22b2pmlW3UvayhWq/HYyoF7Oau45aDdbPtoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HMNhhX4W; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E069147A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708887054; bh=WH6GM9goJEt1bM9bjbu7aMgm20/St90ib3S/MlnO49Y=;
	h=From:To:Cc:Subject:Date:From;
	b=HMNhhX4WwKMZBM65aY6Yejps5M2tZk+3GYw3IFiFZlwAhjhIbZOK9qaYLeyuGxsnt
	 tvyHldUviV/7EQssVLhsUiRke4fHLyNjW1uabphhGyflG2zyyRVVOxE4SPA+tcIiiO
	 2eop0m/gvfTI70W135Y+4F8yxJLnaq0PQC1BioCWgC77ndJrwaULhWzt5PRwl2jJDV
	 NwI/QhxKspp8bhP66Yn4rhpIr6Y9m2P4m4loK0GHrR9g1G3etwqEtxAV32m0aR2PdI
	 QFtZ662UMKHdFhIzTKlmljjsOjajw5FSTkih5EB+C59+7sOtPqcAL6paRDT3VKhsfF
	 Yxhn9P5vmiNAA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E069147A99;
	Sun, 25 Feb 2024 18:50:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Two more documentation fixes for 6.8
Date: Sun, 25 Feb 2024 11:50:53 -0700
Message-ID: <87y1b85qeq.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit c23de7ceae59e4ca5894c3ecf4f785c50c0fa428:

  docs: kernel_feat.py: fix build error for missing files (2024-02-08 11:05:35 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.8-fixes3

for you to fetch changes up to b7b2ffc3ca59b06397550f96febe95f3f153eb1e:

  docs: translations: use attribute to store current language (2024-02-21 13:41:37 -0700)

----------------------------------------------------------------
Two documentation build fixes:

- The XFS online fsck documentation uses incredibly deeply nested
  subsection and list nesting; that broke the PDF docs build.  Tweak a
  parameter to tell LaTeX to allow the deeper nesting.

- Fix a 6.8 PDF-build regression

----------------------------------------------------------------
Jonathan Corbet (1):
      docs: Instruct LaTeX to cope with deeper nesting

Vegard Nossum (1):
      docs: translations: use attribute to store current language

 Documentation/conf.py                |  6 ++++++
 Documentation/sphinx/translations.py | 10 ++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

