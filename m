Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2E7C5EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376363AbjJKUo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbjJKUox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:44:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89380C0;
        Wed, 11 Oct 2023 13:44:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b95622c620so44851766b.0;
        Wed, 11 Oct 2023 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697057082; x=1697661882; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekSd27xlwThNX/Q4Rmy9BVkLLGiyelkBChOxdtoZaAU=;
        b=FGVm9aVVUYugQjczLngQUfeoly+pGzzyiO3dWpkw0RVKHDeAVlAwEKFU2i9w/i6j9J
         GvUM3qq0z/ngbY5EBYEWMhUgQLHu3sy4CMdv6i9+cnJMbcEjTdAQlE8LSU0MOGmMJlo1
         Cj7rDXeBBKt3gv/6T7ymmrB3r4VB2w7yRh6spcHlN9NEEgdS+v7d1PjqxakbUCQ3QmVk
         Eb4HaJ8qDD52zDWb8cIV+d5qh1v96qXhiQ7EfVWZE6NkFkE44OeDAxcu9jq61PPrr2y9
         4+beA32k0qRIvFQSh6okhgzuEusAGQ6aJBfn8f6nrHZ0NSzWzhcF0u6EUPdjdfvpkBTG
         A3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057082; x=1697661882;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekSd27xlwThNX/Q4Rmy9BVkLLGiyelkBChOxdtoZaAU=;
        b=AQRwhGiR9dezXsKGaIEKHhxoW4Cv7hbM4T7Ljg7LrWK+4XUbOWi/T/O44Hu1iUEYYL
         0lo9fU1UUCijhfqXa+WfiIZrU0vLI4iU2IvxofVosN16Eb7bGMhmH3mo1k0pjM8M8M3S
         Q/r/25I+e0PRHSiXWV3I4KR0AONXCAQYr6ErIh8UqQFOdnjLOw77k0kQW25P0ewOt7WZ
         6oG5/N0sqwnhVN81TArS8AEI26sSZGxS6TU+/iLzmauDr8h3go7ch5pA8KZTLvP7v9KC
         9IulX+SyPzFzOONz9qP8Ub1P7JQTt8LXakRZResGbdV/PX5O0Ay6Zau+0HnE7HAhBoBW
         C0Kg==
X-Gm-Message-State: AOJu0YxHcPePw4uIrrXRl7lSyaYFRX5XC1sMy5NZvFg1AIU5IZbEptI2
        r5a1HR3jRFRYDq7J4iddC18=
X-Google-Smtp-Source: AGHT+IGs+QPMwkJTsynUOVn4VkRAiWxZMwrR441kv446Bslzb6MbVsgant46R2AnlsPNf3FCwukPnQ==
X-Received: by 2002:a17:906:5a6b:b0:9a9:e3a9:af02 with SMTP id my43-20020a1709065a6b00b009a9e3a9af02mr20192152ejc.8.1697057081631;
        Wed, 11 Oct 2023 13:44:41 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ov19-20020a170906fc1300b009a193a5acffsm10125559ejb.121.2023.10.11.13.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 13:44:41 -0700 (PDT)
Date:   Wed, 11 Oct 2023 22:44:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Johnny Liu <johnliu@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpu: host1x: Correct allocated size for contexts
Message-ID: <ZScJN6I2zdO5Jeum@orome.fritz.box>
References: <20230901115910.701518-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zsqpP2XHutRMmF6h"
Content-Disposition: inline
In-Reply-To: <20230901115910.701518-1-cyndis@kapsi.fi>
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


--zsqpP2XHutRMmF6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 02:59:09PM +0300, Mikko Perttunen wrote:
> From: Johnny Liu <johnliu@nvidia.com>
>=20
> Original implementation over allocates the memory size for the
> contexts list. The size of memory for the contexts list is based
> on the number of iommu groups specified in the device tree.
>=20
> Fixes: 8aa5bcb61612 ("gpu: host1x: Add context device management code")
> Signed-off-by: Johnny Liu <johnliu@nvidia.com>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/gpu/host1x/context.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Both patches applied, thanks.

Thierry

--zsqpP2XHutRMmF6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUnCTcACgkQ3SOs138+
s6GZEA/9EdvqUmfzSRbzjrdgiT88qxR7YL/IsDRoy2WAc4H+VIn5GdsUOrrhhvOy
417AETxf+XE82vrtEJtLDcrDCO96pyt0BvKySl1nuD1VS/67s4c6gAS5xXd4tn+/
Az7rKc0h/7Ut15oo991yUldkqNZG1CNJvLdBfeeALQQswxEPQmwtJpxK4I8ze2HD
UOU5i6QRJDPhq8F+yD6mzX86Sb+yAplPw9dLDDzE7k+KIX2ccgLjtwy0D03fpHq0
dnjfJiSiPdhZNaD6rWBtqtLOz4+rg9ADtwJxG0mWnTfZopfdUe3Od8LCibBmcaiM
d6sCnC9WG2PtKc1+dfscs/LRq7yvQh35K0Jh5Y8NY4/YoQh4rZB1MtvP7HknFes3
arm3dLaQjNYXOJxY2IQBAuniATwtxxp61aS+vO/hgiTShXwiPTz8ZRm5rAxwX8Xj
Zb2xPOwQiBD8HzAwuddwqFuQ//0byWE6HkJXm7L5cEK3d9yvSedIEau4uYilT8aw
/NaCme/LVVs1YTrMUtwkGgj9zxs5fikzfNE3ErTZZXFLJPUxJknrVPN9VZ8NcHsh
N/wDrikDp0bE9GujnEgaWMhfkaOGcEOsHewtFZkB+rN9TeZ2KY1G8eJMqV15MWrS
dksIMqcpjU0d9Oc8M9GzIANN1dgS8GTNieAOnWtwLHrj4fDGGcs=
=cyGi
-----END PGP SIGNATURE-----

--zsqpP2XHutRMmF6h--
