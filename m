Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA357F6CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjKXHMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjKXHML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:12:11 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54369D6F;
        Thu, 23 Nov 2023 23:12:13 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cf98ffc257so7833835ad.3;
        Thu, 23 Nov 2023 23:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700809933; x=1701414733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSs2TLIiQnVXysh13y2McMK8OCeKJ03dTwOH/qdr7qs=;
        b=fr5mlL22BSgfPGSE14O8WWfIiiOoPEvIpCxmsGctonU03voBmiVs9glz2gCcfkYp+X
         TL7gC1no4ZxOBr5wMjVH2AfTyJSJooyshMF2Q4xvKY4hy9InUNDwa8I6vfRpUppHU4T3
         0IBIdOHzJ2pIJWHsOPS5NlYg6nTP7ExZXCvfdiK2DsyDRPP+6131+MivPGI7WSuv5F59
         NEhi1oZ6+2gov2HVMrnDDjbkE22hnXmOqBLz+4zZAcmD+uxJgGu6IU2/uq54ZEVbomfy
         Y93nJt28orpLctCVGnKTtq+fmxwCADG9MuK5OxG1KCERQPoqMbeeTba0hsYfqIEdbg/k
         6e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700809933; x=1701414733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSs2TLIiQnVXysh13y2McMK8OCeKJ03dTwOH/qdr7qs=;
        b=A/qjjuOiTVA87p0RCsuWFERgXDCRekLSUdgcAJTMwZ0yBuuoTTStip/lFEQq6PPs+r
         j86VOsT8p+nllTuqkWNGRznHtEcajLs+M1j5S2x7dIzfoS6Taw+ZdtVDFfATCndCbqvo
         y+NsU2WCqiLiHo8IFYCEqQjqB31e0Lw69/fixUN7HDWpwaU6yGEpycuNugM57yH2uc1V
         76IKLMasGGmbSYSchJapFQBdO2dl84Gy+Tfr/VIUOxqo7DsNVvVhErB/M+769pvnrUSS
         5vssYTQS6Q83csfOngktVE46sYAVmqZDqfkkqxLT9vHJA7PsZLPi+8LNxnNPm8TECa34
         kf/g==
X-Gm-Message-State: AOJu0Yxsr+R7fEohRJREbLm0w8q185lvNIUvNtg1A/ACHtSjaEH7+Eth
        /3+e+5HYo+/LsgX1uMdU+TA=
X-Google-Smtp-Source: AGHT+IHdYLJK3SurdNxYDAK1HN7CBs2YafccJeaFtb4KIRTyMAzuiKgsL0P1vRTQB2PkGaFg7wgtHw==
X-Received: by 2002:a17:903:2352:b0:1cf:6ce6:5f22 with SMTP id c18-20020a170903235200b001cf6ce65f22mr2217152plh.60.1700809932665;
        Thu, 23 Nov 2023 23:12:12 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902eed500b001bc21222e34sm2463733plb.285.2023.11.23.23.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 23:12:11 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id E99681021057D; Fri, 24 Nov 2023 14:12:08 +0700 (WIB)
Date:   Fri, 24 Nov 2023 14:12:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>, pratyush@kernel.org,
        michael@walle.cc
Cc:     Linux MTD <linux-mtd@lists.infradead.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] docs: mtd: spi-nor: add sections about flash
 additions and testing
Message-ID: <ZWBMyPIPwq9L-5pG@archie.me>
References: <20231123160721.64561-1-tudor.ambarus@linaro.org>
 <20231123160721.64561-2-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ywD7BkN9lcIBxOS"
Content-Disposition: inline
In-Reply-To: <20231123160721.64561-2-tudor.ambarus@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ywD7BkN9lcIBxOS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 06:07:20PM +0200, Tudor Ambarus wrote:
> +Minimum testing requirements
> +-----------------------------
> +
> +Do all the tests from below and paste them in the commit's comments
> +section, after the ``---`` marker.
> +
> +1/ Specify the controller that you used to test the flash and specify
> +the frequency at which the flash was operated::
> +
> +    E.g. This flash is populated on the X board and was tested at Y
> +    frequency using the Z (put compatible) SPI controller.
> +
> +2/ Dump the sysfs entries and print the md5/sha1/sha256 SFDP checksum::
> +
> +    root@1:~#  cat /sys/bus/spi/devices/spi1.0/spi-nor/partname
> +    sst26vf064b
> +    root@1:~#  cat /sys/bus/spi/devices/spi1.0/spi-nor/jedec_id
> +    bf2643
> +    root@1:~#  cat /sys/bus/spi/devices/spi1.0/spi-nor/manufacturer
> +    sst
> +    root@1:~# hexdump -C  /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
> +    00000000  53 46 44 50 06 01 02 ff  00 06 01 10 30 00 00 ff  |SFDP...=
=2E....0...|
> +    00000010  81 00 01 06 00 01 00 ff  bf 00 01 18 00 02 00 01  |.......=
=2E........|
> +    00000020  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |.......=
=2E........|
> +    00000030  fd 20 f1 ff ff ff ff 03  44 eb 08 6b 08 3b 80 bb  |. .....=
=2ED..k.;..|
> +    00000040  fe ff ff ff ff ff 00 ff  ff ff 44 0b 0c 20 0d d8  |.......=
=2E..D.. ..|
> +    00000050  0f d8 10 d8 20 91 48 24  80 6f 1d 81 ed 0f 77 38  |.... .H=
$.o....w8|
> +    00000060  30 b0 30 b0 f7 ff ff ff  29 c2 5c ff f0 30 c0 80  |0.0....=
=2E).\..0..|
> +    00000070  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |.......=
=2E........|
> +    *
> +    00000100  ff 00 04 ff f3 7f 00 00  f5 7f 00 00 f9 ff 7d 00  |.......=
=2E......}.|
> +    00000110  f5 7f 00 00 f3 7f 00 00  ff ff ff ff ff ff ff ff  |.......=
=2E........|
> +    00000120  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |.......=
=2E........|
> +    *
> +    00000200  bf 26 43 ff b9 5f fd ff  30 f2 60 f3 32 ff 0a 12  |.&C.._.=
=2E0.`.2...|
> +    00000210  23 46 ff 0f 19 32 0f 19  19 ff ff ff ff ff ff ff  |#F...2.=
=2E........|
> +    00000220  00 66 99 38 ff 05 01 35  06 04 02 32 b0 30 72 42  |.f.8...=
5...2.0rB|
> +    00000230  8d e8 98 88 a5 85 c0 9f  af 5a ff ff 06 ec 06 0c  |.......=
=2E.Z......|
> +    00000240  00 03 08 0b ff ff ff ff  ff 07 ff ff 02 02 ff 06  |.......=
=2E........|
> +    00000250  03 00 fd fd 04 07 00 fc  03 00 fe fe 02 02 07 0e  |.......=
=2E........|
> +    00000260
> +    root@1:~# sha256sum /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
> +    428f34d0461876f189ac97f93e68a05fa6428c6650b3b7baf736a921e5898ed1  /s=
ys/bus/spi/devices/spi1.0/spi-nor/sfdp
> +
> +3/ Dump debugfs data::
> +
> +    root@1:~# cat /sys/kernel/debug/spi-nor/spi1.0/capabilities
> +    Supported read modes by the flash
> +     1S-1S-1S
> +      opcode		0x03
> +      mode cycles	0
> +      dummy cycles	0
> +     1S-1S-1S (fast read)
> +      opcode		0x0b
> +      mode cycles	0
> +      dummy cycles	8
> +     1S-1S-2S
> +      opcode		0x3b
> +      mode cycles	0
> +      dummy cycles	8
> +     1S-2S-2S
> +      opcode		0xbb
> +      mode cycles	4
> +      dummy cycles	0
> +     1S-1S-4S
> +      opcode		0x6b
> +      mode cycles	0
> +      dummy cycles	8
> +     1S-4S-4S
> +      opcode		0xeb
> +      mode cycles	2
> +      dummy cycles	4
> +     4S-4S-4S
> +      opcode		0x0b
> +      mode cycles	2
> +      dummy cycles	4
> +   =20
> +    Supported page program modes by the flash
> +     1S-1S-1S
> +      opcode	0x02
> +   =20
> +    root@1:~# cat /sys/kernel/debug/spi-nor/spi1.0/params
> +    name		sst26vf064b
> +    id			bf 26 43 bf 26 43
> +    size		8.00 MiB
> +    write size		1
> +    page size		256
> +    address nbytes	3
> +    flags		HAS_LOCK | HAS_16BIT_SR | SOFT_RESET | SWP_IS_VOLATILE
> +   =20
> +    opcodes
> +     read		0xeb
> +      dummy cycles	6
> +     erase		0x20
> +     program		0x02
> +     8D extension	none
> +   =20
> +    protocols
> +     read		1S-4S-4S
> +     write		1S-1S-1S
> +     register		1S-1S-1S
> +   =20
> +    erase commands
> +     20 (4.00 KiB) [0]
> +     d8 (8.00 KiB) [1]
> +     d8 (32.0 KiB) [2]
> +     d8 (64.0 KiB) [3]
> +     c7 (8.00 MiB)
> +   =20
> +    sector map
> +     region (in hex)   | erase mask | flags
> +     ------------------+------------+----------
> +     00000000-00007fff |     [01  ] |
> +     00008000-0000ffff |     [0 2 ] |
> +     00010000-007effff |     [0  3] |
> +     007f0000-007f7fff |     [0 2 ] |
> +     007f8000-007fffff |     [01  ] |
> +
> +4/ Use `mtd-utils <https://git.infradead.org/mtd-utils.git>`__
> +and verify that erase, read and page program operations work fine.
> +
> +a/ Generate a 2 MB file::
> +
> +    root@1:~# dd if=3D/dev/urandom of=3D./spi_test bs=3D1M count=3D2
> +    2+0 records in
> +    2+0 records out
> +    2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.848566 s, 2.5 MB/s
> +
> +b/ Verify erase::
> +
> +    root@1:~# mtd_debug write /dev/mtd1 0 2097152 spi_test
> +    Copied 2097152 bytes from spi_test to address 0x00000000 in flash
> +
> +    root@1:~# mtd_debug erase /dev/mtd1 0 2097152
> +    Erased 2097152 bytes from address 0x00000000 in flash
> +
> +    root@1:~# mtd_debug read /dev/mtd1 0 2097152 spi_read
> +    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
> +
> +    root@1:~# hexdump -C spi_read
> +    00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |.......=
=2E........|
> +    *
> +    00200000
> +
> +c/ Write, read back and compare::
> +
> +    root@1:~# mtd_debug write /dev/mtd1 0 2097152 spi_test
> +    Copied 2097152 bytes from spi_test to address 0x00000000 in flash
> +
> +    root@1:~# mtd_debug read /dev/mtd1 0 2097152 spi_read
> +    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
> +
> +    root@1:~# sha1sum spi_*
> +    51eeddc316a4121cf96e76e526d94d638283ec22  spi_read
> +    51eeddc316a4121cf96e76e526d94d638283ec22  spi_test
> +
> +d/ Dump mtd_info data::
> +
> +    root@1:~# mtd_debug info /dev/mtd1
> +    mtd.type =3D MTD_NORFLASH
> +    mtd.flags =3D MTD_CAP_NORFLASH
> +    mtd.size =3D 8388608 (8M)
> +    mtd.erasesize =3D 4096 (4K)
> +    mtd.writesize =3D 1
> +    mtd.oobsize =3D 0
> +    regions =3D 0

The numbered lists don't properly rendered, so I have to fix it up:

---- >8 ----
diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/drive=
r-api/mtd/spi-nor.rst
index 7a8737fe181de5..d482658628b3c0 100644
--- a/Documentation/driver-api/mtd/spi-nor.rst
+++ b/Documentation/driver-api/mtd/spi-nor.rst
@@ -30,13 +30,13 @@ Minimum testing requirements
 Do all the tests from below and paste them in the commit's comments
 section, after the ``---`` marker.
=20
-1/ Specify the controller that you used to test the flash and specify
-the frequency at which the flash was operated::
+1) Specify the controller that you used to test the flash and specify
+   the frequency at which the flash was operated, e.g.::
=20
-    E.g. This flash is populated on the X board and was tested at Y
+    This flash is populated on the X board and was tested at Y
     frequency using the Z (put compatible) SPI controller.
=20
-2/ Dump the sysfs entries and print the md5/sha1/sha256 SFDP checksum::
+2) Dump the sysfs entries and print the md5/sha1/sha256 SFDP checksum::
=20
     root@1:~#  cat /sys/bus/spi/devices/spi1.0/spi-nor/partname
     sst26vf064b
@@ -68,7 +68,7 @@ the frequency at which the flash was operated::
     root@1:~# sha256sum /sys/bus/spi/devices/spi1.0/spi-nor/sfdp
     428f34d0461876f189ac97f93e68a05fa6428c6650b3b7baf736a921e5898ed1  /sys=
/bus/spi/devices/spi1.0/spi-nor/sfdp
=20
-3/ Dump debugfs data::
+3) Dump debugfs data::
=20
     root@1:~# cat /sys/kernel/debug/spi-nor/spi1.0/capabilities
     Supported read modes by the flash
@@ -142,51 +142,51 @@ the frequency at which the flash was operated::
      007f0000-007f7fff |     [0 2 ] |
      007f8000-007fffff |     [01  ] |
=20
-4/ Use `mtd-utils <https://git.infradead.org/mtd-utils.git>`__
-and verify that erase, read and page program operations work fine.
+4) Use `mtd-utils <https://git.infradead.org/mtd-utils.git>`__
+and verify that erase, read and page program operations work fine:
=20
-a/ Generate a 2 MB file::
+   a) Generate a 2 MB file::
=20
-    root@1:~# dd if=3D/dev/urandom of=3D./spi_test bs=3D1M count=3D2
-    2+0 records in
-    2+0 records out
-    2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.848566 s, 2.5 MB/s
+       root@1:~# dd if=3D/dev/urandom of=3D./spi_test bs=3D1M count=3D2
+       2+0 records in
+       2+0 records out
+       2097152 bytes (2.1 MB, 2.0 MiB) copied, 0.848566 s, 2.5 MB/s
=20
-b/ Verify erase::
+   b) Verify erase::
=20
-    root@1:~# mtd_debug write /dev/mtd1 0 2097152 spi_test
-    Copied 2097152 bytes from spi_test to address 0x00000000 in flash
+       root@1:~# mtd_debug write /dev/mtd1 0 2097152 spi_test
+       Copied 2097152 bytes from spi_test to address 0x00000000 in flash
=20
-    root@1:~# mtd_debug erase /dev/mtd1 0 2097152
-    Erased 2097152 bytes from address 0x00000000 in flash
+       root@1:~# mtd_debug erase /dev/mtd1 0 2097152
+       Erased 2097152 bytes from address 0x00000000 in flash
=20
-    root@1:~# mtd_debug read /dev/mtd1 0 2097152 spi_read
-    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
+       root@1:~# mtd_debug read /dev/mtd1 0 2097152 spi_read
+       Copied 2097152 bytes from address 0x00000000 in flash to spi_read
=20
-    root@1:~# hexdump -C spi_read
-    00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |.........=
=2E......|
-    *
-    00200000
+       root@1:~# hexdump -C spi_read
+       00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |......=
=2E.........|
+       *
+       00200000
=20
-c/ Write, read back and compare::
+   c) Write, read back and compare::
=20
-    root@1:~# mtd_debug write /dev/mtd1 0 2097152 spi_test
-    Copied 2097152 bytes from spi_test to address 0x00000000 in flash
+       root@1:~# mtd_debug write /dev/mtd1 0 2097152 spi_test
+       Copied 2097152 bytes from spi_test to address 0x00000000 in flash
=20
-    root@1:~# mtd_debug read /dev/mtd1 0 2097152 spi_read
-    Copied 2097152 bytes from address 0x00000000 in flash to spi_read
+       root@1:~# mtd_debug read /dev/mtd1 0 2097152 spi_read
+       Copied 2097152 bytes from address 0x00000000 in flash to spi_read
=20
-    root@1:~# sha1sum spi_*
-    51eeddc316a4121cf96e76e526d94d638283ec22  spi_read
-    51eeddc316a4121cf96e76e526d94d638283ec22  spi_test
+       root@1:~# sha1sum spi_*
+       51eeddc316a4121cf96e76e526d94d638283ec22  spi_read
+       51eeddc316a4121cf96e76e526d94d638283ec22  spi_test
=20
-d/ Dump mtd_info data::
+   d) Dump mtd_info data::
=20
-    root@1:~# mtd_debug info /dev/mtd1
-    mtd.type =3D MTD_NORFLASH
-    mtd.flags =3D MTD_CAP_NORFLASH
-    mtd.size =3D 8388608 (8M)
-    mtd.erasesize =3D 4096 (4K)
-    mtd.writesize =3D 1
-    mtd.oobsize =3D 0
-    regions =3D 0
+       root@1:~# mtd_debug info /dev/mtd1
+       mtd.type =3D MTD_NORFLASH
+       mtd.flags =3D MTD_CAP_NORFLASH
+       mtd.size =3D 8388608 (8M)
+       mtd.erasesize =3D 4096 (4K)
+       mtd.writesize =3D 1
+       mtd.oobsize =3D 0
+       regions =3D 0

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--4ywD7BkN9lcIBxOS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWBMxAAKCRD2uYlJVVFO
o2weAQD4knx9+5Yu3XTUNp7EP2+ydqS/Z0H52A5Ip/HPpCAELQEAh2pp7LI+92pC
eMRIwkx5L9y0m+OagyPzTEApkzdVPQ0=
=yn1L
-----END PGP SIGNATURE-----

--4ywD7BkN9lcIBxOS--
