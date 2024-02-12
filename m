Return-Path: <linux-kernel+bounces-62302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C5E851E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1609281F66
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E6647F46;
	Mon, 12 Feb 2024 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="C11Iw4bH"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783A47A70
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768268; cv=none; b=Lfi7PmyAXNOF7nwc0ri0v7XngaoJ6t9sxMz/7yKKpXuMc4bdxVjJh13akkOB7nyPPxfVyDqFXLs6qKuJh6e/8URtJFxDXNaqLUa8sksq7c0Iy11RHoROVj0JtF7H/zVqmN5tuUOmzOKu78DiymczMCgJKPlpWcXaCos2weUU9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768268; c=relaxed/simple;
	bh=46m5kgpYafsjbmkgwgaR3UEdg9F5o1nC2dyStdDKowI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uT+/W//PNgWbjaCwuWnjH0UBGt4Psi9qDlhCv7zE2dHXDRlE6hHZFi0UZaF7grtAY+n/YV42hQ9SLCqQ9iGMfxPRRYBplkvkNr0fUTAeIEo4MYDQ3ThYaNTgJFbHg9KBq7QKgvFmtTdjOFUJ6Vih8ms1efPqe0qumpaqdOVXYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=C11Iw4bH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2861860a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:04:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707768266; x=1708373066;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oHyBDS7WaykcBxou7weKIofyX0CqedvQH5iZaXyJUSI=;
        b=uM/y1y74OOYXOSzPa5GJigHSFeD7IkWXJk75HfBGiDs7uhDh/3mhmFXbbvJwBwBuoA
         HnXugnBnD8jP+h8T5PpEPIzBjfVg0dHvIrj8og03UIr8p8UkSKRq015vinrWeeGlZDCR
         ZMfm9S++PuPDN8ZEi/oUdCTvNpvRmmfmPO9riiM8pk6NlwpKldEPeSmsbF3hH5M41eIw
         E8M/T+Zyg50vTVkiwGAMQ/yUwGSd8WZJ94ye5ZYkIPN41+zafwXD1UBMvg/PpudOiHLR
         Tc72yK5Fv03wi4pV6JBuTSmpriSX1UCB+AJPR6/AiFlOCyCHF5N7f05olz1QwTHAkQe9
         MkhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1nEG1WwBeWuGIqe+X+zwLIxPGrpAFzinZpfTyWWYD0EL17X8xcfwvHHF24iftYFxpuM3tbdc6IvmUNBzx428ATGiAno7y3xmHbzKj
X-Gm-Message-State: AOJu0YyGap/0udTOTJyQ3jLVBnu+hzKAMkpHGcxgX9jYKRyyQWRJ7nBi
	UhAoD/4OLy1YzdAhmHBdMn5gvDjdat3dbRWq5KSxzbTGlDCZrSSx
X-Google-Smtp-Source: AGHT+IEMGnpxGT56LrXgCFndTnvCesBsLlgnBQKvMecarsRHN8zHvIvLfxyta8lDj4PhdImTon3wBw==
X-Received: by 2002:a17:90a:348d:b0:296:1bf4:e797 with SMTP id p13-20020a17090a348d00b002961bf4e797mr5843091pjb.39.1707768266250;
        Mon, 12 Feb 2024 12:04:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXedhrpGpeN/mZtKPE3iUbsChTf1bVigu3+DpaD6WA1ZRSMHipyEPQETX+Lv3vb7jJTFxad2niSeQ0nFqmkqb1V6Wdu7sSePH/lfNh70NjSKNo1UmzG6x4+UuBYaktj9f/fsDdGeAWlUoniKT2TpmdQMMIucI6BHWDFDtkrFx3ygS9fIWUyDgzKIkGMxTp2Ec/7BeAXhUyjdzBQocBe8QhMsIKm3orsx12oMvDGqy9A6KlVAwQGycr8f7S3LY08eGrt9G9YONShmzflbA/T
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id mr1-20020a17090b238100b00296bb0b2f57sm938628pjb.21.2024.02.12.12.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:04:25 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707768264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oHyBDS7WaykcBxou7weKIofyX0CqedvQH5iZaXyJUSI=;
	b=C11Iw4bHxhH3M1/VOZDftgEoILCd3GlmfqDD6dN8rYyZx2g2Sp+nSDeKFmFz+xeRSoZTMC
	o/esB8Z/s3cn9XVMaNMOzligTd4fszB7Tk0VPT5NkYWopLDiBlS5yp96lfg3w/kPDmV8rj
	rgDZBJmItUwmszZhwSIHvK5LNoiH4/QxP5lDv9nFqYRRAe1fRJlLLpbapf+ag4J6ZFEZD6
	a5M1V7Jom6t/8mgk2K1gMkp7h/+a6mtKccz/SbvRndbTpm1r4HFIi8XAcNHozQgCH/b/KN
	wjOTK3j4l7hDKU9zGK99eV9tAI1BvoT3ilGaB3EKB6HKlWWEIKAQMuH8yBSj2A==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH v2 0/5] powerpc: struct bus_type cleanup
Date: Mon, 12 Feb 2024 17:04:58 -0300
Message-Id: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOp5ymUC/4WNQQ6CMBBFr0JmbU1pEKkr72GIacsgk2DbTAE1h
 LtbuYDL95L//goJmTDBpViBcaFEwWdQhwLcYPwDBXWZQUlVSSW1sHO6uxGNn6OI4YUcnRKVbip
 V985Z3UCeRsae3nv21mYeKE2BP/vLUv7sn+BSCinO2pzqzhm0trw+DY+EjEePE7Tbtn0BD9AKR
 7sAAAA=
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=46m5kgpYafsjbmkgwgaR3UEdg9F5o1nC2dyStdDKowI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlynnuMoCq0skqVLkNyeXmP6y8brBEXCdxD+d4j
 tgdu4ncXBKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcp57gAKCRDJC4p8Y4ZY
 poMsD/0RvTTqHv+De6ldjUB5U9FVw9LSQpxhixM4+Vea1K/AUn/X06Slrqk2KGuB4t0hNee8q3+
 CMCyqcE2Ggdf618CxQ0Dl04JBWol8rgcOuFCv5xnnwOFlBT173GjFuph2qS900Q2SBPK7fmDSec
 PaJOmu7VZ8n8rGzUrdc0sHTwjeOyqHxrCTGdn7yU7aCtHn2IrxTr/9Zj/TMxWeRRU5p8a8Kjw0n
 D6NmhGLwHfiO02H+hZW/uoUmD4jixo6aSQp8RPi12nbO3oWIhCK+CASr+SuhfRIg7cou3QWwT1s
 rCVKOeHT2alFnwWWxlgv/XkpMR4eixScTnzR2a4joKjAOPEzOdmWNujmfXX4hUswjGbapkjSAIl
 wIqGSwcTYUUeLFP7kW4YeieDJ3Q9YUCBHlNZhYQ8M8Y1NSINCbrI5liJdt0bf9gaNCgCbFtlo5h
 9L6C1h6idOImKJ1I+HXKM1H3mIiprbc9tkBSvBSoyIZjzZhFQCyqfLb/mR0Ns0Uar8UrPysS5SW
 RIffqFjxOCAD5xiU8ldo3hl3ycstEVZjm7BRUi4c4s9kSSaidl4c+KObiMQABynvvcyeEzJ5p4B
 xOv3MBK0yzo8iUV59ZtVpoXd5IVbGP9/e+GC8YlUMK1FAVbsgprDLUtuS1CjQdkXSlH0lRx3rkq
 QRUy+o6OPIZ9WSw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]). Patch 1/5 is a prerequisite to 2/5, but the others have
no dependency. They were built using bootlin's without warnings using
powerpc64le-power8--glibc--stable-2023.11-1 toolchain.

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Changes in v2:
- Added a new patch to make macio_bus_type const.
- Improved changelogs to remove the word "Now".
- Fixed a build error: https://lore.kernel.org/oe-kbuild-all/202402102142.uphiKeqw-lkp@intel.com/
- Link to v1: https://lore.kernel.org/r/20240209-bus_cleanup-powerpc2-v1-0-79a56dcaebb1@marliere.net

---
Ricardo B. Marliere (5):
      powerpc: vio: move device attributes into a new ifdef
      powerpc: vio: make vio_bus_type const
      powerpc: mpic: make mpic_subsys const
      powerpc: pmac: make macio_bus_type const
      powerpc: ibmebus: make ibmebus_bus_type const

 arch/powerpc/include/asm/ibmebus.h       |  2 +-
 arch/powerpc/include/asm/macio.h         |  2 +-
 arch/powerpc/include/asm/mpic.h          |  2 +-
 arch/powerpc/include/asm/vio.h           |  2 +-
 arch/powerpc/platforms/pseries/ibmebus.c |  4 +--
 arch/powerpc/platforms/pseries/vio.c     | 61 ++++++++++++++++++--------------
 arch/powerpc/sysdev/mpic.c               |  2 +-
 drivers/macintosh/macio_asic.c           |  2 +-
 8 files changed, 43 insertions(+), 34 deletions(-)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240209-bus_cleanup-powerpc2-498426fccb98

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


