Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986B3762BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjGZGqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGZGp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:45:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1122705;
        Tue, 25 Jul 2023 23:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690353953; x=1721889953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gDNCsCsO1KbGhAHJNmEBa1gkvZGzH8c3upBGSOQlNOA=;
  b=F62RQVXUzDmoaoFbYR32xfCLGv/rmnK/AVb2eXGLxODDGkPKOLuigRzz
   EXyNSGQWvtQfpLymX7GHE0WUDyvj3cZYaBY79fgXY7zCJ6boZtMVHWe1V
   KARVT4ZyAJmD27dXOEUMFcHCFy4IFK2q5VVfNEDqC90IfUfHsXWp3FR46
   mxsdYCysbIY93uFMbEI4bk5+JUWtd1lFZq5FW9yDUCdmcvNdjTY591JBl
   BJwQQXLM/3q1d7cVW83UGVQAlv06reRGGOgQPAUzDwuhHtNSTofFfeLTn
   em/cIzJtcfeOaGNV7IVLedwSVDpUDpFWxZAMZIfdc/+JtEEcnsSfKK2rn
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="asc'?scan'208";a="163253302"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2023 23:45:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 25 Jul 2023 23:45:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 25 Jul 2023 23:45:43 -0700
Date:   Wed, 26 Jul 2023 07:45:08 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "chenjiahao (C)" <chenjiahao16@huawei.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <guoren@kernel.org>, <heiko@sntech.de>,
        <bjorn@rivosinc.com>, <alex@ghiti.fr>, <akpm@linux-foundation.org>,
        <atishp@rivosinc.com>, <bhe@redhat.com>,
        <thunder.leizhen@huawei.com>, <horms@kernel.org>
Subject: Re: [PATCH -next v8 0/2] support allocating crashkernel above 4G
 explicitly on riscv
Message-ID: <20230726-affix-employed-319aada685e7@wendy>
References: <20230725214413.2488159-1-chenjiahao16@huawei.com>
 <20230725-judiciary-auction-ef50be622175@spud>
 <96245a6f-cff1-9f2a-1217-4109d9a19291@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IJOap9vmU2OvA6x9"
Content-Disposition: inline
In-Reply-To: <96245a6f-cff1-9f2a-1217-4109d9a19291@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--IJOap9vmU2OvA6x9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 10:20:00AM +0800, chenjiahao (C) wrote:
>=20
> On 2023/7/26 5:48, Conor Dooley wrote:
> > Hey,
> >=20
> > Your $subject says -next, but the patch failed to apply to
> > riscv/for-next. What was the base for this patchset?
> >=20
> > Thanks,
> > Conor.
>=20
> Hi,
>=20
> My patchset was tested on current linux-next HEAD
> (commit ID: 1e25dd777248, tag: next-20230725) and
> it seems all ok.

> Could you try applying with the base above, or
> is there any problem with that base?

There's some difference between linux-next and riscv/for-next that
prevents the patchwork automation from applying the patches.

--IJOap9vmU2OvA6x9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMDA5QAKCRB4tDGHoIJi
0tKwAP9sgmoHHSgRVm0XXcQYF7qM3+usgvdzT0xxSm4kXVozZgD3WZsTiicAAJla
IpwJI7hV57KDX7zRXzg2yr8IZCNjDg==
=VfGq
-----END PGP SIGNATURE-----

--IJOap9vmU2OvA6x9--
