Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E457F8FE2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 23:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjKYWuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 17:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjKYWug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 17:50:36 -0500
X-Greylist: delayed 360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Nov 2023 14:50:40 PST
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368E0FE;
        Sat, 25 Nov 2023 14:50:40 -0800 (PST)
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
        by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4Sd6Nk3mMTz5yvD;
        Sat, 25 Nov 2023 23:44:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.one; s=key2;
        t=1700952278; bh=FZNJP3nxNUKEIuONIbATOwCDJtkvy7ja6YZOXoIHlqI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:From;
        b=hKOLvl5w8rs3sYDDko7hym+l9R1XT11TFAf1Vl+hbgrEJkcFQoTVRSHAPDXJ3QOQf
         Hedbm47b+0oESJEnawSEzTA3XCoGlsO/nJ3z0elqlTK+KEAvZOXGai3XXhQIQaK0aP
         SCdQYE2csjVATGJgRnSDhRjCt22jTjgJTp30vN4boNRMxkhXXlHipYVpmPocun58Sd
         wBra2CxGVpxz2hTVFxzGJIu1S7KzXYPxGA6XlcLcfHxGhT+CFiixp4+pU46UlJ+M8/
         f/o+XYcIPzpSGG9Pib6Etq20elfJ4iW/aTFPTZmu6m5Zgh3wOdWzbDZp3EKr++RTXG
         T+Cy2DR2UE5Dw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4Sd6Nk32dxz4w70;
        Sat, 25 Nov 2023 23:44:38 +0100 (CET)
Received: from mx2fc6.netcup.net (unknown [10.243.12.53])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Sd6Nj585yz8scr;
        Sat, 25 Nov 2023 23:44:37 +0100 (CET)
Received: from [192.168.1.24] (xdsl-188-155-37-14.adslplus.ch [188.155.37.14])
        by mx2fc6.netcup.net (Postfix) with ESMTPSA id C3FDA45338;
        Sat, 25 Nov 2023 23:44:32 +0100 (CET)
Authentication-Results: mx2fc6;
        spf=pass (sender IP is 188.155.37.14) smtp.mailfrom=benjamin@bigler.one smtp.helo=[192.168.1.24]
Received-SPF: pass (mx2fc6: connection is authenticated)
Message-ID: <d795999676663a576f12f07a7013bee758fb781c.camel@bigler.one>
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From:   Benjamin Bigler <benjamin@bigler.one>
To:     francesco@dolcini.it
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux@bigler.io,
        regressions@lists.linux.dev, stefan.moring@technolution.nl
Date:   Sat, 25 Nov 2023 23:44:32 +0100
In-Reply-To: <ZVsyVAapXTWnznFd@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0
MIME-Version: 1.0
X-PPP-Message-ID: <170095227324.806.8324255313749551391@mx2fc6.netcup.net>
X-Rspamd-Queue-Id: C3FDA45338
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: 2ksQ9lJvOoisjgPJEMFMloG8LvydxyFtO4QBLzOvLWrCGO0=
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm uncertain whether this is the appropriate place to respond, but I
am encountering a similar issue on a phyboard-polis-rdk (imx8mm) with
Linux 6.7-rc2. My system uses the imx-sdma firmware version 4.6.

The problem is with the TPM, which fails to function correctly,
displaying the error message:
"tpm tpm0: TPM in field failure mode, requires firmware upgrade."

The issue is identical to the one reported by Stefan. It can be
resolved by reverting commits 15a6af94a2779d5dfb42ee4bfac858ea8e964a3f
and 5f66db08cbd3ca471c66bacb0282902c79db9274, after which the TPM works
again.

Additionally, I've conducted the tests which Francesco mentioned:

> ```
> cd /tmp
>=20
> dd if=3D/dev/urandom of=3D4k-spi-test-data.bin bs=3D1 count=3D4k
> spidev_test -D "$device" -s 4000000 -i 4k-spi-test-data.bin -o 4k-
spi-test-result.bin
>=20
> dd if=3D/dev/urandom of=3D16bytes-spi-test-data.bin bs=3D1 count=3D16
> spidev_test -D "$device" -s 16000 -i 16bytes-spi-test-data.bin -o
16bytes-spi-test-result.bin
> ```

The readback data is correct but on MOSI/MISO there are 16384 bytes.

Please let me know if I can do some more tests.

Best regards,

Benjamin Bigler
