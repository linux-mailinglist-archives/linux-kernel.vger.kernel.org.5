Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1B77FEFB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354860AbjHQUYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354848AbjHQUYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:24:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D0630DE;
        Thu, 17 Aug 2023 13:24:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so2405185e9.2;
        Thu, 17 Aug 2023 13:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692303854; x=1692908654;
        h=in-reply-to:references:cc:to:content-language:subject:reply-to
         :user-agent:mime-version:date:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j+5Wl3qyx4Iy9Z/PTJlsRKZSBQ3v1eW2aXxCPWi7Zak=;
        b=eDlWWPpc3Ht22XX3A5vPmxW2Y0HvU/WV8uY9a7FaDWrT37sP67gmvfWpsnqcFYxQwp
         eymFrvgtjP1xwg4I4Vgc81jvFBpxAZrkiusCJk8e9XNTcp47MEAMUlHKfe/B1M32foA2
         VA/5JS5sXq8IKwqGvNCLeDKzNJwcMMnPgRVp6ClmyKUWvU56y48ljQsV7M4NTiyowq+C
         cIl/WQ0bKFXz3uv4oHDafikfDpmrJy2Po0qrcLzeoHUwCl8+BawsGpTUse86wmb1HICB
         PFoYLBNZSH43L7HguU16fJVu84zLAXs5+BO72kd3HLFMYW0Mp7e7JRFYbYI5b3BfbH0W
         y24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692303854; x=1692908654;
        h=in-reply-to:references:cc:to:content-language:subject:reply-to
         :user-agent:mime-version:date:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+5Wl3qyx4Iy9Z/PTJlsRKZSBQ3v1eW2aXxCPWi7Zak=;
        b=TCkxzldMsF/tnm1KEqoah1A0Wa5yqkRp1tOcyqzvdxZQnWlNuINdC6xJEn7e2DQO7O
         NmKZG1qhlmL+1g5N+3pamPEj53tBvGZ9BUT2LLbbfI6WLmfUl6NLzSy40FCvPD4/SvZC
         /cCxXzMCtNr/wXFtD6FyPVOtkbpWptUjATPoB37x5OuDGP9j3zv0A64vskZvp9Nv23wW
         faNqmmquWwzyqCI1SwgDC/JLdRCXjYjdXnFPg7T2D79x0zYQT14DKyy4m1rhHx6d2iRC
         /9qjXPL29h+ucVAQvi2Y83le6Q32B8wtQlEHDKWTUfH8OOVY+vXaNrQ9bejEh3lOvexx
         qcnA==
X-Gm-Message-State: AOJu0YwX8ueyJLlvVNsmQLkZl2l/X1eeT0U3ah/IomBYqjIZJDOmK6ce
        yqmIGZ+B1lLman0c2OXoiYw=
X-Google-Smtp-Source: AGHT+IGS8S6PkC+aXqO7L3JZXSQt6BCJHbhJ0z9uEQqqV+8K7aiOlmRbgiLmJtdOvezx4Yb2ujt1Iw==
X-Received: by 2002:a05:600c:248:b0:3fe:1bef:4034 with SMTP id 8-20020a05600c024800b003fe1bef4034mr584155wmj.37.1692303853907;
        Thu, 17 Aug 2023 13:24:13 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.40.43])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bc5d8000000b003fe17e04269sm544377wmk.40.2023.08.17.13.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 13:24:13 -0700 (PDT)
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx.manpages@gmail.com>
Message-ID: <121ae7d6-db88-4ec7-a7d5-e7b1c14b49d4@gmail.com>
Date:   Thu, 17 Aug 2023 22:24:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Reply-To: alx@kernel.org
Subject: Re: [PATCH 1/4] linux/array_size.h: Move ARRAY_SIZE(arr) to a
 separate header
Content-Language: en-US
To:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        andriy.shevchenko@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
 <20230817143352.132583-2-lucas.segarra.fernandez@intel.com>
In-Reply-To: <20230817143352.132583-2-lucas.segarra.fernandez@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------K6EBxUhtYCvjdHouZM93UhNd"
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------K6EBxUhtYCvjdHouZM93UhNd
Content-Type: multipart/mixed; boundary="------------LMve7cXexGde0dyAa1VwcxEd";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
Reply-To: alx@kernel.org
To: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
 herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org, qat-linux@intel.com,
 andriy.shevchenko@intel.com, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID: <121ae7d6-db88-4ec7-a7d5-e7b1c14b49d4@gmail.com>
Subject: Re: [PATCH 1/4] linux/array_size.h: Move ARRAY_SIZE(arr) to a
 separate header
References: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
 <20230817143352.132583-2-lucas.segarra.fernandez@intel.com>
In-Reply-To: <20230817143352.132583-2-lucas.segarra.fernandez@intel.com>

--------------LMve7cXexGde0dyAa1VwcxEd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 2023-08-17 16:33, Lucas Segarra Fernandez wrote:
> From: Alejandro Colomar <alx.manpages@gmail.com>
>=20
> Touching files so used for the kernel,
> forces 'make' to recompile most of the kernel.
>=20
> Having those definitions in more granular files
> helps avoid recompiling so much of the kernel.
>=20
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Heh!  This is really really old, isn't it?  :p

Would you mind updating my email to use the kernel.org address?

From: Alejandro Colomar <alx@kernel.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>

Thanks for taking care of this patch!

Cheers,
Alex

> ---
>  include/linux/array_size.h                    | 13 +++++++++++++
>  include/linux/clk-provider.h                  |  1 +
>  include/linux/counter.h                       |  1 +
>  include/linux/genl_magic_func.h               |  1 +
>  include/linux/hashtable.h                     |  1 +
>  include/linux/kernel.h                        |  7 +------
>  include/linux/kfifo.h                         |  1 +
>  include/linux/kvm_host.h                      |  1 +
>  include/linux/moduleparam.h                   |  2 ++
>  include/linux/mtd/rawnand.h                   |  1 +
>  include/linux/netfilter.h                     |  1 +
>  include/linux/pagemap.h                       |  1 +
>  include/linux/phy.h                           |  1 +
>  include/linux/pinctrl/machine.h               |  2 +-
>  include/linux/property.h                      |  1 +
>  include/linux/rcupdate_wait.h                 |  1 +
>  include/linux/regmap.h                        |  1 +
>  include/linux/skmsg.h                         |  1 +
>  include/linux/string.h                        |  1 +
>  include/linux/surface_aggregator/controller.h |  1 +
>  20 files changed, 33 insertions(+), 7 deletions(-)
>  create mode 100644 include/linux/array_size.h
>=20
> diff --git a/include/linux/array_size.h b/include/linux/array_size.h
> new file mode 100644
> index 000000000000..06d7d83196ca
> --- /dev/null
> +++ b/include/linux/array_size.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ARRAY_SIZE_H
> +#define _LINUX_ARRAY_SIZE_H
> +
> +#include <linux/compiler.h>
> +
> +/**
> + * ARRAY_SIZE - get the number of elements in array @arr
> + * @arr: array to be sized
> + */
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_ar=
ray(arr))
> +
> +#endif  /* _LINUX_ARRAY_SIZE_H */
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.=
h
> index 0f0cd01906b4..4f4d4f4af0a6 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -6,6 +6,7 @@
>  #ifndef __LINUX_CLK_PROVIDER_H
>  #define __LINUX_CLK_PROVIDER_H
> =20
> +#include <linux/array_size.h>
>  #include <linux/of.h>
>  #include <linux/of_clk.h>
> =20
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index b63746637de2..baf4ffcd8d18 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -6,6 +6,7 @@
>  #ifndef _COUNTER_H_
>  #define _COUNTER_H_
> =20
> +#include <linux/array_size.h>
>  #include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> diff --git a/include/linux/genl_magic_func.h b/include/linux/genl_magic=
_func.h
> index 2984b0cb24b1..cec9cae51f0b 100644
> --- a/include/linux/genl_magic_func.h
> +++ b/include/linux/genl_magic_func.h
> @@ -2,6 +2,7 @@
>  #ifndef GENL_MAGIC_FUNC_H
>  #define GENL_MAGIC_FUNC_H
> =20
> +#include <linux/array_size.h>
>  #include <linux/build_bug.h>
>  #include <linux/genl_magic_struct.h>
> =20
> diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
> index f6c666730b8c..09c5f1522b06 100644
> --- a/include/linux/hashtable.h
> +++ b/include/linux/hashtable.h
> @@ -7,6 +7,7 @@
>  #ifndef _LINUX_HASHTABLE_H
>  #define _LINUX_HASHTABLE_H
> =20
> +#include <linux/array_size.h>
>  #include <linux/list.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 0d91e0af0125..7195c6f27a22 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -11,6 +11,7 @@
>  #ifndef _LINUX_KERNEL_H
>  #define _LINUX_KERNEL_H
> =20
> +#include <linux/array_size.h>
>  #include <linux/stdarg.h>
>  #include <linux/align.h>
>  #include <linux/limits.h>
> @@ -49,12 +50,6 @@
>  #define READ			0
>  #define WRITE			1
> =20
> -/**
> - * ARRAY_SIZE - get the number of elements in array @arr
> - * @arr: array to be sized
> - */
> -#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_ar=
ray(arr))
> -
>  #define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
> =20
>  #define u64_to_user_ptr(x) (		\
> diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
> index 0b35a41440ff..b6fdd92ccb56 100644
> --- a/include/linux/kfifo.h
> +++ b/include/linux/kfifo.h
> @@ -36,6 +36,7 @@
>   * to lock the reader.
>   */
> =20
> +#include <linux/array_size.h>
>  #include <linux/kernel.h>
>  #include <linux/spinlock.h>
>  #include <linux/stddef.h>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 9d3ac7720da9..a629b398a592 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -3,6 +3,7 @@
>  #define __KVM_HOST_H
> =20
> =20
> +#include <linux/array_size.h>
>  #include <linux/types.h>
>  #include <linux/hardirq.h>
>  #include <linux/list.h>
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 962cd41a2cb5..3cecef5fa1cf 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_MODULE_PARAMS_H
>  #define _LINUX_MODULE_PARAMS_H
>  /* (C) Copyright 2001, 2002 Rusty Russell IBM Corporation */
> +
> +#include <linux/array_size.h>
>  #include <linux/init.h>
>  #include <linux/stringify.h>
>  #include <linux/kernel.h>
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 5159d692f9ce..cd27ef633a4f 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -13,6 +13,7 @@
>  #ifndef __LINUX_MTD_RAWNAND_H
>  #define __LINUX_MTD_RAWNAND_H
> =20
> +#include <linux/array_size.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/nand.h>
>  #include <linux/mtd/flashchip.h>
> diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
> index d4fed4c508ca..f9ca506c4261 100644
> --- a/include/linux/netfilter.h
> +++ b/include/linux/netfilter.h
> @@ -2,6 +2,7 @@
>  #ifndef __LINUX_NETFILTER_H
>  #define __LINUX_NETFILTER_H
> =20
> +#include <linux/array_size.h>
>  #include <linux/init.h>
>  #include <linux/skbuff.h>
>  #include <linux/net.h>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 716953ee1ebd..7a3de980ed9d 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -5,6 +5,7 @@
>  /*
>   * Copyright 1995 Linus Torvalds
>   */
> +#include <linux/array_size.h>
>  #include <linux/mm.h>
>  #include <linux/fs.h>
>  #include <linux/list.h>
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 11c1e91563d4..39e88b570ead 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -11,6 +11,7 @@
>  #ifndef __PHY_H
>  #define __PHY_H
> =20
> +#include <linux/array_size.h>
>  #include <linux/compiler.h>
>  #include <linux/spinlock.h>
>  #include <linux/ethtool.h>
> diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/ma=
chine.h
> index 0639b36f43c5..ee8803f6ad07 100644
> --- a/include/linux/pinctrl/machine.h
> +++ b/include/linux/pinctrl/machine.h
> @@ -11,7 +11,7 @@
>  #ifndef __LINUX_PINCTRL_MACHINE_H
>  #define __LINUX_PINCTRL_MACHINE_H
> =20
> -#include <linux/kernel.h>	/* ARRAY_SIZE() */
> +#include <linux/array_size.h>
> =20
>  #include <linux/pinctrl/pinctrl-state.h>
> =20
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 8c3c6685a2ae..f7889c7c3a66 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -10,6 +10,7 @@
>  #ifndef _LINUX_PROPERTY_H_
>  #define _LINUX_PROPERTY_H_
> =20
> +#include <linux/array_size.h>
>  #include <linux/bits.h>
>  #include <linux/fwnode.h>
>  #include <linux/stddef.h>
> diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wai=
t.h
> index 699b938358bf..a321404eeec0 100644
> --- a/include/linux/rcupdate_wait.h
> +++ b/include/linux/rcupdate_wait.h
> @@ -6,6 +6,7 @@
>   * RCU synchronization types and methods:
>   */
> =20
> +#include <linux/array_size.h>
>  #include <linux/rcupdate.h>
>  #include <linux/completion.h>
> =20
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 8fc0b3ebce44..af0430dc0945 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -10,6 +10,7 @@
>   * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
>   */
> =20
> +#include <linux/array_size.h>
>  #include <linux/list.h>
>  #include <linux/rbtree.h>
>  #include <linux/ktime.h>
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 054d7911bfc9..d7e3b9f46d58 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -4,6 +4,7 @@
>  #ifndef _LINUX_SKMSG_H
>  #define _LINUX_SKMSG_H
> =20
> +#include <linux/array_size.h>
>  #include <linux/bpf.h>
>  #include <linux/filter.h>
>  #include <linux/scatterlist.h>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index dbfc66400050..3c920b6d609b 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_STRING_H_
>  #define _LINUX_STRING_H_
> =20
> +#include <linux/array_size.h>
>  #include <linux/compiler.h>	/* for inline */
>  #include <linux/types.h>	/* for size_t */
>  #include <linux/stddef.h>	/* for NULL */
> diff --git a/include/linux/surface_aggregator/controller.h b/include/li=
nux/surface_aggregator/controller.h
> index cb7980805920..dcce0b663a3a 100644
> --- a/include/linux/surface_aggregator/controller.h
> +++ b/include/linux/surface_aggregator/controller.h
> @@ -12,6 +12,7 @@
>  #ifndef _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H
>  #define _LINUX_SURFACE_AGGREGATOR_CONTROLLER_H
> =20
> +#include <linux/array_size.h>
>  #include <linux/completion.h>
>  #include <linux/device.h>
>  #include <linux/types.h>

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------LMve7cXexGde0dyAa1VwcxEd--

--------------K6EBxUhtYCvjdHouZM93UhNd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTegesACgkQnowa+77/
2zJnww//f77oaeF1hfR86huOIjrML990rXlZ/07x+kYEQUb0Q+Ei7Q67fmcbx4aM
dupF8vuPCUdcvDvFMmMfIZascgZ6aHnAoayWnXiCYJVKV/4ZhhgFzaRGwtTs5Pgk
dkD/66B6ntkE9ejR1V2MFLCIhp8AXr20YPZmAtH3KQ3JuFdesEhHwp7gTdVGzQ/C
tiSyqgosupvsk725GziCrhNDxu0VwqlmdkdGqZUf2EuNDWWg615SruP4olyRR/77
4H91ds1YKu5y5qppd+PjInvaGr5g4345OCAyQKVWLnR/ZOtuNDiOzEfI99V4ecpl
99uZMZ7sIUbddwdcq/KuCmeni+uMaAZso+nwLPJf1iKrWCQnDtJTLRWq4XSVzLvx
GSiFJO3BKeJotxeAmI6ZUmZRm32JdHYnNM472a8baj4pVfhKkpwVOhj/2LBmXwj/
o7wHNjJFMD6OOYMyrzmT5mSkVLqqUA6SxhIKp1ou5eXlnEO2tvlMSd/33op8UXJQ
6b9h2hlhcErJe46NqlBccfVjkNq6Dcambp+ngCLh7jBlShor/dOv4Y5OHiFAYAMz
XwuqaBkjO3lyNqWkLwEoEBlFBVqdcNhkqUIokLJUU0tim5MB3P0R9lUN33eaDIco
NrqZ304AsbtUvjqMvTUvsQlyMPrANiiEsPsgsnZY8Qp86Bi9MEQ=
=DC/L
-----END PGP SIGNATURE-----

--------------K6EBxUhtYCvjdHouZM93UhNd--
