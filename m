Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C66754E34
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 11:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGPJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 05:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGPJyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 05:54:11 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63823FA
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 02:54:10 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63c82f9094bso2927036d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 02:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689501249; x=1690106049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuZSHeCu4KqE0b9tPVjiUw2JtLp/pUndGexcbDWarPk=;
        b=UrzEKoECC1d+KLjCr/lwD5eCn5Oi0RLv6IfOfCkJmauMf+fw2I5HrRDTLbUkvKcwNd
         XdUZM2UPW2gxBZ420NUDlauFRvx6ZTdzhKb02qv3aAHJJcrMM/GKZ5HppkEL1mzNdUb1
         aiwM/aEStayXG5EVNyApST8LXXZxYK95ewBqVATHlVT6JBPP/mhmlh+J4qC2Oh9zWoTx
         Oxa9LjLxHSZGfgnQGQHm6y3lK/YWj/WrBM5Agtovod6XBZ5hZhDGWPPpLRypYQmjSPp6
         hSBQ2PvNhb3ILBhbqYF0XyjmjZBTkXkas3tgrWHG8WjiIFqTxN3iKJpszrFERBiNRNEs
         z8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689501249; x=1690106049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuZSHeCu4KqE0b9tPVjiUw2JtLp/pUndGexcbDWarPk=;
        b=AfSOiVD1X+CcgelJ1tAqNfik8lx8wIbKdHdqTsOHSQqpLiHoij/KDw1RyY5SuikTNe
         Omiv7I0ruEA5+kLuV8t8ErJPk2+vtDfEwKj9clIQP609ghyeImWYmNzv1aVsju8USfwO
         hx1o90k7dU7gygByLnZ3dVtcYkiID9Ugkw/Ykpir4kkQnWGBYbbFLNykSF2jfKNJyFQc
         5P/DR56KRBEpFNsWN8o6cH++x7DaAieRCHCevdFtSkdQSFT2cdTCGEBbvAa6U7+BFElj
         mwHMSyUSOtL1Vf0BCv7n4W70POOn6+hG41ku37DFH6a1HQ85jSTa9/fpURGb7gKOyArE
         iY6g==
X-Gm-Message-State: ABy/qLak4JG8BUeyjVmMSfVMxAIB7ytslKzOKkCmDwD4+egFoLidhHbu
        pC21fggiJYs0mD31XyTPidIW7UdOr8i7l8fyyAmfz2oz874u2804
X-Google-Smtp-Source: APBJJlG3b2n1Cleoh1rXOeLJbbCGQk7EzlaEvvsuju5VYXuWLDyO0YFdK2d9cfiU/ukMr6Pv18nYWlEf6I7Vyon2n54=
X-Received: by 2002:a05:6214:d0b:b0:61b:2111:c2e2 with SMTP id
 11-20020a0562140d0b00b0061b2111c2e2mr4978364qvh.2.1689501249386; Sun, 16 Jul
 2023 02:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN3JqXckWO=V7p=FhPU1tK03RE1w9UE6xL5Y86SMk209w@mail.gmail.com>
 <b41e1b86-6280-5779-7bb7-3ba97481239@google.com>
In-Reply-To: <b41e1b86-6280-5779-7bb7-3ba97481239@google.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 16 Jul 2023 14:53:58 +0500
Message-ID: <CABXGCsMaMgcPskMHPL+E=cOf9YMyaSnxg2dMa2jWO7qbjZGkjQ@mail.gmail.com>
Subject: Re: [bug/bisected] I see "mm/pgtable-generic.c:53: bad pmd
 (____ptrval____)(8000000100077061)" every boot time
To:     Hugh Dickins <hughd@google.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 7:42=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
>
> And thanks for the patient bisecting.  Yes, it will be 0d940a9b270b
> which introduced the unexpected problem, then be872f83bf5 which fixed
> the unbootability aspect (that's right, isn't it? with be872f83bf5 in,
> your machine booted ok? but in between it was unbootable).

Absolutely right.

> Very useful info, since it narrowed the symptom down to users of
> that pagewalker, before it was allowing for NULL from pte_offset_map()
> (we were not expecting ever to hit a bad pmd in normal circumstances).
>
> I have now been able to reproduce such a message, by setting
> CONFIG_EFI_PGT_DUMP=3Dy - am I guessing correctly that you have that?

Yes.
$ cat .config | grep CONFIG_EFI_PGT_DUMP
CONFIG_EFI_PGT_DUMP=3Dy

But distro Fedora has been set this setting to "Y" since 2016.
https://src.fedoraproject.org/rpms/kernel/blob/1b7eeb80190501aaf226e90e8f58=
f994cfc3efe0/f/kernel-x86_64-debug.config#_1293

commit 1b7eeb80190501aaf226e90e8f58f994cfc3efe0
Author: Laura Abbott <labbott@fedoraproject.org>
Date:   Thu Nov 10 10:16:25 2016 -0800

    Change method of configuration generation

    The existing method of managing configuration files gets unweildy.
    Changing individual lines in text files gets difficult without
    manual organization. Switch to a method of configuration generation
    that's inspired from the method used inside Red Hat. Each configuration
    option gets its own file which are then combined to form the
    configuration files. This makes confirming what's actually enabled much
    easier.

> For now, I recommend that you leave CONFIG_EFI_PGT_DUMP unset.
> I wonder how many other people have it set, but have not yet noticed
> this "bad pmd" message you are reporting.
>
> The problem comes from a confluence of surprises: the pagewalker
> now makes an exception for init_mm, but efi_mm is another odd case;
> and espfix sets up pmd entries in an unconventional way, which happens
> to fit the "bad pmd" criterion; then the efi_mm pgt dump discovers them.
>
> I'm not rushing to judgment on where and what the right fix will be,
> that needs some reflection.  And perhaps more urgent than that, is that
> I got not one but 12 such messages (with 4 processors): that's another
> surprise, I would have expected the condition to be cleared after the
> first message (but that clearing to ruin the running of Win16 binaries).
>
> More will follow, at lower priority; but if I'm wrong about you having
> CONFIG_EFI_PGT_DUMP=3Dy, and unsetting it hiding the issue, please speak =
up.

I confirm after unsetting CONFIG_EFI_PGT_DUMP the "bad pmd" message
didn't appear any more.

--=20
Best Regards,
Mike Gavrilov.
