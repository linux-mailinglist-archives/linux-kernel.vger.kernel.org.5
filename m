Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2554778DD70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243919AbjH3SuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244704AbjH3NrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3915C107
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uG5M2Lwpie6cChdlBf2i1g6i8ozHuD8iPPR+2gMyfYc=;
        b=g/l+PkCMGx9sWGN5eBN5jsf85xnUUfy66IrogE2JUurfNX5H1PCw4Pkb8dY/SuMPQdfx3y
        u6i6dnlH1+P0Bv7CSUxPxSSqLiblE4QCq7PjVdWTV8eh9N2vSZ/Kx/dqASPvxDatARsPC/
        iCyMh88PSSvBVr77qVs4RyBvKOb4B+w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-HoSfqRSvNyOmys1Ht87gBg-1; Wed, 30 Aug 2023 09:46:30 -0400
X-MC-Unique: HoSfqRSvNyOmys1Ht87gBg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51e3bb0aeedso757014a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403189; x=1694007989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uG5M2Lwpie6cChdlBf2i1g6i8ozHuD8iPPR+2gMyfYc=;
        b=WF+6yazI3VMfQO3YCGesmgftJRjEOdVg27wmzYjsAvL0G9uUb0kdw/bFOLnDIfQhzE
         ZY7KCzfngwyX/Lwgw0yxH+jbTkCQvrLusxOF0zb5I/lO7JKiGbGMhdDxO7WlBGnMp9Yl
         WDSCRaFsscTIyQWlNESYElF49bi4fBlIAQ+5gAVaxaYh8BGm1pHdxBPHKGL8o+g8o+IS
         2CfhWkBon0Mzswp/NQ93Xx71xAYgkpHZohW5MgUalL0AYQ6cN447b9JfgzwmEqLNksjp
         odt5G1oAlnTRgv8ehU4anpgvqKX/CCto0KYID9B62h8I9ruWXKJYjwJr52a9hy5rJM/6
         OtKw==
X-Gm-Message-State: AOJu0Yync4nsffJ5Y3cY3cG4+908GV3wdSv4fpnY+X1qQhSgWZWznwUp
        ZrUCWGK/MoXU6XFMwY9b+sX7jBsWPK6n579YHEH/YNb86RuJ42hL36XN9XWlZcE6Smcws5owxQ8
        gbC3b1YGDY2Jx+TCSzdqjfYOY
X-Received: by 2002:a05:6402:50cf:b0:522:e6b0:8056 with SMTP id h15-20020a05640250cf00b00522e6b08056mr1964356edb.4.1693403189068;
        Wed, 30 Aug 2023 06:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpKYbKxrilyWwmvyGSQuR3YdE5ziBNReJitKpOxi4O0anKghb3+MxxX32nil6cbORrhxRuFQ==
X-Received: by 2002:a05:6402:50cf:b0:522:e6b0:8056 with SMTP id h15-20020a05640250cf00b00522e6b08056mr1964344edb.4.1693403188914;
        Wed, 30 Aug 2023 06:46:28 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7d297000000b0052595b17fd4sm6683260edq.26.2023.08.30.06.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:28 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>
Subject: [PATCH 2/5] kernel: kexec: copy user-array safely
Date:   Wed, 30 Aug 2023 15:45:53 +0200
Message-ID: <0a3f1bca273792edbdc41b64c454a6f7f499c9a8.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693386602.git.pstanner@redhat.com>
References: <cover.1693386602.git.pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 92d301f98776..f6067c1bb089 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -242,7 +242,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
-- 
2.41.0

