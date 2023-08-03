Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10F476E42D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjHCJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjHCJTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:19:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC31630E2;
        Thu,  3 Aug 2023 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691054351; x=1722590351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iyu2F1JT8sOFPz+Gp6fcbz1PovWQBilZGpXmG0uf2ys=;
  b=lqscUvAse6sn+x12Jd6glFsQF/UZyoLQFrliYhKf6DdFAdA20TtNooQa
   u3KZHEyKu9kEGCNq2ILyZKnOn/c3qRGC5W+xpMhVs2wtbcKziTvHkg3vI
   6a57q1i9sdkKTimqJzfCZjApChZ+/lsEIsMY3p+iUcZGdhY7wMMpiIBwB
   8y3YbrO7FvZAnP9auhMJiUtwztFXXI8gxves6uC5OvP3ktfTEZ8I8K3ff
   BoLwMNYAQsxFJbH42WneRWVbwT+sNmFxjLDIDCTEWl1mBwhaezgXQYdwz
   t9GasSp79t3NEOjAzTR0cFiaBBvIaEEyvfLrtaIvYwLSWGmX83APvwJFn
   g==;
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="asc'?scan'208";a="227772059"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2023 02:19:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 3 Aug 2023 02:19:09 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 3 Aug 2023 02:19:06 -0700
Date:   Thu, 3 Aug 2023 10:18:30 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nylon Chen <nylon.chen@sifive.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <geert+renesas@glider.be>,
        <pavel@ucw.cz>, <vincent.chen@sifive.com>,
        <emil.renner.berthing@canonical.com>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <conor@kernel.org>, <zong.li@sifive.com>
Subject: Re: [PATCH v4 1/1] riscv: dts: sifive: unleashed/unmatched: Remove
 PWM controlled LED's active-low properties
Message-ID: <20230803-avenge-vaporizer-8258cd3ed423@wendy>
References: <20230803085734.340-1-nylon.chen@sifive.com>
 <20230803085734.340-2-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ttHvIlaft4ITbXCH"
Content-Disposition: inline
In-Reply-To: <20230803085734.340-2-nylon.chen@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ttHvIlaft4ITbXCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 04:57:34PM +0800, Nylon Chen wrote:
> This removes the active-low properties of the PWM-controlled LEDs in
> the HiFive Unmatched device tree.
>=20
> The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schemat=
ics-v3.pdf[1].
>=20
> Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf845=
3f8698_hifive-unleashed-a00-schematics-1.pdf [0]
> Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce7=
6f4192_hifive-unmatched-schematics-v3.pdf [1]
>=20

> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Since there is no PWM driver patch for this to go along with, this ack
doesn't mean anything anymore. Please drop it if you resubmit.


--ttHvIlaft4ITbXCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMtw5gAKCRB4tDGHoIJi
0tnFAP0Zc9lgzavW5BcBnULMuCokFPIRFh6giiSMIiiNxXtIIAD/UOJ7eZR4vZrq
G8wToCxvQNYV0/XzSojKzSKqZODO6As=
=DKmS
-----END PGP SIGNATURE-----

--ttHvIlaft4ITbXCH--
