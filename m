Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3017BED6C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378684AbjJIVe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377082AbjJIVe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:34:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024F399
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:34:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32ccafde8e0so63281f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696887263; x=1697492063; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TNDOsSTch3MMqY9kI8wZmkDm7oCLtJgQ3JvcvKno3Xk=;
        b=AeFdfRH2A57T4/Ind1J2OAz17EJ+TzsBjleBgdiOaWT3jiYKDmYDPqhujd+axT0ChY
         esZ3u2Mh5/9yFROiB74Kguln/GyprBItwRqWGqwgaHnw2ZAHG3Qp9+pQLSpmcifQrN9W
         GUC5O7ds5PvNtb8nBFl3eLFl7Q7wOMKyxtcxU879GbOCG89/iXxAVy+cIbQPelti9PV6
         KPpJQkmLMfNWuL9jgrx7yQ7SLiUWij6rS1HCIDJyzFjXrXs5L9FYxwZx8IFZ8ndkaYnQ
         HOMjZt5jsR1o5hB+dfJuYp9QyTr2+dqEYYX5b0TcPlNh5rJG5K/GsUcimDeiKNH08hUQ
         f1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696887263; x=1697492063;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNDOsSTch3MMqY9kI8wZmkDm7oCLtJgQ3JvcvKno3Xk=;
        b=tZ03oq6gx27+Iy47o0cmKYZakl4MsT5ur1AR1mTkAje/VjV/ozhgjxeOFvJ6TSKWZu
         Mot9K3wL883JmW+PBXu8Rvl/muFkp6lTo6wp2yIjTuFTMvkzz+qb41BKdSqOM8AnOIbz
         aUEV1T9OfsJUWpl9wUoeoZfeYS7+7rdCxQwtkwK5zd9ItJvmA/0P3SUzwodCsZnlciKG
         FtrZMDzgvvXY1RzAfTkgRolMztguC/E7OcVFE536zoJudo5VRSLGxXn7rKPI1R9NBwrA
         SMb0a0tOhAd+ihTD8O87Att3DwRPKqig2iEQyLOcsMI5FnpJRMvHtl+z4PeP7XTrosoE
         SD7Q==
X-Gm-Message-State: AOJu0YxG/oG9FsxTCcaAp/PEl3fQu7l2sg+Vd73fuhzPR3CTorBT+QII
        ElYElcYyW8RK0VJiGzwGOJ8=
X-Google-Smtp-Source: AGHT+IEp21rPlfxlwCIL6YcK9L2I+Ff5iswt4GDSRJHG16laa4xoz7a4kSqpkc/aog/kf6l9kHP+bg==
X-Received: by 2002:adf:e604:0:b0:31f:fdcf:b2b6 with SMTP id p4-20020adfe604000000b0031ffdcfb2b6mr14520504wrm.55.1696887263095;
        Mon, 09 Oct 2023 14:34:23 -0700 (PDT)
Received: from dell.localnet (77-255-201-154.dynamic.inetia.pl. [77.255.201.154])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709062b0600b009b29553b648sm7188210ejg.206.2023.10.09.14.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:34:22 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: ams-delta: Allow it to be test compiled
Date:   Mon, 09 Oct 2023 23:34:20 +0200
Message-ID: <13421748.dW097sEU6C@dell>
In-Reply-To: <202310090122.Yp9JndiQ-lkp@intel.com>
References: <20231008135601.542356-1-jmkrzyszt@gmail.com>
 <202310090122.Yp9JndiQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23960251.ouqheUzb2q";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart23960251.ouqheUzb2q
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] ASoC: ti: ams-delta: Allow it to be test compiled
Date: Mon, 09 Oct 2023 23:34:20 +0200
Message-ID: <13421748.dW097sEU6C@dell>
In-Reply-To: <202310090122.Yp9JndiQ-lkp@intel.com>
MIME-Version: 1.0

Dnia niedziela, 8 pa=C5=BAdziernika 2023 20:03:21 CEST kernel test robot pi=
sze:
> Hi Janusz,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on broonie-sound/for-next]
> [also build test ERROR on linus/master v6.6-rc4 next-20231006]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Janusz-Krzysztofik=
/ASoC-ti-ams-delta-Allow-it-to-be-test-compiled/20231008-215910
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git=
 for-next
> patch link:    https://lore.kernel.org/r/20231008135601.542356-1-jmkrzysz=
t%40gmail.com
> patch subject: [PATCH] ASoC: ti: ams-delta: Allow it to be test compiled
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231009=
/202310090122.Yp9JndiQ-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231009/202310090122.Yp9JndiQ-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310090122.Yp9JndiQ-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
> >> sound/soc/ti/ams-delta.c:401:24: error: initialization of 'void (*)(st=
ruct tty_struct *, const u8 *, const u8 *, size_t)' {aka 'void (*)(struct t=
ty_struct *, const unsigned char *, const unsigned char *, unsigned int)'} =
from incompatible pointer type 'void (*)(struct tty_struct *, const u8 *, c=
onst char *, int)' {aka 'void (*)(struct tty_struct *, const unsigned char =
*, const char *, int)'} [-Werror=3Dincompatible-pointer-types]
>      401 |         .receive_buf =3D cx81801_receive,
>          |                        ^~~~~~~~~~~~~~~
>    sound/soc/ti/ams-delta.c:401:24: note: (near initialization for 'cx818=
01_ops.receive_buf')
>    cc1: some warnings being treated as errors

This is the error I reported and fixed in the recent "[PATCH] ASoC: ti:=20
ams-delta: Fix cx81801_receive() argument types".  This change just=20
exhibits that error, still present in trees without that fix.

Mark, if you are OK with this change, could you please give your ack, like=
=20
you did for the fix?

Greg, since you already added that fix to your tty-linux tree, commit=20
b3fa3cf02e3c, could you please also take this patch?

Thanks,
Janusz

>=20
>=20
> vim +401 sound/soc/ti/ams-delta.c
>=20
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  =
393 =20
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  =
394  static struct tty_ldisc_ops cx81801_ops =3D {
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  =
395  	.name =3D "cx81801",
> fbadf70a8053b3 sound/soc/ti/ams-delta.c   Jiri Slaby         2021-05-05  =
396  	.num =3D N_V253,
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  =
397  	.owner =3D THIS_MODULE,
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  =
398  	.open =3D cx81801_open,
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  =
399  	.close =3D cx81801_close,
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  =
400  	.hangup =3D cx81801_hangup,
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29 @=
401  	.receive_buf =3D cx81801_receive,
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  =
402  	.write_wakeup =3D cx81801_wakeup,
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  =
403  };
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  =
404 =20
> 6d7f68a1eab3d5 sound/soc/omap/ams-delta.c Janusz Krzysztofik 2009-07-29  =
405 =20
>=20
>=20


--nextPart23960251.ouqheUzb2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnyr6IsGnTYAeAkHJ2WqSnltsjBoFAmUkcdwACgkQ2WqSnlts
jBpG1gf/Xf4UDGXaQO6w4A4PbxFkumCYro0do9ngRH668OOuaTn//xqnKsziL5mS
gRCV3IF60YSwaVHBF3AU4S8PNDTugigA+w+jqXViYDa1AhFqB7S4SvlT0c7Gt33S
yu4vDHnZvd4bpXQdqCMUcVkBpFHEboXor/j7oKOIyf51EF9Zn503mFWeqwA8Z7tm
iEAWcQPIaforwJBnNrIf79Q2K1cnmhVX7DaUqJFknWRR9sH+ZIBBZhpqL4nAVk2j
ep9un8kB7Q3WWH00K9MUS5P33IVUQk65g/0CVsAK7fDvYnaeTLgeTWRGrZYyGTTt
TYsrbGjitpvPKDEl4h1IOkKi3gU0lA==
=8g9/
-----END PGP SIGNATURE-----

--nextPart23960251.ouqheUzb2q--



