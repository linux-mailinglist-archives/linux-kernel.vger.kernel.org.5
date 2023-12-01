Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E828C800C6E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379036AbjLANne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379035AbjLANnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:43:33 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24F1171A;
        Fri,  1 Dec 2023 05:43:38 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bc22c836bso3065864e87.0;
        Fri, 01 Dec 2023 05:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701438217; x=1702043017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9OwuQJSOXjrOdfbj5sQ0Qx3CiHR7kZcKuli9ggq/7fA=;
        b=SC0nKEvyOdfV42Ld6Y/T1X+zWIuioWYretk99zs/f00BEQDW/8NOQBPYuoPUiBzixO
         0RPyge9GVuH5oj34KQYjwr64olGOZByHY9BnLkxCSSBdA/BHYj6idawkI+UepU4ZrnSz
         9smUDg+fJ30TsXK7cB/XvWqbDh6XtJFOxoytgn+6ItPehfBxxcel8Pc4SLRrqyoeIHRN
         xTLqd2dp9IIgmfun2On20IQ6ru0ytipCDm3aw0Tt6nIqIX+MWakdPbdoU7zopqG6ABcu
         T/LPKQ+A0JzLG1k28JCtdr2lvW2TGXT8HuAMT9ystzNo/i6yK1V6bCGsW0dIstzjDzty
         gSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701438217; x=1702043017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OwuQJSOXjrOdfbj5sQ0Qx3CiHR7kZcKuli9ggq/7fA=;
        b=JdoI669+6ga7i/c7Ls304CCI5gbden7XxedrbKLYqQob3vtqIY+uOnbTu4HeeKKy3B
         jigZ7xQfpuiSmrR7pEXwJs4bj9r3XI/MH2LJQTaGCMRMWYjnSmZFCf9LtZpBi/A+Uc+V
         bmnMtbotgsht2+H02tYRA6bia6rcV6wRL0uXHSzcuL8kAvj5aPVhM4kgZd6rQhMQjfyl
         s0ByemNrbRDRv5bKqULt6JMkgdK4eVvubAKmqoCq6fhLMIBBWVNIfvQUGYTpSE0sNd4d
         knipH4F1e5obtm3T9qEtI/XXCUzevc6S/p8XN59hzt9VC0dA5FGyzrI2YZPyJkoShhZW
         Cu4w==
X-Gm-Message-State: AOJu0Yzak0yjCIrL6chLLhNPcV8DLPM0Tbg1UwkPQQAaQM/SDL7BdlO/
        P4hKRoKJTUDU39fDrIUVJKPINtNkUDs=
X-Google-Smtp-Source: AGHT+IHCJSo697bipzIClt5iEyV3Ndb+eworhBOfHy+XLwOg96uE68SDl85M9yciK5pjUp2bXczqJA==
X-Received: by 2002:ac2:4f05:0:b0:50b:d764:6ec4 with SMTP id k5-20020ac24f05000000b0050bd7646ec4mr1200398lfr.116.1701438216683;
        Fri, 01 Dec 2023 05:43:36 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25e73000000b0050bbb90531esm426867lfr.155.2023.12.01.05.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:43:35 -0800 (PST)
Date:   Fri, 1 Dec 2023 14:48:06 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: pxrc - simplify mutex handling with guard macro
Message-ID: <ZWnkFjFeEV7y9tUr@gmail.com>
References: <20231201-pxrc-guard-v1-1-38937e657368@gmail.com>
 <ZWnfsjIukIbAvQ-l@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nfy3sN/Smg4PYgnm"
Content-Disposition: inline
In-Reply-To: <ZWnfsjIukIbAvQ-l@hovoldconsulting.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nfy3sN/Smg4PYgnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 02:29:22PM +0100, Johan Hovold wrote:
> On Fri, Dec 01, 2023 at 01:08:45PM +0100, Marcus Folkesson wrote:
> > Use the guard(mutex) macro for handle mutex lock/unlocks.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>=20
> A couple of drive-by comments below.
>=20
> > ---
> >  drivers/input/joystick/pxrc.c | 27 +++++++++++----------------
> >  1 file changed, 11 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxr=
c.c
> > index ea2bf5951d67..3c3bf7179b46 100644
> > --- a/drivers/input/joystick/pxrc.c
> > +++ b/drivers/input/joystick/pxrc.c
> > @@ -5,15 +5,17 @@
> >   * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
> >   */
> > =20
> > -#include <linux/kernel.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/errno.h>
> > -#include <linux/slab.h>
> > +#include <linux/input.h>
> > +#include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/slab.h>
> >  #include <linux/uaccess.h>
> > +
> >  #include <linux/usb.h>
> >  #include <linux/usb/input.h>
> > -#include <linux/mutex.h>
> > -#include <linux/input.h>
>=20
> Looks like an unrelated change.

I reordered the include files as I added cleanup.h.
I can do it in a separate patch if that is preferred.

>  =20
> >  #define PXRC_VENDOR_ID		0x1781
> >  #define PXRC_PRODUCT_ID		0x0898
> > @@ -89,25 +91,20 @@ static int pxrc_open(struct input_dev *input)
> >  		dev_err(&pxrc->intf->dev,
> >  			"%s - usb_submit_urb failed, error: %d\n",
> >  			__func__, retval);
> > -		retval =3D -EIO;
> > -		goto out;
> > +		return -EIO;
> >  	}
> > =20
> >  	pxrc->is_open =3D true;
> > -
> > -out:
> > -	mutex_unlock(&pxrc->pm_mutex);
> > -	return retval;
> > +	return 0;
> >  }
>=20
> Eh, this looks obviously broken. Did you not test this before
> submitting? I assume lockdep would complain loudly too.

Sorry, it is more that I'm not in the habit of using b4 for submitting
patches yet, so things got wrong.
There is a v2 out there.

The driver (v2) is quickly tested on HW and, what I can tell, seems to beha=
ve.

>=20
> You're apparently the author of this driver and can test it, but I fear
> the coming onslaught of untested guard conversions from the "cleanup"
> crew. Not sure I find the result generally more readable either.
>=20
> Johan


Best regards
Marcus Folkesson

--nfy3sN/Smg4PYgnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmVp5BIACgkQiIBOb1ld
UjLsbA/9EqT6TP1FGnNnbx5pd+KL2UAh2cVOe6E4MP5MkjONSbP87J5ass1rtOLE
j8er6xjoOtR3d/wZaamd01jEbdDPX2ptJVNfDxQmxJ/ExQ/r7Ohn1UW4eJd4ZxHM
o6FuX8yhkHL9fKmdxVFTAZkeYFOBa97fSDfyYYcUAWxxoS6kiR1zOPPXyvJAs7Kk
8OGig9dvNM+zi+G4XTisVwLL0X5Qy4U2mbh93DRUkiS6y7GguurFJ2e1Naa6BEG5
1EVzg+j3jpZh+8OMmSAgbk8IlfbeZVK6lAI0ewAJKTrbB31MWXZ/vnxNlq64u0d6
SRBdV3y9BgCKzu4xzv3YYgwfw3Tj4D382Cutdq3Tm7lNnpPvKU3iXPnnVTtX/hOU
F6MxiqM5VL+d+jeAzfJIXgFwsJqHv9CkWOphMxa+r/r2vr8622HSIBYZ3vqBJnz4
kPYQOq0ZLsFLRb6NGj4UvHhT/Jjr7HLndCOt41qauoWbuaEEmlBKuhJemK4ufXNo
l5pM0qjS44Z0p/EPkiNr6LU8OlVKWdJ0gmBH5grUHYgakbKk8NWyNu1GOK2c4mWZ
RrPm2Zlgq66GPcVbODREjfqm+QCfafY30h2P0Ek1ywMKzPvNqDzpSCIyw0NSEdwW
3267cgWPU6TrfBtRz1f2M85rhRiqbUd9BTVXMUb1Tv2QtKiPoek=
=wBIH
-----END PGP SIGNATURE-----

--nfy3sN/Smg4PYgnm--
