Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77561806591
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376397AbjLFDUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFDUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:20:10 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C41C1AA;
        Tue,  5 Dec 2023 19:20:16 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c629a9fe79so2810204a12.3;
        Tue, 05 Dec 2023 19:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701832816; x=1702437616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbWegLruIWfk7HHjzudK83DEHlZmfwTMD8LAtlJ7Hk8=;
        b=bvDHniXkeH+TAlr2mucy/zP2xU9GlbRkCJ0BcjKY+CjFNwFbjy/Z9lTraT71n0Tl8N
         QnO0nXqLNOMPzGRfKk8eXDVCi99DCVF4f14yjrNl1Q0CbOJmlhVtmi7i7n6VDvBAfmRy
         +0QlwiPcFxlRU3QI/N/aaFL3x6zhyCTT5AJm13CS5HYyhpX4itEQCtKj90d9eGJevKwF
         tFcMmFxEzUq45fJ+W/jOSNom62CofSVL2UGhjampTBziArmkaS4ylJl/dDY8tJUhK1K3
         T3hbQ8sEl6795jsA+V+YLVlMv/qWks8m5BNAtd660UW20Iao61zwDGKlUiofpEfG3eYO
         7Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701832816; x=1702437616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbWegLruIWfk7HHjzudK83DEHlZmfwTMD8LAtlJ7Hk8=;
        b=MWA13kvq97TxYsAo+C6aMyf2OcnXD4biysfQHUWVoYokgVzvCEgNI3ZgiQrA1p1UrL
         rrE7AYzvPk02r3TkXHBH0Ezkc7Oamu9A9QbkuanRcv5hmvtb+z+Spr5nR9p97Wm6Yp6l
         7ZNdyXuwafBEi8NlYm1tWEREygVAswioUp0jqfdgZNlYWls15eztH8byO1ZvUpyZfLGm
         yLheUKodlPpcyV/dk00xftF6ieoW1dOHMJ6IlXUnsjjfw8ZyCzWo2j3oY7dOJ2H2NbzS
         HfK6G2mh5K/u40kwwBGYNIZ2pFg+U5QlfaN9ehoatEOI1qS2cvMol5qv/NhT1B+g08gP
         me8g==
X-Gm-Message-State: AOJu0YzDj0e7joXAwWRA6c444rb8JG3RxkWxnlL7W+KZgWikSmUripzQ
        0UjNUU1RieAWEc9ON1ci+tI=
X-Google-Smtp-Source: AGHT+IGHvutYgMcTLhOthlYgg/Dwf/5tmBozECpELlMTbXQaeNaLXGBV6iGB2iChY7bhGVrPh+XzcA==
X-Received: by 2002:a05:6a20:760a:b0:18b:9b41:eb90 with SMTP id m10-20020a056a20760a00b0018b9b41eb90mr103486pze.10.1701832815584;
        Tue, 05 Dec 2023 19:20:15 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id z6-20020a170902ee0600b001cfc35d1326sm7515152plb.177.2023.12.05.19.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 19:20:15 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 482C11025C548; Wed,  6 Dec 2023 09:45:45 +0700 (WIB)
Date:   Wed, 6 Dec 2023 09:45:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kory Maincent <kory.maincent@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        attreyee-muk <tintinm2017@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Linux Networking <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Devicetree <devicetree@vger.kernel.org>,
        Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 2/8] ethtool: Expand Ethernet Power Equipment
 with c33 (PoE) alongside PoDL
Message-ID: <ZW_gWDrlp4ltXIRf@archie.me>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-2-56d8cac607fa@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xUlHZgsU8STvZe3K"
Content-Disposition: inline
In-Reply-To: <20231201-feature_poe-v2-2-56d8cac607fa@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xUlHZgsU8STvZe3K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 06:10:24PM +0100, Kory Maincent wrote:
> In the current PSE interface for Ethernet Power Equipment, support is
> limited to PoDL. This patch extends the interface to accommodate the
> objects specified in IEEE 802.3-2022 145.2 for Power sourcing
> Equipment (PSE).
>=20
> The following objects are now supported and considered mandatory:
> - IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus
> - IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
> - IEEE 802.3-2022 30.9.1.2.1 aPSEAdminControl
>=20
> To avoid confusion between "PoDL PSE" and "PoE PSE", which have similar
> names but distinct values, we have followed the suggestion of Oleksij
> Rempel and Andrew Lunn to maintain separate naming schemes for each,
> using c33 (clause 33) prefix for "PoE PSE".
> You can find more details in the discussion threads here:
> https://lore.kernel.org/netdev/20230912110637.GI780075@pengutronix.de/
> https://lore.kernel.org/netdev/2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.=
ch/
>=20
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>=20
> Changes in v2:
> - Rename all the PoE variables and enum with a c33 prefix.
> - Add documentation, thanks to Oleksij for having written one.
> ---
>  Documentation/networking/pse-pd/introduction.rst | 73 ++++++++++++++++++=
++++++
>  include/linux/pse-pd/pse.h                       |  9 +++
>  include/uapi/linux/ethtool.h                     | 43 ++++++++++++++
>  include/uapi/linux/ethtool_netlink.h             |  3 +
>  4 files changed, 128 insertions(+)
>=20
> diff --git a/Documentation/networking/pse-pd/introduction.rst b/Documenta=
tion/networking/pse-pd/introduction.rst
> new file mode 100644
> index 000000000000..e213083b9aff
> --- /dev/null
> +++ b/Documentation/networking/pse-pd/introduction.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Power Sourcing Equipment (PSE) in IEEE 802.3 Standard
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
> +Power Sourcing Equipment (PSE) is essential in networks for delivering p=
ower
> +along with data over Ethernet cables. It usually refers to devices like
> +switches and hubs that supply power to Powered Devices (PDs) such as IP
> +cameras, VoIP phones, and wireless access points.
> +
> +PSE vs. PoDL PSE
> +----------------
> +
> +PSE in the IEEE 802.3 standard generally refers to equipment that provid=
es
> +power alongside data over Ethernet cables, typically associated with Pow=
er over
> +Ethernet (PoE).
> +
> +PoDL PSE, or Power over Data Lines PSE, specifically denotes PSEs operat=
ing
> +with single balanced twisted-pair PHYs, as per Clause 104 of IEEE 802.3.=
 PoDL
> +is significant in contexts like automotive and industrial controls where=
 power
> +and data delivery over a single pair is advantageous.
> +
> +IEEE 802.3-2018 Addendums and Related Clauses
> +----------------------------------------------
> +
> +Key addenda to the IEEE 802.3-2018 standard relevant to power delivery o=
ver
> +Ethernet are as follows:
> +
> +- **802.3af (Approved in 2003-06-12)**: Known as PoE in the market, deta=
iled in
> +  Clause 33, delivering up to 15.4W of power.
> +- **802.3at (Approved in 2009-09-11)**: Marketed as PoE+, enhancing PoE =
as
> +  covered in Clause 33, increasing power delivery to up to 30W.
> +- **802.3bt (Approved in 2018-09-27)**: Known as 4PPoE in the market, ou=
tlined
> +  in Clause 33. Type 3 delivers up to 60W, and Type 4 up to 100W.
> +- **802.3bu (Approved in 2016-12-07)**: Formerly referred to as PoDL, de=
tailed
> +  in Clause 104. Introduces Classes 0 - 9. Class 9 PoDL PSE delivers up =
to ~65W
> +
> +Kernel Naming Convention Recommendations
> +----------------------------------------
> +
> +For clarity and consistency within the Linux kernel's networking subsyst=
em, the
> +following naming conventions are recommended:
> +
> +- For general PSE (PoE) code, use "c33_pse" key words. For example:
> +  ``enum ethtool_c33_pse_admin_state c33_admin_control;``.
> +  This aligns with Clause 33, encompassing various PoE forms.
> +
> +- For PoDL PSE - specific code, use "podl_pse". For example:
> +  ``enum ethtool_podl_pse_admin_state podl_admin_control;`` to different=
iate
> +  PoDL PSE settings according to Clause 104.
> +
> +Summary of Clause 33: Data Terminal Equipment (DTE) Power via Media Depe=
ndent Interface (MDI)
> +------------------------------------------------------------------------=
-------------------
> +
> +Clause 33 of the IEEE 802.3 standard defines the functional and electric=
al
> +characteristics of Powered Device (PD) and Power Sourcing Equipment (PSE=
).
> +These entities enable power delivery using the same generic cabling as f=
or data
> +transmission, integrating power with data communication for devices such=
 as
> +10BASE-T, 100BASE-TX, or 1000BASE-T.
> +
> +Summary of Clause 104: Power over Data Lines (PoDL) of Single Balanced T=
wisted-Pair Ethernet
> +------------------------------------------------------------------------=
-------------------
> +
> +Clause 104 of the IEEE 802.3 standard delineates the functional and elec=
trical
> +characteristics of PoDL Powered Devices (PDs) and PoDL Power Sourcing Eq=
uipment
> +(PSEs). These are designed for use with single balanced twisted-pair Eth=
ernet
> +Physical Layers. In this clause, 'PSE' refers specifically to PoDL PSE, =
and
> +'PD' to PoDL PD. The key intent is to provide devices with a unified int=
erface
> +for both data and the power required to process this data over a single
> +balanced twisted-pair Ethernet connection.

I get many htmldocs warnings:

```
Documentation/networking/pse-pd/introduction.rst:56: WARNING: Title underli=
ne too short.

Summary of Clause 33: Data Terminal Equipment (DTE) Power via Media Depende=
nt Interface (MDI)
---------------------------------------------------------------------------=
----------------
Documentation/networking/pse-pd/introduction.rst:56: WARNING: Title underli=
ne too short.

Summary of Clause 33: Data Terminal Equipment (DTE) Power via Media Depende=
nt Interface (MDI)
---------------------------------------------------------------------------=
----------------
Documentation/networking/pse-pd/introduction.rst:65: WARNING: Title underli=
ne too short.

Summary of Clause 104: Power over Data Lines (PoDL) of Single Balanced Twis=
ted-Pair Ethernet
---------------------------------------------------------------------------=
----------------
Documentation/networking/pse-pd/introduction.rst:65: WARNING: Title underli=
ne too short.

Summary of Clause 104: Power over Data Lines (PoDL) of Single Balanced Twis=
ted-Pair Ethernet
---------------------------------------------------------------------------=
----------------
looking for now-outdated files... none found
pickling environment... done
checking consistency... Documentation/networking/pse-pd/introduction.rst: W=
ARNING: document isn't included in any toctree
```

I have to fix them up:

---- >8 ----
diff --git a/Documentation/networking/index.rst b/Documentation/networking/=
index.rst
index 683eb42309cc5b..3900c6885cfc7d 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -88,6 +88,7 @@ Contents:
    phonet
    pktgen
    plip
+   pse-pd/index
    ppp_generic
    proc_net_tcp
    radiotap-headers
diff --git a/Documentation/networking/pse-pd/index.rst b/Documentation/netw=
orking/pse-pd/index.rst
new file mode 100644
index 00000000000000..18197bc7303dc9
--- /dev/null
+++ b/Documentation/networking/pse-pd/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Power Sourcing Equipment (PSE) Documentation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. toctree::
+   :maxdepth: 2
+
+   introduction
diff --git a/Documentation/networking/pse-pd/introduction.rst b/Documentati=
on/networking/pse-pd/introduction.rst
index e213083b9aff2d..e3d3faaef717f2 100644
--- a/Documentation/networking/pse-pd/introduction.rst
+++ b/Documentation/networking/pse-pd/introduction.rst
@@ -24,7 +24,7 @@ is significant in contexts like automotive and industrial=
 controls where power
 and data delivery over a single pair is advantageous.
=20
 IEEE 802.3-2018 Addendums and Related Clauses
-----------------------------------------------
+---------------------------------------------
=20
 Key addenda to the IEEE 802.3-2018 standard relevant to power delivery over
 Ethernet are as follows:
@@ -53,7 +53,7 @@ following naming conventions are recommended:
   PoDL PSE settings according to Clause 104.
=20
 Summary of Clause 33: Data Terminal Equipment (DTE) Power via Media Depend=
ent Interface (MDI)
---------------------------------------------------------------------------=
-----------------
+--------------------------------------------------------------------------=
-------------------
=20
 Clause 33 of the IEEE 802.3 standard defines the functional and electrical
 characteristics of Powered Device (PD) and Power Sourcing Equipment (PSE).
@@ -62,7 +62,7 @@ transmission, integrating power with data communication f=
or devices such as
 10BASE-T, 100BASE-TX, or 1000BASE-T.
=20
 Summary of Clause 104: Power over Data Lines (PoDL) of Single Balanced Twi=
sted-Pair Ethernet
---------------------------------------------------------------------------=
-----------------
+--------------------------------------------------------------------------=
------------------
=20
 Clause 104 of the IEEE 802.3 standard delineates the functional and electr=
ical
 characteristics of PoDL Powered Devices (PDs) and PoDL Power Sourcing Equi=
pment

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--xUlHZgsU8STvZe3K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZW/gVAAKCRD2uYlJVVFO
oyi0AP0akTssoZ2ef0IsF2c3NcWk9n0I0Qa7r88yxoNHZh4whAD/Q3Tnge1Z06AT
0nVAX/jUCWw3zw0Bk7o2ptuss7XjxwA=
=NdIm
-----END PGP SIGNATURE-----

--xUlHZgsU8STvZe3K--
