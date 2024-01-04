Return-Path: <linux-kernel+bounces-16266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36199823BE1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5E72882F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36A618C31;
	Thu,  4 Jan 2024 05:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCO7cl8q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B723D1865A;
	Thu,  4 Jan 2024 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7b51b0ceso118475e87.1;
        Wed, 03 Jan 2024 21:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704347207; x=1704952007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D1hePiwwPWJ2XA1ilYXmZCLY4DSOPTqBpRyLgRU6YnM=;
        b=GCO7cl8qKOSepPRPOrFN+jJNRwwLnfW+NBdGdckpeekCWJGetA8Qa1jRnpJi2YPh/j
         BzXRSYG4uxLDJ+s8fgpXYLTa4kl69a1uTCjpF73z284T57DzwWdsNhic6qOnbQ+TIWEm
         wFauECCLNQguV+BzbAIsl0txL41RihWJPH4LuQ036NRmuS5LK2nzMJ6aBx1TJ6/K5360
         Q05yCxOgUdQ0L4grYC/W2117tjZ42V5hq7geNNlniUDV0UFg5mzsgMgChkwYon5qhq/4
         qtDjf3+FRWrLh4wV6EHPXi0z6MXpH3PthsBeTReeno9iIrUMm59riL/C10CP1/AbaZOo
         wopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704347207; x=1704952007;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1hePiwwPWJ2XA1ilYXmZCLY4DSOPTqBpRyLgRU6YnM=;
        b=FkpQZYtUpDO638gwxnxYtLZ8naPiwqRIJPnbbGe+Rv46UtFvQ8SVpdgaSJ/YKVnj/q
         Wp58ZZyP+Ru/nNRYVw0Gwh4SGvUnzpYIVymAYCgYQwIZbwgJR7aO4XO0nzVeLXFCXOeL
         M82iC5tmI5e/cQotGfBAbJSF4z6dGO3kgemZb+wjMWLkfNOkQhtMddFbL4igKvm5ATsn
         VRnh4Dt5T+i9CCzCcYC2ot6DHrTe/m5Jax/gZfO88usht3yhXGygHXxy8J39u0ekuLF9
         CgMXBGltYHbvHLhqBGwIrQ+wZLamYdhLDFMvqV45DjkRCi0IXRisJuRbcg35fMd71UN+
         3LUw==
X-Gm-Message-State: AOJu0YxgGHPQYvA/MwiV0zkDP3xH7XzxT1jZkY+YITE8C/2h//FXQqHh
	xtnpP587Ip9mJ+vYtLxpRfCoN1osumYRT6hqeMA=
X-Google-Smtp-Source: AGHT+IEofVGvBg7wumZRh+Y7cCfGBtGe23r+MWBmOqHY5tYDJY4Wnk9Vvbss3X4LgKybt3T1hBEW3JQqiCXWlHWUM0g=
X-Received: by 2002:ac2:5dfb:0:b0:50e:6b57:4628 with SMTP id
 z27-20020ac25dfb000000b0050e6b574628mr19504lfq.13.1704347207272; Wed, 03 Jan
 2024 21:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 3 Jan 2024 23:46:36 -0600
Message-ID: <CAH2r5msj3W0t7QqkZuTgP9vW+gF=P2Y53ELGaiQe_Xi-pyTHfA@mail.gmail.com>
Subject: [GIT PULL] SMB3 client multichannel fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
861deac3b092f37b2c5e6871732f3e11486f7082:

  Linux 6.7-rc7 (2023-12-23 16:25:56 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc8-smb3-mchan-fixes

for you to fetch changes up to 09eeb0723f219fbd96d8865bf9b935e03ee2ec22:

  cifs: do not depend on release_iface for maintaining iface_list
(2023-12-29 09:11:26 -0600)

----------------------------------------------------------------
Three important multichannel smb3 client fixes found in recent testing
- fix oops due to incorrect refcounting of interfaces after disabling
multichannel
- fix possible unrecoverable session state after disabling
multichannel with active sessions
- fix two places that were missing use of chan_lock
----------------------------------------------------------------
Shyam Prasad N (3):
      cifs: after disabling multichannel, mark tcon for reconnect
      cifs: cifs_chan_is_iface_active should be called with chan_lock held
      cifs: do not depend on release_iface for maintaining iface_list

 fs/smb/client/cifsglob.h |  1 -
 fs/smb/client/connect.c  | 27 +++++++++++++++++----------
 fs/smb/client/smb2ops.c  | 34 +++++++++++++++++++++++-----------

-- 
Thanks,

Steve

