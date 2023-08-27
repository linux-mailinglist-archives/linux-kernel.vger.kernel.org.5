Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744F678A107
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjH0SeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjH0Sdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:33:47 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F75C2;
        Sun, 27 Aug 2023 11:33:44 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-48d0edd8a81so942563e0c.0;
        Sun, 27 Aug 2023 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693161223; x=1693766023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AjI9Pwq+N4FR718gGbAXgguaZx2dSf1QeJaOjWxI7o=;
        b=sdZGpN/ILlKUlvbsi7pQXmeHlJXhrJa5wj5FID4xZUBlBtpZwJIhZmLHUbJXrcYOMy
         3ijwsnvW1816kx6GP2ERk+EP6xr9QESmER2/KKBxHz9lao9Bd0S+OhbpSEA5zta/kUhQ
         H0Ey4mqkdYEQK87slMoPoL5tDeQSq/CSQwUzsBcr1t/JFgbNP4XINbIXmEZbqm5/yOda
         3zlA/QsW/R4CwlHIuvnw5ClRpjd8hn4Q7hSetrw1xlm18Mf7yfwfVbdnOelMHAVW2aC3
         pbNwbXL0qqjBAih65F7wWOF//GdMNRcAzKEh81y3xi/t39lw5pSFoYnbQtvmL02ZJn1d
         oK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693161223; x=1693766023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AjI9Pwq+N4FR718gGbAXgguaZx2dSf1QeJaOjWxI7o=;
        b=HgCgaNhTl6rwBmQ0sHw+oEZyN0GKqFB2zznx6nxsYtncakHEb1jX9WzSuRiVTGmR23
         odliKaxcs3spJSFOn0UFfiintLGzGGVnLAohQ717jlgaWAGRN14d/IHhjjPLrfr+3mP/
         ofnAO8a6BKj2tqrtBhuz6p2PfdhQB8E20hB5aYaz2Eb2igqJyHN+l//xhdqsIxpgzCps
         wbKoaLeJUc7KNpRLjS1lZtkTEtDOoQ0uyBakSG7tA+VLdFO5Qw0lIW7DDyK1zQpOtnPX
         bB07h/1ocb2vEPd8CvSvpr6nKN3nlyekmkMM2oZ+mNOZI3ZVuuFJQHi98/QT78mwbo6m
         4VsQ==
X-Gm-Message-State: AOJu0YzDkdXMu1V3KShWfYu/Eor2k2n/33fFLI4NH1Rn23sAcr5aZgyW
        VGNwIzlPJRvltcNHu2tlfz0oGk5WaEpcwo1T9o8=
X-Google-Smtp-Source: AGHT+IG0s80d/slHpcIbqAe8hJygc15l3As8SYY9WMc/Ti9GQ/8PSoxiNE2KD8BVOqzSRYp6KiWrIh76ZDQYj6LcC3A=
X-Received: by 2002:a05:6102:89:b0:44d:4b8d:31e5 with SMTP id
 t9-20020a056102008900b0044d4b8d31e5mr13869889vsp.35.1693161223159; Sun, 27
 Aug 2023 11:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+jjjYTk=5wn2o46uNB+bJYX8xLgMP==dsJuvC94DvtN2f_6Yw@mail.gmail.com>
 <ZOqg9VovoVanfuR0@debian.me> <CA+jjjYT6+NJwB2Kn0jWLKtmz3dWH6UnVJNA6vDbPXnnJnHMf9Q@mail.gmail.com>
 <20230827020635.GQ3390869@ZenIV> <CA+jjjYRr3SHvXhVZLfACkUrN98n3W8aMBe1e8zqUNDuRZt17=A@mail.gmail.com>
 <20230827041716.GR3390869@ZenIV> <CA+jjjYRY4+ZwX6OJQ1Ax16i5roRh-BPePPjyGv7coxvBrxXiEQ@mail.gmail.com>
 <20230827163000.GS3390869@ZenIV>
In-Reply-To: <20230827163000.GS3390869@ZenIV>
From:   Joshua Hudson <joshudson@gmail.com>
Date:   Sun, 27 Aug 2023 11:33:32 -0700
Message-ID: <CA+jjjYT1NgR79CuBso4O_C=jVKRG8GKbv8xu9aqPJFv1hOJ=3Q@mail.gmail.com>
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

On Sun, Aug 27, 2023 at 9:30=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sun, Aug 27, 2023 at 07:39:03AM -0700, Joshua Hudson wrote:
> > Offset 0x1C into the FAT filesystem is defined as "Count of hidden
> > sectors preceding
> > the partition that contains this FAT volume." It's been there since
> > DOS 3.0. The Linux
> > Kernel does not care what's in this field, but I have tools that have
> > a hard time of it
> > not being there. One example of a tool is BootDuet.
> >
> > The rationale is to reduce the number of tools that have to walk the
> > partition table, the
> > most obvious one being the boot sector itself which doesn't have room.
>
> ???
>
> That makes no sense whatsoever; "boot sector" here is the first sector
> of _partition_, not that of the entire disk (that would be MBR).
>
> To quote the same wikipedia,
> ----
> A volume boot record (VBR) (also known as a volume boot sector,
> a partition boot record or a partition boot sector) is a type of boot
> sector introduced by the IBM Personal Computer. It may be found on a
> partitioned data storage device, such as a hard disk, or an unpartitioned
> device, such as a floppy disk, and contains machine code for bootstrappin=
g
> programs (usually, but not necessarily, operating systems) stored in othe=
r
> parts of the device. On non-partitioned storage devices, it is the first
> sector of the device. On partitioned devices, it is the first sector of
> an individual partition on the device, with the first sector of the entir=
e
> device being a Master Boot Record (MBR) containing the partition table.
> ----
>
> So your rationale doesn't work - you need to know where the partition is
> just to read the sector that contains that field.  Or have access to
> something that can be asked to read from partition, as opposed to the
> entire disk (kernel, for example), but that something can usually be
> asked where the hell does partition start.

The MBR doesn't look at the BPB. It looks at the first four bytes of the
partition table entry, loads that sector (which is the VBR), and jumps to
it. In the late 90s it became a thing to pass DL all the way through to
enable booting from ZIP disks, but nothing else is passed from the MBR
to the VBR. Thus, the BPB is in the VBR and describes the filesystem
and knows its own offset (otherwise the disk would not boot).

https://github.com/FDOS/kernel/blob/132a0a9f94d23f13c90319bb0e0232a5f33164d=
8/boot/boot.asm#L203

Almost everybody depended on this exact behavior for dual booting. Each
OS was defined in the boot menu as a path to a 512 byte file, which was
that OS's boot sector. They don't access disk relative to their own positio=
n,
but rather what their position should be.

So what I did: unmounted /boot/efi, started a virtual machine with /dev/sda
as the disk, booted a different OS than the host OS, shut it down, and got
very confused when changes to /boot/efi via the guest OS were not reflected
in the host OS.

>
> On anything with UEFI the first sector of the entire disk is likely to be
> the "protective MBR" in the beginning of GPT.
>

# dd if=3D/dev/sda bs=3Dc skip=3D446 count=3D66 | hexdump -C
00000000  00 00 02 00 ee ff ff ff  01 00 00 00 af 88 e0 e8  |....=C3=AE=C3=
=BF=C3=BF=C3=BF....=C2=AF.=C3=A0=C3=A8|
00000010  80 20 21 00 06 df 13 0c  00 08 00 00 00 20 03 00  |. !..=C3=9F...=
.... ..|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|
00000040  55 aa                                             |U=C2=AA|
00000042

I wouldn't be too sure of that. And yes, the second line corresponds
exactly to the EFI partition's entry in GPT.
