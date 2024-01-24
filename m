Return-Path: <linux-kernel+bounces-37607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F61A83B27A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39D528709E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CF3133402;
	Wed, 24 Jan 2024 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxm/T8Gj"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588C132C11
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125684; cv=none; b=FIX1/D55Z0tnCY5EYZXVs4w+rPMkkngvdHLLYikg9DPVoED7PMAuMuQ+y5y9m84Gm50UPOh6I/dlJIeih9B2hsQK5qrAVYLgun4S+EoS1F9F2mg7p9NuIVgSR2DoH/PwYknGD6B8Jbm1Oknt0yLR0vRXGmNkbqozIB2UWif3BaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125684; c=relaxed/simple;
	bh=KssMWTRI+8GOKUe82CV7T7S+hcADgDJnkQ/Tqq4Pqe4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VeXqRg7pHGCZcZKMLnaHVvLI98PqmEjlte2524rLugryyL5wFndnt7y5/3ZUFngDUYbd1H/ZYYmYQ+Ks+9XG3ooLsynIz+KgIDNcvjsWM0EqKocx+61boN9baJqXKzg9sD5lBPPD0zHRKwmBra3Nvhfl446GnAowrTpcw77dnDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxm/T8Gj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2909978624eso1754299a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706125682; x=1706730482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z5in7yxhrady5lTGoDYyRXRDY4MiEGt5/MmabNiOiSA=;
        b=hxm/T8Gj+WhY1huGTYKyIVoY0/+//ALo/iFJQW/YjfG8yLC5pmG5vOFPgVMftsWtyZ
         eKV44plPsPirat1USiiW5SvRuau1f8ReHbvimAjFdfxqhI/qT92d9w7hpnWJmPZar4JF
         zR9BwpDSOnrp9OF8LP5o4qXBYuzlN0wcQDNMnY/th4PcU4VSNXcdBMeF+5s/pkvvJW2j
         /JDOpOVzTdFzJStWkWP3YrwO6GPbm+0N6vJ0TfcwP95wEXj0asnpBW4mTZiNOz39QC0Q
         wN4PBPWjc12kGGvNFGPbqqdfixxeSsI8JpTN4rl8cAj0BLITqRXZ9BFF3Fnx5BNdVa7d
         2WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125682; x=1706730482;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z5in7yxhrady5lTGoDYyRXRDY4MiEGt5/MmabNiOiSA=;
        b=V3+HZ1EoV/f7skgoO4bdxNKHrORz+j1u9Ka+4BiSnlXnDHvd0JNNQno5vYeC5m0gYS
         bztbUGsTfExoUgcuNDOJ/usjMikjtXV/VLg6OiZFsmD+CZEHWIO+OPVG7X86r5DPq9CT
         5bYUqjKpweaUQ2zPvZaZJfjOv/uIprZDJ+c56SsER09xCHr2USp0ys/qW6wgpDS0qM2n
         QoDjukes/HSKXHT/h7Hiyja5axtbGEYUqd2k6W7R0fawCPpkmSE1iMx0L0UBOtOxcgm1
         xtgp4pmEmicWf4tYHu4AitZ6Adfz91XDnx4NRdcmgauZzGUSgObE6r35AP9E6erl6sU6
         ZZCg==
X-Gm-Message-State: AOJu0YzgK/OTMgmq6G59nbDrh9U78OAWq9BKoyO97IMiVFany+zZdXC7
	SyYKBmtd9JQBCsBwF9e1+Jiwbxh2A3pG+MBvpBJ2SX54g/rm43koD/CZNCtb5vybnTPqq7EtwQa
	IfGgPpntQlYtQCEyQhzQH3QhhWzI=
X-Google-Smtp-Source: AGHT+IFyxXjOG934e5n5jLLEJXDq+MUHI1v1Jjbuk7zDMyHb75jBe7esgnnldaaGUDAuOjhtRfiLHy9mnlVnHjsgizk=
X-Received: by 2002:a17:90a:1307:b0:28e:7b94:78dd with SMTP id
 h7-20020a17090a130700b0028e7b9478ddmr64854pja.25.1706125682538; Wed, 24 Jan
 2024 11:48:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Wed, 24 Jan 2024 12:47:34 -0700
Message-ID: <CADBGO79JycAycKXm9A46pLrGZHTsySV4NH+yvV7VFU-8reMF=Q@mail.gmail.com>
Subject: [REGRESSION BISECTED] 6.8-rc1 - Wayland hangs when connecting via VNC
 or RDP
To: Luben Tuikov <ltuikov89@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When I attempt to connect via VNC or RDP to my Ubuntu desktop, the Wayland
server seems to hang. The desktop GUI no longer works either locally or
remotely. I can still log in via ssh, so the system is still alive,
but the GUI is
frozen. If I boot into Xorg instead, everything works fine. Kernel 6.7
works fine
also.

I bisected this to commit f7fe64ad0f22 "drm/sched: Split free_job into
own work item".
That commit does not revert cleanly however.

I don't see anything in dmesg when this happens. Here is a snippet from
journalctl when it happens:
Jan 23 16:14:30 paulz-Precision-5820-Tower systemd[2826]: Started
Tracker metadata extractor.
Jan 23 16:14:55 paulz-Precision-5820-Tower systemd[2826]: Started
Application launched by gnome-session-binary.
Jan 23 16:16:47 paulz-Precision-5820-Tower
gnome-remote-desktop-daemon[4158]: [16:16:47:810] [4158:4896]
[ERROR][com.freerdp.core.peer] - Incorrect RDP header.
Jan 23 16:16:47 paulz-Precision-5820-Tower
gnome-remote-desktop-daemon[4158]: [16:16:47:810] [4158:4896]
[ERROR][com.freerdp.core.peer] - peer_recv_callback:
CONNECTION_STATE_ACTIVE - peer_recv_pdu() fail
Jan 23 16:16:47 paulz-Precision-5820-Tower
gnome-remote-desktop-daemon[4158]: [16:16:47:810] [4158:4896]
[ERROR][com.freerdp.core.transport] - transport_check_fds:
transport->ReceiveCallback() - -1
Jan 23 16:16:47 paulz-Precision-5820-Tower gnome-remote-de[4158]:
Unable to check file descriptor, closing connection
Jan 23 16:16:47 paulz-Precision-5820-Tower systemd[1]:
run-user-1001-gnome\x2dremote\x2ddesktop-cliprdr\x2d9Tp4LD.mount:
Deactivated successfully.

This is on an x86_64 Xeon system running Ubuntu 22.04.3.  Any hints on how to
debug this further? Is there a way to turn on additional debug prints for this?

Thanks,
Paul

