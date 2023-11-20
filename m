Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB47F1906
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjKTQqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjKTQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:46:20 -0500
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5415B10D8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:45:32 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SYtff0MFrzMq6hk;
        Mon, 20 Nov 2023 16:45:30 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SYtfd44ZgzMpnPh;
        Mon, 20 Nov 2023 17:45:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.io;
        s=20200409; t=1700498729;
        bh=7FT4vey4M0IFQTQ3VKqZdUegCZYs+l920IgntzrCIDw=;
        h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
        b=cSi02sYz4HKFvWUzw/BC1YhAQHM2EP0g18WJC9gnMpY3dJ5NojWBR5KISQMJ0s/Pe
         zVoEznPQiNFsN3x9bCgFN2h4goeFxLw5+rqzqQFLqDetEEtZ7JvdkvkeYgIWqjVhc2
         ojvY8UK2m8FV35mLF7zM7gaV/JotU1GoENf0JQhg=
Message-ID: <314e596f4f7b7e7f8742c47dfeeb7d93@mail.infomaniak.com>
Date:   Mon, 20 Nov 2023 17:45:29 +0100
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From:   linux@bigler.io
Reply-To: linux@bigler.io
To:     Stefan Moring <stefan.moring@technolution.nl>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6ImtDMngxZlYwKzA3QlIvTXM1bGtYQnc9PSIsInZhbHVlIjoiWDhCLzRCZTFHRE4zZmVFbFRZNS9FUT09IiwibWFjIjoiYzZjY2Q1YTY0MGQzNzYxYTM2ODljNmExY2VlNjlhMTg3MWFiYTEyOWRmMzcwMTQ1NjA5YjdmOGVhMzIzZDZkYiIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6ImwrN2RvVlBNdDZzZmdlMUx1STNPenc9PSIsInZhbHVlIjoia21ydXZ3RWpUWElPZlF1RmM1YSs4Zz09IiwibWFjIjoiYWEwYzU3MDk3YzA1MDMyZDhiYjBjMmM2M2UxMTM4OGM5NjAxMzI3ZDkwYjVjMGE1MmQ4ZjdkMzlhMjNiNmUyOSIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.596)
References: <8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com>
 <e4f12422-1c47-4877-88b3-dfa9917331a2@leemhuis.info>
 <f4439fd1-7c2d-4a96-9116-1dbe04fceac0@leemhuis.info>
 <CAB3BuKA+qOY+UhWR-9Ov3qsz3wQr8q8n38MrEMf3FMCthr04yA@mail.gmail.com>
 <2fcdd99eee9ee4f5d34fa1abab2f51bb@mail.infomaniak.com>
 <CAB3BuKARgJhaVNFsP1FQ+2yLe18QU9H17fHKjc-Sf3izE+MZ1Q@mail.gmail.com>
 <86566391db9c5044f1a082bc8ec697a2@mail.infomaniak.com>
 <ZVsdNGyVrTJ/Kv3n@francesco-nb.int.toradex.com>
 <6322fd4c1967a518310140c35ab34f65@mail.infomaniak.com>
 <ZVsyVAapXTWnznFd@francesco-nb.int.toradex.com>
 <CAB3BuKDb6uucujD7ac-w4pa1GVNLSQUA4OGE7i074mQSU==WaA@mail.gmail.com>
In-Reply-To: <CAB3BuKDb6uucujD7ac-w4pa1GVNLSQUA4OGE7i074mQSU==WaA@mail.gmail.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan

I added my printing=20
@@ -655,12 +658,25 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx=
_data *spi_imx,
=20
        /* Clear BL field and set the right value */
        ctrl &=3D ~MX51_ECSPI_CTRL_BL_MASK;
+       dev_info(spi_imx->dev, "%s: count=3D%d, bits_per_word=3D%d\n",
+            __FUNCTION__, spi_imx->count, spi_imx->bits_per_word);
+
        if (spi_imx->target_mode && is_imx53_ecspi(spi_imx))
                ctrl |=3D (spi_imx->target_burst * 8 - 1)
                        << MX51_ECSPI_CTRL_BL_OFFSET;

and run the test with the burst enabled=20
/var/volatile/tmp# spidev_test --device /dev/spidev1.0 --speed 20000000 --b=
pw 8 -i 127bytes-spi-test-data.bin -o 127bytes-spi-test-result.bin
[  802.729824] spi_imx 30830000.spi: mx51_ecspi_prepare_transfer: count=3D1=
27, bits_per_word=3D8
-> transmitted 504 Bytes on the line

then I run it with burst disabled
spidev_test --device /dev/spidev1.0 --speed 20000000 --bpw 8 -i 127bytes-sp=
i-test-data.bin -o 127bytes-spi-test-result.bin
[  316.683807] spi_imx 30830000.spi: mx51_ecspi_prepare_transfer: count=3D0=
, bits_per_word=3D8
-> transmitted 127 Bytes on the line

The count is different=20
- for burst-enabled  127
- for burst-disable 0

concerning the sdma-firmware I checked on=20
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/tree/imx/sdma
but the latest I found was 4.5

Regards
Stefan


Am 2023-11-20T16:30:15.000+01:00 hat Stefan Moring <stefan.moring@technolut=
ion.nl> geschrieben:
>  Hi Stefan,
>=20
> I have been trying to reproduce your error on my iMX8M, scoping the SPI
> lines, but everything works as expected. I don't have the exact same boar=
d,
> but I don't think that should be a problem. One difference I noticed is
> that my imx-sdma firmware is version 4.6.
>=20
> Can you verify the values used for the transfer,  spi_imx->count and
> spi_imx->bits_per_word inside the mx51_ecpsi_prepare_transfer() method?
> Those are the only two things that changed in the commits. Maybe compare
> them to the working version?
>=20
> Kind regards,
>=20
> Stefan Moring
>=20
> Op ma 20 nov 2023 om 11:18 schreef Francesco Dolcini <francesco@dolcini.i=
t>:
>=20
>=20
> >    On Mon, Nov 20, 2023 at 10:33:38AM +0100, linux@bigler.io wrote:
> >=20
> > >     I run the test and it worked fine. The transmitted data matches w=
ith
> > >   the recived data, no diff.
> >   ok, thanks for confirming. At least we are on the same page.
> >=20
> >=20
> > >     BUT!!! on the MDIO it is completly different !!!
> > >   When I request to send 4kB Data I measure on the line 16384Byte.
> > > =20
> > >   The data is again   3Dummy Bytes followed by the databyte.
> > >   So the error symetic on send and recive
> > =20
> >  ok, that's annoying. I wonder if the loopback test could be improved t=
o
> >  spot such kind of issues, maybe we could verify if the execution time
> >  is reasonable given the SPI clock frequency and the payload size ...
> >=20
> >  Francesco
> >=20
>=20
>=20
>
