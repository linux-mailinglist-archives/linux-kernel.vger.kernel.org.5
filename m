Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875DF7F0CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjKTHSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKTHSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:18:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E68A2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:18:48 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso5603965e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700464727; x=1701069527; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRhnT6SBAvyFzdcnWB9ep0kLqDtC5zY+wmDjKO7YL10=;
        b=T7V1SGgVnPRHXVRgB5c2P6wOqD9E6r6JcUSimRQla7H8EUEw7VnuWbXhrntZfRUnS7
         OVcB0TY7prlhNzcmcxHiiUBB1O3M4Tn3LGm5oPQrLPaqu91sx0mmLx//zqbiUZi5MKIm
         mv/lG9TnWKnSCBOb9Z/EwGPymlq6SsBgc6Qd1iJo0HzNscA1KQo7vs8vsz8hqjZuWn5Y
         lRtdgTy3b2P2hN8WBUvUAOFRsB4xJjfIdQPB7KQyWypkTKzE4wvz7SOIn9wMODYrHW/6
         pa5r4rZVpq0PrMN8m5Zuc+RPeTr/ODqfpmFBJ2fYWAmgwVtbqlMAdtimSHKbBywKe1HY
         WB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464727; x=1701069527;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRhnT6SBAvyFzdcnWB9ep0kLqDtC5zY+wmDjKO7YL10=;
        b=JJOLLdgl+Ic1txQDG2aXppoXH0WZbGJBf5nYagvA4268/2sGf2snhu3wmX8uutamUq
         NxxTnEj+9of0RpFguLeuNmbO+KdG0lr70TYxidXsGU6hxConnNgzePddKuhNamr+3HHj
         1/JgEV69hMV5bQSsO0Fk2mtdAvrOT9wKfI+FSuZFhEpDuYWHicd+b/Lm0o1Iy7AGZIz/
         eDolPzkyy4JDcVtjmP/OHsoW3cE7DVPzI8gMKlfXFSUvS/a4SGDDgm0Qffg85vcltKUo
         K68L35H+Px/mH43iJsTcgt1S0o7cM7uCmFINrKOTUnJOmjQtaLz4Qa+kHL1fMUZV4JJO
         cx3Q==
X-Gm-Message-State: AOJu0Yxhl7/iR049um+/xrLzdGsqD7uEdWjHjXt01u8W+H4k75+uec6N
        ASjDdMbiSY8YQPNkdL1jxCI=
X-Google-Smtp-Source: AGHT+IEt86LFOUVPu1Nd6G7IZQLRL7Xvx9niu0K7c9CgoHfjWYave10KoKyu5fUihnoBNAZePpJMVQ==
X-Received: by 2002:a19:c511:0:b0:502:ff3b:766f with SMTP id w17-20020a19c511000000b00502ff3b766fmr5421313lfe.6.1700464726800;
        Sun, 19 Nov 2023 23:18:46 -0800 (PST)
Received: from dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id b30-20020a0565120b9e00b0050aab2f368dsm439880lfv.37.2023.11.19.23.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:18:45 -0800 (PST)
Date:   Mon, 20 Nov 2023 09:18:33 +0200
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] kernel/reboot: document function parameter
Message-ID: <ZVsISf/QVZ3QsHFx@dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tdi0yUQpaZUSAj32"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tdi0yUQpaZUSAj32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The hw_failure_emergency_poweroff() has been documented using kernel
doc. The documentation omits description of the function parameter
'int poweroff_delay_ms' - which seems like self-explatonary.

However, the build bot is nagging about the missing parameter
documentation, so add the trivial documentation to shut the bot up.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309040349.HLOK1O5I-lkp@int=
el.com/
Fixes: dfa19b11385d ("reboot: Add hardware protection power-off")
---
Mark, would you pick this up? (Excuse can be that the regulator framework
uses the emergency_poweroff) Or any suggestions who should I CC? This
has fallen through the cracks for couple of times already and I suspect
this belongs to no-one specifically.

 kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 395a0ea3c7a8..2e5fd997d49c 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -944,6 +944,7 @@ static DECLARE_DELAYED_WORK(hw_failure_emergency_powero=
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

--tdi0yUQpaZUSAj32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmVbCEMACgkQeFA3/03a
ocXnXwf/fFk/4B6s6QIC9uSQ3vOrKn5UDmOPBinE9hzBb47fQ4WSbytwe/4DAkFU
K/lYCjgPH6r6XermpsMaY36eCYT7k4FRAfV726jWS+he4gyK9h+YngoDc+eEMuZw
jvMHBLkDA6ZgX9EGDjEjseWKckc7c0DlQTEToZVb3swo+NAO/FS0M2Zeg0j+UYbf
NCPnqrVOScGtOXxR8zleVKtJc420IPszkLz+Lm3n4fg/YEMfBYYOiLY0hcj5qpOP
zA5JkrnDpG2XsIaGdOwNqxgD/GmG2B4bxARy+DBnxmwNsaYdwZRj+f3A50DBYVyX
6OktA12IDCkvv+Mi3vgwFazJkS8Ujg==
=oVMn
-----END PGP SIGNATURE-----

--tdi0yUQpaZUSAj32--
