Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA7768358
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 03:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjG3BaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 21:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjG3B36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 21:29:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F0B2D47;
        Sat, 29 Jul 2023 18:29:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5222a38c0a0so4805427a12.1;
        Sat, 29 Jul 2023 18:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690680595; x=1691285395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h47PWxUJY4ooXK5fyJ1q9IFAXzuyJeCww5vmtT3W8Jw=;
        b=WtHtHnhpzrNfanl1IxPrvzjwqQr8inR0FCK6nee5iV+tBAaPDx9mH1DYToQj/mjDPc
         RNnnhTe6v4sz+AAtY3yrtHjx6jTqME73g7Bed64St1cPzYD8xN0zYMFHOsOMVytLesCI
         j49pisHPJ1ZHW2PmKpV+jDrJflrLWEqUEdGVeTMJTAMsBSgNPXQiI3HWeiW5hrXZRw3j
         69CBZnLGiSJg5JtTlniRzHI0iT5wFrwXWuM1zWmTOM8Yzi8EbdazTRQToaQ/A9v1Czo/
         vqouKQ+zDmd5+l/mT4RA9Ku31POAqG1Ixi67yKnKvuJ53fnFHK3dW+sSuQWAlhuM5U92
         6VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690680595; x=1691285395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h47PWxUJY4ooXK5fyJ1q9IFAXzuyJeCww5vmtT3W8Jw=;
        b=BUPbiS78iLJoW5udasBjD8HloPu/Xo71wDbWH5540FKzWs9e+cu0KMfYIF4MqIsqwY
         z9N2l60ud3+TdJjiAQqk0HlAtCoG1m81QCYy27VKuvIzVHUvij/l8QKt5XUOhmKMDoxL
         8XQTxfHmXwqW/WHK1CpbtU7iC6JnaVVzflT0w6qyDtkiyFWArJqc73nUZNfg1hasYmOF
         EXqV/fbv8rh2AMys/MhvBt0JtXgGCr7ZziresBPHj+qDBtXYl5+aVKnCTcz5UCW9a8nZ
         ldz/eNrtz7VBwdZWqYwEVuUfQzXGz+4V5OpVY1mBgZk3A7261DpaILb1yG081GFY41nF
         dnnA==
X-Gm-Message-State: ABy/qLZdV6nJsKWjmnH/Pboxs/rczW5tseg95gTfZkREf3gLYFCf+vdS
        aYv8kRhvvBytiOFvKxZu9NU=
X-Google-Smtp-Source: APBJJlEkJu6s8QxmoLE96Yye3e2+9QK5Uyie7INpCXldI4pQMVQZsqd2MLR7uzaqdFoij/rMiCJy4Q==
X-Received: by 2002:a17:907:2c75:b0:997:d627:263a with SMTP id ib21-20020a1709072c7500b00997d627263amr3201488ejc.67.1690680595028;
        Sat, 29 Jul 2023 18:29:55 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id e1-20020a1709062c0100b0099bd5b72d93sm3931957ejh.43.2023.07.29.18.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 18:29:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id CD2D127C005A;
        Sat, 29 Jul 2023 21:29:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 29 Jul 2023 21:29:51 -0400
X-ME-Sender: <xms:D73FZE9nU7AmMxu16XtN5KzCEil9rkxqQ_E54Brpl1yAJZ86mDU9mw>
    <xme:D73FZMsSHglK3cdwGsiB4RD4wmuZtOqzhE9AaB_mvcHCfzSB7jv8j9F9DPS7Z04Vp
    obwdDM6tMGhxoFXSQ>
X-ME-Received: <xmr:D73FZKC6NDtU35FazVZGwwB-uccL3lYLMOHe8blrHGGxpIZKT183AegcmTeKrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieelgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeetueehteefjedufeefleeifeehgfduffejfeeiteekheejjeefieeuffeu
    ffegjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:D73FZEeigqXMs4pMGNfXUu--u02QHHWxwuSC09bGPBl6SP4iHx8RHw>
    <xmx:D73FZJOmIj50NppVLh2sKjxROe5nixtRMmw48R9v8-4aok7WNA4ipA>
    <xmx:D73FZOma0yDArd1g8lJBieHhMkz18R1GuJMTzEB094-UHM18w0XEmw>
    <xmx:D73FZMdsLUKMTKxDsS7oIIlz6h6ZULvsAnODaHmVopZeTj4QVJbRVQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jul 2023 21:29:51 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Subject: [PATCH 3/3] rust: alloc: Add realloc and alloc_zeroed to the GlobalAlloc impl
Date:   Sat, 29 Jul 2023 18:29:04 -0700
Message-ID: <20230730012905.643822-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730012905.643822-1-boqun.feng@gmail.com>
References: <20230730012905.643822-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Roy Baron <bjorn3_gh@protonmail.com>

While there are default impls for these methods, using the respective C
api's is faster. Currently neither the existing nor these new
GlobalAlloc method implementations are actually called. Instead the
__rust_* function defined below the GlobalAlloc impl are used. With
rustc 1.71 these functions will be gone and all allocation calls will go
through the GlobalAlloc implementation.

Link: https://github.com/Rust-for-Linux/linux/issues/68
Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
[boqun: add size adjustment for alignment requirement]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/allocator.rs | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
index 1aec688cf0e0..6f1f50465ab3 100644
--- a/rust/kernel/allocator.rs
+++ b/rust/kernel/allocator.rs
@@ -51,6 +51,33 @@ unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
             bindings::kfree(ptr as *const core::ffi::c_void);
         }
     }
+
+    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
+        // SAFETY:
+        // - `new_size`, when rounded up to the nearest multiple of `layout.align()`, will not
+        //   overflow `isize` by the function safety requirement.
+        // - `layout.align()` is a proper alignment (i.e. not zero and must be a power of two).
+        let layout = unsafe { Layout::from_size_align_unchecked(new_size, layout.align()) };
+
+        // SAFETY:
+        // - `ptr` is either null or a pointer allocated by this allocator by the function safety
+        //   requirement.
+        // - the size of `layout` is not zero because `new_size` is not zero by the function safety
+        //   requirement.
+        unsafe { krealloc_aligned(ptr, layout, bindings::GFP_KERNEL) }
+    }
+
+    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
+        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
+        // requirement.
+        unsafe {
+            krealloc_aligned(
+                ptr::null_mut(),
+                layout,
+                bindings::GFP_KERNEL | bindings::__GFP_ZERO,
+            )
+        }
+    }
 }
 
 #[global_allocator]
-- 
2.41.0

