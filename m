Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D547705A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjHDQHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjHDQHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:07:40 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329201734
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:07:38 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-790ba9cf42aso80744939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691165257; x=1691770057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=da5fg3TgkaSR1bp3tOW/fj0rtgRsAZ3/eloqeDzmNS4=;
        b=F5OmByUBVWWa76po0Kn7y8nCTIK1X+EXk0ooogEeYC0/HgzW7YmbgeXJ2X6Q3ntlx3
         6XNYYG/hx9UFQEst7T/1Jg7dKGuMJb1l1wyFsLR8I+Y8nZtAMyUVQbhyvKcaaPeombIJ
         rtOWEJ5reuMDrfceWpBfGUR0MvzYmgGXrlEH8re2I896nN5D4FK5fcpSNkG4Viaw247C
         falI67qSotOoFbfNPHhL0L1n0NPDQHNHq8hF7db0SjHNYyO4TFlBp1Eq1AGeVd4e6CS0
         kGwwRJn2i2VdYr+BRLqF/sispxNJfgjuj0Srv6sS0xk8vhXuNJp/XnEpylJ7fC2l8SBv
         m+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165257; x=1691770057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=da5fg3TgkaSR1bp3tOW/fj0rtgRsAZ3/eloqeDzmNS4=;
        b=GRa5Dlu1VM85YVHH9mpIhC0qlXEvf99GE/mkofoACzKr85s07iNNzc5TiQKH5i0Sun
         BC5JNhIZLgBqh8aVa3TTB/oqI7L0R6ApVvaSNiER7L/lMqjDxz/l3FmwMZj3DC3iDNVV
         YaK2nJJ4RbO6ez/mt0qMnYu1FEIaNyxP8e0aO+0qSRcB48zGpnYmYcbj4Z4c00Ivg1uI
         3JAXi9zlUvE4I4zW8ouZe+hAdMy/MLAyw1Xj0c+fCq7743JKLercDsmxouKX99NssCpz
         8lFwVUTuI1vqJJnbrHdbP0f3i/BYvjiqsh+3AFGMmL9mIXkFpy5aVujByut1lBf2/dqo
         +S+w==
X-Gm-Message-State: AOJu0YxvUCz1NUmc9YW4sohPgVxklqlLteegDtICMEcH7ikdrHRmJI3X
        LOocNf71K5OGITWa0yu2ZNnYzCYcyBxRZPEtaelSYoqx8Vt3nbP8X5s=
X-Google-Smtp-Source: AGHT+IEwsMq1ia4HXPYjRR8+0Q+CAUZ9Z870C8uyH35O/DhrlrYRB4eg7HzODE/GFjOIa24SjN+x3MmUiQCp4ntZhTM=
X-Received: by 2002:a6b:f802:0:b0:786:4795:30c9 with SMTP id
 o2-20020a6bf802000000b00786479530c9mr2108623ioh.20.1691165257145; Fri, 04 Aug
 2023 09:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad> <CAG_fn=V4wyHjXT41byPbAkrZzisZRfKszwM4EUFV-FNWuXXfbw@mail.gmail.com>
 <ZMG29WmwQFVgTSCv@yury-ThinkPad>
In-Reply-To: <ZMG29WmwQFVgTSCv@yury-ThinkPad>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 4 Aug 2023 18:07:00 +0200
Message-ID: <CAG_fn=VrPJj6YowHNki5RGAAs8qvwZpUVN4K9qw=cf4aW7Qw9A@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/mixed; boundary="000000000000694c6006021b18ea"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000694c6006021b18ea
Content-Type: text/plain; charset="UTF-8"

>         space >= nbits <=>
>         BITS_PER_LONG - offset >= nbits <=>
>         offset + nbits <= BITS_PER_LONG
>
> >         map[index] &= (fit ? (~(GENMASK(nbits - 1, 0) << offset)) :
>
> So here GENMASK(nbits + offset - 1, offset) is at max:
> GENMASK(BITS_PER_LONG - 1, offset). And it never overflows, which is my
> point. Does it make sense?

It indeed does. Perhaps pulling offset inside GENMASK is not a bug
after all (a simple test does not show any difference between their
behavior.
But `GENMASK(nbits - 1 + offset, offset)` blows up the code (see below).
My guess is that this happens because the compiler fails to reuse the
value of `GENMASK(nbits - 1, 0)` used to clamp the value to write, and
calculates `GENMASK(nbits - 1 + offset, offset)` from scratch.

>
> > ~BITMAP_FIRST_WORD_MASK(start));
>
> As I said, ~BITMAP_FIRST_WORD_MASK() is the same as BITMAP_LAST_WORD_MASK()
> and vise-versa.

Surprisingly, ~BITMAP_FIRST_WORD_MASK() generates better code than
BITMAP_LAST_WORD_MASK().

>
> >         map[index] |= value << offset;
> >         if (fit)
> >                 return;
> >
> >         map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);

OTOH I managed to shave three more bytes off by replacing
~BITMAP_LAST_WORD_MASK with a BITMAP_FIRST_WORD_MASK here.

> >         map[index + 1] |= (value >> space);
> > }

I'll post the implementations together with the disassembly below.
I used some Clang 17.0.0 version that is a couple months behind
upstream, but that still produces sustainably shorter code (~48 bytes
less) than the trunk GCC on Godbolt.

1. Original implementation of bitmap_write() from this patch - 164
bytes (interestingly, it's 157 bytes with Clang 14.0.6)

==================================================================
void bitmap_write(unsigned long *map, unsigned long value,
                  unsigned long start, unsigned long nbits)
{
        size_t index = BIT_WORD(start);
        unsigned long offset = start % BITS_PER_LONG;
        unsigned long space = BITS_PER_LONG - offset;

        if (unlikely(!nbits))
                return;
        value &= GENMASK(nbits - 1, 0);
        if (space >= nbits) {
                map[index] &= ~(GENMASK(nbits - 1, 0) << offset);
                map[index] |= value << offset;
                return;
        }
        map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
        map[index] |= value << offset;
        map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
        map[index + 1] |= (value >> space);
}
==================================================================
0000000000001200 <bitmap_write>:
    1200: 41 57                push   %r15
    1202: 41 56                push   %r14
    1204: 53                    push   %rbx
    1205: 48 85 c9              test   %rcx,%rcx
    1208: 74 7b                je     1285 <bitmap_write+0x85>
    120a: 48 89 c8              mov    %rcx,%rax
    120d: 49 89 d2              mov    %rdx,%r10
    1210: 49 c1 ea 06          shr    $0x6,%r10
    1214: 41 89 d1              mov    %edx,%r9d
    1217: f6 d9                neg    %cl
    1219: 49 c7 c7 ff ff ff ff mov    $0xffffffffffffffff,%r15
    1220: 49 d3 ef              shr    %cl,%r15
    1223: 41 83 e1 3f          and    $0x3f,%r9d
    1227: 41 b8 40 00 00 00    mov    $0x40,%r8d
    122d: 4c 21 fe              and    %r15,%rsi
    1230: 48 89 f3              mov    %rsi,%rbx
    1233: 44 89 c9              mov    %r9d,%ecx
    1236: 48 d3 e3              shl    %cl,%rbx
    1239: 4d 29 c8              sub    %r9,%r8
    123c: 49 c7 c3 ff ff ff ff mov    $0xffffffffffffffff,%r11
    1243: 4e 8b 34 d7          mov    (%rdi,%r10,8),%r14
    1247: 49 39 c0              cmp    %rax,%r8
    124a: 73 3f                jae    128b <bitmap_write+0x8b>
    124c: 49 c7 c7 ff ff ff ff mov    $0xffffffffffffffff,%r15
    1253: 44 89 c9              mov    %r9d,%ecx
    1256: 49 d3 e7              shl    %cl,%r15
    1259: 49 f7 d7              not    %r15
    125c: 4d 21 fe              and    %r15,%r14
    125f: 49 09 de              or     %rbx,%r14
    1262: 4e 89 34 d7          mov    %r14,(%rdi,%r10,8)
    1266: 01 c2                add    %eax,%edx
    1268: f6 da                neg    %dl
    126a: 89 d1                mov    %edx,%ecx
    126c: 49 d3 eb              shr    %cl,%r11
    126f: 49 f7 d3              not    %r11
    1272: 44 89 c1              mov    %r8d,%ecx
    1275: 48 d3 ee              shr    %cl,%rsi
    1278: 4e 23 5c d7 08        and    0x8(%rdi,%r10,8),%r11
    127d: 4c 09 de              or     %r11,%rsi
    1280: 4a 89 74 d7 08        mov    %rsi,0x8(%rdi,%r10,8)
    1285: 5b                    pop    %rbx
    1286: 41 5e                pop    %r14
    1288: 41 5f                pop    %r15
    128a: c3                    ret
    128b: 44 89 c9              mov    %r9d,%ecx
    128e: 49 d3 e7              shl    %cl,%r15
    1291: 49 f7 d7              not    %r15
    1294: 4d 21 fe              and    %r15,%r14
    1297: 49 09 de              or     %rbx,%r14
    129a: 4e 89 34 d7          mov    %r14,(%rdi,%r10,8)
    129e: 5b                    pop    %rbx
    129f: 41 5e                pop    %r14
    12a1: 41 5f                pop    %r15
    12a3: c3                    ret
==================================================================

2. Your implementation, my_bitmap_write() - 152 bytes (used to be
slightly worse with Clang 14.0.6 - 159 bytes):

==================================================================
void my_bitmap_write(unsigned long *map, unsigned long value,
                     unsigned long start, unsigned long nbits)
{
        unsigned long w, end;

        if (unlikely(nbits == 0))
                return;

        value &= GENMASK(nbits - 1, 0);

        map += BIT_WORD(start);
        start %= BITS_PER_LONG;
        end = start + nbits - 1;

        w = *map & (end < BITS_PER_LONG ? ~GENMASK(end, start) :
BITMAP_LAST_WORD_MASK(start));
        *map = w | (value << start);

        if (end < BITS_PER_LONG)
                return;

        w = *++map & BITMAP_LAST_WORD_MASK(end + 1 - BITS_PER_LONG);
        *map = w | (value >> (BITS_PER_LONG - start));
}
==================================================================
0000000000001160 <my_bitmap_write>:
    1160: 48 85 c9              test   %rcx,%rcx
    1163: 0f 84 8e 00 00 00    je     11f7 <my_bitmap_write+0x97>
    1169: 49 89 c9              mov    %rcx,%r9
    116c: f6 d9                neg    %cl
    116e: 48 d3 e6              shl    %cl,%rsi
    1171: 48 d3 ee              shr    %cl,%rsi
    1174: 49 89 d2              mov    %rdx,%r10
    1177: 49 c1 ea 06          shr    $0x6,%r10
    117b: 89 d0                mov    %edx,%eax
    117d: 83 e0 3f              and    $0x3f,%eax
    1180: 4e 8d 04 08          lea    (%rax,%r9,1),%r8
    1184: 4a 8d 0c 08          lea    (%rax,%r9,1),%rcx
    1188: 48 ff c9              dec    %rcx
    118b: 4e 8b 0c d7          mov    (%rdi,%r10,8),%r9
    118f: 48 83 f9 3f          cmp    $0x3f,%rcx
    1193: 77 29                ja     11be <my_bitmap_write+0x5e>
    1195: 41 f6 d8              neg    %r8b
    1198: 48 c7 c2 ff ff ff ff mov    $0xffffffffffffffff,%rdx
    119f: 44 89 c1              mov    %r8d,%ecx
    11a2: 48 d3 ea              shr    %cl,%rdx
    11a5: 89 c1                mov    %eax,%ecx
    11a7: 48 d3 ea              shr    %cl,%rdx
    11aa: 48 d3 e2              shl    %cl,%rdx
    11ad: 48 d3 e6              shl    %cl,%rsi
    11b0: 48 f7 d2              not    %rdx
    11b3: 49 21 d1              and    %rdx,%r9
    11b6: 4c 09 ce              or     %r9,%rsi
    11b9: 4a 89 34 d7          mov    %rsi,(%rdi,%r10,8)
    11bd: c3                    ret
    11be: f6 da                neg    %dl
    11c0: 89 d1                mov    %edx,%ecx
    11c2: 49 d3 e1              shl    %cl,%r9
    11c5: 49 d3 e9              shr    %cl,%r9
    11c8: 48 89 f2              mov    %rsi,%rdx
    11cb: 89 c1                mov    %eax,%ecx
    11cd: 48 d3 e2              shl    %cl,%rdx
    11d0: 4c 09 ca              or     %r9,%rdx
    11d3: 4a 89 14 d7          mov    %rdx,(%rdi,%r10,8)
    11d7: 4a 8b 54 d7 08        mov    0x8(%rdi,%r10,8),%rdx
    11dc: 41 f6 d8              neg    %r8b
    11df: 44 89 c1              mov    %r8d,%ecx
    11e2: 48 d3 e2              shl    %cl,%rdx
    11e5: 48 d3 ea              shr    %cl,%rdx
    11e8: f6 d8                neg    %al
    11ea: 89 c1                mov    %eax,%ecx
    11ec: 48 d3 ee              shr    %cl,%rsi
    11ef: 48 09 d6              or     %rdx,%rsi
    11f2: 4a 89 74 d7 08        mov    %rsi,0x8(%rdi,%r10,8)
    11f7: c3                    ret
==================================================================

3. My improved version built on top of yours and mentioned above under
the name bitmap_write_new() - 116 bytes:

==================================================================
void bitmap_write_new(unsigned long *map, unsigned long value,
                      unsigned long start, unsigned long nbits)
{
        unsigned long offset;
        unsigned long space;
        size_t index;
        bool fit;

        if (unlikely(!nbits))
                return;

        value &= GENMASK(nbits - 1, 0);
        offset = start % BITS_PER_LONG;
        space = BITS_PER_LONG - offset;
        index = BIT_WORD(start);
        fit = space >= nbits;

        map[index] &= (fit ? (~(GENMASK(nbits - 1, 0) << offset)) :
~BITMAP_FIRST_WORD_MASK(start));
        map[index] |= value << offset;
        if (fit)
                return;

        map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
        map[index + 1] |= (value >> space);
}
==================================================================
00000000000012b0 <bitmap_write_new>:
    12b0: 48 85 c9              test   %rcx,%rcx
    12b3: 74 6e                je     1323 <bitmap_write_new+0x73>
    12b5: 48 89 c8              mov    %rcx,%rax
    12b8: f6 d9                neg    %cl
    12ba: 49 c7 c2 ff ff ff ff mov    $0xffffffffffffffff,%r10
    12c1: 49 d3 ea              shr    %cl,%r10
    12c4: 49 c7 c3 ff ff ff ff mov    $0xffffffffffffffff,%r11
    12cb: 4c 21 d6              and    %r10,%rsi
    12ce: 89 d1                mov    %edx,%ecx
    12d0: 83 e1 3f              and    $0x3f,%ecx
    12d3: 41 b8 40 00 00 00    mov    $0x40,%r8d
    12d9: 49 29 c8              sub    %rcx,%r8
    12dc: 49 89 d1              mov    %rdx,%r9
    12df: 49 c1 e9 06          shr    $0x6,%r9
    12e3: 49 39 c0              cmp    %rax,%r8
    12e6: 4d 0f 42 d3          cmovb  %r11,%r10
    12ea: 49 d3 e2              shl    %cl,%r10
    12ed: 49 f7 d2              not    %r10
    12f0: 4e 23 14 cf          and    (%rdi,%r9,8),%r10
    12f4: 49 89 f3              mov    %rsi,%r11
    12f7: 49 d3 e3              shl    %cl,%r11
    12fa: 4d 09 d3              or     %r10,%r11
    12fd: 4e 89 1c cf          mov    %r11,(%rdi,%r9,8)
    1301: 49 39 c0              cmp    %rax,%r8
    1304: 73 1d                jae    1323 <bitmap_write_new+0x73>
    1306: 01 d0                add    %edx,%eax
    1308: 4a 8b 54 cf 08        mov    0x8(%rdi,%r9,8),%rdx
    130d: 89 c1                mov    %eax,%ecx
    130f: 48 d3 ea              shr    %cl,%rdx
    1312: 48 d3 e2              shl    %cl,%rdx
    1315: 44 89 c1              mov    %r8d,%ecx
    1318: 48 d3 ee              shr    %cl,%rsi
    131b: 48 09 d6              or     %rdx,%rsi
    131e: 4a 89 74 cf 08        mov    %rsi,0x8(%rdi,%r9,8)
    1323: c3                    ret
==================================================================

4. The version of bitmap_write_new() that uses `(GENMASK(nbits - 1 +
offset, offset)` - 146 bytes:

==================================================================
void bitmap_write_new_shift(unsigned long *map, unsigned long value,
                      unsigned long start, unsigned long nbits)
{
        unsigned long offset;
        unsigned long space;
        size_t index;
        bool fit;

        if (unlikely(!nbits))
                return;

        value &= GENMASK(nbits - 1, 0);
        offset = start % BITS_PER_LONG;
        space = BITS_PER_LONG - offset;
        index = BIT_WORD(start);
        fit = space >= nbits;

        map[index] &= (fit ? ~(GENMASK(nbits - 1 + offset, offset)) :
~BITMAP_FIRST_WORD_MASK(start));
        map[index] |= value << offset;
        if (fit)
                return;

        map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
        map[index + 1] |= (value >> space);
}
==================================================================
0000000000001330 <bitmap_write_new_shift>:
    1330: 48 85 c9              test   %rcx,%rcx
    1333: 74 6a                je     139f <bitmap_write_new_shift+0x6f>
    1335: 48 89 c8              mov    %rcx,%rax
    1338: f6 d9                neg    %cl
    133a: 48 d3 e6              shl    %cl,%rsi
    133d: 48 d3 ee              shr    %cl,%rsi
    1340: 41 89 d0              mov    %edx,%r8d
    1343: 41 83 e0 3f          and    $0x3f,%r8d
    1347: 41 b9 40 00 00 00    mov    $0x40,%r9d
    134d: 4d 29 c1              sub    %r8,%r9
    1350: 49 89 d2              mov    %rdx,%r10
    1353: 49 c1 ea 06          shr    $0x6,%r10
    1357: 49 c7 c3 ff ff ff ff mov    $0xffffffffffffffff,%r11
    135e: 44 89 c1              mov    %r8d,%ecx
    1361: 49 d3 e3              shl    %cl,%r11
    1364: 49 39 c1              cmp    %rax,%r9
    1367: 73 37                jae    13a0 <bitmap_write_new_shift+0x70>
    1369: 53                    push   %rbx
    136a: 49 f7 d3              not    %r11
    136d: 4e 23 1c d7          and    (%rdi,%r10,8),%r11
    1371: 48 89 f3              mov    %rsi,%rbx
    1374: 44 89 c1              mov    %r8d,%ecx
    1377: 48 d3 e3              shl    %cl,%rbx
    137a: 4c 09 db              or     %r11,%rbx
    137d: 4a 89 1c d7          mov    %rbx,(%rdi,%r10,8)
    1381: 01 d0                add    %edx,%eax
    1383: 4a 8b 54 d7 08        mov    0x8(%rdi,%r10,8),%rdx
    1388: 89 c1                mov    %eax,%ecx
    138a: 48 d3 ea              shr    %cl,%rdx
    138d: 48 d3 e2              shl    %cl,%rdx
    1390: 44 89 c9              mov    %r9d,%ecx
    1393: 48 d3 ee              shr    %cl,%rsi
    1396: 48 09 d6              or     %rdx,%rsi
    1399: 4a 89 74 d7 08        mov    %rsi,0x8(%rdi,%r10,8)
    139e: 5b                    pop    %rbx
    139f: c3                    ret
    13a0: 44 01 c0              add    %r8d,%eax
    13a3: f6 d8                neg    %al
    13a5: 89 c1                mov    %eax,%ecx
    13a7: 49 d3 e3              shl    %cl,%r11
    13aa: 49 d3 eb              shr    %cl,%r11
    13ad: 49 f7 d3              not    %r11
    13b0: 44 89 c1              mov    %r8d,%ecx
    13b3: 48 d3 e6              shl    %cl,%rsi
    13b6: 4e 23 1c d7          and    (%rdi,%r10,8),%r11
    13ba: 4c 09 de              or     %r11,%rsi
    13bd: 4a 89 34 d7          mov    %rsi,(%rdi,%r10,8)
    13c1: c3                    ret
==================================================================

For posterity, I am also attaching the C file containing the four
implementations together with some code testing them.

PS. I won't be actively working on the patch series till the end of
August, so feel free to ignore this letter until then.

--000000000000694c6006021b18ea
Content-Type: text/x-csrc; charset="US-ASCII"; name="bitmap_write.c"
Content-Disposition: attachment; filename="bitmap_write.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lkws339s0>
X-Attachment-Id: f_lkws339s0

I2luY2x1ZGUgPHN0ZGRlZi5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8c3RkYm9vbC5oPgoKI2RlZmluZSBCSVRTX1BFUl9MT05HIDY0CiNkZWZpbmUg
dW5saWtlbHkoeCkgeAojZGVmaW5lIFVMKHgpICh4IyNVTCkKI2RlZmluZSBHRU5NQVNLKGgsIGwp
IFwKCSgoKH5VTCgwKSkgLSAoVUwoMSkgPDwgKGwpKSArIDEpICYgXAoJICh+VUwoMCkgPj4gKEJJ
VFNfUEVSX0xPTkcgLSAxIC0gKGgpKSkpCgojZGVmaW5lIEJJVF9XT1JEKG5yKQkJKChucikgLyBC
SVRTX1BFUl9MT05HKQojZGVmaW5lIEJJVE1BUF9GSVJTVF9XT1JEX01BU0soc3RhcnQpICh+MFVM
IDw8ICgoc3RhcnQpICYgKEJJVFNfUEVSX0xPTkcgLSAxKSkpCiNkZWZpbmUgQklUTUFQX0xBU1Rf
V09SRF9NQVNLKG5iaXRzKSAofjBVTCA+PiAoLShuYml0cykgJiAoQklUU19QRVJfTE9ORyAtIDEp
KSkKCgp2b2lkIG15X2JpdG1hcF93cml0ZSh1bnNpZ25lZCBsb25nICptYXAsIHVuc2lnbmVkIGxv
bmcgdmFsdWUsCgkJICAgICB1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIG5iaXRz
KQp7Cgl1bnNpZ25lZCBsb25nIHcsIGVuZDsKCglpZiAodW5saWtlbHkobmJpdHMgPT0gMCkpCgkJ
cmV0dXJuOwoKCXZhbHVlICY9IEdFTk1BU0sobmJpdHMgLSAxLCAwKTsKCgltYXAgKz0gQklUX1dP
UkQoc3RhcnQpOwoJc3RhcnQgJT0gQklUU19QRVJfTE9ORzsKCWVuZCA9IHN0YXJ0ICsgbmJpdHMg
LSAxOwoKCXcgPSAqbWFwICYgKGVuZCA8IEJJVFNfUEVSX0xPTkcgPyB+R0VOTUFTSyhlbmQsIHN0
YXJ0KSA6IEJJVE1BUF9MQVNUX1dPUkRfTUFTSyhzdGFydCkpOwoJKm1hcCA9IHcgfCAodmFsdWUg
PDwgc3RhcnQpOwoKCWlmIChlbmQgPCBCSVRTX1BFUl9MT05HKQoJCXJldHVybjsKCgl3ID0gKisr
bWFwICYgQklUTUFQX0xBU1RfV09SRF9NQVNLKGVuZCArIDEgLSBCSVRTX1BFUl9MT05HKTsKCSpt
YXAgPSB3IHwgKHZhbHVlID4+IChCSVRTX1BFUl9MT05HIC0gc3RhcnQpKTsKfQoKdm9pZCBiaXRt
YXBfd3JpdGUodW5zaWduZWQgbG9uZyAqbWFwLCB1bnNpZ25lZCBsb25nIHZhbHVlLAoJCSAgdW5z
aWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBuYml0cykKewoJc2l6ZV90IGluZGV4ID0g
QklUX1dPUkQoc3RhcnQpOwoJdW5zaWduZWQgbG9uZyBvZmZzZXQgPSBzdGFydCAlIEJJVFNfUEVS
X0xPTkc7Cgl1bnNpZ25lZCBsb25nIHNwYWNlID0gQklUU19QRVJfTE9ORyAtIG9mZnNldDsKCglp
ZiAodW5saWtlbHkoIW5iaXRzKSkKCQlyZXR1cm47Cgl2YWx1ZSAmPSBHRU5NQVNLKG5iaXRzIC0g
MSwgMCk7CglpZiAoc3BhY2UgPj0gbmJpdHMpIHsKCQltYXBbaW5kZXhdICY9IH4oR0VOTUFTSyhu
Yml0cyAtIDEsIDApIDw8IG9mZnNldCk7CgkJbWFwW2luZGV4XSB8PSB2YWx1ZSA8PCBvZmZzZXQ7
CgkJcmV0dXJuOwoJfQoJbWFwW2luZGV4XSAmPSB+QklUTUFQX0ZJUlNUX1dPUkRfTUFTSyhzdGFy
dCk7CgltYXBbaW5kZXhdIHw9IHZhbHVlIDw8IG9mZnNldDsKCW1hcFtpbmRleCArIDFdICY9IH5C
SVRNQVBfTEFTVF9XT1JEX01BU0soc3RhcnQgKyBuYml0cyk7CgltYXBbaW5kZXggKyAxXSB8PSAo
dmFsdWUgPj4gc3BhY2UpOwp9Cgp2b2lkIGJpdG1hcF93cml0ZV9uZXcodW5zaWduZWQgbG9uZyAq
bWFwLCB1bnNpZ25lZCBsb25nIHZhbHVlLAoJCSAgICAgIHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVu
c2lnbmVkIGxvbmcgbmJpdHMpCnsKCXVuc2lnbmVkIGxvbmcgb2Zmc2V0OwoJdW5zaWduZWQgbG9u
ZyBzcGFjZTsKCXNpemVfdCBpbmRleDsKCWJvb2wgZml0OwoKCWlmICh1bmxpa2VseSghbmJpdHMp
KQoJCXJldHVybjsKCgl2YWx1ZSAmPSBHRU5NQVNLKG5iaXRzIC0gMSwgMCk7CglvZmZzZXQgPSBz
dGFydCAlIEJJVFNfUEVSX0xPTkc7CglzcGFjZSA9IEJJVFNfUEVSX0xPTkcgLSBvZmZzZXQ7Cglp
bmRleCA9CUJJVF9XT1JEKHN0YXJ0KTsKCWZpdCA9IHNwYWNlID49IG5iaXRzOwoKCW1hcFtpbmRl
eF0gJj0gKGZpdCA/ICh+KEdFTk1BU0sobmJpdHMgLSAxLCAwKSA8PCBvZmZzZXQpKSA6IH5CSVRN
QVBfRklSU1RfV09SRF9NQVNLKHN0YXJ0KSk7CgltYXBbaW5kZXhdIHw9IHZhbHVlIDw8IG9mZnNl
dDsKCWlmIChmaXQpCgkJcmV0dXJuOwoKCW1hcFtpbmRleCArIDFdICY9IEJJVE1BUF9GSVJTVF9X
T1JEX01BU0soc3RhcnQgKyBuYml0cyk7CgltYXBbaW5kZXggKyAxXSB8PSAodmFsdWUgPj4gc3Bh
Y2UpOwp9Cgp2b2lkIGJpdG1hcF93cml0ZV9uZXdfc2hpZnQodW5zaWduZWQgbG9uZyAqbWFwLCB1
bnNpZ25lZCBsb25nIHZhbHVlLAoJCSAgICAgIHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVk
IGxvbmcgbmJpdHMpCnsKCXVuc2lnbmVkIGxvbmcgb2Zmc2V0OwoJdW5zaWduZWQgbG9uZyBzcGFj
ZTsKCXNpemVfdCBpbmRleDsKCWJvb2wgZml0OwoKCWlmICh1bmxpa2VseSghbmJpdHMpKQoJCXJl
dHVybjsKCgl2YWx1ZSAmPSBHRU5NQVNLKG5iaXRzIC0gMSwgMCk7CglvZmZzZXQgPSBzdGFydCAl
IEJJVFNfUEVSX0xPTkc7CglzcGFjZSA9IEJJVFNfUEVSX0xPTkcgLSBvZmZzZXQ7CglpbmRleCA9
CUJJVF9XT1JEKHN0YXJ0KTsKCWZpdCA9IHNwYWNlID49IG5iaXRzOwoKCW1hcFtpbmRleF0gJj0g
KGZpdCA/IH4oR0VOTUFTSyhuYml0cyAtIDEgKyBvZmZzZXQsIG9mZnNldCkpIDogfkJJVE1BUF9G
SVJTVF9XT1JEX01BU0soc3RhcnQpKTsKCW1hcFtpbmRleF0gfD0gdmFsdWUgPDwgb2Zmc2V0OwoJ
aWYgKGZpdCkKCQlyZXR1cm47CgoJbWFwW2luZGV4ICsgMV0gJj0gQklUTUFQX0ZJUlNUX1dPUkRf
TUFTSyhzdGFydCArIG5iaXRzKTsKCW1hcFtpbmRleCArIDFdIHw9ICh2YWx1ZSA+PiBzcGFjZSk7
Cn0KCiNkZWZpbmUgTUFQU0laRSAzCgp2b2lkIHByaW50X21hcCh1bnNpZ25lZCBsb25nICptYXAs
IGNvbnN0IGNoYXIgKmMpCnsKCWludCBpOwoKCXByaW50ZigiJXM6ICIsIGMpOwoJZm9yIChpID0g
MDsgaSA8IE1BUFNJWkU7IGkrKykgewoJCXByaW50ZigiJWx4ICIsIG1hcFtpXSk7Cgl9Cglwcmlu
dGYoIlxuIik7Cn0KCiNkZWZpbmUgQ09NUEFSRShmbjEsIGZuMikJCVwKZG8gewkJCQkJXAoJdW5z
aWduZWQgbG9uZyBvbmVbTUFQU0laRV0sIHR3b1tNQVBTSVpFXSwgdGhyZWVbTUFQU0laRV07XAoJ
aW50IHJlczsJCQkJCQlcCgkJCQkJCQkJXAoJbWVtc2V0KG9uZSwgMCwgc2l6ZW9mKHVuc2lnbmVk
IGxvbmcpKk1BUFNJWkUpOwkJXAoJbWVtc2V0KHR3bywgMCwgc2l6ZW9mKHVuc2lnbmVkIGxvbmcp
Kk1BUFNJWkUpOwkJXAoJZm4xKG9uZSwgdmFsdWUsIHN0YXJ0LCBuYml0cyk7CQkJCVwKCWZuMih0
d28sIHZhbHVlLCBzdGFydCwgbmJpdHMpOwkJCQlcCglyZXMgPSBtZW1jbXAob25lLCB0d28sIHNp
emVvZih1bnNpZ25lZCBsb25nKSpNQVBTSVpFKTsJXAoJaWYgKHJlcykgewkJCQkJCVwKCQlwcmlu
dGYoI2ZuMSAiIHZzLiAiICNmbjIgIjogWyVsdSwgJWx1XTogJWRcbiIsIAlcCgkJCXN0YXJ0LCBu
Yml0cywgcmVzKTsJCQlcCgkJcHJpbnRfbWFwKG9uZSwgI2ZuMSk7CQkJCVwKCQlwcmludF9tYXAo
dHdvLCAjZm4yKTsJCQkJXAoJfQkJCQkJCQlcCn0gd2hpbGUgKDApCgp2b2lkIHRlc3QodW5zaWdu
ZWQgbG9uZyB2YWx1ZSwgdW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBuYml0cykK
ewoJQ09NUEFSRShiaXRtYXBfd3JpdGUsIGJpdG1hcF93cml0ZV9uZXcpOwoJQ09NUEFSRShiaXRt
YXBfd3JpdGUsIG15X2JpdG1hcF93cml0ZSk7CglDT01QQVJFKGJpdG1hcF93cml0ZSwgYml0bWFw
X3dyaXRlX25ld19zaGlmdCk7Cn0KCmludCBtYWluKCkKewoJdW5zaWduZWQgbG9uZyB2YWx1ZSA9
IDB4ZmFmYWZhZmFmYWZhZmFmYVVMOwoJdW5zaWduZWQgbG9uZyBzdGFydCwgbmJpdHM7CgoJZm9y
IChzdGFydCA9IDA7IHN0YXJ0IDw9IChNQVBTSVpFLTEpKkJJVFNfUEVSX0xPTkc7IHN0YXJ0Kysp
IHsKCQlmb3IgKG5iaXRzID0gMDsgbmJpdHMgPD0gQklUU19QRVJfTE9ORzsgbmJpdHMrKykgewoJ
CQl0ZXN0KHZhbHVlLCBzdGFydCwgbmJpdHMpOwoJCX0KCX0KCXJldHVybiAwOwp9Cg==
--000000000000694c6006021b18ea--
