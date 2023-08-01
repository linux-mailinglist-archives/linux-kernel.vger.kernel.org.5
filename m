Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376E176A8DD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjHAGWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjHAGWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152171736
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690870876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cEXcNVC8M7lRhYW42/+g5b3GBs/QdaOQFoEqQEgH0aI=;
        b=FR5LaKIqlSB8nP+ALDbUfYULDjYa+V3oRr2izQvDWeSXLQOV2UJG9Irt4Ij/YdPeENX23X
        zJ/f2jhikx6PX/UgXwtcNg1XPw+jOTkARjYwr4bKZV0ICxmUa2YUdQDAL3lE8Q26MFWplq
        EBlVCiH8kxjR+/zUpfQalovvoWYAVyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-uK10LyYmNP2AG880KA65sA-1; Tue, 01 Aug 2023 02:21:12 -0400
X-MC-Unique: uK10LyYmNP2AG880KA65sA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F49D8631E7;
        Tue,  1 Aug 2023 06:21:12 +0000 (UTC)
Received: from butterfly.localnet (unknown [10.45.224.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83A77492B03;
        Tue,  1 Aug 2023 06:21:10 +0000 (UTC)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Saurav Kashyap <skashyap@marvell.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Laight <David.Laight@aculab.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jozef Bacik <jobacik@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Rob Evers <revers@redhat.com>
Subject: Re: [PATCH v2 0/3] scsi: qedf: sanitise uaccess
Date:   Tue, 01 Aug 2023 08:21:05 +0200
Message-ID: <2290359.ElGaqSPkdT@redhat.com>
Organization: Red Hat
In-Reply-To: <yq1edknrkfk.fsf@ca-mkp.ca.oracle.com>
References: <20230731084034.37021-1-oleksandr@redhat.com>
 <yq1edknrkfk.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4819602.GXAFRqVoOG";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4819602.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@redhat.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 0/3] scsi: qedf: sanitise uaccess
Date: Tue, 01 Aug 2023 08:21:05 +0200
Message-ID: <2290359.ElGaqSPkdT@redhat.com>
Organization: Red Hat
In-Reply-To: <yq1edknrkfk.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0

On pond=C4=9Bl=C3=AD 31. =C4=8Dervence 2023 20:43:34 CEST Martin K. Peterse=
n wrote:
>=20
> Oleksandr,
>=20
> > qedf driver, debugfs part of it specifically, touches __user pointers
> > directly for printing out info to userspace via sprintf(), which may
> > cause crash like this:
>=20
> Applied to 6.6/scsi-staging, thanks!

Thank you all.

=2D-=20
Oleksandr Natalenko (post-factum)
Principal Software Maintenance Engineer
--nextPart4819602.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEENQb0bxzeq+SMr0+vn464/xkP+AUFAmTIpFEACgkQn464/xkP
+AVGoBAApM2s3dmQ3OKGrANSHHTUgfnr0/xROPJb2VMhL3nInOgvhpfQ1/BrRU/B
AWcijQW38xTCDWkxvBJQG49PwiYKPfAqS8OWxfQebxWzr0vZJK/OQ9J6fuxAEdT0
WjCUUz6VM7f089FzI6dw2RDA8/gO6MPkOYrqlYHXw8OGFgPFpoVbJeJUpX5AR+o0
jln3dOVPaP4Y/GhEuW01wiDhRQZoVRHKY5Ay9rTutaypeItQWuCkQBP7zIEflTx3
CiubLcC6oeon6pi/9Un1St9f0PRUy6+T6F1T130hd8YfGT7vwy9XiBauEpLbQd++
s+mKn0lUkWmcsu70Orqj+94L4RiOpBrBghNzJu4OW5AiWFzcCGKUK0sJ7DWDMPEc
jrCSNntf2nhE/JzR3jpd+RsTW1aQpD09BPvJ6fasHHko66lOxflIuS/YizgicWqu
fQzi6gmT6JHLnY2lQS49bkvcQbGI5jO+FllQmHcOFwTxI36pEg3JofIUg1Ow7Fku
iEwLnX5R/Rvx4UzmOyBvBFq8YBong2kaCOgm+0B5SBn0Ha/0q26BV5lantLCE6dr
+U5WR34m7/4iJoHNBHSknw2qhv156B/TW6+z+O8Tx7BdNpV+5/CvYrvjFHs1VoBX
w5QYYVy18URpL3xBO/H1Hh9jHB9o0v8penMxN4LJvAU9RqJ028Q=
=gjDU
-----END PGP SIGNATURE-----

--nextPart4819602.GXAFRqVoOG--



