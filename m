Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C7379E6CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbjIMLbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbjIMLbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:31:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158721726;
        Wed, 13 Sep 2023 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1694604676; x=1695209476; i=wahrenst@gmx.net;
 bh=28UftcTBRZ6helOYZnhliSx5p5LHun67O1lu6Xhm8Ig=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=MyagVk0GEzc/rKdlwS5PzESKtkYq0Nf6cWuUra2ZHvtCgX2vjRnEPbU+JsbfJKpDzYbFmGi/McI
 FRPiQ/BgTf2ujLvaJn3sjGkGCNkOozTSokMOeCa/wZ04AbkfGfbOa+qFRQ/0zwE00wavBpdrvL4IY
 w2rhGsFV8Zu7H3nVIIlsQ4OJtcvX1qxLvUUUbx0IKTTT/2xp1k1ug+kOsR8C4piqv64h9pLaw3hfS
 1lnkBScVLvJjvqZ4e5fIUt/sV2KRgi9ZDf3AOe48Xt8BdPuxQ5PUjC1kj6Y5BXC3RujGb1Wg078/W
 lvffdQHRErnY/l1+xCRziKS2WbtTBDT0AhWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1qmgYP26np-006vkL; Wed, 13
 Sep 2023 13:31:16 +0200
Message-ID: <66a6c513-7277-255d-dd56-eed1d6a8efe8@gmx.net>
Date:   Wed, 13 Sep 2023 13:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v10 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Umang Jain <umang.jain@ideasonboard.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        athierry@redhat.com, error27@gmail.com,
        kieran.bingham@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        dave.stevenson@raspberrypi.com, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
References: <20230911140712.180751-1-umang.jain@ideasonboard.com>
 <20230911140712.180751-2-umang.jain@ideasonboard.com>
 <c96262e7-9bd9-c75d-7584-e6ff62f69530@gmx.net>
 <d006e31a-33df-51b1-c8cf-9c7e5590adb6@ideasonboard.com>
 <7b7d322d-5ea6-5048-0cbe-8d292853ba12@gmx.net>
Content-Language: en-US
In-Reply-To: <7b7d322d-5ea6-5048-0cbe-8d292853ba12@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J3aK1TsqiktJsf7+0PTG00rcEOkVlbMc3Ux6kZqx1ZcLBD2VqER
 snLZGlzHKbA1aKZcxgBUjapCgacwK30bDRXQkvZfGtmDSy9thlorNODA7nzs6wq6YxWjhzA
 r3fCuVhgYW5xuZNxbQuOoOlOVMhT4NMh25lcM3LPeUEgLPw3Qbq6IHks5lSZsNtzKIYLbTQ
 qyfZb4FnvwqwmR09bQRsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Aa5zqFzzW6Q=;TSWzz8UOW2Vrt7q1EYQ7JyeekD0
 M+7Y4SFDSO+xdOqfCDjRpApbN5hZI14riCM5UsU6vFcrmWW82Svc7KuBdelxTx1Z9lBKm/Roe
 QTfAck/dmZYo0L2pam5cPN3OENeHAE5IxL/mJJ0x3ZTx6xQ8UkfGhuGlTDtJ/XZLeRyf7dupD
 ib3VyCS7vkjDODHyKfKrIW5pnlAfKWTWFjNOjMLDJhfqB2mxrxeP5/vdQAbty5/nhHaypPKfI
 hw1vQtloYDs0Xao4EeihkjRxDfUxO8Z8+tzYzmQ1rvWtcM26zxTf3cwKII4NxmwvrZ/E3DT/t
 IfEWI67d0tc6snnI2N6EsgxaysXvK40C7YlB3OqAqGjQE/HtOOM5Ym/rrQzWNyBXrolcC/T9s
 z43f1kotSPl/PT8JXdvI3xRiou7QBYGy8ChoI3xiEwGdHp14kYauzz4O9G0j+vkAubabfve9P
 q0TtwBj4gVZ0i9md8IlMFLWf/u8ez6ddl5+2irvJ9Pr2qrUrsocrRbvUsxhaQP45Wq/e2QCw3
 rMtkkmzOUC0gYVxswc+dxpa1bKazq9E7y3zib0ShUm8u1ZDtoe/bduVvJPiPY750WWtmWmiDN
 bzPrt2TR3uHisyfSy8j2cndFAudj4nqHguL8yAD+MroQLU0TAwV0Av4jGJuwW2TQOVTdTgeBy
 LHzb7sqtc4vBP/OQiWQIoxNUhz2UGA55BK9bHWNodU5OMGGfdpMPike3ENoKlOZNceuT6az9F
 HxWfUR5BOIqftK62M8bVrpwAU00keHnU45XQTlpey0swdgv6b0qKpFF6BQPm+6wEotlPHVZTg
 I1cjzvxWr5Y2Co8ZZygeEfSHXvn5PxmBvwZxCJO3hmc3pksduuzoSXto9DLfn1JLb5Ex8Q0BB
 f8Jf7Q66yFsnREfh8tpHQV7OYVOuRTaICWj8O57GuG3fqfPEtnuMzZBaGmhWWyQakN48S8zqv
 FYfVNkEj5knalnKKuK0vjRYsC90=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 12.09.23 um 09:23 schrieb Stefan Wahren:
> Hi Umang,
>
> Am 12.09.23 um 07:50 schrieb Umang Jain:
>> Hi Stephan
>>
>> On 9/12/23 1:52 AM, Stefan Wahren wrote:
>>> Hi Umang,
>>>
>>> Am 11.09.23 um 16:07 schrieb Umang Jain:
>>>> ...
>>>
>>> Unfortunately the call of of_dma_configure() generates warnings likes
>>> this (Raspberry Pi 3A+ with multi_v7_defconfig + VCHIQ):
>>>
>>> [=C2=A0=C2=A0=C2=A0 9.206802] vchiq-bus bcm2835-audio: DMA mask not se=
t
>>> [=C2=A0=C2=A0=C2=A0 9.206892] vchiq-bus bcm2835-camera: DMA mask not s=
et
>>
>> huh, really weird, as on my RPi-3-b I get these set correctly and I
>> don't any such warning.
> This warning comes from this line [1]. Did you test with the mainline
> devicetree from [2] which must be specified in the config.txt? Be
> aware the arm dts files has moved into a sub directory just like
> arm64. I don't use U-Boot, just the vendor bootloader from Raspberry
> Pi OS. Please look at [3] for the details.
please look at [4], which is possible a solution. AFAIK the dwc2 also
had the same problem.

[4] -
https://elixir.bootlin.com/linux/latest/source/drivers/usb/dwc2/platform.c=
#L448
