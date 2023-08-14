Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3A077B1ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjHNG7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjHNG6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:58:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CCDE6A;
        Sun, 13 Aug 2023 23:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691996320; x=1723532320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZwuSZdj9UqWjAmgGZ6tAfbCaUt/hHjJWCDx6nN0pxoY=;
  b=iPgNcXpIiBAAMEIFaM8oVel+vfLpzL1CKMvEQL1F2RJIrvMJx1CQ6VMG
   FJrotH5fgbUqQQxr15TLDCJKA0DqLZrDV5yghPAsx69iYpEt51YNqwqul
   QaGUtEy3BD1z/N6tBrJdUdQKW0Bw2T4FkZ5lUh1iwvvLdmatgq5F36khs
   B1I3M9yUamsDtpoYvcddeO/o3+f/7UdFLmmjHOjJLnqNX79atrmJ3kGM3
   3YpQ6YbGwNdfxvzvznWIapZDALno4F8UictyIQOAcXoZTcqf9M86hDmJP
   p5uu2Gpb9Y1d9fuDWsVEA1+mUW4+xcmUPH1aY8O9clAbwNcFpC8XFcV/9
   A==;
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="asc'?scan'208";a="225265556"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Aug 2023 23:58:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 13 Aug 2023 23:58:31 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Sun, 13 Aug 2023 23:58:30 -0700
Date:   Mon, 14 Aug 2023 07:57:51 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v1] clk: starfive: jh7110-sys: Set PLL0 rate to 1.5GHz
Message-ID: <20230814-relieving-brisket-9a8c38e817a4@wendy>
References: <20230811033631.160912-1-xingyu.wu@starfivetech.com>
 <20230811-jiffy-nebula-a8ea5ef15eee@wendy>
 <cace0094-948b-a4e9-ab63-6fdfb9952b44@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RojBI9Zo7R/mgEe2"
Content-Disposition: inline
In-Reply-To: <cace0094-948b-a4e9-ab63-6fdfb9952b44@starfivetech.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--RojBI9Zo7R/mgEe2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 11:06:05AM +0800, Xingyu Wu wrote:
> On 2023/8/11 14:43, Conor Dooley wrote:
> > On Fri, Aug 11, 2023 at 11:36:31AM +0800, Xingyu Wu wrote:
> >> Set PLL0 rate to 1.5GHz.
> >=20
> > Why are you doing that though?
>=20
> Because the CPU frequency scaling is based on 1.5GHz rate on JH7110 SoC.
> And now the PLL clock driver has been accepted and PLL0 is just 1GHz[1].
> [1] https://github.com/starfive-tech/VisionFive2/issues/55
>=20
> We should set the PLL0 rate to a correct rate (1.5GHz) and then
> the CPUfreq will work normally.

Please include an explanation in the commit message of the problem this
is addressing.

Also, a Fixes: tag + reported-by?

> Best regards,
> Xingyu Wu
>=20
> >=20
> >=20
> >> Change the parent of cpu_root clock
> >> and the divider of cpu_core before setting.
> >>=20
> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> >> ---
> >>=20
> >> Hi Stephen and Emil,
> >>=20
> >> This patch sets PLL0 rate to 1.5GHz. In order not to affect the cpu=20
> >> operation, the cpu_root's parent clock should be changed first.
> >> And the divider of the cpu_core clock should be set to 2 so they
> >> won't crash when setting 1.5GHz without voltage regulation.
> >>=20
> >> This patch is based on linux-next which has merge PLL driver on
> >> StarFive JH7110 SoC.
> >>=20
> >> Thanks,
> >> Xingyu Wu
>=20

--RojBI9Zo7R/mgEe2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNnQXwAKCRB4tDGHoIJi
0qJMAP4kZmzrUwCXni8fgSgkuHudobkp5DySRNfylKsWb967qQD+NOCVhXJk98tx
PBr+FTU1J98r09xigNcFP3qzFziehgU=
=bcON
-----END PGP SIGNATURE-----

--RojBI9Zo7R/mgEe2--
