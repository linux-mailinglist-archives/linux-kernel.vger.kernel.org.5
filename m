Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7A37899F7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 02:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjH0A4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 20:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjH0A4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 20:56:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0C19A;
        Sat, 26 Aug 2023 17:56:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf3a2f44ffso16788165ad.1;
        Sat, 26 Aug 2023 17:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693097780; x=1693702580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ePHcufuMq3pmxeqUOnA6gD856Da2hnjiacEbgQNiyc=;
        b=Qg0w2uKEwnnq0bqmn3hKAmMtE5qhqY89qkRHTyzd8mb8cxpOveDG44s6c6vmM+tabc
         klOope0puKZ3o8Y4j4zsSkE3sGXVGmA3YfKHJznMJtUp1GK87hvLIC6I+8qjN6PBjkmf
         NGaq9nLN5gOWyWi5c2OBiQLXkTF1g17xhjeaQP4vGzNI54Fvu01bDAlYT8gCrlP8TzDu
         J2tsFJIRWSmaWfhLWNYkQKf1SxxNRkeUXjY8YQElgNultmi9i39q63Nk5BzTngyHUF5a
         qPxbApNKVYm6fjkrQuhBWg9vVU/Cw0swY0b32lHVj92sEneXw/WuzW11ywJ/oFQN5WiH
         XSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693097780; x=1693702580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ePHcufuMq3pmxeqUOnA6gD856Da2hnjiacEbgQNiyc=;
        b=IGP1YlSmf2EOgqAlzJusRp6GDylG8d19s+isvzNUgY2TrIzyR6aucuIm8NWZVMK6H8
         8fcVCdHwWn7Ra8isU48Bv7SxwM4DSfSzr7SWr8ibZhjR7f8u0Vy4nmzUnneRHDL8k4t+
         8rxMDaSXoJtzbxDf8OkfwM9baMCoa9Xq9jTYxCbxYPtZxBmICHGkhSwVVXNHQpGyaHqf
         2FXvrCn3e0R2jqAlPKvQCMQOv8dv2IfqIaSQc1mb8DEdITqbZTX54Xf4ZBLMK8oT9HqK
         DlQaH4aRFOKEVnM6fMz3BkbE9htgGIaptAMMbCnU+71UpCYQc+UbA2MlB3lXSEWuJQ6x
         WQhQ==
X-Gm-Message-State: AOJu0Yz8r+K7xi3MF40rBm8qV4Fp9tATMC8Uoj8uWFhxarxl7Sz4yFEZ
        Hcbn2zUKr01Mr1cjGGnvrZk=
X-Google-Smtp-Source: AGHT+IGsVSfybNw1HZ46sl7MDJywNFAJTvz4szI5nRtjxvKaS7S9I8OcoK5k/yTSe0vWLdwkhxWndA==
X-Received: by 2002:a17:903:11c8:b0:1b8:90bd:d157 with SMTP id q8-20020a17090311c800b001b890bdd157mr25752357plh.26.1693097779637;
        Sat, 26 Aug 2023 17:56:19 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b9f7bc3e77sm4306436plg.189.2023.08.26.17.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:56:19 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1F9C681656C0; Sun, 27 Aug 2023 07:56:15 +0700 (WIB)
Date:   Sun, 27 Aug 2023 07:56:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     mengkanglai <mengkanglai2@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
        "Yanan (Euler)" <yanan@huawei.com>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [BUGREPORT]
 slab-out-of-bounds in do_csum
Message-ID: <ZOqfL52gs81HzdcM@debian.me>
References: <bfb7e812fb9043e78e88bbe65334b9ef@huawei.com>
 <ZOR13ezPVcuVHh_H@debian.me>
 <c82e104ceb6344a38dd1b0514379ae88@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9oSqcPKScbLWA+u"
Content-Disposition: inline
In-Reply-To: <c82e104ceb6344a38dd1b0514379ae88@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9oSqcPKScbLWA+u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 10:05:27AM +0000, mengkanglai wrote:
> The attachment is the fuzz reproduction program.
> Have you encountered similar problems?
>=20

Please don't top-post; reply inline with appropriate context instead.

Anyway, your reply doesn't answer my previous question: Do you
have this issue on mainline?

--=20
An old man doll... just what I always wanted! - Clara

--s9oSqcPKScbLWA+u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZOqfLwAKCRD2uYlJVVFO
o5RyAQCOgJBsHUjj8vq7ws1jvA6MpJclQYujSZODQg/IpQSvvgEA8y9h6hgkTzmI
XQeEpmtycVfxre/ll8ZRuykDE/jlqQY=
=o3uf
-----END PGP SIGNATURE-----

--s9oSqcPKScbLWA+u--
