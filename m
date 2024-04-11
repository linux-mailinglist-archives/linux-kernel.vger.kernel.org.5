Return-Path: <linux-kernel+bounces-141445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083018A1E60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3361F23CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F19A4C630;
	Thu, 11 Apr 2024 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKghfGn/"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07427502B5;
	Thu, 11 Apr 2024 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858831; cv=none; b=b7b7Wad+kvxYDHNiGtdiziJsGq+o6/OkPBpSWoGqSWWbGujHyT1SESKjK8vBt2lY3P2DdT6+z95ylELCdaJ4huln56E0xEQYogSkmRol50+dbGixI0dkl+cEEWdCvx9MKi81THytFuOwQGkWunFR33aZ3pN8D9Kdn6RisrZKQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858831; c=relaxed/simple;
	bh=h05CbtcAxI8aFNKx4QsEB4SWlbdKRKn/4mkPD2O/G50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8cU41YIfDUofAKp6VnS6lcKAF58GQyG5Jmp1wvtjFTyn1w50IjGsXuL+EdLnIuGvlJBk96dcVhf4BSm0b8GuSi0tYRIX0huq2hNuWMyAcCwUeqr91ohY9qoW8/m2zVWpiWLRenxcul5vYxPIFd8PfOA+xdqdelMPM7NAiXM37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKghfGn/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343d7ff2350so22872f8f.0;
        Thu, 11 Apr 2024 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858828; x=1713463628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yWLNY8BuzmLk8t2ZD8eDNEWlsMPvC04pg9vc4aQu/60=;
        b=NKghfGn/DICxY5vkB71tbaro01KTIpAUUc+9NnI0L2xYEXOt8YyxgK7IFysFW+NyyE
         A4tgstu93Gpj1PNN+V+W6YiAW4+OWlcaico8lVlQxzWHKImxrntVx9xkYyqgtkamGFjA
         G1GgZ99+iKhZ0OBCLwx1iDEB/Ij7jcjLFPJOflC+Atc/MfNpSRwNl+LqODurC0gCkcg+
         9HBI9AAWaG63btPGsIHb1bsl/bbAs64Vm/XDpnYPF9klfLz6iMxumsbLjh/e4Oau0bT+
         Yze7VySvokxFlL9QZupGkb/EmgZ1Kh1VTzGAg2MziCZtcfTcZ8kc/AIuLBy0dPotFDhh
         YI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858828; x=1713463628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWLNY8BuzmLk8t2ZD8eDNEWlsMPvC04pg9vc4aQu/60=;
        b=nGuuHj9wXhd4yt3937lT1Xue9LQOlP36o8Bp9G+V4+n9DuSi0TAeIQ2PYKVPBwrz3b
         ORzbWbwXVLkTMH+Z2CHb2pfyZL8nrSSD9sg6W5kOtr8fBGV4JL9yjahxq5o20IgnSgEJ
         vdn5/O5aM1eA23rcH8CPRZTeym+c5qaqKvol0vnD1MI1A860NqkWDVtDLUOA2R1c1/WK
         9LisOYcvrBvXHampNn0w9O1vqELobopJZL7aMfOrvcjycNMomehLiJDuubhiEMckmDOE
         mdOFx+Q5GA1fY1z4RVEA7umJ8ugGz/5reUWdOoKtyhwVPJNb7qJLrohcWmFvlPH0/XUe
         KcCg==
X-Gm-Message-State: AOJu0YxkUUE3JLWlOe3KiCrLzEz7LzJNbJo3tVgSh86hfvpuOODYXPMM
	dd4Ajabs2bESTffhAGf+fE4LfxDb6gBm6al9GW5YpvVMeeJzDXj/DEIn9Q==
X-Google-Smtp-Source: AGHT+IGwl4TS8EnUa5huGs5MMxc9kEB4SXxgszl+vnh77zhUlqYTRFW5luIwoiE/NoEpy4YydiENIA==
X-Received: by 2002:a5d:47c2:0:b0:343:6b0c:7553 with SMTP id o2-20020a5d47c2000000b003436b0c7553mr223025wrc.55.1712858827273;
        Thu, 11 Apr 2024 11:07:07 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe3c9000000b00344a8f9cf18sm2324640wrm.7.2024.04.11.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:07:06 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/5] OpenRISC FPU and Signal handling fixups
Date: Thu, 11 Apr 2024 19:06:27 +0100
Message-ID: <20240411180644.2023991-1-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series has some fixups found when I was doing a deep dive
documentation of the OpenRISC FPU support which was added in 2023.

  http://stffrdhrn.github.io/hardware/embedded/openrisc/2023/08/24/or1k-fpu-linux-and-compilers.html

The FPU handling has issues of being inefficient and also not providing the
proper state if signals are received when handling syscalls.

The series is small, so should be easy to see from the commit list but in
summary does:

 - Fixup some issues with exception handling.
 - Adds CONFIG_FPU to allow disabling FPU support
 - Fixups to e FPU handling logic moving the FPCSR state out of the kernel
   stack pt_regs and into the task_struct.

Stafford Horne (5):
  openrisc: traps: Convert printks to pr_<level> macros
  openrisc: traps: Remove calls to show_registers before die
  openrisc: traps: Don't send signals to kernel mode threads
  openrisc: Add FPU config
  openrisc: Move FPU state out of pt_regs

 arch/openrisc/Kconfig                 |   9 ++
 arch/openrisc/include/asm/fpu.h       |  22 ++++
 arch/openrisc/include/asm/processor.h |   1 +
 arch/openrisc/include/asm/ptrace.h    |   3 +-
 arch/openrisc/kernel/entry.S          |  15 +--
 arch/openrisc/kernel/process.c        |   5 +
 arch/openrisc/kernel/ptrace.c         |  18 ++--
 arch/openrisc/kernel/signal.c         |  36 ++++++-
 arch/openrisc/kernel/traps.c          | 144 ++++++++++++++------------
 9 files changed, 160 insertions(+), 93 deletions(-)
 create mode 100644 arch/openrisc/include/asm/fpu.h

-- 
2.44.0


