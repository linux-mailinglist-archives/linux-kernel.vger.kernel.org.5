Return-Path: <linux-kernel+bounces-29596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E404831096
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40561F22CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482AF15AE;
	Thu, 18 Jan 2024 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDAAu3cK"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B3917C7;
	Thu, 18 Jan 2024 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705538400; cv=none; b=iJ6CdcHhfbjaopoX3hiAaSa+8Fy+Cf5RauueUs0VR6rF9AT7IPKn1BmQjyb7c8BJkss6Pbqk4JyJHX2HdieMPURzEobGkRrXe4KPJPrZmrJX8aYRBZreCrY6ljRKcgXEbSitbUvlwyDqzf9lofTUw38NCSM8LQ7+QeJyhmMZIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705538400; c=relaxed/simple;
	bh=xfSRm8NYBQgeSl23nqbKW5dBqQgWEKEtHeDQhZjOa3o=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 From:Date:Message-ID:Subject:To:Cc:Content-Type; b=s8ucYZvkaeMULw5RhEONGJrPTNFcCXlsLQA4CBZIL1Xsj1hP+DZSPK6UWsg9c8oEm340i1AmlfvFl8aJITr0RBSF//MjhkJRLzMOCi9mjOZNV0ymGMAT99MHrdNgpyNUgIagCdBHegsa6fkHi1/9LMfy5jhN+D6gBG1qiN2B3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDAAu3cK; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e7b273352so13072614e87.1;
        Wed, 17 Jan 2024 16:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705538397; x=1706143197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F9BqwFmg7PAKPDz/4wrpx1bRNJyJhn0vNuUNbGSy8TU=;
        b=mDAAu3cKmZYS5NpgesLJfxbgMdsxGymXWTFw5VcE1jBX1wOk6xgq5eDpW8nlhUFPN2
         it+rCtVZnrszS5NXiUNOiBEbqJCoFD45XWip8qdGYysrXnFkHRXQ6kbKBJhu60psJD36
         6C2FVj5APK9O9ZOB3SrpZyHm1BZMIVN15YRgbhhHSvmG7zSkDOA/4o7I9sp2YKLZOFzR
         U2JDFtvqsA8222XGvRn8t0uwqdqeR1UcPxzyWlf4trdflSnpzetWXC8h4yq+azrhb7T2
         hiz3w7EH2cVQbB3DxpfUcVvDP29Ry8IesmcODFzBuCvOaJp1YRL/4QyNgdV6SPVgkGZG
         Zx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705538397; x=1706143197;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9BqwFmg7PAKPDz/4wrpx1bRNJyJhn0vNuUNbGSy8TU=;
        b=TOeQ5l46PiWVtpPQ45b0G8B/v/ay9UWlaMZdX2o9CHKdqTRbq4ELD1cCMbJrxesmI1
         otEfs76SVIw/YizqlVy+pRjyLF3QLRZWM77rrq1/GP8xExY9Ha8C2Gd/0ecMP5fXXFoa
         6oMztiPi3aXeKitJFrthRFnnHBoNupTDcK4f3RFEffQ7rIP53e4QbNiqn+j8E2c9Tfei
         5Xx17Sd3JqK2T+BTaSVHTIZ4/62QGGz9BPldl8d7QtN6g+PYqLL5lVbe1EZvYRsz6VMe
         p3AAR4hmrxKqifdU5zaHj6KzeeL7d5p3nGCXVHD8XBzroixulBbPvkPLzo7XeH2XHCxk
         AKtQ==
X-Gm-Message-State: AOJu0YxNGZKlZdpnra4RNVK9hucv8dHlOS76QWpyrjHTJkLqnUJk+kYC
	8TaNs4CpoKfq5A2CinW/nsBkmzic5mZzfL5BpxuCV87kI9RJd/Pb6PfT9w+68kXQHnqO9MVlOcT
	7Ud9wbF8YHCJziLM1D1G5m2xDyTTdNz8D63P4Hg==
X-Google-Smtp-Source: AGHT+IHEPhIiOZgJv9JLiCnLY+mq7HxxpH6beNx2tl0YcvdNI9emQRmCV4DOo4GJpIOSZq0kWr6lGlGBxJ82q5MsmUk=
X-Received: by 2002:a05:6512:31d0:b0:50e:757c:cab4 with SMTP id
 j16-20020a05651231d000b0050e757ccab4mr20156lfe.52.1705538396717; Wed, 17 Jan
 2024 16:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 17 Jan 2024 18:39:45 -0600
Message-ID: <CAH2r5mu+MHtC7VsKcv+x=Mr3=eghEfSrp-A4_0Sm2cuPDEzW3A@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
6a31658aa1c0b757df652f6fcf3a001f90fda302:

  Merge tag '6.8-rc-smb-server-fixes' of git://git.samba.org/ksmbd
(2024-01-11 20:27:41 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.8-rc-smb-server-fixes-part2

for you to fetch changes up to 77bebd186442a7d703b796784db7495129cc3e70:

  ksmbd: only v2 leases handle the directory (2024-01-14 22:14:56 -0600)

----------------------------------------------------------------
Four ksmbd server fixes
- Fix for incorrect oplock break on directories when leases disabled
- UAF fix for race between create and destroy of tcp connection
- Important session setup SPNEGO fix
- Update ksmbd feature status summary

----------------------------------------------------------------
Namjae Jeon (4):
      ksmbd: update feature status in documentation
      ksmbd: validate mech token in session setup
      ksmbd: fix UAF issue in ksmbd_tcp_new_connection()
      ksmbd: only v2 leases handle the directory

 Documentation/filesystems/smb/ksmbd.rst |  9 ++++++---
 fs/smb/server/asn1.c                    |  5 +++++
 fs/smb/server/connection.c              |  6 ------
 fs/smb/server/connection.h              |  2 +-
 fs/smb/server/oplock.c                  |  6 ++++++
 fs/smb/server/smb2pdu.c                 | 22 +++++++++++++++++-----
 fs/smb/server/transport_rdma.c          | 11 ++++++-----
 fs/smb/server/transport_tcp.c           | 13 +++++++------
 8 files changed, 48 insertions(+), 26 deletions(-)

-- 
Thanks,

Steve

