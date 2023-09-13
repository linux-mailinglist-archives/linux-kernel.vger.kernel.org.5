Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8C679E360
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbjIMJSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbjIMJSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:18:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A92B1999
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:17:59 -0700 (PDT)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7034A3F675
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694596676;
        bh=YOII/3O27Az9SG2nD11VPnmQx6Ck7v8vZGr+bu9t/Fo=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=oKdbfuCgNld38ZZCLcH75o28222kOSwzRkmyx/xr2OQYt9uA191yAoexBJSFRSM3z
         4j3ACapaswvqSgAobbSU4ao8xlY5VaNKGtCC1JXonJ7s4R3PUDBhUzkGHtSwOhOhf/
         dZpvpwy0fkdYpSpr7u+kjD/cY9IBTXgTxU/unadG/RbpykQDT/O5MBAYx/B5kbkNsI
         Jh5JlTMz6Y3VImkB0gHicKYUFqzBXeKboNd/YqmGShaI3Oa0BOVnXypxfo3UP03m6T
         W9CTzfO0S/elWV0jZhZV97NmF272DzOUPMxuSsO5bWTT0bq1jLbm1ZZE2pOsd6skjB
         Pf6Xsy0hpyFMA==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31f79595669so278963f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694596673; x=1695201473;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOII/3O27Az9SG2nD11VPnmQx6Ck7v8vZGr+bu9t/Fo=;
        b=rodvLgMT8n0OWhxhF7VZdcERGBrUzej2gjGCjKhfFCXBJ6RpxT49nKrFb7Y8ILjd7i
         4jucBFveG3y2qDYGjJFb89+P4YDrZaWfaYlA5c7/JeOyufMQxhpUEejdtG35PH6RR7Ct
         3wGzqNumi3bCJfTFrcLKTrqZLSPIDYkITnjtpTdQ1CE2U2/zpLMWKRsQGMq48nMbkh6z
         1nWWOFpdxrSf9ya0SXQRIqP7gOC/bggS3J5CVl1SyU7QEy5SIseVBKl8G0WSXnlKAPM8
         +mgrQr4xACxaE393WQQh1VbnTmkyNSXI5lHiVqvwnPfjLVT2pXB9mZDJRfytoc9deMlv
         NKzg==
X-Gm-Message-State: AOJu0Yx0+J/Nq/aOlZ2T8rRNelbejk7ta8sgidw/p73ZsGv2D1FL+qrT
        oiCwu2+NtJhk1qaJaNIjt/UhpQBnlGWMauW/EzmaQj3zjXJWE64yKUomafctYfNxoHo42//jq60
        Dp/SEJaPqb7OB8+YwLGRSroumInEDwJyc6daERvQsaA==
X-Received: by 2002:a5d:526f:0:b0:314:1096:6437 with SMTP id l15-20020a5d526f000000b0031410966437mr1551485wrc.19.1694596673128;
        Wed, 13 Sep 2023 02:17:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzZpbc5eKZXXiI/rQ4cz9Po8Dhm8unDuLJ1pm1qT0dvDqRwRkliciQI48iSOie4UN/NJ49IQ==
X-Received: by 2002:a5d:526f:0:b0:314:1096:6437 with SMTP id l15-20020a5d526f000000b0031410966437mr1551467wrc.19.1694596672814;
        Wed, 13 Sep 2023 02:17:52 -0700 (PDT)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4c91000000b003179b3fd837sm14942590wrs.33.2023.09.13.02.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:17:52 -0700 (PDT)
Date:   Wed, 13 Sep 2023 11:17:47 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, marcan@marcan.st, keescook@chromium.org,
        gustavoars@kernel.org, hdegoede@redhat.com,
        ryohei.kondo@cypress.com
Subject: Re: [PATCH] wifi: brcmfmac: Replace 1-element arrays with flexible
 arrays
Message-ID: <20230913111747.35839fd8@gollum>
In-Reply-To: <87msxqlaao.fsf@kernel.org>
References: <20230913065421.12615-1-juerg.haefliger@canonical.com>
        <87msxqlaao.fsf@kernel.org>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Cu_SgLCiae9uFjwQIJE6=+Z";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Cu_SgLCiae9uFjwQIJE6=+Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Sep 2023 11:58:07 +0300
Kalle Valo <kvalo@kernel.org> wrote:

> Juerg Haefliger <juerg.haefliger@canonical.com> writes:
>=20
> > Since commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC"),
> > UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> > 'element' and 'channel_list' will trigger warnings, so make them proper
> > flexible arrays.
> >
> > False positive warnings were:
> >
> >   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brc=
m80211/brcmfmac/cfg80211.c:6984:20
> >   index 1 is out of range for type '__le32 [1]'
> >
> >   UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brc=
m80211/brcmfmac/cfg80211.c:1126:27
> >   index 1 is out of range for type '__le16 [1]'
> >
> > for these lines of code:
> >
> >   6884  ch.chspec =3D (u16)le32_to_cpu(list->element[i]);
> >
> >   1126  params_le->channel_list[i] =3D cpu_to_le16(chanspec);
> >
> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com> =20
>=20
> Should this be queued for v6.6?

I would think so. It's a problem since 6.5. Which reminds me that I should
have added:

Cc: stable@vger.kernel.org # 6.5+

...Juerg



--Sig_/Cu_SgLCiae9uFjwQIJE6=+Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmUBfjsACgkQD9OLCQum
Qrcu2g//VfE5J5Fsa8NX7kn7uJX0G9v1OLJIRJ/A9HYWNJ9CWWp0coKnWy0rdrWm
kJYut2/zOC/sjvKaXLIfSIRvmpL/4jl6/9Uesacah+7bfBszcYbNGStwa5sGx1zf
ntzc9RM0vRoYZYHfYyEootuzqQZ9ZSr2OZkCBnHe1KnAKz1NkoUOag+l6l76HMI+
XjtpXC5EHOmGCyWebWBUOv3SQl8g81bKKu+DwtW2zsKYpuJcYcQv9Y0GZgl0Bu6u
rrKXTGyZpyrQ4H9lqI0LP1GAwpbuinYgW0Xft6MUkVgQUS3qDhOBJCa1Nfb5xS0v
wMNH8KNZNT4vREH3LKOlRP/SdtP4lPH4udoONveHfGLXt+VXlgq02jRr/Jxj6ICM
dkIpY54ND8+I+psaH5Oi8s3qhcSzY8xuwJeZzQRh+wh7X8h8aj67N9hv6tQZkDEe
3WQmb3slanRnMGSgJhCkp3M1IrR38nNBgQe6nb9UagiWXW6l1kar5sQ+uQkPAgZz
Z3AE0rQt0SV2EHfyWGkwUSSTVKAP7mSb3jsVr+3UExOTLnNq1GsPr+dJ8oG3baHL
UDe3xw2TrXv+cSOUKuWqef3/C6xeqM7Jjz2fyYwKP+hjr5smf5QMzfdGif4Nv9x5
cmID/ABkY+GOGkFNE+68Qr+DOy/3CglizPfsB7ESqVdJFgLa1rU=
=Yn1Y
-----END PGP SIGNATURE-----

--Sig_/Cu_SgLCiae9uFjwQIJE6=+Z--
