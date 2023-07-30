Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BA576835C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 03:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjG3B37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 21:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjG3B34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 21:29:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3162D42;
        Sat, 29 Jul 2023 18:29:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c0cb7285fso23510466b.0;
        Sat, 29 Jul 2023 18:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690680593; x=1691285393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PhtA3S/JDjazeAwjyLjhNAHRYNrsVmh0Eu0g8T30AIE=;
        b=GxodfzLoeHEML6pPfMb2i5ubNXaelxwAO2W34igO8jTtDBLWAt2ufATykcytjJB8XK
         vRDO87nLa5BC6iBaAXZRhxA1WdUZnyXa6Oka3eCRskFpe0sphP2EKno+HJbCKkry8KOy
         /e7Kp1UbvgRvyH3FITUQ897aimqik+1v8IU1zDld5RkiJkubHET2EMfJ3SVYKX9+yDrW
         uci5ip+cKB0n4I4oupu75FnnBpkAAnFeRtrcpnzq8QYdWnzCksKBWKPhwd5vBad4Dkjw
         /XZJ4UfgI2saPGQ26eXmXctum+25eDOYCjhFIfpibT9wOEhjqBpY8pdiT0Lr+uNJjt+w
         p0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690680593; x=1691285393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhtA3S/JDjazeAwjyLjhNAHRYNrsVmh0Eu0g8T30AIE=;
        b=H4xrd1bM20/zSK6tgcu29WAB6swX21hPDrD0Ec3esSOkeNkg9ZSCo6OgN9MKq01fg2
         RznhtbxAORJCYkpMyAAcMRKt6cKcMp3e3Hp0xA01V3B92VRrtlYlbE0cO4mDuuZ9UEsN
         9uNOFPQgMQ2fZFOXmZ7c8nFwhdCJ8hzYLm4EGohkmeOv1Ild2JGzV5wjNb4Efjr2mB6i
         rO5g1hgyNGUbvL/f5C3z4eXUR/BCoBo0vRB7dDj+W83nLj4NimtZJrLqwRLzN/d3eag7
         VVf9FV0jZCRGlhMHMfcjksftS2fuZGWgxqpRshlkwroaCw8uOOi+UcGzMPkVkRQoe86Z
         N8Mg==
X-Gm-Message-State: ABy/qLb4gPURkEpyTUTawhG20oEBkz572m0XwiAGjxi4stAWCUfQxv28
        HKjRVdPkHdpf1ahcwArJyfY=
X-Google-Smtp-Source: APBJJlEWZ4fEpFiRMrw7EC3MVm+HdQDWtlmx77hRPTswhgISe7d/3BzMSMsMz0JaEbUxAOd2etsRKQ==
X-Received: by 2002:a17:906:32c3:b0:970:71c:df58 with SMTP id k3-20020a17090632c300b00970071cdf58mr3269835ejk.42.1690680593477;
        Sat, 29 Jul 2023 18:29:53 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906c30400b009926928d486sm3948593ejz.35.2023.07.29.18.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 18:29:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 45DFB27C0054;
        Sat, 29 Jul 2023 21:29:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 29 Jul 2023 21:29:50 -0400
X-ME-Sender: <xms:Db3FZE1GxCqIWq2al3xY7sdKyNYUcLriwoJ6GnSs3WmgCt4C2LtwTQ>
    <xme:Db3FZPE4rWmi_SEddURyN7tnU1pTCEd5PMxyPV3srMsjG7wFmopNd1vbTDIL30G6S
    UbpsHvDk0wLzW3r9A>
X-ME-Received: <xmr:Db3FZM4cdhN0ppkiWJfM9C00StddWqpaeR8r2a9GeQ6mmuVTon7XQU8ndPbj0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieelgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfevffeiueejhfeuiefggeeuheeg
    gefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Db3FZN3D9t38mabmVh4bYeFHm-a87MoF_QiVq5nQtu0MpCUCA9mCFw>
    <xmx:Db3FZHG3Cagdmaea71yV0Bz0rQ15OWBE2R4tgmKtSP00zAYteD-E4Q>
    <xmx:Db3FZG89BeKQhElW2bXEtDpBOZ9hC6zmgV4vcj8biZplrzYg3FmY9Q>
    <xmx:Dr3FZPV9YYfvEQ2FM6VcuWtp2OsipSMfpdxGapdDU4azLUJkdLgNXQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jul 2023 21:29:49 -0400 (EDT)
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
Subject: [PATCH 2/3] rust: allocator: Use krealloc_aligned() in KernelAllocator::alloc
Date:   Sat, 29 Jul 2023 18:29:03 -0700
Message-ID: <20230730012905.643822-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730012905.643822-1-boqun.feng@gmail.com>
References: <20230730012905.643822-1-boqun.feng@gmail.com>
MIME-Version: 1.0
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

This fixes the potential issue that when KernelAllocator is used, the
allocation may be mis-aligned due to SLAB's alignment guarantee.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/allocator.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
index fae11d1fdba7..1aec688cf0e0 100644
--- a/rust/kernel/allocator.rs
+++ b/rust/kernel/allocator.rs
@@ -41,9 +41,9 @@ unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gf
 
 unsafe impl GlobalAlloc for KernelAllocator {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
-        // `krealloc()` is used instead of `kmalloc()` because the latter is
-        // an inline function and cannot be bound to as a result.
-        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8 }
+        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
+        // requirement.
+        unsafe { krealloc_aligned(ptr::null_mut(), layout, bindings::GFP_KERNEL) }
     }
 
     unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
-- 
2.41.0

