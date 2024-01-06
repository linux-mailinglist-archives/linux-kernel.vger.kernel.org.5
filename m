Return-Path: <linux-kernel+bounces-18566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8A0825F73
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C48EB217A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8534A6FC5;
	Sat,  6 Jan 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ipq0Ao+I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F56FAE;
	Sat,  6 Jan 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6F57E40E01BB;
	Sat,  6 Jan 2024 12:19:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M2KYUmljKwYP; Sat,  6 Jan 2024 12:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704543562; bh=WuofjL+TlVJRuKZtEYcpXEUDIrlBp5v/Qqz5LXnIqAY=;
	h=Date:From:To:Cc:Subject:From;
	b=Ipq0Ao+ICb4PQUIZIaB2gcL+MSgipIYP6MRUgdNIltpfemA/FEiwvhwuqZFPYdljh
	 KaZOVTym6PgkGBMATDO5sraU/2BAUt4R7GnuGcctphAvsmLdl0qlVu2c3Kive4c2A/
	 V4S/W4kYWwKkY/VqnoJkNeNSAKuxKvT87CQapbrE5MBL0p2f/XVxfsQWy+Ui7KlFRA
	 ymK1SmQJa/D4pR7SfDUdU9bGNIGKZsabL2CKumY9gM0IxVVGGFgiFjYAIf+rMZJgF2
	 1ZiGSUmJ8pUF2cmq9ej8KYLnZi9dtZ/Dm+pQDCpW9ax/eL4C4pVoh7JW9a+AjDQkKr
	 qJ36D9PcXIikybXn6BVd+L8WITlvJL06nyuO+jVACw6egei5+A/e+7wI9bCFEjnlmG
	 zoNKw/aHg9RcEbfaSwn/pXFy3J5FLNUukUM7AZ+YQT/I8FJvAn9K0KQTWs+H16SWRZ
	 8WQJVBYQrXqUvTnCxgHf0V6Ul2oHqLCqbQQpCYuKq8upXAvmveqHN+xccy1V1c7uVd
	 SpmlhNXp45kfW+53Z3o/Yhcg7gTOLYW0bhpLrBjxupJdwJV6fiv3ENaMw1bVvHdDIV
	 Ex6qnX1sLMPdEIzoyqtVQyzZHDDXGn/Xu2tkEXBjkbdzAI9Do6t5ZkJDwgmocG2sbE
	 q8wohuElNHEP1G5uCVsbESLo=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 855CC40E01B2;
	Sat,  6 Jan 2024 12:19:19 +0000 (UTC)
Date: Sat, 6 Jan 2024 13:19:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-edac <linux-edac@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.8
Message-ID: <20240106121912.GAZZlFQJdtoGzRxIiE@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

please pull the pile of EDAC updates for 6.8.

Thx.

---

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b22=
63:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_upd=
ates_for_v6.8

for you to fetch changes up to 1e92af09fab1b5589f3a7ae68109e3c6a5ca6c6e:

  EDAC/skx_common: Filter out the invalid address (2024-01-02 09:20:08 -0=
800)

----------------------------------------------------------------
- The EDAC drivers part of the effort to make the ->remove() platform
  driver callback return void

- Add support for AMD AI accelerators

- Add support for a number of Intel SoCs: Alder Lake-N, Raptor Lake-P,
  Meteor Lake-{P,PS}

- Random fixes and cleanups all over the place

----------------------------------------------------------------
Abhinav Singh (1):
      EDAC/{sb,i7core}_edac: Do not use a plain integer for a NULL pointe=
r

Andy Shevchenko (4):
      EDAC, pnd2: Replace custom definition by one from sizes.h
      EDAC, pnd2: Apply bit macros and helpers where it makes sense
      EDAC, pnd2: Correct misleading error message in mk_region_mask()
      EDAC, pnd2: Sort headers alphabetically

Arnd Bergmann (1):
      EDAC/thunderx: Fix possible out-of-bounds string access

Ilpo J=C3=A4rvinen (1):
      EDAC/pci_sysfs: Use PCI_HEADER_TYPE_MASK instead of literals

Muralidhara M K (2):
      EDAC/mc: Add support for HBM3 memory type
      EDAC/amd64: Add support for family 0x19, models 0x90-9f devices

Qiuxu Zhuo (6):
      EDAC/igen6: Make get_mchbar() helper function
      EDAC/igen6: Add Intel Alder Lake-N SoCs support
      EDAC/igen6: Add Intel Raptor Lake-P SoCs support
      EDAC/igen6: Add Intel Meteor Lake-PS SoCs support
      EDAC/igen6: Add Intel Meteor Lake-P SoCs support
      EDAC/skx_common: Filter out the invalid address

Rob Herring (2):
      EDAC/altera: Use device_get_match_data()
      EDAC/armada_xp: Explicitly include correct DT includes

Uwe Kleine-K=C3=B6nig (22):
      EDAC/altera: Convert to platform remove callback returning void
      EDAC/armada_xp: Convert to platform remove callback returning void
      EDAC/aspeed: Convert to platform remove callback returning void
      EDAC/bluefield: Convert to platform remove callback returning void
      EDAC/cell: Convert to platform remove callback returning void
      EDAC/cpc925: Convert to platform remove callback returning void
      EDAC/dmc520: Convert to platform remove callback returning void
      EDAC/highbank_l2: Convert to platform remove callback returning voi=
d
      EDAC/highbank_mc: Convert to platform remove callback returning voi=
d
      EDAC/mpc85xx: Convert to platform remove callback returning void
      EDAC/npcm: Convert to platform remove callback returning void
      EDAC/octeon-l2c: Convert to platform remove callback returning void
      EDAC/octeon-lmc: Convert to platform remove callback returning void
      EDAC/octeon-pc: Convert to platform remove callback returning void
      EDAC/octeon-pci: Convert to platform remove callback returning void
      EDAC/ppc4xx: Convert to platform remove callback returning void
      EDAC/qcom: Convert to platform remove callback returning void
      EDAC/synopsys: Convert to platform remove callback returning void
      EDAC/ti: Convert to platform remove callback returning void
      EDAC/xgene: Convert to platform remove callback returning void
      EDAC/zynqmp: Convert to platform remove callback returning void
      EDAC/fsl_ddr: Convert to platform remove callback returning void

 drivers/edac/altera_edac.c      |  21 ++---
 drivers/edac/amd64_edac.c       |  66 ++++++++++----
 drivers/edac/amd64_edac.h       |   1 +
 drivers/edac/armada_xp_edac.c   |  16 ++--
 drivers/edac/aspeed_edac.c      |   6 +-
 drivers/edac/bluefield_edac.c   |   6 +-
 drivers/edac/cell_edac.c        |   5 +-
 drivers/edac/cpc925_edac.c      |   6 +-
 drivers/edac/dmc520_edac.c      |   6 +-
 drivers/edac/edac_mc.c          |   1 +
 drivers/edac/edac_pci_sysfs.c   |   4 +-
 drivers/edac/fsl_ddr_edac.c     |   3 +-
 drivers/edac/fsl_ddr_edac.h     |   2 +-
 drivers/edac/highbank_l2_edac.c |   5 +-
 drivers/edac/highbank_mc_edac.c |   5 +-
 drivers/edac/i7core_edac.c      |   4 +-
 drivers/edac/igen6_edac.c       | 194 ++++++++++++++++++++++++++++++++++=
++----
 drivers/edac/layerscape_edac.c  |   2 +-
 drivers/edac/mpc85xx_edac.c     |  13 ++-
 drivers/edac/npcm_edac.c        |   6 +-
 drivers/edac/octeon_edac-l2c.c  |   6 +-
 drivers/edac/octeon_edac-lmc.c  |   5 +-
 drivers/edac/octeon_edac-pc.c   |   5 +-
 drivers/edac/octeon_edac-pci.c  |   6 +-
 drivers/edac/pnd2_edac.c        |  55 ++++++------
 drivers/edac/ppc4xx_edac.c      |   7 +-
 drivers/edac/qcom_edac.c        |   6 +-
 drivers/edac/sb_edac.c          |  10 +--
 drivers/edac/skx_common.c       |   4 +
 drivers/edac/synopsys_edac.c    |   6 +-
 drivers/edac/thunderx_edac.c    |  10 +--
 drivers/edac/ti_edac.c          |   6 +-
 drivers/edac/xgene_edac.c       |   6 +-
 drivers/edac/zynqmp_edac.c      |   6 +-
 include/linux/edac.h            |   3 +
 35 files changed, 331 insertions(+), 182 deletions(-)


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

