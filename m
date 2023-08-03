Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC22476E3AA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjHCIxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjHCIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:53:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715AAE43;
        Thu,  3 Aug 2023 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691052817; x=1722588817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1DUG1YI9NaBIZLAvEQTa5XZeeipNelrYpejz4hwab7Q=;
  b=GJlqrq8/zVUazAgzGQ9TGMAu6CTZYnKIZfTOu6EhRGjx3wuZRofCwO8o
   2gBDwPEC/XlV3U0kB33kAlXqpD6FZH0zTEzlVEPDtXjWID11MwS1jh6DA
   jQrNgWXOK2Qw+g18W4JkwqO1jMAog+LbLviLqSdfuUpl5s08hIIUIU5/M
   Sz/26UtEM0U1yCP0psQsMN6zJ8musiNaf88Ae7q7MetKRvIWv3HLu49LT
   4Jq/pNRCCJR6t36E3xBzojcnUM2F4F8r8yTgpPhIi60IFoSGh5AglHH5G
   60LTJYXwUpp/F9jIZ+K42QFElRnLoal93ziRgH/3dQqXDJKyKNTNw8BqN
   g==;
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="asc'?scan'208";a="164637452"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2023 01:53:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 3 Aug 2023 01:53:35 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 3 Aug 2023 01:53:32 -0700
Date:   Thu, 3 Aug 2023 09:52:56 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/1] serial: core: Fix serial_base_match() after
 fixing controller port name
Message-ID: <20230803-molecule-shelter-aa71b219af26@wendy>
References: <20230803071034.25571-1-tony@atomide.com>
 <2023080351-chaplain-headgear-bcbb@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SqrNJ+wWy5BRsFok"
Content-Disposition: inline
In-Reply-To: <2023080351-chaplain-headgear-bcbb@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--SqrNJ+wWy5BRsFok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 09:50:03AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 03, 2023 at 10:10:32AM +0300, Tony Lindgren wrote:
> > While fixing DEVNAME to be more usable, I broke serial_base_match() as =
the
> > ctrl and port prefix for device names seemed unnecessary.
> >=20
> > The prefixes are still needed by serial_base_match() to probe the serial
> > base controller port, and serial tx is now broken.
> >=20
> > Let's fix the issue by checking against dev->type and drv->name instead
> > of the prefixes that are no longer in the DEVNAME.
> >=20
> > Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port nam=
e to show controller id")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202308021529.35b3ad6c-oliver.san=
g@intel.com
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >=20
> > Changes since v1:
> > - Leave out magic numbers and use str_has_prefix() as suggested by Andy
> >   and Greg
> >=20
> > - Improve patch description and add a link for Closes tag as suggested
> >   by Jiri
> >=20
> > - Check the name against device_type name since we have it and leave
> >   out the changes to try to define names in the header because of the
> >   issues noted by Jiri
> >=20
> > - Leave out Tested-by from Mark and Anders as the patch changed
>=20
> Thanks for this, now queued up.

Seems like I am a bit late, but FWIW this does fix my boot failures in
-next:
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--SqrNJ+wWy5BRsFok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMtq3QAKCRB4tDGHoIJi
0hzrAPwNe3Aci1oYSam7q2JubnqG7pAXfKkMra6oE8XJJWnaAgEA+tcvAHd/Uxl6
hWtkS4rt9R1xmhsUfEj/FVcMrh8ZCAc=
=VAFL
-----END PGP SIGNATURE-----

--SqrNJ+wWy5BRsFok--
