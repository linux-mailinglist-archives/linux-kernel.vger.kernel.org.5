Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CAF78DC72
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjH3Spt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242454AbjH3Ifc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:35:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D23F1AE;
        Wed, 30 Aug 2023 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693384528; x=1724920528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1rr15Edf/mJdMl4aJdngCeF31+Nb5/f0kCNlVbqGRGc=;
  b=rVXoFatN+nhu2iJqnRLaeWPV1cdY4pd3cpuiBepSIiEf+WiXpDi7ouzN
   ztv1MilIMdiPV/qkq0FPxUFAmb5/vAtRHvulLCzDv4oMnnzLYuv9v6QmB
   OH/dIh/tgLNWycgy7uzxt7ZV1GiQ38euBzN4cIwyTdANaMq1DPkOr9wTi
   pyjDGVUJsh6Wq5Ec+HgY1mOPN/YaQjQw/M2wE3EpZe0GvEp3XO921L9LD
   VZurzOwAlo3EJPVF/IyQsRJLeRVaTS7Pgcwez6NVH7Ud8naJjqAtfrYoc
   rFjOCbiaMx1VFyWDsNUe5omuqJLdYdFmldvk/0/ehO8dGhYCg9pPcgyif
   A==;
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="asc'?scan'208";a="169026622"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2023 01:35:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 30 Aug 2023 01:34:51 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 30 Aug 2023 01:34:48 -0700
Date:   Wed, 30 Aug 2023 09:34:06 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     William Qiu <william.qiu@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Drop unused properties
Message-ID: <20230830-procedure-frostbite-56c751f7c276@wendy>
References: <20230830031846.127957-1-william.qiu@starfivetech.com>
 <20230830031846.127957-2-william.qiu@starfivetech.com>
 <20230830-commence-trickery-40eaa193cb15@wendy>
 <b375b88c-0d9c-30a9-21f6-283083cf3880@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h1favm8wo5hVWnmt"
Content-Disposition: inline
In-Reply-To: <b375b88c-0d9c-30a9-21f6-283083cf3880@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--h1favm8wo5hVWnmt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 09:29:20AM +0200, Krzysztof Kozlowski wrote:
> On 30/08/2023 08:50, Conor Dooley wrote:
> > On Wed, Aug 30, 2023 at 11:18:44AM +0800, William Qiu wrote:
> >> Due to the change of tuning implementation, it's no longer necessary to
> >> use the "starfive,sysreg" property in dts, so drop the relevant
> >> description in dt-bindings here.
> >=20
> > How does changing your software implantation invalidate a description of
> > the hardware?
> >=20
>=20
> Which is kind of proof that this syscon was just to substitute
> incomplete hardware description (e.g. missing clocks and phys). We
> should have rejected it. Just like we should reject them in the future.

:s I dunno what to do with this... I'm inclined to say not to remove it
=66rom the binding or dts at all & only change the software.

> There are just few cases where syscon is reasonable. All others is just
> laziness. It's not only starfivetech, of course. Several other
> contributors do the same.

I'm not sure if laziness is fair, lack of understanding is usually more
likely.

--h1favm8wo5hVWnmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZO7++gAKCRB4tDGHoIJi
0u4KAP0Vf98t3HptgWUDxzyfGqUIFcjfe/j2Dbq8eR0D637TbAEA0mpYQNoVYT5e
3uimUjgIT7U4Gkf664SMkKGV+ED1Zgs=
=cvPO
-----END PGP SIGNATURE-----

--h1favm8wo5hVWnmt--
