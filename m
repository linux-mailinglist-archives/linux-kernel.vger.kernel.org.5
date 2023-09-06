Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A627944C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbjIFUvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjIFUvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:51:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E14B199F;
        Wed,  6 Sep 2023 13:50:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c336f5b1ffso1970775ad.2;
        Wed, 06 Sep 2023 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694033457; x=1694638257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntkeD2GzDhcOIlti0nenV0eqBlUuQFPFxpxBV7T54Yo=;
        b=cGhHv2M6LMXYbGWgWwmudzIOD7IgGusmvzykBKwUziZ4LeYc2EgWsNdjEtaA99FnNg
         dzi+FGmrW89nVRqMHcCBz8L97hY9La42aBJGzoX8e2sywl/bzHRL7V9kUkd8DgeYtlwv
         nONIWROlkwxmTmqkxs7nPsrj9DZYI71u0r6217Kg+PL+Qv2IMUjtSqTazJSkwEsuglyW
         nEN45oNWSm+5b1+s3cVlWzSRWAMN5ke+cmTYau8utcoCX9karh6ZW0lRHVLkp32ly4/E
         u5IRCL4u+JGZYOWH7iRQ2RIcTOV6wRqs4OxjzfKEqWfijUMiM8q33Vgp7W2wBf+goW7r
         tvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694033457; x=1694638257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntkeD2GzDhcOIlti0nenV0eqBlUuQFPFxpxBV7T54Yo=;
        b=WuZyU/8uulhZR5mPlNjs5/wm12TqjZyzMsZWxA7oXHROaEX5h3KDi+T6u4baLiILPR
         ssgdgYqlmRs+6pqcM9VdZkJR2qDU+ONj8CfdKK8rj2lz3GlD2ILALsXdhfLzrRSrTOvw
         2uPq1kY14LysRvZyqep04SR3g3UHjYOS5vEiqnk86rV170dGCYAoaWzVuN9v93z4VMlO
         Heu5iJJX7qejLIj4EJQgIGp24dU/OYmlmqM+mi3cOWwOy8zwkeUJl41TvFpFfZRzdzDq
         7d1baxXSIPOW4skyFVvdT8W7xb6bLNU09na2Lpkcao6Fp0UxUM7n0sVZ3LT5JbDo4JsA
         KtkA==
X-Gm-Message-State: AOJu0Yws7u3uuB4Axr/XVi0T2Fr556AT6c+IozLub9imI5FnS0YxufPY
        pQ28nz/9URmw4089wiq109xkOGQKvp4=
X-Google-Smtp-Source: AGHT+IEWWvBi4fya5NjGYF87fcuug7M4Cz6Bvv60hgETrRATd3dF7O3XQ7p+k1MEZzyNgG/YOhkEMA==
X-Received: by 2002:a17:902:c404:b0:1c3:3682:f83f with SMTP id k4-20020a170902c40400b001c33682f83fmr13572339plk.30.1694033457342;
        Wed, 06 Sep 2023 13:50:57 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1c23:3930:f482:ec7e:9b42:eaeb])
        by smtp.gmail.com with ESMTPSA id jb15-20020a170903258f00b001c322a41188sm8443979plb.117.2023.09.06.13.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 13:50:56 -0700 (PDT)
From:   Manmohan Shukla <manmshuk@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Manmohan Shukla <manmshuk@gmail.com>
Subject: [PATCH] rust: error: Markdown style nit
Date:   Thu,  7 Sep 2023 02:18:57 +0530
Message-Id: <20230906204857.85619-1-manmshuk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a trivial markdown style nit in the `SAFETY` comment.

Signed-off-by: Manmohan Shukla <manmshuk@gmail.com>
---
 rust/kernel/error.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 05fcab6abfe6..6233021daa8a 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -133,7 +133,7 @@ pub fn to_errno(self) -> core::ffi::c_int {
     /// Returns the error encoded as a pointer.
     #[allow(dead_code)]
     pub(crate) fn to_ptr<T>(self) -> *mut T {
-        // SAFETY: self.0 is a valid error due to its invariant.
+        // SAFETY: `self.0` is a valid error due to its invariant.
         unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
     }
 
-- 
2.34.1
