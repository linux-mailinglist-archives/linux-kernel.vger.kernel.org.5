Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413FF77D924
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbjHPDhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbjHPDeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:34:07 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6352719;
        Tue, 15 Aug 2023 20:32:15 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bcd4b5ebbaso5278987a34.1;
        Tue, 15 Aug 2023 20:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692156734; x=1692761534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BL/F/X8bC3GTds988AutPOHQC46oxwdLAdPac8xjblg=;
        b=NC3+uCjJWXs55QZdoTpPOmV1Ji5h/xsfV3h/BLeZ4EMM8N9tjXYl9ijOXOvyXN1oi/
         I6mffbS7ohPjrmpLdtEd/bd+QLGsJaJKHGZF7QtwegH/DzC+JnMDZyszxmrEN6LY2EA3
         wMUC3YbovdgIFpHHh8fD9e0HE2CEYiaoCkC9HkiludDb2S9VrIFRZAtSRpfEyJpxVinU
         ssWWorBJQrDx5RnzFGtniwMXQU1gmY7GlDB7X/SQZ5jU/REUAP+pn7lveN4LhlsYLTa2
         Wysd8twYZmj82pGv4PNtPj9Z+qm9tGCI5oS/nRTBDM4wBETAiR3Ac9i4DZqTQ6VRxpVF
         olYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692156734; x=1692761534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL/F/X8bC3GTds988AutPOHQC46oxwdLAdPac8xjblg=;
        b=a0g3jPzQ0YK0fYc9JUfoFgq0ScDaPO8lrnkywdDtbUTLuLAdoOI+cW1xy/GmfeUOGc
         0k+bo7JMiYX3dA8k3br2AFEus+DWbHs/gwH42dwKXhh5ggWuQZHCjd7Y7LL2biyUsXjZ
         0Pxb+xXJQLClp5pBlLjBLshyx+RnarFmT04vtEzepE4GivJrbkrOxZWl8zZNIsv0Qekk
         IiXkdzi9MziQezEjzn3+ERVS3S09uYpqJcjSgR9gdV9ZsYEDhQST5eeGTjg40X1e1u9o
         a3Ycbb2t0h78hEg77aqZGGtfReBH3X4nVH75OCB3tcaOHEWbBdexSRIFS9kCpmGxnZw6
         dspw==
X-Gm-Message-State: AOJu0YwqRvsxbAePPeRzsDReSHDVodXbbUaUUZ/ksbsd9ihI9roMZ3AM
        YzA4uQ2tuG33aAapHtVgxfI=
X-Google-Smtp-Source: AGHT+IHwwEZLJtvTSLrvqU+elcRjoZRAZnKEzs4FKKKjO1s6M+lXRjpifXkHOpKiOwnBOKqOOE5sAQ==
X-Received: by 2002:a9d:6381:0:b0:6b9:9018:6ea with SMTP id w1-20020a9d6381000000b006b9901806eamr831995otk.20.1692156734278;
        Tue, 15 Aug 2023 20:32:14 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709029a0200b001bbcf43e120sm11891302plp.95.2023.08.15.20.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 20:32:13 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 23B178232E98; Wed, 16 Aug 2023 10:32:12 +0700 (WIB)
Date:   Wed, 16 Aug 2023 10:32:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Loic Guegan <manzerbredes@mailbox.org>
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] Adding a driver for the INA260 chip of Texas Instrument.
 It follows the hardware monitoring kernel API.
Message-ID: <ZNxDPGUgW_CC4HrZ@debian.me>
References: <ZNtWl_Jyj2PWBYpf@lguegan-thinkpad>
 <2ee4bac8-8114-4c72-9b6c-6038869fb9f2@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Aol3dnsz0xFnCEmt"
Content-Disposition: inline
In-Reply-To: <2ee4bac8-8114-4c72-9b6c-6038869fb9f2@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Aol3dnsz0xFnCEmt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 08:45:39AM -0700, Guenter Roeck wrote:
> On Tue, Aug 15, 2023 at 12:42:31PM +0200, Loic Guegan wrote:
> > Signed-off-by: Loic Guegan <manzerbredes@mailbox.org>
>=20
> Subject and description are all wrong. I would suggest to read
> and understand the documentation in Documentation/process
> as well as Documentation/hwmon/submitting-patches.rst
> before resubmitting.

And when submitting patches, do not GPG-sign them like ordinary emails,
but rather use patatt instead.

--=20
An old man doll... just what I always wanted! - Clara

--Aol3dnsz0xFnCEmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZNxDOwAKCRD2uYlJVVFO
ownKAPwNzqKAocSrIpLnXw68P0IVWgO3hWjv3qxZ+fCoLia8hQEA0SuSaWFC58uo
XN8SJRbeJKC03BPgKkZowIQ6O8BdXwo=
=wx1r
-----END PGP SIGNATURE-----

--Aol3dnsz0xFnCEmt--
