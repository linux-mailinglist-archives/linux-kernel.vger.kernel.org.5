Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E124789B07
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjH0CjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjH0CjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:39:11 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76FD198;
        Sat, 26 Aug 2023 19:39:09 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-44d4c3fa6a6so896140137.0;
        Sat, 26 Aug 2023 19:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693103948; x=1693708748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YclM2rcAOdd8l+ascUQHzxjafV7NOlnSyJsVWi30UWg=;
        b=U26QKM0Kler819ZCbbhEZdjf6T4w1wy/aEndDNqNI8I5iTbJXJa2MZnBoKt4oP9FuB
         JLTNLU/iqVrRyvFRHn304FP+QGAvcd8G98Wrh5zjJ8nPlokJSKpTv13DDZ3oA1l5/U6W
         LeNK14er1mqiOVI4kb0ocZnPXy+Y/pKV1TvcLCuZ6PO7tMJWxwrcE0BearX3w8mbrtTO
         NQ9qe4iv2MN2ote/KTV7vbTj7a8W43XwahQYykJ0ai7Ai0ysYLucpv+MhtNw2z9zbFXE
         FHFYOGvgYGRkoS9o3AD8jxCb+lMkzB+m78XMaGZXYtWchYBRM0ord2W6oZknxMPgQYT/
         AAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693103948; x=1693708748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YclM2rcAOdd8l+ascUQHzxjafV7NOlnSyJsVWi30UWg=;
        b=TvYc8y8n+SOL5iWvyc7Q2xU9oqQAkQwTlnnG9hVlCbsSs+A7YIP7x7s7OPlwoEzUKU
         P0Ps9EK24KpkT38RfZEUw0q10N6+ZF/VJva6ObrdroIWadeuIvJam9Q7e3lW2IDMsQy8
         PBrdiDfHnkQ6A9ESi6avBvwO7W8r5b0Io3T0TViu6ibLV+Vl8o6R/IAJYLn4xI3rmpWX
         QsJWzkK6A0iwdyvH1oucb+45vgB7KWrF6U+WwVlsk7w9PU+pFlVrNa8+LRPhQxxHSrN3
         cCTAG3M7w5Ol0sfmkuXLqkTh9beXljv/79642p7Ey5jG8zd+g0WxjVeOeQDXuNpHz2pK
         e8nw==
X-Gm-Message-State: AOJu0YxYBdDVmVxAb0WLmPea0WX/etU5XjQIe4Emy7F1qm1HzsxH6Abw
        NGsR6EkpYS0MyPwwmMgEaPo1I+92OaAR2+vRptI=
X-Google-Smtp-Source: AGHT+IG9u7CSk9MsLZztwz3f86zjhb0y3DSMpyidSYZ5VzUruGpbbFj3bjz7OWEUTkJSxRZyFBCO3YxV0q2uQgXyOZM=
X-Received: by 2002:a67:f845:0:b0:44d:57aa:532f with SMTP id
 b5-20020a67f845000000b0044d57aa532fmr14706132vsp.31.1693103948658; Sat, 26
 Aug 2023 19:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+jjjYTk=5wn2o46uNB+bJYX8xLgMP==dsJuvC94DvtN2f_6Yw@mail.gmail.com>
 <ZOqg9VovoVanfuR0@debian.me> <CA+jjjYT6+NJwB2Kn0jWLKtmz3dWH6UnVJNA6vDbPXnnJnHMf9Q@mail.gmail.com>
 <20230827020635.GQ3390869@ZenIV>
In-Reply-To: <20230827020635.GQ3390869@ZenIV>
From:   Joshua Hudson <joshudson@gmail.com>
Date:   Sat, 26 Aug 2023 19:38:57 -0700
Message-ID: <CA+jjjYRr3SHvXhVZLfACkUrN98n3W8aMBe1e8zqUNDuRZt17=A@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Whole disk and all partitions have page caches of their own."

That's so bad.

I can think of numerous cases where this will cause problems; including
some I encountered last year and did not understand at the time. Manipulati=
ng
EFI partitions through the whole disk device makes sense because FAT filesy=
stems
*know their offset on the disk*, and some of the existing tools really
don't like being
given a partition device.

There's also the astounding: write stuff to disk, umount everything,
copy one disk to
another using the whole disk device doesn't work because reading the whole =
disk
yields a stale cache (sometimes).

On the other hand, I can think of very few cases where the file vs
disk buffer pool
matters, because the loop device is unaffected (writing to a loop
block device is
coherent with the file).

On Sat, Aug 26, 2023 at 7:06=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sat, Aug 26, 2023 at 06:25:58PM -0700, Joshua Hudson wrote:
> > I am presuming you mean "Are you sure this not a hardware issue?"
> >
> > I am sure it is not, for two reasons.
> >
> > 1) If it were a hardware issue I would still expect the two device
> > nodes (whole disk and partition) to report the *same* data.
> >
> > 2) I have since developed a workaround involving BLKFLSDEV. The
> > workaround is really ugly.
>
> Whole disk and all partitions have page caches of their own.
> There is no coherency between those; write through one, then
> read through another and you are not guaranteed that read won't
> see the stale cached data.
>
> Doctor, it hurts when I do it...
>
> Incidentally, read from device/write to the place you've read via
> file/read from device again also has no coherency warranties, for
> exact same reason.
>
> IOW, not a bug.
