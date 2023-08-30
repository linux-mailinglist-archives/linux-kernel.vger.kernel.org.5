Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EE778E1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243464AbjH3V4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243486AbjH3V4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D759710CC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693432443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3HX1XPusXsYUn8qwS78j9iWd+RejhkFGAbo+CjD/nNY=;
        b=F40XvdpVL1Ujoj8/dorAyKpA0qlSyerGUL1XQw/ixAuhscQmO6hvpr9sAw0q5pw3EtSdV1
        XzMhomJdT2PNDoP9coG4zhjmGdPReIf2PwBakvkNAzR/X1RGtHqc9Gzxvw4OlRmnVOAQZ1
        KU6VLME+EayxpNkgEgiLtqaLzyDBsv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-tvoA4VHqPCKOkOaRi-jgTQ-1; Wed, 30 Aug 2023 17:53:59 -0400
X-MC-Unique: tvoA4VHqPCKOkOaRi-jgTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25D618022E4;
        Wed, 30 Aug 2023 21:53:59 +0000 (UTC)
Received: from localhost (unknown [10.39.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CC549A;
        Wed, 30 Aug 2023 21:53:58 +0000 (UTC)
Date:   Wed, 30 Aug 2023 17:53:57 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 0/3] vfio: use __aligned_u64 for ioctl structs
Message-ID: <20230830215357.GB480691@fedora>
References: <20230829182720.331083-1-stefanha@redhat.com>
 <3e8b6e0503a84c93b6dd44c0d311abfe@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M3JpRe0KuvJhXfGH"
Content-Disposition: inline
In-Reply-To: <3e8b6e0503a84c93b6dd44c0d311abfe@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M3JpRe0KuvJhXfGH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 09:10:06PM +0000, David Laight wrote:
> From: Stefan Hajnoczi
> > Sent: 29 August 2023 19:27
> >=20
> > v2:
> > - Rebased onto https://github.com/awilliam/linux-vfio.git next to get t=
he
> >   vfio_iommu_type1_info pad field [Kevin]
> > - Fixed min(minsz, sizeof(dmabuf)) -> min(dmabuf.argsz, sizeof(dmabuf))=
 [Jason, Kevin]
>=20
> You managed to use min_t() instead of fixing the types to match.

I'm not sure what you're referring to here. Can you explain which line
of code and what you'd like to see changed?

Stefan

--M3JpRe0KuvJhXfGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTvunUACgkQnKSrs4Gr
c8hdNQgAlLEgKLTxkMeE1a7Gk9wV1MzGlrGOgGXZ2SHLcuLtDF1qZ5Ou1HUL9yDq
m2jSfzUODCUBZsHVyJpArItEZlSn6v0//65oOqULxXVG3e+rRXaUL7YIYSlbnA8Y
p8XZ7hxVMEqCdvnnsQHpIDixrBnEZuqCTX7gT6rf4Zv7ELFgS76NmpoF4WMD7ZLo
LdAwLGzc2P03WyIRtXD5qWSjWi5SVSE4x5q0w8/YHIe9+lwfdo5CnSn5i+wi8Qa1
OVrN82DU2H+rgFFEUh61V9WRJ+PUZfWvoLT3Ejydcs+845PBofGfzAnMxLHfvX6g
+9EEa0AckkeHi18G93l8L8OQbCZgLQ==
=1+4Y
-----END PGP SIGNATURE-----

--M3JpRe0KuvJhXfGH--

