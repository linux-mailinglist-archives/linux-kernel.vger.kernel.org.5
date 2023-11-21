Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC67F33EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjKUQiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKUQiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:38:09 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45EE1A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:38:04 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a0064353af8so325858866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700584683; x=1701189483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnQiI66ERXdutobrQqwNJkAvBp6oF40h4hHvm90YF3Y=;
        b=QDhRS9MzoqDDTcR7J8T1UnTGCBkm43SjsgDXbuc3GWEW/kaRyRne/0I2/AdmIIDz5z
         OUhES7S4LXR/li1RTG0gnoyC7yzGEeF28oP6kqQldJNapIEFa6Pw+NV14Wjk+HVsukEE
         WJICAiJwldIEAvT/8E25TeHUnu3qt6lQXcvSJ6gn0bSpurX6U0CoJk/sXDtvQqd8e0e6
         agMlN3eOL+FqEpCDLueQPIqM7OwwmLC7p6QfHbZdpSQgLYnyygFqLGkedIiSO8Io7+2v
         3OOAnwzUZnziHN4nR8z68yn9uWns1KGZTnINMxqi93N6QN6bQ2UUcvfB4FWEZYdrYjxD
         ACnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700584683; x=1701189483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnQiI66ERXdutobrQqwNJkAvBp6oF40h4hHvm90YF3Y=;
        b=MoLZHCLTAKlJ+21agAxX/G+aPRCJGPwKfxru+7JuyXqP2ph2uWuEs1F2wtq3nED1sB
         Lpx1sDKrze88T6YgJT/OKVN1TeKXrEViKbqPYvj+FEMt2h+pJADZrlzRTy5jfgp4w+tv
         /yCdOEY4zRj+MQtd46jY8DIOMKTsZg+HYx1ul0gsSJukUZEgQftvwwC0Wt7FoSBvETO/
         Ec7mhIQqExrP1vWko6G/aa3OSI2dCCDu1KcAr12U2O8SW+PVpDKj9Cb5R26e8ooGdVIc
         UOZ+IwJMgGEE/0AxodmE7pIL1B/U+cYqYKTQAvxPCACidOqdmG/4Zpg5JhY4uyMAPVry
         H+Uw==
X-Gm-Message-State: AOJu0YzLv5noCoGntSJOgaK5L2J8kOqGh8C6+a60i99ibD5YZj6Rx1/F
        xkgUrHSQSFab3hMcHQJpjWcl/DlzH50zOS6kGEQ=
X-Google-Smtp-Source: AGHT+IEroNhDXAGLFWmJRyng0r89Z0+xmgDAHqE3ZDxTLpJf7V8p0TFYPwbmi9OUkIV7Mnqp4MCWZxXMO+CxAzCAzw4=
X-Received: by 2002:a17:907:72c9:b0:a00:76b1:7d9a with SMTP id
 du9-20020a17090772c900b00a0076b17d9amr3490030ejc.38.1700584682902; Tue, 21
 Nov 2023 08:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20231117192909.98944-1-marc.ferland@sonatest.com>
 <20231117192909.98944-6-marc.ferland@sonatest.com> <3d72e17b-aa8d-4611-996e-4a4adc7a2fdd@kernel.org>
In-Reply-To: <3d72e17b-aa8d-4611-996e-4a4adc7a2fdd@kernel.org>
From:   Marc Ferland <marc.ferland@gmail.com>
Date:   Tue, 21 Nov 2023 11:37:51 -0500
Message-ID: <CAMRMzCBehCjT1wTXXj797di7cy2w=BTvD1wPiEU3vQTwE=-KWg@mail.gmail.com>
Subject: Re: [PATCH 6/7] w1: ds2433: add support for ds28ec20 eeprom
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     krzysztof.kozlowski@linaro.org, gregkh@linuxfoundation.org,
        marc.ferland@sonatest.com, jeff.dagenais@gmail.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
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

On Mon, Nov 20, 2023 at 4:26=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 17/11/2023 20:29, marc.ferland@gmail.com wrote:
> > From: Marc Ferland <marc.ferland@sonatest.com>
> >
> > The ds28ec20 eeprom is (almost) backward compatible with the
> > ds2433. The only major differences are:
> >
> > - the eeprom size is now 2560 bytes instead of 512;
> > - the number of pages is now 80 (same page size as the ds2433: 256 bits=
);
> > - the programming time has increased from 5ms to 10ms;
> >
> > This patch adds support for the ds28ec20 to the ds2433 driver. From
> > the datasheet: The DS28EC20 provides a high degree of backward
> > compatibility with the DS2433. Besides the different family codes, the
> > only protocol change that is required on an existing DS2433
> > implementation is a lengthening of the programming duration (tPROG)
> > from 5ms to 10ms.
> >
> > Tests:
> >
> > dmesg now returns:
> >
> >     w1_master_driver w1_bus_master1: Attaching one wire slave 43.000000=
478756 crc e0
> >
> > instead of:
> >
> >     w1_master_driver w1_bus_master1: Attaching one wire slave 43.000000=
478756 crc e0
> >     w1_master_driver w1_bus_master1: Family 43 for 43.000000478756.e0 i=
s not registered.
> >
> > Test script:
> >
> >     #!/bin/sh
> >
> >     EEPROM=3D/sys/bus/w1/devices/43-000000478756/eeprom
> >     BINFILE1=3D/home/root/file1.bin
> >     BINFILE2=3D/home/root/file2.bin
> >
> >     for BS in 1 2 3 4 8 16 32 64 128 256 512 1024 2560; do
> >         dd if=3D/dev/random of=3D${BINFILE1} bs=3D${BS} count=3D1 statu=
s=3Dnone
> >         dd if=3D${BINFILE1} of=3D${EEPROM} status=3Dnone
> >         dd if=3D${EEPROM} of=3D${BINFILE2} bs=3D${BS} count=3D1 status=
=3Dnone
> >         if ! cmp --silent ${BINFILE1} ${BINFILE2}; then
> >           echo file1
> >           hexdump ${BINFILE1}
> >           echo file2
> >           hexdump ${BINFILE2}
> >           echo FAIL
> >           exit 1
> >         fi
> >         echo "${BS} OK!"
> >     done
> >
> > Test results (CONFIG_W1_SLAVE_DS2433_CRC is not set):
> >
> >    $ cat /proc/config.gz | gunzip | grep CONFIG_W1_SLAVE_DS2433
> >    CONFIG_W1_SLAVE_DS2433=3Dm
> >    # CONFIG_W1_SLAVE_DS2433_CRC is not set
> >
> >     # ./test.sh
> >     1 OK!
> >     2 OK!
> >     3 OK!
> >     4 OK!
> >     8 OK!
> >     16 OK!
> >     32 OK!
> >     64 OK!
> >     128 OK!
> >     256 OK!
> >     512 OK!
> >     1024 OK!
> >     2560 OK!
> >
> > Test results (CONFIG_W1_SLAVE_DS2433_CRC=3Dy):
> >
> >     $ cat /proc/config.gz | gunzip | grep CONFIG_W1_SLAVE_DS2433
> >     CONFIG_W1_SLAVE_DS2433=3Dm
> >     CONFIG_W1_SLAVE_DS2433_CRC=3Dy
> >
> >     # create a 32 bytes block with a crc, i.e.:
> >     00000000  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456=
789:;<=3D>?@|
> >     00000010  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEF=
GHIJKLMN.c|
> >
> >     # fill all 80 blocks
> >     $ dd if=3Dtest.bin of=3D/sys/bus/w1/devices/43-000000478756/eeprom =
bs=3D32 count=3D80
> >
> >     # read back all blocks, i.e.:
> >     $ hexdump -C /sys/bus/w1/devices/43-000000478756/eeprom
> >     00000000  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456=
789:;<=3D>?@|
> >     00000010  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEF=
GHIJKLMN.c|
> >     00000020  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456=
789:;<=3D>?@|
> >     00000030  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEF=
GHIJKLMN.c|
> >     ...
> >     000009e0  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456=
789:;<=3D>?@|
> >     000009f0  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEF=
GHIJKLMN.c|
> >     00000a00
> >
> > Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
> > ---
> >  drivers/w1/slaves/w1_ds2433.c | 84 +++++++++++++++++++++++++++++++----
> >  1 file changed, 75 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds243=
3.c
> > index 04c3eee9e5d7..69bdf3dba573 100644
> > --- a/drivers/w1/slaves/w1_ds2433.c
> > +++ b/drivers/w1/slaves/w1_ds2433.c
> > @@ -1,8 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> > - *   w1_ds2433.c - w1 family 23 (DS2433) driver
> > + *   w1_ds2433.c - w1 family 23 (DS2433) & 43 (DS28EC20) eeprom driver
> >   *
> >   * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
> > + * Copyright (c) 2023 Marc Ferland <marc.ferland@sonatest.com>
> >   */
> >
> >  #include <linux/kernel.h>
> > @@ -23,6 +24,7 @@
> >  #include <linux/w1.h>
> >
> >  #define W1_F23_EEPROM_DS2433 0x23
> > +#define W1_F43_EEPROM_DS28EC20       0x43
> >
> >  #define W1_PAGE_SIZE         32
> >  #define W1_PAGE_BITS         5
> > @@ -45,10 +47,16 @@ static const struct ds2433_config config_f23 =3D {
> >       .tprog =3D 5,
> >  };
> >
> > +static const struct ds2433_config config_f43 =3D {
> > +     .eeprom_size =3D 2560,
> > +     .page_count =3D 80,
> > +     .tprog =3D 10,
> > +};
> > +
> >  struct w1_data {
> >  #ifdef CONFIG_W1_SLAVE_DS2433_CRC
> > -     u8      *memory;
> > -     u32     validcrc;
> > +     u8              *memory;
> > +     unsigned long   *validcrc;
>
> Why do you change it? This is actually candidate for its own patch with
> its own justification (not "groundwork" but a reason why such code is
> better).

Noted. Thanks for the review. I'll include the fixes in a v2.

Regards,
Marc
