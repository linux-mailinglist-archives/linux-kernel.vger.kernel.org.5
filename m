Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7842879002A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbjIAPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjIAPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:52:42 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C23310E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:52:38 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68bed2c786eso1803738b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1693583558; x=1694188358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lqD6F9hQEjrLwITu6O6UtLx0oEpIDMvFu3M5X8+XSwI=;
        b=pgp4kW/3v9X6zJd6qi6uChpNNUFiYhPCDEubTHJUgqTGW4WCJLV0c5smw79l66zQTy
         SuuivhLlbq6bUHgGpVkqdB3SEoio8tNOHgE59Un/qdxBa9JocKCihY57JFNz9Ld7bLcJ
         D9QstCEXKbnQFHrVQj6p2Y4Alg5e3L1mRaat0k4w0bXWdFRm2eQOTCJvR/PTjQy0+MNV
         11ZNQNL6+77HQCqDRTWZj7MbIbJfPQJ8+9JmkjXRpk38qJoj+eTEyvxT9u0TBXhMAoNn
         9dc5lYYrJWdcpqLPgRZm9HSY01roo2GPt1cIaPUSxP20CpnHm7QWuYi1Eeay0tXbw1ET
         zZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693583558; x=1694188358;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqD6F9hQEjrLwITu6O6UtLx0oEpIDMvFu3M5X8+XSwI=;
        b=Lnz/uX23fc9NqTH/wRGlzGyS3g7OH2vJd7VjyHOoyJJ/jaGMBA5h6QBJwbjNhJXLDT
         V4J2scrlNynIJODym95//06gJPniw9oD2sBMycxx6TY1XzZ/onKTzkJ55RRO/41nTwWe
         ltWvapE7UosRzngtqHLIv9AUbAGPph0THenkhqXISbZjgSH8THJHwqkFhEdCT7dklKwh
         5ejI7UcVUlkotmoeUxGmrbKAqvN8gK4IrPWhAvR7R4lmdNVV8dDMJ/yFWJO8msp24Izp
         B3VQpZkKM3lP5xKt4cx/8uvuzQMEYpzP5bp3p/mrvp3VRqE1O7zVbGQyVZNxXF83Gx2W
         6ZUg==
X-Gm-Message-State: AOJu0YwHblcML7nKlNPQi1l/dQBUHwr2U18uT74sjJo2GyJ7XPMX5+Iz
        BGvwG1xT4tsp8ICEsB6Mq91UEQ==
X-Google-Smtp-Source: AGHT+IEsJwd67wWu6obKIBkuyj8i6oFcNlHwVk6w5MP+PXzFL1qJikZmxVhuHEXPdkkBiS9v+qBf3A==
X-Received: by 2002:a05:6a20:1612:b0:13f:5a05:6038 with SMTP id l18-20020a056a20161200b0013f5a056038mr3331551pzj.58.1693583558012;
        Fri, 01 Sep 2023 08:52:38 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id q19-20020a62ae13000000b0068a49aad7d4sm3123612pff.79.2023.09.01.08.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 08:52:37 -0700 (PDT)
Date:   Fri, 01 Sep 2023 08:52:37 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Sep 2023 08:52:35 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 1
In-Reply-To: <CAHk-=wj3iBTT5mcYvaUH+fX7Y+z=JUbx6O5nvNMkpe2k8Hcokw@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-2dd1e80e-1a99-4cf2-82cd-3a880957e16d@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2023 08:21:35 PDT (-0700), Linus Torvalds wrote:
> On Fri, 1 Sept 2023 at 07:41, Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> for the other the result I ended up with was
>>
>> extern pgd_t early_pg_dir[PTRS_PER_PGD];
>> static pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>> static p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
>> static pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;
>
> That's wrong, you should have removed the 'early_pg_dir' declaration
> that is now in <asm/pgtable.h>, as done by commit d2402048bc8a
> ("riscv: mm: fix 2 instances of -Wmissing-variable-declarations").

Thanks, Nick had pointed that out too but looks like I missed it.

>> though that's not showing up in the git diff, so I may have something odd going
>> on here.
>
> So what's going on is that you resolved the merge conflict by taking
> everything from one side (not correct, as above), and then git no
> longer considers it a conflict after-the-fact.
>
> Side n ote in case you care about the actual git logic:

Ya, I'm always interested to hear -- as I'm sure you can tell it's still 
a bit of a mystery on my end, but I'd rather learn when I get lost than 
just keep being lost ;)

> The git rules for merge conflicts are different when doing the merge
> and when showing the result after doing a merge.
>
> When doing the merge, git will do the expensive history calculations
> to figure out the merge base and do a 3-way merge of the base and the
> two sides.
>
> So at merge time, git looks back in the history from the two merge
> heads, and does the three-way diff based on the history leading up to
> the two points.
>
> But after the merge, "git show" will basically do the reverse: it
> won't look back in the history, but look at the *result* of the merge.
> You are, after all, asking it to show the merge itself.
>
> So then it will again do a three-way diff, but not of the merge base,
> but of the merge _result_ and the two sides.
>
> And if the merge result is the same as one of the sides, there's no
> conflict remaining, and so no three-way diff.
>
> So that's how conflicts sometimes "disappear" after the merge.

OK, that explains why I get such different results between the pre and 
post merge output -- my workflow involves commiting a merge and then 
pushing it up to the test builders, so I guess I should just be 
double-checking the pre-merge rather than trying to figure things out 
after the fact from just looking at the merge.

>                        Linus
