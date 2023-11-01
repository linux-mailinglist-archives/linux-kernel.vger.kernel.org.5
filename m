Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DBA7DE362
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjKAPCm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Nov 2023 11:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKAPCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:02:41 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C9DDC;
        Wed,  1 Nov 2023 08:02:38 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a7b91faf40so69489257b3.1;
        Wed, 01 Nov 2023 08:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698850958; x=1699455758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeqpghJGIn+FJig0S4AO4Z/Kq8V9fOr8ACdyqDQ8PIU=;
        b=kKmoSBrTaHJTreR6+77TQZSCf1aDxCWmyWCdQUfTDx6g7l3rzEF0+ELSixuWOw7UCM
         I9+zH1Ec99IRXEFDcaol1nFdKUnvgiv/hHU9HBVSsObb0zD8xvOX39lb4hftht6a4xci
         Su6mwQDZbybV9ov9wbr3GGxzTJOsv9FpNPHH8kVI37Bi+7Ew8rsL+zCJ31RF9T3rOf8Z
         bN+hLyr7fHPTuobnyHZhMhMt2vudUpKnq0FHcD4dcqZsciDHJcD2iVyZQga/+/REdZdO
         aot9CgPRJuHrNIR5Xu8BSRCwc/5Bj+hmbUSiCKXbIQ4TGGqHcvGWm1YMVWJppi0fnr72
         3B/w==
X-Gm-Message-State: AOJu0Yytbxa3j+g9jO6K63B90xxmDdP1tme2Xr1CxCxHHqubbrus7b3Z
        IoUrm7rkgMq0mVtoTimpuYcGZcO5/z7zRQ==
X-Google-Smtp-Source: AGHT+IG/giQJiapQlJiZ0hB6g0O2l9o3+d6JvoEPG5DoKXhxME6J+54LE5egxkmwMCEykgOJGUWANw==
X-Received: by 2002:a81:b60d:0:b0:5a7:c641:4fd2 with SMTP id u13-20020a81b60d000000b005a7c6414fd2mr15154808ywh.10.1698850957731;
        Wed, 01 Nov 2023 08:02:37 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id s5-20020a817705000000b00597e912e67esm17882ywc.131.2023.11.01.08.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 08:02:37 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7c08b7744so69506997b3.3;
        Wed, 01 Nov 2023 08:02:37 -0700 (PDT)
X-Received: by 2002:a81:e608:0:b0:5a7:baae:329f with SMTP id
 u8-20020a81e608000000b005a7baae329fmr13801406ywl.15.1698850957231; Wed, 01
 Nov 2023 08:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
 <CAMuHMdXpwMdLuoWsNGa8qacT_5Wv-vSTz0xoBR5n_fnD9cNOuQ@mail.gmail.com>
 <20231031144505.bqnxu3pgrodp7ukp@moria.home.lan> <CAMuHMdVKi=ShPUwTHrX0CEN2f9+jRXWymnKH=BiXTpmg857AJQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVKi=ShPUwTHrX0CEN2f9+jRXWymnKH=BiXTpmg857AJQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Nov 2023 16:02:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfj5q_06cM3dXvNyfdNZQM=M=ocbG5XFpCp2UhVjjJ9w@mail.gmail.com>
Message-ID: <CAMuHMdVfj5q_06cM3dXvNyfdNZQM=M=ocbG5XFpCp2UhVjjJ9w@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs for v6.7
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kent,

On Tue, Oct 31, 2023 at 4:00 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Oct 31, 2023 at 3:45 PM Kent Overstreet
> MEAN_AND_VARIANCE_UNIT_TEST should depend on BCACHEFS_FS, as the actual
> mean_and_variance code is only compiled if BCACHEFS_FS is enabled.

And I really meant "should depend on BCACHEFS_FS", not "should select
BCACHEFS_FS", like is done in today's linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/fs/bcachefs/Kconfig?h=next-20231101&id=487ed6712ae1bf2311197bd41ae572ff8da5e966

> On m68k (ARAnyM), it fails with:

[...]

> # Totals: pass:7 fail:2 skip:0 total:9
> not ok 1 mean and variance tests
>
> Haven't tried the test on any other platform yet, so this could be a
> big-endian, 32-bit, m68k-specific, or even a generic problem.

It fails in the exact same way on arm32 and arm64...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
