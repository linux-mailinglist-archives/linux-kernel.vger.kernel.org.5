Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBBA80BFA3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjLKCsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjLKCsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:48:13 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8FCDA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 18:48:19 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231211024817epoutp03b33387fea1bc65a812e5e986a947895a~fpxYkkYLT0429504295epoutp03P
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:48:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231211024817epoutp03b33387fea1bc65a812e5e986a947895a~fpxYkkYLT0429504295epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702262897;
        bh=rZejJMBuaSwsVc/aCyPlkYrHKlHgmO7Ghhnl4Zu9oB0=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=E4ZuNclykDyWzTZYG7i2med6WthYAFhuSbPjAKuMjIzpkSI4FVugjBkB4nVdD/DFL
         AWITUds0APoEG+ATyGa/k3cyGUxFj2q29FJ62b5Md9iML306g1DhD4jQankYkP84u+
         sNhz7RttqhXEmy5cJhcC6YFtfNHy0YjfZBj2SuSs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231211024817epcas2p387c9241c90237856d659b6dd309585c3~fpxX6attj2305223052epcas2p3z;
        Mon, 11 Dec 2023 02:48:17 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SpR4w3HY1z4x9Px; Mon, 11 Dec
        2023 02:48:16 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.8F.09622.07876756; Mon, 11 Dec 2023 11:48:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20231211024815epcas2p4bab12232eb9182f4de1c1b5d7d6b4568~fpxWqpqBs0127201272epcas2p4C;
        Mon, 11 Dec 2023 02:48:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231211024815epsmtrp27aabd70c6663656bcac0051fc27bfa47~fpxWjVu9O2544325443epsmtrp2E;
        Mon, 11 Dec 2023 02:48:15 +0000 (GMT)
X-AuditID: b6c32a46-fcdfd70000002596-1b-657678707158
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.3C.08755.F6876756; Mon, 11 Dec 2023 11:48:15 +0900 (KST)
Received: from [10.229.8.168] (unknown [10.229.8.168]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231211024815epsmtip2ddbf42bdf4ab5eff4d60d8fad33b55ef~fpxWPCIz42494524945epsmtip2L;
        Mon, 11 Dec 2023 02:48:15 +0000 (GMT)
Message-ID: <5e5df314-e64c-4181-b9b8-0674b36898d1@samsung.com>
Date:   Mon, 11 Dec 2023 11:45:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [PATCH v3 4/4] pinctrl: samsung: add exynosautov920 pinctrl
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
In-Reply-To: <a695f62f-5d08-49d6-a0b9-9f023ad7f586@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxz2vWuvVw3mrKBvGNFyyzDgwBaBvjhgHzZ42RZH3Ja4zQRu5VIY
        pa29lsGGKRnhQwObTjags4DDuFA/iJShNlQHdGwQUzdH2FJFWAZsUFAmccRIYS0HG/89v4/n
        9/w+3pfEZT4ikszXmzmTntXRxEZRV18sijcWF3GKtnkZGmvqItBFtxdDzR6vGJW3thPogT0K
        uf3fSlDd4jcY6vhjWIyczYsA/eI6Q6CREQdADbdvYOhWa60EVbg9EtQ3UyVGT1xNIuRwBfPu
        njoNXpIx120jEqbDcZxg7g13E8xN+0UJ4zxnZT4LKJhPOx2Ame/YkUW+W5CWx7G5nEnO6TWG
        3Hy9Np1+7c3s/dnJKQplvDIVqWi5ni3k0mn161nxmfm64CS0vIjVWYKuLJbn6T0ZaSaDxczJ
        8wy8OZ3mjLk6o8qYwLOFvEWvTdBz5n1KhSIxOZiYU5C3/KuDME5tKh6tPIuVgSHpCSAlIZUE
        L7kqxCfARlJGXQNwYmoCE4xHAH7VU78a+QfAAbuXWKPMPurChYAbwNqfq1YNP4DnrlZJQllh
        VAZsvNmAh7CIeg42NwwCwb8FDjSOi0I4gnoPVpwfXam6lWJgxxWBi1PboW+8GQvhcGoUh/7K
        j0MCODUGoN37eKUQQe2GC+2twf5IUhoUW3zICNyd8OrsmZWGIDVDwqXHZSKhbTVsWhoHAt4K
        p3/olAg4Es4/cK+OZoCVQ7dW/aXwSsud1fwXoe1p54oWTsXCdteeEITUs9DjEwmym2F1X0Ai
        uMNgdaVMIMbA0S/W9hYFP/e0YQJm4ODdbvwkiLatW4pt3fC2dcPY/tdtASIH2MYZ+UItxyca
        E/87tsZQ2AFWHnlc5jVQNzuX0AswEvQCSOJ0eFiUh+dkYblsyUecyZBtsug4vhckB09zCo+M
        0BiCv0RvzlYmpSqSUlKUqsRkhYreHna/wp4ro7SsmSvgOCNnWuNhpDSyDIsITEZUm3fdk70a
        Na090EVMz2GuA1/GDbfNfa1pjE/IocclC2iI7fFZgTSAyMBc/6Z3xh4mtVpekb/dUlbzwf7k
        koN/iy7tOyjeldaPVPlSaU6R9ce2mIladWn9DeeM//SS+y/7hsLJ875o5+9v7f1pecMLZ0uj
        3yh4Gn3nExO2o6jGP/C88rrZgJfMZoEP69R13xWTv1kv99SeFHXuljYenjjSb76/N1wVTizQ
        NcvLdP2WSdX3Vndmd9tlcZOaydrMTB0KR5bY/OycwWeqWq1/Wsud3thhc2zPsYSYmaLjmguH
        uxd9/dtulx89OkA+aUnNOHTk5Qvu9Kal9xeP7RTTIj6PVcbhJp79F8UGjphtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSvG5+RVmqwYJmSYsH87axWazZe47J
        Yv6Rc6wWzYvXs1m8mytjsff1VnaLKX+WM1lsenyN1WLz/D+MFpd3zWGzuHt3FaPFjPP7mCzO
        LO5lt2jde4Td4vCbdlaLn7vmsVis2gVUd3viZEYHIY+ds+6ye2xa1cnmcefaHjaP/XPXsHts
        XlLv0f/XwKNvyypGj8+b5AI4orhsUlJzMstSi/TtErgy/l9fxVbwkrvifttCpgbGK5xdjJwc
        EgImEm8/bWPuYuTiEBLYzSgxe8sPZoiEjMTyZ31sELawxP2WI6wQRS8ZJSa96mYESfAK2EnM
        3D8DrIFFQFVi/oxTUHFBiZMzn7CA2KIC0RKrP19gBbGFBTwkNm1sZwexmQXEJW49mc8EMlRE
        4DGzxMOp/8HOYBZ4wCixfNIjqHU/GSVmnpoCdgebgLbE9/WLgRIcHJxAq/+894CYZCbRtbWL
        EcKWl9j+dg7zBEahWUgOmYVk4SwkLbOQtCxgZFnFKJlaUJybnltsWGCYl1quV5yYW1yal66X
        nJ+7iREcwVqaOxi3r/qgd4iRiYPxEKMEB7OSCK/MkeJUId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rziL3pThATSE0tSs1NTC1KLYLJMHJxSDUx6h/e0z5NZm7HUuVEwTyDrzAnZng9Hnx508eIN
        mMeqFDUjqe7IgXm/TLnaT19wbFlns9dbnPX/WZfwQ6wzmu84xvxM4Tkm+2gvZ9t8u3fnnq+e
        Ldu7n0OjlFmtxiF1/0fFtJyVNTd/PzALVejbX1xp0xvYPz/vw0ZrlhOct54wJObeubt8qZHF
        t3LH2myxoCkSU3KaOXZ//LZF+VjXswbtl2kXL7N/mHL+Mcuv54teC1YlszmrBUp6zblc++bF
        dUHW4BqnTfyRoccfMepcUP2XVl/PylV081GO79PsdN9NzpuFA+SaRYMXVrddY34jPL2r5GrB
        6nNyNcfYBCUERWbXzigVe3u8IXdFdc23V0osxRmJhlrMRcWJAHcYMg1PAwAA
X-CMS-MailID: 20231211024815epcas2p4bab12232eb9182f4de1c1b5d7d6b4568
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208075020epcas2p414c85e03d18327665eeff54082314b56
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
        <CGME20231208075020epcas2p414c85e03d18327665eeff54082314b56@epcas2p4.samsung.com>
        <20231208074527.50840-5-jaewon02.kim@samsung.com>
        <a695f62f-5d08-49d6-a0b9-9f023ad7f586@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

Thanks for your review.


On 23. 12. 10. 22:23, Krzysztof Kozlowski wrote:
> On 08/12/2023 08:45, Jaewon Kim wrote:
>> Add pinctrl data for ExynosAutov920 SoC.
>>
>> Pinctrl data for ExynosAutoV920 SoC.
>>   - GPA0,GPA1 (10): External wake up interrupt
>>   - GPQ0 (2): SPMI (PMIC I/F)
>>   - GPB0,GPB1,GPB2,GPB3,GPB4,GPB5,GPB6 (47): I2S Audio
>>   - GPH0,GPH1,GPH2,GPH3,GPH4,GPH5,GPH6,GPH8 (49): PCIE, UFS, Ethernet
>>   - GPG0,GPG1,GPG2,GPG3,GPG4,GPG5 (29): General purpose
>>   - GPP0,GPP1,GPP2,GPP3,GPP4,GPP5,GPP6,GPP7,GPP8,GPP9,GPP10 (77): USI
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
> ...
>
>
>>   /**
>>    * struct exynos_weint_data: irq specific data for all the wakeup interrupts
>>    * generated by the external wakeup interrupt controller.
>> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
>> index 362e99566919..800a2f0a026a 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
>> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
>> @@ -1324,6 +1324,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
>>   		.data = &exynosautov9_of_data },
>>   	{ .compatible = "tesla,fsd-pinctrl",
>>   		.data = &fsd_of_data },
>> +	{ .compatible = "samsung,exynosautov920-pinctrl",
>> +		.data = &exynosautov920_of_data },
> Please put it after autov9.

Okay, I will change the order.

>
> Best regards,
> Krzysztof
>
>
>

Thanks

Jaewon Kim

