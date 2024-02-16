Return-Path: <linux-kernel+bounces-68114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3715F857621
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E2E1C227E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A05E171AD;
	Fri, 16 Feb 2024 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjWnbXDi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7B168B1
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066412; cv=none; b=cBhpM1HEghQIGlufjG6+mK4+F2uK5zHxdQWkhrI6O15OPklfnU+FKWGYpcpajFx17WpWtKiZNOyzFxEmE1PMRGNvl6C+q7TjhQdF+iwW4ACbydEJ7AkgPV2fmowKTRYT0Q9Iv2mcB3XGEkZPwjO+njTMPq6ax/B/azg3P3SX9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066412; c=relaxed/simple;
	bh=0ouwPAOvp37tNU9HOy900jC8g2eiBovoWT/VvmXWWew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hh2jp9kqylcDW+FkSXjw25wKFPne6skDDHVAvs0oVoECDDOs5A2AIzQwpHhukwzhXSs/TmAMv3EsieURPTFGjZOUC/T0t+uT0LVnQoD4BqOQLIJr8DSzTLk5YGvxoSdqohuumGpfGIfVEWQ0j8pLTqovoenXV43qMLviclOJhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjWnbXDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18853C433F1;
	Fri, 16 Feb 2024 06:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066412;
	bh=0ouwPAOvp37tNU9HOy900jC8g2eiBovoWT/VvmXWWew=;
	h=From:To:Cc:Subject:Date:From;
	b=IjWnbXDiQdMeLIOL7ePxjxfS1PtPIsT9yTKbOxuzfl5UDqJFOyqoBlVo35021+TCP
	 JIBZEp2WAMoib0goWBRNCYJS0NP7aEzZUf1WyRW16hn8K2m4lgK9eLTZpzNEuPv7yr
	 KvkcH+TvpIg0bhc1dZqoEuFwitxs0XKVJKjVZcS9aye6RmbaJfpygA5Wl12V2ukn+k
	 llt+hk9C7yz0NvX5W1uXcXhlw8twPetGz8VX2D2kUhY6sUgwH85nB6JurogjkgGFvl
	 XbhsUzzBQvZsG/+SUiBpPmOVDGsMmuG6+arqRE8wWMLPUxnq5U7ZJZExSmaYbQkaKv
	 jAjNxwWg0RNrg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	intel-gfx@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: [PATCH 00/21] drm/i915: remove unused structure members
Date: Fri, 16 Feb 2024 07:53:05 +0100
Message-ID: <20240216065326.6910-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series removes unused i915 structure members as found by
clang-struct (and manually checked by me).

Cc: intel-gfx@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>

Jiri Slaby (SUSE) (21):
  drm/i915: remove unused intel_dvo_dev_ops hooks
  drm/i915: remove structs intel_vgpu_pipe_format and
    intel_vgpu_fb_format
  drm/i915: remove intel_dsi::{port_bits,hs}
  drm/i915: remove
    intel_gvt_gtt::{mm_alloc_page_table,mm_free_page_table}
  drm/i915: remove intel_gvt_mmio_info::{device,addr_range}
  drm/i915: remove intel_vgpu_workload::{ring_context,restore_inhibit}
  drm/i915: remove intel_vbt_panel_data::edp::initialized
  drm/i915: remove intel_guc::ads_engine_usage_size
  drm/i915: remove i915_drm_client::id
  drm/i915: remove i915_perf_stream::size_exponent
  drm/i915: remove intel_vgpu_gtt::active_ppgtt_mm_bitmap
  drm/i915: remove intel_vgpu_fence::base
  drm/i915: remove intel_vgpu_opregion::mapped
  drm/i915: remove intel_vgpu::intx_trigger
  drm/i915: remove gvt_mmio_block::device
  drm/i915: remove intel_gvt_irq_info::warned
  drm/i915: remove intel_gvt_event_info::policy
  drm/i915: remove intel_gvt_irq::pending_events
  drm/i915: remove execute_cb::signal
  drm/i915: remove i915_vma::obj_hash
  drm/i915: remove intel_memory_region_ops::flags

 .../drm/i915/display/intel_display_types.h    |  1 -
 drivers/gpu/drm/i915/display/intel_dsi.h      |  4 ---
 drivers/gpu/drm/i915/display/intel_dvo_dev.h  | 25 -------------------
 drivers/gpu/drm/i915/gt/uc/intel_guc.h        |  2 --
 drivers/gpu/drm/i915/gvt/fb_decoder.h         | 11 --------
 drivers/gpu/drm/i915/gvt/gtt.h                |  3 ---
 drivers/gpu/drm/i915/gvt/gvt.h                |  5 ----
 drivers/gpu/drm/i915/gvt/interrupt.c          |  1 -
 drivers/gpu/drm/i915/gvt/interrupt.h          |  2 --
 drivers/gpu/drm/i915/gvt/mmio.h               |  2 --
 drivers/gpu/drm/i915/gvt/scheduler.h          |  2 --
 drivers/gpu/drm/i915/i915_drm_client.h        |  2 --
 drivers/gpu/drm/i915/i915_perf_types.h        |  1 -
 drivers/gpu/drm/i915/i915_request.c           |  1 -
 drivers/gpu/drm/i915/i915_vma_types.h         |  1 -
 drivers/gpu/drm/i915/intel_memory_region.h    |  2 --
 16 files changed, 65 deletions(-)

-- 
2.43.1


