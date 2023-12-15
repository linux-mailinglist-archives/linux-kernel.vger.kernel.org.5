Return-Path: <linux-kernel+bounces-1842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8598154B2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C0B22D24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872CE3FB12;
	Fri, 15 Dec 2023 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T0vDp6yS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61236AEE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6X/8g8dcFseOxoWxBd+fYzojaaVtjnt3eobM6crGlY8=; b=T0vDp6ySun5FruDXtGj19F0xQf
	+h+UsDLCvwXL0LTrclEYZN0neFFBG83g9CZ5e5uTrzFWqLQSHE8ho/EkhSMQSV4ygsBg44kO6cwUa
	A3PwcuvGxFp61US9Jd7fSgAt4MSjSEUravUrdjd2eOtCvzuGRgHlCyRxTe7D0Aw9PHgHCtaGCD4VE
	5J0VqQqau6Nwl4j65OV24vkfswycRIAeQ3Nvho0dBPKauerVYKxKGWBVyv6/hKldGJsBY7qSkNtwH
	FLz93vUK5iCpj9N+MeQrL4+lLbU9Ye7w/Pbv1Km5og2W3ciNaTsKF4aIokBCb14zK5Ca8f3iuu2vV
	bVGrn9fg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEI2p-004tlg-1a;
	Fri, 15 Dec 2023 23:56:39 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	kernel test robot <lkp@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Zack Rusin <zackr@vmware.com>,
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/vmwgfx: fix kernel-doc Excess struct member 'base'
Date: Fri, 15 Dec 2023 15:56:38 -0800
Message-ID: <20231215235638.19189-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a new kernel-doc warning reported by kernel test robot:

vmwgfx_surface.c:55: warning: Excess struct member 'base' description in 'vmw_user_surface'

The other warning is not correct: it is confused by "__counted_by".
Kees has made a separate patch for that.

In -Wall mode, kernel-doc still reports 20 warnings of this nature:
vmwgfx_surface.c:198: warning: No description found for return value of 'vmw_surface_dma_size'
but I am not addressing those.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312150701.kNI9LuM3-lkp@intel.com/
Cc: Kees Cook <keescook@chromium.org>
Cc: Zack Rusin <zackr@vmware.com>
Cc: VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -44,7 +44,6 @@
  * struct vmw_user_surface - User-space visible surface resource
  *
  * @prime:          The TTM prime object.
- * @base:           The TTM base object handling user-space visibility.
  * @srf:            The surface metadata.
  * @master:         Master of the creating client. Used for security check.
  */

