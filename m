Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159EE7AE244
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjIYX3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjIYX3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:29:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03481116;
        Mon, 25 Sep 2023 16:29:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B96C433C8;
        Mon, 25 Sep 2023 23:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695684582;
        bh=QWki2CSqm9eYB90M3TIkABMvM25AfYZ4QVC3NVr+usc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEi9Erzidy2B4EGgLNyAwUR2I2jQfsADDMRS7eGK4KM1zqCwEKj+JuwE7nSpx69kA
         /DcFAEy6QyyBgv93ARPrctTWZMbKg/1IKJs4wmIcYj68A8FG2dQlr5VT2b7hhscS0F
         TnyzyaZTWoq9eHpaYt0SITFgEQ77XE8Too8DA3EMHw2bzsx0F9Sef7HSEWgkRIOcn6
         jCdNFWVzQ51B3BU4qz5O0bEE+NXixVZRpkmhG1Ysy7OY6DB6CmOaTEMjMPypbXLnWu
         nE88aaIIPR15qDjzaHPMxMH68yXUFrAYirZo2CACzcE6D/qFH7IdZpkbljTaWU96Pe
         hReSlUcZElf2g==
Date:   Tue, 26 Sep 2023 01:29:39 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] userfaultfd.2: reword to account for new fault
 resolution ioctls
Message-ID: <pzeysxf4x5c52rs4i74mvhpc7whuih3sbz3wdv75ll3mih5uur@it6qhwo6idje>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d2rl2hxcti2s7kgj"
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d2rl2hxcti2s7kgj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 02/10] userfaultfd.2: reword to account for new fault
 resolution ioctls
MIME-Version: 1.0

Hi Axel,

On Tue, Sep 19, 2023 at 12:01:58PM -0700, Axel Rasmussen wrote:
> Basically, reword the sentence to clarify that this isn't a complete
> list. I don't believe it's worth maintaining a fully complete list here,
> instead ioctl_userfaultfd.2 is the place to do that. Let this just be an
> example.
>=20
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Patch applied.

Thanks,
Alex

> ---
>  man2/userfaultfd.2 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> index 1b2af22f9..00d94e514 100644
> --- a/man2/userfaultfd.2
> +++ b/man2/userfaultfd.2
> @@ -222,11 +222,12 @@ operation,
>  a page fault occurring in the requested memory range, and satisfying
>  the mode defined at the registration time, will be forwarded by the kern=
el to
>  the user-space application.
> -The application can then use the
> +The application can then use various (e.g.
>  .B UFFDIO_COPY ,
>  .B UFFDIO_ZEROPAGE ,
>  or
>  .B UFFDIO_CONTINUE
> +)
>  .BR ioctl (2)
>  operations to resolve the page fault.
>  .PP
> --=20
> 2.42.0.459.ge4e396fd5e-goog
>=20

--d2rl2hxcti2s7kgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUSF+IACgkQnowa+77/
2zKRUhAAkG+iUG7FNAHqtgzPXEpK39yHzOqX7vFZVGHHXepGD3FJIDOki0IhuQA+
K80kJl+cU8mAOcKOuzubCt+HsHc+HF9L+4Gxq4DXlo88IQUO6EuBweqJm0syZrkE
qumOazDIDxsdNQEopIz+UBTk7szDub3vXZlge/XobHfO+EFPRfHvGSICXbKZHADT
LuyFLeczMbJZrNrYwxr1pBJn8pQK6/hHlEGtjSVyUfXMojxKZH7blZHux4bNheJt
Y4SEu39b6EK0//HNkKNYQEPdtbQ70XIRFQckufExii7yYHxa92U8T73xNIDvhuNE
sHVsd0DXJn/AZaa4hLRwgxt+zXpAmOYo5TKainkHOGnnGY2z8DSdvWT9EktUTJXB
dpsO+2EVKfAKbnTyXMPq8AM1dB4vcuKCHaRPgGLjNSFYHdVIT9hB4XszCF4TdE0F
HuoIKHCX2PuFfZpgGs+Mbs0+tvYkyogxleJnP9LIU9fHNuxsn31BZN0mcqsVh4hm
oYkH8Rsdk20CdR/2NdWVLR1J5CMJkja6IwuKc4ADTznEbK5x9SbeoCBk5c8ooFNK
WjVsiFguSZ00s/dF/mzGO3ca1sfeskQyO5r7ieZqS4BOglH6a+333sYz0yHY6U10
dLMOftxqT6aCTipY95ookUEzHo3t4fHCiSiIEe7H6UHevo8P/p8=
=3ZoL
-----END PGP SIGNATURE-----

--d2rl2hxcti2s7kgj--
