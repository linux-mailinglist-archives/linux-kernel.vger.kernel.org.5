Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE5A7F0696
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjKSNv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSNv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:51:26 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE40583;
        Sun, 19 Nov 2023 05:51:22 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf57430104so2961295ad.1;
        Sun, 19 Nov 2023 05:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700401882; x=1701006682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BFaaFcM0s0AAPxjIW+xwio0LQYtoB+ElMC4cqj7h3OU=;
        b=iJG5nFAmjSdrE84nVdT0yUnwzDSzl2gdZZt+gOJZH97sCcBO4wqbwNxLFnbuzN6I3T
         XFFeVzxBbLMSq6OyP2VMrXDw9yQp81kvaM8oznhpX9c4unaIHru1SDt9hwAzrlDdRP1d
         RCE5/Ji56wdD4kXEFB4rTUc76nLCHpYIHI2imN4L0t+f8N461VXk1OHwlZwtPQ+3zwuR
         G6S9ofZ72r69bL9joUwVyzBBhdxFEXUVQYJYxYjDqM/oZ104R0WcWyxie0aMRl7fb9eq
         XrpPObAiyxNM7FmwnKK8slOaJblUP1KM593cItucf7dN8+GFiN6oGwmca08tkiKCBG1V
         3umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700401882; x=1701006682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFaaFcM0s0AAPxjIW+xwio0LQYtoB+ElMC4cqj7h3OU=;
        b=K6kfC0yH/L7ROhNJC49WAfx7XJ86g2dhOVzHDR64lrFfMYJHlDjV6CB2+iitJgMAta
         HNgPGt4Q/X2NWcieC0fV7iKwR7eulxsfmDTgk0Mhhhk76q8NS+5hX4SMnMFV1uG8QcTv
         gTEN8LfNSukRoFkoFyiqak4bPEYsC4Y+kJq4pA/kvTT1Ir4O6XNPLNDHDt8vyFHA0Jcs
         ZhJec1H1X4pVEHgI9iU71NtN/TYkRd6zuyKI8PkkxpczNJwJajhwseTM1JutV4d5MTIX
         r396vgsZJGS/m/CX/LbJ1zOYM7H/DEDklfZ20v+4twuA3GP2HtXu51gVOPkU/J6vMgQO
         bwwg==
X-Gm-Message-State: AOJu0YxXQ5Pv1lYRK/XN+OClgy4JigY2iZ58cGKv+9LroyhNkLHzcL2P
        7bUIl3tVFEHR6XspUG25SMQ=
X-Google-Smtp-Source: AGHT+IEKLUCj2Ws0Mij9vi9u00UGwYdfEvC3Ii6wJOCCe34iYBfOpfyXwjQK64/2RqGVrm/vmWgMSw==
X-Received: by 2002:a17:902:c14c:b0:1cc:51b8:8100 with SMTP id 12-20020a170902c14c00b001cc51b88100mr3278733plj.7.1700401882073;
        Sun, 19 Nov 2023 05:51:22 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001c61901ed37sm4377515plb.191.2023.11.19.05.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:51:21 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id EE102101D92E3; Sun, 19 Nov 2023 20:51:19 +0700 (WIB)
Date:   Sun, 19 Nov 2023 20:51:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Oliver Sieber <ollisieber@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Sound System <linux-sound@vger.kernel.org>,
        Linux ALSA Development <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: Fwd: acp3x: Missing product ID for Thinkpad T14s Gen2 AMD Ryzen
 7 PRO 5850U
Message-ID: <ZVoS13B2Br9U8mvu@archie.me>
References: <8bd0e77f-720b-4804-bbd8-477bd7df938e@gmail.com>
 <251c1bea-8250-40dd-bdea-1cd739d1e77a@gmail.com>
 <a75ce6e7-5012-43d8-a222-dd2639c5969c@gmail.com>
 <78149e00-12b5-459b-8754-a17dd974916d@gmail.com>
 <87sf54jyjl.wl-tiwai@suse.de>
 <826bb4f4-c6ea-4c45-a0e0-5ca826f0cfe0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RgrZYw5NPeRGwo21"
Content-Disposition: inline
In-Reply-To: <826bb4f4-c6ea-4c45-a0e0-5ca826f0cfe0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RgrZYw5NPeRGwo21
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2023 at 09:54:32AM +0100, Oliver Sieber wrote:
> Hi,
>=20
> in the following I provide my proposed patch for the bug report on Bugzil=
la
> [1]. Let me quote from it:
> > Hey,sound/soc/amd/renoir/rn-pci-acp3x.c has a hard-coded list of quirks=
=2E It seems like some product IDs may be missing. In my case, I am using a=
 Lenovo Thinkpad t14s gen2 with an AMD Ryzen 7 PRO 5850U.
> > My audio output is fine but my internal microphone cannot be found.
> >=20
> > Running `dmidecode` yields:
> >=20
> > Handle 0x000F, DMI type 1, 27 bytes
> > System Information
> > 	Manufacturer: LENOVO
> > 	Product Name: 20XGS1KT02
> > 	Version: ThinkPad T14s Gen 2a
> >=20
> > Could it be that one may have to add the product ID "20XGS1KT02" to the=
 hard-coded list of quirks in rn-pci-acp3x.c?
> >=20
> >=20
> > It seems as there have been similar problems in the past, e.g.https://b=
ugzilla.kernel.org/show_bug.cgi?id=3D216270.
>=20
> My proposed diff looks as follows:
>=20
> Subject: ASoC: AMD Renoir - add DMI entry for Lenovo ThinkPad T14s Gen 2
> From: Oliver Sieber
> The ThinkPad T14s Gen 2 laptop does not have the internal digital
> microphone connected to the AMD's ACP bridge, but it's advertised
> via BIOS. The internal microphone is connected to the HDA codec.
>=20
> Use DMI to block the microphone PCM device for this platform.
>=20
> Signed-off-by: Oliver Sieber <ollisieber@gmail.com>
> ---
> diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c
> b/sound/soc/amd/renoir/rn-pci-acp3x.c
> index b3812b70f5f9..754e24d55e6f 100644
> --- a/sound/soc/amd/renoir/rn-pci-acp3x.c
> +++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
> @@ -199,6 +199,13 @@ static const struct dmi_system_id rn_acp_quirk_table=
[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_EXAC=
T_MATCH(DMI_BOARD_NAME, "20NLCTO1WW"),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* Lenovo ThinkPad T14s Gen 2 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 .matches =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_EXACT_MATC=
H(DMI_BOARD_VENDOR, "LENOVO"),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMI_EXACT_MATC=
H(DMI_BOARD_NAME, "20XGS1KT02"),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {}
>=20
> =C2=A0};
>=20

Hi Oliver,

Did you forget Takashi's suggestion to follow formal patch submission
procedure [1]? Hint: It is suggested to use git-send-email(1) when
sending patches, as it handles them as-is (e.g. no wordwrapping,
tabs preserved).

Thanks.

[1]: https://lore.kernel.org/alsa-devel/87sf54jyjl.wl-tiwai@suse.de/

--=20
An old man doll... just what I always wanted! - Clara

--RgrZYw5NPeRGwo21
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVoS1AAKCRD2uYlJVVFO
oxEwAP9tVEhVvsolMp9atXWPaMw9tMx11FLXrcNpseXNiPTpWwD40zHKn4qSaSFA
d+qO6fzkUeHigQdKkJrzBoLskjqsAg==
=bWQV
-----END PGP SIGNATURE-----

--RgrZYw5NPeRGwo21--
