Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E94792B46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344230AbjIEQuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353781AbjIEIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:08:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BD9100
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:07:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bcc331f942so26512391fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693901276; x=1694506076; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ma+7JLUHyVlK04Dce8XthTm49y1bESjTFBoz9rmZnOc=;
        b=L2zAxz7tSUi4DzAd4Cutukc4jjzqlGJRKSNSjyWPpCk5gEO90cMCKKoMxERRG8gijt
         uQE6abh6e9LIpSwcJ1GH6AV3SM95a2S1XEHMfLyQmzKJDu8GVnQ0RSO/hyA/aNLTwCKL
         aN/h+8rYKlaA2LUqjbrG8K450T5FOjWGFTmfO3B7FPSG7oMQyiaW0IkSLary3ypr/zB9
         JPe4R7+27LZSOIVBHv4Gr5fwobD/dIr8sgOS+c63I+jtAlV+ZD1I0HtyUFz+IrC8l2Od
         LTnLFGayF0YOpDS0i5XyQ1YauCaTuzIR2fPUWkNMTzkUG7jEFjWQfT+ZLn2876b51JAV
         xmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693901276; x=1694506076;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ma+7JLUHyVlK04Dce8XthTm49y1bESjTFBoz9rmZnOc=;
        b=kJKw2owfmF7zt7vW5rPVAcz/lgUX4s/kvL2LNytLjpVS9VIOwDMLREC7+aV/n/hDSp
         y1XuPpkOT8aF1YF7WoScsYQbQLyGO4ZxFxL4qDhVLrZ+Clv2RZW/JtZ+wDKm8uDBRTMg
         y0H86EURFKK83CEq42IO5CHX9T63OOfCXwQtCLCA4uFZBtVOBCWf+NDMmnZKTd3P7Ucp
         rQNKdQLxKQIltXS2OCNfJUWNr4zZQGFDa+wBDL0eVCluPyTzue1jEIhxsmzrF3/BqPj3
         Ba1r4E2QQIzJq3Pb3A1Q8jEJqwA4Hg2iKHpD2laHe9f9ghM4/blkg1gT2oNo3TL4Liis
         j3yw==
X-Gm-Message-State: AOJu0YzCzjU6vsg5qennTyBfnTqBLACVory9CmVN27xxB/nUcJ4WV1Gy
        TE90GV0p2V9buuBKyz99vHQ=
X-Google-Smtp-Source: AGHT+IGpsqQ2A1eJn/Cf4Rq168e6XS6jqYpp0FfqYQlQF0jeh1hyX6qZeULecuGShcKKWpBS/A77mw==
X-Received: by 2002:a2e:80c5:0:b0:2bc:dd8f:ccd7 with SMTP id r5-20020a2e80c5000000b002bcdd8fccd7mr4184556ljg.16.1693901276013;
        Tue, 05 Sep 2023 01:07:56 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::3])
        by smtp.gmail.com with ESMTPSA id j15-20020a2eb70f000000b002b70a8478ddsm2746747ljo.44.2023.09.05.01.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 01:07:54 -0700 (PDT)
Date:   Tue, 5 Sep 2023 11:07:41 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/reboot: document function parameter
Message-ID: <ZPbhzchX59rwEj2L@dc78bmyyyyyyyyyyyyybt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AbN3uFc/OUz1Bz9c"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AbN3uFc/OUz1Bz9c
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

--AbN3uFc/OUz1Bz9c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmT24b8ACgkQeFA3/03a
ocW2hwgAwdMbmnDRrhKXnNq4d4IB2rHK3ASkBsIRR96ZbXiTLDYGA24nAjjsiWSR
W8uB8iCMwY+exjFlHfWX7+SzIUHwVL17nTSNN/e7sJT2SWBIZszX+T8iI863LiaV
GCLJgyM/fiUcanQLDuQX0wyxWrUooiD1fG83foChnhpgjCHUoGecgQk4UilebT30
ug6MngJCUemgl14vMBLS3Hx43NNHwUEEXecArgnfMoAq9FuTYh6VFEpIiMwnCr7e
Q9pSzzdaFAUvkZ3Vn4BROVmzHYeOAv20Jnj0/BtO5jqZnrwzwp+rzHMphVYd9o+Q
oB8ml2pmJHzSQqF5adU8f8vZIcDGNQ==
=/w1A
-----END PGP SIGNATURE-----

--AbN3uFc/OUz1Bz9c--
