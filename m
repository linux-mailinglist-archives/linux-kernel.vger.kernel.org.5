Return-Path: <linux-kernel+bounces-98971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF28781BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6101F21FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA2440BE1;
	Mon, 11 Mar 2024 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uZFVB6LN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7107140850;
	Mon, 11 Mar 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167820; cv=none; b=AGyxdHyoMDZ+Cs9NfSIL/Z9SYxjQ7Fdrw1EPpejOpGLhnK1bIawoq/dlSs64xtzJ7X3OqzBUl9rZA5FshU9dI2YddhFRBlmEnfgR97kUiiG5I/sowXA4zqX/fLBWHX35U4dtn0a5Db0uLMqfjcq/NJIjZeVEOJw2H3iJGCV0Nts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167820; c=relaxed/simple;
	bh=NFXgzJ4YuGprBA9q+Ng9neXNqQYOjSNfOZEoYCQyD90=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YauHq9znbJb2tmbGJe9xNk38TvYS++xc7nZRuYKUc3ZV0EtS8eD39JTklfD3ICr+NSuz8KiwOyAiu39lR77/1btCANcfA2L9dVefDCYny8tF7afYt4uvchwfxd7BTVP1H4gb1P3tkiGagY/5YNboHUj31CwUCIT8ti3lAnV84GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uZFVB6LN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710167816;
	bh=NFXgzJ4YuGprBA9q+Ng9neXNqQYOjSNfOZEoYCQyD90=;
	h=From:Subject:Date:To:Cc:From;
	b=uZFVB6LNYCf23aphtIoK/AhSqbKOiA1JbRU613SBw1HVKf8x2QAUx/CB0TJ/vxWmj
	 VBAja6ELPwXH2neoSWfPWA1fsvC+FGGO35RjuS42Bzh97KVcmG3+EyGdgi/vf2lkAU
	 dWIpTN8IyhM7XR3c3EmwTRFZW0SIfPUbLSFX+H89b4MVmX3eQJv5KzdkDkevl03llA
	 of+O6mFHLSPOUByw80y4UCp/BtPNdBNUXNcbnTtMwTewWA5efk9ZgY8ek4PWElvGDk
	 m3awNwVtMc5brEljRQHFfJJ7ahex0uQX8BrkH8WmWC4TwjTnoOyGLEF/lubfRtVFnv
	 Oj7GsFCJ1GfvQ==
Received: from [192.168.1.36] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B374B37813B6;
	Mon, 11 Mar 2024 14:36:54 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 0/2] docs: *-regressions.rst: Tweaks to the commands
Date: Mon, 11 Mar 2024 10:36:14 -0400
Message-Id: <20240311-regzbot-fixes-v2-0-98c1b6ec0678@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN4W72UC/3WMQQ6CMBBFr0JmbU1bKhBX3sOwaMsUJkHGtISop
 He3snf5/s97OySMhAmu1Q4RN0rESwF9qsBPdhlR0FAYtNRG1rITEceP41UEemESpra6C4NxjVZ
 QnGfE4yjKvS88UVo5vo/8pn7rv9KmhBSXtrUmoGpQ6ZvnebaOoz17fkCfc/4CRCGbC64AAAA=
To: Thorsten Leemhuis <linux@leemhuis.info>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: kernel@collabora.com, regressions@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 workflows@vger.kernel.org, Chris Bainbridge <chris.bainbridge@gmail.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

A couple tweaks to the commands in the regression documentation to make
them up-to-date and less confusing.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Reworded patch 1:
  - s/collon/colon/
  - Made title and message more straightforward
- Link to v1: https://lore.kernel.org/r/20240308-regzbot-fixes-v1-0-577a4fe16e12@collabora.com

---
Nícolas F. R. A. Prado (2):
      docs: *-regressions.rst: Add colon to regzbot commands
      docs: handling-regressions.rst: Update regzbot command fixed-by to fix

 Documentation/admin-guide/reporting-regressions.rst |  2 +-
 Documentation/process/handling-regressions.rst      | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
change-id: 20240308-regzbot-fixes-43a28fd4b621

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


