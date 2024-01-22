Return-Path: <linux-kernel+bounces-33099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3077836478
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6EE28992E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0BF3D54E;
	Mon, 22 Jan 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d0vrUis/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="96c7CAYf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48183CF73;
	Mon, 22 Jan 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930124; cv=none; b=HUcbKGdacP2llT4K0PA6sQs8PysRCK2lLBoFOddtq02HWfXPc1aOdiyTDKZ9kMV1vkfA284/BQFUDsLleaL2AMmIruQxbqkCT520wurGP+gTkjUj6eHCeY8AzTz/er6YFhfJLmyOX6HruEHK6w8GLrCcO+w9O9HNMFnxgYpPDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930124; c=relaxed/simple;
	bh=96csejVuBN+D+VPuJds55P1BcltaGRMtTmc14B8nNMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaQRKh6psm5c/aW2kxpa7e32NRqEjBk/PyZO72X/iCwrHGQKFAqL9EaT4AmJiabk6dS7tlfFuYWCuqDhZifmxGc2mQVq13Rn1DOqxhS6x/D3a/o/FaPI3yGGwUzGFQOSL/87cC6IayUJ2JDGaHzWvJeZRR4K+mWkLjX8zaLWkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d0vrUis/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=96c7CAYf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705930118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awuamTE42/074kTxugr/0GtzJDoRZWmqdXCI2kFZC+Y=;
	b=d0vrUis/CCx5e/VLQE8MpWHb2cVkxZnbZaDt3ZhRpbT0QUiYjv6TsjQFLxKpYoHi50iqby
	xyv03btqJ43zL+dielaVERzdFsT5i5qRr9E0ZbSMnoPTmNDppXBYkgr7xo7XKF8v5OxpEz
	0+odq2Px5H88nwvUSBoDSyb0DtDdrmhe/vb4VeFtNaOlMZCMRxFjNgQRYzH5k4fsthRXfp
	GPwsP1c85IAFogmK5M5tVveCaKXm+/HERl4zu69fuSPpPbfUlAPiAswcZmDJsXDUznmxi7
	ss2vxB9Al+4Bo58rRrXBilCoGLxUdhYMB2fWJ5nNVEXgiO+CFs64duwOncD3Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705930118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awuamTE42/074kTxugr/0GtzJDoRZWmqdXCI2kFZC+Y=;
	b=96c7CAYfR4KHwyToJZ3JLTvn82owbILqQt93daebGYdQp5GwSIB1/i9VDZuM2gkq/TnMGK
	PlfzyXqgW7BE7wDQ==
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
Subject: [PATCH 1/2] Documentation: Replace deprecated 'functions' by 'identifiers'
Date: Mon, 22 Jan 2024 14:28:19 +0100
Message-Id: <20240122132820.46633-2-anna-maria@linutronix.de>
In-Reply-To: <20240122132820.46633-1-anna-maria@linutronix.de>
References: <20240122132820.46633-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kernel-doc option 'functions' is deprecated and is only an alias for
'identifiers'. To make sure nobody will use this alias in the future and to be
able to remove the related parts in documentation and scripts, replace the
existing occurences by 'identifiers'. The replace was done using sed expression:

  's/:functions:/:identifiers:/g'.

Some files were revisited manually to fix indentation:
  Documentation/arch/x86/sgx.rst
  Documentation/core-api/kernel-api.rst
  Documentation/core-api/printk-basics.rst
  Documentation/dev-tools/kcsan.rst
  Documentation/dev-tools/kfence.rst
  Documentation/dev-tools/kselftest.rst
  Documentation/driver-api/infiniband.rst
  Documentation/driver-api/reset.rst
  Documentation/gpu/drm-kms-helpers.rst

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
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
 48 files changed, 263 insertions(+), 263 deletions(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index cced568d78e9..aa965621a594 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -79,13 +79,13 @@ initialization with a pointer to a structure describing the driver
 (``struct pci_driver``):
 
 .. kernel-doc:: include/linux/pci.h
-   :functions: pci_driver
+   :identifiers: pci_driver
 
 The ID table is an array of ``struct pci_device_id`` entries ending with an
 all-zero entry.  Definitions with static const are generally preferred.
 
 .. kernel-doc:: include/linux/mod_devicetable.h
-   :functions: pci_device_id
+   :identifiers: pci_device_id
 
 Most drivers only need ``PCI_DEVICE()`` or ``PCI_DEVICE_CLASS()`` to set up
 a pci_device_id table.
diff --git a/Documentation/arch/x86/sgx.rst b/Documentation/arch/x86/sgx.rst
index d90796adc2ec..b952d2a2bd01 100644
--- a/Documentation/arch/x86/sgx.rst
+++ b/Documentation/arch/x86/sgx.rst
@@ -95,10 +95,10 @@ access, special privileged instructions are then used to copy data into enclave
 pages and establish enclave page permissions.
 
 .. kernel-doc:: arch/x86/kernel/cpu/sgx/ioctl.c
-   :functions: sgx_ioc_enclave_create
-               sgx_ioc_enclave_add_pages
-               sgx_ioc_enclave_init
-               sgx_ioc_enclave_provision
+   :identifiers: sgx_ioc_enclave_create
+		 sgx_ioc_enclave_add_pages
+		 sgx_ioc_enclave_init
+		 sgx_ioc_enclave_provision
 
 Enclave runtime management
 --------------------------
@@ -111,9 +111,9 @@ regular page will be dynamically added to the enclave. The enclave is
 still required to run EACCEPT on the new page before it can be used.
 
 .. kernel-doc:: arch/x86/kernel/cpu/sgx/ioctl.c
-   :functions: sgx_ioc_enclave_restrict_permissions
-               sgx_ioc_enclave_modify_types
-               sgx_ioc_enclave_remove_pages
+   :identifiers: sgx_ioc_enclave_restrict_permissions
+		 sgx_ioc_enclave_modify_types
+		 sgx_ioc_enclave_remove_pages
 
 Enclave vDSO
 ------------
@@ -136,7 +136,7 @@ a signal and return the fault information directly to its caller.  This avoids
 the need to juggle signal handlers.
 
 .. kernel-doc:: arch/x86/include/uapi/asm/sgx.h
-   :functions: vdso_sgx_enter_enclave_t
+   :identifiers: vdso_sgx_enter_enclave_t
 
 ksgxd
 =====
diff --git a/Documentation/core-api/boot-time-mm.rst b/Documentation/core-api/boot-time-mm.rst
index e5ec9f1a563d..ac28dddc2239 100644
--- a/Documentation/core-api/boot-time-mm.rst
+++ b/Documentation/core-api/boot-time-mm.rst
@@ -38,4 +38,4 @@ really happens under the hood.
 
 .. kernel-doc:: include/linux/memblock.h
 .. kernel-doc:: mm/memblock.c
-   :functions:
+   :identifiers:
diff --git a/Documentation/core-api/debug-objects.rst b/Documentation/core-api/debug-objects.rst
index ac926fd55a64..ee7f948999d7 100644
--- a/Documentation/core-api/debug-objects.rst
+++ b/Documentation/core-api/debug-objects.rst
@@ -65,7 +65,7 @@ Debug functions
 ===============
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_init
+   :identifiers: debug_object_init
 
 This function is called whenever the initialization function of a real
 object is called.
@@ -88,7 +88,7 @@ calling code must use debug_object_init_on_stack() and remove the
 object before leaving the function which allocated it. See next section.
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_init_on_stack
+   :identifiers: debug_object_init_on_stack
 
 This function is called whenever the initialization function of a real
 object which resides on the stack is called.
@@ -112,7 +112,7 @@ calling debug_object_free() before the function which allocates the
 object returns. Otherwise we keep track of stale objects.
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_activate
+   :identifiers: debug_object_activate
 
 This function is called whenever the activation function of a real
 object is called.
@@ -137,7 +137,7 @@ tracker object is set to ODEBUG_STATE_ACTIVE.
 
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_deactivate
+   :identifiers: debug_object_deactivate
 
 This function is called whenever the deactivation function of a real
 object is called.
@@ -150,7 +150,7 @@ When the deactivation is legitimate, then the state of the associated
 tracker object is set to ODEBUG_STATE_INACTIVE.
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_destroy
+   :identifiers: debug_object_destroy
 
 This function is called to mark an object destroyed. This is useful to
 prevent the usage of invalid objects, which are still available in
@@ -169,7 +169,7 @@ When the destruction is legitimate, then the state of the associated
 tracker object is set to ODEBUG_STATE_DESTROYED.
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_free
+   :identifiers: debug_object_free
 
 This function is called before an object is freed.
 
@@ -186,7 +186,7 @@ usage of the object is detected by the other debug checks.
 
 
 .. kernel-doc:: lib/debugobjects.c
-   :functions: debug_object_assert_init
+   :identifiers: debug_object_assert_init
 
 This function is called to assert that an object has been initialized.
 
diff --git a/Documentation/core-api/genalloc.rst b/Documentation/core-api/genalloc.rst
index a5af2cbf58a5..0c77bfcba8f0 100644
--- a/Documentation/core-api/genalloc.rst
+++ b/Documentation/core-api/genalloc.rst
@@ -18,10 +18,10 @@ Code using this allocator should include <linux/genalloc.h>.  The action
 begins with the creation of a pool using one of:
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_create		
+   :identifiers: gen_pool_create
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: devm_gen_pool_create
+   :identifiers: devm_gen_pool_create
 
 A call to gen_pool_create() will create a pool.  The granularity of
 allocations is set with min_alloc_order; it is a log-base-2 number like
@@ -39,7 +39,7 @@ pool when the given device is destroyed.
 A pool is shut down with:
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_destroy
+   :identifiers: gen_pool_destroy
 
 It's worth noting that, if there are still allocations outstanding from the
 given pool, this function will take the rather extreme step of invoking
@@ -50,10 +50,10 @@ that state, so one of the first orders of business is usually to add memory
 to the pool.  That can be done with one of:
 
 .. kernel-doc:: include/linux/genalloc.h
-   :functions: gen_pool_add
+   :identifiers: gen_pool_add
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_add_owner
+   :identifiers: gen_pool_add_owner
 
 A call to gen_pool_add() will place the size bytes of memory
 starting at addr (in the kernel's virtual address space) into the given
@@ -66,13 +66,13 @@ The functions for allocating memory from the pool (and putting it back)
 are:
 
 .. kernel-doc:: include/linux/genalloc.h
-   :functions: gen_pool_alloc
+   :identifiers: gen_pool_alloc
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_dma_alloc
+   :identifiers: gen_pool_dma_alloc
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_free_owner
+   :identifiers: gen_pool_free_owner
 
 As one would expect, gen_pool_alloc() will allocate size< bytes
 from the given pool.  The gen_pool_dma_alloc() variant allocates
@@ -89,10 +89,10 @@ return.  If that sort of control is needed, the following functions will be
 of interest:
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_alloc_algo_owner
+   :identifiers: gen_pool_alloc_algo_owner
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_set_algo
+   :identifiers: gen_pool_set_algo
 
 Allocations with gen_pool_alloc_algo() specify an algorithm to be
 used to choose the memory to be allocated; the default algorithm can be set
@@ -123,22 +123,22 @@ above.  With luck, wider awareness of this module will help to prevent the
 writing of special-purpose memory allocators in the future.
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_virt_to_phys
+   :identifiers: gen_pool_virt_to_phys
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_for_each_chunk
+   :identifiers: gen_pool_for_each_chunk
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_has_addr
+   :identifiers: gen_pool_has_addr
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_avail
+   :identifiers: gen_pool_avail
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_size
+   :identifiers: gen_pool_size
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: gen_pool_get
+   :identifiers: gen_pool_get
 
 .. kernel-doc:: lib/genalloc.c
-   :functions: of_gen_pool_get
+   :identifiers: of_gen_pool_get
diff --git a/Documentation/core-api/generic-radix-tree.rst b/Documentation/core-api/generic-radix-tree.rst
index ed42839ae42f..22ccc3132d8e 100644
--- a/Documentation/core-api/generic-radix-tree.rst
+++ b/Documentation/core-api/generic-radix-tree.rst
@@ -9,4 +9,4 @@ generic radix tree functions
 ----------------------------
 
 .. kernel-doc:: include/linux/generic-radix-tree.h
-   :functions:
+   :identifiers:
diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
index e7c32a8de126..a41334607ab0 100644
--- a/Documentation/core-api/gfp_mask-from-fs-io.rst
+++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
@@ -36,9 +36,9 @@ scope will inherently drop __GFP_FS respectively __GFP_IO from the given
 mask so no memory allocation can recurse back in the FS/IO.
 
 .. kernel-doc:: include/linux/sched/mm.h
-   :functions: memalloc_nofs_save memalloc_nofs_restore
+   :identifiers: memalloc_nofs_save memalloc_nofs_restore
 .. kernel-doc:: include/linux/sched/mm.h
-   :functions: memalloc_noio_save memalloc_noio_restore
+   :identifiers: memalloc_noio_save memalloc_noio_restore
 
 FS/IO code then simply calls the appropriate save function before
 any critical section with respect to the reclaim is started - e.g.
diff --git a/Documentation/core-api/idr.rst b/Documentation/core-api/idr.rst
index 18d724867064..fba86fe8e502 100644
--- a/Documentation/core-api/idr.rst
+++ b/Documentation/core-api/idr.rst
@@ -79,6 +79,6 @@ Functions and structures
 ========================
 
 .. kernel-doc:: include/linux/idr.h
-   :functions:
+   :identifiers:
 .. kernel-doc:: lib/idr.c
-   :functions:
+   :identifiers:
diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index ae92a2571388..14c198779a18 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -25,7 +25,7 @@ String Conversions
    :export:
 
 .. kernel-doc:: include/linux/kstrtox.h
-   :functions: kstrtol kstrtoul
+   :identifiers: kstrtol kstrtoul
 
 .. kernel-doc:: lib/kstrtox.c
    :export:
@@ -46,8 +46,8 @@ String Manipulation
    :internal:
 
 .. kernel-doc:: mm/util.c
-   :functions: kstrdup kstrdup_const kstrndup kmemdup kmemdup_nul memdup_user
-               vmemdup_user strndup_user memdup_user_nul
+   :identifiers: kstrdup kstrdup_const kstrndup kmemdup kmemdup_nul memdup_user
+		 vmemdup_user strndup_user memdup_user_nul
 
 Basic Kernel Library Functions
 ==============================
@@ -121,8 +121,8 @@ Text Searching
    :export:
 
 .. kernel-doc:: include/linux/textsearch.h
-   :functions: textsearch_find textsearch_next \
-               textsearch_get_pattern textsearch_get_pattern_len
+   :identifiers: textsearch_find textsearch_next \
+		 textsearch_get_pattern textsearch_get_pattern_len
 
 CRC and Math Functions in Linux
 ===============================
@@ -177,7 +177,7 @@ Division Functions
 ------------------
 
 .. kernel-doc:: include/asm-generic/div64.h
-   :functions: do_div
+   :identifiers: do_div
 
 .. kernel-doc:: include/linux/math64.h
    :internal:
diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index af8151db88b2..669c24449019 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -12,7 +12,7 @@ User Space Memory Access
    :export:
 
 .. kernel-doc:: mm/gup.c
-   :functions: get_user_pages_fast
+   :identifiers: get_user_pages_fast
 
 .. _mm-api-gfp-flags:
 
@@ -44,7 +44,7 @@ The Slab Cache
    :export:
 
 .. kernel-doc:: mm/util.c
-   :functions: kfree_const kvmalloc_node kvfree
+   :identifiers: kfree_const kvmalloc_node kvfree
 
 Virtually Contiguous Mappings
 =============================
@@ -114,7 +114,7 @@ More Memory Management Functions
 .. kernel-doc:: include/linux/page_ref.h
 .. kernel-doc:: include/linux/mmzone.h
 .. kernel-doc:: mm/util.c
-   :functions: folio_mapping
+   :identifiers: folio_mapping
 
 .. kernel-doc:: mm/rmap.c
 .. kernel-doc:: mm/migrate.c
diff --git a/Documentation/core-api/printk-basics.rst b/Documentation/core-api/printk-basics.rst
index 2dde24ca7d9f..60003398a80a 100644
--- a/Documentation/core-api/printk-basics.rst
+++ b/Documentation/core-api/printk-basics.rst
@@ -108,5 +108,5 @@ Function reference
 ==================
 
 .. kernel-doc:: include/linux/printk.h
-   :functions: printk pr_emerg pr_alert pr_crit pr_err pr_warn pr_notice pr_info
-      pr_fmt pr_debug pr_devel pr_cont
+   :identifiers: printk pr_emerg pr_alert pr_crit pr_err pr_warn pr_notice pr_info
+		 pr_fmt pr_debug pr_devel pr_cont
diff --git a/Documentation/crypto/api-aead.rst b/Documentation/crypto/api-aead.rst
index d15256f1ae36..9be2ba7635ac 100644
--- a/Documentation/crypto/api-aead.rst
+++ b/Documentation/crypto/api-aead.rst
@@ -5,13 +5,13 @@ Authenticated Encryption With Associated Data (AEAD) Algorithm Definitions
    :doc: Authenticated Encryption With Associated Data (AEAD) Cipher API
 
 .. kernel-doc:: include/crypto/aead.h
-   :functions: aead_request aead_alg
+   :identifiers: aead_request aead_alg
 
 Authenticated Encryption With Associated Data (AEAD) Cipher API
 ---------------------------------------------------------------
 
 .. kernel-doc:: include/crypto/aead.h
-   :functions: crypto_alloc_aead crypto_free_aead crypto_aead_ivsize crypto_aead_authsize crypto_aead_blocksize crypto_aead_setkey crypto_aead_setauthsize crypto_aead_encrypt crypto_aead_decrypt
+   :identifiers: crypto_alloc_aead crypto_free_aead crypto_aead_ivsize crypto_aead_authsize crypto_aead_blocksize crypto_aead_setkey crypto_aead_setauthsize crypto_aead_encrypt crypto_aead_decrypt
 
 Asynchronous AEAD Request Handle
 --------------------------------
@@ -20,4 +20,4 @@ Asynchronous AEAD Request Handle
    :doc: Asynchronous AEAD Request Handle
 
 .. kernel-doc:: include/crypto/aead.h
-   :functions: crypto_aead_reqsize aead_request_set_tfm aead_request_alloc aead_request_free aead_request_set_callback aead_request_set_crypt aead_request_set_ad
+   :identifiers: crypto_aead_reqsize aead_request_set_tfm aead_request_alloc aead_request_free aead_request_set_callback aead_request_set_crypt aead_request_set_ad
diff --git a/Documentation/crypto/api-akcipher.rst b/Documentation/crypto/api-akcipher.rst
index 40aa8746e2a1..80a07339a3dc 100644
--- a/Documentation/crypto/api-akcipher.rst
+++ b/Documentation/crypto/api-akcipher.rst
@@ -2,7 +2,7 @@ Asymmetric Cipher Algorithm Definitions
 ---------------------------------------
 
 .. kernel-doc:: include/crypto/akcipher.h
-   :functions: akcipher_alg akcipher_request
+   :identifiers: akcipher_alg akcipher_request
 
 Asymmetric Cipher API
 ---------------------
@@ -11,10 +11,10 @@ Asymmetric Cipher API
    :doc: Generic Public Key API
 
 .. kernel-doc:: include/crypto/akcipher.h
-   :functions: crypto_alloc_akcipher crypto_free_akcipher crypto_akcipher_set_pub_key crypto_akcipher_set_priv_key crypto_akcipher_maxsize crypto_akcipher_encrypt crypto_akcipher_decrypt crypto_akcipher_sign crypto_akcipher_verify
+   :identifiers: crypto_alloc_akcipher crypto_free_akcipher crypto_akcipher_set_pub_key crypto_akcipher_set_priv_key crypto_akcipher_maxsize crypto_akcipher_encrypt crypto_akcipher_decrypt crypto_akcipher_sign crypto_akcipher_verify
 
 Asymmetric Cipher Request Handle
 --------------------------------
 
 .. kernel-doc:: include/crypto/akcipher.h
-   :functions: akcipher_request_alloc akcipher_request_free akcipher_request_set_callback akcipher_request_set_crypt
+   :identifiers: akcipher_request_alloc akcipher_request_free akcipher_request_set_callback akcipher_request_set_crypt
diff --git a/Documentation/crypto/api-digest.rst b/Documentation/crypto/api-digest.rst
index 7a1e670d6ce1..0262bf8175e3 100644
--- a/Documentation/crypto/api-digest.rst
+++ b/Documentation/crypto/api-digest.rst
@@ -5,7 +5,7 @@ Message Digest Algorithm Definitions
    :doc: Message Digest Algorithm Definitions
 
 .. kernel-doc:: include/crypto/hash.h
-   :functions: hash_alg_common ahash_alg shash_alg
+   :identifiers: hash_alg_common ahash_alg shash_alg
 
 Asynchronous Message Digest API
 -------------------------------
@@ -14,7 +14,7 @@ Asynchronous Message Digest API
    :doc: Asynchronous Message Digest API
 
 .. kernel-doc:: include/crypto/hash.h
-   :functions: crypto_alloc_ahash crypto_free_ahash crypto_ahash_init crypto_ahash_digestsize crypto_ahash_reqtfm crypto_ahash_reqsize crypto_ahash_statesize crypto_ahash_setkey crypto_ahash_finup crypto_ahash_final crypto_ahash_digest crypto_ahash_export crypto_ahash_import
+   :identifiers: crypto_alloc_ahash crypto_free_ahash crypto_ahash_init crypto_ahash_digestsize crypto_ahash_reqtfm crypto_ahash_reqsize crypto_ahash_statesize crypto_ahash_setkey crypto_ahash_finup crypto_ahash_final crypto_ahash_digest crypto_ahash_export crypto_ahash_import
 
 Asynchronous Hash Request Handle
 --------------------------------
@@ -23,7 +23,7 @@ Asynchronous Hash Request Handle
    :doc: Asynchronous Hash Request Handle
 
 .. kernel-doc:: include/crypto/hash.h
-   :functions: ahash_request_set_tfm ahash_request_alloc ahash_request_free ahash_request_set_callback ahash_request_set_crypt
+   :identifiers: ahash_request_set_tfm ahash_request_alloc ahash_request_free ahash_request_set_callback ahash_request_set_crypt
 
 Synchronous Message Digest API
 ------------------------------
@@ -32,4 +32,4 @@ Synchronous Message Digest API
    :doc: Synchronous Message Digest API
 
 .. kernel-doc:: include/crypto/hash.h
-   :functions: crypto_alloc_shash crypto_free_shash crypto_shash_blocksize crypto_shash_digestsize crypto_shash_descsize crypto_shash_setkey crypto_shash_digest crypto_shash_export crypto_shash_import crypto_shash_init crypto_shash_update crypto_shash_final crypto_shash_finup
+   :identifiers: crypto_alloc_shash crypto_free_shash crypto_shash_blocksize crypto_shash_digestsize crypto_shash_descsize crypto_shash_setkey crypto_shash_digest crypto_shash_export crypto_shash_import crypto_shash_init crypto_shash_update crypto_shash_final crypto_shash_finup
diff --git a/Documentation/crypto/api-kpp.rst b/Documentation/crypto/api-kpp.rst
index 7d86ab906bdf..27ce96ab7dde 100644
--- a/Documentation/crypto/api-kpp.rst
+++ b/Documentation/crypto/api-kpp.rst
@@ -2,7 +2,7 @@ Key-agreement Protocol Primitives (KPP) Cipher Algorithm Definitions
 --------------------------------------------------------------------
 
 .. kernel-doc:: include/crypto/kpp.h
-   :functions: kpp_request crypto_kpp kpp_alg kpp_secret
+   :identifiers: kpp_request crypto_kpp kpp_alg kpp_secret
 
 Key-agreement Protocol Primitives (KPP) Cipher API
 --------------------------------------------------
@@ -11,13 +11,13 @@ Key-agreement Protocol Primitives (KPP) Cipher API
    :doc: Generic Key-agreement Protocol Primitives API
 
 .. kernel-doc:: include/crypto/kpp.h
-   :functions: crypto_alloc_kpp crypto_free_kpp crypto_kpp_set_secret crypto_kpp_generate_public_key crypto_kpp_compute_shared_secret crypto_kpp_maxsize
+   :identifiers: crypto_alloc_kpp crypto_free_kpp crypto_kpp_set_secret crypto_kpp_generate_public_key crypto_kpp_compute_shared_secret crypto_kpp_maxsize
 
 Key-agreement Protocol Primitives (KPP) Cipher Request Handle
 -------------------------------------------------------------
 
 .. kernel-doc:: include/crypto/kpp.h
-   :functions: kpp_request_alloc kpp_request_free kpp_request_set_callback kpp_request_set_input kpp_request_set_output
+   :identifiers: kpp_request_alloc kpp_request_free kpp_request_set_callback kpp_request_set_input kpp_request_set_output
 
 ECDH Helper Functions
 ---------------------
@@ -26,7 +26,7 @@ ECDH Helper Functions
    :doc: ECDH Helper Functions
 
 .. kernel-doc:: include/crypto/ecdh.h
-   :functions: ecdh crypto_ecdh_key_len crypto_ecdh_encode_key crypto_ecdh_decode_key
+   :identifiers: ecdh crypto_ecdh_key_len crypto_ecdh_encode_key crypto_ecdh_decode_key
 
 DH Helper Functions
 -------------------
@@ -35,4 +35,4 @@ DH Helper Functions
    :doc: DH Helper Functions
 
 .. kernel-doc:: include/crypto/dh.h
-   :functions: dh crypto_dh_key_len crypto_dh_encode_key crypto_dh_decode_key
+   :identifiers: dh crypto_dh_key_len crypto_dh_encode_key crypto_dh_decode_key
diff --git a/Documentation/crypto/api-rng.rst b/Documentation/crypto/api-rng.rst
index 10ba7436cee4..ccd42048e45c 100644
--- a/Documentation/crypto/api-rng.rst
+++ b/Documentation/crypto/api-rng.rst
@@ -2,7 +2,7 @@ Random Number Algorithm Definitions
 -----------------------------------
 
 .. kernel-doc:: include/crypto/rng.h
-   :functions: rng_alg
+   :identifiers: rng_alg
 
 Crypto API Random Number API
 ----------------------------
@@ -11,4 +11,4 @@ Crypto API Random Number API
    :doc: Random number generator API
 
 .. kernel-doc:: include/crypto/rng.h
-   :functions: crypto_alloc_rng crypto_rng_alg crypto_free_rng crypto_rng_generate crypto_rng_get_bytes crypto_rng_reset crypto_rng_seedsize
+   :identifiers: crypto_alloc_rng crypto_rng_alg crypto_free_rng crypto_rng_generate crypto_rng_get_bytes crypto_rng_reset crypto_rng_seedsize
diff --git a/Documentation/crypto/api-skcipher.rst b/Documentation/crypto/api-skcipher.rst
index 04d6cc5357c8..f487f490a3c6 100644
--- a/Documentation/crypto/api-skcipher.rst
+++ b/Documentation/crypto/api-skcipher.rst
@@ -5,7 +5,7 @@ Block Cipher Algorithm Definitions
    :doc: Block Cipher Algorithm Definitions
 
 .. kernel-doc:: include/linux/crypto.h
-   :functions: crypto_alg cipher_alg compress_alg
+   :identifiers: crypto_alg cipher_alg compress_alg
 
 Symmetric Key Cipher API
 ------------------------
@@ -14,7 +14,7 @@ Symmetric Key Cipher API
    :doc: Symmetric Key Cipher API
 
 .. kernel-doc:: include/crypto/skcipher.h
-   :functions: crypto_alloc_skcipher crypto_free_skcipher crypto_has_skcipher crypto_skcipher_ivsize crypto_skcipher_blocksize crypto_skcipher_setkey crypto_skcipher_reqtfm crypto_skcipher_encrypt crypto_skcipher_decrypt
+   :identifiers: crypto_alloc_skcipher crypto_free_skcipher crypto_has_skcipher crypto_skcipher_ivsize crypto_skcipher_blocksize crypto_skcipher_setkey crypto_skcipher_reqtfm crypto_skcipher_encrypt crypto_skcipher_decrypt
 
 Symmetric Key Cipher Request Handle
 -----------------------------------
@@ -23,7 +23,7 @@ Symmetric Key Cipher Request Handle
    :doc: Symmetric Key Cipher Request Handle
 
 .. kernel-doc:: include/crypto/skcipher.h
-   :functions: crypto_skcipher_reqsize skcipher_request_set_tfm skcipher_request_alloc skcipher_request_free skcipher_request_set_callback skcipher_request_set_crypt
+   :identifiers: crypto_skcipher_reqsize skcipher_request_set_tfm skcipher_request_alloc skcipher_request_free skcipher_request_set_callback skcipher_request_set_crypt
 
 Single Block Cipher API
 -----------------------
@@ -32,4 +32,4 @@ Single Block Cipher API
    :doc: Single Block Cipher API
 
 .. kernel-doc:: include/crypto/internal/cipher.h
-   :functions: crypto_alloc_cipher crypto_free_cipher crypto_has_cipher crypto_cipher_blocksize crypto_cipher_setkey crypto_cipher_encrypt_one crypto_cipher_decrypt_one
+   :identifiers: crypto_alloc_cipher crypto_free_cipher crypto_has_cipher crypto_cipher_blocksize crypto_cipher_setkey crypto_cipher_encrypt_one crypto_cipher_decrypt_one
diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 94b6802ab0ab..9cf5a85976c5 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -226,9 +226,9 @@ are defined at the C-language level. The following macros can be used to check
 properties of concurrent code where bugs would not manifest as data races.
 
 .. kernel-doc:: include/linux/kcsan-checks.h
-    :functions: ASSERT_EXCLUSIVE_WRITER ASSERT_EXCLUSIVE_WRITER_SCOPED
-                ASSERT_EXCLUSIVE_ACCESS ASSERT_EXCLUSIVE_ACCESS_SCOPED
-                ASSERT_EXCLUSIVE_BITS
+    :identifiers: ASSERT_EXCLUSIVE_WRITER ASSERT_EXCLUSIVE_WRITER_SCOPED
+                  ASSERT_EXCLUSIVE_ACCESS ASSERT_EXCLUSIVE_ACCESS_SCOPED
+                  ASSERT_EXCLUSIVE_BITS
 
 Implementation Details
 ----------------------
diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
index 936f6aaa75c8..2885450f1a9d 100644
--- a/Documentation/dev-tools/kfence.rst
+++ b/Documentation/dev-tools/kfence.rst
@@ -303,11 +303,11 @@ The following describes the functions which are used by allocators as well as
 page handling code to set up and deal with KFENCE allocations.
 
 .. kernel-doc:: include/linux/kfence.h
-   :functions: is_kfence_address
-               kfence_shutdown_cache
-               kfence_alloc kfence_free __kfence_free
-               kfence_ksize kfence_object_start
-               kfence_handle_page_fault
+   :identifiers: is_kfence_address
+		 kfence_shutdown_cache
+		 kfence_alloc kfence_free __kfence_free
+		 kfence_ksize kfence_object_start
+		 kfence_handle_page_fault
 
 Related Tools
 -------------
diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index ab376b316c36..25d857371809 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -397,9 +397,9 @@ Helpers
 -------
 
 .. kernel-doc:: tools/testing/selftests/kselftest_harness.h
-    :functions: TH_LOG TEST TEST_SIGNAL FIXTURE FIXTURE_DATA FIXTURE_SETUP
-                FIXTURE_TEARDOWN TEST_F TEST_HARNESS_MAIN FIXTURE_VARIANT
-                FIXTURE_VARIANT_ADD
+    :identifiers: TH_LOG TEST TEST_SIGNAL FIXTURE FIXTURE_DATA FIXTURE_SETUP
+                  FIXTURE_TEARDOWN TEST_F TEST_HARNESS_MAIN FIXTURE_VARIANT
+                  FIXTURE_VARIANT_ADD
 
 Operators
 ---------
@@ -408,8 +408,8 @@ Operators
     :doc: operators
 
 .. kernel-doc:: tools/testing/selftests/kselftest_harness.h
-    :functions: ASSERT_EQ ASSERT_NE ASSERT_LT ASSERT_LE ASSERT_GT ASSERT_GE
-                ASSERT_NULL ASSERT_TRUE ASSERT_NULL ASSERT_TRUE ASSERT_FALSE
-                ASSERT_STREQ ASSERT_STRNE EXPECT_EQ EXPECT_NE EXPECT_LT
-                EXPECT_LE EXPECT_GT EXPECT_GE EXPECT_NULL EXPECT_TRUE
-                EXPECT_FALSE EXPECT_STREQ EXPECT_STRNE
+    :identifiers: ASSERT_EQ ASSERT_NE ASSERT_LT ASSERT_LE ASSERT_GT ASSERT_GE
+                  ASSERT_NULL ASSERT_TRUE ASSERT_NULL ASSERT_TRUE ASSERT_FALSE
+                  ASSERT_STREQ ASSERT_STRNE EXPECT_EQ EXPECT_NE EXPECT_LT
+                  EXPECT_LE EXPECT_GT EXPECT_GE EXPECT_NULL EXPECT_TRUE
+                  EXPECT_FALSE EXPECT_STREQ EXPECT_STRNE
diff --git a/Documentation/driver-api/80211/cfg80211.rst b/Documentation/driver-api/80211/cfg80211.rst
index 836f609c3f75..018f01ce070a 100644
--- a/Documentation/driver-api/80211/cfg80211.rst
+++ b/Documentation/driver-api/80211/cfg80211.rst
@@ -12,7 +12,7 @@ Device registration
    :doc: Device registration
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions:
+   :identifiers:
 	ieee80211_channel_flags
 	ieee80211_channel
 	ieee80211_rate_flags
@@ -46,7 +46,7 @@ Actions and configuration
    :doc: Actions and configuration
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions:
+   :identifiers:
 	cfg80211_ops
 	vif_params
 	key_params
@@ -100,7 +100,7 @@ Scanning and BSS list handling
    :doc: Scanning and BSS list handling
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions:
+   :identifiers:
 	cfg80211_ssid
 	cfg80211_scan_request
 	cfg80211_scan_done
@@ -119,7 +119,7 @@ Utility functions
    :doc: Utility functions
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions:
+   :identifiers:
 	ieee80211_channel_to_frequency
 	ieee80211_frequency_to_channel
 	ieee80211_get_channel
@@ -135,7 +135,7 @@ Data path helpers
    :doc: Data path helpers
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions:
+   :identifiers:
 	ieee80211_data_to_8023
 	ieee80211_amsdu_to_8023s
 	cfg80211_classify8021d
@@ -147,7 +147,7 @@ Regulatory enforcement infrastructure
    :doc: Regulatory enforcement infrastructure
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions:
+   :identifiers:
 	regulatory_hint
 	wiphy_apply_custom_regulatory
 	freq_reg_info
@@ -159,7 +159,7 @@ RFkill integration
    :doc: RFkill integration
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions:
+   :identifiers:
 	wiphy_rfkill_set_hw_state
 	wiphy_rfkill_start_polling
 	wiphy_rfkill_stop_polling
@@ -171,7 +171,7 @@ Test mode
    :doc: Test mode
 
 .. kernel-doc:: include/net/cfg80211.h
-   :functions:
+   :identifiers:
 	cfg80211_testmode_alloc_reply_skb
 	cfg80211_testmode_reply
 	cfg80211_testmode_alloc_event_skb
diff --git a/Documentation/driver-api/80211/mac80211-advanced.rst b/Documentation/driver-api/80211/mac80211-advanced.rst
index f8df7b3af8f5..33b7a7c2e18e 100644
--- a/Documentation/driver-api/80211/mac80211-advanced.rst
+++ b/Documentation/driver-api/80211/mac80211-advanced.rst
@@ -15,7 +15,7 @@ appropriate trigger, which will then be triggered appropriately by
 mac80211.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions:
+   :identifiers:
 	ieee80211_get_tx_led_name
 	ieee80211_get_rx_led_name
 	ieee80211_get_assoc_led_name
@@ -31,7 +31,7 @@ Hardware crypto acceleration
    :doc: Hardware crypto acceleration
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions:
+   :identifiers:
 	set_key_cmd
 	ieee80211_key_conf
 	ieee80211_key_flags
@@ -52,7 +52,7 @@ Beacon filter support
    :doc: Beacon filter support
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_beacon_loss
+   :identifiers: ieee80211_beacon_loss
 
 Multiple queues and QoS support
 ===============================
@@ -60,7 +60,7 @@ Multiple queues and QoS support
 TBD
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_tx_queue_params
+   :identifiers: ieee80211_tx_queue_params
 
 Access point mode support
 =========================
@@ -79,7 +79,7 @@ support for powersaving clients
    :doc: AP support for powersaving clients
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions:
+   :identifiers:
 	ieee80211_get_buffered_bc
 	ieee80211_beacon_get
 	ieee80211_sta_eosp
@@ -101,7 +101,7 @@ addresses here, note which configurations are supported by mac80211, add
 notes about supporting hw crypto with it.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions:
+   :identifiers:
 	ieee80211_iterate_active_interfaces
 	ieee80211_iterate_active_interfaces_atomic
 
@@ -111,7 +111,7 @@ Station handling
 TODO
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions:
+   :identifiers:
 	ieee80211_sta
 	sta_notify_cmd
 	ieee80211_find_sta
@@ -123,7 +123,7 @@ Hardware scan offload
 TBD
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_scan_completed
+   :identifiers: ieee80211_scan_completed
 
 Aggregation
 ===========
@@ -145,7 +145,7 @@ RX A-MPDU aggregation
 .. WARNING: DOCPROC directive not supported: !Cnet/mac80211/agg-rx.c
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_ampdu_mlme_action
+   :identifiers: ieee80211_ampdu_mlme_action
 
 Spatial Multiplexing Powersave (SMPS)
 =====================================
@@ -154,7 +154,7 @@ Spatial Multiplexing Powersave (SMPS)
    :doc: Spatial multiplexing power save
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions:
+   :identifiers:
 	ieee80211_request_smps
 	ieee80211_smps_mode
 
@@ -169,7 +169,7 @@ Rate Control API
 TBD
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions:
+   :identifiers:
 	ieee80211_start_tx_ba_session
 	ieee80211_start_tx_ba_cb_irqsafe
 	ieee80211_stop_tx_ba_session
@@ -212,7 +212,7 @@ Programming information
 -----------------------
 
 .. kernel-doc:: net/mac80211/sta_info.h
-   :functions:
+   :identifiers:
 	sta_info
 	ieee80211_sta_info_flags
 
@@ -226,7 +226,7 @@ Aggregation Functions
 =====================
 
 .. kernel-doc:: net/mac80211/sta_info.h
-   :functions:
+   :identifiers:
 	sta_ampdu_mlme
 	tid_ampdu_tx
 	tid_ampdu_rx
diff --git a/Documentation/driver-api/80211/mac80211.rst b/Documentation/driver-api/80211/mac80211.rst
index e38a220401f5..ebe0177cf602 100644
--- a/Documentation/driver-api/80211/mac80211.rst
+++ b/Documentation/driver-api/80211/mac80211.rst
@@ -30,7 +30,7 @@ Finally, a discussion of hardware capabilities should be done with
 references to other parts of the book.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions:
+   :identifiers:
 	ieee80211_hw
 	ieee80211_hw_flags
 	SET_IEEE80211_DEV
@@ -50,7 +50,7 @@ This chapter should describe PHY handling including start/stop callbacks
 and the various structures used.
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions:
+   :identifiers:
 	ieee80211_conf
 	ieee80211_conf_flags
 
@@ -72,7 +72,7 @@ the recommendation to allow only a single interface in STA mode at
 first!
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_vif
+   :identifiers: ieee80211_vif
 
 Receive and transmit processing
 ===============================
@@ -107,7 +107,7 @@ functions/definitions
 ---------------------
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions:
+   :identifiers:
 	ieee80211_rx_status
 	mac80211_rx_encoding_flags
 	mac80211_rx_flags
@@ -141,7 +141,7 @@ Frame filtering
    :doc: Frame filtering
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions: ieee80211_filter_flags
+   :identifiers: ieee80211_filter_flags
 
 The mac80211 workqueue
 ======================
@@ -150,6 +150,6 @@ The mac80211 workqueue
    :doc: mac80211 workqueue
 
 .. kernel-doc:: include/net/mac80211.h
-   :functions:
+   :identifiers:
 	ieee80211_queue_work
 	ieee80211_queue_delayed_work
diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
index ee913ae16371..4463d90dc697 100644
--- a/Documentation/driver-api/device_link.rst
+++ b/Documentation/driver-api/device_link.rst
@@ -254,7 +254,7 @@ State machine
 =============
 
 .. kernel-doc:: include/linux/device.h
-   :functions: device_link_state
+   :identifiers: device_link_state
 
 ::
 
diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
index 5f04c3bcdf0c..e7163fefd237 100644
--- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
+++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
@@ -112,7 +112,7 @@ expected to be used regularly by userspace.
 firmware_fallback_sysfs
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/fallback.c
-   :functions: firmware_fallback_sysfs
+   :identifiers: firmware_fallback_sysfs
 
 Firmware kobject uevent fallback mechanism
 ==========================================
@@ -220,7 +220,7 @@ A device driver which needs this can describe the firmware it needs
 using an efi_embedded_fw_desc struct:
 
 .. kernel-doc:: include/linux/efi_embedded_fw.h
-   :functions: efi_embedded_fw_desc
+   :identifiers: efi_embedded_fw_desc
 
 The EFI embedded-fw code works by scanning all EFI_BOOT_SERVICES_CODE memory
 segments for an eight byte sequence matching prefix; if the prefix is found it
diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index 06ac89adaafb..db9a40ad0d86 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -33,19 +33,19 @@ and processed one by one. ARM’s SMCCC is used to pass the execution
 of the requests on to a secure monitor (EL3).
 
 .. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
-   :functions: stratix10_svc_command_code
+   :identifiers: stratix10_svc_command_code
 
 .. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
-   :functions: stratix10_svc_client_msg
+   :identifiers: stratix10_svc_client_msg
 
 .. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
-   :functions: stratix10_svc_command_config_type
+   :identifiers: stratix10_svc_command_config_type
 
 .. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
-   :functions: stratix10_svc_cb_data
+   :identifiers: stratix10_svc_cb_data
 
 .. kernel-doc:: include/linux/firmware/intel/stratix10-svc-client.h
-   :functions: stratix10_svc_client
+   :identifiers: stratix10_svc_client
 
 .. kernel-doc:: drivers/firmware/stratix10-svc.c
    :export:
diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index 0d6ea0329995..13068b794c11 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -18,27 +18,27 @@ an error is returned.
 request_firmware
 ----------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: request_firmware
+   :identifiers: request_firmware
 
 firmware_request_nowarn
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: firmware_request_nowarn
+   :identifiers: firmware_request_nowarn
 
 firmware_request_platform
 -------------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: firmware_request_platform
+   :identifiers: firmware_request_platform
 
 request_firmware_direct
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: request_firmware_direct
+   :identifiers: request_firmware_direct
 
 request_firmware_into_buf
 -------------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: request_firmware_into_buf
+   :identifiers: request_firmware_into_buf
 
 Asynchronous firmware requests
 ==============================
@@ -52,7 +52,7 @@ in atomic contexts.
 request_firmware_nowait
 -----------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: request_firmware_nowait
+   :identifiers: request_firmware_nowait
 
 Special optimizations on reboot
 ===============================
@@ -66,7 +66,7 @@ firmware to be loaded.
 firmware_request_cache()
 ------------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: firmware_request_cache
+   :identifiers: firmware_request_cache
 
 request firmware API expected driver use
 ========================================
diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index 604208534095..7684fe2ec6b6 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -10,13 +10,13 @@ API to implement a new FPGA bridge
 * fpga_bridge_unregister() - Unregister a bridge
 
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
-   :functions: fpga_bridge
+   :identifiers: fpga_bridge
 
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
-   :functions: fpga_bridge_ops
+   :identifiers: fpga_bridge_ops
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_register
+   :identifiers: fpga_bridge_register
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_unregister
+   :identifiers: fpga_bridge_unregister
diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 49c0a9512653..b8c341d0de68 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -135,28 +135,28 @@ API for implementing a new FPGA Manager driver
 * fpga_mgr_unregister() -  Unregister an FPGA manager
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_mgr_states
+   :identifiers: fpga_mgr_states
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_manager
+   :identifiers: fpga_manager
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_manager_ops
+   :identifiers: fpga_manager_ops
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_manager_info
+   :identifiers: fpga_manager_info
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register_full
+   :identifiers: fpga_mgr_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register
+   :identifiers: fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_register_full
+   :identifiers: devm_fpga_mgr_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_register
+   :identifiers: devm_fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_unregister
+   :identifiers: fpga_mgr_unregister
diff --git a/Documentation/driver-api/fpga/fpga-programming.rst b/Documentation/driver-api/fpga/fpga-programming.rst
index fb4da4240e96..c4f6e91f113c 100644
--- a/Documentation/driver-api/fpga/fpga-programming.rst
+++ b/Documentation/driver-api/fpga/fpga-programming.rst
@@ -90,7 +90,7 @@ API for programming an FPGA
 * fpga_image_info_free() -  Free an FPGA image info struct
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_program_fpga
+   :identifiers: fpga_region_program_fpga
 
 FPGA Manager flags
 
@@ -98,10 +98,10 @@ FPGA Manager flags
    :doc: FPGA Manager flags
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
-   :functions: fpga_image_info
+   :identifiers: fpga_image_info
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_image_info_alloc
+   :identifiers: fpga_image_info_alloc
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_image_info_free
+   :identifiers: fpga_image_info_free
diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index dc55d60a0b4a..64c7052b0586 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -76,34 +76,34 @@ following APIs to handle building or tearing down that list.
 * fpga_bridges_put() - Given a list of bridges, put them
 
 .. kernel-doc:: include/linux/fpga/fpga-region.h
-   :functions: fpga_region
+   :identifiers: fpga_region
 
 .. kernel-doc:: include/linux/fpga/fpga-region.h
-   :functions: fpga_region_info
+   :identifiers: fpga_region_info
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_register_full
+   :identifiers: fpga_region_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_register
+   :identifiers: fpga_region_register
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_unregister
+   :identifiers: fpga_region_unregister
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_get
+   :identifiers: fpga_mgr_get
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: of_fpga_mgr_get
+   :identifiers: of_fpga_mgr_get
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_put
+   :identifiers: fpga_mgr_put
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_get_to_list
+   :identifiers: fpga_bridge_get_to_list
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: of_fpga_bridge_get_to_list
+   :identifiers: of_fpga_bridge_get_to_list
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridges_put
+   :identifiers: fpga_bridges_put
diff --git a/Documentation/driver-api/hte/hte.rst b/Documentation/driver-api/hte/hte.rst
index 153f3233c100..a987690cab9b 100644
--- a/Documentation/driver-api/hte/hte.rst
+++ b/Documentation/driver-api/hte/hte.rst
@@ -25,13 +25,13 @@ The HTE framework APIs for the providers
 ----------------------------------------
 
 .. kernel-doc:: drivers/hte/hte.c
-   :functions: devm_hte_register_chip hte_push_ts_ns
+   :identifiers: devm_hte_register_chip hte_push_ts_ns
 
 The HTE framework APIs for the consumers
 ----------------------------------------
 
 .. kernel-doc:: drivers/hte/hte.c
-   :functions: hte_init_line_attr hte_ts_get hte_ts_put devm_hte_request_ts_ns hte_request_ts_ns hte_enable_ts hte_disable_ts of_hte_req_count hte_get_clk_src_info
+   :identifiers: hte_init_line_attr hte_ts_get hte_ts_put devm_hte_request_ts_ns hte_request_ts_ns hte_enable_ts hte_disable_ts of_hte_req_count hte_get_clk_src_info
 
 The HTE framework public structures
 -----------------------------------
diff --git a/Documentation/driver-api/i2c.rst b/Documentation/driver-api/i2c.rst
index 7582c079d747..6247c13f238e 100644
--- a/Documentation/driver-api/i2c.rst
+++ b/Documentation/driver-api/i2c.rst
@@ -39,7 +39,7 @@ i2c_adapter devices which don't support those I2C operations.
    :internal:
 
 .. kernel-doc:: drivers/i2c/i2c-boardinfo.c
-   :functions: i2c_register_board_info
+   :identifiers: i2c_register_board_info
 
 .. kernel-doc:: drivers/i2c/i2c-core-base.c
    :export:
diff --git a/Documentation/driver-api/infiniband.rst b/Documentation/driver-api/infiniband.rst
index 30e142ccbee9..ce3befc85b2b 100644
--- a/Documentation/driver-api/infiniband.rst
+++ b/Documentation/driver-api/infiniband.rst
@@ -77,14 +77,14 @@ iSCSI Extensions for RDMA (iSER)
    :internal:
 
 .. kernel-doc:: drivers/infiniband/ulp/iser/iscsi_iser.c
-   :functions: iscsi_iser_pdu_alloc iser_initialize_task_headers \
-	iscsi_iser_task_init iscsi_iser_mtask_xmit iscsi_iser_task_xmit \
-	iscsi_iser_cleanup_task iscsi_iser_check_protection \
-	iscsi_iser_conn_create iscsi_iser_conn_bind \
-	iscsi_iser_conn_start iscsi_iser_conn_stop \
-	iscsi_iser_session_destroy iscsi_iser_session_create \
-	iscsi_iser_set_param iscsi_iser_ep_connect iscsi_iser_ep_poll \
-	iscsi_iser_ep_disconnect
+   :identifiers: iscsi_iser_pdu_alloc iser_initialize_task_headers \
+		 iscsi_iser_task_init iscsi_iser_mtask_xmit iscsi_iser_task_xmit \
+		 iscsi_iser_cleanup_task iscsi_iser_check_protection \
+		 iscsi_iser_conn_create iscsi_iser_conn_bind \
+		 iscsi_iser_conn_start iscsi_iser_conn_stop \
+		 iscsi_iser_session_destroy iscsi_iser_session_create \
+		 iscsi_iser_set_param iscsi_iser_ep_connect iscsi_iser_ep_poll \
+		 iscsi_iser_ep_disconnect
 
 .. kernel-doc:: drivers/infiniband/ulp/iser/iser_initiator.c
    :internal:
diff --git a/Documentation/driver-api/mei/hdcp.rst b/Documentation/driver-api/mei/hdcp.rst
index e85a065b1cdc..5f4617358b9b 100644
--- a/Documentation/driver-api/mei/hdcp.rst
+++ b/Documentation/driver-api/mei/hdcp.rst
@@ -28,5 +28,5 @@ mei_hdcp api
 ------------
 
 .. kernel-doc:: drivers/misc/mei/hdcp/mei_hdcp.c
-    :functions:
+    :identifiers:
 
diff --git a/Documentation/driver-api/reset.rst b/Documentation/driver-api/reset.rst
index 84e03d7039cc..ea1973566660 100644
--- a/Documentation/driver-api/reset.rst
+++ b/Documentation/driver-api/reset.rst
@@ -189,18 +189,18 @@ query the reset line status using reset_control_status().
    :internal:
 
 .. kernel-doc:: drivers/reset/core.c
-   :functions: reset_control_reset
-               reset_control_assert
-               reset_control_deassert
-               reset_control_status
-               reset_control_acquire
-               reset_control_release
-               reset_control_rearm
-               reset_control_put
-               of_reset_control_get_count
-               of_reset_control_array_get
-               devm_reset_control_array_get
-               reset_control_get_count
+   :identifiers: reset_control_reset
+		 reset_control_assert
+		 reset_control_deassert
+		 reset_control_status
+		 reset_control_acquire
+		 reset_control_release
+		 reset_control_rearm
+		 reset_control_put
+		 of_reset_control_get_count
+		 of_reset_control_array_get
+		 devm_reset_control_array_get
+		 reset_control_get_count
 
 Reset controller driver API
 ---------------------------
@@ -214,8 +214,8 @@ devm_reset_controller_register().
    :internal:
 
 .. kernel-doc:: drivers/reset/core.c
-   :functions: of_reset_simple_xlate
-               reset_controller_register
-               reset_controller_unregister
-               devm_reset_controller_register
-               reset_controller_add_lookup
+   :identifiers: of_reset_simple_xlate
+		 reset_controller_register
+		 reset_controller_unregister
+		 devm_reset_controller_register
+		 reset_controller_add_lookup
diff --git a/Documentation/driver-api/spi.rst b/Documentation/driver-api/spi.rst
index f28887045049..9d228b01862e 100644
--- a/Documentation/driver-api/spi.rst
+++ b/Documentation/driver-api/spi.rst
@@ -47,7 +47,7 @@ policies for how they use the bits transferred with SPI.
    :internal:
 
 .. kernel-doc:: drivers/spi/spi.c
-   :functions: spi_register_board_info
+   :identifiers: spi_register_board_info
 
 .. kernel-doc:: drivers/spi/spi.c
    :export:
diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
index 201163d8c13e..04880995df3e 100644
--- a/Documentation/driver-api/usb/typec.rst
+++ b/Documentation/driver-api/usb/typec.rst
@@ -63,7 +63,7 @@ The port drivers will describe every Type-C port they control with struct
 typec_capability data structure, and register them with the following API:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_register_port typec_unregister_port
+   :identifiers: typec_register_port typec_unregister_port
 
 When registering the ports, the prefer_role member in struct typec_capability
 deserves special notice. If the port that is being registered does not have
@@ -82,7 +82,7 @@ registration. The class offers the following API for registering/unregistering
 partners.
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_register_partner typec_unregister_partner
+   :identifiers: typec_register_partner typec_unregister_partner
 
 The class will provide a handle to struct typec_partner if the registration was
 successful, or NULL.
@@ -94,7 +94,7 @@ create a sysfs directory for the identity under the partner device. The result
 of Discover Identity command can then be reported with the following API:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_partner_set_identity
+   :identifiers: typec_partner_set_identity
 
 Registering Cables
 ~~~~~~~~~~~~~~~~~~
@@ -115,7 +115,7 @@ the details during registration. The class offers the following API for
 registering/unregistering cables and their plugs:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_register_cable typec_unregister_cable typec_register_plug typec_unregister_plug
+   :identifiers: typec_register_cable typec_unregister_cable typec_register_plug typec_unregister_plug
 
 The class will provide a handle to struct typec_cable and struct typec_plug if
 the registration is successful, or NULL if it isn't.
@@ -127,7 +127,7 @@ sysfs directory for the identity under the cable device. The result of Discover
 Identity command can then be reported with the following API:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_cable_set_identity
+   :identifiers: typec_cable_set_identity
 
 Notifications
 ~~~~~~~~~~~~~
@@ -137,7 +137,7 @@ during connection of a partner or cable, the port driver must use the following
 APIs to report it to the class:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_set_data_role typec_set_pwr_role typec_set_vconn_role typec_set_pwr_opmode
+   :identifiers: typec_set_data_role typec_set_pwr_role typec_set_vconn_role typec_set_pwr_opmode
 
 Alternate Modes
 ~~~~~~~~~~~~~~~
@@ -152,7 +152,7 @@ Ports that support Alternate Modes need to register each SVID they support with
 the following API:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_port_register_altmode
+   :identifiers: typec_port_register_altmode
 
 If a partner or cable plug provides a list of SVIDs as response to USB Power
 Delivery Structured VDM Discover SVIDs message, each SVID needs to be
@@ -161,12 +161,12 @@ registered.
 API for the partners:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_partner_register_altmode
+   :identifiers: typec_partner_register_altmode
 
 API for the Cable Plugs:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_plug_register_altmode
+   :identifiers: typec_plug_register_altmode
 
 So ports, partners and cable plugs will register the alternate modes with their
 own functions, but the registration will always return a handle to struct
@@ -174,13 +174,13 @@ typec_altmode on success, or NULL. The unregistration will happen with the same
 function:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_unregister_altmode
+   :identifiers: typec_unregister_altmode
 
 If a partner or cable plug enters or exits a mode, the port driver needs to
 notify the class with the following API:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_altmode_update_active
+   :identifiers: typec_altmode_update_active
 
 Multiplexer/DeMultiplexer Switches
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -193,7 +193,7 @@ route the pins on the connector to some other component besides USB. USB Type-C
 Connector Class supplies an API for registering those switches.
 
 .. kernel-doc:: drivers/usb/typec/mux.c
-   :functions: typec_switch_register typec_switch_unregister typec_mux_register typec_mux_unregister
+   :identifiers: typec_switch_register typec_switch_unregister typec_mux_register typec_mux_unregister
 
 In most cases the same physical mux will handle both the orientation and mode.
 However, as the port drivers will be responsible for the orientation, and the
@@ -205,7 +205,7 @@ the switch for the port. The drivers can then use the following API for
 controlling them:
 
 .. kernel-doc:: drivers/usb/typec/class.c
-   :functions: typec_set_orientation typec_set_mode
+   :identifiers: typec_set_orientation typec_set_mode
 
 If the connector is dual-role capable, there may also be a switch for the data
 role. USB Type-C Connector Class does not supply separate API for them. The
diff --git a/Documentation/driver-api/usb/typec_bus.rst b/Documentation/driver-api/usb/typec_bus.rst
index 21c890ae17e5..d28610acb275 100644
--- a/Documentation/driver-api/usb/typec_bus.rst
+++ b/Documentation/driver-api/usb/typec_bus.rst
@@ -95,28 +95,28 @@ Alternate mode structs
 ~~~~~~~~~~~~~~~~~~~~~~
 
 .. kernel-doc:: include/linux/usb/typec_altmode.h
-   :functions: typec_altmode_driver typec_altmode_ops
+   :identifiers: typec_altmode_driver typec_altmode_ops
 
 Alternate mode driver registering/unregistering
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. kernel-doc:: include/linux/usb/typec_altmode.h
-   :functions: typec_altmode_register_driver typec_altmode_unregister_driver
+   :identifiers: typec_altmode_register_driver typec_altmode_unregister_driver
 
 Alternate mode driver operations
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. kernel-doc:: drivers/usb/typec/bus.c
-   :functions: typec_altmode_enter typec_altmode_exit typec_altmode_attention typec_altmode_vdm typec_altmode_notify
+   :identifiers: typec_altmode_enter typec_altmode_exit typec_altmode_attention typec_altmode_vdm typec_altmode_notify
 
 API for the port drivers
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 .. kernel-doc:: drivers/usb/typec/bus.c
-   :functions: typec_match_altmode
+   :identifiers: typec_match_altmode
 
 Cable Plug operations
 ~~~~~~~~~~~~~~~~~~~~~
 
 .. kernel-doc:: drivers/usb/typec/bus.c
-   :functions: typec_altmode_get_plug typec_altmode_put_plug
+   :identifiers: typec_altmode_get_plug typec_altmode_put_plug
diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst b/Documentation/gpu/amdgpu/display/display-manager.rst
index be2651ecdd7f..aaea77f31bbe 100644
--- a/Documentation/gpu/amdgpu/display/display-manager.rst
+++ b/Documentation/gpu/amdgpu/display/display-manager.rst
@@ -18,7 +18,7 @@ Lifecycle
    :doc: DM Lifecycle
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
-   :functions: dm_hw_init dm_hw_fini
+   :identifiers: dm_hw_init dm_hw_fini
 
 Interrupts
 ==========
@@ -30,7 +30,7 @@ Interrupts
    :internal:
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
-   :functions: register_hpd_handlers dm_crtc_high_irq dm_pflip_high_irq
+   :identifiers: register_hpd_handlers dm_crtc_high_irq dm_pflip_high_irq
 
 Atomic Implementation
 =====================
@@ -39,7 +39,7 @@ Atomic Implementation
    :doc: atomic
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
-   :functions: amdgpu_dm_atomic_check amdgpu_dm_atomic_commit_tail
+   :identifiers: amdgpu_dm_atomic_check amdgpu_dm_atomic_commit_tail
 
 Color Management Properties
 ===========================
@@ -135,7 +135,7 @@ The DRM blend mode and its elements are then mapped by AMDGPU display manager
    :doc: mpc-overview
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
-   :functions: mpcc_blnd_cfg
+   :identifiers: mpcc_blnd_cfg
 
 Therefore, the blending configuration for a single MPCC instance on the MPC
 tree is defined by :c:type:`mpcc_blnd_cfg`, where
@@ -147,7 +147,7 @@ alpha and plane alpha values. It sets one of the three modes for
 :c:type:`MPCC_ALPHA_BLND_MODE`, as described below.
 
 .. kernel-doc:: drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
-   :functions: mpcc_alpha_blend_mode
+   :identifiers: mpcc_alpha_blend_mode
 
 DM then maps the elements of `enum mpcc_alpha_blend_mode` to those in the DRM
 blend formula, as follows:
diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index 59cfe8a7a8ba..a2a2d5334dd8 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -303,11 +303,11 @@ These functions aren't exported to drivers, but are documented here to help make
 the MST topology helpers easier to understand
 
 .. kernel-doc:: drivers/gpu/drm/display/drm_dp_mst_topology.c
-   :functions: drm_dp_mst_topology_try_get_mstb drm_dp_mst_topology_get_mstb
-               drm_dp_mst_topology_put_mstb
-               drm_dp_mst_topology_try_get_port drm_dp_mst_topology_get_port
-               drm_dp_mst_topology_put_port
-               drm_dp_mst_get_mstb_malloc drm_dp_mst_put_mstb_malloc
+   :identifiers: drm_dp_mst_topology_try_get_mstb drm_dp_mst_topology_get_mstb
+		 drm_dp_mst_topology_put_mstb
+		 drm_dp_mst_topology_try_get_port drm_dp_mst_topology_get_port
+		 drm_dp_mst_topology_put_port
+		 drm_dp_mst_get_mstb_malloc drm_dp_mst_put_mstb_malloc
 
 MIPI DBI Helper Functions Reference
 ===================================
diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 0ca1550fd9dc..421579d9d9e2 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -32,13 +32,13 @@ Interrupt Handling
    :doc: interrupt handling
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
-   :functions: intel_irq_init intel_irq_init_hw intel_hpd_init
+   :identifiers: intel_irq_init intel_irq_init_hw intel_hpd_init
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
-   :functions: intel_runtime_pm_disable_interrupts
+   :identifiers: intel_runtime_pm_disable_interrupts
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
-   :functions: intel_runtime_pm_enable_interrupts
+   :identifiers: intel_runtime_pm_enable_interrupts
 
 Intel GVT-g Guest Support(vGPU)
 -------------------------------
@@ -430,7 +430,7 @@ User Batchbuffer Execution
 Scheduling
 ----------
 .. kernel-doc:: drivers/gpu/drm/i915/i915_scheduler_types.h
-   :functions: i915_sched_engine
+   :identifiers: i915_sched_engine
 
 Logical Rings, Logical Ring Contexts and Execlists
 --------------------------------------------------
@@ -520,7 +520,7 @@ GuC Memory Management
 .. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc.c
    :doc: GuC Memory Management
 .. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc.c
-   :functions: intel_guc_allocate_vma
+   :identifiers: intel_guc_allocate_vma
 
 
 GuC-specific firmware loader
@@ -549,7 +549,7 @@ HuC
 .. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_huc.c
    :doc: HuC
 .. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_huc.c
-   :functions: intel_huc_auth
+   :identifiers: intel_huc_auth
 
 HuC Memory Management
 ~~~~~~~~~~~~~~~~~~~~~
@@ -603,21 +603,21 @@ This section covers the entrypoints exported outside of i915_perf.c to
 integrate with drm/i915 and to handle the `DRM_I915_PERF_OPEN` ioctl.
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_init
+   :identifiers: i915_perf_init
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_fini
+   :identifiers: i915_perf_fini
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_register
+   :identifiers: i915_perf_register
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_unregister
+   :identifiers: i915_perf_unregister
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_open_ioctl
+   :identifiers: i915_perf_open_ioctl
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_release
+   :identifiers: i915_perf_release
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_add_config_ioctl
+   :identifiers: i915_perf_add_config_ioctl
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_remove_config_ioctl
+   :identifiers: i915_perf_remove_config_ioctl
 
 i915 Perf Stream
 ----------------
@@ -626,47 +626,47 @@ This section covers the stream-semantics-agnostic structures and functions
 for representing an i915 perf stream FD and associated file operations.
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf_types.h
-   :functions: i915_perf_stream
+   :identifiers: i915_perf_stream
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf_types.h
-   :functions: i915_perf_stream_ops
+   :identifiers: i915_perf_stream_ops
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: read_properties_unlocked
+   :identifiers: read_properties_unlocked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_open_ioctl_locked
+   :identifiers: i915_perf_open_ioctl_locked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_destroy_locked
+   :identifiers: i915_perf_destroy_locked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_read
+   :identifiers: i915_perf_read
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_ioctl
+   :identifiers: i915_perf_ioctl
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_enable_locked
+   :identifiers: i915_perf_enable_locked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_disable_locked
+   :identifiers: i915_perf_disable_locked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_poll
+   :identifiers: i915_perf_poll
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_perf_poll_locked
+   :identifiers: i915_perf_poll_locked
 
 i915 Perf Observation Architecture Stream
 -----------------------------------------
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf_types.h
-   :functions: i915_oa_ops
+   :identifiers: i915_oa_ops
 
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_stream_init
+   :identifiers: i915_oa_stream_init
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_read
+   :identifiers: i915_oa_read
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_stream_enable
+   :identifiers: i915_oa_stream_enable
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_stream_disable
+   :identifiers: i915_oa_stream_disable
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_wait_unlocked
+   :identifiers: i915_oa_wait_unlocked
 .. kernel-doc:: drivers/gpu/drm/i915/i915_perf.c
-   :functions: i915_oa_poll_wait
+   :identifiers: i915_oa_poll_wait
 
 Other i915 Perf Internals
 -------------------------
diff --git a/Documentation/gpu/rfc/i915_scheduler.rst b/Documentation/gpu/rfc/i915_scheduler.rst
index c237ebc024cd..8c63fe4b038a 100644
--- a/Documentation/gpu/rfc/i915_scheduler.rst
+++ b/Documentation/gpu/rfc/i915_scheduler.rst
@@ -138,7 +138,7 @@ extension.
 .. c:namespace-push:: rfc
 
 .. kernel-doc:: include/uapi/drm/i915_drm.h
-        :functions: i915_context_engines_parallel_submit
+        :identifiers: i915_context_engines_parallel_submit
 
 .. c:namespace-pop::
 
diff --git a/Documentation/gpu/rfc/i915_small_bar.rst b/Documentation/gpu/rfc/i915_small_bar.rst
index d6c03ce3b862..266a17893d22 100644
--- a/Documentation/gpu/rfc/i915_small_bar.rst
+++ b/Documentation/gpu/rfc/i915_small_bar.rst
@@ -17,7 +17,7 @@ required, and prioritize using the non-CPU visible portion of
 I915_MEMORY_CLASS_DEVICE.
 
 .. kernel-doc:: Documentation/gpu/rfc/i915_small_bar.h
-   :functions: __drm_i915_gem_create_ext
+   :identifiers: __drm_i915_gem_create_ext
 
 probed_cpu_visible_size attribute
 ---------------------------------
@@ -32,7 +32,7 @@ where the total size of the heap needs to be known. It also wants to be able to
 give a rough estimate of how memory can potentially be allocated.
 
 .. kernel-doc:: Documentation/gpu/rfc/i915_small_bar.h
-   :functions: __drm_i915_memory_region_info
+   :identifiers: __drm_i915_memory_region_info
 
 Error Capture restrictions
 --------------------------
diff --git a/Documentation/gpu/vga-switcheroo.rst b/Documentation/gpu/vga-switcheroo.rst
index cbbdb994f1dd..f7d9dca08a02 100644
--- a/Documentation/gpu/vga-switcheroo.rst
+++ b/Documentation/gpu/vga-switcheroo.rst
@@ -35,31 +35,31 @@ Public structures
 -----------------
 
 .. kernel-doc:: include/linux/vga_switcheroo.h
-   :functions: vga_switcheroo_handler
+   :identifiers: vga_switcheroo_handler
 
 .. kernel-doc:: include/linux/vga_switcheroo.h
-   :functions: vga_switcheroo_client_ops
+   :identifiers: vga_switcheroo_client_ops
 
 Public constants
 ----------------
 
 .. kernel-doc:: include/linux/vga_switcheroo.h
-   :functions: vga_switcheroo_handler_flags_t
+   :identifiers: vga_switcheroo_handler_flags_t
 
 .. kernel-doc:: include/linux/vga_switcheroo.h
-   :functions: vga_switcheroo_client_id
+   :identifiers: vga_switcheroo_client_id
 
 .. kernel-doc:: include/linux/vga_switcheroo.h
-   :functions: vga_switcheroo_state
+   :identifiers: vga_switcheroo_state
 
 Private structures
 ------------------
 
 .. kernel-doc:: drivers/gpu/vga/vga_switcheroo.c
-   :functions: vgasr_priv
+   :identifiers: vgasr_priv
 
 .. kernel-doc:: drivers/gpu/vga/vga_switcheroo.c
-   :functions: vga_switcheroo_client
+   :identifiers: vga_switcheroo_client
 
 Handlers
 ========
diff --git a/Documentation/hid/hid-bpf.rst b/Documentation/hid/hid-bpf.rst
index 4fad83a6ebc3..a7ba9c88f99c 100644
--- a/Documentation/hid/hid-bpf.rst
+++ b/Documentation/hid/hid-bpf.rst
@@ -167,19 +167,19 @@ Available tracing functions to attach a HID-BPF program:
 --------------------------------------------------------
 
 .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
-   :functions: hid_bpf_device_event hid_bpf_rdesc_fixup
+   :identifiers: hid_bpf_device_event hid_bpf_rdesc_fixup
 
 Available API that can be used in all HID-BPF programs:
 -------------------------------------------------------
 
 .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
-   :functions: hid_bpf_get_data
+   :identifiers: hid_bpf_get_data
 
 Available API that can be used in syscall HID-BPF programs:
 -----------------------------------------------------------
 
 .. kernel-doc:: drivers/hid/bpf/hid_bpf_dispatch.c
-   :functions: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_allocate_context hid_bpf_release_context
+   :identifiers: hid_bpf_attach_prog hid_bpf_hw_request hid_bpf_allocate_context hid_bpf_release_context
 
 General overview of a HID-BPF program
 =====================================
diff --git a/Documentation/mm/ksm.rst b/Documentation/mm/ksm.rst
index 2806e3e4a10e..a4ff806dce82 100644
--- a/Documentation/mm/ksm.rst
+++ b/Documentation/mm/ksm.rst
@@ -78,7 +78,7 @@ The frequency of such scans is defined by
 Reference
 ---------
 .. kernel-doc:: mm/ksm.c
-   :functions: mm_slot ksm_scan stable_node rmap_item
+   :identifiers: mm_slot ksm_scan stable_node rmap_item
 
 --
 Izik Eidus,
diff --git a/Documentation/security/tpm/tpm_vtpm_proxy.rst b/Documentation/security/tpm/tpm_vtpm_proxy.rst
index ea08e76b17f5..cd77c7c0bfec 100644
--- a/Documentation/security/tpm/tpm_vtpm_proxy.rst
+++ b/Documentation/security/tpm/tpm_vtpm_proxy.rst
@@ -47,4 +47,4 @@ UAPI
 .. kernel-doc:: include/uapi/linux/vtpm_proxy.h
 
 .. kernel-doc:: drivers/char/tpm/tpm_vtpm_proxy.c
-   :functions: vtpmx_ioc_new_dev
+   :identifiers: vtpmx_ioc_new_dev
-- 
2.39.2


