Return-Path: <linux-kernel+bounces-41088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA6383EBAD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F174EB2223F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139041D6A7;
	Sat, 27 Jan 2024 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIQioKD8"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B191D524;
	Sat, 27 Jan 2024 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706340036; cv=none; b=G8SE7mANLk1J/VK3M8IRBHdUPCl5CmWg+EZF4yJjw03/MLj72iiWn1RZHQS/Mje8l5P3PZABIsdmexlw+OhfbwAe/O+qKr345rGRGkmbLZd1hH1In0NQs5fifSVW4DVI/dgy7E/p3t9guvJ31wJCfDkRLywf7WDxcI6kCWC/f+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706340036; c=relaxed/simple;
	bh=DG0T+i0aFTOnH0ZkHPv2DZqh/O1e2GiaMwd2yGa/MLY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gfxrlDr1dEN/2BC8nJDXNRsKwyos9jdw3EpAgzTvvXaPleqb8SNqV1hSPFN6sXQz5jmIvLChzLHnoUsvvRV0Rk3/+JPSVvLbPmzLllaKxCYllawNnquE7gyrjyoukYCpdsQ5fgaB2j/1yiOuvNmzJlrXkLPOsLlio5Woc0/tGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIQioKD8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51028acdcf0so1235838e87.0;
        Fri, 26 Jan 2024 23:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706340032; x=1706944832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qkT/O48GLFNhmSB0dmvxtjrh5cflJ0MwZ+5bygqYP8o=;
        b=jIQioKD8SMFuC5AvVWAXf2phcaRBuwWxe6shf4+LR12qkw5TCRqlzoqnJJtTgP+Vpx
         Hf2WgKKgE4DCyrED+vwu6aKyCqQs+0Y/qKqsGcgsYScng51ssPj8M1kwmElFP3rUMBDz
         qZdzmgULoQvSe2IioPW8xMgXWcrbS7VPP4YHnl6Iz+I4IL2LkOCtStyhKzZZcliYxWJ2
         jRPv0bl86UtZI7MpBiOPS1G8DtkChZMMMckEMX2CA5Z0xnvj3I8V+YYmK/S5sVH/NnNA
         jweXgzmcVWdaLF3dCeHSSNI8tDPx00o3tNjSKWkD5O9pesB+YhJc2plPBXBC3dgyvgR0
         Enfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706340032; x=1706944832;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkT/O48GLFNhmSB0dmvxtjrh5cflJ0MwZ+5bygqYP8o=;
        b=CLCMjLOA1daKOF1fk1HwrpqRI7o/pjjWCbJ1WM9Zbs56QedhOded/vAqOcpVTIPqpO
         09lABxXQUGnkT7BDr2aUZIkv1jcpakYArGnQ/sDLADf8Fsu2CC3H8CVISdWyrl3Qf/GO
         Lp5eq0stzDqsTOygHuBudO6GnOQ9cmwwpKS9sgk5oerPuliK8mMRF0U34TQsYyfBqFwI
         /xskthFf97BoM9fcOHwM+ybGOQKM+LJ4o5MRbSMtTg/zBR/sUOGspfqQ9rsVRCpKkKtX
         xN0GgHH1dEk+HYWtr+FHsT/ezpFWdIzWs9CNkg+ail0Zae1vTb7Cxn6uF6/9huOG8h88
         1iLg==
X-Gm-Message-State: AOJu0YxarfJqrKuzVOe+T3DMtJD7M11YqQCQtzg6I28O/313NqeS5Ns5
	LvyoQl+9w7ivWb9ZamunmaDOYby/dhIdTNGIcqL1kAaA66RocXd0k5mDnhZvc8rSkn6sujoyPHZ
	odpSFooz52OHoMvwD1xPHkfdr8K0msEFm
X-Google-Smtp-Source: AGHT+IE0uFI9d15jjQoRZIaWTwIjN4NeIlsEkhnwWccKMrv58WW9QFr7XZJfb0a9tXxtsDWjS7fCo3E8yl7DH98YV5Y=
X-Received: by 2002:a2e:9794:0:b0:2cf:4f79:9b4e with SMTP id
 y20-20020a2e9794000000b002cf4f799b4emr683645lji.41.1706340032284; Fri, 26 Jan
 2024 23:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sat, 27 Jan 2024 01:20:21 -0600
Message-ID: <CAH2r5mt0S22dHKCYSK2pMOX8mc+K9Dp+zV-Ocdy_15ZCHvdMWg@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.8-rc2-smb3-server-fixes

for you to fetch changes up to ebeae8adf89d9a82359f6659b1663d09beec2faa:

  ksmbd: fix global oob in ksmbd_nl_policy (2024-01-25 00:16:54 -0600)

----------------------------------------------------------------
2 ksmbd fixes, including one for stable
- Fix netlink OOB
- Minor kernel doc fix

----------------------------------------------------------------
Lin Ma (1):
      ksmbd: fix global oob in ksmbd_nl_policy

Yang Li (1):
      smb: Fix some kernel-doc comments

 fs/smb/server/ksmbd_netlink.h | 3 ++-
 fs/smb/server/transport_ipc.c | 4 ++--
 fs/smb/server/transport_tcp.c | 2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

--
Thanks,

Steve

