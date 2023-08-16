Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AC677E1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245261AbjHPMeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244429AbjHPMeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:34:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BA01FCE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692189254; x=1723725254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lyhELIJqxcrJzxwaOiTZGnsjr8uYfDonHAMh6w9QOK0=;
  b=oWyPsEYF1L6dMIr+y8uYDwdNELEny7o9seHV33zf6hShl80RIGUnYTML
   qHaS13FZ849aHK8feZ1wfbLFG0i+a3oC+/9XDUw1Zg5GEtTUHuyjzR4qr
   cyPhSEYPsyFcipFfpAzCQTJMDPxCznrK1hkkwigwVlWD8xEysXbaI+Usj
   BDggyfN/wV6PGtfICET9LB4TegJthScz6Az4H+sAL9KymovzTfUTnm29y
   1nmTA21ybvCJiaHzXS047gsScON9YZth3wh6i4dsaBOI9/ARnxvIVX2KA
   6j9khRfQsRZrOUSpSO3j3yLssrNzBa/wP8prLCbeMKs8yERp7pbzGmbLw
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="asc'?scan'208";a="225669164"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2023 05:34:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 16 Aug 2023 05:34:11 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 16 Aug 2023 05:34:09 -0700
Date:   Wed, 16 Aug 2023 13:33:30 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nick Hu <nick.hu@sifive.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <ajones@ventanamicro.com>,
        <mason.huo@starfivetech.com>, <jeeheng.sia@starfivetech.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH] riscv: suspend: Add syscore ops for suspend
Message-ID: <20230816-mural-portion-5b22d90e83fd@wendy>
References: <20230816034009.2614866-1-nick.hu@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mujUFVaVXdyT0dmu"
Content-Disposition: inline
In-Reply-To: <20230816034009.2614866-1-nick.hu@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--mujUFVaVXdyT0dmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2023 at 11:40:09AM +0800, Nick Hu wrote:
> Save and restore the FPU and vector states when system suspend. If a
> task is the one who performs the suspend flow and it also do some
> floating or vector operations before the suspend, we should save and
> restore the FPU states and vector states for this task.
>=20
> Signed-off-by: Nick Hu <nick.hu@sifive.com>

> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>

What was Andy's contribution to the patch?
Are you missing a co-developed-by tag?

Also, I'm a bit confused by the commit message due to a lack of
knowledge here - is this a fix or a new feature?
It reads as if things are not being saved/restored correctly, but
there's no "fix" related keywords in the commit message nor a Fixes:
tag.

Thanks,
Conor.

--mujUFVaVXdyT0dmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNzCGgAKCRB4tDGHoIJi
0vd6APsEzcdqOn94Igwx7pElasQuaMkT0YL/4Ki5Fv89meVt1wD+N8lY5dX3JdnO
Jzi2aDbkXftaAbJyn5chJR7M3qc6UwI=
=r77g
-----END PGP SIGNATURE-----

--mujUFVaVXdyT0dmu--
