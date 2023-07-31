Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448B9768F79
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjGaID5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjGaIDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DB5E7B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690790523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=72q4lz0Tbh4St16jS4aYSQ3HaSSrFI82ffLJTmWDSLw=;
        b=f5UPxKLU7Eo6z+8PGAT/IXHPceZ6fF7PQQ5N/+mHvnGot5UF6jeLDhsCLFpX5/TQvwJV5Q
        AdvDwiwrSS0mBV0XZuD3EGqjEkkwoW39F5XZ11Qi7vSTJMzlttxbGql6wyFRvIqIq50ESg
        wC9L+nYQikx/5hfzWWjSJi2J1lI+vY8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-zUkbplYRNM6ni_8dlaLNPQ-1; Mon, 31 Jul 2023 04:01:57 -0400
X-MC-Unique: zUkbplYRNM6ni_8dlaLNPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 355331044593;
        Mon, 31 Jul 2023 08:01:57 +0000 (UTC)
Received: from butterfly.localnet (unknown [10.45.224.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91DEE2166B25;
        Mon, 31 Jul 2023 08:01:55 +0000 (UTC)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Saurav Kashyap <skashyap@marvell.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "GR-QLogic-Storage-Upstream@marvell.com" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jozef Bacik <jobacik@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Rob Evers <revers@redhat.com>
Subject: Re: [PATCH 1/3] scsi: qedf: do not touch __user pointer in
 qedf_dbg_stop_io_on_error_cmd_read() directly
Date:   Mon, 31 Jul 2023 10:01:46 +0200
Message-ID: <2690368.mvXUDI8C0e@redhat.com>
Organization: Red Hat
In-Reply-To: <314512939ebd44508b767d799e7c30af@AcuMS.aculab.com>
References: <20230728065819.139694-1-oleksandr@redhat.com>
 <20230728065819.139694-2-oleksandr@redhat.com>
 <314512939ebd44508b767d799e7c30af@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12254412.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12254412.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@redhat.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 31 Jul 2023 10:01:46 +0200
Message-ID: <2690368.mvXUDI8C0e@redhat.com>
Organization: Red Hat
In-Reply-To: <314512939ebd44508b767d799e7c30af@AcuMS.aculab.com>
MIME-Version: 1.0

Hello.

On p=C3=A1tek 28. =C4=8Dervence 2023 17:23:25 CEST David Laight wrote:
> From: Oleksandr Natalenko
> > Sent: 28 July 2023 07:58
> >=20
> > The qedf_dbg_stop_io_on_error_cmd_read() function invokes sprintf()
> > directly on a __user pointer, which may crash the kernel.
> >=20
> > Avoid doing that by using a small on-stack buffer for sprintf()
> > and then calling simple_read_from_buffer() which does a proper
> > copy_to_user() call.
> >=20
> > Fixes: 61d8658b4a ("scsi: qedf: Add QLogic FastLinQ offload FCoE driver=
 framework.")
> ...
> > diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_=
debugfs.c
> > index a3ed681c8ce3f..4d1b99569d490 100644
> > --- a/drivers/scsi/qedf/qedf_debugfs.c
> > +++ b/drivers/scsi/qedf/qedf_debugfs.c
> > @@ -185,18 +185,17 @@ qedf_dbg_stop_io_on_error_cmd_read(struct file *f=
ilp, char __user *buffer,
> >  				   size_t count, loff_t *ppos)
> >  {
> >  	int cnt;
> > +	char cbuf[7];
> >  	struct qedf_dbg_ctx *qedf_dbg =3D
> >  				(struct qedf_dbg_ctx *)filp->private_data;
> >  	struct qedf_ctx *qedf =3D container_of(qedf_dbg,
> >  	    struct qedf_ctx, dbg_ctx);
> >=20
> >  	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "entered\n");
> > -	cnt =3D sprintf(buffer, "%s\n",
> > +	cnt =3D sprintf(cbuf, "%s\n",
> >  	    qedf->stop_io_on_error ? "true" : "false");
>=20
> You've made cbuf[] exactly just big enough.
> If anyone breathes on this code it could overflow.
> You really should use scnprintf() for safety.

OK, I'll do scnprintf(cbuf, sizeof(cbuf), ...) in the next version of the s=
ubmission.

Thanks.

> >=20
> > -	cnt =3D min_t(int, count, cnt - *ppos);
> > -	*ppos +=3D cnt;
> > -	return cnt;
> > +	return simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
>=20
> Or just:
> 	if (gedf->stop_on_error)
> 		return simple_read_from_buffer(buffer, count, ppos, "true\n", 5);
> 	return simple_read_from_buffer(buffer, count, ppos, "false\n", 6);
>=20
> 	David
>=20
> =09
> >  }
> >=20
> >  static ssize_t
> > --
> > 2.41.0
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>=20
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
Principal Software Maintenance Engineer
--nextPart12254412.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEENQb0bxzeq+SMr0+vn464/xkP+AUFAmTHamoACgkQn464/xkP
+AVoaxAAsIK3mp8cRHCNhDUwV8SW2DusW6fa2ghZXpiTxGGH+MjnInxI6YjFZpct
XcrMfoGnX4zX08G3hzwkzLVstZb2aMoqw1eXmpKKfTewzYoAms8z7pjZ3oSeQ7Hm
D0vKDRADZQVrgjiUlOUS+MFJ5N7OjASUZsspvpCH1A1RRo77psoWw/ajqZAZ1vTh
mVCvtH1vCVRpTDmBoRQqrYPOpYsGvG5mTqQDH6elXdgnFYsFZKcCfCPxnHHx6cj7
UviTy/PaP+wJaUUzZ33nqYykwfVZyF2KNkSgkQUJPfAzg2QToQBIGUAospXrz8fN
PxNXTh6/Lc4iFum44YQJnJZVDjf1HbJDxFOqf+n2TGo8N3pMAihK/C34A9zOvNy6
UuSxMdLL/kAdJo/B6m/FaiqilPnbAdFboVgRM5L8EnTvGAqA2EimSsDQe2N6Y2DS
4WNLExHc57tUuicrxPa20j9yPzS3sgv/wk1nIWCpxvB6Zo5NOuGoiOl0HL1am++d
IpWZ+2cNFS6qUKphFrNW7upDjbESe6Jz1ayAtSW3InCQG2JHda4uIbAzzKSbodG8
ozKIv0EqAFMv0dxdkRHoI7Mi5wwCeghuVfaj+mChcOVkvkasXWuyZFlm8m6mZJzA
0HETWDvkWilgOn9B7oafgDXy5i60gSuJVF+TioDkMR4a8qpicsQ=
=4nAH
-----END PGP SIGNATURE-----

--nextPart12254412.O9o76ZdvQC--



