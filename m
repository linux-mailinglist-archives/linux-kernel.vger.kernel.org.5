Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57667789ABB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 03:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjH0BEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 21:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjH0BDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 21:03:54 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F171A6;
        Sat, 26 Aug 2023 18:03:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a529e1974so1524715b3a.3;
        Sat, 26 Aug 2023 18:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693098232; x=1693703032;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/qLKUalhcdgMAE/M/Hw6b4WKmXW6Syqr6CakMdx2sM=;
        b=OE7amlXr9Jn9SDuBNtaQpTUIEHq36f29Reeefk1QJKdDiNpLt8gC9vvt1c5qU/zeYG
         11Ah8GrK0FsuAnylxEErUw91VaiK2iNE3y3+Xf5aaUhEdYg9jVew8YcnGSsEjP9B7HAN
         ZM3+VVUgdqyTyxg+6zCUWt1VFuxdPQMAdaYOIy3R0gxeOGwjJNJgpkb3Nf0BQsU1U51p
         SmP68iIiF6HLBLty9KOCTYX9pLF7qXLfQisS9W4TXBnffbhbaBd8Oh9HqxAD13C1m+VN
         1FA2rvcWVZXVHjDpnQXoENXao1z7JqyU9p5Bf1eyhcv3RS3EiyBVOKFEMYnmcMXasS98
         XO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693098232; x=1693703032;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/qLKUalhcdgMAE/M/Hw6b4WKmXW6Syqr6CakMdx2sM=;
        b=ZudWTu2L6cQcGJ+9XhOLGNcKhQ4C1fJbV/q/CaSBi9nz6A2Bi1yEpr/GjgndAHAWuA
         yWRrEBH/z1+JpJnMFBYf6NEiz/NvgFrFkFGIl57oKP/DVVeOAY+s9musVbRU86Ry1aWW
         AUYW9D50rJjwINZcSr7L5rkNlbYJ/hIxhopiJ/fKGMs5VF4ufJNxDyjLJyIUZ+TFibr+
         mSUu7vI3sRXjOg3nVeKFz2ZISMAyfipFDqUZEARkW3YPhxmy03mca6b1o6UEHg5YWXRB
         CM+Sv3X5Xn7ZSEAm0SQnKo6zG7Zsd/V5Fr2l2pH3sYDqBoaOkx0KgD/jqA5b9qi2M6wB
         02tA==
X-Gm-Message-State: AOJu0YwFnqxxoOGmKzTqvioFRXYqiTJLmzjeTrC/BHIAvSvClyTimJU5
        VSY2IzZyATNLSoWvgANykfA=
X-Google-Smtp-Source: AGHT+IG6S1JGV2M5+BySXE0JJy+cmc6kzd66vB9IxXCIorqYmJLIUgkUf2Fw6je+92Y42wTQIfFkvA==
X-Received: by 2002:a17:902:e808:b0:1c0:ecbb:1832 with SMTP id u8-20020a170902e80800b001c0ecbb1832mr1429865plg.26.1693098231653;
        Sat, 26 Aug 2023 18:03:51 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id iw20-20020a170903045400b001b8a2edab6asm4365104plb.244.2023.08.26.18.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 18:03:51 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3F8B481CCAD6; Sun, 27 Aug 2023 08:03:49 +0700 (WIB)
Date:   Sun, 27 Aug 2023 08:03:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Joshua Hudson <joshudson@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: Cache coherency bug: stale reads on /dev/sda1
Message-ID: <ZOqg9VovoVanfuR0@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bjVAAIN2A5eZ8tod"
Content-Disposition: inline
In-Reply-To: <CA+jjjYTk=5wn2o46uNB+bJYX8xLgMP==dsJuvC94DvtN2f_6Yw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bjVAAIN2A5eZ8tod
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 02:59:45PM -0700, Joshua Hudson wrote:
> uname -a
> Linux nova 6.4.12 #1 SMP PREEMPT_DYNAMIC Sat Aug 26 09:11:27 PDT 2023
> x86_64 GNU/Linux
>=20
> Kernel source is
> https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/linux-6.4.12.tar.xz
>=20
> Can reliably reproduce as follows:
>=20
> # hexedit /dev/sda1 (this is my EFI partition)
> PgDn
> # hexedit /dev/sda
> G 100000  (your value may vary--we want to seek to the start of the
> EFI partition)
> PgDn
> PgDn
> ^C
> write a marker to the padding between the BPB and the first FAT sector.
> (If your system doesn't have one, edit an error message in the boot secto=
r)
> ^X
> # hexedit /dev/sda1
> PgDn
> Look for marker written above, find it's not there !!!
> ^C
>=20
> I discovered this one trying to defragment my EFI partition after a
> grub upgrade left it very fragmented due to replacing logos.

Are you sure this is hardware issue?

--=20
An old man doll... just what I always wanted! - Clara

--bjVAAIN2A5eZ8tod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOqg9AAKCRD2uYlJVVFO
o+GuAP0fuH1LfzqXEc0cXxDCfobYSdm23I8M4IxXm6sdEFlIDwD/RGivalsKTtjI
wY9DMYZ1BpSscGRwW4c2H2dtmZHKRgY=
=bkK1
-----END PGP SIGNATURE-----

--bjVAAIN2A5eZ8tod--
