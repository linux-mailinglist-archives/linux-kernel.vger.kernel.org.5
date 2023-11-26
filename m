Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A237F9544
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 21:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjKZUTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 15:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZUTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 15:19:51 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E334E4;
        Sun, 26 Nov 2023 12:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w1CoogEK5Y94cevFhrHKrD8PA3R+RY/g+P1/BFeJ95A=; b=Q5gQG/fBzZOzhI5MCJVm8aJMoR
        Te2/2mcwgKMEb3ZFvU/EL6zjKSguNEfQO/Klw1G+dHfg5e6rXaT8lUlzQBeV7c7109LxdwGQqCYWo
        qEB1bGcn/iekkZVvoHvFQSMhl9oS07WU5zpQcYt/ot9HyVlq5A8aHICReKX5aEAOZu+VFqGb3N2wu
        wlrBm/a5nAe9NF/qV0DvzZuT8l2pDLBC8BL1NBMcTrEKAQWEsjcKB+3aTeJ7MmOHQCrIUs3gfJ1Mo
        leI19GwCijc4P8kg+H/zhWPh75rHHbfCr7XXgyi95awlwtfZN3r/miZAYHX0e+lhh9FZPcU7SzIWZ
        Cw0wIhrQ==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <kibi@debian.org>)
        id 1r7LbZ-009ZQ3-91; Sun, 26 Nov 2023 20:19:50 +0000
Date:   Sun, 26 Nov 2023 21:19:46 +0100
From:   Cyril Brulebois <kibi@debian.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 0/2] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <20231126201946.ffm3bhg5du2xgztv@mraw.org>
Organization: Debian
References: <20231113185607.1756-1-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mkmt4f6shqfnuwxf"
Content-Disposition: inline
In-Reply-To: <20231113185607.1756-1-james.quinlan@broadcom.com>
X-Debian-User: kibi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mkmt4f6shqfnuwxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jim,

Jim Quinlan <james.quinlan@broadcom.com> (2023-11-13):
> V8 -- Un-advertise L1SS capability when in "no-l1ss" mode (Bjorn)
>    -- Squashed last two commits of v7 (Bjorn)
>    -- Fix DT binding description text wrapping (Bjorn)
>    -- Fix incorrect Spec reference (Bjorn)
>          s/PCIe Spec/PCIe Express Mini CEM 2.1 specification/
>    -- Text substitutions (Bjorn)
>          s/WRT/With respect to/=20
>          s/Tclron/T_CLRon/
>=20
> v7 -- Manivannan Sadhasivam suggested (a) making the property look like a
>       network phy-mode and (b) keeping the code simple (not counting clkr=
eq
>       signal appearances, un-advertising capabilites, etc).  This is
>       what I have done.  The property is now "brcm,clkreq-mode" and
>       the values may be one of "safe", "default", and "no-l1ss".  The
>       default setting is to employ the most capable power savings mode.

Still:

Tested-by: Cyril Brulebois <cyril@debamax.com>


I've just run my big test matrix again, and I can confirm everything is
still looking good with the updated series and the updated base commit.


Test setup:
-----------

 - using a $CM with the 20230111 EEPROM
 - on the same CM4 IO Board
 - with a $PCIE board (PCIe to multiple USB ports)
 - and the same Samsung USB flash drive + Logitech keyboard.

where $CM is one of:

 - CM4 Lite Rev 1.0
 - CM4 8/32 Rev 1.0
 - CM4 4/32 Rev 1.1

and $PCIE is one of:

 - SupaHub PCE6U1C-R02, VER 006
 - SupaHub PCE6U1C-R02, VER 006S
 - Waveshare VIA VL805/806-based


Results:
--------

 1. With an unpatched kernel, I'm getting either a successful boot
    *without* seeing the devices plugged on the PCIe-to-USB board
    or the dreaded SError in most cases, using a locally-built
    v6.4-rc7-194-g8a28a0b6f1a1d kernel.

 2. With a patched kernel (v6.6-15365-g305230142ae0 + this series),
    for all $CM/$PCIE combinations, I'm getting a system that boots,
    sees the flash drive, and gives decent read/write performance on
    it (plus a functional keyboard).


Cheers,
--=20
Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
D-I release manager -- Release team member -- Freelance Consultant

--mkmt4f6shqfnuwxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEtg6/KYRFPHDXTPR4/5FK8MKzVSAFAmVjqFwACgkQ/5FK8MKz
VSBgfxAAn3o2oYlRYjjFM1QJdb0L/cGkGg6stFG1Cg9G/y0SX/U9C4/RF0hYeXGg
9gKGzI2KVWFdWIMwEqBcVnM0/+m50VUyIn2ne0iHwkoOZXlJu5+5v2+lRhDKgmad
f1b86OdzqJ/JFT6AuA7f9JDzyQar/Q3TMFcN7ObOhoCfuKX/mnDrzhcWT4RFHSTA
CZrDs6y/ua4+07GxlJncR1yIlOVxwlTsTY3S0yD1Ppbva9BHZ5FP2/1o18TIipwh
vPCik5XC5c2oEeyEpP6adLJgQK9HYhMzw4eDPM7FTC27tOokr4DZkYDza6zn8XOS
xP3tMptoFfWNJHxmvXz3nS+qT6QkIvoNkysVNYM3J/HsVHjUUYHj9Wcj4tEdVOtY
ueMIuNnYF6PkPJ3erg09FMp8eBpk05ctSTdIq0U/Fg7UjSNWNDrW6JFsIQTpaenm
HxhroQzHFsBOAdHT5WFXQfXDTSUQVmNnv59cVWPhHwHlLy0ePFpjRC3doLZ0Zp65
dUQVF5VOgnnsO1WVExiyFNqm2b1JC9f1HSF0gjgbwJvnsY06uuZrodsFYKep8/np
1px/1lHTK23gvu+soe05hqmepc3Pn2HqpMdr56Lh/GZucmoCZydnn7MuykPcRLvy
seFmfpyY13qpLSXeRubFi524GtF/pc6XkIK1Wq4J5DGpTT2Y6Ts=
=ve11
-----END PGP SIGNATURE-----

--mkmt4f6shqfnuwxf--
