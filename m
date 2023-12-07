Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9E58092C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443921AbjLGUtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjLGUs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:48:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40F01718;
        Thu,  7 Dec 2023 12:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701982124; x=1702586924; i=w_armin@gmx.de;
        bh=j1KQyy5uZSILlZqSsSLS4MPgyN7jRnDBrPne253w/98=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=Wobu4kRet4gqvrIHkX2jrUrdBFggYsB+Y9RFiRqdlYxkj+JSKg7L5EBuTWoLGN9F
         Hj9Sl24cl4STDiyMfRStquQ8xXqhufPDx4zrzIArgoOwAC6HswGZkTFBB6cubMR7L
         VdRv+EBHvOk3yvcnxzDpgoZu8noOUSwOLUNza3xdDXcaX3G56Wrbw0LIA6qwdtZeE
         yd4Gj5CyP/vgcYcFol0psU85fKG8G95y0rzfSj35jd1TRy6O7fC0D1G7mQ/0k2TVR
         SeYZdR5W0eB3zpWkhJPjLewIwbdACPkwwTF9wUKotIEV7dX6wFfEJoEo96EAatjov
         7wxkUcn5Vysi5r2Miw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mf0BG-1rhvxm0Vbe-00gWKN; Thu, 07
 Dec 2023 21:48:44 +0100
Message-ID: <67069bf0-58d9-44d3-94ac-4cbc2647d447@gmx.de>
Date:   Thu, 7 Dec 2023 21:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: Add driver for Gigabyte AORUS Waterforce AIO
 coolers
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231207122402.107032-1-savicaleksa83@gmail.com>
 <ce3568c5-c35b-40b5-80f1-8334d1b3549b@gmx.de>
 <f6522abb-885d-4476-bf27-5ee8b48138bd@gmail.com>
From:   Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <f6522abb-885d-4476-bf27-5ee8b48138bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:81m6qr5n2wi/45vDrfvBrgtzddgoNeb23aZ/edWnNoRvayYIdEg
 OF5OdaVYEROH4WrDLXDDTbbJkrhgKPZxCY84OjWP/tDkMgmG6i8tlE82PlwayJLtGe2MWhY
 H0OPp98u1xb3CxuG8KkEY07O3o03K2u54hs8Qe4TgkmaoGXaOagErmpD54deKDtgdAFox+g
 B755s4uYQfPfJX+8cQpyw==
UI-OutboundReport: notjunk:1;M01:P0:riQAvS79JTc=;WUYCzJoA3zXDwlHjK6hopcaQDOE
 TCHTIL8gu/0fQzWbxWL3jwTj6xX3S+7y4UvfUxoyaoKCzFCzElsvA3wxibUUrI9R4dvSzR1/3
 Mle85oLrI9p/Y3KRHtMKOfp1k7oibA1iuyVbSu9UB9IbitPhoO3UeCNFGBHgnattAmifRJ4J5
 28A8l+m/J+sfBSVGOh9Ri1MRGmcx9ECk0+RDAm6znPZ2sMoeGjW767ytA+gxLpVlqCjjj4ArF
 DRLROB2mKgPrPZ8TsmfeVWhFpEI4ycdzmvEPsEuOUbmrMLGzOJqPEaxewHbR0xqtL2EPq64RY
 HuCK09WOj2onJdC3KdGFfvrZa0xHKhvyNS47+Y/+sG+D7eNpYdyj1ObzkhTUWqewCAsxe4EB8
 1mb1ZFqiQ4X8c5tvwiJgP3HVc8MREmDso7U7JXtAhJ0EpJHwZlfWmBCTYyftxdoBYQSBSZ0MB
 u6bFU1js22Dk+QFdpbboJ4nA82pgofvT0dlwfS15c8O9vxkm16g+bIuwUWqHVDxv8IbHlxei7
 qLXtXY3I08BHw22RDqpE/+IArIbFZ7v36EPrxBYbUp4ZFLj4aJUPHoLTBjJIRNRnvxJ/YvgxX
 Lk8BuDJpKyhsWYxQ9kTKnJPgfYT3rU2ET/1oT1ivYLZihraRXJtWvcEOKA5QpF10kMFpfUW80
 MKh3oLhzYcaPQIqBSC47slE2exUr65/qAgGorpGDDOwek4TCdbcx3t8f157rRG6IyAHbIFi+P
 tgquCz9B6C/x67PNRqEjDF//9S997W0hjFv4IJnrHUklmywDucEE4Kk2g4P14AbKvqZEyqBFY
 xUAPrsGDeQQ3yz6VQVz25Gp6+I4+Puv+Km1hh7yd+0TocSvvy+hfydhFG7YTYCh3JFyAs3POe
 bIeTQnHwcmmCkmui6HGdbg11VHuyoMtp5FQexAFj/W6ewL0Cc2xJems1CZXP405hZHiKm7HVp
 j+s0UWZpoddTkRzmWhChxuCkcsQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.12.23 um 21:04 schrieb Aleksa Savic:

> On 2023-12-07 20:39:23 GMT+01:00, Armin Wolf wrote:
>> Am 07.12.23 um 13:23 schrieb Aleksa Savic:
>>
> ...
>
>>> +
>>> +static struct hid_driver waterforce_driver =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D "waterforce",
>>> +=C2=A0=C2=A0=C2=A0 .id_table =3D waterforce_table,
>>> +=C2=A0=C2=A0=C2=A0 .probe =3D waterforce_probe,
>>> +=C2=A0=C2=A0=C2=A0 .remove =3D waterforce_remove,
>>> +=C2=A0=C2=A0=C2=A0 .raw_event =3D waterforce_raw_event,
>>> +};
>>> +
>>> +static int __init waterforce_init(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return hid_register_driver(&waterforce_driver);
>>> +}
>>> +
>>> +static void __exit waterforce_exit(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 hid_unregister_driver(&waterforce_driver);
>>> +}
>>> +
>>> +/* When compiled into the kernel, initialize after the HID bus */
>>> +late_initcall(waterforce_init);
>>> +module_exit(waterforce_exit);
>> Hi,
>>
>> I think you could use the module_hid_driver() macro here.
> As far as I'm aware, hwmon will get built before hid, so a late_initcall=
()
> is necessary for this to function when compiled as a built-in driver. Ot=
her
> HID drivers in hwmon also do this (see nzxt-smart2 for an example).
>
> Aleksa
>
Interesting, in this case forget about my suggestion above.

Armin Wolf

>>> +
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_AUTHOR("Aleksa Savic <savicaleksa83@gmail.com>");
>>> +MODULE_DESCRIPTION("Hwmon driver for Gigabyte AORUS Waterforce AIO co=
olers");
>
