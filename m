Return-Path: <linux-kernel+bounces-19358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B703826BDE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379FF1F2228A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016C1427E;
	Mon,  8 Jan 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLBzwdO3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5503714008
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d8902da73so15528075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 02:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704711071; x=1705315871; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AechreWHgGzJn6b1I80zikyMF1nx9/fCB7ZjxXTdQGA=;
        b=jLBzwdO3ie2Ngep8HKQnB6FiGpy7ZBjVPF5E+0Z+EozukXfY30PsN+d83vS9E38vDP
         jTleYt5UM6CkB8VggKpFbIXjZ9Y4hFoOVHA24WtTTtOEGQAfvdYJdpLAM/5rBBjDFmK3
         ZEBQUSUNZl1brE+1fgZBPtyQUNFh/WkXdbXBEi3M31WgQgBo5jYmyx7/LgEua2HHUzKo
         VLkCdYlKupq+4Ehq3ehmM3kTtxneoAIl8AfeANB3A4zwazLQnCpP18DDTXlCY9x1NpFe
         6PzrTK2q+/9Vg2w9BAakKLx/8JmD1T/t74PzHQx77eT9vNaB2IBMTDeKEpaISwY23Kcy
         xFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704711071; x=1705315871;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AechreWHgGzJn6b1I80zikyMF1nx9/fCB7ZjxXTdQGA=;
        b=MX82q2Wca26bR34OSoAIZR8SdQPmyC4HtQFwgnIlDgdW34hQfLlL/y9QAyic4ISIGT
         o9/B07Zbg2V/nHTBS+urh6i9WEN0eXBuBhcRI+dYm9wdv3sEUijbSM/k/jQcnWDgS65V
         zZBNtEUDuu/npumEkbFlYaSBKbvjQDUapqPoVpJACRfz3rQr3DUz3/AnTMI8rN6E5Zch
         IpiRa/Phbisrv2jGk/wJHF22MohFmUjyNGOQawvpNK5LuhvkDCowdiDmNc8qdhKjSmHi
         ufpbc/1bsVSLC88u7jN5nJYDA+H7ylZ5W/1G+7nu+eS5xhPxmIbkmrXKrZu4ZcgQGGzX
         W5Tw==
X-Gm-Message-State: AOJu0YyZSCIriRhGid1gshF4mwn7X6rOvHxhCfQMK3Yg0aYts6CVzfhL
	rNmy+kbnrXmsp5lh0oT34h9bTPzJLqY=
X-Google-Smtp-Source: AGHT+IHUwF603iPc/Q/rGxgs6aJ0Z/x3+XE8nS5Wdd7AVk2coeoFzwFoI0mxQpeTQWgLLqr8nZIVjQ==
X-Received: by 2002:a05:600c:3b9d:b0:40d:77d9:8d80 with SMTP id n29-20020a05600c3b9d00b0040d77d98d80mr2026337wms.44.1704711071318;
        Mon, 08 Jan 2024 02:51:11 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id b6-20020adff906000000b003375d8b0460sm5887506wrr.1.2024.01.08.02.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 02:51:10 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 11:51:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [GIT PULL] x86/apic changes for v6.8
Message-ID: <ZZvTnQPx2C1NcFd7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/apic git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2024-01-08

   # HEAD: 5e1c8a47fc6ec6251ddd126f4245279fc072f1c0 x86/ioapic: Remove unfinished sentence from comment

x86/apic changes for v6.8:

 - Clean up 'struct apic':

    - Drop ::delivery_mode
    - Drop 'enum apic_delivery_modes'
    - Drop 'struct local_apic'

 - Fix comments

 Thanks,

	Ingo

------------------>
Adrian Huang (1):
      x86/ioapic: Remove unfinished sentence from comment

Andrew Cooper (3):
      x86/apic: Drop apic::delivery_mode
      x86/apic: Drop enum apic_delivery_modes
      x86/apic: Drop struct local_apic


 arch/x86/include/asm/apic.h           |   2 -
 arch/x86/include/asm/apicdef.h        | 276 +---------------------------------
 arch/x86/kernel/apic/apic_flat_64.c   |   2 -
 arch/x86/kernel/apic/apic_noop.c      |   1 -
 arch/x86/kernel/apic/apic_numachip.c  |   2 -
 arch/x86/kernel/apic/bigsmp_32.c      |   1 -
 arch/x86/kernel/apic/io_apic.c        |   2 +-
 arch/x86/kernel/apic/probe_32.c       |   1 -
 arch/x86/kernel/apic/x2apic_cluster.c |   1 -
 arch/x86/kernel/apic/x2apic_phys.c    |   1 -
 arch/x86/kernel/apic/x2apic_uv_x.c    |   1 -
 arch/x86/platform/uv/uv_irq.c         |   2 +-
 drivers/iommu/amd/iommu.c             |   4 +-
 drivers/iommu/intel/irq_remapping.c   |   2 +-
 drivers/pci/controller/pci-hyperv.c   |   7 -
 15 files changed, 12 insertions(+), 293 deletions(-)

