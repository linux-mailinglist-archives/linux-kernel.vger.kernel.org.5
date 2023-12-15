Return-Path: <linux-kernel+bounces-317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482A813F41
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8971F226F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22815805;
	Fri, 15 Dec 2023 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbzDrMrG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E8650;
	Fri, 15 Dec 2023 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e1d61b657so140123e87.0;
        Thu, 14 Dec 2023 17:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702604171; x=1703208971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=msKpLJDj2E+6ke2GakBcCsbJMiMSu4+2qkb0cKHtw4I=;
        b=XbzDrMrGgJPUkNzAq6pRwJqjXj9NmJA2p6qRpgeoEoEIk6aiH102nd3I8tRwfzHOlB
         N5ha6teHRbG6elw/h2rXdEZczdSzZCR8PCn1DDAcydcje4VdGaiZBGNOREqSerHwJX/+
         YuRCpcAatJ1qjKQEF+7p/QW5mzbvaPde3CLBGhpHMKJofr3CgWayhpO3c6F5D+ENG2ju
         d+ciW15YWJWrVDdi2E7E54PGCIHhtItrKLYOcXI2tLJk4Krejc2acZtt4WYEUsVmdAAG
         jnym2nQezzKbkfNBu/6wvmFzuTMU1b5LzWR71pnU2EZ+sa2LKrA5vB+vq0SHr6rsrazB
         iy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702604171; x=1703208971;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msKpLJDj2E+6ke2GakBcCsbJMiMSu4+2qkb0cKHtw4I=;
        b=iFHxOAKlnPlmXM+tNsAebrxRwoQK9iES5ojs9/9Fc0txeYN/SRQoL8qbXhy74fG6Ri
         GAF+BLUcjazPbF36N0kgG/JhT44I+ZK1R0IOjWgOqJMOLQLYpgzLprGnTaH0MvNUnFek
         LPz9PxxBWiNFuLuTOPE4T91n3m64bF3zAKRl5ziZeToD/qgSg5x7A5j7HJieQasW4WVz
         6ir03UtKjFnnpqqdINfcUoiWgj15ouZ0BBk8tifuM550UfpFywgGBkmBnUqOpD0yRnWs
         4bQhcyJq42vf+dUeWMblM+EQXeYus61vF3sXWtzMCkTX0qom4881nEbrANsFFN2FsKeA
         CruQ==
X-Gm-Message-State: AOJu0Yxh4hPfavufgHli9TiZ5Etn06gHD1kCgUhitB0kuXfsaqui/iEb
	rs3cl2QOx6xZNn1me52oNdYmrHQkTgfYN2RU3NfI4fpy6AA=
X-Google-Smtp-Source: AGHT+IEETPSBpzWv6linvi4l70q1BFb6Wu2X8X6h+1vFcPrNUaKpaoEB9k3iXCkM3/1DVJcaTpo0VbIU0PrkR60wqAw=
X-Received: by 2002:a05:6512:1322:b0:50d:1f0c:2b24 with SMTP id
 x34-20020a056512132200b0050d1f0c2b24mr4973835lfu.20.1702604170570; Thu, 14
 Dec 2023 17:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Thu, 14 Dec 2023 19:35:59 -0600
Message-ID: <CAH2r5msvjVFMG24ffSg+N9nmYDy+fBBaba_wMCc-=4V=4m5PyQ@mail.gmail.com>
Subject: [GIT PULL] four smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paulo Alcantara <pc@manguebit.com>, Robert Morris <rtm@csail.mit.edu>, 
	CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc5-smb3-client-fixes

for you to fetch changes up to 3a42709fa909e22b0be4bb1e2795aa04ada732a3:

  smb: client: fix OOB in smb2_query_reparse_point() (2023-12-11 12:30:39 -0600)

----------------------------------------------------------------
Four import client fixes addressing potential overflows, all marked
for stable as well
- address OOBs and null dereference found by Dr. Morris's recent
analysis and fuzzing
----------------------------------------------------------------
Paulo Alcantara (4):
      smb: client: fix OOB in receive_encrypted_standard()
      smb: client: fix potential OOBs in smb2_parse_contexts()
      smb: client: fix NULL deref in asn1_ber_decoder()
      smb: client: fix OOB in smb2_query_reparse_point()

 fs/smb/client/cached_dir.c | 17 +++++++---
 fs/smb/client/smb2misc.c   | 26 ++++++---------
 fs/smb/client/smb2ops.c    | 40 +++++++++++++----------
 fs/smb/client/smb2pdu.c    | 93
++++++++++++++++++++++++++++++++----------------------
 fs/smb/client/smb2proto.h  | 12 ++++---
 5 files changed, 109 insertions(+), 79 deletions(-)


-- 
Thanks,

Steve

