Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75B07A10C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjINWRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjINWRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:17:14 -0400
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EB12720
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:17:10 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1bf00f8cf77so2111197fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694729829; x=1695334629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NmiSL1hPoXorfA2q6qNOq7ioFso4QUSjYQj36GecrTE=;
        b=xkngvD2Ibfn8w03jxth/IdNDuHUov2S9wEE3mKAgK6Q1mChzRVyw499SXq0AUo289Y
         +JKqJd5TxrL2PO0QKNR23nWlvl+MrmwriQSqIDEvCUnQd7Uo1p0lI6XDj9OYqGoIkXck
         J52jeUoyaC9rVgZDVdETfWrEwEszVZ7TSIDG2h37hl9k13Tq+YmW9EiDJUA51/nf10WK
         BZVMls7AVpXNkoY3o0KpqXGp6n2kd1H6koJZTJ4EMOE2GfZ8txQDffzrlTUlK6yqOwur
         qV+YJoBcWV7/tAxy6NAzSig4O+Rx095bL6zYNVPjmsp0kcIPm3buw0KK2lkdTG32viMt
         KB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694729829; x=1695334629;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmiSL1hPoXorfA2q6qNOq7ioFso4QUSjYQj36GecrTE=;
        b=U/kESbmecpBxT9QWOsdzhGkrnQU6k3hg5D3+9YkFDEDGHsn5hUFVmFWluaBpKWJ1jy
         93vZWiduuBGdGNOIhG51Qv/tkdqH2LyBIEaLw4BQrq72SDlZuseWw1oCkzfPeBjWcVru
         5uNt/KMDIizwKrZMhiGM3eFeaht/FAbsii1K9JD+FLyYa8QRHt4brRb5WP1+0XTajqlz
         viEVEZh3OF//5V3p1WbAsRBCUSNBkoy1HsXZEROEWddZxDF0zWxG8A09RYqyk0ZakcuL
         FDtNOZzSJPsOzS0T/LRfUjwOhyREB8eTNRpyhtRtq+7+UXZoHLhommDTAH2Qn8BJX0Zx
         zClw==
X-Gm-Message-State: AOJu0YzI+comCUVerUziMYny8qq9zaX/W/DC/jdStUvDioWxC4VuuP/m
        KJiREBIvff+Hy7PUvhpvsoOgLHqtYwUc7QT/oA==
X-Google-Smtp-Source: AGHT+IFwcROu4zar64CAvXwI9J0nMFhba4+cLsta+BCeiKNlxnKo7O4A0MBXBGcuyAHHg0RNV0zPR7a2HtcCyI3FeQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:5b17:b0:1d6:6175:e8b7 with
 SMTP id ds23-20020a0568705b1700b001d66175e8b7mr704oab.4.1694729829605; Thu,
 14 Sep 2023 15:17:09 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:17:08 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGOGA2UC/x2NQQqDMBAAvyI5dyFqodqvlB6SuEmXkjXsamgR/
 97Q28xl5jCKQqjm3h1GsJLSyk36S2fCy3FCoKW5Geww2rm/gm7CoXxhEaooCqnsjTPwuld0O3B 9Z0BOxAglg3eKEGCcfJzDbfLBRtPaRTDS5/99PM/zB65MP5KHAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694729828; l=2319;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=RxOj2KRPJoHaPbd44NSfvp7xlYOfBBUfmUGMt4NplWM=; b=DjqYwwhRW21CQ5QMz9Kq/kMZK/2XQMBC1ojIhEn54/lvBB1ZMdiXQOPyCP7EYWc+wzaWYIxZw
 urNwQ6OfNmeAjWVrv9S1uYW4YBYQvugcZXBlGnwgHVmMTJgXi8klaNc
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
Subject: [PATCH] drm/nouveau/pm: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
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

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c
index 8fe0444f761e..131db2645f84 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c
@@ -462,7 +462,7 @@ nvkm_perfmon_mthd_query_domain(struct nvkm_perfmon *perfmon,
 
 		args->v0.id         = di;
 		args->v0.signal_nr  = nvkm_perfdom_count_perfsig(dom);
-		strncpy(args->v0.name, dom->name, sizeof(args->v0.name) - 1);
+		strscpy(args->v0.name, dom->name, sizeof(args->v0.name));
 
 		/* Currently only global counters (PCOUNTER) are implemented
 		 * but this will be different for local counters (MP). */
@@ -513,8 +513,7 @@ nvkm_perfmon_mthd_query_signal(struct nvkm_perfmon *perfmon,
 			snprintf(args->v0.name, sizeof(args->v0.name),
 				 "/%s/%02x", dom->name, si);
 		} else {
-			strncpy(args->v0.name, sig->name,
-				sizeof(args->v0.name) - 1);
+			strscpy(args->v0.name, sig->name, sizeof(args->v0.name));
 		}
 
 		args->v0.signal = si;
@@ -572,7 +571,7 @@ nvkm_perfmon_mthd_query_source(struct nvkm_perfmon *perfmon,
 
 		args->v0.source = sig->source[si];
 		args->v0.mask   = src->mask;
-		strncpy(args->v0.name, src->name, sizeof(args->v0.name) - 1);
+		strscpy(args->v0.name, src->name, sizeof(args->v0.name));
 	}
 
 	if (++si < source_nr) {

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-38bf9c78bc0f

Best regards,
--
Justin Stitt <justinstitt@google.com>

