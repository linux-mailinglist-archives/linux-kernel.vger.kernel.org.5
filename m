Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0D27A04EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbjINNF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbjINNF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:05:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A461FD5;
        Thu, 14 Sep 2023 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694696752; x=1726232752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bFjx+SY72hetzAF5+8Myb01ScB2LpuX1/USvMPO9Sl4=;
  b=Y1xi+n5Wb2ufcedJPeclNkM7ac+Ljjr0yxRRat3B+49KxtOCF3MKIySM
   vNF2rUljQLUUlL47LoGdEY0cEET7eCTxKGqvYirFmAVEpQHTSEDRzjGTK
   QtboLG9llfOD68PROg4wjkiHOn4OV0vyFCizDOo9oX0ibu286+yquULIU
   auaAmP206HAJCO5Vl8VKPeIdfCqAdGDOxf2Px8CXlF3lI93U8d43y8LaX
   VjfZGoiqIpGv2/7GYbYfFqF93MHoHrt7E1ZXFV/le9QXkJk2DYBO7HlVc
   5X3Fjrpx/ZAE2ff0bkshvWveDoBgB/LKjxUtNecsX8dtrmv0pSAWseeop
   Q==;
X-CSE-ConnectionGUID: FF6xf1diS2Ob62pF01zcqQ==
X-CSE-MsgGUID: ADYnQ6GcSYyCRIyV8oyr1A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="asc'?scan'208";a="4664425"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 06:05:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 14 Sep 2023 06:05:50 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 14 Sep 2023 06:05:47 -0700
Date:   Thu, 14 Sep 2023 14:05:31 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/6] RISC-V BLAKE2s Vector implementation
Message-ID: <20230914-float-uneven-7cd1a18b3978@wendy>
References: <20230912115728.172982-1-bjorn@kernel.org>
 <20230914-roaming-plunging-948c78d9831c@wendy>
 <87pm2kap1p.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Z89i+AmwxS2DNN/"
Content-Disposition: inline
In-Reply-To: <87pm2kap1p.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--4Z89i+AmwxS2DNN/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 02:59:30PM +0200, Bj=F6rn T=F6pel wrote:
> Conor Dooley <conor.dooley@microchip.com> writes:
>=20
> > On Tue, Sep 12, 2023 at 01:57:22PM +0200, Bj=F6rn T=F6pel wrote:
> >> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> >>=20
> >> Hi,
> >>=20
> >> This is Andy's kernel mode vector V2 series [1], with my BLAKE2s
> >> AVX-512-to-RISC-V translation patch appended.
> >>=20
> >> I've tagged it as RFC, since Andy's series is still not in-tree yet.
> >>=20
> >> It's a first step towards a Vector aided Wireguard! ;-)
> >
> > This has the same problems as Andy's stuff & doesn't build properly for=
 the
> > automation. What is the plan between yourself and Andy for submitting a
> > version of the in-kernel vector support that passes build testing?
>=20
> I'll synch up with Andy! I'm not even sure the blake2s patch should part
> of the "in-kernel vector" series at all.

The in-kernel vector stuff should come with a user, otherwise it's dead
code :)

--4Z89i+AmwxS2DNN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQMFGwAKCRB4tDGHoIJi
0nmFAQDHF1wBd2jJ7LQfLaP8C74vxNiAF9XKvsbMGR3MThqnJgD+JLe5EToa4Wse
m9FpUzukIIhTCC5Xsq+aCiT+wUzQcAA=
=2kdw
-----END PGP SIGNATURE-----

--4Z89i+AmwxS2DNN/--
