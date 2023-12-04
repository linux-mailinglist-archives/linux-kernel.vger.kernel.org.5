Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8A48031A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjLDLkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDLkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:40:35 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADCAB0;
        Mon,  4 Dec 2023 03:40:41 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231204114040euoutp02292a0127f27ad873afe25d97659f31a9~dnhNdbYt51544815448euoutp02O;
        Mon,  4 Dec 2023 11:40:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231204114040euoutp02292a0127f27ad873afe25d97659f31a9~dnhNdbYt51544815448euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701690040;
        bh=qoSlDlAlmyMO1fD/zESFlbZVGoR0yDyo5RovorKXLGU=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=ZiElWQBWoN/gMkxnTbl4EIJxJaE/qWzC15BE8zltHkDgiAkzy4jcRQQtE89lZJRFE
         y0CAFQMH/8r3YrWb6vhMFfNnjlRU4OQG3F1D5CcUm6baAXYgCF3nBRHZq0UuUfINyM
         b9rZMUmPEL+y10xZs8D85HkEGozViYSZ4VZGZ/5w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231204114040eucas1p22e4e9d56a0f68b1e4d48c13f2cc13892~dnhNR4TKl1052710527eucas1p2C;
        Mon,  4 Dec 2023 11:40:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 47.26.09814.7BABD656; Mon,  4
        Dec 2023 11:40:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231204114039eucas1p29c6f8a162191e58ff658d3a1c44429bf~dnhM11-r21052710527eucas1p2B;
        Mon,  4 Dec 2023 11:40:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231204114039eusmtrp2aa892cf8db8bcd9cc62f775c443bc043~dnhMyrE4x3101831018eusmtrp2K;
        Mon,  4 Dec 2023 11:40:39 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-67-656dbab7ff2e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1A.00.09146.7BABD656; Mon,  4
        Dec 2023 11:40:39 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231204114037eusmtip1af7cdf53ae21703af228f6e129f28260~dnhLNXjH_2303523035eusmtip1g;
        Mon,  4 Dec 2023 11:40:37 +0000 (GMT)
Message-ID: <9e4e65de-7234-4234-8091-796277a1f1c5@samsung.com>
Date:   Mon, 4 Dec 2023 12:40:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 12/23] pinctrl: mediatek: Make use of
 PINCTRL_GROUP_DESC()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
In-Reply-To: <20231129161459.1002323-13-andriy.shevchenko@linux.intel.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjed87hnAOueKxsfEEJCQGjC3JZAL8NgmOT5EzdJpOxuBs2coZC
        uaSF1REWG0GETgTacStQNBCuCqzcK6bKBg0wLlZhpEMZ4yJggHUSN0B0tgc3/j3v+z7P97zP
        m3w0LlwgnegzcYmcJE4kdiXtiNae1cH9bbpYznvDfAANTq0TaCVPh6PWjECUdb4AQ9VPrmHo
        elY3gTTtTzD0fXedDZoc+QiVFisBMl7owlDJ+TYKZa72AzR9rQig2rwOAmWo2gg0NNRIoZuP
        Wii0rBmj0A9PqzCknRq1Qbn6AQo1lT0FSLFWg6O7uhIS3U29A1CmtgWglvklDE2pNSTqS5sj
        UHa5kUB1g7dJNFPURKKNNi2BluqmAVLVv4/mmh3Rb7kq8M4etmaumGLVEwMkW2e8SLIZl58R
        bO7AfrZDfZ9iy7V6ki3vnMdYbW0myY6PdpKspjeUbao4xw4VXgXsj0vtGJu94c0OK2KOCT+z
        C4zkxGe+4SReQSftTqfNPiQTftp+tnW9gZKDvlcVwJaGjC+c1KzaKIAdLWSqAbxU30jwxQqA
        Ff/c35w8BnAmdYN4KZFf7yD5QRWAFxYqMb4wAzhSc+sFi6YFTBB8oAIWAcG4wZnVAdKCBcwO
        2Fs0bX3oNcYFTpgKKQsmGR+oWFRYOTuZ4/Dn8QdWAwfmFxLeK222GuBMDgkbeu5Z1TjjCE3T
        ZZgF2zKH4aRy1obvu8C2xRLcIoCMfBvMX36+ufchqDT0kzzeCRcMzRSPd8PnHWUYL7gI4JX1
        ic0iB0D5QxPgWQFwfHCNtGTDmX2wQefFt4PhLd2yNTJk7OHY4g5+CXuobC3A+bYAZqQLefYe
        qDbU/2d7e9iI5wBX9ZbDqLdEU2+Jo/7f9wogaoEjlySNjeKkb8ZxMk+pKFaaFBfleSo+Vgte
        fIf+Z4aVdlC1YPbsAhgNugCkcVcHgcYUwwkFkaJvkzlJfIQkScxJu8AumnB1FLhHunBCJkqU
        yMVwXAIneTnFaFsnOVZj2q7sVh4Z85jpOfFK/Agnya/3EZszsuTy90aDvgpwp+cpMjPiQOhs
        aVjKTffdic75Rx8Fiw4ZZB59Rv1JcU9kchf3eW/649+VMb5npz/9YFdIxK8uDmF3ZI3V7wZM
        pWDLxUkHjc4H3ZzsQ4ZLR+3OReQ3OPVFJ4evb4CpTwL9C3NEl96O2isPNZRXJvy1z+DjvLJU
        o0+LNoccSdSd8vvicGXn8VWpSe3fd/RPuUtHoD7ULXjc71gWIwv/o7TZIUUm/rgiKvDyiWy3
        70K8C0zFVV+m9/ukKh23JYf7/e3lm2f8Gn3YemNNp/IQ+5r1BWGvJ/vfoIvfqotURbP1NriT
        2ZWQnhb5vIFLpKJ/Ac8KBzB9BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+T579mxQq6eJ7HtcRO66PPGY29zoixHVJfVQaSZedmhHU5/A
        Y2PcNrDsrIVU41GkbZJj4KjwFwxkbcCALHKhHHiAwsURTBAYAwowI7yQyQWs7vjvdZ/P+/35
        fO5zby6L/4AdyT2cpaM1WQqlkAjDbyy13Y51N6to8bwXoq6xRRz9XdzMQg2GBFSYdwZDl+5X
        Y6im8BqObI33MXTimp2NRn59C50tNQHU87kHQ2V5bg4qWLgBkK+6BKCq4iYcGcxuHHV3Ozjo
        xz/qOeiurZ+DTgcuYsg51sdGxpZODnKVBwBiHlSyUG9zGYF6j98CqMBZD1D91CyGxqw2AnXk
        T+KoqKIHR/auqwQaL3ER6KHbiaNZuw8g8+VkNFknQINGM3jpWapyspRDWYc7Ccre8yVBGU4t
        4ZSxM5Zqst7mUBXOFoKquDKFUc6qAoLy9l0hKFv725Tr3KdUt+VbQH0/24hRRQ/F1E0mcxc/
        VZSgUefo6Kcz1FrdC8J9EiQVSeKRSCqLF0m2PvfeNqlcuCUx4RCtPJxLa7Ykvi/KyPdPENm/
        PP5hw2ItRw86HmVAKBeSMqivaSIYEMblk+cBHG0rx4ONJ2H713p2kNfBQB/zn+gugIsDo4AB
        XC6PTIRDZrCiwcln4PhCJ7HCPPIJ2F7iW52znoyGwwMWzgoTpAQyM8yqZh2ZAlu9Q6scTnYR
        0GhJW2EWaSLg8Jg0uMsA4NVbJ7FgQwAHfOWrHEq+DkdMfnawHgeZegYEORq6Z8pYXwG+dc0d
        1jV26xqLdY3lG4BXgXA6R6tKV2klIq1Cpc3JShcdVKucYDmEDdcXXI3A9vs9kQdgXOABkMsS
        hvNsA5k0n3dI8dFRWqNO0+Qoaa0HyJefYWRFrj+oXk5xli5NEieWS2Rx8WJ5fNxWoYCXnG1Q
        8Ml0hY7OpOlsWvO/D+OGRuox9lL3u7uVNdKW0rCZs+7vilJvxso29qeM7KhLntjwmqPK8lf2
        xiOj4qN5S09FDbp/cM+fsCd9cuQNSWrl5tqXDR6f75jjz4shJrKxS2baMdi2Vxohn5tXO1oP
        6PIddz6uLX5Tb88P+BsDnL3nXIK6uk61xJ9k3u5Mn1OcDszlbst1CKriJl717vlg/2M7LYk7
        W8v4l6XdPp/hWLUs5foj4v3eL2Yu9LuizpMXPBFNuy8l9b4yrRrMihiPjqmImRhNn/+tY1fI
        0ELE9uMgtbmwuta/iR7+h+39Wft81FTIHlgUual8X8p02b2ozfq66QMbfjqDFU++46NPmV50
        f9anvENUCnFthkISw9JoFf8CmRY9FQ0EAAA=
X-CMS-MailID: 20231204114039eucas1p29c6f8a162191e58ff658d3a1c44429bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231204114039eucas1p29c6f8a162191e58ff658d3a1c44429bf
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231204114039eucas1p29c6f8a162191e58ff658d3a1c44429bf
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
        <20231129161459.1002323-13-andriy.shevchenko@linux.intel.com>
        <CGME20231204114039eucas1p29c6f8a162191e58ff658d3a1c44429bf@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.2023 17:06, Andy Shevchenko wrote:
> Make use of PINCTRL_GROUP_DESC() instead of open coding it.
>
> Signed-off-by: Andy Shevchenko<andriy.shevchenko@linux.intel.com>

This patch landed in linux-next as commit 1949e4630c3b ("pinctrl: 
mediatek: Make use of PINCTRL_GROUP_DESC()"). Unfortunately it causes a 
build break of ARM64 arch with standard defconfig.

> ---
>   drivers/pinctrl/mediatek/pinctrl-moore.h | 7 +------
>   drivers/pinctrl/mediatek/pinctrl-paris.h | 7 +------
>   2 files changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.h b/drivers/pinctrl/mediatek/pinctrl-moore.h
> index e1b4b82b9d3d..22ef1ffbcdcb 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-moore.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-moore.h
> @@ -38,12 +38,7 @@
>   	}
>   
>   #define PINCTRL_PIN_GROUP(name, id)			\
> -	{						\
> -		name,					\
> -		id##_pins,				\
> -		ARRAY_SIZE(id##_pins),			\
> -		id##_funcs,				\
> -	}
> +	PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), id##_funcs)
>   int mtk_moore_pinctrl_probe(struct platform_device *pdev,
>   			    const struct mtk_pin_soc *soc);
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.h b/drivers/pinctrl/mediatek/pinctrl-paris.h
> index 8762ac599329..f208a904c4a8 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.h
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.h
> @@ -50,12 +50,7 @@
>   	}
>   
>   #define PINCTRL_PIN_GROUP(name, id)			\
> -	{						\
> -		name,					\
> -		id##_pins,				\
> -		ARRAY_SIZE(id##_pins),			\
> -		id##_funcs,				\
> -	}
> +	PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), id##_funcs)
>   
>   int mtk_paris_pinctrl_probe(struct platform_device *pdev);


PINCTRL_GROUP_DESC() macro from drivers/pinctrl/core.h contains a cast 
to (struct group_desc), what breaks users of the above macros.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

