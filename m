Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D924768354
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 03:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjG3B3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 21:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3B3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 21:29:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23852D42;
        Sat, 29 Jul 2023 18:29:51 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9923833737eso476261466b.3;
        Sat, 29 Jul 2023 18:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690680590; x=1691285390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sHPSm4abOb9l98MpBhFZNGhszS0pZcdCCKi7Bi/pqvI=;
        b=fSTNlLWfNz4UoXw+opBwkzeopFwjV7EL7X41MsBp7VcgKq6HqR//8ybtgJ5qfzp8FG
         8gPfw76VQ/dmmaLkQY0IpqGwQ6a5B4djKNavWZ31xu/m5/b86+xEs4PfEjsWJdP0IdlE
         UpoSAalXythXlkg+YPSxc4KupZQZ33rixHeuuE/b+TXziz/718H7RNFxqid6VDdovybu
         U8PTWarYha5UcupNAJIHdBD/4q2T57x5J9bs8dknAbhVyMkvwcZ9DGuG13p8nXVHDdZg
         pEdi36dEO6bChjtC3GCtaHPi68XE1NY9lqG3t2W5f1lZBLyi3kcVKu7XhHKZp+k5fi/p
         Ed1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690680590; x=1691285390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHPSm4abOb9l98MpBhFZNGhszS0pZcdCCKi7Bi/pqvI=;
        b=kducRmZ5v2Ihu0u4bDCj9avblYUs+L/B8XM/ZbCKiEIDBhiXhp71KB49bAOnJKQFKL
         t02F4yE1mP48K/Vbd3wXSBCNxXQyVjtubHD6w2v79KQMBNQPv0FEPUZlNhZk+WnIDcGB
         O9pBUqQ/zWrpunn3Ea8r3Rlm90Mr87CAQKgihsZonpKelWjlAAbtFPA97HngBb+IT6R4
         vA9BNQUuQYsJOqheqCpIo1iXXnXqbJKk95YknpCno4VKlFuydLGxMQWc9129/E4Sc8ai
         M6kxrphRntFl6tCyLLKBtPjwMr6MJQddehBd8FlxxAZiCj38AYRoJsfv8MEjvD6c8cww
         9pMQ==
X-Gm-Message-State: ABy/qLbmrvTNhdtmsSwaY9UkqEqt+9yCKYzWMd9Sv3sslGLtdxHrPZef
        6N/0LSDTA24SnoQ4lRI2l8o=
X-Google-Smtp-Source: APBJJlEnRj1eTU/0PQU8AhT5UyCJsLMVbQ5xl0KZHPACbfNIzXty1iKA/b58dLi7nUq/bBkNlbSxFg==
X-Received: by 2002:a17:906:1cf:b0:99b:ef86:60d8 with SMTP id 15-20020a17090601cf00b0099bef8660d8mr3401915ejj.5.1690680589930;
        Sat, 29 Jul 2023 18:29:49 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id br15-20020a170906d14f00b0098e42bef736sm3995349ejb.176.2023.07.29.18.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 18:29:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7477927C005A;
        Sat, 29 Jul 2023 21:29:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 29 Jul 2023 21:29:46 -0400
X-ME-Sender: <xms:CL3FZMEyyC8cCS8LAPoHCHV-R9F9B0FTE6qYlXDqW_4JBKv04axOkA>
    <xme:CL3FZFUeuaV05z_zuUXnSGDjBqSXd1Xcu5fX5mEnI_1kqYboDv_q5Rne32f0fPppD
    mM5ccQXHUUI00qZ3Q>
X-ME-Received: <xmr:CL3FZGKgzoTkxAJpVtf9TkJzwQKmsKFZP_g99bDlJ_dCwaUnVBuSwzk_NzQWGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieelgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeekgffgveeutdeuhfegteevudduffejjedvjefftedtkefgueejgedvtdeutdef
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:CL3FZOHBTUu1zU48DE7n8v2EiK5Rfn4R6Rh8cvcmjqoU_Im_Jame7w>
    <xmx:CL3FZCV3-wHEe6437cIDg-CuIPTiwK1K6EiFBGNmvC5wk0MgoxkUhw>
    <xmx:CL3FZBOVHzK0SgaLdPo-vj4vwW6W4DX_6b8sBWKwker7T8yWLJ2Q0g>
    <xmx:Cr3FZIlbRyceXNtPTQNMCCf0AQuiu-hQ0jnbPoHu4rD7wcgOTOC9YQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Jul 2023 21:29:44 -0400 (EDT)
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
Subject: [PATCH 0/3] Fix alignment issue and prepare for rust 1.71
Date:   Sat, 29 Jul 2023 18:29:01 -0700
Message-ID: <20230730012905.643822-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Hi Miguel,

I end up with this series:

(background: https://lore.kernel.org/rust-for-linux/CANiq72=pb18B6NOcXF03d0ctOP8kv2dqnUeNyEuSvuDb=vs-0g@mail.gmail.com/) 

Patch #1: introduces the core helper function that help calculate the
correct size for krealloc(), and also use the helper function to fix
`__rust_*` ones, this should be backported to stable kernels hence the
Cc.

Patch #2: use the helper function in KernelAllocator

Patch #3: Bjorn's patch with correct use of the helper function.

I have to add a few more SAFETY comments in these `__rust_*` functions,
which may cause conflict with your 1.71 series.

Since all previous patches get refactored a bit, I dropped all the
Reviewed-bys, appreciate anyone to take a look, thanks!

Regards,
Boqun

Björn Roy Baron (1):
  rust: alloc: Add realloc and alloc_zeroed to the GlobalAlloc impl

Boqun Feng (2):
  rust: allocator: Prevent mis-aligned allocation
  rust: allocator: Use krealloc_aligned() in KernelAllocator::alloc

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/allocator.rs        | 107 ++++++++++++++++++++++++++------
 2 files changed, 90 insertions(+), 18 deletions(-)

-- 
2.41.0

