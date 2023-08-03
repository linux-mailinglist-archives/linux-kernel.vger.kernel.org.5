Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421F176E415
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjHCJQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHCJQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:16:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452FEDA;
        Thu,  3 Aug 2023 02:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691054161; x=1722590161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=04nS9RFoJGf7hQ29BgtmNNaD7za5rZOA7S2jxdjGYCQ=;
  b=I7EZdyVbvDb30mMyDX1Fhypq+N/vby6kpzOdVoOe4pI7WADpdae5fzfS
   s/BCT0wB5RDf0a9kgMs5+U315M/SLC+CVFzs/NYb2pdZWmgB5evUzQh/0
   wiIUMcDAi70z7t+NNglk2G27hnZjBxnOM0Q8cA88zlAnSA4NUPwP/gbni
   7gOKhUMzdDCgSo301uY4iklEHvIQZsi6hUagH4HMByNgM+XDgMGDRP6hY
   gNomJ7tgjh/O8ras2bJpiEVGHt8ymN8CwB9c/6YL0BjUJ42JWO/kEhufx
   dUeDxuUVEs2LNiXrg2LI73fL+8acM+JGyO5zz6buTglksvjErx4RAtPQY
   A==;
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="asc'?scan'208";a="164641497"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2023 02:16:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 3 Aug 2023 02:15:49 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 3 Aug 2023 02:15:46 -0700
Date:   Thu, 3 Aug 2023 10:15:10 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nylon Chen <nylon.chen@sifive.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <geert+renesas@glider.be>,
        <pavel@ucw.cz>, <vincent.chen@sifive.com>,
        <emil.renner.berthing@canonical.com>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <conor@kernel.org>, <zong.li@sifive.com>
Subject: Re: [PATCH v4 0/1] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <20230803-vehicular-leggings-2830239f818a@wendy>
References: <20230803085734.340-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PB2u+tDiCA4uxtSW"
Content-Disposition: inline
In-Reply-To: <20230803085734.340-1-nylon.chen@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--PB2u+tDiCA4uxtSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 04:57:33PM +0800, Nylon Chen wrote:
> According to the circuit diagram of User LEDs - RGB described in themanua=
l hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].
>=20
> The behavior of PWM is acitve-high.
>=20
> Removed patches: 1
> New patches: (none)
>=20
> Links:
> - [0]:  https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8=
453f8698_hifive-unleashed-a00-schematics-1.pdf
> - [1]:  https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68c=
e76f4192_hifive-unmatched-schematics-v3.pdf
> - [2]:  https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed=
8b16acba_fu740-c000-manual-v1p6.pdf
>=20
> Changed in v4:
>  - Remove previous updates to the PWM algorithm.

Why? I don't recall the conclusion on the previous version being that
that patch was not needed.

--PB2u+tDiCA4uxtSW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMtwHgAKCRB4tDGHoIJi
0oMBAP9459PoL9HrrQEWgQ+bIJZFoDTz4oSo2vP5a5WyJGiJPAEAlkh6h9+6u46j
Vp1m1aPtTRxrkslLMJnwvuWrvxWbqAA=
=791u
-----END PGP SIGNATURE-----

--PB2u+tDiCA4uxtSW--
