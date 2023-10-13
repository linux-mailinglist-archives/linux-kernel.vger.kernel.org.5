Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6882D7C7AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 02:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjJMAET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 20:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMAER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 20:04:17 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EF6CA;
        Thu, 12 Oct 2023 17:04:15 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c64a3c4912so1025341a34.3;
        Thu, 12 Oct 2023 17:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697155454; x=1697760254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh67ucGuzIvE780j/LrVx5Elx34xcaAEoCizzJ+iHF8=;
        b=N3TP5VcuIGDVeiQY461R0QaNw6eX78Sss2PGs6h2S1lcHYGsrTMGFXyEcXxzWZ83g1
         BSgUUuxfYxA95uU+YxaZyMwCh8nOFr3n4aG2WkMoZOm4kSSR6BdN1clVsIh8BSLLXF5g
         SqArOx50D4E0Tx0ftwzgAc3IORCizgaEQJt3peapypbsDaLpHnG4iaepn5tncQoFOC1E
         71ZqUc1DP1ccGGq9nWdo5eTkEuEl0iw4gIuDgMUyV103HhxOEk0latoP19BaHYSGa8n7
         VIqlKsIrECYaoFPZqJCID+fjjHWpsOuHLCNZOYXuJbZwptFfwvQIbojaPyiPXhuce6Yw
         jbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697155454; x=1697760254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh67ucGuzIvE780j/LrVx5Elx34xcaAEoCizzJ+iHF8=;
        b=owm6QLBbaLtdFrUwNqVt+DN9zhswY/n6NY8rqJdvSKrdogk2SBOV/oh67tlxhk6R4N
         7byH46HdeLzfHhXTKrzx+B1CvEO1QlvXQXEYPaxVRC1HJ/bt7YN6t523zkq98ZQart3j
         fRDV13UMaPs8o9AZH+KwZ+86m+CEujdkiBSsip4xrrzy2w2Mtcbt3zKa5Q0HzyukL2nN
         ZprLmlu4g42xbIqgSbJupoMxVBhOnD3C1/jWnhT8/jxmWAqFjnRUU3g/NrsrqgmX39PV
         njYYP5odf7GRqyJkuUsuQ31fHBSLYs7k4FHa/weerLBfYGqkXhzAxqE/6a2KsTS1S/SH
         bgqA==
X-Gm-Message-State: AOJu0YxFvY8zcMwYDIEhF+XuaJ3c4fYMPjJjTiTfY+eQ7lCKyAhPGagC
        yHTfj89CvkOxpOrqysQzsXA=
X-Google-Smtp-Source: AGHT+IEoD+6r6arnZjsqloxzLh2yK4Ao1EbLkqH70J3zGd6qS6Bha/trbmFxeZQVi0Pk+lVNP9d65w==
X-Received: by 2002:aca:1c18:0:b0:3ae:5c89:dcc2 with SMTP id c24-20020aca1c18000000b003ae5c89dcc2mr27713272oic.34.1697155454577;
        Thu, 12 Oct 2023 17:04:14 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id d9-20020a634f09000000b005aa800c149bsm196524pgb.39.2023.10.12.17.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 17:04:13 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9E3208061F09; Fri, 13 Oct 2023 07:04:07 +0700 (WIB)
Date:   Fri, 13 Oct 2023 07:04:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Loic Poulain <loic.poulain@linaro.org>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Wireless WAN <linuxwwan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Intel 7560 LTE Modem stops working after resuming from standby
Message-ID: <ZSiJdxjokD0P9wRc@debian.me>
References: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
 <CAMZdPi9RDSAsA8bCwN1f-4v3Ahqh8+eFLTArdyE5qZeocAMhtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PP7bwyu6fGW3EUdk"
Content-Disposition: inline
In-Reply-To: <CAMZdPi9RDSAsA8bCwN1f-4v3Ahqh8+eFLTArdyE5qZeocAMhtQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PP7bwyu6fGW3EUdk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 06:54:11PM +0200, Loic Poulain wrote:
> Hi Chetan,
>=20
> On Thu, 12 Oct 2023 at 11:52, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> >
> > > I noticed a few days ago, after Fedora moved to Kernel 6.5, that my I=
ntel LTE Modem was not working anymore after resuming from standby.
> > >
> > > The journal listed this error message multiple times:
> > > kernel: iosm 0000:01:00.0: msg timeout
> > >
> > > It took me a while to determine the root cause of the problem, since =
the modem did not work either in the following warm reboots.
> > > Only a shutdown revived the modem.
> > >
> > > I did a bisection of the error and I was able to find the culprit:
> > >
> > > [e4f5073d53be6cec0c654fac98372047efb66947] net: wwan: iosm: enable ru=
ntime pm support for 7560
>=20
> Any quick fix for this issue? alternatively we will probably revert e4f50=
73d53.

Chetan can't be contacted as sending to his address bounces (error 550)
(had he left Intel?). Last message on LKML is this culprit patch [1].
Hence, revert for now.

Thanks.

[1]: https://lore.kernel.org/all/1b0829943267c30de27f271666cb7ce897f5b54a.1=
686218573.git.m.chetan.kumar@linux.intel.com/

--=20
An old man doll... just what I always wanted! - Clara

--PP7bwyu6fGW3EUdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSiJcQAKCRD2uYlJVVFO
o3T4AQC2eZBwGIxvu1lYm3OWhuSJWAkmt205gwAEftFVbJMb4wD/eOyi70nh9Io+
kMI6SLXZyG8rleaKEg9MYV9rZ3LfCwk=
=dFVx
-----END PGP SIGNATURE-----

--PP7bwyu6fGW3EUdk--
