Return-Path: <linux-kernel+bounces-148528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E08A83FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D785F285C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E613D604;
	Wed, 17 Apr 2024 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JRj2KCNQ"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F77FBD2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359720; cv=none; b=lt6YsqzlGsU4t/8x8qVDhPlZG+NEDdxgNxvKEOOPy36LGXoi5tAKabJyJdXeRAQ/iacEbj5LY/OFHELvr0F3tQwi0MWsACzu3EMCm7VbY7BNtp/TYIvYwHNzV3mS7KnWnzqpK27SrwjUSWV1UyA1SplAkQe/JOsjEllRVmUfKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359720; c=relaxed/simple;
	bh=gGcYfkcOBlDKQg2F7m0trtJCxcQWptrmnmeqHFQ2y3M=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=dqNv+/oX3j91Qt3DHq1WPC1m0XX/jeEvRAowcIkpiLy7ipaFLJwtcUXRWD2CjDIytD8nMJlDRBu9qv6AVUvCe1Gz9cVFVjcTm7TmZZ55qQNbH3fBqKh0fTL57UQ6F1w7Hcf9klU1obvJ2tvxv/CrPt4D+wsalDCZcZs5p5LWPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JRj2KCNQ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240417131515euoutp02131b421081c59018291e7dc3b2eed772~HE5VMC7id1642316423euoutp02a;
	Wed, 17 Apr 2024 13:15:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240417131515euoutp02131b421081c59018291e7dc3b2eed772~HE5VMC7id1642316423euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713359715;
	bh=uBxPgqTEo2iX6hLs3MNtcO2W6a0v2bhzM2pLLlecH2c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JRj2KCNQIjzctyCJ0njNrvWy5DFCjAl33y4/LQgXz7bhZR0GLNgl2oB9CXIlhsVyB
	 QiX/w00uS7OMT8t3tNR6VELhP3uKZBMnUI59Y9mNJUyX3EorG/3nHw13WemNrwnd6m
	 3+PhVKRNvU1LtnXtr9RexeHnd7rAlK0W80YAtjb0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240417131514eucas1p23a88e2f736a59de1d7d86185b105c2f7~HE5U5BzsV2441624416eucas1p2d;
	Wed, 17 Apr 2024 13:15:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 43.BC.09624.26BCF166; Wed, 17
	Apr 2024 14:15:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240417131514eucas1p1fd8e71df34db689442fb27f09383ec73~HE5URgwWt2752227522eucas1p1w;
	Wed, 17 Apr 2024 13:15:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240417131514eusmtrp2a298727569197a9d5b17f10c75345b9e~HE5UQ6Iwz1834818348eusmtrp2e;
	Wed, 17 Apr 2024 13:15:14 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-62-661fcb62ede8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 1C.C2.09010.26BCF166; Wed, 17
	Apr 2024 14:15:14 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240417131513eusmtip2fd07eeebcd939574451de713fd2f7921~HE5T74xae0827308273eusmtip2v;
	Wed, 17 Apr 2024 13:15:13 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 17 Apr 2024 14:15:12 +0100
Date: Wed, 17 Apr 2024 15:15:07 +0200
From: Joel Granados <j.granados@samsung.com>
To: <wenyang.linux@foxmail.com>
CC: "Eric W . Biederman" <ebiederm@xmission.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, Christian Brauner
	<brauner@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] sysctl: move the extra1/2 boundary check of u8 to
 sysctl_check_table_array
Message-ID: <20240417131507.ygbgclckr3rsn5gi@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="767mxcnp7ni4jsp3"
Content-Disposition: inline
In-Reply-To: <tencent_70C2A71330E3F84D3D1F55F9521B04BD4C0A@qq.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djPc7pJp+XTDDY/17d4ffgTo8X/bS3s
	Fme6cy0u75rDZnFjwlNGi5bVu1gd2DxmN1xk8VjQc57ZY9OqTjaPz5vkPKYcamcJYI3isklJ
	zcksSy3St0vgyrhwqZ2p4Ld3xfYn+xgbGH9YdTFyckgImEj8W3+crYuRi0NIYAWjxO/HD6Gc
	L4wS59bPY4FwPjNKdDa8ZoVpOdrZygJiCwksZ5S4s0Udrmj2kxNQHZuBZh2fBDSLg4NFQFXi
	+gEBkAY2AR2J82/uMIPYIgLyEueerGIHqWcWOMoosX1+FxtIQlggReLnza2sIL28Ag4SE75X
	gIR5BQQlTs58AraYWaBC4ubpd0wgJcwC0hLL/3GAhDkFnCQ2r33LBHGnosTXxfdYIOxaiVNb
	bjGBrJIQmMwp8fTJZagiF4nW7laox4QlXh3fwg5hy0j83zkfpoFRYv+/D+wQzmpGiWWNX6G6
	rSVarjyB6nCU6Nk2BexoCQE+iRtvBSEO5ZOYtG06M0SYV6KjTQiiWk1i9b03LBMYlWcheW0W
	ktdmIbwGEdaRWLD7ExuGsLbEsoWvmSFsW4l1696zLGBkX8UonlpanJueWmyYl1quV5yYW1ya
	l66XnJ+7iRGYvk7/O/5pB+PcVx/1DjEycTAeYlQBan60YfUFRimWvPy8VCUR3hZh2TQh3pTE
	yqrUovz4otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkGpoD5ZYW3/1qVcWhF
	CVZWXTLU5Hu34ZNs4K2bVV63z35btjvCVj9++7P36RnWbzVF7Upd+wT392ZrWrMtFVhsMV18
	td75ue0llTNOTNiu59tufZkh9eXNxMdnPc5+Mt55wNzrOEvQ5OANr8x314cf6rWK/RL13uz9
	ox3XH3w+Pvnk5OvWmrv65fk03aUtlV5p/yl5ExD7ajKjeoxLPrPS7OXzi2rq1VYt3vov/SpD
	d2S4+IWa9Md9538VreuduGLj1yvRMZu+TtgbN0VILX0j31MB98VH93948/x/Kv+6BQrnJy1s
	v7Ox8faTfHE5ZjOXz4dSNfliYqJbjmtrvo5cz7Z/6mwBS5nTQlIJm27k7lViKc5INNRiLipO
	BACqDgGm2gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xe7pJp+XTDE6+ZLZ4ffgTo8X/bS3s
	Fme6cy0u75rDZnFjwlNGi5bVu1gd2DxmN1xk8VjQc57ZY9OqTjaPz5vkPKYcamcJYI3SsynK
	Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQyzjX1stc8NO7
	4v2DL8wNjN+suhg5OSQETCSOdraydDFycQgJLGWU2HBoKgtEQkZi45errBC2sMSfa11sEEUf
	GSV6bnyH6tjMKHHhzUKmLkYODhYBVYnrBwRAGtgEdCTOv7nDDGKLCMhLnHuyih2knlngKKPE
	9vkgkzg5hAVSJH7e3MoK0ssr4CAx4XsFSFhIYCqjxImnsiA2r4CgxMmZT8AOYhYok2icspEF
	pJxZQFpi+T8OkDCngJPE5rVvmSDuVJT4uvge1P21Ep//PmOcwCg8C8mkWUgmzUKYBBHWkrjx
	7yUThrC2xLKFr5khbFuJdevesyxgZF/FKJJaWpybnltspFecmFtcmpeul5yfu4kRGMPbjv3c
	soNx5auPeocYmTgYDzGqAHU+2rD6AqMUS15+XqqSCG+LsGyaEG9KYmVValF+fFFpTmrxIUZT
	YBhOZJYSTc4HJpe8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQam
	Mk8/P/PdfMUiVzW3ebhpVJv9ODyrbrLUps+5a6Penu6UWRcY1n5RbLEPb33t5vtfJxSoahY4
	Cs/z3qw734p1RtzS+deLn2h5BclKpqan2t5kW28h51eR/GLFb7mza9sqUl09z1fJMNRlVq7e
	MTdbZPJHf0PXMwoXNhpl3WdT8y5UKLq1/CqH+JSEyRl/ku9MZneqcthxO2HJdZupHaL8Xjfc
	p9i87hQwuWtRq8zYr/NX45rEo2Wtu1oeKXlFeS7gVsiPWf3MU/LfVYGVylNseTpPxi4Rc/z3
	TO2YaGV11pFWy0Z2ZtXFZbvPMZU9YrJedXhl9wcXV9eORzsMC1pv/N0Z7CxRLDdX33TGdCWW
	4oxEQy3mouJEAJbbKpV2AwAA
X-CMS-MailID: 20240417131514eucas1p1fd8e71df34db689442fb27f09383ec73
X-Msg-Generator: CA
X-RootMTR: 20240405144133eucas1p2933a5a59342a44c02330d22521dcd115
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240405144133eucas1p2933a5a59342a44c02330d22521dcd115
References: <CGME20240405144133eucas1p2933a5a59342a44c02330d22521dcd115@eucas1p2.samsung.com>
	<tencent_70C2A71330E3F84D3D1F55F9521B04BD4C0A@qq.com>

--767mxcnp7ni4jsp3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 10:40:59PM +0800, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
>=20
Please move the text describing what was done to the top. So you would
start the message like this:

"
Move boundary checking for proc_dou8ved_minmax into module loading, thereby
reporting errors in advance. And add a kunit test case ensuring the
boundary check is done correctly.
"
> The boundary check of u8's extra is currently performed at runtime.
> This may result in some kernel modules that can be loaded normally without
> any errors, but not works, as follows:
This reads funny. Please change it to something like this:
"
The boundary check in proc_dou8vec_minmax done to the extra elements in
the ctl_table struct is currently performed at runtime. This allows buggy
kernel modules to be loaded normally without any errors only to fail
when used.
"

>=20
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/sysctl.h>
Please indent the example code

>=20
> static struct ctl_table_header *_table_header;
> unsigned char _data =3D 0;
> struct ctl_table table[] =3D {
> 	{
> 		.procname       =3D "foo",
> 		.data           =3D &_data,
> 		.maxlen         =3D sizeof(u8),
> 		.mode           =3D 0644,
> 		.proc_handler   =3D proc_dou8vec_minmax,
> 		.extra1         =3D SYSCTL_ZERO,
> 		.extra2         =3D SYSCTL_ONE_THOUSAND,
> 	},
> 	{}
don't include a sentinel in your example.
> };
>=20
> static int init_demo(void) {
> 	if (!_table_header)
> 		_table_header =3D register_sysctl("kernel", table);
>=20
> 	pr_info("test: init module.\n");
> 	return 0;
> }
>=20
> static void cleanup_demo(void) {
> 	if (_table_header) {
> 		unregister_sysctl_table(_table_header);
> 	}
This is just an example. Lets remove the cleanup_demo as it does not
give any additional info

>=20
> 	pr_info("test: cleanup module.\n");
> }
>=20
> module_init(init_demo);
> module_exit(cleanup_demo);
Lets remove this "module_exit" line.
> MODULE_LICENSE("GPL");
>=20
>  # insmod test.ko
>=20
>  # cat /proc/sys/kernel/foo
>  cat: /proc/sys/kernel/foo: Invalid argument
>=20
>  # echo 1 >  /proc/sys/kernel/foo
>  -bash: echo: write error: Invalid argument
You can do with just including either read or write. No need to include
both.

So the code would end up to something like this:
"
This is a buggy example module:
        #include <linux/kernel.h>
        #include <linux/module.h>
        #include <linux/sysctl.h>

        static struct ctl_table_header *_table_header;
        unsigned char _data =3D 0;
        struct ctl_table table[] =3D {
                {
                        .procname       =3D "foo",
                        .data           =3D &_data,
                        .maxlen         =3D sizeof(u8),
                        .mode           =3D 0644,
                        .proc_handler   =3D proc_dou8vec_minmax,
                        .extra1         =3D SYSCTL_ZERO,
                        .extra2         =3D SYSCTL_ONE_THOUSAND,
                },
        };

        static int init_demo(void) {
                if (!_table_header)
                        _table_header =3D register_sysctl("kernel", table);
                return 0;
        }

        module_init(init_demo);
        MODULE_LICENSE("GPL");

And this is the result:
        # insmod test.ko
        # cat /proc/sys/kernel/foo
        cat: /proc/sys/kernel/foo: Invalid argument

"

>=20
> This patch moves boundary checking forward to module loading,
> thereby reporting errors in advance, and also adds a kunit test case.
>=20
> Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
> v3:=20
> - kunit: using register_sysctl, and thus unnecessary sentries were removed
> - kunit: using constant ctl_tables
> v2:
> - kunit: detect registration failure with KUNIT_EXPECT_NULL
>=20
>  fs/proc/proc_sysctl.c | 12 +++++++++++
>  kernel/sysctl-test.c  | 49 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/sysctl.c       | 14 ++++---------
>  3 files changed, 65 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 37cde0efee57..136e3f8966c3 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1096,6 +1096,7 @@ static int sysctl_err(const char *path, struct ctl_=
table *table, char *fmt, ...)
> =20
>  static int sysctl_check_table_array(const char *path, struct ctl_table *=
table)
>  {
> +	unsigned int extra;
>  	int err =3D 0;
> =20
>  	if ((table->proc_handler =3D=3D proc_douintvec) ||
> @@ -1107,6 +1108,17 @@ static int sysctl_check_table_array(const char *pa=
th, struct ctl_table *table)
>  	if (table->proc_handler =3D=3D proc_dou8vec_minmax) {
>  		if (table->maxlen !=3D sizeof(u8))
>  			err |=3D sysctl_err(path, table, "array not allowed");
> +
> +		if (table->extra1) {
> +			extra =3D *(unsigned int *) table->extra1;
> +			if (extra > 255U)
> +				err |=3D sysctl_err(path, table, "array not allowed");
The error message here does not make sense: It should be along the lines
of "Range value to large for proc_dou8vec_minmax"

> +		}
> +		if (table->extra2) {
> +			extra =3D *(unsigned int *) table->extra2;
> +			if (extra > 255U)
> +				err |=3D sysctl_err(path, table, "array not allowed");
Same as previous.

> +		}
>  	}
> =20
>  	if (table->proc_handler =3D=3D proc_dobool) {
> diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> index 6ef887c19c48..4e7dcc9187e2 100644
> --- a/kernel/sysctl-test.c
> +++ b/kernel/sysctl-test.c
> @@ -367,6 +367,54 @@ static void sysctl_test_api_dointvec_write_single_gr=
eater_int_max(
>  	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
>  }
> =20
> +/*
> + * Test that registering an invalid extra value is not allowed.
> + */
> +static void sysctl_test_register_sysctl_sz_invalid_extra_value(
> +		struct kunit *test)
> +{
> +	unsigned char data =3D 0;
> +	struct ctl_table table_foo[] =3D {
> +		{
> +			.procname	=3D "foo",
> +			.data		=3D &data,
> +			.maxlen		=3D sizeof(u8),
> +			.mode		=3D 0644,
> +			.proc_handler	=3D proc_dou8vec_minmax,
> +			.extra1		=3D SYSCTL_FOUR,
> +			.extra2		=3D SYSCTL_ONE_THOUSAND,
> +		},
> +	};
> +
> +	struct ctl_table table_bar[] =3D {
> +		{
> +			.procname	=3D "bar",
> +			.data		=3D &data,
> +			.maxlen		=3D sizeof(u8),
> +			.mode		=3D 0644,
> +			.proc_handler	=3D proc_dou8vec_minmax,
> +			.extra1		=3D SYSCTL_NEG_ONE,
> +			.extra2		=3D SYSCTL_ONE_HUNDRED,
> +		},
> +	};
> +
> +	struct ctl_table table_qux[] =3D {
> +		{
> +			.procname	=3D "qux",
> +			.data		=3D &data,
> +			.maxlen		=3D sizeof(u8),
> +			.mode		=3D 0644,
> +			.proc_handler	=3D proc_dou8vec_minmax,
> +			.extra1		=3D SYSCTL_ZERO,
> +			.extra2		=3D SYSCTL_TWO_HUNDRED,
> +		},
> +	};
> +
> +	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_foo));
> +	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_bar));
> +	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
> +}
> +
>  static struct kunit_case sysctl_test_cases[] =3D {
>  	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
>  	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
> @@ -378,6 +426,7 @@ static struct kunit_case sysctl_test_cases[] =3D {
>  	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
>  	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
>  	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
> +	KUNIT_CASE(sysctl_test_register_sysctl_sz_invalid_extra_value),
>  	{}
>  };
> =20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 81cc974913bb..3efe3a991743 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -977,16 +977,10 @@ int proc_dou8vec_minmax(struct ctl_table *table, in=
t write,
>  	if (table->maxlen !=3D sizeof(u8))
>  		return -EINVAL;
> =20
> -	if (table->extra1) {
> -		min =3D *(unsigned int *) table->extra1;
> -		if (min > 255U)
> -			return -EINVAL;
> -	}
> -	if (table->extra2) {
> -		max =3D *(unsigned int *) table->extra2;
> -		if (max > 255U)
> -			return -EINVAL;
> -	}
> +	if (table->extra1)
> +		min =3D *(unsigned char *) table->extra1;
Please leave as (unsigned int *)

> +	if (table->extra2)
> +		max =3D *(unsigned char *) table->extra2;
Please leave as (unsigned int *)

> =20
>  	tmp =3D *table;
> =20
> --=20
> 2.25.1
>=20

--=20

Joel Granados

--767mxcnp7ni4jsp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYfy1sACgkQupfNUreW
QU+qwgv/V1uxhnWhDWO8pC3gEh52bdTVNehfqm+izxfdsC+/wFCl8/yzahlvUATZ
+G3VUzyU46C5eYum4TrPNZ/xMs3brZZ4IE0DtHCv60c8wY8L+V1wBKiFT2GDdd+8
BygCbo+cke59AyNrjTr47OonAX98f5btRwiIlELAy//xmQ7wAuluba+yKPjq8iwj
fd5+vljWDrWgP7tj/fNFTX+p7be05pndWVgMDAIxKFCrLchjdbjUu5tn6e/iOyWQ
5N6lMAtEExVOIVBo5dGwLG13NnUa/WGCZE3luTWirWi9DsX4eg04UQJgiVQ/CaV6
CdBIef8O86c1Yp7poOGmC99FeRE783Ys5CkHFQR1iynaB65K25kH0oXahsu5KN6U
65V8crPovr00PK/f8puHkUWRjtQEyixtN1ykEv9Kwvlar6Hv5uUQ0ihTSd60RpUa
TwEByxK1SI3RoLPsZEABRtLAMFmXnHOH8JqwenL12osyKLp5QYK5EbjFVP14fiwj
cCAV1bci
=Uurk
-----END PGP SIGNATURE-----

--767mxcnp7ni4jsp3--

