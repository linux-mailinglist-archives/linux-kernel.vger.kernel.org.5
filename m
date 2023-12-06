Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6EB806B57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377410AbjLFKJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377412AbjLFKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:09:42 -0500
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com [IPv6:2a00:1450:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB5ED49
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:09:48 -0800 (PST)
Received: by mail-lf1-x14a.google.com with SMTP id 2adb3069b0e04-50bf1bbf67aso3230753e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701857386; x=1702462186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1L9PtqvjoQFgO5q+VnM788vYaeOUUwutSgupIUHrpw=;
        b=YvSNrajpI6D3Jtgrhf87UOkAQtV42jT6EuKVxcORvVfGmOBjxQwf/468Bfmb1Tad4w
         1OG5QbY850Nsq5K/1qg3meLgwRzJoi7geNkugR5aiXqrKdt2Z3N9Zw2hD+W3/KHAr8rA
         ++uwupYC8+5W/+613FbIvS3CeRMPtD9J23yyyfbSTVx1EL8uKgzx+2j1mcARMWGDTxrD
         33B6iu+1Vc6/z1g50EMcZk0hVY9K/ZvfYhj9+3vwOgG3jiI8veHsyfCdC2qwa/oDFrdk
         z2vZbDaybdLwA5BiXODRoKLYm8OBWq3mUfoy6BYogLIqhPt2qBxLK044cU2kyvWqDHxG
         pjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857386; x=1702462186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1L9PtqvjoQFgO5q+VnM788vYaeOUUwutSgupIUHrpw=;
        b=j6GhZ0GtsP/dyx45wFEeZPfF1auxmCmLIhi8f9Kn90/qc4T4MVbUcp2+eSyGkmHjJ+
         UR794Esa5SUq16bPGzrYCF3ErLMOBalezq5fqGEKb4msMqBAPy/yyIGf3e5l9WEj9xBI
         64GNfpZEYUqFUSftGyjP1woHhRklhZlWhSOqQz7Z1bYIEbLJ9rj9t+m8tSxlHQr0z63g
         tEqZYMLbpKa2BHW8n1mnSm1+e16V+ctIXrQAq4/MQ5pVIiOejnHNggvGnU3Iuc2n59HS
         IQCmi815tmRsinMmTmGkzXmhaoAEDIJSSoHYC/VMJhrKh0rmxi/HNy26hSw/swanZ/gq
         645w==
X-Gm-Message-State: AOJu0YzLCH/+2Cf51htq9sJImoTXmC7PSI8+JF/Hv4W2c4p1sY0g1osC
        /ZSPD2THQec11sjCqtPHBbbtVQ7Ow9C9BjE=
X-Google-Smtp-Source: AGHT+IGcZaa0HIqhd1WvwmU9/aezaZATfqG4dYdD1uU8/+cxuckpLe6BI/oIuVMP4tyS6jJfsHxO67Crxq6ZihE=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:5f6f:0:b0:50b:f822:eacf with SMTP id
 c15-20020ac25f6f000000b0050bf822eacfmr7060lfc.9.1701857386498; Wed, 06 Dec
 2023 02:09:46 -0800 (PST)
Date:   Wed, 06 Dec 2023 10:09:23 +0000
In-Reply-To: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
Mime-Version: 1.0
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=gjsFTUAv4pM5ZDJTd0sbTeFQ61hWz6BaOzuWVUqxq5w=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcEhjgsTlj7q910nqwwTDSnkQsaj8PWPzf/p24
 xNoUDnQ9huJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBIYwAKCRAEWL7uWMY5
 Rhx4D/9VIZRDqteITL/cUGikpx6VfrHfTxuyPcTCIR+GBin1ORtXgW+Bt6OwxBi3hwmsdrhgAbD
 3108bBJ5qfRCoI6Lt5pmvQwWE6X1rBF1CWvwWhJHseTDg5ddzP9IiMRforJXCt7kitqp1ORX2TK
 i+1/aJomLqn7Wgka2NGua5btH6ixeZetd7KZMe+0QeeYMM7326rbf16LSoOSOcHcZSzL5vAxD19
 F/H+hEfilOKYsoVGpFPbDYpXcO7zIuWfKVssGmFXhpROxJM4iFdDytnmXsv3d/Ak76N+hJBzcn9
 ZJi5twiTHlgWjEclmhEVG7vJA9mmnGfKPWv0ddRn1+d+gXksYgqDInQ/vS3XrkuC7VP5aegFabQ
 tPjSCyS4iJh75zIgbdPgDISDIwict5SjjC0MNli6WI5pNOugCjP5fekPne54LC7aSsAUGLsa6PI
 vWFX1AsnQViiHdsFFnPVbTRYc0V8o07TbPdlx4tMsdJduWvF8+wW5IGZ1IffvFess7dcrksF6np
 AikW4+oesXvSf/CMoXl+kJy9EcxcXRP91Oec08ayBv4KSdRit3ScvYmjsE6PdxARtylFOhIR87I
 7OM/5aalMAmvl3lHw52Kn7b7nxBalpM73+jnBjzKnqz/FO2j2Cm4jTNm685HgT6o/+FkGG5PPRB /L7P5iNaWdSc9+g==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-rb-new-condvar-methods-v1-1-33a4cab7fdaa@google.com>
Subject: [PATCH 1/2] rust: sync: add `CondVar::notify_sync`
From:   Alice Ryhl <aliceryhl@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wake up another thread synchronously.

This method behaves like `notify_one`, except that it hints to the
scheduler that the current thread is about to go to sleep, so it should
schedule the target thread on the same CPU.

This is used by Rust Binder as a performance optimization. When sending
a transaction to a different process, we usually know which thread will
handle it, so we can schedule that thread for execution next on this
CPU for better cache locality.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/condvar.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index b679b6f6dbeb..9861c6749ad0 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -155,6 +155,12 @@ fn notify(&self, count: i32, flags: u32) {
         };
     }
 
+    /// Calls the kernel function to notify one thread synchronously.
+    pub fn notify_sync(&self) {
+        // SAFETY: `wait_list` points to valid memory.
+        unsafe { bindings::__wake_up_sync(self.wait_list.get(), bindings::TASK_NORMAL) };
+    }
+
     /// Wakes a single waiter up, if any.
     ///
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost

-- 
2.43.0.rc2.451.g8631bc7472-goog

