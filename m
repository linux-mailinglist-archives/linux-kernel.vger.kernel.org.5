Return-Path: <linux-kernel+bounces-154504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB528ADCDA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14B61C21B71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499291CFB5;
	Tue, 23 Apr 2024 04:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je9KbRFn"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1B91CF89;
	Tue, 23 Apr 2024 04:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713846468; cv=none; b=htXnrSp9GcLVV+Tu4dRMaJC+vPBU+mMLXifgZavdygDN9kOIg25W6zMmQKimM37k/sPK8Do4JjYvfFVD+w/dvKsaCl3Zlha4Kl2VzD4BdMDG/jXvO14sXUejS290eXDbUgSfMLA1xQch0c8jXFpYiWMWQPmtHFyAuyp7iJmMccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713846468; c=relaxed/simple;
	bh=lcreMtz3aTiGRTjjchfBYwvQDEdmCbX67ssnUDNQPtM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hU34kXEiOzS2LwyIhOmaoWSSj7YoY2dCCr/IY1tDV0gnEHSbxN1q7OiFaOK4PDg1wjmq2yfmH4yHHfBXhxLMxY2qI510biE0uDtLf/wMx171ClNp2t0D5zDbuFt3Q5Uho3jVOBnDDG/sxbtWcjWgbXTsEJmSugKZVZEeMd5mD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je9KbRFn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2de2339024dso904951fa.0;
        Mon, 22 Apr 2024 21:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713846465; x=1714451265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vXD4HYm9bDjUoBX4uPUgJNHban+xQV9+4zOLQOyU2cY=;
        b=Je9KbRFn5AccRca+ezes6ezXIGXEgXr2gN1I+ZB35Q00/umCFKbpoNYEUAZzTB1ws1
         Jt8F083oYPSIaWH319DWaroMvJ17OYtNqg46gTtSHovcs/9U4iB4uqKglFjMjyD0Y79E
         o4CMEi1qpCAqNv5mWCnmht0MQfk7STkxuFCIGxMkHZbyLicK8+9zQ9IyE242y5J1/i1W
         dHgTpWv0zYpQ5OOOfXrXWlcZlA9U8dCxodqAH7tHzpmjMgfcNAlFaRZL9YIKk1zNhi+D
         87yT3ntd+pZDsi8Q+h26tBX79Z+xXCqC+LfImayZFjP4o+C8BcOpB6R1DVXWAIN816Oy
         UXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713846465; x=1714451265;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXD4HYm9bDjUoBX4uPUgJNHban+xQV9+4zOLQOyU2cY=;
        b=MphlZvKfWc4Pqj5cHVwB7kF70cqJWY7AHA8137wHUcOEb3BiEZfK13GA3FWcC5cOin
         XVwJS+v9w0bTF5IPbaZPLOY5CwPetfSG1SMIV/eicLD0AD4e2iEfPKJBB7x5wPRJaKKJ
         ker46CFHQX+tMtzt/1mNP5txguJ+NZl/xvBl8bp5qsRU5LkUA4hZZs92hTX/gwKBmBWR
         RCMSsiQmIo5h8+erQXnuXzJ8Ec/dA4YaG1hEIOVhwZtjJtvLA7b0cSfTA/d6xpDh1DOX
         wryeF8jIFzW1ID9ei6dgmO+4eQPJ1byntx1SmPDzIDo8AoDeig6zGO1NI2zdbemKBTrn
         eyHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVByMWr6bfZRMcdj3NxqTkgUTE4695OgxC9nn1dl0Us7628bnSompqNDkl1Ogzva1KQeIs5A7cYfKTscVQzAGYD4LTDGo66RzuVDnMA
X-Gm-Message-State: AOJu0YycEkYAeNcSDJHqEG+eio8urKY86GtzCnv4SyzcY+TiAG2t96x2
	o28LR+DIBIXn1T8NEwNqgoMel1Oikauns18eLT4PKAKTOns/+2H5Fk5J4r9NS/cHBPWjkKzHNvz
	AiMGP90kVo8sVk7tJP/5DUA5rXy4nyg==
X-Google-Smtp-Source: AGHT+IE8+a0MH4unOupvoB2gYdeK2VNsqaK954LX1EdT3PtSOL8PMaYgfShdKWTfFUuVeGJktT+BY+mYIm+/9JUt/2o=
X-Received: by 2002:a2e:988c:0:b0:2dc:d2c5:ed0 with SMTP id
 b12-20020a2e988c000000b002dcd2c50ed0mr7357254ljj.12.1713846464806; Mon, 22
 Apr 2024 21:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Mon, 22 Apr 2024 23:27:33 -0500
Message-ID: <CAH2r5muJrPsupmdXDDVV8vNjifZDnyrQoSHJSTDAUUckrX7JEw@mail.gmail.com>
Subject: [GIT PULL] smb3 fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc5-smb-client-fixes

for you to fetch changes up to 77d8aa79ecfb209308e0644c02f655122b31def7:

  cifs: reinstate original behavior again for forceuid/forcegid
(2024-04-22 10:50:31 -0500)

----------------------------------------------------------------
Four smb3 client fixes
- fscache fix
- fix for case where we could use uninitialized lease
- add tracepoint for debugging refcounting of tcon
- fix mount option regression (e.g. forceuid vs. noforceuid when uid=
specified) caused by conversion to the new mount API

----------------------------------------------------------------
David Howells (2):
      cifs: Fix reacquisition of volume cookie on still-live connection
      cifs: Add tracing for the cifs_tcon struct refcounting

Paulo Alcantara (1):
      smb: client: fix rename(2) regression against samba

Takayuki Nagata (1):
      cifs: reinstate original behavior again for forceuid/forcegid

 fs/smb/client/cifsfs.c        |  3 ++
 fs/smb/client/cifsglob.h      |  3 ++
 fs/smb/client/cifsproto.h     |  9 ++--
 fs/smb/client/connect.c       | 21 ++++----
 fs/smb/client/fs_context.c    | 12 +++++
 fs/smb/client/fs_context.h    |  2 +
 fs/smb/client/fscache.c       | 20 ++++++++
 fs/smb/client/misc.c          | 13 +++--
 fs/smb/client/smb2misc.c      | 10 ++--
 fs/smb/client/smb2ops.c       |  7 ++-
 fs/smb/client/smb2pdu.c       |  8 +--
 fs/smb/client/smb2transport.c |  2 +
 fs/smb/client/trace.h         | 92 ++++++++++++++++++++++++++++++++++-
 13 files changed, 176 insertions(+), 26 deletions(-)


--
Thanks,

Steve

