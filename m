Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFAC75DE62
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 21:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGVT5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 15:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGVT5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 15:57:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2A10C3;
        Sat, 22 Jul 2023 12:56:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso45311671fa.0;
        Sat, 22 Jul 2023 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690055818; x=1690660618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cP5qZpuE9PuKFQNB1UPD3lEvU+dXufBvkaX/xc8UOj4=;
        b=CuUcZel0Z7E82US/0alNe2jdLhEtKOTKLbLQuzZ4SOrjS0fzjKpEGn/S6U2b1KYILU
         rjn/ywGrMcst0pLsGLleCI5gRnFAlf6B1s4QkCsFdZlUOGrCeHFn/bfB8ilxQS6UL8hZ
         qyHxpWowVpaXsqMYbO1b4wa23gbOMQcJcp59i9uEpxoW9yGC+AaP8OYgFG4XI9mNHQqG
         j31ie0VUM7JdXHSIzwikTN+YnDSjLAEtwFM8k65tKmJt8ujh8hiXwYv9MoTHWVeKmJhl
         FdT1TY4nnKyyayJbmQQfYTSvI4egfRSMUVHnZzApze8UCdW4zQe1i8Tsq4Bi0EqfRAOG
         kWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690055818; x=1690660618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP5qZpuE9PuKFQNB1UPD3lEvU+dXufBvkaX/xc8UOj4=;
        b=QazELKvNmxRz2A4OLS/5ZQbl2BJDFol2y/3EK8zu5lclM6W5a33TsZ90HvQ3RnbHaQ
         Orxi/8lkeJglNvXPcuZUmmJ2Rpz4DovZsiH0u+1yOuqTGXgGSugqZidE4TROWLzqiJBC
         bkk0KyYxrLy4TiGd7JRBF56aaQjxaPvDcF3HQGHpEXh96gm5KeX9Jm6FclIFawZ4yd0S
         NFXg3o6sHbNftni3iuUqB8qGDugAOe6Clwt/RKIHJR196Hk8umw3vi8Xbu+feoCmVVRc
         imW6mk0EZRAx0uaNaI7U/2Zcr5vceMzobxY4tgDT5ovLKTBkIBVZ0u8vDeQCE9rBJBeT
         TSUw==
X-Gm-Message-State: ABy/qLbbUorjhyO7w+27dLlQsqBi68BebZ8BIb8s97pgyejhtqSG83Rn
        wapmInjioBg6xwXAiPJDfPWe+KUNUVMabMk3VE7yBQJCDB4=
X-Google-Smtp-Source: APBJJlHVSbTcg+CYyMwiAbVEa3n90aJp3WZPzZSAn+eYY9u0bBFm0E+bpJyZ4Lv6QlJL+tKKKo/+3qSD3hV1jLK3i98=
X-Received: by 2002:a2e:8097:0:b0:2b7:33b3:ab5c with SMTP id
 i23-20020a2e8097000000b002b733b3ab5cmr3449890ljg.35.1690055817569; Sat, 22
 Jul 2023 12:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msCqEDv1mUMMVTg8t7K+CO82Ha_xQoYJ-FkQ9h83By5wA@mail.gmail.com>
 <CAHk-=whTnOWaYxG2sU8ikFZsowUPApWgHxf0jM77ELUb39SuAw@mail.gmail.com>
In-Reply-To: <CAHk-=whTnOWaYxG2sU8ikFZsowUPApWgHxf0jM77ELUb39SuAw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 22 Jul 2023 14:56:46 -0500
Message-ID: <CAH2r5mv2V8SDi=qDDwsnoeXSLxqLXHH7FESEz736scrfU+w=MQ@mail.gmail.com>
Subject: Re: [GIT PULL] smb3 client minor debugging fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 1:24=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, 22 Jul 2023 at 07:19, Steve French <smfrench@gmail.com> wrote:
> >
> > add small debugging improvement
> > - it is helpful for network debugging of smb3 problems to be able to
> > use directory not just file (e.g. access to empty share)
> > ----------------------------------------------------------------
> > Shyam Prasad N (1):
> >       cifs: allow dumping keys for directories too
> >
> > Steve French (1):
> >       cifs: update internal module version number for cifs.ko
>
> Bah. I pulled, and then unpulled, because that module version number
> change was obviously garbage.

I had missed a line in the version update.  Have now fixed that typo.
The module version number is used e.g. to tell when someone has
backported fixes for cifs.ko to an earlier kernel release (so e.g. we
can see from "modinfo cifs" or "cat /proc/fs/cifs/DebugData | grep
Version" whether they are running an updated version of cifs.ko or the
default version for that kernel).  I try to update the module version
at the end of the merge window but have sometimes delayed updating it
until after an important fix.

> This pull wasn't really a "fix" anyway, but then when I see nonsense
> like that I just decide it's entirely bogus.

For some context on the debug improvement:
- the keys change improves ability to read a network trace to debug
problems on encrypted connections which are very common (e.g. using
wireshark or tcpdump).  That works today with tools like "smbinfo keys
/mnt/file" but requires passing in a filename on the mount (see e.g.
https://wiki.samba.org/index.php/Wireshark_Decryption), but it often
makes more sense to just pass in the mount point path (ie a directory
not a filename).  And this fix was needed to debug some types of
problems (an obvious example is on an encrypted connection failing
operations on an empty share or with no files in the root of the
directory) - so you can simply pass in the "smbinfo keys <mntpoint>"
and get the information that wireshark needs.

I have updated to correct the version missing line at
git://git.samba.org/sfrench/cifs-2.6.git
tags/6.5-rc2-smb3-client-fixes-ver2

--=20
Thanks,

Steve
