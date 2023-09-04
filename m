Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60377917D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349514AbjIDNL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbjIDNL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:11:58 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC264B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 06:11:51 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230904131148euoutp016a3fc43fe6982bd289757fe1d388c90a~BtDzKdcev0547605476euoutp01y;
        Mon,  4 Sep 2023 13:11:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230904131148euoutp016a3fc43fe6982bd289757fe1d388c90a~BtDzKdcev0547605476euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693833108;
        bh=iMpaxlraNrwSut3kI6JQUwwpWA322KAAE7VPI1Trx8c=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=jIg6GMEznXyk+SxfOo1URpADehrc7IAjm9f9kKWz47rbq884vVKSe7q6Uw0hMAZ0j
         D4Rq2nxBsV2ciLS0yg18kpw6JstjI+4Zyi/jkrpsT5Osp58D7G0+lghLgCfsl+Oyyg
         fgpaelPI7xczTqVri/bpn4JNPiYW4G3smW0jIcc4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230904131147eucas1p27e15573ea6c7f6df02a3b8c881542b0a~BtDy62XMo3070330703eucas1p2W;
        Mon,  4 Sep 2023 13:11:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C3.C1.37758.397D5F46; Mon,  4
        Sep 2023 14:11:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230904131147eucas1p29cb4fd0a357def778c8ab237ae037736~BtDyhTTlE2643026430eucas1p2j;
        Mon,  4 Sep 2023 13:11:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230904131147eusmtrp11634adf12b38ba47a2b3f4972aa31df0~BtDygtzk91193711937eusmtrp1Z;
        Mon,  4 Sep 2023 13:11:47 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-73-64f5d79317a7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 67.42.10549.397D5F46; Mon,  4
        Sep 2023 14:11:47 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230904131147eusmtip2a048a4df2ef548af41ef2d8b0b34e679~BtDyVrKgx2031720317eusmtip2X;
        Mon,  4 Sep 2023 13:11:47 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 4 Sep 2023 14:11:46 +0100
Date:   Mon, 4 Sep 2023 15:11:45 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v1 1/3] parport: Use kasprintf() instead of fixed buffer
 formatting
Message-ID: <20230904131145.tp4umorb3t25tmsq@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="c5hkprao7t3bkepg"
Content-Disposition: inline
In-Reply-To: <20230901134250.1172990-1-andriy.shevchenko@linux.intel.com>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7djP87qTr39NMVj1Td2it2k6k8XlXXPY
        LG5MeMpoceD0FGYHFo+ds+6ye2xa1cnmMe9koMfnTXIBLFFcNimpOZllqUX6dglcGc2f9rEU
        rLarOHm5n6WBcaJJFyMHh4SAicTN765djFwcQgIrGCVedBxi6WLkBHK+MEpM+28EkfjMKPFj
        +xSwBEjDudVfWSASyxklVn2fwApX1ffmOStE+2Yg55oDiM0ioCLx8fs8ZhCbTUBH4vybO2C2
        iIC5xLpJi9hAbGaBCon+A9PBeoUFIiX+LtzLBGLzAtX8OvmPDcIWlDg58wkLTP3MdfeZQF5g
        FpCWWP6PAyTMKeApsbppFzvEoUoSX9/0skLYtRKnttxiArlTQmA6p8SafdeZIRIuEktWbWaD
        sIUlXh3fAtUsI3F6cg8LRMNkRon9/z6wQzirGSWWNX5lgqiylmi58gSqw1Gia/F3dkig8knc
        eCsIcSifxKRt05khwrwSHW1CENVqEqvvvWGZwKg8C8lrs5C8NgvhNYiwlcSsxsUsGMI6Egt2
        f2LDENaWWLbwNTOErSvRdewA1HBLiUf/r7BgqrGVWLfuPcsCRp5VjOKppcW56anFxnmp5XrF
        ibnFpXnpesn5uZsYgUnx9L/jX3cwrnj1Ue8QIxMH4yFGFaDmRxtWX2CUYsnLz0tVEuGV0/6U
        IsSbklhZlVqUH19UmpNafIhRmoNFSZxX2/ZkspBAemJJanZqakFqEUyWiYNTqoGJ+5Th9VAL
        11vHFXZss+qobRT55TvnbYy2/qE7pd/uPI8qUReeulktbm/4BaF6wS8eWp5H5+5tuVgpIpUf
        l7bBI6HI5+/0mJdBga+fWluxbfLN0E9KtMw4ebP29IOzosI/F3Zwx3+JZzj6883Syj1uK7OW
        z2IL8XC584v55t28s/u+xvVytU+/vinoe3/V0juMZ4LiBOpOia8/HGXv7rriFouOQ+T8jEhN
        L00Dh7l89n6+Pjf+hHToWKjK8RwP7W1X/VKgt3Vy+L+F7C2f53Ae2njtuVpOIOP3bu2dmV8X
        1a3f8yzg0Nf0ojOPzR6HnrNW6km7+fCl4tukloJ9Uzi/7J16VDWq8o5Y+aX21sNKLMUZiYZa
        zEXFiQAneCPZBQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e/4Pd3J17+mGMxbIWjR2zSdyeLyrjls
        FjcmPGW0OHB6CrMDi8fOWXfZPTat6mTzmHcy0OPzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9
        Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jFeT/jAWrLSrmDZrN3MDY69JFyMnh4SA
        icS51V9Zuhi5OIQEljJKHHy/lA0iISOx8ctVVghbWOLPtS42iKKPjBITdt6AcjYzSuzt/McO
        UsUioCLx8fs8ZhCbTUBH4vybO2C2iIC5xLpJi8CmMgtUSPQfmA42VVggUuLvwr1MIDYvUM2v
        k/+ghs5hlJg2Yz0zREJQ4uTMJ0D3cQA1l0ms6ZGGMKUllv/jAKngFPCUWN20ix3iUCWJr296
        oY6ulfj89xnjBEbhWUgGzUIYNAth0Cyw26wkZjUuZsEQ1pK48e8lE4awtsSyha+ZYeyHE6cy
        QdiWEo/+X2HBVGMrsW7de5YFjDyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAlPDtmM/N+9g
        nPfqo94hRiYOxkOMKkCdjzasvsAoxZKXn5eqJMIrp/0pRYg3JbGyKrUoP76oNCe1+BCjKTD4
        JzJLiSbnA5NWXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QD06ol
        1rlNYZuPZhbwL64+seA9p2au/Z1F+x+vuasWu9ROSkTQ9WPQqjjeQ7cfvf9TqzqnquH4x1yJ
        5JTt0tJrDnkvtu1+cf/7/U+Sq76mH502t2mOnFxhb/qFF7lrbObY3rSzv73ZSrnzVaXG3Jv/
        VjLvKn1Z/87/1Q6BtVx1O9yllHLEnpXyL8gumsfdcERs+TaFhokL77Crz57nVKi1MW6XrvH7
        Tb9VI2Tf/jzP8MMyR01TUE9oR/rjjTpXnNT/37j4WmmfoONEoeqodTf7f894fO683JW62Ve9
        t2/k1z7zb+30+asXyBiXesaqP5myLvx1cwxvGrc610E9tjkzFZ0O3Nttk/GsmtF3Oa8je78S
        S3FGoqEWc1FxIgBOsYa3ogMAAA==
X-CMS-MailID: 20230904131147eucas1p29cb4fd0a357def778c8ab237ae037736
X-Msg-Generator: CA
X-RootMTR: 20230901134310eucas1p1d9be610c894d46f19bb6c12576aef94b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230901134310eucas1p1d9be610c894d46f19bb6c12576aef94b
References: <CGME20230901134310eucas1p1d9be610c894d46f19bb6c12576aef94b@eucas1p1.samsung.com>
        <20230901134250.1172990-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--c5hkprao7t3bkepg
Content-Type: multipart/mixed; boundary="gcfvjs5in7dsexwz"
Content-Disposition: inline

--gcfvjs5in7dsexwz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 04:42:48PM +0300, Andy Shevchenko wrote:
> Improve readability and maintainability by replacing a hardcoded string
> allocation and formatting by the use of the kasprintf() helper.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/parport/procfs.c | 53 +++++++---------------------------------
>  drivers/parport/share.c  | 15 +++++-------
>  include/linux/parport.h  |  2 --
>  3 files changed, 15 insertions(+), 55 deletions(-)
>=20
> diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
> index 4e5b972c3e26..7aa99c65b934 100644
> --- a/drivers/parport/procfs.c
> +++ b/drivers/parport/procfs.c
> @@ -32,13 +32,6 @@
>  #define PARPORT_MAX_TIMESLICE_VALUE ((unsigned long) HZ)
>  #define PARPORT_MIN_SPINTIME_VALUE 1
>  #define PARPORT_MAX_SPINTIME_VALUE 1000
> -/*
> - * PARPORT_BASE_* is the size of the known parts of the sysctl path
> - * in dev/partport/%s/devices/%s. "dev/parport/"(12), "/devices/"(9
> - * and null char(1).
> - */
> -#define PARPORT_BASE_PATH_SIZE 13
> -#define PARPORT_BASE_DEVICES_PATH_SIZE 22
> =20
>  static int do_active_device(struct ctl_table *table, int write,
>  		      void *result, size_t *lenp, loff_t *ppos)
> @@ -431,8 +424,7 @@ int parport_proc_register(struct parport *port)
>  {
>  	struct parport_sysctl_table *t;
>  	char *tmp_dir_path;
> -	size_t tmp_path_len, port_name_len;
> -	int bytes_written, i, err =3D 0;
> +	int i, err =3D 0;
> =20
>  	t =3D kmemdup(&parport_sysctl_template, sizeof(*t), GFP_KERNEL);
>  	if (t =3D=3D NULL)
> @@ -446,35 +438,23 @@ int parport_proc_register(struct parport *port)
For this function I would even go a step further and start with the two
kasprintf calls so we can then free them in the reverse order. And then
leave the rest as it is. I attached an untested diff that applies on
top of your changes to show you what I mean.

>  		t->vars[5 + i].extra2 =3D &port->probe_info[i];
>  	}
> =20
> -	port_name_len =3D strnlen(port->name, PARPORT_NAME_MAX_LEN);
> -	/*
> -	 * Allocate a buffer for two paths: dev/parport/PORT and dev/parport/PO=
RT/devices.
> -	 * We calculate for the second as that will give us enough for the firs=
t.
> -	 */
> -	tmp_path_len =3D PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len;
> -	tmp_dir_path =3D kzalloc(tmp_path_len, GFP_KERNEL);
> +	tmp_dir_path =3D kasprintf(GFP_KERNEL, "dev/parport/%s/devices", port->=
name);
>  	if (!tmp_dir_path) {
>  		err =3D -ENOMEM;
>  		goto exit_free_t;
>  	}
> =20
> -	bytes_written =3D snprintf(tmp_dir_path, tmp_path_len,
> -				 "dev/parport/%s/devices", port->name);
> -	if (tmp_path_len <=3D bytes_written) {
> -		err =3D -ENOENT;
> -		goto exit_free_tmp_dir_path;
> -	}
>  	t->devices_header =3D register_sysctl(tmp_dir_path, t->device_dir);
>  	if (t->devices_header =3D=3D NULL) {
>  		err =3D -ENOENT;
>  		goto  exit_free_tmp_dir_path;
>  	}
> =20
> -	tmp_path_len =3D PARPORT_BASE_PATH_SIZE + port_name_len;
> -	bytes_written =3D snprintf(tmp_dir_path, tmp_path_len,
> -				 "dev/parport/%s", port->name);
> -	if (tmp_path_len <=3D bytes_written) {
> -		err =3D -ENOENT;
> +	kfree(tmp_dir_path);
> +
> +	tmp_dir_path =3D kasprintf(GFP_KERNEL, "dev/parport/%s", port->name);
> +	if (!tmp_dir_path) {
> +		err =3D -ENOMEM;
>  		goto unregister_devices_h;
>  	}
> =20
> @@ -514,34 +494,22 @@ int parport_proc_unregister(struct parport *port)
> =20
>  int parport_device_proc_register(struct pardevice *device)
>  {
> -	int bytes_written, err =3D 0;
>  	struct parport_device_sysctl_table *t;
>  	struct parport * port =3D device->port;
> -	size_t port_name_len, device_name_len, tmp_dir_path_len;
>  	char *tmp_dir_path;

=2E..

> diff --git a/include/linux/parport.h b/include/linux/parport.h
> index 999eddd619b7..fff39bc30629 100644
> --- a/include/linux/parport.h
> +++ b/include/linux/parport.h
> @@ -180,8 +180,6 @@ struct ieee1284_info {
>  	struct semaphore irq;
>  };
> =20
> -#define PARPORT_NAME_MAX_LEN 15
This variable protected against port->name not ending in '\0'. Anyone
worried that kasprintf could be unbounded?

> -
>  /* A parallel port */
>  struct parport {
>  	unsigned long base;	/* base address */
> --=20
> 2.40.0.1.gaa8946217a0b
>=20

--=20

Joel Granados

--gcfvjs5in7dsexwz
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment; filename="parport.patch"
Content-Transfer-Encoding: quoted-printable

diff --git i/drivers/parport/procfs.c w/drivers/parport/procfs.c
index 7aa99c65b934..0e3b01368aec 100644
--- i/drivers/parport/procfs.c
+++ w/drivers/parport/procfs.c
@@ -423,12 +423,24 @@ parport_default_sysctl_table =3D {
 int parport_proc_register(struct parport *port)
 {
 	struct parport_sysctl_table *t;
-	char *tmp_dir_path;
+	char *parport_name_devices, *parport_name;
 	int i, err =3D 0;
=20
+	parport_name_devices =3D kasprintf(GFP_KERNEL, "dev/parport/%s/devices", =
port->name);
+	if (!parport_name_devices)
+		return -ENOMEM;
+
+	parport_name =3D kasprintf(GFP_KERNEL, "dev/parport/%s", port->name);
+	if (!parport_name) {
+		err =3D -ENOMEM;
+		goto exit_partport_name_devices;
+	}
+
 	t =3D kmemdup(&parport_sysctl_template, sizeof(*t), GFP_KERNEL);
-	if (t =3D=3D NULL)
-		return -ENOMEM;
+	if (t =3D=3D NULL) {
+		err =3D -ENOMEM;
+		goto exit_parport_name;
+	}
=20
 	t->device_dir[0].extra1 =3D port;
=20
@@ -438,27 +450,13 @@ int parport_proc_register(struct parport *port)
 		t->vars[5 + i].extra2 =3D &port->probe_info[i];
 	}
=20
-	tmp_dir_path =3D kasprintf(GFP_KERNEL, "dev/parport/%s/devices", port->na=
me);
-	if (!tmp_dir_path) {
-		err =3D -ENOMEM;
-		goto exit_free_t;
-	}
-
-	t->devices_header =3D register_sysctl(tmp_dir_path, t->device_dir);
+	t->devices_header =3D register_sysctl(parport_name_devices, t->device_dir=
);
 	if (t->devices_header =3D=3D NULL) {
 		err =3D -ENOENT;
-		goto  exit_free_tmp_dir_path;
+		goto exit_free_t;
 	}
=20
-	kfree(tmp_dir_path);
-
-	tmp_dir_path =3D kasprintf(GFP_KERNEL, "dev/parport/%s", port->name);
-	if (!tmp_dir_path) {
-		err =3D -ENOMEM;
-		goto unregister_devices_h;
-	}
-
-	t->port_header =3D register_sysctl(tmp_dir_path, t->vars);
+	t->port_header =3D register_sysctl(parport_name, t->vars);
 	if (t->port_header =3D=3D NULL) {
 		err =3D -ENOENT;
 		goto unregister_devices_h;
@@ -466,17 +464,19 @@ int parport_proc_register(struct parport *port)
=20
 	port->sysctl_table =3D t;
=20
-	kfree(tmp_dir_path);
-	return 0;
+	goto exit_parport_name;
=20
 unregister_devices_h:
 	unregister_sysctl_table(t->devices_header);
=20
-exit_free_tmp_dir_path:
-	kfree(tmp_dir_path);
-
 exit_free_t:
 	kfree(t);
+
+exit_parport_name:
+	kfree(parport_name);
+
+exit_partport_name_devices:
+	kfree(parport_name_devices);
 	return err;
 }
=20

--gcfvjs5in7dsexwz--

--c5hkprao7t3bkepg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmT113wACgkQupfNUreW
QU9s2wv+M4/gR2ggBzJQcRG2gwOrNhZSNWpY5cw9mNhH8eUNbrY3M+wTlXyJ+ywc
SXKzrf2doVS4OjUnBi3gstugGI+A7cIxqX5iBk0YyHqU92hTqi/bEcKMRV7KjA+k
d1v1+jEUEqw6pJ4t0hXAY2EH9eCIHnCzrOr0qcyr9V6HrhhbXGsO+Mcwr65oIkxp
j4TwmSUrAlqDrXOOeKhA22gXj1op/cssKCP2x/ftMsCctlBo6w4zuXVXerPevINy
Kyfbf1BuWkU/jtdv1Z7WRj4DiuFppxN2xXgP2l/6IyfyFxdh/wB6sq81zFtBs4ls
RQcI8Y3PQ+mBpcezumQidlOSZ4otCRpQF+L4EcAcK7w3A7foOpisLlYP2j+/t9lv
f1ObDnHENmQFQQiQbu8vu33MkufNIWtXEx3/LvH/2tG2aPe8gGFbcDQfmpTWNNQm
7+16AhB7WOnv//2TtAYw268X7Mq6c5Rsj0oTtqV7y3TnpkQXY5PJeg6OQB72FvJj
k6O4rH+m
=/4Of
-----END PGP SIGNATURE-----

--c5hkprao7t3bkepg--
