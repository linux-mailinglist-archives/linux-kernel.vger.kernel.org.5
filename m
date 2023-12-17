Return-Path: <linux-kernel+bounces-2561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85A815ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32B02830FD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA25328DB;
	Sun, 17 Dec 2023 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XD9RIWZt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029972AE74;
	Sun, 17 Dec 2023 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9BD7240E00A9;
	Sun, 17 Dec 2023 11:59:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gdhyoHV_EUEW; Sun, 17 Dec 2023 11:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1702814388; bh=CU71ife/iGYv40WFcoEmKSjXttoht0SWNlAq2riKP/w=;
	h=Date:From:To:Cc:Subject:From;
	b=XD9RIWZts7RRl/Um6y0nvJ7SPbkUCnhlhmeZp33US67Pk52XVsnYXSs03pd32GSn8
	 QZ6ACfeQnoEsxDuLPuXC30JF2V6y81Pck9xzsqmhSIHePnQneKIhIZdu0j1urg2/Uh
	 ThB/QkI7yIk2s0BLhLgW1YZB8Y28zYjTfByPiiNhzcOrX+rYoWhvHXB1mao/vsmMr8
	 W9w3fWeE7g96+TDdzWBddgT0IPZGh+7jWmQGq7s/P0fHQTTr1Kba5xoTKHvKp3gxkY
	 Y+mHXp6J64+1/Hda//ZIejY+1qjLggDaICZrsLoDV4igQwwWnNsfzaOKczB0QFvhf7
	 OJfgD5O9v7w9PfZvxLR89BOCesYGhnFZ9fL3HShNCNuwFENYf/iLC+vNxgF85zULSe
	 XtjKW/5oRsIXXffOBvvC7gih2RfaH7cCKaRU1Uc32CN8Ytkyr8l9pWwysh3i3e3tMV
	 aczI/UNVhOYlGUmZBlT0xrD2QNCImfv5vXBox5i+tAp4tAj4q5fhVyY80/X3bNoE/R
	 sX9GQ254pV0VvNQnH4seaLLUadYlL2/O7u1KsijE/xeIONIYLQhKnmWCOALLX4wpkI
	 3e4N8JIb/YR56rSsgXHDVbpOUxluFidt6tuPVnFy929t1a1nSYIp63MPJ6W+DsWwn+
	 mHwK+wRishRhvqu1cX5+JQj4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 65ED140E00CD;
	Sun, 17 Dec 2023 11:59:45 +0000 (UTC)
Date: Sun, 17 Dec 2023 12:59:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC/urgent for v6.7-rc6
Message-ID: <20231217115937.GAZX7iqX6fhyiF1mMZ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an urgent EDAC fix for v6.7-rc6.

Thx.

---

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.7_rc6

for you to fetch changes up to 9483aa44912f26da2b69dade6099c2bf4b50a8c3:

  EDAC/versal: Read num_csrows and num_chans using the correct bitfield macro (2023-12-15 13:01:27 +0100)

----------------------------------------------------------------
- A single fix for the EDAC Versal driver to read out register fields
  properly

----------------------------------------------------------------
Shubhrajyoti Datta (1):
      EDAC/versal: Read num_csrows and num_chans using the correct bitfield macro

 drivers/edac/versal_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

