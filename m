Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13568794437
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbjIFUDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241447AbjIFUDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:03:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D431BC2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:02:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so214962a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694030570; x=1694635370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFGzRmiXKKd0N3HPSCNBLoOVphe462VTeYOzBJScy7w=;
        b=V4Uqf0Vv1ncW6gf+obWFIocDobyrPOi+aVRyhoPy7NekVgOAjeDJXeejlb250b+6o/
         9iM99XCxI3ujbx1OlESjOarAZYipF1bgab9RibKVMpnh3KS21XOzuh3SRbWVuqxw44pw
         8T/pFlREsHhFFVUp0/aWbQdC3yFjwX+m4jI9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694030570; x=1694635370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFGzRmiXKKd0N3HPSCNBLoOVphe462VTeYOzBJScy7w=;
        b=ZjP29CTsyqoLGA9KiMsd4gb7HTwx8irGmmHc7/f1/Rq0DQImR1JVmO7BQ8izvX8Zdd
         4nwJben61vC9CsJvqP6wclFbNtYZjfrjCtVPI5ME0EdlCoA51LvMQe4Mplhmy053mMu1
         qaL0Js70okVhiaD6sRupNkTvVFzgJyayRNBdA1HfY0VGwBztEmmelY2UwIRGeaRBTBFT
         Kc6OSwiv7w4xOR9zYP/Ss1W7Ki8pWrEZDbAjMIz55Vo3HoHHHPHa5Ko9iYDzJ/U8mGjb
         oNE7hD5kKPWEaHNIbiqpmsJ1g7UQdundfxPJmdn+MUmyjAnWutxDj166pwivfskCbPmw
         SPAg==
X-Gm-Message-State: AOJu0YyHR7NUWUeSQvv8WqbSfpioW31omyE80Rz0CEgXEm3Gm0J2LZU9
        ikG7rbEc+7jHZUGnSytuPcK0Um2yZv57DbrCGldZoQ==
X-Google-Smtp-Source: AGHT+IG0aFhMQNkdXXs46d+yfgeRH6opsLeua/DYLotSALoeRQBqKwRFkuou9eL4+O81ZrW+Zu26zQ==
X-Received: by 2002:a50:fb0f:0:b0:522:3d36:ff27 with SMTP id d15-20020a50fb0f000000b005223d36ff27mr3169468edq.31.1694030570268;
        Wed, 06 Sep 2023 13:02:50 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402069a00b0051e2670d599sm8935441edy.4.2023.09.06.13.02.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 13:02:49 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so189995a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 13:02:49 -0700 (PDT)
X-Received: by 2002:aa7:d805:0:b0:527:fa8d:d40b with SMTP id
 v5-20020aa7d805000000b00527fa8dd40bmr3010868edq.26.1694030569176; Wed, 06 Sep
 2023 13:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan> <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
In-Reply-To: <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Sep 2023 13:02:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
Message-ID: <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sept 2023 at 12:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> There are a few other issues that I have with this, and Christoph did
> mention a big one: it's not been in linux-next.

Oh, and the fact that it hasn't been in linux-next became immediately
clear, and it's a real practical problem.

I get a compile error when just doing a basic built-test:

  fs/bcachefs/btree_key_cache.c: In function =E2=80=98btree_key_cache_creat=
e=E2=80=99:
  fs/bcachefs/btree_key_cache.c:356:56: error: implicit conversion
from =E2=80=98enum btree_node_locked_type=E2=80=99 to =E2=80=98enum six_loc=
k_type=E2=80=99
[-Werror=3Denum-conversion]
    356 |                 mark_btree_node_locked(trans, path, 0,
BTREE_NODE_UNLOCKED);
        |
^~~~~~~~~~~~~~~~~~~

and that compile error is actually a sign of a pretty serious bug.

BTREE_NODE_UNLOCKED is of the wrong enum type, and has a value (-1)
that simply cannot be represented in a 'enum six_lock_type'.

I'm pretty sure that the compiler is actually allowed to assume it is
in the range of the source enum.

Yes, the inline function then does a cast to 'enum
btree_node_locked_type', but because the compiler may assume that the
incoming enum has values 0..2, it's not clear that it will necessarily
cast the value -1 to the expected value.

It probably works in practice on x86 (without -fshort-enum, I think
gcc will always use an 'int'), but that code really is wrong. On other
platforms, gcc defaults -fshort-enums on, and in that case a 'enum
six_lock_type' is actually of underlying type 'unsigned char'.

And guess what happens when you have (unsigned char)-1? It does *not*
cast back to -1.

I don't know whether any of the architectures we support has that
"default to -fshort-enums" behaviour, and at least hexagon uses
"-fno-short-enums" to avoid this issue, but it really is a serious
bug.

A Clang build also results in objtool complaints about bcachefs, with

  fs/bcachefs/buckets.o: warning: objtool:
bch2_trans_mark_metadata_bucket() falls through to next function
bch2_trans_mark_dev_sb()
  fs/bcachefs/fsck.o: warning: objtool: write_inode() falls through to
next function hash_check_key()

and sure enough, the code generation ends up being

          movq    %rbx, %rdi
          movl    %r12d, %esi
          callq   bch2_trans_restart_error
  .Lfunc_end25:
          .size   write_inode, .Lfunc_end25-write_inode

and the issue is that bch2_trans_restart_error() is marked __noreturn,
but objtool hasn't been told about it, so objtool is very unhappy
about that "code seems to fall off the side of the earth" kind of
issue.

Both of these are very much signs of "this has never been tested in
other environments", and would presumably have been found immediately
in linux-next.

As it is, I'm not convinced I want to even continue to go through this
all, when it fails at the very first hurdle. A clean build is not some
"would be nice" feature, and it is big part of why we have automation
for new code.

                     Linus
