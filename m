Return-Path: <linux-kernel+bounces-33097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF09836474
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769D81C22435
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B313D0C0;
	Mon, 22 Jan 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Raor0MWw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q8TzPILh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2B3CF57;
	Mon, 22 Jan 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930121; cv=none; b=AGGR+Ht7cYlfLO9x3BzCuBlsdQiP5ncEhgJ1Y22Ix3pY9If8qpuas7YtwuxAo18IZ9KMNbaVrzd7fE0EDhOKijF977h++l65LkQ85udttMAtxy7s9x4QeRakFe6xLR7dJyZ39HnGbQ7bA0Uj2aV3ZdLX2W/fykC2pv5Zi8gyyrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930121; c=relaxed/simple;
	bh=KD9CzXDI3FSpEchHjIpMd6dRa37p1zEkYPrCD6KgGOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rEStQrC7Z9rI1bVD4KcwBx/D3Ibru33gkzdWDs3L4UmVZByBsgjpTiS0Fpvm3Et4RXh0JHry/bODDcFm0ISxot0Wdp4hELpY+VnJ4VGVf/NBorohoSL1+Ibp2CEPUrQgB9OGRnU26kr+GxJBstUIflIxeSAHvZK+l6OfqkvpNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Raor0MWw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q8TzPILh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705930118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uKZCnmT0rQ7xvCextkDvrtIUvMCCC3PPe7T7/Wyualk=;
	b=Raor0MWwk1oF1SxQ7Ze8VNww2sdo/sPpop0PCrLNm2ls02Ioq0GJW6O+i/E1B+Zqwp0IIL
	O5BJPhKiCyfmXIrWDnAYqCiVypvpei5kMDFuEP4EB5odb3IoiWv6o+h5kKGxjllOdwGs1j
	4pyM764bjLDuC1+LaLcr0pQlsxxU3rS3WSUi9JYjQfeLXmOkafzXh1gL9WU1J6rtPiJkss
	Mm+jcCtBP3vtS6UOOBQv0WHV+JMQRi0xCEiduOWw7nkyrxqlVYHkpr99iAKAGRVU7TlgHp
	WplPkTMYrUz3dSt3wA/wQVWhLV4OsGJaob2LsvTUG8PjlSmHeQWmAK7bMrlLVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705930118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uKZCnmT0rQ7xvCextkDvrtIUvMCCC3PPe7T7/Wyualk=;
	b=q8TzPILh4eJvE7QAeIHvk96RAVdnuUUBDtMZ11+lHqDQxwHvsd24EbagSL8sK2DZ8tPQUr
	vczrSi1+FGylKKCg==
To: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Dipen Patel <dipenp@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 0/2] kernel-doc: Remove deprecated kernel-doc option 'functions'
Date: Mon, 22 Jan 2024 14:28:18 +0100
Message-Id: <20240122132820.46633-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

the kernel-doc option 'functions' is marked deprecated and is simply an
alias for 'identifiers' and the conversion didn't looked that bad. So the
first patch replaces all existing users of 'functions' and the second
removes all parts in documentation and also inside the scripts.

Thanks,

	Anna-Maria



Anna-Maria Behnsen (2):
  Documentation: Replace deprecated 'functions' by 'identifiers'
  Documentation: Remove deprecated kernel-doc option 'functions'

 Documentation/PCI/pci.rst                     |  4 +-
 Documentation/arch/x86/sgx.rst                | 16 ++---
 Documentation/core-api/boot-time-mm.rst       |  2 +-
 Documentation/core-api/debug-objects.rst      | 14 ++--
 Documentation/core-api/genalloc.rst           | 34 +++++-----
 Documentation/core-api/generic-radix-tree.rst |  2 +-
 .../core-api/gfp_mask-from-fs-io.rst          |  4 +-
 Documentation/core-api/idr.rst                |  4 +-
 Documentation/core-api/kernel-api.rst         | 12 ++--
 Documentation/core-api/mm-api.rst             |  6 +-
 Documentation/core-api/printk-basics.rst      |  4 +-
 Documentation/crypto/api-aead.rst             |  6 +-
 Documentation/crypto/api-akcipher.rst         |  6 +-
 Documentation/crypto/api-digest.rst           |  8 +--
 Documentation/crypto/api-kpp.rst              | 10 +--
 Documentation/crypto/api-rng.rst              |  4 +-
 Documentation/crypto/api-skcipher.rst         |  8 +--
 Documentation/dev-tools/kcsan.rst             |  6 +-
 Documentation/dev-tools/kfence.rst            | 10 +--
 Documentation/dev-tools/kselftest.rst         | 16 ++---
 Documentation/doc-guide/kernel-doc.rst        |  3 -
 Documentation/driver-api/80211/cfg80211.rst   | 16 ++---
 .../driver-api/80211/mac80211-advanced.rst    | 26 ++++----
 Documentation/driver-api/80211/mac80211.rst   | 12 ++--
 Documentation/driver-api/device_link.rst      |  2 +-
 .../firmware/fallback-mechanisms.rst          |  4 +-
 .../driver-api/firmware/other_interfaces.rst  | 10 +--
 .../driver-api/firmware/request_firmware.rst  | 14 ++--
 Documentation/driver-api/fpga/fpga-bridge.rst |  8 +--
 Documentation/driver-api/fpga/fpga-mgr.rst    | 18 +++---
 .../driver-api/fpga/fpga-programming.rst      |  8 +--
 Documentation/driver-api/fpga/fpga-region.rst | 22 +++----
 Documentation/driver-api/hte/hte.rst          |  4 +-
 Documentation/driver-api/i2c.rst              |  2 +-
 Documentation/driver-api/infiniband.rst       | 16 ++---
 Documentation/driver-api/mei/hdcp.rst         |  2 +-
 Documentation/driver-api/reset.rst            | 34 +++++-----
 Documentation/driver-api/spi.rst              |  2 +-
 Documentation/driver-api/usb/typec.rst        | 26 ++++----
 Documentation/driver-api/usb/typec_bus.rst    | 10 +--
 .../gpu/amdgpu/display/display-manager.rst    | 10 +--
 Documentation/gpu/drm-kms-helpers.rst         | 10 +--
 Documentation/gpu/i915.rst                    | 64 +++++++++----------
 Documentation/gpu/rfc/i915_scheduler.rst      |  2 +-
 Documentation/gpu/rfc/i915_small_bar.rst      |  4 +-
 Documentation/gpu/vga-switcheroo.rst          | 14 ++--
 Documentation/hid/hid-bpf.rst                 |  6 +-
 Documentation/mm/ksm.rst                      |  2 +-
 Documentation/security/tpm/tpm_vtpm_proxy.rst |  2 +-
 Documentation/sphinx/kerneldoc.py             |  5 --
 50 files changed, 263 insertions(+), 271 deletions(-)

-- 
2.39.2


