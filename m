Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F1F76CA89
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjHBKLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjHBKK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:10:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418C9211B;
        Wed,  2 Aug 2023 03:10:55 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690971052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3flfNg7D3xDoacIyuCI9Tv6Ia0JzLVFeGS0pO9j6hc=;
        b=lCcwn+4dDNiakaikCPd2NRCJcwoRItNDzrmThzLoywqqDYp7HfD1V9RNpnqmN11+0wX23O
        do0T01D47qno0jZQbT2Aynk7OqfhvuqBKeW0KMajE8HH25docPlL9J++RyfSfxwjoVW9K0
        EAfwd5jFfATDzdIiVx3u9Lm9zeQJbK+ZToxlVi3qUMUduOCeYOhno3JRa1xlh8iwFtMNpV
        srZP6R/k+Z79S7rqpq1tPbEJymDc7WXJgWJz1t3V/TpxgF29bsp7QyfgqMH5zY8ZwHZYL5
        cz2A724eTdfIHGmV3FiA7mLpnP3w+BsiViM31XMknAplqhHwpg2hlrsSl4mV/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690971052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O3flfNg7D3xDoacIyuCI9Tv6Ia0JzLVFeGS0pO9j6hc=;
        b=AA0b0nIT91SHfhSeCVwZv1JCnRBTwk9kar1m+JPxGBdwU5gHLHVW0umEXE6SihZK0R4R2X
        YM5YnK1Esun1x2CA==
To:     Johannes Zink <j.zink@pengutronix.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>,
        Johannes Zink <j.zink@pengutronix.de>
Subject: Re: [PATCH v3 0/2] net: stmmac: correct MAC propagation delay
In-Reply-To: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
References: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
Date:   Wed, 02 Aug 2023 12:10:51 +0200
Message-ID: <87fs51kb4k.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue Aug 01 2023, Johannes Zink wrote:
> ---
> Changes in v3:
> - work in Richard's review feedback. Thank you for reviewing my patch:
>   - as some of the hardware may have no or invalid correction value
>     registers: introduce feature switch which can be enabled in the glue
>     code drivers depending on the actual hardware support
>   - only enable the feature on the i.MX8MP for the time being, as the patch
>     improves timing accuracy and is tested for this hardware
> - Link to v2: https://lore.kernel.org/r/20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de
>
> Changes in v2:
> - fix builds for 32bit, this was found by the kernel build bot
> 	Reported-by: kernel test robot <lkp@intel.com>
> 	Closes: https://lore.kernel.org/oe-kbuild-all/202307200225.B8rmKQPN-lkp@intel.com/
> - while at it also fix an overflow by shifting a u32 constant from macro by 10bits
>   by casting the constant to u64
> - Link to v1: https://lore.kernel.org/r/20230719-stmmac_correct_mac_delay-v1-1-768aa4d09334@pengutronix.de
>
> ---
> Johannes Zink (2):
>       net: stmmac: correct MAC propagation delay
>       net: stmmac: dwmac-imx: enable MAC propagation delay correction for i.MX8MP

Tested on imx8mp <-> TSN Switch <-> x86 with i225:

Before your patch:

|ptp4l -i eth0 -f configs/gPTP.cfg --summary_interval=5 -m
|ptp4l[139.274]: rms    9 max   27 freq +29264 +/-  13 delay   347 +/-   2
|ptp4l[171.279]: rms   10 max   24 freq +29257 +/-  13 delay   344 +/-   2
|ptp4l[203.283]: rms   10 max   24 freq +29254 +/-  13 delay   347 +/-   2
|ptp4l[235.288]: rms    9 max   24 freq +29255 +/-  13 delay   346 +/-   1
|ptp4l[267.292]: rms    9 max   28 freq +29257 +/-  13 delay   347 +/-   2

After:

|ptp4l -i eth0 -f configs/gPTP.cfg --summary_interval=5 -m
|ptp4l[214.186]: rms    9 max   29 freq +28868 +/-  16 delay   326 +/-   2
|ptp4l[246.190]: rms    8 max   22 freq +28902 +/-  15 delay   329 +/-   2
|ptp4l[278.194]: rms    9 max   24 freq +28930 +/-  15 delay   325 +/-   1
|ptp4l[310.199]: rms    9 max   25 freq +28956 +/-  15 delay   327 +/-   3
|ptp4l[342.203]: rms    9 max   27 freq +28977 +/-  14 delay   327 +/-   1

And the derived register values:

|[   15.864016] KURT: PTP_TS_INGR_CORR_NS: 3147483248 PTP_TS_INGR_CORR_SNS: 0
|[   15.870862] KURT: PTP_TS_EGR_CORR_NS: 400 PTP_TS_EGR_CORR_SNS: 0
|[   20.000962] KURT: PTP_TS_INGR_CORR_NS: 3147483636 PTP_TS_INGR_CORR_SNS: 0
|[   20.007809] KURT: PTP_TS_EGR_CORR_NS: 12 PTP_TS_EGR_CORR_SNS: 0

So, seems to work:

Tested-by: Kurt Kanzenbach <kurt@linutronix.de> # imx8mp

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmTKK6sTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgpH7D/9gvmG6+n49HSx1HFttoXKOeJBVJJO2
BD3+idE7X5Uq6p5FErWUWpOgLRSYMrNTXYO3V/Z+MAaFoxiPm/mjnW0d5Angr2Hu
8OW/krHNG8eupFVzJ7zVmdtY9Ct1bkcUCdOb6YEP53YMqbgnFogzrXL1Ym9PDuKL
DcZjC4fLYZbpS+sqqEt7nPfHk6fWaSpGzLb7XsMFfH+xBQN4sA3XblSY9dmmiL98
gNvCPkbpk6pRKwDpM46xefREyBOiocRbgtxbubuSI2t2858EbONQmam394axk52J
qc/zf4LxGfAia8gtqtSqEMK+l4Xd3kkb1bKX1fFoZc2TLZExQDDUNC6UjAZwAl0n
TMWi4g+qDKDFAcyszh3EQtRFx0LPj/HLmX9u9WTCt7DOP9MgKlNwMNuppTO6GT//
yAw+0QYNyEebvge0z/ZkVn+zNZXCMSLyskkaa/CC4p9pjfp/IuUJyUhfnDIL+Svn
2WoB2IU7AqKPDAeVJI/rx8LNftu8KgAL1Z7SKOYpW42nWPv7wH17W3hgil56YTk6
mzAyIHWu90aFePMXrLrbPHoAdGJiHxLHIiwjkzzowInj7Pk/QiplYYtUaCJAZioh
NMWO3PBMVdGInW6ys9pZsDSf8MI3diR2aU7g02k7A666pCrx1ugCaYnx9cks59cv
18dkcDquyqvDMA==
=4fSs
-----END PGP SIGNATURE-----
--=-=-=--
