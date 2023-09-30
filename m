Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACF67B3FD4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjI3KLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjI3KLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:11:06 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CEC193;
        Sat, 30 Sep 2023 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
 t=1696068640; x=1696673440; i=wahrenst@gmx.net;
 bh=KKRSMDrPIzVP/XxEyC7mrWL0yDhjIEq4gqbgYL6BXdI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Hg9Th1F7IfDY3TtbRmOMLiNY1Ms/tXqYshxpDGYauqlRfWpwNN4s1+K8ylcxSApOhHVhznpDEvG
 4UtRqddLt2pHzWWwlceLYeDJjOR3UrBkjBzVJ6uUEbL5oYlIyUdpWRTRCG/54FV0+tvGzh/GRX525
 SJJzc2PKfwrm3qstsFaUbbQQ0K0rcys9KdwyJMjiwsjQ7oHDCHxHww36sHc+5fxFOoJN6ayWBRWlG
 vYPnUw56z7NNgsQfWRF6H0tt6bGkxog3PQQMbQ2t0/aVJ8p2+naQPmTGW4zLQmA/C1AbP4J7mpCXa
 l6I22AJGEkgjICRSzMnehkF/5OLTDY4NPDUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V4J-1rmAWt32GV-013snH; Sat, 30
 Sep 2023 12:10:40 +0200
Message-ID: <3b99e6d9-2bc3-d0a4-fd2d-515f26bf39bd@gmx.net>
Date:   Sat, 30 Sep 2023 12:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v12 0/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20230923143200.268063-1-umang.jain@ideasonboard.com>
Content-Language: en-US
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20230923143200.268063-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3AixLoDKKjLyEq5DipKAWP0QejMaRwdTs4PVeBI5HQbr+ZnK2Az
 JPp9T5JkQss5VwZlgROnxcP2jwWMTOynvnBKMo6zyQBmtnpo+Vrk0l2NAa2gC22w+UoN3Oq
 c9mY00IGjJ7IvZwVjUawKRoghWJsKN29HzoIrzHjgq1HKgsSlwIEpW7m/OR5yPa3nNzENk8
 xH4fuejtWNalhWYRAr8qw==
UI-OutboundReport: notjunk:1;M01:P0:F9wAkd3r6Ec=;1M0aqMuBvuF99wv47dwfuLX7Qks
 LyCv72m6ulR09k3M3oAOs29TGKrlRmPXqq9WCSdYnU99AjAO0FRwdm/3hgwLSDG0gwtmNsNUa
 wL7u1iuqL6SnjueqdI/+fHvbngjJmnkMov6ly5KP7TTBKem+F3XgHGT3/U0AregUY3JKmqyUX
 DCTcbNeTkiDDK16j5V4DspptYD6C/ydIp5UrzEcSysoAp2+ujxnd7XH8VUVZXB/jBBYrwD066
 sG4PUW3zsoi4hc8NwHfsExTwOHb/S6S7BYcg6txrKFwfQ1SitofQtcfSwUADODEOlCaJ9W48Y
 0v96CvLPDcHpz7Aa0fuKlGFvWjyF9RQJmFc6Q51iFtnuuBH4dSNSYdx6MmPCtMK9KimWmjNl6
 a5ZGwTb7NxFs86WFdx1BN94uLaVvdxh67jQc3wTSdoZVH5JwVoGbEBueRLAAcb+vJmoYji7zW
 JiT/z04hMl8XnvDvdstsXsQDUP6OKVha0d/3bBS+U/nbFF2x6MFFuJmqIsjaWGKVS+zJ5QjFW
 AfsT8eefzdC996ICid832G+nl/x2j8q34+msyq/Z8tK6faKDrFwcgC8FMrUIpLls895ch9TC8
 ukjeXZ1Rf/hUnkl30a8chuTvKg3HuffOqbLmZEx4zT5f0Gn/tE7K7KuCK/0cSEXbs/QGReKBt
 /NSodhuOkPoyeatQclTklsp5HP1LKJ0QVRBkZjmuMLMyIEMuKney0+/PHpspKVfj3g3XVFx+r
 UOr2wAUVZBlGR+2I0JROEm+1pRiKnxV4Vl2qq0yI2YKi+7bIpocKho2zhIs2/FAa3dRNktaw3
 isUtJXRf0DC9QtMPRbwucannn63LIwb07pjo8rxKMPdskBIcDPGCFwmIUF8ktgvziQW5vPcdG
 0fr6ui4uE39KY9OEEK6tZ4M7z2QGkUZydwv4R615SYdMtaIalN8zHxKG2N+GX29uShhKdV3vA
 Y5V9Z/4gCCQbo720dOmF6lh845o=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 23.09.23 um 16:31 schrieb Umang Jain:
> The patch series added a new bus type vchiq_bus_type and registers
> child devices in order to move them away from using platform
> device/driver.
>
> Tested on RPi-3-b with media tree master branch.
>
> Patch 1/6 and 2/6 adds explicit DMA mask to bcm2835-camera
> and bcm2835-audio respectively to avoid regression when moving
> to away from platform device/driver model.
>
> Patch 3/6 and 4/6 adds a new bus_type and registers them to vchiq
> interface
>
> Patch 5/6 and 6/6 moves the bcm2835-camera and bcm2835-audio
> to the new bus respectively
>
> Patch 5/5 removes a platform registeration helper which is no
> longer required.
>
> Changes in v12:
> - Add initial two patches to set DMA Mask explicitly to avoid regression
> - fixup vchiq_device.c bad squash in v11
> - Rename vchiq_device.[ch] to vchiq_bus.[ch]
> - Fix memory leak if device cannot be registered
> - Make vchiq_bus_type_match() use bool values
> - vchiq_register_child() helper removal folded in 6/6
>    instead of creating extra patch.

The whole series is

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
