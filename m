Return-Path: <linux-kernel+bounces-161103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE628B472E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0CE51C20C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD961411F4;
	Sat, 27 Apr 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlvXRVdc"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C528C11;
	Sat, 27 Apr 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714236319; cv=none; b=GIE1boE01iTMdaZ09Hb91qtLrBIpj474DZdgqWUH8zjxYgmY8nkGSzXLMpvSIJ6g9jkPqmsyg9eMy45OwDXKiAV2tNNgpyL9nL0iWrehw4FRszWADV+sxy7NoBbq0hiFZnlKWMjHN/cI1pDsT5gsu+i/NjGxyxFjEvO+YqSsF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714236319; c=relaxed/simple;
	bh=AK8Jk7phL3mTytSw5obD0mYNwkMdEy/HNfhMr8DLIBw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WIE9cgypUYnfLzgyXsVLbxZAp564f55PELyp5n0JOwWRjcSJ97ue0OHvPX+PfnrRt5ahUDywOdoMuj0VQxTY62Nx+3xuhUZCy0rXowhEC78ql/6makTtmb5DIkZr0TZQHaeMnSEGuAih5mOpf52EdJ/5T0BLz4s44mUEvajvW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlvXRVdc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516ef30b16eso3589295e87.3;
        Sat, 27 Apr 2024 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714236316; x=1714841116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JhEfRurz6bxQo7nPFIdFapmeHOyGD4f5KO0BLw+ShI8=;
        b=AlvXRVdcqKHfF/a29Eijgqc+ZzTFUK2D2kpFrMuhpNa37qJtXCMevupAbKzcXbdJ6X
         E/1ptftH5pGIVLI7HpNmW+1wJGJAa+P3wihrWBOrib0kLz058+VrmkTpy7jSKfkUtVmd
         174Sz1PekviTAcsHC7/4OXVChS9aapiQTKK4RJPqdssNrUJU6XchAUiLPA1qR2MrfHBR
         V6YvzhEL3BRtHf4uar5zzC6o9uYascxDeDk7WFnPuPmBPoh49wTigUwq5lbljYn5cqOV
         HpX8bRooSX9thXIR/yjlQSQuiUcvNDxjphgD+nSdadzwx+nQh9TBDuGurrWLo6EGnN9o
         V8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714236316; x=1714841116;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhEfRurz6bxQo7nPFIdFapmeHOyGD4f5KO0BLw+ShI8=;
        b=DJxdgF7RAX+d6jWvYU5np9+l3YZV7RSGvTFS2zIU1YBMu0Bz4s0k1DQ8VKMshmLNq4
         OvtlMHK3xZBaQ3NzkKuu+q5lKe+HxjfPtuitCn2QCcD5MILbbgAviv4JIr1vRcuFfKZ4
         LVfBmGvgnPa5wKFHFSSlVlHbWQ6wVVnZqLnoyJugLXtOzwXoKk5H16Uv98qxKqLMnSOV
         SPO2UVS5hhIiXgVwXVESgzDqylQkUYzBug4PJV0LJ/DhxG/CNfgVwLmfINpS3USMXoEQ
         4Wfrup1t9rsH5Ra3dO9AFfIWvnjOkkSAG1OXMUBe0eQOi0KodeoM7ytJddrKIouGCZ6e
         vsOw==
X-Forwarded-Encrypted: i=1; AJvYcCUJz4vX2FCcAzWaccIkcWSyqJeCaIaCPfTuXFuQLAxqVn9wzlbbGuAcRh/EkS/Zg/zNOQiFL5vdKIw1iLohvqmMThrym5R5I+a45Q==
X-Gm-Message-State: AOJu0YzPi/mpZXmWkQeWlrDiR9EC9hgtrNOUzaAVrfPRsOeadyTAsFnS
	8HllFpqAwKuLVIQY9X2BSHSAdkAKKo6ckZUpFfnrLHn9d22PnpSRTvVljPDTSaQtwwVtoKPyS7a
	PcFCxE++OipULdMt48ZeX9mEEL9eBpR3S
X-Google-Smtp-Source: AGHT+IG1moZlk1t7Lo09tpyc5qg2v89QLmKjBDgtsKQqvNMOG4PVyGOPJJydcZQO8hOE6LUgRLRSZruk7I5t1Z14qTw=
X-Received: by 2002:a05:6512:3196:b0:51d:3675:6a08 with SMTP id
 i22-20020a056512319600b0051d36756a08mr1180454lfe.66.1714236315799; Sat, 27
 Apr 2024 09:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sat, 27 Apr 2024 11:45:04 -0500
Message-ID: <CAH2r5muJvf713EeXf81FaVyU9mA9bqLAgXLe036aCHbYKZ3ZCw@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
9d1ddab261f3e2af7c384dc02238784ce0cf9f98:

  Merge tag '6.9-rc5-smb-client-fixes' of
git://git.samba.org/sfrench/cifs-2.6 (2024-04-23 09:37:32 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.9-rc5-cifs-fixes-part2

for you to fetch changes up to 8861fd5180476f45f9e8853db154600469a0284f:

  smb3: fix lock ordering potential deadlock in cifs_sync_mid_result
(2024-04-25 12:49:50 -0500)

----------------------------------------------------------------
Three smb3 client fixes, all also for stable
- two small locking fixes spotted by Coverity
- FILE_ALL_INFO and network_open_info packing fix

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      smb: client: Fix struct_group() usage in __packed structs

Steve French (2):
      smb3: missing lock when picking channel
      smb3: fix lock ordering potential deadlock in cifs_sync_mid_result

 fs/smb/client/cifspdu.h   | 4 ++--
 fs/smb/client/smb2pdu.h   | 2 +-
 fs/smb/client/transport.c | 7 ++++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
Thanks,

Steve

