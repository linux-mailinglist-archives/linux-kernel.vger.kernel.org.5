Return-Path: <linux-kernel+bounces-125680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2C7892A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A37F2B21BDD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053622BAEF;
	Sat, 30 Mar 2024 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0EM5N83"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E061F17745;
	Sat, 30 Mar 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711796436; cv=none; b=jB7OFhef4jVv2VRx9Mk5lwTLyS4gQd2NnVgXup2LDxoe7kPsq72NK00a4Iwm464hejXp+Mjgyslo4KGBzPby1rgZozKzdiI+AykUlhfN3SrWgHQqzqAXl81U6Q40MhZvhnI1VigpCI0oftjPDgjt7e8hH/3dKQQ05u+V3YEjUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711796436; c=relaxed/simple;
	bh=Jwe+vggAZDD+vfu7vnGv6UKPiaTajESiZxowCaJTh+0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Z3J0HfniDXfjR4unbnBP2mxP5DoBz3X8gKvLW+Y5cW6C+e02JrFMNGxjcBlIwrnrn4vRD4o67sAhcSuobZeqDRNBxrPC5je3AKAUfkzsS+Px+OmvifsnrH3gGkOdlL8OYAOleQdWaX6Gcm3sYOaRptsRYlt8iaef7tpqWXZdL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0EM5N83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFB2C433F1;
	Sat, 30 Mar 2024 11:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711796435;
	bh=Jwe+vggAZDD+vfu7vnGv6UKPiaTajESiZxowCaJTh+0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=g0EM5N83MZCtCuNY4XcTlgxbP5+mHkHFFXF8MvbuIkab5S2AGAaYtHn6XIb+/ZokO
	 Kv8VSI5vNF1dk92FgqOpx3/lwCWmJ/lX1N5y8B1BWlX4pbU/VCo1DTE/OVGmB3gIf4
	 ghE75e+eqD4AW9wVjDjHwhxtpEUHNfa0rWpR+VhgBgacFEg18rJJ4yAV01mEJ3WWF+
	 V765XCHkL+/3/xzcfRqF5VPqPSQxOErYPBdMtqPI0JhJllsqh8RgeFstm7p0Yl23WX
	 xBHvrKimUtRZDni/p4a66GNvHS4WS5a/fQpAKZKm6BhhiMFRpk38EcwKtVeudvvc+A
	 r58fqm1PgxGzg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Mar 2024 13:00:32 +0200
Message-Id: <D0716WSMOLJJ.1MNFI6TD2F9FV@kernel.org>
Cc: <keyrings@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: Add ECDH support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Zhang Yiqun" <zhangyiqun@phytium.com.cn>, <dhowells@redhat.com>,
 <corbet@lwn.net>
X-Mailer: aerc 0.17.0
References: <20240330065506.3146-1-zhangyiqun@phytium.com.cn>
In-Reply-To: <20240330065506.3146-1-zhangyiqun@phytium.com.cn>

On Sat Mar 30, 2024 at 8:55 AM EET, Zhang Yiqun wrote:
> This patch is to introduce ECDH into keyctl syscall for

"Introduce Elliptic Curve Diffie-Hellman (ECDH)"

What does it mean to "introduce ECDH into keyctl syscall"?

> userspace usage, containing public key generation and
> shared secret computation.

Who else uses syscalls other than user space? You are implying
that there some other client.

>
> It is mainly based on dh code, so it has the same condition
> to the input which only user keys is supported. The output
> result is storing into the buffer with the provided length.

What is "dh code"?

>
> Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
> ---
>  Documentation/security/keys/core.rst |  62 ++++++
>  include/linux/compat.h               |   4 +
>  include/uapi/linux/keyctl.h          |  11 +
>  security/keys/Kconfig                |  12 +
>  security/keys/Makefile               |   2 +
>  security/keys/compat_ecdh.c          |  50 +++++
>  security/keys/ecdh.c                 | 318 +++++++++++++++++++++++++++
>  security/keys/internal.h             |  44 ++++
>  security/keys/keyctl.c               |  10 +
>  9 files changed, 513 insertions(+)
>  create mode 100644 security/keys/compat_ecdh.c
>  create mode 100644 security/keys/ecdh.c
>
> diff --git a/Documentation/security/keys/core.rst b/Documentation/securit=
y/keys/core.rst
> index 326b8a973828..9749466a3c95 100644
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -884,6 +884,68 @@ The keyctl syscall functions are:
>       and either the buffer length or the OtherInfo length exceeds the
>       allowed length.
> =20
> +  *  Compute a elliptic curve Diffie-Hellman shared secret::
        Compute an Elliptic Curve Diffie-Hellman (ECDH) shared secret:

> +
> +	long keyctl(KEYCTL_ECDH_COMPUTE, struct keyctl_ecdh_params *params,
> +		    char *buffer, size_t buflen,
> +		    struct keyctl_curve_params *curve);
> +
> +     The params struct contains serial numbers for two keys::
> +
> +	 - The local private key
> +	 - The shared public key
> +
> +     The value computed is::
> +
> +	result =3D private EC-MUTIPLY public
> +
> +     The buffer length must be at least the length of the prime, or zero=
.
> +
> +     If the buffer length is nonzero, the length of the result is
> +     returned when it is successfully calculated and copied in to the
> +     buffer. When the buffer length is zero, the minimum required
> +     buffer length is returned.
> +
> +     The curve parameter struct keyctl_curve_params is as follows:
> +
> +	 - ``char *curvename`` specifies the curve parameter used in
> +	   the following computation.
> +
> +     This function will return error EOPNOTSUPP if the key type is not
> +     supported, error ENOKEY if the key could not be found, or error
> +     EACCES if the key is not readable by the caller.
> +
> +  *  Generate a elliptic curve Diffie-Hellman shared public key::

s/::/:/=20

various locations

> +
> +	long keyctl(KEYCTL_ECDH_GENPUBKEY,
> +		    struct keyctl_ecdh_params *params,
> +		    char *buffer, size_t buflen,
> +		    struct keyctl_curve_params *curve);
> +
> +     The params struct contains serial numbers for one keys::
> +
> +	 - The local private key
> +
> +     The value computed is::
> +
> +	result =3D private EC-MUTIPLY G
> +
> +     The buffer length must be at least the length of the prime, or zero=
.
> +
> +     If the buffer length is nonzero, the length of the result is
> +     returned when it is successfully calculated and copied in to the
> +     buffer. When the buffer length is zero, the minimum required
> +     buffer length is returned.
> +
> +     The curve parameter struct keyctl_curve_params is as follows:
> +
> +	 - ``char *curvename`` specifies the curve parameter used in

s/``char *curvename``/char *curvename/

> +	   the following computation.
> +
> +     This function will return error EOPNOTSUPP if the key type is not
> +     supported, error ENOKEY if the key could not be found, or error
> +     EACCES if the key is not readable by the caller.
> +
> =20
>    *  Restrict keyring linkage::
> =20
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 233f61ec8afc..1f989ef5c9e1 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -411,6 +411,10 @@ struct compat_keyctl_kdf_params {
>  	__u32 __spare[8];
>  };
> =20
> +struct compat_keyctl_curve_params {
> +	compat_uptr_t curvename;
> +};

Please, do not create this at all.

> +
>  struct compat_stat;
>  struct compat_statfs;
>  struct compat_statfs64;
> diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
> index 4c8884eea808..77b5d9d837a2 100644
> --- a/include/uapi/linux/keyctl.h
> +++ b/include/uapi/linux/keyctl.h
> @@ -70,6 +70,8 @@
>  #define KEYCTL_MOVE			30	/* Move keys between keyrings */
>  #define KEYCTL_CAPABILITIES		31	/* Find capabilities of keyrings subsyst=
em */
>  #define KEYCTL_WATCH_KEY		32	/* Watch a key or ring of keys for changes =
*/
> +#define KEYCTL_ECDH_COMPUTE		33	/* Compute EC Diffie-Hellman values */
> +#define KEYCTL_ECDH_GENPUBKEY		34	/* Generate EC Diffie-Hellman public k=
eys */
> =20
>  /* keyctl structures */
>  struct keyctl_dh_params {
> @@ -90,6 +92,15 @@ struct keyctl_kdf_params {
>  	__u32 __spare[8];
>  };
> =20
> +struct keyctl_ecdh_params {
> +	__s32 priv;
> +	__s32 pub;
> +};
> +
> +struct keyctl_curve_params {
> +	char __user *curvename;

This will cause ABI to be a total trainwreck because the size changes
depending on arch bitsize. Please never do anything like this in an
ioctl API.

I.e. please change to __u64 curve_name

> +};
>
> +
>  #define KEYCTL_SUPPORTS_ENCRYPT		0x01
>  #define KEYCTL_SUPPORTS_DECRYPT		0x02
>  #define KEYCTL_SUPPORTS_SIGN		0x04
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index abb03a1b2a5c..b36be8d8d501 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -125,6 +125,18 @@ config KEY_DH_OPERATIONS
> =20
>  	 If you are unsure as to whether this is required, answer N.
> =20
> +config KEY_ECDH_OPERATIONS
> +       bool "Elliptic Curve Diffie-Hellman operations on retained keys"
> +       depends on KEYS
> +       select CRYPTO
> +       select CRYPTO_ECDH
> +       help
> +	 This option provides support for calculating Elliptic Curve
> +	 Diffie-Hellman public keys and shared secrets using values
> +	 stored as keys in the kernel.
> +
> +	 If you are unsure as to whether this is required, answer N.
> +
>  config KEY_NOTIFICATIONS
>  	bool "Provide key/keyring change notifications"
>  	depends on KEYS && WATCH_QUEUE
> diff --git a/security/keys/Makefile b/security/keys/Makefile
> index 5f40807f05b3..590fc4724f37 100644
> --- a/security/keys/Makefile
> +++ b/security/keys/Makefile
> @@ -17,11 +17,13 @@ obj-y :=3D \
>  	request_key_auth.o \
>  	user_defined.o
>  compat-obj-$(CONFIG_KEY_DH_OPERATIONS) +=3D compat_dh.o
> +compat-obj-$(CONFIG_KEY_ECDH_OPERATIONS) +=3D compat_ecdh.o
>  obj-$(CONFIG_COMPAT) +=3D compat.o $(compat-obj-y)
>  obj-$(CONFIG_PROC_FS) +=3D proc.o
>  obj-$(CONFIG_SYSCTL) +=3D sysctl.o
>  obj-$(CONFIG_PERSISTENT_KEYRINGS) +=3D persistent.o
>  obj-$(CONFIG_KEY_DH_OPERATIONS) +=3D dh.o
> +obj-$(CONFIG_KEY_ECDH_OPERATIONS) +=3D ecdh.o
>  obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) +=3D keyctl_pkey.o
> =20
>  #
> diff --git a/security/keys/compat_ecdh.c b/security/keys/compat_ecdh.c
> new file mode 100644
> index 000000000000..040d2a1c5548
> --- /dev/null
> +++ b/security/keys/compat_ecdh.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* 32-bit compatibility syscall for 64-bit systems for ECDH operations
> + *
> + * Copyright (C) 2024 Zhang Yiqun <zhangyiqun@phytium.com.cn>
> + */
> +
> +#include <linux/uaccess.h>
> +

Not sure what is the purpose of this empty line?

> +#include "internal.h"
> +
> +/*
> + * Perform the ECDH computation or ECDH based key derivation.
> + *
> + * If successful, 0 will be returned.
> + */
> +long compat_keyctl_ecdh_compute(struct keyctl_ecdh_params __user *params=
,
> +				char __user *buffer, size_t buflen,
> +				struct compat_keyctl_curve_params __user *curve)
> +{
> +	struct keyctl_curve_params curvecopy;
> +	struct compat_keyctl_curve_params compat_curvecopy;

reverse xmas tree declaration order (various locations)

> +
> +	if (!curve)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&compat_curvecopy, curve, sizeof(compat_curvecopy)) =
!=3D 0)
> +		return -EFAULT;
> +
> +	curvecopy.curvename =3D compat_ptr(compat_curvecopy.curvename);
> +
> +	return keyctl_ecdh_compute(params, buffer, buflen, &curvecopy);
> +}
> +
> +long compat_keyctl_ecdh_genpubkey(struct keyctl_ecdh_params __user *para=
ms,
> +				  char __user *buffer, size_t buflen,
> +				  struct compat_keyctl_curve_params __user *curve)
> +{
> +	struct keyctl_curve_params curvecopy;
> +	struct compat_keyctl_curve_params compat_curvecopy;
> +
> +	if (!curve)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&compat_curvecopy, curve, sizeof(compat_curvecopy)) =
!=3D 0)
> +		return -EFAULT;
> +
> +	curvecopy.curvename =3D compat_ptr(compat_curvecopy.curvename);
> +
> +	return keyctl_ecdh_genpubkey(params, buffer, buflen, &curvecopy);
> +}
> diff --git a/security/keys/ecdh.c b/security/keys/ecdh.c
> new file mode 100644
> index 000000000000..5e5be22b920c
> --- /dev/null
> +++ b/security/keys/ecdh.c
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Crypto operations using stored keys
> + *
> + * Copyright (c) 2024 Zhang Yiqun <zhangyiqun@phytium.com.cn>
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/scatterlist.h>
> +#include <linux/crypto.h>
> +#include <crypto/hash.h>
> +#include <crypto/kpp.h>
> +#include <crypto/ecdh.h>
> +#include <keys/user-type.h>
> +#include "internal.h"
> +
> +static ssize_t ecdh_data_from_key(key_serial_t keyid, char **data)
> +{
> +	struct key *key;
> +	key_ref_t key_ref;
> +	long status;
> +	ssize_t ret;
> +
> +	key_ref =3D lookup_user_key(keyid, 0, KEY_NEED_READ);
> +	if (IS_ERR(key_ref)) {
> +		ret =3D -ENOKEY;
> +		goto error;
> +	}
> +
> +	key =3D key_ref_to_ptr(key_ref);
> +
> +	ret =3D -EOPNOTSUPP;
> +	if (key->type =3D=3D &key_type_user) {
> +		down_read(&key->sem);
> +		status =3D key_validate(key);
> +		if (status =3D=3D 0) {
> +			const struct user_key_payload *payload;
> +			uint8_t *duplicate;
> +
> +			payload =3D user_key_payload_locked(key);
> +
> +			duplicate =3D kmemdup(payload->data, payload->datalen,
> +					    GFP_KERNEL);
> +			if (duplicate) {
> +				*data =3D duplicate;
> +				ret =3D payload->datalen;
> +			} else {
> +				ret =3D -ENOMEM;
> +			}
> +		}
> +		up_read(&key->sem);
> +	}
> +
> +	key_put(key);
> +error:
> +	return ret;
> +}
> +
> +static void ecdh_free_data(struct ecdh *ecdh)
> +{
> +	kfree_sensitive(ecdh->key);
> +}
> +
> +long keyctl_ecdh_compute(struct keyctl_ecdh_params __user *params,
> +		       char __user *buffer, size_t buflen,
> +		       struct keyctl_curve_params __user *curve)
> +{
> +	long ret;
> +	ssize_t dlen;
> +	int secretlen;
> +	int outlen;
> +	struct keyctl_ecdh_params pcopy;
> +	struct ecdh ecdh_inputs;
> +	struct scatterlist insg;

in_sg

> +	struct scatterlist outsg;

out_sg

> +	DECLARE_CRYPTO_WAIT(compl);
> +	struct crypto_kpp *tfm;
> +	struct kpp_request *req;
> +	uint8_t *secret;
> +	uint8_t *outbuf;

out_buf

> +	char *dhname;
> +
> +	if (!params || (!buffer && buflen) || !curve) {
> +		ret =3D -EINVAL;
> +		goto out1;
> +	}

return -EINVAL; (remove out1 label)

> +
> +	if (copy_from_user(&pcopy, params, sizeof(pcopy)) !=3D 0) {
> +		ret =3D -EFAULT;
> +		goto out1;
> +	}
> +
> +	memset(&ecdh_inputs, 0, sizeof(ecdh_inputs));
> +
> +	dlen =3D ecdh_data_from_key(pcopy.priv, &ecdh_inputs.key);
> +	if (dlen < 0) {
> +		ret =3D dlen;
> +		goto out1;
> +	}
> +	ecdh_inputs.key_size =3D dlen;
> +
> +	secretlen =3D crypto_ecdh_key_len(&ecdh_inputs);
> +	secret =3D kmalloc(secretlen, GFP_KERNEL);
> +	if (!secret) {
> +		ret =3D -ENOMEM;
> +		goto out2;

goto err_free_data;

> +	}
> +
> +	ret =3D crypto_ecdh_encode_key(secret, secretlen, &ecdh_inputs);
> +	if (ret)
> +		goto out3;


goto err_free_secret;

.. you probably get the idea, please do this for all labels.

> +
> +	dhname =3D strndup_user(curve->curvename, CRYPTO_MAX_ALG_NAME);
> +
> +	tfm =3D crypto_alloc_kpp(dhname, 0, 0);
> +	if (IS_ERR(tfm)) {
> +		ret =3D PTR_ERR(tfm);
> +		goto out3;


So who free's dhname in this case?

BR, Jarkko


