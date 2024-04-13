Return-Path: <linux-kernel+bounces-143646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CFA8A3BE2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E163B21785
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F1924A0E;
	Sat, 13 Apr 2024 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTdC3RSm"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97F3D544;
	Sat, 13 Apr 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712999902; cv=none; b=m+BIaAPkLoun3NHag+/xDY/JLRQ47kzHu4asbejWSqAAMWLFYLllzaYuQY2L7SDCol8C1rSkse+BwYJxHoyKW5dAHTRD2tTCcpfz3gr2L6oimEDo+hmRlY3k+7OR++MchS3cXqEX2hlP29bkWWObmpStfQgbFHtj8GT/kRpBFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712999902; c=relaxed/simple;
	bh=RVrHx2Tn7E+TdUywb+9mNfZoGlqTXYQ4SMZtjVw2Ev0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q/rAEy+yh6JvrsuBiRiqernUtAqdxeSALZXEFulNwfLGBn5+T2KkVlKipGSUmEaW2tjf2QpWC4aQZhLLwp79yBv7T01z87E6XgLzD0ufvQaIhVDxFyHR4eVKQg3NOrAxtoti3YuENfNo1JMdHH2eOeHI9Y7is76qhCBtoaO8QTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTdC3RSm; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso17971511fa.0;
        Sat, 13 Apr 2024 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712999899; x=1713604699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JyDcydGm4xOAby3CAOG5g+X6Tv8De1Ldz9Wnnsymsuk=;
        b=BTdC3RSmxlmcI+47oVjf23jkk/3eqMrBXkv6E7C85fi/t0CsPQZ6EuPkUrNkkKOTIV
         Mj3tGppdYZhg5JT6ukb+7IfjJmikQ2ceLj+l9/juIAcV+jTTSqsRaRnGBhNafrmMlSCH
         ld6p45CzZKxhbFXadSCcQLN2RB9A/1BvjNKCCvzCqSduLO6dG9HUJSpqHDN5pedzDjCJ
         ZOTLQt2//9yH7gCbJJGMZ/a+vV8hLVaRzKw1xLpBJCnUjJlRmAghzTN+mgCGk83G+2G+
         WDt6aNRkex25SE6yESv5Xhc+pQluISx/JHTsCsHGF/sSyY86i2RGQW04g6EHIWPL1Er2
         LeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712999899; x=1713604699;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyDcydGm4xOAby3CAOG5g+X6Tv8De1Ldz9Wnnsymsuk=;
        b=e4gHiyrJy8c8qsvf7TZzyr1vZ1pBjoKIqwrWl6r1PrOpAlZPe2sxcjtxfpCHC4XVJb
         MpvMKK3pPqKn1qP+eMpYyLFHlJ2t1cVPHttHx/ymjth4/z63VtkfLehyvBu3KF45IyuN
         X0z896h6uuPbFSP8OFIXsh2FEW/RQCj31RGmE9HVnE5HXWS190Dy7cM3cLHp5JG/eIba
         ydI14hYlUJYxJE88/8OYJrp63FrKEmEgUct+vhIq598zHetQdk8ruoZfQkzpHtbODUBK
         F8uLM4jQxLTmVgh84mzTRn87ibrjl1doaI0dbVoqhy/9er3Cq8UYrH5GmPBo0iFkThNm
         yXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnpUkuVGpSv5zvKpl2sk8uXgVJwa008k8DqNdnPDnsW6jaWpG3Vt3Xzt1jCxB+yV9ccxG5yXHUA/Y/bsFY1xIi3s/ApRS03odqeQ==
X-Gm-Message-State: AOJu0YzSNh6wy6oaSNZXDoKaIEhlY0WehOI0GUJASSF3AzNnj+2DagMs
	Na86NmRx9fa6sUzsEr8w68+gQE6MH35/KPVyz6UKSht/e/pRxwqFAJeqaNpXBE5hVoX9BdBTQ2Q
	fPMxM5VVZ5ZM3XYXcvvh4EZ4Q6P0WwDjn
X-Google-Smtp-Source: AGHT+IF3D/zDZnjVYFWOYOADLurETXOoliEJrkIk5sx9wm9HLXq4sej/FhzBBQlqR/n+TEtE4WaCdmCxbrQHEGAobAI=
X-Received: by 2002:a2e:91c9:0:b0:2d8:6787:eaed with SMTP id
 u9-20020a2e91c9000000b002d86787eaedmr4156036ljg.2.1712999898786; Sat, 13 Apr
 2024 02:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sat, 13 Apr 2024 04:18:07 -0500
Message-ID: <CAH2r5msxJ8sZuc45wo9UYyaRNN1k0-=hgjOzyGxAvM+6OQUx6Q@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/v6.9-rc3-SMB3-client-fixes

for you to fetch changes up to 35f834265e0dc78b003aa0d1af65cafb89666b76:

  smb3: fix broken reconnect when password changing on the server by
allowing password rotation (2024-04-11 16:03:48 -0500)

----------------------------------------------------------------
Four cifs.ko changesets, most also for stable
- fix for oops in cifs_get_fattr of deleted files
- fix for the remote open counter going negative in some directory lease cases
- fix for mkfifo to instantiate dentry to avoid possible crash
- important fix to allow handling key rotation for mount and remount
(ie cases that are becoming more common when password that was used
for the mount will expire soon but will be replaced by new password)
----------------------------------------------------------------
Paulo Alcantara (2):
      smb: client: fix NULL ptr deref in
cifs_mark_open_handles_for_deleted_file()
      smb: client: instantiate when creating SFU files

Steve French (2):
      smb3: fix Open files on server counter going negative
      smb3: fix broken reconnect when password changing on the server
by allowing password rotation

 fs/smb/client/cached_dir.c |  4 +--
 fs/smb/client/cifsglob.h   |  1 +
 fs/smb/client/connect.c    |  8 +++++
 fs/smb/client/fs_context.c | 21 ++++++++++++
 fs/smb/client/fs_context.h |  2 ++
 fs/smb/client/inode.c      |  3 +-
 fs/smb/client/misc.c       |  1 +
 fs/smb/client/smb2ops.c    | 94
+++++++++++++++++++++++++++++++----------------------
 fs/smb/client/smb2pdu.c    | 11 +++++++
 9 files changed, 103 insertions(+), 42 deletions(-)


-- 
Thanks,

Steve

