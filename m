Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53067789FCB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 16:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjH0Ojf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 10:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjH0OjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 10:39:18 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03F4129;
        Sun, 27 Aug 2023 07:39:15 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44d60bb6aa5so1080474137.2;
        Sun, 27 Aug 2023 07:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693147154; x=1693751954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RbkDLVWV7SlVPpKnMQQzDmJvbVwG+RXJq9rFTZhcWvM=;
        b=KWcc+98HlNXafG4sBMJIdguA2WwdPmx+vcTZjN58oCYxNHBji1u6XYqxGC7SpzRBqW
         In3E9lsla1WzU2mflSkipsJ3LGLjABOvkU1aOaZgCOJyN1Bovat8zbMj4CSA+vNTOEx4
         Wml6VxE+7z4IUOlrhjWDdY81PutrIS2ElHvs3q9c/8gEnCITmozRVM1PjU/l4hsEbAnI
         9oOnLxWIwwllJfx/aQtp2YwqZgW/2mVujqdqM/lUiyQgQ2O1AJrguyrJhrl7k/LZMoT7
         qqPoo8gco+99570XuCJcofJwlzGH8i23IKmzBtAwTQgLTjznG9EJFLLHdv27d4L3A7l3
         GX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693147154; x=1693751954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbkDLVWV7SlVPpKnMQQzDmJvbVwG+RXJq9rFTZhcWvM=;
        b=dVKc8OPkBgcvDW8aSAF20g4Eq4YTGeJVy1Wn9wLMJw7wpTS1WRxAYZ2iRJaE9Qye9H
         cNYbJtxP/okLDayGCnT4nXFne9PTgMR/SjyJvGU8vmOIICkdt8ju9MD3zdBaLVytv0km
         ibXezuo/PIXPjWSDNmj0+qkBZD1wJE2ocTsKobyJ3n6Gjl1WK+0z908k0DiuwDm7Ozwh
         ayvJLcWXl/IKL1BZISGFQG2AsbfX4moT4HEH9p3yXaGclrWrofE7Qf+leuZXsfLt69ku
         VHPcvDG7jUWRKhKIAx/kSJVL/I/SxI893prIl3Tc9OL0Y4Eb9ZFWEpYI+mE+QNjP4UCd
         sHhg==
X-Gm-Message-State: AOJu0YyPYVFcaEUW9PL5o8s8xn+1aEDXYgAC8da498h5C+rndjzL5dNQ
        9dnsQWmaHyHunj+On3fWSLlGp/8ElQ7Nue8NtK8=
X-Google-Smtp-Source: AGHT+IEX+RAgXCQ5yMhhglD3n+GFxxJXMdqHGn0csu8wrY6J+nuUwojzLMK48LqDh68q++CCEkFgtgdoxalGXHgBk28=
X-Received: by 2002:a05:6102:50a0:b0:44e:c10f:c15a with SMTP id
 bl32-20020a05610250a000b0044ec10fc15amr1368915vsb.35.1693147154575; Sun, 27
 Aug 2023 07:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+jjjYTk=5wn2o46uNB+bJYX8xLgMP==dsJuvC94DvtN2f_6Yw@mail.gmail.com>
 <ZOqg9VovoVanfuR0@debian.me> <CA+jjjYT6+NJwB2Kn0jWLKtmz3dWH6UnVJNA6vDbPXnnJnHMf9Q@mail.gmail.com>
 <20230827020635.GQ3390869@ZenIV> <CA+jjjYRr3SHvXhVZLfACkUrN98n3W8aMBe1e8zqUNDuRZt17=A@mail.gmail.com>
 <20230827041716.GR3390869@ZenIV>
In-Reply-To: <20230827041716.GR3390869@ZenIV>
From:   Joshua Hudson <joshudson@gmail.com>
Date:   Sun, 27 Aug 2023 07:39:03 -0700
Message-ID: <CA+jjjYRY4+ZwX6OJQ1Ax16i5roRh-BPePPjyGv7coxvBrxXiEQ@mail.gmail.com>
Subject: Re: Cache coherency bug: stale reads on /dev/sda1
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 9:17=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sat, Aug 26, 2023 at 07:38:57PM -0700, Joshua Hudson wrote:
> > "Whole disk and all partitions have page caches of their own."
> >
> > That's so bad.
> >
> > I can think of numerous cases where this will cause problems; including
> > some I encountered last year and did not understand at the time. Manipu=
lating
> > EFI partitions through the whole disk device makes sense because FAT fi=
lesystems
> > *know their offset on the disk*, and some of the existing tools really
> > don't like being
> > given a partition device.
>
> Explain, please.  How does FAT filesystem know its offset on disk?
> Since when?  It had always been possible to copy a FAT image into
> a partition verbatim and it works no matter where on disk that
> partition happens to be...
>
> Has that changed at some point?  Do you have any references?  Ideally
> with some kind of rationale for that weirdness...
>
> Or am I misparsing what you wrote?

(Good news: finally found the invisible button to edit reply quote)

Offset 0x1C into the FAT filesystem is defined as "Count of hidden
sectors preceding
the partition that contains this FAT volume." It's been there since
DOS 3.0. The Linux
Kernel does not care what's in this field, but I have tools that have
a hard time of it
not being there. One example of a tool is BootDuet.

The rationale is to reduce the number of tools that have to walk the
partition table, the
most obvious one being the boot sector itself which doesn't have room.

With random BIOS bugs in UEFI still; I would *not* want to find out
what happens with
a wrong value here on an EFI partition.

Source: https://en.wikipedia.org/wiki/Design_of_the_FAT_file_system

(The field changed size; you actually want to read the entry under DOS 3.31=
)
