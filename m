Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB8679BFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjIKXUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 19:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350957AbjIKVm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 17:42:27 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34657DBD;
        Mon, 11 Sep 2023 14:25:35 -0700 (PDT)
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id AC672CDF42;
        Mon, 11 Sep 2023 21:22:32 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 543F660007;
        Mon, 11 Sep 2023 21:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustri.org; s=gm1;
        t=1694467271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=b0XvMYLh9/MC3gxuFXLDQKkOMU9w8ZJazb0YgA6oPTk=;
        b=mPNTD/3CCFlTXK8D2tNaHmgm4PIe6xtxAwQ8tWGMhi9PN67MtdJceeexPzaWzCAMRhfY6j
        VHP6P8F7h6MwB+kd/ARwiqBvFZ36hRdm28LMhLBiPBNrZxjV+PHHphwHne6fhpt2tyi8KU
        NGfGgFCiKJnMUSEXwfdcE115+yUKuTYaRK+m6zVjehHHHnGedSyRUEjbmgyKhpHA05SNvA
        XhJ0XRi30fADIBZt/cQtqBXCpAjS+hlDGD2V/djdSSCP46hkP2yz/1BYKqpBfBYngcoBZj
        ORMLdx4mHn+rdWRU4lAaaMLaOzRa2CVqwcbCyVpXSZFufli89yIXcU8qKGh1Yw==
Message-ID: <e14c547e-bb3f-4ede-8f0a-dcaa548fe5af@dustri.org>
Date:   Mon, 11 Sep 2023 23:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     gongruiqi@huaweicloud.com
Cc:     42.hyeyoo@gmail.com, akpm@linux-foundation.org,
        aleksander.lobakin@intel.com, cl@linux.com, dennis@kernel.org,
        dvyukov@google.com, elver@google.com, glider@google.com,
        gongruiqi1@huawei.com, iamjoonsoo.kim@lge.com, jannh@google.com,
        jmorris@namei.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, paul@paul-moore.com, pedro.falcato@gmail.com,
        penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
        serge@hallyn.com, tj@kernel.org, vbabka@suse.cz,
        wangweiyang2@huawei.com, xiujianfeng@huawei.com
References: <20230714064422.3305234-1-gongruiqi@huaweicloud.com>
Subject: Re: [PATCH v5] Randomized slab caches for kmalloc()
Content-Language: en-US
From:   jvoisin <julien.voisin@dustri.org>
Autocrypt: addr=julien.voisin@dustri.org; keydata=
 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
 766VTOg4l2PTPCnIdNFy1Os=
In-Reply-To: <20230714064422.3305234-1-gongruiqi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: julien.voisin@dustri.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a small blogpost[1] about this series, and was told[2] that it
would be interesting to share it on this thread, so here it is, copied
verbatim:

Ruiqi Gong and Xiu Jianfeng got their
[Randomized slab caches for
kmalloc()](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c6152940584290668b35fa0800026f6a1ae05fe)
patch series merged upstream, and I've and enough discussions about it to
warrant summarising them into a small blogpost.

The main idea is to have multiple slab caches, and pick one at random
based on
the address of code calling `kmalloc()` and a per-boot seed, to make
heap-spraying harder.
It's a great idea, but comes with some shortcomings for now:

- Objects being allocated via wrappers around `kmalloc()`, like
`sock_kmalloc`,
  `f2fs_kmalloc`, `aligned_kmalloc`, … will end up in the same slab cache.
- The slabs needs to be pinned, otherwise an attacker could
[feng-shui](https://en.wikipedia.org/wiki/Heap_feng_shui) their way
  into having the whole slab free'ed, garbage-collected, and have a slab for
  another type allocated at the same VA. [Jann Horn](https://thejh.net/)
and [Matteo Rizzo](https://infosec.exchange/@nspace) have a [nice
  set of
patches](https://github.com/torvalds/linux/compare/master...thejh:linux:slub-virtual-upstream),
  discussed a bit in [this Project Zero
blogpost](https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html),
  for a feature called [`SLAB_VIRTUAL`](
https://github.com/torvalds/linux/commit/f3afd3a2152353be355b90f5fd4367adbf6a955e),
  implementing precisely this.
- There are 16 slabs by default, so one chance out of 16 to end up in
the same
  slab cache as the target.
- There are no guard pages between caches, so inter-caches overflows are
  possible.
- As pointed by
[andreyknvl](https://twitter.com/andreyknvl/status/1700267669336080678)
  and [minipli](https://infosec.exchange/@minipli/111045336853055793),
  the fewer allocations hitting a given cache means less noise,
  so it might even help with some heap feng-shui.
- minipli also pointed that "randomized caches still freely
  mix kernel allocations with user controlled ones (`xattr`, `keyctl`,
`msg_msg`, …).
  So even though merging is disabled for these caches, i.e. no direct
overlap
  with `cred_jar` etc., other object types can still be targeted (`struct
  pipe_buffer`, BPF maps, its verifier state objects,…). It’s just a
matter of
  probing which allocation index the targeted object falls into.",
  but I considered this out of scope, since it's much more involved;
  albeit something like
[`CONFIG_KMALLOC_SPLIT_VARSIZE`](https://github.com/thejh/linux/blob/slub-virtual/MITIGATION_README)
  wouldn't significantly increase complexity.

Also, while code addresses as a source of entropy has historically be a
great
way to provide [KASLR](https://lwn.net/Articles/569635/) bypasses,
`hash_64(caller ^
random_kmalloc_seed, ilog2(RANDOM_KMALLOC_CACHES_NR + 1))` shouldn't
trivially
leak offsets.

The segregation technique is a bit like a weaker version of grsecurity's
[AUTOSLAB](https://grsecurity.net/how_autoslab_changes_the_memory_unsafety_game),
or a weaker kernel-land version of
[PartitionAlloc](https://chromium.googlesource.com/chromium/src/+/master/base/allocator/partition_allocator/PartitionAlloc.md),
but to be fair, making use-after-free exploitation harder, and significantly
harder once pinning lands, with only ~150 lines of code and negligible
performance impact is amazing and should be praised. Moreover, I wouldn't be
surprised if this was backported in [Google's
KernelCTF](https://google.github.io/security-research/kernelctf/rules.html)
soon, so we should see if my analysis is correct.

1.
https://dustri.org/b/some-notes-on-randomized-slab-caches-for-kmalloc.html
2. https://infosec.exchange/@vbabka@social.kernel.org/111046740392510260

-- 
Julien (jvoisin) Voisin
GPG: 04D041E8171901CC
dustri.org

