Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40AC768FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjGaIOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjGaIOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45946E5A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690791099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fuCYmnkImjZJwJ5RKqoRGV3s3QJX4IXBsMMwCatHIDg=;
        b=LuhqBse7MabrdnnZdl3AYqtPTsyTyahrH1d9MU5HNdzmhTZu0HCRXMbyNzxR3MeKVM5xEw
        SdtvckRxISdHU97oSt5tHxd1jNBSONQpVUiQHywL/kZryERGI3Y48ELNTAn8ROZ9MTEHey
        LTVj/W/aypwpmQKoa3Pja94eid7Aj3o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-5uF_wT9KOJ-HBpkLT3XPsw-1; Mon, 31 Jul 2023 04:11:37 -0400
X-MC-Unique: 5uF_wT9KOJ-HBpkLT3XPsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E33BB803FEF;
        Mon, 31 Jul 2023 08:11:36 +0000 (UTC)
Received: from butterfly.localnet (unknown [10.45.224.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CFDA2166B25;
        Mon, 31 Jul 2023 08:11:35 +0000 (UTC)
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
Subject: Re: [PATCH 2/3] scsi: qedf: do not touch __user pointer in
 qedf_dbg_debug_cmd_read() directly
Date:   Mon, 31 Jul 2023 10:11:33 +0200
Message-ID: <5955796.lOV4Wx5bFT@redhat.com>
Organization: Red Hat
In-Reply-To: <2938f701ba56419e861f1bb410831862@AcuMS.aculab.com>
References: <20230728065819.139694-1-oleksandr@redhat.com>
 <20230728065819.139694-3-oleksandr@redhat.com>
 <2938f701ba56419e861f1bb410831862@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4846980.31r3eYUQgx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        GUARANTEED_100_PERCENT,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4846980.31r3eYUQgx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@redhat.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 31 Jul 2023 10:11:33 +0200
Message-ID: <5955796.lOV4Wx5bFT@redhat.com>
Organization: Red Hat
In-Reply-To: <2938f701ba56419e861f1bb410831862@AcuMS.aculab.com>
MIME-Version: 1.0

Hello/

On p=C3=A1tek 28. =C4=8Dervence 2023 17:26:11 CEST David Laight wrote:
> From: Oleksandr Natalenko
> > Sent: 28 July 2023 07:58
> >=20
> > The qedf_dbg_debug_cmd_read() function invokes sprintf()
> > directly on a __user pointer, which may crash the kernel.
>                                       ^^^ will

I don't think it is 100% guaranteed, but for sure this is not a correct beh=
aviour.

> >=20
> > Avoid doing that by using a small on-stack buffer for sprintf()
> > and then calling simple_read_from_buffer() which does a proper
> > copy_to_user() call.
> ...
> > diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_=
debugfs.c
> > index 4d1b99569d490..f910af0029a2c 100644
> > --- a/drivers/scsi/qedf/qedf_debugfs.c
> > +++ b/drivers/scsi/qedf/qedf_debugfs.c
> > @@ -138,15 +138,14 @@ qedf_dbg_debug_cmd_read(struct file *filp, char _=
_user *buffer, size_t count,
> >  			loff_t *ppos)
> >  {
> >  	int cnt;
> > +	char cbuf[35];
>=20
> Why 35?
> I pick a multiple of 8 that if 'enough.

OK, I overestimated this, it should have been 27, but I'll make it 32 to be=
 a multiple of 8.

Thanks.

> >  	struct qedf_dbg_ctx *qedf_dbg =3D
> >  				(struct qedf_dbg_ctx *)filp->private_data;
> >=20
> >  	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "debug mask=3D0x%x\n", qedf_deb=
ug);
> > -	cnt =3D sprintf(buffer, "debug mask =3D 0x%x\n", qedf_debug);
> > +	cnt =3D sprintf(cbuf, "debug mask =3D 0x%x\n", qedf_debug);
>=20
> Use scnprintf() to be sure it doesn't overflow.
> Much safer if someone does a quick update or copies the code.
>=20
> 	David
>=20
> >=20
> > -	cnt =3D min_t(int, count, cnt - *ppos);
> > -	*ppos +=3D cnt;
> > -	return cnt;
> > +	return simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
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
--nextPart4846980.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEENQb0bxzeq+SMr0+vn464/xkP+AUFAmTHbLUACgkQn464/xkP
+AUbUg//Y5nvNFmiZz3xpfG0OcvALZ1+SByBMm4YAcq9G73iffGFVhiztDU/fauw
3NuWUvndV88ywS9zTTIL2Bv+yFJo3yx7RJOovaYxaUA8Iw2lu530XSfy7Th3BRVE
qpeQ/b6yzsJpq6eY8pWTM0qJkj78D6zeclFh4iGy8k0+DukUQjsjayvYeQFJdRex
4cDUos7e9N4LkIAgMnaE6z8VYI2TJX7qSbK93VNao/XcASBpH9eEXo9pXAsFNIjV
6aEYJOeMeCo1mfeqjQt6WMtADTqjyY1kTN8idUoRYvErWXDJDzmdIEkxElfw7vPD
QTZE10ggiWFcV+HXUXJf516TFfsOdHxvIQr176lfUqehb0HMQwarVvLq55tBYAph
ZM/4GQG0lifgptZIetQxV6ySTSYk8AuTwOkMCSwEe9rQqz4JN1MJDKogApUDMdEy
2IBy9MxmX9K/FBnktEs5i9TG6jeLjOj50zx8i2SQ/P/hPuA90gtsUdQ1xIN6UJ7X
1vycNlKK2CmfbvNLhDxwXrunjChjXZiRE/4FifpjgFO1ynr+n2nhtDF369jkC+Y3
KZNPns4pVQOEj6HUDMEuMcfIk0YtMeZCUyhbXepUlmo0qLkDPiPtGBrpBmt9WPZu
kvFo1Mj+JzsGCh41ra1SFNMjL8n0ii0NVV6ofriV7KKkBgxn5II=
=loJJ
-----END PGP SIGNATURE-----

--nextPart4846980.31r3eYUQgx--



