Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450847664C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjG1HGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjG1HGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFD83A98
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690527916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eStZcsMFW/4qo0fJ7oZgkDyLSnql7+GMuEiHM+0Fe8o=;
        b=ZHdm4LtwqtHfMZqyfp9Y0RFUWqBdLzXztnNel84TLKGyYcT6mlkQHdmByl2XnGOlzawBQM
        xoLVK1hJ8sKWzGlPx7pgpZ2r5i5zH/xQKRAekIWQ58R2jMUv8U4BXDuuv8LverKWZq30m1
        KJVe59BC2atqKoPVWfDQRgW5tlQL6fM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-R48UXjVAMeawoOaDgTXOHg-1; Fri, 28 Jul 2023 03:05:11 -0400
X-MC-Unique: R48UXjVAMeawoOaDgTXOHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 384E685A58A;
        Fri, 28 Jul 2023 07:05:11 +0000 (UTC)
Received: from butterfly.localnet (unknown [10.45.224.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 922EB1121330;
        Fri, 28 Jul 2023 07:05:09 +0000 (UTC)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, Saurav Kashyap <skashyap@marvell.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jozef Bacik <jobacik@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Rob Evers <revers@redhat.com>
Subject: Re: [PATCH 0/3] scsi: qedf: sanitise uaccess
Date:   Fri, 28 Jul 2023 09:05:07 +0200
Message-ID: <3240893.aeNJFYEL58@redhat.com>
Organization: Red Hat
In-Reply-To: <20230728065819.139694-1-oleksandr@redhat.com>
References: <20230728065819.139694-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3247109.44csPzL39Z";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3247109.44csPzL39Z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] scsi: qedf: sanitise uaccess
Date: Fri, 28 Jul 2023 09:05:07 +0200
Message-ID: <3240893.aeNJFYEL58@redhat.com>
Organization: Red Hat
In-Reply-To: <20230728065819.139694-1-oleksandr@redhat.com>
References: <20230728065819.139694-1-oleksandr@redhat.com>
MIME-Version: 1.0

On p=C3=A1tek 28. =C4=8Dervence 2023 8:58:16 CEST Oleksandr Natalenko wrote:
> qedf driver, debugfs part of it specifically, touches __user pointers
> directly for printing out info to userspace via sprintf(), which may
> cause crash like this:
>=20
> BUG: unable to handle kernel paging request at 00007ffd1d6b43a0
> IP: [<ffffffffaa7a882a>] string.isra.7+0x6a/0xf0
> Oops: 0003 [#1] SMP
> Call Trace:
>  [<ffffffffaa7a9f31>] vsnprintf+0x201/0x6a0
>  [<ffffffffaa7aa556>] sprintf+0x56/0x80
>  [<ffffffffc04227ed>] qedf_dbg_stop_io_on_error_cmd_read+0x6d/0x90 [qedf]
>  [<ffffffffaa65bb2f>] vfs_read+0x9f/0x170
>  [<ffffffffaa65cb82>] SyS_pread64+0x92/0xc0
>=20
> Avoid this by preparing the info in a kernel buffer first, either
> allocated on stack for small printouts, or via vmalloc() for big ones,
> and then copying it to the userspace properly.
>=20
> Previous submission is an RFC: [1]. There are no code changes since
> then. The RFC prefix is dropped. The Tested-by tag from Laurence is
> added.
>=20
> There's similar submission from Saurav [2], but we agreed I could nack
> it and proceed with my one.
>=20
> [1] https://lore.kernel.org/linux-scsi/20230724120241.40495-1-oleksandr@r=
edhat.com/
> [2] https://lore.kernel.org/linux-scsi/20230726101236.11922-1-skashyap@ma=
rvell.com/
>=20
> Oleksandr Natalenko (3):
>   scsi: qedf: do not touch __user pointer in
>     qedf_dbg_stop_io_on_error_cmd_read() directly
>   scsi: qedf: do not touch __user pointer in qedf_dbg_debug_cmd_read()
>     directly
>   scsi: qedf: do not touch __user pointer in qedf_dbg_fp_int_cmd_read()
>     directly
>=20
>  drivers/scsi/qedf/qedf_dbg.h     |  2 ++
>  drivers/scsi/qedf/qedf_debugfs.c | 35 +++++++++++++++++++-------------
>  2 files changed, 23 insertions(+), 14 deletions(-)
>=20
>=20

Oops, I forgot to add:

Reviewed-by: Laurence Oberman <loberman@redhat.com>

as per [1].

My ask to the maintainer to add it if the submission is accepted, or let me=
 know if I should do a v2 instead.

[1] https://lore.kernel.org/linux-scsi/4f35b02968a18e636e1689c9d52729ef63a4=
38f9.camel@redhat.com/

=2D-=20
Oleksandr Natalenko (post-factum)
Principal Software Maintenance Engineer
--nextPart3247109.44csPzL39Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEENQb0bxzeq+SMr0+vn464/xkP+AUFAmTDaKMACgkQn464/xkP
+AVqDxAAmwO7k1gqDBcgpEupflAyGWPImXduaqsyM574mMzLHI017uhOy+iCAl0W
CiCfoIs5EGu1YdQc0RFB3qvCczLdBlb9d8K8KHD3Fx8v2Bl7acl38wJwfCqiV7V7
akS02IPqsD4liT4/U9KYogXqejYp3PXI7u3uGorSG0FGLrZhTRNKO4H1/myAm8PX
6+p7leJIJLdNRrqdif2p8zImQtRjbGFLJQhmLyy1L257w6To7tTESawChWkUmNpL
hppdTgVzzddSx2XSZvHm/sdyoj1y5xhBqAcGIaANDEDiJWS3dwhGMBV4sX5zI/PU
9E4hTq/Yq3fdSIphjlh8dV75HhFoGCpLr4sjvI/7lxVzQqksjkN1etSsU+e5ZXB3
v9/6Quf3bu1UwAFpJ4HvYC6rCwrLgC+reMWUKSlBsaYQzIY/Q2N0+geTpqCS99Mx
4+sM7/ks2ncU8AQkALL/cYq+NSLJS49Hni8kVnGDBx5KPJrzdBGIS353+IR6qa5q
4VBbDLDsMVQp/WUqJafvrymmnzqV7nCIyMWDxyrjCqeTBMM081je/uFrnRhrfK/E
0+NGsiGcSay03Ier6s7yZ/lwce7uzXQVVfyXowCgYmtguLdrCTZiqITEISt33JN3
rb8iLswNA6Kfb4gAcIKGFN3IJhKG0PdUz8j1HAk0w1XWsTm15ME=
=7C6A
-----END PGP SIGNATURE-----

--nextPart3247109.44csPzL39Z--



