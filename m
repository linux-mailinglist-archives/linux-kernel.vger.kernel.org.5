Return-Path: <linux-kernel+bounces-68115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F10857628
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F6D286B06
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BCB1798A;
	Fri, 16 Feb 2024 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6rw1uNd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0E175BC
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066415; cv=none; b=YtChO9X/0SmOtOc1PSdaeVhBO0DnBrdTUiE9NZhY5MwhO7Wr43NkK8wpxTSgj2zyRp1Jo9n9yr2x/yGwiVKYnCFqJt4t8DbKRUjuXafLlDFfocQgm0O9Z/pG+e9yooGXmZrLcoVZOhKMlbLUVoubGmpB+WPi2GFL6ax+NQS0Oew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066415; c=relaxed/simple;
	bh=S4KYIAgS4mvLQSOwp8dAYCk+tnxgKRZCI0XPqNFrrhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfh5J0Rc6rT2yJ7cN5DY3PsN+RTPmHxFRMHJWUAMTfIIkFR8MrCYyp0bv0TXJWebga48ajxnNMe/LvdL96EuhQHShqG6HvxCqZDFDHlAHyoeOtNN/Vv2bT1dtRZWA1aG2jvPtrvrG6grnApBzJyocpYfKSBKhd58OeIXkWzXZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6rw1uNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C93C43390;
	Fri, 16 Feb 2024 06:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066415;
	bh=S4KYIAgS4mvLQSOwp8dAYCk+tnxgKRZCI0XPqNFrrhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6rw1uNdI2qWadebU+FZ6zBEiJarygA8OEobGVeQkQxUePa25tpohVS4Yh7qOF7jm
	 QKlWeEUAAqX63u7U4OTFKOQvqEAr/CqKLiZIdyHflQk7meZpfAqw1HdvrUWPHONJmA
	 943Iuu9VBxclR6A1xNs/H3IJGfsprJrAeylDbmtfCx6ZaYOBqlo0CwxLYYZA/je7nw
	 W/oESRD+0BCAHMxtta6RdXxl5WK0shyOFj1N7f9jlCgUc6P+78zTYb2KY8KXPgh8rR
	 NG/WjZaVKRWSNQ4syOmwIqGR2MZNDTHcfFzdJj5vghS6n2NlUYVFQ2LBWW8svk59pz
	 TVtcWD3fspCKw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 01/21] drm/i915: remove unused intel_dvo_dev_ops hooks
Date: Fri, 16 Feb 2024 07:53:06 +0100
Message-ID: <20240216065326.6910-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216065326.6910-1-jirislaby@kernel.org>
References: <20240216065326.6910-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct intel_dvo_dev_ops's ::create_resources(), ::prepare(),
::commit::, and get_modes() are all unused since their addition in
79e539453b34 (DRM: i915: add mode setting support). Drop all of them.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/display/intel_dvo_dev.h | 25 --------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dvo_dev.h b/drivers/gpu/drm/i915/display/intel_dvo_dev.h
index f7e98e1c6470..af7b04539b93 100644
--- a/drivers/gpu/drm/i915/display/intel_dvo_dev.h
+++ b/drivers/gpu/drm/i915/display/intel_dvo_dev.h
@@ -53,12 +53,6 @@ struct intel_dvo_dev_ops {
 	bool (*init)(struct intel_dvo_device *dvo,
 		     struct i2c_adapter *i2cbus);
 
-	/*
-	 * Called to allow the output a chance to create properties after the
-	 * RandR objects have been created.
-	 */
-	void (*create_resources)(struct intel_dvo_device *dvo);
-
 	/*
 	 * Turn on/off output.
 	 *
@@ -79,16 +73,6 @@ struct intel_dvo_dev_ops {
 	enum drm_mode_status (*mode_valid)(struct intel_dvo_device *dvo,
 					   struct drm_display_mode *mode);
 
-	/*
-	 * Callback for preparing mode changes on an output
-	 */
-	void (*prepare)(struct intel_dvo_device *dvo);
-
-	/*
-	 * Callback for committing mode changes on an output
-	 */
-	void (*commit)(struct intel_dvo_device *dvo);
-
 	/*
 	 * Callback for setting up a video mode after fixups have been made.
 	 *
@@ -111,15 +95,6 @@ struct intel_dvo_dev_ops {
 	 */
 	bool (*get_hw_state)(struct intel_dvo_device *dev);
 
-	/**
-	 * Query the device for the modes it provides.
-	 *
-	 * This function may also update MonInfo, mm_width, and mm_height.
-	 *
-	 * \return singly-linked list of modes or NULL if no modes found.
-	 */
-	struct drm_display_mode *(*get_modes)(struct intel_dvo_device *dvo);
-
 	/**
 	 * Clean up driver-specific bits of the output
 	 */
-- 
2.43.1


