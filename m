Return-Path: <linux-kernel+bounces-2320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06471815AF5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 19:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B405C284B0B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9B03175F;
	Sat, 16 Dec 2023 18:07:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B6831593;
	Sat, 16 Dec 2023 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 5392F406CE;
	Sat, 16 Dec 2023 18:07:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 3964420026;
	Sat, 16 Dec 2023 18:07:25 +0000 (UTC)
Message-ID: <59d9ac4e1f7475f51672222af1fc90d7ec23b5da.camel@perches.com>
Subject: Re: [PATCH v4 01/15] scripts: checkpatch: Add __aligned to the list
 of attribute notes
From: Joe Perches <joe@perches.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com, 
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, paul.cercueil@analog.com,
  Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  dan.carpenter@linaro.org, dlechner@baylibre.com,
 marcelo.schmitt1@gmail.com,  Andrew Morton <akpm@linux-foundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2023 10:07:24 -0800
In-Reply-To: <1c5c93ecbd8c46a338b22a4ef52e51648e333c01.1702746240.git.marcelo.schmitt1@gmail.com>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
	 <1c5c93ecbd8c46a338b22a4ef52e51648e333c01.1702746240.git.marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3964420026
X-Rspamd-Server: rspamout06
X-Stat-Signature: iu57srmu8yx8hak7ccps71iro9ugsgq7
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/gxSDX06dR2WX6zylQhF9VPbGZBkW5vqI=
X-HE-Tag: 1702750045-808240
X-HE-Meta: U2FsdGVkX19AhXysoX2U7xiIgPyiEs5MYj2gOP8pvyjmvQ8aceVvVvwYNVxhtBiVlmBkgda0AInSCANpDxTi3UZYmp93Pp1+zg0hZ9JSKse3MHOlCf5a2opqxfOa0RBKjhiM0nYZmCsT4+dcs/MQbaTYUlfrnPccbLV9QfNKyVxadngYorldv6eLx85JhYA+Yub+Y5v2+dOSKtqLfRR9Qvigfc9mNfyhy1qyCQXVJrcMdwxuoEBLZhcBg4Aq9YplqV5lNIS11hS9nAbKCA98fmTuQVSQRARRZXoFK8C8GeWRqKx4YvNG6EE1tHA/lfC21y/qgncb8ihI2+Jwt29huI0SvmiiMICOYAQuzInDLQoCHxWVcoMj/YLNCs0oG2wBDj9XhW2qiVg/zZfjWHPgAjwy99ZYz2+0tttNjjVgEaVSpHuZEW0WCUNsmMKGzEdZ

On Sat, 2023-12-16 at 14:45 -0300, Marcelo Schmitt wrote:
> Checkpatch presumes attributes marked with __aligned(alignment) are part
> of a function declaration and throws a warning stating that those
> compiler attributes should have an identifier name which is not correct.
> Add __aligned compiler attributes to the list of attribute notes
> so they don't cause warnings anymore.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Any expression that evaluates to an integer that is a power of 2 can be
> within __aligned parenthesis.
> I can't see how we could use a regex to check code meets such constraint =
(if possible).

You can't because if a #define is used for the alignment
value it is not necessarily available to a patch fragment
or even a file if the #define is in an #include.

> Some additional exotic uses of __aligned are:
> drivers/net/wireless/quantenna/qtnfmac/bus.h:72:   char bus_priv[] __alig=
ned(sizeof(void *));
> include/linux/netdevice.h:225:} __aligned(4 * sizeof(unsigned long));=20

Right, then there are random uses like:

drivers/firmware/qcom/qcom_qseecom_uefisecapp.c:		size_t __aligned;						\
drivers/firmware/qcom/qcom_qseecom_uefisecapp.c:			*__offset =3D __aligned;=
					\

so there's always some false positive/negative issue
with checkpatch.

Anyway:

Acked-by: Joe Perches <joe@perches.com>

>=20
> The regex
> 			__aligned\s*\(.*\)
> seems to match all use cases.=20
>=20
> We might not catch invalid arguments to __aligned, but it looks like maki=
ng
> checkpath confidently report those wouldn't be feasible anyway.
>=20
> The patch that would trigger the mentioned warning in now
> patch number 13 (iio: adc: Add support for AD7091R-8).
>=20
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 25fdb7fda112..d56c98146da3 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -512,6 +512,7 @@ our $Attribute	=3D qr{
>  			__ro_after_init|
>  			__kprobes|
>  			$InitAttribute|
> +			__aligned\s*\(.*\)|
>  			____cacheline_aligned|
>  			____cacheline_aligned_in_smp|
>  			____cacheline_internodealigned_in_smp|


