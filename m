Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC457C5E98
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjJKUoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjJKUoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:44:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B40291;
        Wed, 11 Oct 2023 13:44:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bffa8578feso3065531fa.2;
        Wed, 11 Oct 2023 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697057044; x=1697661844; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P31EaSRln5Y8qXIhPg5k92XnAsV91qhf1ea5PLnQlac=;
        b=XIvtI/nq89ozpt/HKMWYaLpsyb/orPMH5VPrsE22xSWlZ+wxUvZ6gpgw8ZqilNwXgT
         IqND8bevZjnzxD1RWu5XuDkbxQMD45YOUSNbhrRgrdys5vBFCA3ULJlrK4QV56B5faUZ
         oJoAAuOZxdz5Q/ZQQQ2VmVnl6VvwEI4SdTY+jMKR+Pvv8B1i9ZTUM6/ISwyjp2Tu7pf0
         dyEJ0GZtVZXulhVyvJ3gypMwCZT9z8ENYRZy/jYFHNoMYajibznrkvjNmd6MC0pV7ExK
         XMJmvZwOnu+zhnO2DbZo/TSGXx5qx98haNiqKAerctPbY8WCYshPcU1V/r7Qww1MvemJ
         OVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057044; x=1697661844;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P31EaSRln5Y8qXIhPg5k92XnAsV91qhf1ea5PLnQlac=;
        b=k9w+7ThAYLGFmtohJlJXMs0o0A37w11xIoJyL8JCJOzGAi1WlQ3ddy83FcYH9oTBVC
         p1Wht/VxO/JAHOU/PnVancxzFKDPQ0c9qmCVI7Y1JGyx/zL7qGoN+G/twI0K9ZEhHdwe
         GjWGcpvpAQj69eGLy0W5fVG5CzTRseykMTE08eO1TBgNNYoPZbUWBVQpG1VaXzE1YHWZ
         zY1ZCO0jmpY+bbKkVTuPV/yXtgp5cAE4mLDsGi0iCpxUIn8n7WBiUyyJSYhZrR/056SZ
         9m4MTZYFBf6ez6BfIEDk2zfoXykKz9KZK93puOIu6Xc9CIOMj8L14gxe9qhvFa7vFtLH
         nh5A==
X-Gm-Message-State: AOJu0YwsBgW2E0goV6l50DHeSFhihh2XgzmfApbS8oVvCwWgK2NCAti2
        YQJQ5uAIznwwiLGImAEybyA=
X-Google-Smtp-Source: AGHT+IFQxx5VCl8KKjK9TQ9WjcRa0ePH4vtXFloK3iDhSbfTnnC5mV9npmHSp/URant9nZFf6rq5pQ==
X-Received: by 2002:a19:2d14:0:b0:505:84c8:c640 with SMTP id k20-20020a192d14000000b0050584c8c640mr19445254lfj.48.1697057044063;
        Wed, 11 Oct 2023 13:44:04 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709064ed000b0099bd0b5a2bcsm10267065ejv.101.2023.10.11.13.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:44:03 -0700 (PDT)
Date:   Wed, 11 Oct 2023 22:44:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] gpu: host1x: Add locking in channel allocation
Message-ID: <ZScJEcoHQvi22Tg4@orome.fritz.box>
References: <20230901111510.663401-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EHUtb8eUTGdPEKmK"
Content-Disposition: inline
In-Reply-To: <20230901111510.663401-1-cyndis@kapsi.fi>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EHUtb8eUTGdPEKmK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 02:15:07PM +0300, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> Add locking around channel allocation to avoid race conditions.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/gpu/host1x/channel.c | 7 +++++++
>  drivers/gpu/host1x/channel.h | 3 +++
>  2 files changed, 10 insertions(+)

All three patches applied, thanks.

Thierry

--EHUtb8eUTGdPEKmK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUnCREACgkQ3SOs138+
s6GH+A//QmJ4c3RRvMjnASjZz/n6FJB1QRhFqjrBtygOt+15mW6zqGaL1XUoTR/c
q9PV84sXYyooWoVAp3IKa/hXrNhRxjsEwkxDTEetnvIi+ANSMe0I5gjIJDq40rdg
RClG6XT1sh9zD6ez8Uy++Ge5qOd2Kx8zMKZ56gsZ97pG15bXLjSMfbtGrT0Iq0R6
CdpKkDAQcKB1z+rikxt0pd+J36ibF+usXOM0HRz5Xfcz5Ssfy1c5Thp98MLYgaKu
i9akppvkAmWU7CPv/DzFDXdewtRfKA6FjGvWUMjY8oHJ8xHgiFpY/5DG+eD7DftT
lI4ngk4U4Vt+BfBgAooD5BfDEDgGAU0LSz7yK6WTAI3UZyPCw9moYw5LD3n2WtfO
LUI7I5IOiQKfvRGVxMY2t2EYNbRSb9Ti8gNUMobmoEmd2ZEPDOQh5Vv4O5yEs7El
R32rNJlaz+AoL3ojbNwu570XvDJL1H5sgzHG4Oo+DSP8Id4zEx4KIDcu8MevFhXh
UETZvCd4DkQaLRxuw65IgRwr+PdO3IpQWP4LbVzEFlLHmEeZaUqU0E9C5aA3E90t
fykEqYDr9BA79V2lox+KamGcq2ZeCrGZ62JCM3boB7y2zmFFulHTgIuA7rmZo0Iu
dHrlYhTNsHMg4059Ty7qQwSr4Ez5I3Fwa2BC2W5Db5sb1LbnHqg=
=8Scw
-----END PGP SIGNATURE-----

--EHUtb8eUTGdPEKmK--
