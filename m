Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905ED7C5127
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjJKLKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbjJKLJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:09:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EB6E4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:09:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bff936e10fso9535491fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697022549; x=1697627349; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJMXxiNJ469KGf6nCkSfy2mUYvFcRBuHmMRl5nRn1Ns=;
        b=YRH71+SyZiaqMUfQ2l+Im/sGFK4fsdEw5ydsYihb5RJLga3suEpJvnn1nBsG0huNz/
         MzLl8jfYCJPwHyNbQRB0MZAAAe6WdgUGPzwfDSiY4fi+eloDaCUY6JDgN5Smu61Ufq0D
         Z4wCRPMwH9Rojyjqvnu+FrC+9bVHxiUu8afbU+AkiKV66WHhch9M1PFp0k8dV66rgOQC
         DcmQHQrIZWpEBZ900FOlygI4UtQDjeGSrWwrGrVBQe3fzpYB0AcFy21jd4MoPyZXJ2Do
         AfvstQPV/DEVcou62IAIn28K/0ovOVT0PbDjidaHf5l9r+ZwNTRt56ZI+cjS4+IHO9Y9
         gJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697022549; x=1697627349;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJMXxiNJ469KGf6nCkSfy2mUYvFcRBuHmMRl5nRn1Ns=;
        b=etfvBsXePw9l9KyM+DzJ147H+LA2pw6n9Km5kODgp+eOXRZi6dt7IBrG6PzD4CybHc
         aA95doRPu6zOLadIXHKC2iVdLQ0TotdFk5SNVjfKWTFDW+BXIFbaANId080Zv4rHK0zF
         U4AIs86YhwL2SE5yJW2FYecyyaxE5DOaQjhgHLvmuTAML0zoIwdoZHjIYxpSj602xzQ3
         8d1wgk2OlwuyG1vgVfrlgPLrV1d28dVtQKV5nlM8Ed8FS10Drc2Hg03KxVhPcCkfH2ln
         o4qPt5JluKosYDrEGKjpKtK0xmJwo5aO0+DV3kZvnVPw+rX36v8tBm8Pqu9/lDFVC6DK
         yYuw==
X-Gm-Message-State: AOJu0YzIeT1G+ZyIJaB+vUUqY9DUxcesiqhfjoqlVt89aTJDvUCD+sLy
        BKipgkqHnr1Q3U08nBNBxh4=
X-Google-Smtp-Source: AGHT+IGdCwoG9HectUVZMG69OA4ZIwUr3rpuNWx9zPFIwujKW5EAAg1ZWCMvTBk1SRQ4ZAV1qX+JjA==
X-Received: by 2002:a05:6512:2308:b0:4ff:839b:5355 with SMTP id o8-20020a056512230800b004ff839b5355mr13937689lfu.18.1697022548448;
        Wed, 11 Oct 2023 04:09:08 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id m6-20020a195206000000b005047a395f24sm2208822lfb.214.2023.10.11.04.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:09:06 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:08:52 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [RESEND] kernel/reboot: document function parameter
Message-ID: <ZSaCRLZDkOknRTDg@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4s2hUWAzs/TTeFOf"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4s2hUWAzs/TTeFOf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The hw_failure_emergency_poweroff() has been documented using kernel
doc. The documentation omits description of the function parameter
'int poweroff_delay_ms' - which seems like self-explatonary.

However, the build bot is nagging about the missing parameter
documentation, so add the trivial documentation to shut the bot up.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309040349.HLOK1O5I-lkp@int=
el.com/
Fixes: dfa19b11385d ("reboot: Add hardware protection power-off")
---
 kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 3bba88c7ffc6..c7790711242d 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -940,6 +940,7 @@ static DECLARE_DELAYED_WORK(hw_failure_emergency_powero=
ff_work,
=20
 /**
  * hw_failure_emergency_poweroff - Trigger an emergency system poweroff
+ * @poweroff_delay_ms: Time after which the system is rebooted. In millise=
conds.
  *
  * This may be called from any critical situation to trigger a system shut=
down
  * after a given period of time. If time is negative this is not scheduled.

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
--=20
2.41.0


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--4s2hUWAzs/TTeFOf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmUmgjgACgkQeFA3/03a
ocUsiwgAivTqTyJ+gR9KQ9eS+82HuGeKdeC97ilu60PYqANfyIYocGfPD4rSl88D
L3rtIZHCZuCDzlxGuTvJehn8JdoFM1cRvs2//wsuGH2doP/PJuRTrR/W6Pt53lGR
7LZ5tzhKWf1sBqVIYxrDLlAo/7SPfsIIHgC6RAHl8Xs44LYsJv5zD3Cdz0vyUWyZ
b3uzTEAlMkVhUPXMevFUMzXheTDE3m0MFcnePLSrP2qqnu4P4FUmeDWJYI1J72bA
8kME4Ivic2eif13TkqruZDwBPUixm5qXDSnsW2mnyQ9J8n0qW3xTCCPwG+/p8s4J
AKwCUQkZZsfxHtGIec7f+cTyGdlKPw==
=+26K
-----END PGP SIGNATURE-----

--4s2hUWAzs/TTeFOf--
