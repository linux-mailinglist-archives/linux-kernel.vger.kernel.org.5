Return-Path: <linux-kernel+bounces-2799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E20B81620A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950CCB21C10
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04482481B8;
	Sun, 17 Dec 2023 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eZ5yQoHd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58A481AB
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A451640E00CD;
	Sun, 17 Dec 2023 20:26:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IArvJkURkpd0; Sun, 17 Dec 2023 20:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1702844782; bh=BCgmZJnP8x9qFDbLAR/+5iruMPbwmtoW0exOXUqUKIM=;
	h=Date:From:To:Cc:Subject:From;
	b=eZ5yQoHdY6b7Vcg1tUUrabcanxqtJNRPq8jGxrOik1hiGXtZI0An6XWn9qDnRqtvD
	 gtTzMa6yHdhvJdUJwXzCdiO6AqKWUqUJa87z0xrJAd2O9Lr5fz52fLBK1uXompyos4
	 e358fVRPEZ/mrN/8ybHvS10C4aF72xxS1umLfsqPYoJWFPSiSAnkuxCV8ACOpHwmFv
	 QjqxDdhV+CMTh5vmjwDkkJNdqQD3+cMe27VqLlcHHTmS6M4YkAVUmIv6AhjFK+JvV0
	 3+XFbBGlQy0LePeQ9fymNYon+oXuThm0dlrpWMRvkgnEDo9TcasZC6n3YxG3eRVWSd
	 RJJyGcvG3GwtHcw9NA2mHOtXpF3AyWkUVi7mK2eASLuJtQzfEGs8lSY9UV/GqCEvxx
	 DJlLjK+rs7QXYCZqxMEEbTT9FDJMrpnimHUrw8jS+wV4KoP0UnJON34ikUtUA8M4E3
	 2MsIVgxzjBnBgikh6ldhcAIcLPx8QcCB76XZKTrQNK7QnJu8+bVwBMAi3sQHDBQazK
	 Z1FbGhvPSMdjmvB2qSaZKx8OjUFm0y9RO9n6IyVszc1K3cRUXNnv6HCt0nx+SR5wSZ
	 u7P4nUMNtv+7+bVk/nevMtabAKOo54lX/yYr/yOyzPExgP0opPsVWIH+5sT0nDpLGO
	 eWPxEl25iv+lbwvs+JIWfVZY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 771EC40E00C9;
	Sun, 17 Dec 2023 20:26:19 +0000 (UTC)
Date: Sun, 17 Dec 2023 21:26:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v6.7-rc6
Message-ID: <20231217202613.GAZX9ZZWMM/ytA74VC@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a last minute urgent perf fix for v6.7-rc6.

Thx.

---

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.7_rc6

for you to fetch changes up to 7e2c1e4b34f07d9aa8937fab88359d4a0fce468e:

  perf: Fix perf_event_validate_size() lockdep splat (2023-12-15 12:33:23 +0100)

----------------------------------------------------------------
- Avoid iterating over newly created group leader event's siblings
  because there are none, and thus prevent a lockdep splat

----------------------------------------------------------------
Mark Rutland (1):
      perf: Fix perf_event_validate_size() lockdep splat

 kernel/events/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

