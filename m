Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F50782B38
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjHUOLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbjHUOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:11:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B55E6;
        Mon, 21 Aug 2023 07:11:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26d60e6fe19so1156869a91.1;
        Mon, 21 Aug 2023 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692627100; x=1693231900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3dNZIrk8cdTlP5FxvTPOvR6yau8NHeOzj6hC5/gPKFo=;
        b=NI4VdfEs+S4ba51EOwI21Y8k5Sn6J4avI0XCxfVgfT4tLh3RmZg2jYOnpZtAGVJ+Yt
         2ggneJcbkcPCYa3xm2KhcRTn1lFr9vVxV3QLKSO0tl1SZJctE7O9G0yY4jovD/u4lQu/
         vDi3zr3PEgqnhLcf0WPvUs/93doTNVe17Ij2fzy6hUBMd/R0DPPpWfyB4RslLvWljAEs
         D6D9YghJdkt0TBnKNvCcIXZ1X0tm0PkGpPhympJHEpiyy8RgaI4vrxaGFAN7Vrxooq3a
         Ue0vA73HTPF++6fQM/JisRY7xBKgDYkdGpUyhieMCQguD6GKG8erPgIVGlgWwHtXxUps
         5/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692627100; x=1693231900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dNZIrk8cdTlP5FxvTPOvR6yau8NHeOzj6hC5/gPKFo=;
        b=k1dx6O7nMbTVC7vifYI3vhVZza55l2Iy+FYelgAdmv1DqzSKklfkLVgMK8YELElKmQ
         koew53YJTOuqPle8O7OMxLcwDtJONCa+1M49Q5QTNZv/g6pK2gfkCWdF9VNGo9Rukup+
         vG6eVcz0srOIuvxc4tri659sUVgZby0yYzk47hDlB9WEtVXjBxLjkCmnviuYunJD8MiG
         FvIcnUGLN3DdWnptNOsmciMIvTjsVOmLmAzZzhoe6OGy4fOzAI+uJuWKZsjNYqBUbghl
         cV4z8yCsJNT0uiBLQEptE9v2bD2uxgADEspQHFa/iKcRKBhlP5e5c8CO+5IebcvPTxpU
         x0/w==
X-Gm-Message-State: AOJu0YxHIJSgE86Z66WEZ+/felVWWv5ndoIicWElmAhdHw+tZM4j4Puo
        sUQ80RCRiE91uToI52KGVnk=
X-Google-Smtp-Source: AGHT+IEkFYv67zZssZZUgDaFEIb6DG5zWbc+68lZRn7X+KyaH7nWoP4kkpaBT1HxtyXvlhNQB2C8yQ==
X-Received: by 2002:a17:90b:3884:b0:268:3b8b:140d with SMTP id mu4-20020a17090b388400b002683b8b140dmr3480681pjb.35.1692627099506;
        Mon, 21 Aug 2023 07:11:39 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b002693505391csm7786734pjt.37.2023.08.21.07.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 07:11:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B1C5B81961C9; Mon, 21 Aug 2023 21:11:34 +0700 (WIB)
Date:   Mon, 21 Aug 2023 21:11:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Turritopsis Dohrnii Teo En Ming <tdtemccnp@gmail.com>,
        cluster-devel.redhat.com@debian.me
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Netfilter <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [Cluster-devel] I have been given the guide with full network
 diagram on configuring High Availability (HA) Cluster and SD-WAN for
 Fortigate firewalls by my boss on 10 May 2023 Wed
Message-ID: <ZONwlkirjv2iBFiA@debian.me>
References: <CAD3upLsRxrvG0GAcFZj+BfAb6jbwd-vc2170sZHguWu4mRJpog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9id3nzJVoXz9daxh"
Content-Disposition: inline
In-Reply-To: <CAD3upLsRxrvG0GAcFZj+BfAb6jbwd-vc2170sZHguWu4mRJpog@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9id3nzJVoXz9daxh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 11:12:26PM +0800, Turritopsis Dohrnii Teo En Ming w=
rote:
> Good day from Singapore,
>=20
> I have been given the guide with full network diagram on configuring
> High Availability (HA) Cluster and SD-WAN for Fortigate firewalls by
> my boss on 10 May 2023 Wed. This involves 2 ISPs, 2 identical
> Fortigate firewalls and 3 network switches.
>=20
> Reference guide: SD-WAN with FGCP HA
> Link: https://docs.fortinet.com/document/fortigate/6.2.14/cookbook/23145/=
sd-wan-with-fgcp-ha
>=20
> I have managed to deploy HA cluster and SD-WAN for a nursing home at
> Serangoon Singapore on 9 May 2023 Tue, with some minor hiccups. The
> hiccup is due to M1 ISP ONT not accepting connections from 2 Fortigate
> firewalls. Singtel ISP ONT accepts connections from 2 Fortigate
> firewalls without any problems though. On 9 May 2023 Tue, I was
> following the network diagram drawn by my team leader KKK. My team
> leader KKK's network diagram matches the network diagram in Fortinet's
> guide shown in the link above.
>=20
> The nursing home purchased the following network equipment:
>=20
> [1] 2 units of Fortigate 101F firewalls with firmware upgraded to version=
 7.2.4
>=20
> [2] 3 units of Aruba Instant On 1830 8-port network switches
>=20
> [3] Multiple 5-meter LAN cables
>=20

Then why did you post Fortigate stuffs here in LKML when these are (obvious=
ly)
off-topic? Why don't you try netfilter instead? And do you have any
kernel-related problems?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--9id3nzJVoXz9daxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZONwkAAKCRD2uYlJVVFO
o2v9APwLSkYfNhrIlWLvqv1XaVd4D6YSmC1QEaYhXa7Nf2pcewEAmXXstMCWZtZt
6l62/RN1wYSQNNh+HfJNE5+KG3YXDQ4=
=tY/a
-----END PGP SIGNATURE-----

--9id3nzJVoXz9daxh--
