Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BAB77C9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjHOJFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbjHOJFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:05:03 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621B11A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:05:02 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56c884e1d74so3885193eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692090301; x=1692695101;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJQN6yoEhbxXPbZZLN6+xGLWZ7IHLn+sTDsFmi63TNw=;
        b=omH+Lz68cwjbCm/D7X9r6H/UVNK2jBInKn0vPdtSb4lbNUf54jyK2AyAfqbNGHFJwv
         L5kcHEEE4kj0b1i5dF/Y9z0L6208KBQlbNNxcWntZFKE1UrmhaDq6BLsLhT8JDbsJEd+
         4utxwFNRZonZYMGCMy4RYyMXG01BVG3injXy9KEjrtDashT6K1mUnmiqmSCBpys3Eql4
         fkTQJBoivU1ZrFQdweCuWse8eddiRWJKEur5XSzpaTq7YHhDSf5DACEb6Ea6QMFReEj6
         hejS7zG4TKUGNJQALYG7LCzmiR/PsGIWVG1Fuag3SyCZopG3FB5Kh2xPYSqhqsj3sEHZ
         nnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692090301; x=1692695101;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJQN6yoEhbxXPbZZLN6+xGLWZ7IHLn+sTDsFmi63TNw=;
        b=FUWHdOjM5pIND4mmQJ8LLryYOrQDRZ42FDZ0ll3R8yfAvYJmLU8x0nk39VgrUUD3FF
         lXtSj4zqg37KBHF/yXLwDaWFncJlUzNUz9GdLFVr8Q6H3/XGn5aYZmbcRfkB+kz6CREo
         mr+hLzS4Dey43fxMNqxCUYFioG3l+CVU9URIjgluHMqZlcbcbHK3zPZFAA1qtdwy9bOi
         Q836xAMIyqMOnnw6P6qzqwa4Qv9WOsvgi/AxYwB6RTmc/3ClA10N3hKLdgm7Gw2HsByg
         EgDILEN2XPuvBcJVmAJleEXaoZwz1djuz9r/A+fQhK6ElCaiKbrCKt1TGSShHbMgcOkF
         a7Eg==
X-Gm-Message-State: AOJu0YySqxHf2CObaA1/BO4eOqMDsbZktwbFwrdLK2kw00iIm64wWUEV
        SuDNl/uuAdGr9cCIYuRMuRRjxRZQeXuS6tlZsoT4x5RVTWo=
X-Google-Smtp-Source: AGHT+IGwh/fYWar+hohjWFZdpvjeb8wTgxr3IdFsxgyY6xYd0bz30DluA8kkFBqVmyiKSizm3CB0MSIil1TEndTSaBY=
X-Received: by 2002:a4a:3841:0:b0:56e:466c:7393 with SMTP id
 o1-20020a4a3841000000b0056e466c7393mr1580386oof.5.1692090301500; Tue, 15 Aug
 2023 02:05:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:745a:0:b0:4f0:1250:dd51 with HTTP; Tue, 15 Aug 2023
 02:05:00 -0700 (PDT)
In-Reply-To: <20230815-abklatsch-naschen-651453779dca@brauner>
References: <20230812161554.1676652-1-mjguzik@gmail.com> <20230815-abklatsch-naschen-651453779dca@brauner>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 15 Aug 2023 11:05:00 +0200
Message-ID: <CAGudoHHKpAH4DJvbSRMTfo4+HHBBBx7JF56UUGQtj-JPt+zimQ@mail.gmail.com>
Subject: Re: [PATCH] locking: remove spin_lock_prefetch
To:     Christian Brauner <brauner@kernel.org>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23, Christian Brauner <brauner@kernel.org> wrote:
> On Sat, 12 Aug 2023 18:15:54 +0200, Mateusz Guzik wrote:
>> The only remaining consumer is new_inode, where it showed up in 2001 in
>> the following commit in a historical repo [1]:
>>
>> commit c37fa164f793735b32aa3f53154ff1a7659e6442
>> Author: linus1 <torvalds@athlon.transmeta.com>
>> Date:   Thu Aug 16 11:00:00 2001 -0800
>>
>> [...]
>
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>

this already landed in master, see c8afaa1b0f8bc93d013ab2ea6b9649958af3f1d3

so please drop :)

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>
> [1/1] locking: remove spin_lock_prefetch
>       https://git.kernel.org/vfs/vfs/c/a3e07d2abfef
>


-- 
Mateusz Guzik <mjguzik gmail.com>
