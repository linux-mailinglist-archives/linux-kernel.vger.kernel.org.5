Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB67A0FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjINVOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjINVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:14:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9019A26BB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:14:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d814634fe4bso1775445276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726050; x=1695330850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Utwbn05dq1P3cRtHOia0ZZtBcmsSMx5ruKCs/P2Bvow=;
        b=gRTzGf5Wgw2/H/KNWTK1j/bD4V/KwuvMUyaza2R89tJgLBrYSUdgJMAxc7V9ImBd0Q
         yzFczZDEXLMiJbifoR6wn16NA1LpgqL1WSn2xcee/1ap5qFgYeahbgzukzZ4D2aF6+Y/
         9V2wR4g9vgj8JF29uEzAnenVLypQTi48j/Y2j96/Uvif6V2mIrqQh/P7ffNmzX81UiTS
         5uY/pah0U+yLnXd+fCdi533XFm1k3WIKZVoSqxxvy4IcEV7qhjWvDEBw+JmfbzsflEMr
         KT6dfc1SZApAvBJSxtihtVpHgCvluI1Vtk+scr8JvHrHc0CGXDJO8qvAFG6KDOmVS+HF
         V2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726050; x=1695330850;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Utwbn05dq1P3cRtHOia0ZZtBcmsSMx5ruKCs/P2Bvow=;
        b=O0amkXV/xv6JaptQVysjqMrnvLR9LitDikTjKRt56xE9GH1nONsn18gDdoICSFNzJp
         dEIiS6WCrsa3t23EjHIt5EhTPBGMlTC13Ih+jx+FrDtF0G7FmLuWjaBfaFY5M1g6yQFU
         y8nSdz/zsCVBZedpmtCPxEs9aiYHzPG52yGgUKxcqE2Pr+Pgv4CY5kYGh2+Xzz/3YLCc
         tqMDLVzUqTJPaM9jGkGCCr/nyZFjOWQ+rK/i4Bvmu8KkFShi2Tog7OnjzRa6U2PNm2A5
         oLbI6M7O5ELoKrmBIRw/Qib/eRZCV2d9dKI/KyLperwQ6j+ryDuSVaJiJ7iCdF3rsrbg
         dNfg==
X-Gm-Message-State: AOJu0Yz3y5Dc0Io9idDoPAwxQ/6djZriBMQdtlmVdc79NnsDbGuomlQl
        5T7w5Va9psT8BnoYL5sDOlrHviAKfGiaQed2hA==
X-Google-Smtp-Source: AGHT+IER36kioS8OEQ6mW1MX0UaEyRGxkscXFet8xuTfWHv4C/xW3RLVWiv7TxQnUUbCzU6IzHZhFSDlYovg3BK4jA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:385:0:b0:d81:bb31:d2fa with SMTP
 id 127-20020a250385000000b00d81bb31d2famr27447ybd.3.1694726049875; Thu, 14
 Sep 2023 14:14:09 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:14:07 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ93A2UC/x2NywrCMBAAf6Xk7EISFRp/RURku42L5sFuLJXSf
 zd4m7nMbEZJmNRchs0ILaxcchd3GAw+HzkS8NTdeOuPNrgTaJOM9QuT8EKiEOuncwIO7gyREii 950baFFLB1x1LbrQ2QAijxZEQe8Wb3q9CM6//9/W27z+CzKY7iwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694726048; l=1748;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rUGaAKYDAI4tRkXj4vLoGXXH5bgLIpzt3gFa14KFRqo=; b=UKJjqLcZ98/YSLUUQU9h/fX9EPUL6MGCgnZQv0LIXvqtcWCkalUmCEO2+q3xYXDVzZmuDBhh3
 5Vr6lYASBMSBjn/LjbYtIm2jODAgQdE0C1Pnma6HaMChyGag60U+ITo
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-gpu-drm-i915-gem-selftests-mock_context-c-v1-1-c3f92df942e0@google.com>
Subject: [PATCH] drm/i915: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer without unnecessarily NUL-padding.

`ctx` is zero allocated and as such strncpy's NUL-padding behavior was
strictly a performance hit which should now be resolved. It should be
noted, however, that performance is not critical in these selftests,
especially by these margins.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/gpu/drm/i915/gem/selftests/mock_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/mock_context.c b/drivers/gpu/drm/i915/gem/selftests/mock_context.c
index 8ac6726ec16b..025b9c773b93 100644
--- a/drivers/gpu/drm/i915/gem/selftests/mock_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/mock_context.c
@@ -36,7 +36,7 @@ mock_context(struct drm_i915_private *i915,
 	if (name) {
 		struct i915_ppgtt *ppgtt;
 
-		strncpy(ctx->name, name, sizeof(ctx->name) - 1);
+		strscpy(ctx->name, name, sizeof(ctx->name) - 1);
 
 		ppgtt = mock_ppgtt(i915, name);
 		if (!ppgtt)

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-gpu-drm-i915-gem-selftests-mock_context-c-980c8ecc9142

Best regards,
--
Justin Stitt <justinstitt@google.com>

