Return-Path: <linux-kernel+bounces-51289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C18488C6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFC51C21CFB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF3010A05;
	Sat,  3 Feb 2024 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igjpNltN"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A28171A6;
	Sat,  3 Feb 2024 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706993256; cv=none; b=YKGCTwXqjOYwxXx5aSKP7m0TdvKtY0fx5j6+2+Ivp4EmcKj9CG7DUyEAuf1aL/e+1OEEdtYqKTiscuBEW253lmPT7OnWRdR+s5ajANV4aCUCLnoCMrlYgdhQamdnj55Am2TusG+EefyKlsegqcayV4G5ap+9JXScQ79Dtoq5FCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706993256; c=relaxed/simple;
	bh=dFOJvRm/Dv2GJm9tcmr/rRrBF5xou9O/DPzBxkjeBCs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cbJd/lBjwQUNaEDCWD5Zndw3mQ+oMZ00KIGc9DVNHGDPAn8JsJGE4Gm6U3VH7ahVNlZS+PO36vB/g1fs4zq0oZmFbJFamuLqP8U5SiOUv6lcmUPfegyfU2HS6exFPNGqsc+tZwop3sVpquAGW9vM2zqrfHbSMe2EzfJ3qqQtaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igjpNltN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51124db6cf0so2336109e87.0;
        Sat, 03 Feb 2024 12:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706993253; x=1707598053; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E50Uf9G+1/EGFuipor0RfEYDS7SLOBDadNS0OFqIDYE=;
        b=igjpNltNiqMJB2dHWubt0OMSsUXG4xTomBfYXI25ZbWioeC3pnzyscufc5+H+bOvtN
         Imm5otQobSRv7dTe14jtzVBUY0fCt5I/wKGCGECWg9telpwl5+6Wp40Ilrxb2GF/gKF/
         UdZGCM/LFTGnkrs0hjGG02y/sihqy2+Qz5OdAfTnkoriLiJCSG+CIprZqevW24S4i+gv
         pnFNatJV/LphH51MZySppUIhaCNwb5s3fZ7OKX33rZE5Xk7Yf1TvE0Rp9RQ4n4ze9okJ
         lTGZJq6n+lkT8VzmbcJki9jCOmF4ELBiMqs5ITG5NUhbtYfo5mtZN3YBR0MtKJqf7T1K
         vlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706993253; x=1707598053;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E50Uf9G+1/EGFuipor0RfEYDS7SLOBDadNS0OFqIDYE=;
        b=nav255bfMdv6zWt868RCpsnanmSBK0g1kdATjldFOAG7E9m9hKVJRhUSfoE0Etp69o
         pszFhYcErbaBtEM3cCsUe9kwYeOt6ODWA5DJXs0M3EMNwJ3fdn2EgLw84Fq5FYZjmiv0
         Zh4qb7jCaRFPAnJ/RRLLejZ/ldmNmpj61298/Q2c7WRXaQ6gWGTOfsjy6QjJhQYyzLZw
         mVXVot3Y8wBECqUtsRURp7QVTHZ1wR1TH7BPIdNzbFEDSPSrVhYABskMgSswsRp828d+
         ck8o7G53oHeCoHyAOLQEh/gkEKRJqC3MA4MTmmgJcPrrSFT4rYKCdmlVfk7PXe1F4FII
         IDDQ==
X-Gm-Message-State: AOJu0Yw2/eMcBTBgkE8FwaTSAYI2w5PgoZDOpg+f2Iko86Aql+DIBRyO
	bdDriVE3VuvLNvgWyBdEYzIs1hshzbgZ6sudLuBQbKRm/j0DRuc83EaUpjcxdAbr2svMMazvOAM
	l5/2EpaWKKGZu2gUv7sL6NWhvypYOzQ90k6o=
X-Google-Smtp-Source: AGHT+IG6f3hmgfEQrdFOzDt63ZAHdfESpS0/wFYlA8mChiTdUPzDMSJzb/xIZUWAfKuonFf5E6s80629MvfxXv5TBCw=
X-Received: by 2002:a19:c217:0:b0:50e:7b9c:4d97 with SMTP id
 l23-20020a19c217000000b0050e7b9c4d97mr606778lfc.8.1706993252920; Sat, 03 Feb
 2024 12:47:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sat, 3 Feb 2024 14:47:21 -0600
Message-ID: <CAH2r5mvqa_RSjwQ1oqXt0a51KVu46Bov6_X-x6FUH4s8H1wVRA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/v6.8-rc3-smb-client-fixes

for you to fetch changes up to 11d4d1dba3315f73d2d1d386f5bf4811a8241d45:

  smb: client: increase number of PDUs allowed in a compound request
(2024-02-01 12:15:51 -0600)

----------------------------------------------------------------
Five smb3 client fixes, mostly multichannel related
- four multichannel fixes including fix for channel allocation when
multiple inactive channels, fix for unneeded race in channel
deallocation, correct redundant channel scaling, and redundant
multichannel disabling scenarios
- add warning if max compound requests reached

This does not include some additional important fixes being tested for
deferred close (on delete) and lease key reuse, and the password
rotation fix (since making some minor changes to these).  There is
also a larger patch series not included that improves special files
and symlink support and improves reparse point handling (from Paulo)
that looks reasonably low risk but is larger so is not included.  I am
ok with sending that series earlier than 6.9-rc if requested.
----------------------------------------------------------------
Paulo Alcantara (1):
      smb: client: increase number of PDUs allowed in a compound request

Shyam Prasad N (4):
      cifs: make sure that channel scaling is done only once
      cifs: avoid redundant calls to disable multichannel
      cifs: do not search for channel if server is terminating
      cifs: failure to add channel on iface should bump up weight

 fs/smb/client/cifsglob.h  |  5 ++++-
 fs/smb/client/sess.c      |  6 ++++++
 fs/smb/client/smb2pdu.c   | 24 +++++++++++++++++++-----
 fs/smb/client/transport.c |  4 ++--
 4 files changed, 31 insertions(+), 8 deletions(-)


-- 
Thanks,

Steve

