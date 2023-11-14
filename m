Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EE27EAB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjKNIKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjKNIKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:10:48 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC6F1A5;
        Tue, 14 Nov 2023 00:10:42 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc37fb1310so39982905ad.1;
        Tue, 14 Nov 2023 00:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699949442; x=1700554242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vj7/+lAfEA53l7pM4HwUPg5m3vq3PgfEVzUjZweRlmU=;
        b=E43OL7m7D+3GBMdZdjNSGEZLhtcVazdFnnbPHJKvhiVRivhkSxxKAHaEGch3iv69Er
         12gYDNJR8S01y0QvFb6nmPd9e7d9Yyb30l1kHVUJusDaAeetAWAPYr7QQaiG2zac/HD0
         CTnD8lojy5zlQMoqssFm8/LsSD+uidjRf1KtqdYaEZO6FAuLT3BJACauYwO9HRO2uQHq
         UeVaGnGKMAawsVmEt4Hya6mH3cFpWnssy6OvxcLd9ExfcruzTC/sGFgEJMh483mf2isz
         FhrdevV9j5gkofWMOMHt2GLltp2TvyoMR2hRz5B75Jw/bxD6pG678gg0zD2Q5B3VE8Vj
         QTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699949442; x=1700554242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vj7/+lAfEA53l7pM4HwUPg5m3vq3PgfEVzUjZweRlmU=;
        b=IvleV4fKW2qPbOqZor6E4Ka4DT98rvD2XTCZU9QdF9VPVyKIoY4Xdx6YWGM3FRTSnb
         6bS+xpn76yInQYS0T7ZVJ46iPqglXSzVcPqY0DCcgVg7C5Dp8Zdk/wTrZPAqgZ8lE5zR
         jiUeoyZyjjhi6bv0804Gbx0GMX/JUB7/S52lLy6Dx1hWUgBvQgPFTgQ6Wz8H0uyKah3K
         ye8Q36Js5GvIxsT8Fm8N48CNcGtPK2aUZQmha5bYQAIC6ZeE2+DHXdSe7qS5CtYu+EkN
         ioBjHz+zrTSphbQn2vn+Nir5amErRxz+xj+vjf6Uk0LpBLw21PldEdRdPVO79fqhNXmC
         ZJpQ==
X-Gm-Message-State: AOJu0YxElU9+0Flvt3y3A5v6MC7gGK3qDva3Wc8nlgBdtqjrW5P/WIBG
        AyUwJPZfGIwvrjUbPZKr19A=
X-Google-Smtp-Source: AGHT+IE1LHgIzWEzbIN8OsZ/PBWIZK7lyjQ7s1tYn97NyIKie23c8u0JPZtAPKhTnd5ojodPUXefjw==
X-Received: by 2002:a17:903:1246:b0:1ce:1674:fd22 with SMTP id u6-20020a170903124600b001ce1674fd22mr1603885plh.9.1699949441853;
        Tue, 14 Nov 2023 00:10:41 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001c61901ed2esm5146209plb.219.2023.11.14.00.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:10:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 2826F10206E62; Tue, 14 Nov 2023 15:10:37 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>, Imre Deak <imre.deak@intel.com>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] drm/dp_mst: Separate @failing_port list in drm_dp_mst_atomic_check_mgr() comment
Date:   Tue, 14 Nov 2023 15:10:33 +0700
Message-ID: <20231114081033.27343-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; i=bagasdotme@gmail.com; h=from:subject; bh=/nItUBT7uVPqUMNGT89+pfAJgmn+o44QIuhAdJuptpY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKnBWoEvH96Jtv90asnZ7JLbDrcv6wplaCvEdU71/dHDm 7B287ywjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExk/jeG/4WH39u09z1o6q94 uKr0qfnyf1Z6Ro4+kbLHk+ynvDm8oZeRoWl6jsC0ecW7X3z8c5f5xVpF4wXRV5beKV5xM2b9dpa j7RwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell reported htmldocs warnings when merging drm-intel
tree:

Documentation/gpu/drm-kms-helpers:296: drivers/gpu/drm/display/drm_dp_mst_topology.c:5484: ERROR: Unexpected indentation.
Documentation/gpu/drm-kms-helpers:296: drivers/gpu/drm/display/drm_dp_mst_topology.c:5488: WARNING: Block quote ends without a blank line; unexpected unindent.

Separate @failing_port return value list by surrounding it with a
blank line to fix above warnings.

Fixes: 1cd0a5ea427931 ("drm/dp_mst: Factor out a helper to check the atomic state of a topology manager")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20231114141715.6f435118@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 0854fe428f173a..b9a98587fbef7f 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5479,6 +5479,7 @@ EXPORT_SYMBOL(drm_dp_mst_atomic_enable_dsc);
  *   - 0 if the new state is valid
  *   - %-ENOSPC, if the new state is invalid, because of BW limitation
  *         @failing_port is set to:
+ *
  *         - The non-root port where a BW limit check failed
  *           with all the ports downstream of @failing_port passing
  *           the BW limit check.
@@ -5487,6 +5488,7 @@ EXPORT_SYMBOL(drm_dp_mst_atomic_enable_dsc);
  *         - %NULL if the BW limit check failed at the root port
  *           with all the ports downstream of the root port passing
  *           the BW limit check.
+ *
  *   - %-EINVAL, if the new state is invalid, because the root port has
  *     too many payloads.
  */

base-commit: 59be90248b422f2924872de0be2867652214096a
-- 
An old man doll... just what I always wanted! - Clara

