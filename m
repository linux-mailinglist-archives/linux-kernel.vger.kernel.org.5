Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C387F7A5A36
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjISGyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjISGyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:54:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CA4102;
        Mon, 18 Sep 2023 23:53:59 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso38513465ad.0;
        Mon, 18 Sep 2023 23:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695106439; x=1695711239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JrZnIbFr81fyCrGJLUv7gvnp4WA+u4UAg0ITzEeBQA=;
        b=V0HulJtnyd287prA7csMZJ1DEhcH9lGSlYuXptrtZxfNSGEHUM0uusEVsxyBSR/SDe
         yAxtCeOEYZ/e2/uCu7LkVj/ovpWocEd4DRr0e5sbUfFx4CErxxDqDzzXyzNM7EmZRYPF
         PCYU3NxLxcgO0HU7ET/EX+UfFMNcIy4C69kQE5m33tUlvH2EUiqJQP2iVJh4kO+fU50z
         ZxLHUJ0uUtEe3s495dRNA5PaMLqBJml4r4YHKqTBYv6XosimKtNRA5lgW+WOzcMVIsEz
         7etzsqBvYToKlvCJ435kHSaBRsxYJk0MZScoH2u4Y9gbC1S9vihbXL5NVO96CsvtJF5U
         YFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695106439; x=1695711239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JrZnIbFr81fyCrGJLUv7gvnp4WA+u4UAg0ITzEeBQA=;
        b=wb9Rie1A1EdarcWSPQqNrEuof1Q7RaUT+KY/NIz5KqKW+FcCGSn6Pb37/+YeDsAeXk
         /dyIo9W1Ny7Smlwx6/uzMn6Fw9qLbUF8plY0brC2zDtXPE6nVWSArfiEdviw9XOLbLZ/
         XpQL8u0AXG1xXkoiMdLZ33OY/VDhFxHax9KDK7ZFNKoAMAL+PBIQu4Ius0NGD18AdAnW
         X8yMW73VEgWItNr2OZFHaJbBKAwj6qycKsJeEiZ+Y+OQdAh0gShLlH/5hTSgrfBSxEpP
         4csZD4tEpablyFgtBdKuyd3HrQf8+FpB/Wi6kns95CN+xdWBCcWPe/G3G2eATjgEo9yL
         axLg==
X-Gm-Message-State: AOJu0Yz6yd9NE79+fUxXnM2+eAWFmffhESb8COWFsFO98RDfvZUN1uX8
        eoEs3CHZjZ6jH6u8cGQ4fnQ=
X-Google-Smtp-Source: AGHT+IGMP5NsHVZjmSi0Vp0O55hNYbTudKLiyCcpM3EX+lbrIZBfzGSRrcHKVwGrQqLqcbzPEIvN+g==
X-Received: by 2002:a17:902:ea0f:b0:1bf:557c:5a2c with SMTP id s15-20020a170902ea0f00b001bf557c5a2cmr10880147plg.44.1695106439085;
        Mon, 18 Sep 2023 23:53:59 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001bda30ecaa6sm9338288plg.51.2023.09.18.23.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 23:53:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2DDEF81B96EC; Tue, 19 Sep 2023 13:53:56 +0700 (WIB)
Date:   Tue, 19 Sep 2023 13:53:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Song Liu <song@kernel.org>, Timo Gurr <timo.gurr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: Fwd: Marvell RAID Controller issues since 6.5.x
Message-ID: <ZQlFg4GsULu633P1@debian.me>
References: <224f10a4-7a6a-48bb-88be-491faf8ecff7@gmail.com>
 <ZQf9mh3v5qfN5Tm0@x1-carbon>
 <ZQgCoJ17UioOtdOJ@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6jU0HxXziu/VyJx9"
Content-Disposition: inline
In-Reply-To: <ZQgCoJ17UioOtdOJ@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6jU0HxXziu/VyJx9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 02:56:16PM +0700, Bagas Sanjaya wrote:
> On Mon, Sep 18, 2023 at 07:34:50AM +0000, Niklas Cassel wrote:
> > On Mon, Sep 18, 2023 at 07:18:28AM +0700, Bagas Sanjaya wrote:
> >=20
> > Hello Bagas,
> >=20
> > This is a duplicate of:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217902
> >=20
> > Problem is solved by:
> > https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kern=
el.org/
> >=20
> >=20
>=20
> I have asked the reporter on Bugzilla to check the fix above. When he
> reports back successfully, I'll mark this report as fixed.
>=20

Another user has confirmed the fix (see Bugzilla), so:

#regzbot fix: https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dl=
emoal@kernel.org/

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--6jU0HxXziu/VyJx9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQlFfgAKCRD2uYlJVVFO
owDyAP0RHtQvjlMD6aj+pXaLGlKI2/uSHkRaBy0v0QW8rlurUQEArZwuCVUahkRb
pL10drC+YaEem5L2bn6mk4iPiP+U4QA=
=8Uj2
-----END PGP SIGNATURE-----

--6jU0HxXziu/VyJx9--
