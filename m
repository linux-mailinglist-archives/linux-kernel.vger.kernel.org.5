Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33857E9110
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 15:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjKLOFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 09:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjKLOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 09:05:41 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22941273F;
        Sun, 12 Nov 2023 06:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
        s=s31663417; t=1699797868; x=1700402668; i=frank-w@public-files.de;
        bh=p3jF1nL7lYA2/EJPSIJDaTQe95ovTYY7WJc4wEUUhKI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=fMvKJqxKNZI8B3wDOXZcbBXyfyEUXEsd4E9urPIMi6f8uhpjC+/F4L1KwDxNon/1
         etwwV60cqpLer7ZU4JtW/9xSytrCNvmm9LhG5Suv9j7baKgDxZwQc0vVUN8i7rOqx
         ZmMR3tb6WBSFAkC3kz+eSr9CR0D+38zPJf2GbB9WvIHnVJL+MwZGOim43+az7CwHB
         H7Di0yWxNm2XgGOTqy7nNo5yA6nCczqMwgc4+66SyagdPoDcFbL9Q4nmzy8omJjkE
         7dnkHr/mgYAQIpCQaZgld35bhd18M1kCPoVNs5Sr3q1OVinoD1+xFtYbLQSYktyWZ
         9fuJIHtYi4McuTNWng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.158.24] ([217.61.158.24]) by web-mail.gmx.net
 (3c-app-gmx-bs50.server.lan [172.19.170.103]) (via HTTP); Sun, 12 Nov 2023
 15:04:28 +0100
MIME-Version: 1.0
Message-ID: <trinity-a0ee3146-f23d-4f6c-b29c-5fe446c4d4ad-1699797868421@3c-app-gmx-bs50>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        ricardo@pardini.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Aw: [PATCH 6/6] crypto: rockchip: add rk3588 driver
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 12 Nov 2023 15:04:28 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20231107155532.3747113-7-clabbe@baylibre.com>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-7-clabbe@baylibre.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:OoAQhTgJe+OnN14Ltb8pATB1NCHflAApEBwZRkflJMrP0ATga6qVPOdzsQywS95zapWsZ
 nDNEwLBK361alVtcNqDvR0ArMxhkOlIU7PvcYTzpIjgWS1YvLzSkwVoRXV7JU+y7yG5Dj7k5rCvK
 iZ9ApwxRzK4IkYYRAwe/UeIb0c2xbtIlERJ2AUW9d2vIf2XDT4RgAwCHAviGdDXrCKov2VxC/TkK
 otehpuNxb1t2AmnzoUL3pS/I43Lvz+sF5qbaVyou0Mw1OfSaOxHembZz+ZEaMOOQThQCYUI/NMbF
 v0=
UI-OutboundReport: notjunk:1;M01:P0:Sl09NE6Frd0=;/GSJn2QR97NKCRwp/dLBao2LoRb
 wESdckVa3vNp5KpgBgjr6rsV21sSASn/BKGZOAgctcv1Mc7pQ/2j3xFa7ymOwvQA5+TkN4umy
 EhM9dM7nLtENaoacrpFYWpJJN/vipIfAujPkvB/NN8l1FuW7/CxnqfO8DIsVOcQt1oxWYkf+W
 w1aOl8YPolj+5dEShiE9wdHTH9IwHJTpp7ozdRqiDMOHwVcMINaPgtNHFUpzHryhTdhZAGLdu
 OosdmnXiKPAYbgI83I/gEpjY1y63W8OgCibKpRn745dQd79gtgENTrFtXliXxW3UDvMMjhOaz
 jRhnNQ023hjzrFOUcch3XUvnHy+wjlZN5kF/HZ8+cgIxWD99/ksDKljBefRmq9W2/Ob6eRd2K
 y1CDIfBi1guZ+dFk2fA2cKoYvMg9e7Yz707kcSaSCLoQ6q3c/oVbK0BSW0uUhSzZ1EUKkH+5x
 ilEnox795eexXqvgVGNnUGtowc25ltcleuatGXon4wfZEjWJVbhpqfjhSSS1dOMLBK9dl3ppn
 Qe25FhpF/VIEMRvDBvmfI+E1U0e4CZICN15IhdPOJ0lKpkrSDhv3ExPJRXrPV/4NGy0R7lD+r
 UNF2c6RS/d76msN1USnwORxv/PJsxsR62PRPF486Y/OrPGg3Vyt+1CgjSISCEue+N9J0DYEen
 P9LjqgFHd75v6GOqFJGhQDU+btvP0/yFgZjUPqYniTYZON9v3lfQciHH0P06Od33c00LDCFCu
 mEAyRNVkK9hyNuutJutrpfRUqKvKreZNUb7MyN1nusackIff1CMmBFP6ZhIT0p9mTswu02c5o
 HwgkTPpzHPoSd6MwzVidD61mIXQShmbe9RlhITP1jjRwc=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin

thanks for working on it

> Gesendet: Dienstag, 07. November 2023 um 16:55 Uhr
> Von: "Corentin Labbe" <clabbe@baylibre.com>
> An: davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au, k=
rzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, p.zabel@pengutr=
onix.de, robh+dt@kernel.org, sboyd@kernel.org
> Cc: ricardo@pardini.net, devicetree@vger.kernel.org, linux-arm-kernel@li=
sts.infradead.org, linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org=
, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, "Coren=
tin Labbe" <clabbe@baylibre.com>
> Betreff: [PATCH 6/6] crypto: rockchip: add rk3588 driver
>
> RK3588 have a new crypto IP, this patch adds basic support for it.
> Only hashes and cipher are handled for the moment.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/crypto/Kconfig                        |  29 +
>  drivers/crypto/rockchip/Makefile              |   5 +
>  drivers/crypto/rockchip/rk2_crypto.c          | 739 ++++++++++++++++++
>  drivers/crypto/rockchip/rk2_crypto.h          | 246 ++++++
>  drivers/crypto/rockchip/rk2_crypto_ahash.c    | 344 ++++++++
>  drivers/crypto/rockchip/rk2_crypto_skcipher.c | 576 ++++++++++++++
>  6 files changed, 1939 insertions(+)
>  create mode 100644 drivers/crypto/rockchip/rk2_crypto.c
>  create mode 100644 drivers/crypto/rockchip/rk2_crypto.h
>  create mode 100644 drivers/crypto/rockchip/rk2_crypto_ahash.c
>  create mode 100644 drivers/crypto/rockchip/rk2_crypto_skcipher.c
>
> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> index 79c3bb9c99c3..b6a2027b1f9a 100644
> --- a/drivers/crypto/Kconfig
> +++ b/drivers/crypto/Kconfig
> @@ -660,6 +660,35 @@ config CRYPTO_DEV_ROCKCHIP_DEBUG
>  	  the number of requests per algorithm and other internal stats.
>
>
> +config CRYPTO_DEV_ROCKCHIP2
> +	tristate "Rockchip's cryptographic offloader V2"
> +	depends on OF && ARCH_ROCKCHIP
> +	depends on PM

it should depend on CONFIG_CRYPTO_DEV_ROCKCHIP as rockchip folder is not i=
ncluded without it

drivers/crypto/Makefile
obj-$(CONFIG_CRYPTO_DEV_ROCKCHIP) +=3D rockchip/

> +	select CRYPTO_ECB
> +	select CRYPTO_CBC
> +	select CRYPTO_AES
> +	select CRYPTO_MD5
> +	select CRYPTO_SHA1
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
> +	select CRYPTO_SM3_GENERIC
> +	select CRYPTO_HASH
> +	select CRYPTO_SKCIPHER
> +	select CRYPTO_ENGINE
> +
> +	help
> +	  This driver interfaces with the hardware crypto offloader present
> +	  on RK3566, RK3568 and RK3588.
> +
> +config CRYPTO_DEV_ROCKCHIP2_DEBUG
> +	bool "Enable Rockchip V2 crypto stats"
> +	depends on CRYPTO_DEV_ROCKCHIP2
> +	depends on DEBUG_FS
> +	help
> +	  Say y to enable Rockchip crypto debug stats.
> +	  This will create /sys/kernel/debug/rk3588_crypto/stats for displayin=
g
> +	  the number of requests per algorithm and other internal stats.
> +
>  config CRYPTO_DEV_ZYNQMP_AES
>  	tristate "Support for Xilinx ZynqMP AES hw accelerator"
>  	depends on ZYNQMP_FIRMWARE || COMPILE_TEST
> diff --git a/drivers/crypto/rockchip/Makefile b/drivers/crypto/rockchip/=
Makefile
> index 785277aca71e..452a12ff6538 100644

else i did some tests, but it does not seem that the offloader is used (re=
quests stay at initial value after the bootup test)

i wonder about the last 3 lines in dmesg (fallback), seems i miss somethin=
g for these.

root@bpi-r2pro:~# dmesg | grep crypto
[    0.150643] alg: extra crypto tests enabled.  This is intended for deve=
loper use only.
[    2.718110] rk2-crypto fe380000.crypto: will run requests pump with rea=
ltime priority
[    2.720605] rk2-crypto fe380000.crypto: Registers crypto algos
[    2.721910] rk2-crypto fe380000.crypto: Register ecb(aes) as ecb-aes-rk=
2
[    2.724435] rk2-crypto fe380000.crypto: Register cbc(aes) as cbc-aes-rk=
2
[    2.725072] rk2-crypto fe380000.crypto: Register xts(aes) as xts-aes-rk=
2
[    2.725731] rk2-crypto fe380000.crypto: Register md5 as rk2-md5 3
[    2.726310] rk2-crypto fe380000.crypto: Register sha1 as rk2-sha1 4
[    2.726901] rk2-crypto fe380000.crypto: Register sha256 as rk2-sha256 5
[    2.727521] rk2-crypto fe380000.crypto: Register sha384 as rk2-sha384 6
[    2.728142] rk2-crypto fe380000.crypto: Register sha512 as rk2-sha512 7
[    2.728763] rk2-crypto fe380000.crypto: Register sm3 as rk2-sm3 8
[    3.502442] rk2-crypto fe380000.crypto: Fallback for xts-aes-rk2 is xts=
-aes-ce
[    3.770678] rk2-crypto fe380000.crypto: Fallback for cbc-aes-rk2 is cbc=
-aes-ce
[    3.939055] rk2-crypto fe380000.crypto: Fallback for ecb-aes-rk2 is ecb=
-aes-ce

root@bpi-r2pro:~# cat /sys/kernel/debug/rk2_crypto/stats
rk2-crypto fe380000.crypto requests: 581
ecb-aes-rk2 ecb(aes) reqs=3D132 fallback=3D1994
        fallback due to length: 342
        fallback due to alignment: 1648
        fallback due to SGs: 0
cbc-aes-rk2 cbc(aes) reqs=3D156 fallback=3D2182
        fallback due to length: 329
        fallback due to alignment: 1841
        fallback due to SGs: 6
xts-aes-rk2 xts(aes) reqs=3D137 fallback=3D2143
        fallback due to length: 116
        fallback due to alignment: 739
        fallback due to SGs: 0
rk2-md5 md5 reqs=3D14 fallback=3D739
rk2-sha1 sha1 reqs=3D28 fallback=3D716
rk2-sha256 sha256 reqs=3D25 fallback=3D654
rk2-sha384 sha384 reqs=3D32 fallback=3D656
rk2-sha512 sha512 reqs=3D34 fallback=3D638
rk2-sm3 sm3 reqs=3D23 fallback=3D712
root@bpi-r2pro:~# kcapi-rng -b 512 > rng.bin
root@bpi-r2pro:~# cat /sys/kernel/debug/rk2_crypto/stats
rk2-crypto fe380000.crypto requests: 581
ecb-aes-rk2 ecb(aes) reqs=3D132 fallback=3D1994
        fallback due to length: 342
        fallback due to alignment: 1648
        fallback due to SGs: 0
cbc-aes-rk2 cbc(aes) reqs=3D156 fallback=3D2182
        fallback due to length: 329
        fallback due to alignment: 1841
        fallback due to SGs: 6
xts-aes-rk2 xts(aes) reqs=3D137 fallback=3D2143
        fallback due to length: 116
        fallback due to alignment: 739
        fallback due to SGs: 0
rk2-md5 md5 reqs=3D14 fallback=3D739
rk2-sha1 sha1 reqs=3D28 fallback=3D716
rk2-sha256 sha256 reqs=3D25 fallback=3D654
rk2-sha384 sha384 reqs=3D32 fallback=3D656
rk2-sha512 sha512 reqs=3D34 fallback=3D638
rk2-sm3 sm3 reqs=3D23 fallback=3D712
root@bpi-r2pro:~#

if needed this is my current defconfig/tree:

https://github.com/frank-w/BPI-Router-Linux/blob/6.6-r2pro2/arch/arm64/con=
figs/quartz64_defconfig#L924

regards Frank
