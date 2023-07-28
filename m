Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE205766790
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjG1IpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjG1IoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:44:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520732738;
        Fri, 28 Jul 2023 01:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690533862; x=1722069862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xljk28C8TabJn6D88mq8XQ/vv5LsrMcLddBbYGMpq5U=;
  b=Xec4lLIDT9QfpDG9G2aIRFm8BJTBgCBXz4ThaSuY7FLDM2SWjOpLeRvo
   xo2HspP9zdTyoXYuIh3qYpylTCzIISBn1WMaeVIayTyK9UqviskOaVTad
   PDxgcI9AywncJ+M6KhLbSEZrVuB1Er6Eb2dIG1bdaqHHj2/qgc9OAPN8s
   NV40jUUoWkrpoUMWSfvnRhjljpZVRwJ9vH3KL/7knCftbp8CEUBSHIan3
   08/fxdntIhz/1B+2LqO8lJujrEMVCkYZ407Et3bDS601Zx3B0CgcauZ8b
   a5WFSOHjukwd/7B72OYCiNZL6xTT6oG0/ZKfjTfczqKdgsFVbYBmsIBma
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="asc'?scan'208";a="238388894"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 01:44:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 01:44:21 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Jul 2023 01:44:18 -0700
Date:   Fri, 28 Jul 2023 09:43:43 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
CC:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        <wanghongliang@loongson.cn>, Liu Peibao <liupeibao@loongson.cn>,
        <loongson-kernel@lists.loongnix.cn>, Liu Yun <liuyun@loongson.cn>,
        <chenhuacai@kernel.org>, <kernel@xen0n.name>
Subject: Re: [PATCH v5 0/2] soc: loongson2_pm: add power management support
Message-ID: <20230728-cornball-preacher-a7e4644fcbef@wendy>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UZdMYQzKkfUUS+1M"
Content-Disposition: inline
In-Reply-To: <20230728074944.26746-1-zhuyinbo@loongson.cn>
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

--UZdMYQzKkfUUS+1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

+CC Huacai & WANG.

On Fri, Jul 28, 2023 at 03:49:42PM +0800, Yinbo Zhu wrote:
> Loongson-2 platform support Power Management Controller (ACPI) and this
> series patch was to add PM driver that base on dts and PM binding support.
>=20
> Change in v5:
> 		1. The patch "[PATCH v3 1/3] loongarch: export some arch-specific
> 		   pm interfaces" had been merged into linux-next tree thus this
> 		   v4 series patch need drop it and need depend on it and it's
> 		   patch link was:
> https://lore.kernel.org/all/20230615091757.24686-2-zhuyinbo@loongson.cn/

Just to note, it might be in linux-next, but more importantly it is also
in v6.5-rc1, so there is no issue with dependencies.

> 		2. Swap the positions of compatible for 2k1000 and 2k0500.

I noticed you sent a mail pinging the v4 of this series yesterday as it
had not been picked up. Who do you actually expect to apply these
patches? There does not appear to be a maintainer listed for the
drivers/soc/loongson directory, just one for your GUTS driver.

As a result, patches like
<https://lore.kernel.org/all/a69170cb55cfc73e378b40ccf1d9c16f@208suo.com/>
have gone ignored. Granted, that patch is probably crap that does not
apply, due to 208suo.com people sending corrupted patches, but you the
point.

More interestingly there is also
<https://lore.kernel.org/all/40b324af-3483-4b3d-b65a-a97944aa4a70@app.fastm=
ail.com/>
which seems to have also gone missing (I don't see it in linux-next),
despite some discussion about how the patch should be merged.

Looks to me like drivers/soc/loongson/ needs someone to take
responsibility for picking up patches for the directory & sending them
to the soc maintainers (with a new MAINTAINERS entry reflecting that) so
that patches don't fall through the cracks.

Thanks,
Conor.

--UZdMYQzKkfUUS+1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMN/vwAKCRB4tDGHoIJi
0qmiAQDS9mvW/41YU9HvBHC4ZwNsN5yzGwb0yF2EJGqQ0hFbhAD9FqrgePMsjoB9
mLXY8P6BfLNBh4fDjgk+LEl4mnwIWg4=
=3HUz
-----END PGP SIGNATURE-----

--UZdMYQzKkfUUS+1M--
