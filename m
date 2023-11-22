Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3957F4743
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343989AbjKVM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbjKVM7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:59:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D91597;
        Wed, 22 Nov 2023 04:59:49 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cf7a1546c0so4283735ad.0;
        Wed, 22 Nov 2023 04:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700657989; x=1701262789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QW8tX1Rt7l90NZJE2e+BwQxvjumBfu6BosqaGgb2t5s=;
        b=OD/X2mf+5z7eOLeaYKVYKpDY1D4P6eAIVSkbFyVCCxSeQ0vzrOm0yCYpT0EJOk09dB
         49pLNPpa6eEAIp5cxSpxhs4C+SQBleAMR4XW7598u5oRlcr2ImRWlH8sg08BqYyzlx3r
         DnT2tgJ05k0lhleAuKqpwRSOP4LtEXJ9h4Zbjb6JiwNd3SqdOZbSCJY3iFZeMqPS6xFI
         rqx3Rkmw8GOY5mu+LsPSIbs8A4aVmBxa7hTF3tP0tOTqQnDnFaD13RsGHnmEINQf/Wm0
         OK0RD1OHcsIR1tpnJp2vG81oamv5NzbZQmNBIGunpBJ4xyo/8NLB6oIxmBbK3iIsMcH5
         XHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700657989; x=1701262789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QW8tX1Rt7l90NZJE2e+BwQxvjumBfu6BosqaGgb2t5s=;
        b=T7NHMpw+aNcE7UyiLIuDYwNXFJCjeCNty1jXiiUOGdlyYPq229PuQNZdidN4Lf5VpX
         RKXEf2+2ZjVDUpisDXZgfykrehXfATNrFrOXIKGQzh0Nw13cETpcNOzAr7sGsaGzl76E
         MlNpUhCQxdEku+mp1+Qwz2JE1QIarUWfqQ8c8gjzWsBpMSlblcy0bQTe4eSSgBcNJtXE
         nWS+v/2uW6bZgJg72ODcDqiLV4VAWsKV2QPHWhR49t972MWP7ZQlO9XSegVjOnvig2H/
         CnQtuoSKxwDIm03cr3YZIUOV2Zo6z4qq1d6q9OcgPgRmbNfhX8o6IjkrIHViA8StRY0P
         g+3A==
X-Gm-Message-State: AOJu0YxcDbz0ZAIhnEXmldHieeXMsBWbgv8Jwv75ap7WJX8qOMG2fhYB
        gbU9gk40yp6xSSpQEqjv3aM=
X-Google-Smtp-Source: AGHT+IFuWa8OmkRUyBAwazRj12HP4KY6Fo6QPFHJVHmgN2KnG25EHNg3/YcnMxKbGhWIZ+2KyWD4TA==
X-Received: by 2002:a17:902:da85:b0:1cc:3fc9:7d09 with SMTP id j5-20020a170902da8500b001cc3fc97d09mr2633927plx.15.1700657988620;
        Wed, 22 Nov 2023 04:59:48 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090322c500b001acae9734c0sm1405028plg.266.2023.11.22.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:59:47 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 3976010207134; Wed, 22 Nov 2023 19:59:44 +0700 (WIB)
Date:   Wed, 22 Nov 2023 19:59:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Martyn Welch <martyn.welch@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: Update Martyn Welch's address
Message-ID: <ZV37QCEB9zEk368g@archie.me>
References: <20231122094156.30642-1-bagasdotme@gmail.com>
 <20231122094156.30642-2-bagasdotme@gmail.com>
 <98a17cfe-4358-44f8-aeb3-882a87de1177@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OEFSv2cXj1zn5if4"
Content-Disposition: inline
In-Reply-To: <98a17cfe-4358-44f8-aeb3-882a87de1177@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OEFSv2cXj1zn5if4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:15:19AM +0000, Martyn Welch wrote:
>=20
> On 22/11/2023 09:41, Bagas Sanjaya wrote:
> > He is now active on the mailing lists using his Collabora  >
> > (@collabora.com) address. Reflect it in MAINTAINERS and also add >
> address mapping for him.
> Hmm, mapping yes, changing the email assigned to the VME stuff, no. This =
is
> not something that I consider related to my work at Collabora. Any time
> spent on it at this point will be personal time, hence the use of my
> non-work email address.
>=20
> Realistically, I've lost access to hardware to test anything regarding VME
> and it's not something that's particularly easy to acquire. With the other
> patch in this series removing Manohar, removing me as a maintainer would
> leave Greg, who has been amazing covering my shoddy maintenance of this
> subsystem (what can I say, life has rather got in the way), but I feel it=
's
> unfair to leave him as the sole maintainer. I wonder whether I/we should
> admit this is basically orphaned at this point?

I also feel similar thing when basically the subsystem gets more care from
kernel janitors (including outreachy applicants and people specializing
in checkpatch fixes) than real users, like the case of DECNET [1]. So
I'm agree to orphan VME.

Thanks.

[1]: https://lore.kernel.org/lkml/20220818004357.375695-1-stephen@networkpl=
umber.org/

--=20
An old man doll... just what I always wanted! - Clara

--OEFSv2cXj1zn5if4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZV37PAAKCRD2uYlJVVFO
o1qbAQDpALBJdNaAYVxFyVMxS56nF0gEM2UqT/loGVBX3h35TwD/bGyQnlqQmFHP
TD5HDyxFAe0m1504rF7uCs2fTjkDRQo=
=219y
-----END PGP SIGNATURE-----

--OEFSv2cXj1zn5if4--
