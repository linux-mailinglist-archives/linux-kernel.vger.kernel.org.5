Return-Path: <linux-kernel+bounces-109816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E82E88560A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99AC91C2119B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BE62C6BB;
	Thu, 21 Mar 2024 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="erGSs0tJ"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F91B274
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011057; cv=none; b=M48Up6wJkYsrQnrIMXKefInOgDVoei5ObNdRiQ2lmgK/tHRhGMKSeapgLGUWsaCsoXUAFLURcZM4dagjG3Nk8tZZ11FqPGH6c4TyjXRRC2omr7Q8tGcinnMT2jMufPQHkdWkIshk8cOCku0dLRMWOBFYcf4s0h8pRQ5GrKk2VHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011057; c=relaxed/simple;
	bh=T9tH2WkqXIqAB3/EZYidnvaVwq80SxS0zPzjIGHGoVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fl46pIg1s0lKN8O98glcbJRf31UD1z50uMWiibUEy9kG4YLRuFXEHMUCqmDrUZqlVWz0pRYvPy2eszLj50bOKAGTmHT0Nw+8AXmCfw1tOIMxdNO5I0A4ojV4K62SDzdOXjIANmYq/AxsikHev3d54wvds41/zo82K6dJsKe0ebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=erGSs0tJ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c390030af2so524004b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711011055; x=1711615855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPjyd+yjOktFr1xsuYU5FVU17C6f3y//ZruUY/LClBQ=;
        b=erGSs0tJtIB4NsS/lHDe7kUu3PS4rU3nRiW774UpuNFH6IGIcg6xQd/s90abKDVCCb
         xrxvmb7ME5IOC80b99A6Mzuelp9TyKK5lRYSLjZ/1e7RUvOX4w/OAkNGWuWKbJOWW/eq
         9OsC+Q5MIegQRUg5oLbWbGSH2Z5ZE0fNtTuMxyoL3hDmJVgsL7rCEZpEEkn30sEKka14
         tE6nPma/Vd5gVmyMOo2WEf+YhuZHm4U94F8CgnXYbgVuBxOF2zjRrbsLDYWCWLa1Ge2y
         Ey4PjwAGN9NlgdfJ8JujBqAFRtzfm3BZxlOryC8zrFx2jldjXkUgqWk68FgtRIyycBXZ
         acQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711011055; x=1711615855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPjyd+yjOktFr1xsuYU5FVU17C6f3y//ZruUY/LClBQ=;
        b=roQWVNPHpuC33xFnrfOl+fK8oGKQa8x2fsXjmpbPU06wupiNY14a4kpPNXez2ZTjFt
         W/Jx4Ur0T0dJgTQrVBr6/pYvrjPRHqnglodaWh899D3y8JxAdIkgFDh57JxBMPFlyI7w
         rPxuZhWUp6Ut8MqKSpEaiaMMpcdwMjd13YEeC5Z0L54kLnTu4ShJq9fTXlp7hrQKAAYG
         xq2bFPfZIo2LULAqXcMid1VM9O7GvWQ3fas/n9zzIGWJKRsTU+H5TzGwEzoCbSgOGcpw
         mewrK+BROpwKlSDh5A18vRt1Ay5gcxpaRVhivGDtoYkyKUAch+iTdprhCHytvX8jSKIh
         bMCw==
X-Forwarded-Encrypted: i=1; AJvYcCWDx+r/9I2aSRbuKRuZma9OBhiVPnpkK4lAi0lK3MRZLTPKvun1OMwIbczFPV248Sc203ycB2mrk5dgiNaxov6FsDKEf+jnuxzDhKt8
X-Gm-Message-State: AOJu0Yw9FN/mmqwKup6zTjO8/afXhhAlynXPi0lYQvr5o+kOn9jLCxrr
	H9lTs9nH+uOiTWRI2VXFoA+cz+90Kwmo3r+NR9itQd37Aor2/tTjd1wmNyFGDRo=
X-Google-Smtp-Source: AGHT+IEvqwLm9D/zQrn6jO0supoJFFZJFv0l42kjY6Gp2Frdf15Yh9kjKVuHL7HqdWGlqp+r164FJg==
X-Received: by 2002:a05:6808:1a28:b0:3c3:896f:8817 with SMTP id bk40-20020a0568081a2800b003c3896f8817mr5503819oib.2.1711011055018;
        Thu, 21 Mar 2024 01:50:55 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id x3-20020a544003000000b003c3753dd869sm2275409oie.58.2024.03.21.01.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 01:50:54 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Atish Patra <atishp@atishpatra.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/2] KVM RISC-V APLIC fixes
Date: Thu, 21 Mar 2024 14:20:39 +0530
Message-Id: <20240321085041.1955293-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Few fixes for KVM RISC-V in-kernel APLIC emulation which were discovered
during Linux AIA driver patch reviews.

These patches can also be found in the riscv_kvm_aplic_fixes_v1
branch at: https://github.com/avpatel/linux.git

Anup Patel (2):
  RISC-V: KVM: Fix APLIC setipnum_le/be write emulation
  RISC-V: KVM: Fix APLIC in_clrip[x] read emulation

 arch/riscv/kvm/aia_aplic.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

-- 
2.34.1


