Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4880BFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjLKCrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjLKCrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:47:09 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED1E8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 18:47:15 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231211024713epoutp02f06b4c2e1345e9b53ee5084e68a2c128~fpwc3AGuS0545705457epoutp02h
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:47:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231211024713epoutp02f06b4c2e1345e9b53ee5084e68a2c128~fpwc3AGuS0545705457epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702262833;
        bh=3y7Tkpr4YBYZLXEAHtJR6ivwaNX07D4tzVv45KH1p8M=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=FLK9Uc2yMITyRgqjWk32ygjqYmkF9lLquFM3KCF/oy5js1Ynv4lEYlZrCRsDWv61p
         kFvmai36h7HAXfc3jDTYc5lVK2Ef68TN7Fhdf8E5rstAR19mRcU8gnkZEBB9IBuI87
         OVxoDmdiMUce1tGezE1ccplGahnyTJCq7MkUmRLg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231211024713epcas2p1e262d16d031987878bcda9c999301dd5~fpwcWgP460763107631epcas2p1k;
        Mon, 11 Dec 2023 02:47:13 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SpR3h53qKz4x9Pw; Mon, 11 Dec
        2023 02:47:12 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.DB.18994.03876756; Mon, 11 Dec 2023 11:47:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20231211024712epcas2p17c42285dfcf1c39e52a7b7684785617b~fpwbeBcUW0032200322epcas2p1W;
        Mon, 11 Dec 2023 02:47:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231211024712epsmtrp15d78825173bfe8a5f8fde151ff7568c1~fpwbcNTAq2543325433epsmtrp1Z;
        Mon, 11 Dec 2023 02:47:12 +0000 (GMT)
X-AuditID: b6c32a4d-00bd8a8000004a32-05-657678306bad
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.2C.08755.F2876756; Mon, 11 Dec 2023 11:47:11 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231211024711epsmtip18edf201b95a1a81b1b7174a74289a5bf~fpwbIVOuU1480814808epsmtip1K;
        Mon, 11 Dec 2023 02:47:11 +0000 (GMT)
Message-ID: <04a874f4-df4b-2a9d-ea02-bbb63095d199@samsung.com>
Date:   Mon, 11 Dec 2023 11:44:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/4] pinctrl: samsung: support ExynosAuto GPIO
 structure
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
From:   Jaewon Kim <jaewon02.kim@samsung.com>
In-Reply-To: <9d496fb5-25b4-4f1a-9652-4c54cf2d59a1@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wTZxjO1zvagw29VQjfuoaxI8MgA3uMwrEAY9GMbg6ELC6ZS4YXeitI
        abteYSLLRCYdEKsyNErTAhuGbR2WURAmoSX8cPyIloQZGlRog5CgBRbqFBdB19K68d+T93me
        933e7weG8O9yBViRQsOoFbSc4IagPcOx4njRsTJGdH0xhnI19XCpdqudQzWP2IOob1s7uNSq
        UUhZ3Vd51PmNnziU5d50ENXVvAGoP/sMXGp21gSoS5M2DnWjVcejqq0jPGp4+bsg6p++JpQy
        9Xl1d+obQCZfck0/y5NYTLVcyd3pfq5kwNjOk3RdPiE5uymSnOk2AclDS2Qudrg4rZChpYw6
        ilEUKKVFClk6ceDj/H354mQRGU+mUilElIIuYdKJ/R/lxr9fJPduQkSV0fJSbymXZllib0aa
        WlmqYaIKlawmnWBUUrkqRZXA0iVsqUKWoGA075AiUaLYKzxSXNhvvoaoDDuP1fQscipB70t1
        IBiDeBK02efROhCC8fF+AAetM0E+go97ALxuTPMTjwEc0P3KfeEwV3fy/IQVQOfoasDuBvCW
        qY/jU4XiGbD9yhTiwyj+Jjz90Ij466/A8cYF1IfD8c9gdZvT2xXDduF5sGUizldG8Ah4e6F5
        q00Y7kSgW1vh64/gLgCN9kfAR3DxOLje0boVNdg7a+B5I9dvfh32rhgQnwHif2NQ93N7IPZ+
        6PKsAz/eBR+MdvP8WADvn9UGsBJqb90I4K9hZ8tUQP8u1D/tDvIFRfBY2NG31wchHg1HbqP+
        sTtgzfAmz18OhTVavt8YA50X7IEAQvj9yC8cv0QCx9qoc+AN/bYz0W9bXr9tF/3/Y1sAagIC
        RsWWyJiCRBUZr2C++u+6C5QlFrD1zPdk/w7cHZsJQ4CDgSEAMYQICxWOsAw/VEqXH2fUynx1
        qZxhh4DYezv1iCC8QOn9JwpNPpmUKkpKTiZTEsWiFCIidK7aKOXjMlrDFDOMilG/8HGwYEEl
        p7zp6r6jY+tHyTjzuOfLmQx80ZGaN1q7cuhT9nm5rvFxdIXAdjJr4tH0TcnyTdeyJUzY4yAn
        8QPPCnPC3PM7Kg4botdyq+bIEz3hGJr3WpTjINJrzV9diXnviOPDH3SOCyp7Le/iMzTSJdOi
        OZ7FnLkn9W/F8v9YWPLYBrtTbKrNH5dOweSlrA/Ipxa6PyN9WId8kbxb30G2DVrXVrOF582/
        3ZmZEL66UVU/0b078wrMmASNtr8uTkU+yNyZ4OiaZ7NnDJ1kVeX8J8hag1t8+vMsZ8jlCrn9
        TJ1RajY437aUnXz5kvibUzNObc3BQ/ed8Q1T9wjH+Ji9LrrGFUGgbCFN7kHULP0vZAUJ6m8E
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSnK5+RVmqwcZ+a4sH87axWazZe47J
        Yv6Rc6wWzYvXs1m8mytjsff1VnaLKX+WM1lsenyN1WLz/D+MFpd3zWGzuHt3FaPFjPP7mCzO
        LO5lt2jde4Td4vCbdlaLn7vmsVis2gVUd3viZEYHIY+ds+6ye2xa1cnmcefaHjaP/XPXsHts
        XlLv0f/XwKNvyypGj8+b5AI4orhsUlJzMstSi/TtErgy9qzbyVwwh7+iY9tTpgbG7dxdjJwc
        EgImEutaN7J3MXJxCAnsZpRYeW0ZE0RCRmL5sz42CFtY4n7LEVaIopeMEn9XPwEr4hWwk1iz
        9hIziM0ioCrR83kuM0RcUOLkzCcsILaoQLTE6s8XgJo5OIQFAiUWnNIGCTMLiEvcejKfCWSm
        iMBjZomHU/8zgzjMAg8YJZZPegS17SejxLaPrxhBWtgEtCW+r1/MCmJzAm3e/38mG8QoM4mu
        rV2MELa8xPa3c5gnMArNQnLILCQbZyFpmYWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8
        dL3k/NxNjOAI1tLcwbh91Qe9Q4xMHIyHGCU4mJVEeGWOFKcK8aYkVlalFuXHF5XmpBYfYpTm
        YFES5xV/0ZsiJJCeWJKanZpakFoEk2Xi4JRqYBJ6yeGixmWS03ljFb9f0txa9+PzS6+U/np9
        sl9a7/+ayeuftx9tLxH5d1ngDYMZ559t39tlTot+Nv18OeUHq2H1w5tCxpx3/u071M5zR319
        UeEkE9b+LLOdy09xRN68fsfhz30rq8eqMywkotbvY/IuMFu6f6PqfPvQCP+HhwrCrxr2Knxo
        7Tms2Kxze/u7vifvoza2Sc6wiF+X/e5w+5y+tKjQ6i/xd5Zsm8dbsLPY54q7wcU79/0rCr81
        sEmsObd4xVE/0a2b4jdbbXjTfWHCrMc5TBN3L9J2j9/Rd4zbj08j2CPU7BLLnXVNS5ptn2VZ
        x6W+6Wt40Haxwab0m6/wp/Rlxm3qBU0e89m3LFJiKc5INNRiLipOBAAn9bt9TwMAAA==
X-CMS-MailID: 20231211024712epcas2p17c42285dfcf1c39e52a7b7684785617b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208075020epcas2p260c65fa8d33e0cd97806f065bb8a044d
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
        <CGME20231208075020epcas2p260c65fa8d33e0cd97806f065bb8a044d@epcas2p2.samsung.com>
        <20231208074527.50840-4-jaewon02.kim@samsung.com>
        <9d496fb5-25b4-4f1a-9652-4c54cf2d59a1@linaro.org>
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23. 12. 10. 22:23, Krzysztof Kozlowski wrote:
> On 08/12/2023 08:45, Jaewon Kim wrote:
>> New ExynosAuto series GPIO have a different register structure.
>> In the existing Exynos series, EINT control register enumerated after
> Missing verb... or enumerated is past tense? I just don't get entire
> sentence.

Sorry, I will add 'is' like below.

In the existing Exynos series, the EINT control register is enumerated 
after a specific offset.


>
>> a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET, EXYNOS_GPIO_EMASK_OFFSET).
>> However, from ExynosAutov920 SoC, the register that controls EINT belongs
>> to each GPIO bank, and each GPIO bank has 0x1000 align.
>>
>> This is a structure to protect the GPIO bank using S2MPU in VM environment,
>> and will only be applied in ExynosAuto series SoCs.
>>
>> -------------------------------------------------
>> | original		| ExynosAutov920	|
>> |-----------------------------------------------|
>> | 0x0	GPIO_CON	| 0x0	GPIO_CON	|
>> | 0x4	GPIO_DAT	| 0x4	GPIO_DAT	|
>> | 0x8	GPIO_PUD	| 0x8	GPIO_PUD	|
>> | 0xc	GPIO_DRV	| 0xc	GPIO_DRV	|
>> | 0x10	GPIO_CONPDN	| 0x10	GPIO_CONPDN	|
>> | 0x14	GPIO_PUDPDN	| 0x14	GPIO_PUDPDN	|
>> | 0x700	EINT_CON	| 0x18	EINT_CON	|
> This suggests there is EINT_CON per bank in old and new register layout.
> I don't think it's true, so probably this could look like:
>
> | ---                           | 0x18	EINT_CON (per_bank) |
> | ---                           | 0x18	EINT_FLTCON0 (per_bank) |
> | ---                           | 0x18	EINT_FLTCON1 (per_bank) |
> | ---                           | 0x18	EINT_MASK (per_bank) |
> | 0x700	EINT_CON (global)       | 0x18	EINT_CON	|
>
> etc..
>
> Also, please use spaces for alignment in the table.
>
Thanks you for your review.

I will add (global), (per_bank) for clearer expression.

And, I will use space instead of tab in v4.

>
> Best regards,
> Krzysztof
>
>
