Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20E7518C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjGMG0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGMG0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:26:02 -0400
X-Greylist: delayed 978 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 23:25:59 PDT
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802E3A2;
        Wed, 12 Jul 2023 23:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=folker-schwesinger.de; s=default2212; h=In-Reply-To:References:Message-Id:
        To:From:Cc:Subject:Date:Content-Type:Sender:Reply-To:MIME-Version:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=YxdXRsHV5gvkgalTYn7OFaGTXn3eE6f7fK2e6o6WgVY=; b=NPKoB/g3UlWB8hI3tLw4ORjuQm
        tdAmpdEz7Ly2PNX0bzCDAEgyRo9g7rhW0wJMxyOnRUBAQnDlYACRAeivpu/iiKM/O8vsaCc53ZbgZ
        acTPR2N73GK/gySlt5Z/qx3Scc0naszeOT1+eC8P8FYTgS/weoTNQZOP6KUtk3uwD5SbyEGvVEJss
        UIuRuGG/0A+AM8KZfkQ8YrgQcOZ73LtVZktxWu65qnfPrwFaKgmxjtdcgbzecccJj4Y5mGA8xiNC0
        6eT7rBLiauQFqhAVC0Q/T+MBfTIMrNGFOEBD2j84veWLnh5/suYBpX0OZxY/4VThAq/DrOAib+jTD
        YoezECkA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <dev@folker-schwesinger.de>)
        id 1qJpW5-0000Gm-Fr; Thu, 13 Jul 2023 08:09:29 +0200
Received: from [193.138.218.160] (helo=localhost)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <dev@folker-schwesinger.de>)
        id 1qJpW0-000NOO-W3; Thu, 13 Jul 2023 08:09:29 +0200
Content-Type: multipart/signed;
 boundary=88f15712e0a333f8a9bd02b43aed3c93591977f24a2d039f7f62a6aa0587;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date:   Thu, 13 Jul 2023 06:09:24 +0000
Subject: Re: [PATCH RFC/RFT] crypto: rk3288: enable support for TRNG
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>, <mike.rudenko@gmail.com>,
        <Jason@zx2c4.com>
From:   "Folker Schwesinger" <dev@folker-schwesinger.de>
To:     "Corentin Labbe" <clabbe@baylibre.com>, <davem@davemloft.net>,
        <heiko@sntech.de>, <herbert@gondor.apana.org.au>
Message-Id: <CU0TGMZYXNCJ.3RU1TPFHFOZNM@homedev>
X-Mailer: aerc 0.15.2-83-gab3debc1fad9
References: <20230707115242.3411259-1-clabbe@baylibre.com>
In-Reply-To: <20230707115242.3411259-1-clabbe@baylibre.com>
X-Authenticated-Sender: dev@folker-schwesinger.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26967/Wed Jul 12 09:28:32 2023)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_HEADER_CTYPE_ONLY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--88f15712e0a333f8a9bd02b43aed3c93591977f24a2d039f7f62a6aa0587
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Jul 7, 2023 at 1:52 PM CEST, Corentin Labbe wrote:
> The rockchip IP has a TRNG which could be used as a hwrng.
> Since TRNG is only failling rngtests on rk3328 and does not work on
> rk3288, the TRNG is enabled only on rk3399 via a variant.
> But this is not a surprise since when vendor tried to add support for TRN=
G upstream,
> rk3288 was not handled, and rk3328 was added "disabled", so I conclude
> this is a known problem.
> Anyway the quality of rk3399 TRNG is low, so a dedicated kconfig option
> is done to not enabled it by default.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Hello
>
> All rk3288 compatible crypto IP have a TRNG and supporting it was awaited=
 for
> some time (https://bugzilla.kernel.org/show_bug.cgi?id=3D216502)
>
> I has some problem with this one, it was the first time I hit so many 100=
% failure on rngtest.
>
> I finally bisected a RNG_SAMPLE value (1200) which lead to "only" 50-70% =
failure.
> The calcul of fail rate is done with (FIPS 140-2 successes/FIPS 140-2 fai=
lures) of rngtest.
> Since it is the first time I hit that case, does setting rng_quality to 3=
00 is
> what to do (using the worst succes rate of 30%) ?
>
> But I am really puzzled why vendor default is to use RNG_SAMPLE=3D100 whi=
ch is total failure (according to rngtest).
> Unfortunatly all my try to have more answer from them seems to have been =
forwarded to /dev/null.
>
> Thanks
> Regards

I tested this on a rk3399-rock-pi-4b with the following results:

# uname -a
Linux rockpi-bookworm 6.4.3-dirty #83 SMP PREEMPT Wed Jul 12 09:07:12 CEST =
2023 aarch64 GNU/Linux

# sudo ls -l /dev/hwrng
crw------- 1 root root 10, 183 Jan 18 09:52 /dev/hwrng

# cat /sys/devices/virtual/misc/hw_random/rng_current
Rockchip rk3288 TRNG

# sudo dd if=3D/dev/hwrng count=3D100 bs=3D2048 | rngtest
rngtest 5
Copyright (c) 2004 by Henrique de Moraes Holschuh
This is free software; see the source for copying conditions.  There is NO =
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

rngtest: starting FIPS tests...
100+0 records in
100+0 records out
204800 bytes (205 kB, 200 KiB) copied, 10.1847 s, 20.1 kB/s
rngtest: entropy source drained
rngtest: bits received from input: 1638400
rngtest: FIPS 140-2 successes: 54
rngtest: FIPS 140-2 failures: 27
rngtest: FIPS 140-2(2001-10-10) Monobit: 27
rngtest: FIPS 140-2(2001-10-10) Poker: 3
rngtest: FIPS 140-2(2001-10-10) Runs: 1
rngtest: FIPS 140-2(2001-10-10) Long run: 0
rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
rngtest: input channel speed: (min=3D94.195; avg=3D159.504; max=3D195.252)K=
ibits/s
rngtest: FIPS tests speed: (min=3D17.826; avg=3D25.180; max=3D38.377)Mibits=
/s
rngtest: Program run time: 10221628 microseconds

# sudo dd if=3D/dev/hwrng count=3D200 bs=3D2048 | rngtest
rngtest 5
Copyright (c) 2004 by Henrique de Moraes Holschuh
This is free software; see the source for copying conditions.  There is NO =
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

rngtest: starting FIPS tests...
200+0 records in
200+0 records out
409600 bytes (410 kB, 400 KiB) copied, 20.2624 s, 20.2 kB/s
rngtest: entropy source drained
rngtest: bits received from input: 3276800
rngtest: FIPS 140-2 successes: 115
rngtest: FIPS 140-2 failures: 48
rngtest: FIPS 140-2(2001-10-10) Monobit: 48
rngtest: FIPS 140-2(2001-10-10) Poker: 1
rngtest: FIPS 140-2(2001-10-10) Runs: 0
rngtest: FIPS 140-2(2001-10-10) Long run: 0
rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
rngtest: input channel speed: (min=3D94.636; avg=3D159.621; max=3D195.400)K=
ibits/s
rngtest: FIPS tests speed: (min=3D25.031; avg=3D27.258; max=3D28.639)Mibits=
/s
rngtest: Program run time: 20297102 microseconds



Tested-by: Folker Schwesinger <dev@folker-schwesinger.de>

Kind regards,

Folker


>  drivers/crypto/Kconfig                        |  8 ++
>  drivers/crypto/rockchip/Makefile              |  1 +
>  drivers/crypto/rockchip/rk3288_crypto.c       | 18 +++-
>  drivers/crypto/rockchip/rk3288_crypto.h       | 18 ++++
>  drivers/crypto/rockchip/rk3288_crypto_ahash.c |  2 +
>  .../crypto/rockchip/rk3288_crypto_skcipher.c  |  2 +
>  drivers/crypto/rockchip/rk3288_crypto_trng.c  | 92 +++++++++++++++++++
>  7 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/crypto/rockchip/rk3288_crypto_trng.c
>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 44e44b8d9ce6..7226d441686c 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -650,6 +650,14 @@ config CRYPTO_DEV_ROCKCHIP
>  	  This driver interfaces with the hardware crypto accelerator.
>  	  Supporting cbc/ecb chainmode, and aes/des/des3_ede cipher mode.
> =20
> +config CRYPTO_DEV_ROCKCHIP_TRNG
> +	bool "Support for Rockchip TRNG"
> +	depends on CRYPTO_DEV_ROCKCHIP
> +	select HW_RANDOM
> +	help
> +	  Select this option if you want to provide kernel-side support for
> +	  the True Random Number Generator found in the Crypto IP.
> +
>  config CRYPTO_DEV_ROCKCHIP_DEBUG
>  	bool "Enable Rockchip crypto stats"
>  	depends on CRYPTO_DEV_ROCKCHIP
> diff --git a/drivers/crypto/rockchip/Makefile b/drivers/crypto/rockchip/M=
akefile
> index 785277aca71e..11910f0e6a62 100644
> --- a/drivers/crypto/rockchip/Makefile
> +++ b/drivers/crypto/rockchip/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) +=3D rk_crypto.o
>  rk_crypto-objs :=3D rk3288_crypto.o \
>  		  rk3288_crypto_skcipher.o \
>  		  rk3288_crypto_ahash.o
> +rk_crypto-$(CONFIG_CRYPTO_DEV_ROCKCHIP_TRNG) +=3D rk3288_crypto_trng.o
> diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/roc=
kchip/rk3288_crypto.c
> index 9f6ba770a90a..880e4db812a2 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto.c
> @@ -40,15 +40,18 @@ static const struct rk_variant rk3288_variant =3D {
>  	.num_clks =3D 4,
>  	.rkclks =3D {
>  		{ "sclk", 150000000},
> -	}
> +	},
> +	.trng =3D false,
>  };
> =20
>  static const struct rk_variant rk3328_variant =3D {
>  	.num_clks =3D 3,
> +	.trng =3D false,
>  };
> =20
>  static const struct rk_variant rk3399_variant =3D {
>  	.num_clks =3D 3,
> +	.trng =3D true,
>  };
> =20
>  static int rk_crypto_get_clks(struct rk_crypto_info *dev)
> @@ -195,6 +198,10 @@ static int rk_crypto_debugfs_show(struct seq_file *s=
eq, void *v)
>  		seq_printf(seq, "%s %s requests: %lu\n",
>  			   dev_driver_string(dd->dev), dev_name(dd->dev),
>  			   dd->nreq);
> +#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_TRNG
> +		seq_printf(seq, "HWRNG: %lu %lu\n",
> +			   dd->hwrng_stat_req, dd->hwrng_stat_bytes);
> +#endif
>  	}
>  	spin_unlock(&rocklist.lock);
> =20
> @@ -381,6 +388,10 @@ static int rk_crypto_probe(struct platform_device *p=
dev)
>  			dev_err(dev, "Fail to register crypto algorithms");
>  			goto err_register_alg;
>  		}
> +#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_TRNG
> +		if (crypto_info->variant->trng)
> +			rk3288_hwrng_register(crypto_info);
> +#endif
> =20
>  		register_debugfs(crypto_info);
>  	}
> @@ -411,6 +422,11 @@ static int rk_crypto_remove(struct platform_device *=
pdev)
>  #ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
>  		debugfs_remove_recursive(rocklist.dbgfs_dir);
>  #endif
> +#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_TRNG
> +		if (crypto_tmp->variant->trng)
> +			rk3288_hwrng_unregister(crypto_tmp);
> +#endif
> +
>  		rk_crypto_unregister();
>  	}
>  	rk_crypto_pm_exit(crypto_tmp);
> diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/roc=
kchip/rk3288_crypto.h
> index b2695258cade..016c3b72c19c 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto.h
> +++ b/drivers/crypto/rockchip/rk3288_crypto.h
> @@ -9,6 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> +#include <linux/hw_random.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/scatterlist.h>
>  #include <crypto/engine.h>
> @@ -183,6 +184,16 @@
>  #define RK_CRYPTO_HASH_DOUT_6		0x01a4
>  #define RK_CRYPTO_HASH_DOUT_7		0x01a8
> =20
> +#define RK_CRYPTO_TRNG_CTRL		0x0200
> +#define RK_CRYPTO_OSC_ENABLE		BIT(16)
> +#define RK_CRYPTO_TRNG_DOUT_0		0x0204
> +/* sample < 1000 lead to 100% failure on rngtest,
> + * using more than 1200 does not increase success.
> + */
> +#define RK_CRYPTO_RNG_SAMPLE		1200
> +
> +#define RK_CRYPTO_MAX_TRNG_BYTE		32
> +
>  #define CRYPTO_READ(dev, offset)		  \
>  		readl_relaxed(((dev)->reg + (offset)))
>  #define CRYPTO_WRITE(dev, offset, val)	  \
> @@ -212,6 +223,7 @@ struct rk_clks {
>  struct rk_variant {
>  	int num_clks;
>  	struct rk_clks rkclks[RK_MAX_CLKS];
> +	bool trng;
>  };
> =20
>  struct rk_crypto_info {
> @@ -222,11 +234,15 @@ struct rk_crypto_info {
>  	struct reset_control		*rst;
>  	void __iomem			*reg;
>  	int				irq;
> +	struct mutex			lock;
> +	struct hwrng			hwrng;
>  	const struct rk_variant *variant;
>  	unsigned long nreq;
>  	struct crypto_engine *engine;
>  	struct completion complete;
>  	int status;
> +	unsigned long hwrng_stat_req;
> +	unsigned long hwrng_stat_bytes;
>  };
> =20
>  /* the private variable of hash */
> @@ -288,3 +304,5 @@ extern struct rk_crypto_tmp rk_ahash_md5;
> =20
>  struct rk_crypto_info *get_rk_crypto(void);
>  #endif
> +int rk3288_hwrng_register(struct rk_crypto_info *rk);
> +void rk3288_hwrng_unregister(struct rk_crypto_info *rk);
> diff --git a/drivers/crypto/rockchip/rk3288_crypto_ahash.c b/drivers/cryp=
to/rockchip/rk3288_crypto_ahash.c
> index a78ff3dcd0b1..67ed3a54bc7b 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
> @@ -287,6 +287,7 @@ static int rk_hash_run(struct crypto_engine *engine, =
void *breq)
>  		goto theend;
>  	}
> =20
> +	mutex_lock(&rkc->lock);
>  	rk_ahash_reg_init(areq, rkc);
> =20
>  	while (sg) {
> @@ -321,6 +322,7 @@ static int rk_hash_run(struct crypto_engine *engine, =
void *breq)
>  	}
> =20
>  theend:
> +	mutex_unlock(&rkc->lock);
>  	pm_runtime_put_autosuspend(rkc->dev);
> =20
>  	local_bh_disable();
> diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/c=
rypto/rockchip/rk3288_crypto_skcipher.c
> index 59069457582b..304c2c44fea0 100644
> --- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> +++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
> @@ -357,6 +357,7 @@ static int rk_cipher_run(struct crypto_engine *engine=
, void *async_req)
>  			}
>  		}
>  		err =3D 0;
> +		mutex_unlock(&rkc->lock);
>  		rk_cipher_hw_init(rkc, areq);
>  		if (ivsize) {
>  			if (ivsize =3D=3D DES_BLOCK_SIZE)
> @@ -372,6 +373,7 @@ static int rk_cipher_run(struct crypto_engine *engine=
, void *async_req)
>  		crypto_dma_start(rkc, sgs, sgd, todo / 4);
>  		wait_for_completion_interruptible_timeout(&rkc->complete,
>  							  msecs_to_jiffies(2000));
> +		mutex_unlock(&rkc->lock);
>  		if (!rkc->status) {
>  			dev_err(rkc->dev, "DMA timeout\n");
>  			err =3D -EFAULT;
> diff --git a/drivers/crypto/rockchip/rk3288_crypto_trng.c b/drivers/crypt=
o/rockchip/rk3288_crypto_trng.c
> new file mode 100644
> index 000000000000..7a0e1300d0e8
> --- /dev/null
> +++ b/drivers/crypto/rockchip/rk3288_crypto_trng.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * rk3288_crypto_trng.c - hardware cryptographic offloader for rockchip
> + *
> + * Copyright (C) 2022-2023 Corentin Labbe <clabbe@baylibre.com>
> + *
> + * This file handle the TRNG
> + */
> +#include "rk3288_crypto.h"
> +#include <linux/hw_random.h>
> +#include <linux/iopoll.h>
> +#include <linux/pm_runtime.h>
> +
> +static int rk3288_trng_read(struct hwrng *hwrng, void *data, size_t max,=
 bool wait)
> +{
> +	struct rk_crypto_info *rk;
> +	unsigned int todo;
> +	int err =3D 0;
> +	int i;
> +	u32 v;
> +
> +	rk =3D container_of(hwrng, struct rk_crypto_info, hwrng);
> +
> +	todo =3D min_t(size_t, max, RK_CRYPTO_MAX_TRNG_BYTE);
> +
> +#ifdef CONFIG_CRYPTO_DEV_ROCKCHIP_DEBUG
> +	rk->hwrng_stat_req++;
> +	rk->hwrng_stat_bytes +=3D todo;
> +#endif
> +
> +	err =3D pm_runtime_resume_and_get(rk->dev);
> +	if (err < 0)
> +		goto err_pm;
> +
> +	mutex_lock(&rk->lock);
> +
> +#define HIWORD_UPDATE(val, mask, shift) \
> +			((val) << (shift) | (mask) << ((shift) + 16))
> +	v =3D RK_CRYPTO_OSC_ENABLE | RK_CRYPTO_RNG_SAMPLE;
> +	CRYPTO_WRITE(rk, RK_CRYPTO_TRNG_CTRL, v);
> +
> +	v =3D HIWORD_UPDATE(RK_CRYPTO_TRNG_START, RK_CRYPTO_TRNG_START, 0);
> +	CRYPTO_WRITE(rk, RK_CRYPTO_CTRL, v);
> +	wmb();
> +
> +	err =3D readl_poll_timeout(rk->reg + RK_CRYPTO_CTRL, v,
> +				 !(v & RK_CRYPTO_TRNG_START),
> +				 100, 2000);
> +	if (err) {
> +		dev_err(rk->dev, "HWRNG read timeout");
> +		goto readfail;
> +	}
> +
> +	for (i =3D 0; i < todo / 4; i++) {
> +		v =3D readl(rk->reg + RK_CRYPTO_TRNG_DOUT_0 + i * 4);
> +		put_unaligned_le32(v, data + i * 4);
> +	}
> +
> +	err =3D todo;
> +
> +	v =3D HIWORD_UPDATE(0, RK_CRYPTO_TRNG_START, 0);
> +	CRYPTO_WRITE(rk, RK_CRYPTO_CTRL, v);
> +
> +readfail:
> +	mutex_unlock(&rk->lock);
> +
> +	pm_runtime_put(rk->dev);
> +
> +err_pm:
> +	return err;
> +}
> +
> +int rk3288_hwrng_register(struct rk_crypto_info *rk)
> +{
> +	int ret;
> +
> +	dev_info(rk->dev, "Register TRNG with sample=3D%d\n", RK_CRYPTO_RNG_SAM=
PLE);
> +
> +	rk->hwrng.name =3D "Rockchip rk3288 TRNG";
> +	rk->hwrng.read =3D rk3288_trng_read;
> +	rk->hwrng.quality =3D 300;
> +
> +	ret =3D hwrng_register(&rk->hwrng);
> +	if (ret)
> +		dev_err(rk->dev, "Fail to register the TRNG\n");
> +	return ret;
> +}
> +
> +void rk3288_hwrng_unregister(struct rk_crypto_info *rk)
> +{
> +	hwrng_unregister(&rk->hwrng);
> +}


--88f15712e0a333f8a9bd02b43aed3c93591977f24a2d039f7f62a6aa0587
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJAEABYIADgWIQQFbmi0A2l3pTuK+esCQHEyPYq7fQUCZK+VFRocZGV2QGZvbGtl
ci1zY2h3ZXNpbmdlci5kZQAKCRACQHEyPYq7fZ/QAQCzKrEJP4tzXBQutnXUDLsD
D8NSaydBNhhoPflg/qOJxwEAzHbunl1pGYf4lrRF50bKL6lCjYJaGdTN+7SJv4Mc
kAU=
=SQrv
-----END PGP SIGNATURE-----

--88f15712e0a333f8a9bd02b43aed3c93591977f24a2d039f7f62a6aa0587--
