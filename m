Return-Path: <linux-kernel+bounces-19370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF944826C03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E227C1C2226A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5412F29410;
	Mon,  8 Jan 2024 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0MQKTfi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F22940E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a298accc440so171417366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704711812; x=1705316612; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1wov7S+c4eP3tA/GZq5tzz01wP3CYZQxPahNS7M7qNc=;
        b=c0MQKTfiplX4ceUasvMX49L372RtGFyx3xn7pVRCQdB/yLxyEtIaoETTggyr4Y7OOP
         BJ0nLQIgIkLb/jRRgZFtQbHVmMnGkaTza5A9NMSq8odRpYXcbTWCq+xjb/Dkr4OQN90r
         lUDLNCPP2Vc7nLFtDtjDVqZK0vpu3HxU6WTgtEyglPLCduhVtDYqFA0k3d7RRmcXY1lb
         DC34Nd7msGBxoq/mb9CwSr2vohm1QevdEcfpd9CRPOU5RSF924Xxua93EcpSzOsvkZDE
         0v0IQpSH/giLgsynDO/PqqyPOq+tqJiIZO8w7ZrmScMpqdTsk9Bao39bbuSJFNVzMh8E
         McHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704711812; x=1705316612;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wov7S+c4eP3tA/GZq5tzz01wP3CYZQxPahNS7M7qNc=;
        b=NvQ9kkKjqYBzahVOr7aJtBfCjM3jkzOhNFA4RXs2km4ZHmtQHRiWdEJ2oJAr0hjGJL
         YmVllmfOCeptv+8Nx7EFg1d/6r4njV8CGagD4v2qmSHDph3hsRD9SBpcJcR5f/sU1rnj
         1OVoRJLPwtwmTVeIbJ2dkVcIvJHm8JcO0PXiuxPmP1bXYpRYantaa17J5/q2XSvQyXsq
         tM0gq7XPoxAu9JrwXzmMv83EkSzbtmUhlIP2jD9kocFfj0ECLG5v3QoaUk2dkfGlpX/+
         7m0i69/w8/4A0j9EKfCqQKXvqUf0a6t7zWZc3xr+U447JvAF1XuYkOP4uwkOHTEqQUT2
         7o+w==
X-Gm-Message-State: AOJu0YzjkYXC3d7+gWaH7oILGdPuSq23eJ7rJdtFRoQnz1pL8RYSga9g
	noOSxPtmbhSetkfCkrg6c2M=
X-Google-Smtp-Source: AGHT+IFi8eDoTveBUHW6MozVPRwFM6NpnZSq4KpmHCz4D3CVm9qkLzjaBRZYYfi1bbG7pegdmwlfhg==
X-Received: by 2002:a17:907:268a:b0:a28:abb3:dd74 with SMTP id bn10-20020a170907268a00b00a28abb3dd74mr1751694ejc.81.1704711812382;
        Mon, 08 Jan 2024 03:03:32 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id ch16-20020a170906c2d000b00a2afe82f651sm204827ejb.12.2024.01.08.03.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:03:31 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 12:03:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: [GIT PULL] x86/asm changes for v6.8
Message-ID: <ZZvWgXCxrBcVwFco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/asm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2024-01-08

   # HEAD: bc90aefa99f74452d549d503a3f1cbf3adc9c6bb x86/asm: Add DB flag to 32-bit percpu GDT entry

x86/asm changes for v6.8:

 - Replace magic numbers in GDT descriptor definitions & handling:

   - Introduce symbolic names via macros for descriptor types/fields/flags,
     and then use these symbolic names.

   - Clean up definitions a bit, such as GDT_ENTRY_INIT()

   - Fix/clean up details that became visibly inconsistent after the
     symbol-based code was introduced:

      - Unify accessed flag handling

      - Set the D/B size flag consistently & according to the HW specification

 Thanks,

	Ingo

------------------>
Vegard Nossum (5):
      x86/asm: Provide new infrastructure for GDT descriptors
      x86/asm: Replace magic numbers in GDT descriptors, preparations
      x86/asm: Replace magic numbers in GDT descriptors, script-generated change
      x86/asm: Always set A (accessed) flag in GDT descriptors
      x86/asm: Add DB flag to 32-bit percpu GDT entry


 arch/x86/boot/pm.c                      |  7 +--
 arch/x86/include/asm/desc_defs.h        | 78 +++++++++++++++++++++++++++------
 arch/x86/kernel/apm_32.c                |  2 +-
 arch/x86/kernel/cpu/common.c            | 48 +++++++++-----------
 arch/x86/kernel/head64.c                |  6 +--
 arch/x86/kernel/setup_percpu.c          |  4 +-
 arch/x86/platform/pvh/head.S            |  7 +--
 arch/x86/realmode/rm/reboot.S           |  3 +-
 drivers/firmware/efi/libstub/x86-5lvl.c |  4 +-
 drivers/pnp/pnpbios/bioscalls.c         |  2 +-
 10 files changed, 104 insertions(+), 57 deletions(-)

