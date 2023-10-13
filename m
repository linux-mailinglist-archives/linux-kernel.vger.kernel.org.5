Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9237C87E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjJMOdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJMOdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:33:43 -0400
X-Greylist: delayed 1331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Oct 2023 07:33:39 PDT
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75AABD;
        Fri, 13 Oct 2023 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:
        Content-Transfer-Encoding:To:From:Cc:Subject:Message-Id:Date:Content-Type:
        Sender:Reply-To:MIME-Version:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=TxwwokEAbgE2tWmv/Wot1RPxsCzOem/ELZjKvvjAb+M=; b=TY0kQ4rYjnJByIpl42J3+RKmun
        F+N+FRYTXPViiQDUgf3Sw+XssHSi1xvG7DzyPVg24tCIgxIoTBWg2Dy6/X657L5BFsLgp2g67H4/t
        34dJbD1ViiCT+8j62dj/nzVi+QuXrWGANBDQ0Xkr23NORANlk/edKrUf/6n/jIKA8z61KAqvkwmYT
        KAi3gS5dJAp3J9Z+sVR3dgutoNvFI3XGTA/YBQEn2k/CeD27ajKDvpTGG2TjWvO9GNBeUZcMvJ/93
        IS2t0WgXks0Q6J4Ye3oJ3TT0rhI8/Ry7EHJwUCEZjGqMchg+3oPIrrSTQUYv8AggXpkUBtJefvNVP
        5iOT6+KA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dev@folker-schwesinger.de>)
        id 1qrIsv-000HXg-MS; Fri, 13 Oct 2023 16:11:25 +0200
Received: from [80.88.27.155] (helo=localhost)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <dev@folker-schwesinger.de>)
        id 1qrIsk-000T92-MZ; Fri, 13 Oct 2023 16:11:24 +0200
Content-Type: multipart/signed;
 boundary=0377e7501be3d79d6faabf808a2de3b62744369f17e3be7eb4f7324fb286;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date:   Fri, 13 Oct 2023 14:11:13 +0000
Message-Id: <CW7DEUEAKEXO.KE3YKH135Y3C@folker-schwesinger.de>
Subject: Re: [PATCH v1 0/2] Fix i2s0 pin conflict on ROCK Pi 4 RK3399 boards
Cc:     <kernel@collabora.com>,
        "Arnaud Ferraris" <arnaud.ferraris@collabora.com>,
        "Brian Norris" <briannorris@chromium.org>,
        "Caleb Connolly" <kc@postmarketos.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Corentin Labbe" <clabbe@baylibre.com>,
        "FUKAUMI Naoki" <naoki@radxa.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        "Jagan Teki" <jagan@amarulasolutions.com>,
        "Johan Jonker" <jbx6244@gmail.com>,
        "Judy Hsiao" <judyhsiao@chromium.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Rick Wertenbroek" <rick.wertenbroek@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Yogesh Hegde" <yogi.kernel@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   "Folker Schwesinger" <dev@folker-schwesinger.de>
To:     "Christopher Obbard" <chris.obbard@collabora.com>,
        <linux-rockchip@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.16.0-6-gd179485eefe5
References: <20231013114737.494410-1-chris.obbard@collabora.com>
In-Reply-To: <20231013114737.494410-1-chris.obbard@collabora.com>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27060/Fri Oct 13 09:41:49 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0377e7501be3d79d6faabf808a2de3b62744369f17e3be7eb4f7324fb286
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8


On Fri Oct 13, 2023 at 1:47 PM CEST, Christopher Obbard wrote:
> i2s0 fails to probe on my Radxa ROCK 4SE and ROCK Pi 4B boards with:
>
>     rockchip-pinctrl pinctrl: pin gpio3-29 already requested by leds; can=
not claim for ff880000.i2s
>     rockchip-pinctrl pinctrl: pin-125 (ff880000.i2s) status -22
>     rockchip-pinctrl pinctrl: could not request pin 125 (gpio3-29) from g=
roup i2s0-8ch-bus-bclk-off  on device rockchip-pinctrl
>     rockchip-i2s ff880000.i2s: Error applying setting, reverse things bac=
k
>     rockchip-i2s ff880000.i2s: bclk disable failed -22
>
> This is due to the pinctl attempting to request a GPIO which the boards
> use for a different function.
>
> The first patch adds a missing pinctl node i2s0_2ch_bus_bclk_off to the
> RK3399 devicetree.
>
> The second patch sets the i2s0 pinctrl to use the new node when idle and
> fixes the issue.
>
>
> Christopher Obbard (2):
>   arm64: dts: rockchip: Add i2s0-2ch-bus-bclk-off pins to RK3399
>   arm64: dts: rockchip: Fix i2s0 pin conflict on ROCK Pi 4 boards
>
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |  1 +
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 10 ++++++++++
>  2 files changed, 11 insertions(+)

Thanks, works as advertised on my Rock 4SE!

So for the entire series:

Tested-By: Folker Schwesinger <dev@folker-schwesinger.de>

Kind regards,
Folker

--0377e7501be3d79d6faabf808a2de3b62744369f17e3be7eb4f7324fb286
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJAEABYIADgWIQQFbmi0A2l3pTuK+esCQHEyPYq7fQUCZSlQAhocZGV2QGZvbGtl
ci1zY2h3ZXNpbmdlci5kZQAKCRACQHEyPYq7fcaaAPsFBvjaD6faGXW/mZLedAE8
Oio8383iwlnrrWOmoshgcAEAxShIZ4xIjPkCTtOnd8Z/OI4flfytkRBns2asy9ei
9AE=
=n0fE
-----END PGP SIGNATURE-----

--0377e7501be3d79d6faabf808a2de3b62744369f17e3be7eb4f7324fb286--
