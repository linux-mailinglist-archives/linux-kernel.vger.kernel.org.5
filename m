Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960327F90A4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjKZBOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZBON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:14:13 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA4FD;
        Sat, 25 Nov 2023 17:14:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cf8b35a6dbso21890845ad.0;
        Sat, 25 Nov 2023 17:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700961259; x=1701566059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/y64aIIFuJQcFEqdYvuTbOB4txWgZi66KcW7TCOECw=;
        b=El8plglo4ap3FzYBX6SXv1taVv4p09poHkJuqJtPnYPIyQxv5d3lzhjiJEBZVKbu8e
         aPct6x7GzgiJNkhJM76X20/pHaTRMwZ6CCiWo5gXvyfq5p4SUfr40KylLKNhK5j5YoQk
         QL1jcI3PAhUUH33jHSuYPU/CYiamemnammy7lXq/lJAJhWCXpj2dnOQmP0lbso7Um1G0
         HcfqCtWuSdOOTkoKZ3IzUpSiUykVpVb230xdP89dWGecjqs34la5Vn0vFu97vne7Ucvb
         Ik9c2f5KFCDwRDNl4WH/lAdLusksx2RdmYqkMmDu8VUCXoBJjFRjAR2pHxYcq8U5QMI0
         M6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700961259; x=1701566059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/y64aIIFuJQcFEqdYvuTbOB4txWgZi66KcW7TCOECw=;
        b=MZZigTg5fHclKgD2tmUvsCFM9aCWySnmA2j82fBpAW5hQJuy17P8gFsAgxWTATc1VV
         V69nnnwvur8JujpPrZCMLz/biFP/Ggx+rbx1ptl5r6zEx7Z1eSD3FZ0FHmTCYKF4+05d
         7JKL+L7fEgv2yu6W5PvShHCe0fxiPKHJVW/OjZpDDLNSGWD4/+eussAykRXcerrBmkAs
         90pGYlotUxwWb9y6wnS3ifJJKueYuG+jlgmyFaxU4hhkgceUFoenAuP5yk9xO0GQwPaD
         3/BdXz/7dBYzlX1PtKGWs1IeuccS+2v6lLOCOY6KPolWodu9Ev7Ne27g+UINUfLRZMuT
         7aRQ==
X-Gm-Message-State: AOJu0YzGp9yKsFLa1ONLnPD5Bf+Y2/aikX+Zo10btcI03THANf5a6W33
        gl6OJlYALAiY/7AYwuEmVBQ=
X-Google-Smtp-Source: AGHT+IGYQo4PLQcBfKODLgFJ6Bq3Wx1172kTCKprXL8fq4ot6eMl4+dVLhKl8+q/JgIhv6Qcdx8g+Q==
X-Received: by 2002:a17:902:e744:b0:1cf:bd98:633b with SMTP id p4-20020a170902e74400b001cfbd98633bmr1779707plf.64.1700961259410;
        Sat, 25 Nov 2023 17:14:19 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b001c55db80b14sm5509190plg.221.2023.11.25.17.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 17:14:18 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 922CF10205C41; Sun, 26 Nov 2023 08:14:15 +0700 (WIB)
Date:   Sun, 26 Nov 2023 08:14:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Joey Gouly <joey.gouly@arm.com>,
        Linux Kernel Hardening <linux-hardening@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regression@lists.linux.dev>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bill Wendling <morbo@google.com>
Subject: Re: [BUG] Boot crash on v6.7-rc2
Message-ID: <ZWKb56E2kKngcWW5@archie.me>
References: <20231124102458.GB1503258@e124191.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5Hmfvs539k+85674"
Content-Disposition: inline
In-Reply-To: <20231124102458.GB1503258@e124191.cambridge.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5Hmfvs539k+85674
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 10:24:58AM +0000, Joey Gouly wrote:
> Hi all,
>=20
> I just hit a boot crash on v6.7-rc2 (arm64, FVP model):
>=20
> [    1.418845] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000517
> [    1.418855] Mem abort info:
> [    1.418860]   ESR =3D 0x0000000096000004
> [    1.418867]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    1.418876]   SET =3D 0, FnV =3D 0
> [    1.418882]   EA =3D 0, S1PTW =3D 0
> [    1.418889]   FSC =3D 0x04: level 0 translation fault
> [    1.418897] Data abort info:
> [    1.418902]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> [    1.418910]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [    1.418919]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [    1.418928] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000881835000
> [    1.418938] [0000000000000517] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [    1.418952] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    1.418961] Modules linked in:
> [    1.418969] CPU: 0 PID: 8 Comm: kworker/0:0 Tainted: G                =
T  6.7.0-rc2-dirty #4191 40d10cdc812c74fd5dc5d91e2452ff6f1e5f4b4a
> [    1.418984] Hardware name: FVP Base RevC (DT)
> [    1.418992] Workqueue: mld mld_ifc_work
> [    1.419003] pstate: 101402005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTY=
PE=3D--)
> [    1.419016] pc : ___neigh_create+0x790/0x9c8
> [    1.419028] lr : ___neigh_create+0x270/0x9c8
> [    1.419041] sp : ffff8000800c3a20
> [    1.419048] x29: ffff8000800c3a20 x28: ffffd7c64c921078 x27: ffff00080=
188bd50
> [    1.419066] x26: ffff00080183a30c x25: ffff00080188bda0 x24: ffff00080=
183a300
> [    1.419084] x23: 0000000000000000 x22: 0000000000000010 x21: ffff00080=
188bcc0
> [    1.419102] x20: 0000000000000000 x19: ffff0008003ef000 x18: 000000000=
0000014
> [    1.419119] x17: 00000000cf0f2572 x16: 0000000080faa78d x15: 00000000b=
79921ac
> [    1.419137] x14: ffff00087ff332c0 x13: 1600000000000000 x12: 000000000=
00002ff
> [    1.419155] x11: 000000007c2c4dbd x10: 0000000000000003 x9 : 000000000=
0000000
> [    1.419172] x8 : ffff00080188bd80 x7 : 00000000be3df655 x6 : 00000000f=
1691d6f
> [    1.419190] x5 : 000000007c2c4dbd x4 : 0000000000000000 x3 : 000000008=
eb8ab5b
> [    1.419207] x2 : 000000000000050f x1 : 000000000000001d x0 : 000000000=
00002ff
> [    1.419225] Call trace:
> [    1.419230]  ___neigh_create+0x790/0x9c8
> [    1.419243]  __neigh_create+0x18/0x20
> [    1.419255]  ip6_finish_output2+0x5f8/0x8c4
> [    1.419267]  ip6_finish_output+0x1f0/0x258
> [    1.419279]  ip6_output+0x70/0x1cc
> [    1.419291]  NF_HOOK.constprop.0+0x4c/0xd8
> [    1.419302]  mld_sendpack+0x1b4/0x394
> [    1.419313]  mld_ifc_work+0x1d4/0x4b4
>=20
> I tracked it down to the following line in net/core/neighbour.c ___neigh_=
create:
> 	memcpy(n->primary_key, pkey, key_len);
>=20
> I did this by surrounding the memcpy with BUG():
> 	BUG_ON(n->tbl !=3D tbl);
> 	memcpy(n->primary_key, pkey, key_len);
> 	BUG_ON(n->tbl !=3D tbl);
>=20
> And it was crashing on the second one.
>=20
> Checking `struct neighbour`:
>=20
> 	struct neighbour {
> 		struct neighbour __rcu	*next;
> 		struct neigh_table	*tbl;
> 	.. fields ..
> 		u8			primary_key[0];
> 	} __randomize_layout;
>=20
> Due to the `__randomize_layout`, `primary_key` field is being placed befo=
re `tbl` (actually it's the same address since it's a 0 length array). That=
 means the memcpy() corrupts the tbl pointer.
>=20
> I think I just got unlucky with my CONFIG_RANDSTRUCT seed (I can provide =
it if needed), it doesn't look as if it's a new issue.
>=20
> I couldn't reproduce directly on v6.6 (the offsets for `tbl` and `primary=
_key` didn't overlap).
> However I tried changing the zero-length-array to a flexible one:
>=20
> 	+	DECLARE_FLEX_ARRAY(u8, primary_key);
> 	+	u8		primary_key[0];
>=20
> Then the field offsets ended up overlapping, and I also got the same cras=
h on v6.6.
>=20

Thanks for the well-handled regression report. I'm adding it to regzbot
for tracking:

#regzbot ^introduced: 1ee60356c2dca9
#regzbot title: Boot crash caused by true flexible array warning
#regzbot fix: neighbour: Fix __randomize_layout crash in struct neighbour

--=20
An old man doll... just what I always wanted! - Clara

--5Hmfvs539k+85674
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWKb4wAKCRD2uYlJVVFO
o3v8AQCzt7rgIarKQqzj/B/2EhfxNDrdWb72QbQTgt3iu7rZfAEAw5hbmG8YNctp
YSjTe8uJ2MlH9+1YPx3hqxUFlr4Fogw=
=/ICY
-----END PGP SIGNATURE-----

--5Hmfvs539k+85674--
