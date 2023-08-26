Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B57789730
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 16:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjHZOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 10:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjHZOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 10:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C51519A0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 07:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21E4C608C0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17630C433C7;
        Sat, 26 Aug 2023 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693058764;
        bh=ukZ6g9EgWPFpAkFvHGXVcuI1MM3Y+aVwL2MADMeVBTU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hEhdoseJzsPGizH7PA9sWAhJB8NV7oOIzb56+6bL7zKKO0dzFZQtjYW53M9Rdtrm1
         PDll6zD9T3tkm1zl9r1jdEooRVqDYJEYqiBPe8i5umSYGTn8SSoExX7ih97FPcgUaX
         xJUQsdOmuSD77v+2LbiRvJ8yv8ycUPjuEfgX5IZsC7xVUL5KQFE9UGSNONHVcUIjBK
         KpDDt8BG7KLshSVKBFcqpDFH72eAt6ZlwcT4g7NHwF86Z+N4JnmPbCzpGW8F+tYP16
         DtWyoGHvduD4mTpnEebDQkX8/Y/h/DN6ObHHNQFnzIUnqoJBDcEW/Lvc7aTk75p6HO
         8o29gxRGxD3sw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, pulehui@huawei.com,
        conor.dooley@microchip.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     puranjay12@gmail.com
Subject: Re: [PATCH bpf-next v2 3/3] bpf, riscv: use prog pack allocator in
 the BPF JIT
In-Reply-To: <20230824133135.1176709-4-puranjay12@gmail.com>
References: <20230824133135.1176709-1-puranjay12@gmail.com>
 <20230824133135.1176709-4-puranjay12@gmail.com>
Date:   Sat, 26 Aug 2023 16:06:00 +0200
Message-ID: <87v8d1q4on.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Puranjay Mohan <puranjay12@gmail.com> writes:

> Use bpf_jit_binary_pack_alloc() for memory management of JIT binaries in
> RISCV BPF JIT. The bpf_jit_binary_pack_alloc creates a pair of RW and RX
> buffers. The JIT writes the program into the RW buffer. When the JIT is
> done, the program is copied to the final RX buffer with
> bpf_jit_binary_pack_finalize.
>
> Implement bpf_arch_text_copy() and bpf_arch_text_invalidate() for RISCV
> JIT as these functions are required by bpf_jit_binary_pack allocator.

General style comment; Please try to use the full 100 characters width
for the patches. You're having a lot of linebreaks, which IMO makes the
patch harder to read.


Bj=C3=B6rn
