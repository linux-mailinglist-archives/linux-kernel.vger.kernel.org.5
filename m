Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEA97ECAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjKOTEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKOTEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:04:22 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3B1DC;
        Wed, 15 Nov 2023 11:04:17 -0800 (PST)
Received: from [192.168.1.129] ([37.4.248.43]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMWcT-1qkyqR1Jzz-00JbZM; Wed, 15 Nov 2023 20:03:48 +0100
Message-ID: <3b9ec650-8a99-4bac-9ac9-d2cd87efced5@i2se.com>
Date:   Wed, 15 Nov 2023 20:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] staging: mmal-vchiq: Use vc-sm-cma to support
 zero copy
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-6-umang.jain@ideasonboard.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20231109210309.638594-6-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hRUgUPLJ7rFTcdE7NnVcI/4HzsqA4QYhQf3aFo9afPhySVvhACg
 ///NpGH8Kc41l0Xucn7dDL/L68PirBZ42PrNbUYgYG7D3G2W3tYshi8mtRw3lfS+XnAmCM0
 rQo082W3D2O9M9Nl8qzao9eoEA9zyeQKotc0xhQmXhA4zIyxpFBCw0WAreIMUPosdf23Y9l
 9ZXAY34760qzi05XY8MZQ==
UI-OutboundReport: notjunk:1;M01:P0:xlxB7dXYVbM=;ZzonCn7mXukF7za8R8WhfIBem8b
 7Y+9VSl8Tcrq8BKgZ/qdjJa092opnS/WGchGNB4vD6z/z0co4MooUwc6hKWDTSOFqmKyF6RmH
 tHMDIcfftwNr7OGnPsGp9dF/m7GK2N1xoZHjbyJOMcIqHSFuBScs5lW7YkzhX7HqSj11teeJD
 madIE93cDzmtvv8NW/eQqmkUfvWgIe5D+wRsXSMqSpQsdAzCvMea1B1i3gtYFsbC9YTYXKGYR
 LcW2sue9WGkd9aUG5GtuDsqZP+LQYf0D7uAMYD5TOHnAmvj4ALnQPdBAGcJcj+0P4II4Tlgt9
 Z7cAh2JSGQNIJ4LaiYh9nZ2MjCv5NoN0a1Y1/5ZYlT9e1BvTEnh7iGFWrOGOMD23P5GbNvaSP
 F4K1wxOB+S8cjrPXJZfsORyCzBeg8Ct+yfUUKBS7LKfkM2cTJao6bU+htyqSeBpbkTrcPHPqi
 G/BwZTn2UR1CIWitUnIXf4yBDsKDcM98tl8BC/NXTlLxESoxPzhMhwZRpOcvKSkqmCmefxLhK
 6+lFEmy+r1TpBcOhmz+QgZ5oxxZTIdHLX3zTU5rEo4PrDc5tOIdER3ays+WMPTFPDti1XHN69
 zv2C0GFnpjuMmN0w7Goi31uUPkY/WkOYiunN1SVGOPhf7PebD24l/7RRzw6eQklTWliwzODF8
 QcMgFKp+r9NMw7Ooti/bzBDg7o835td7ZpadUSkka0A8eJfkm+ulZjsR6L982lccHvqy0YpOp
 9vFguXT7+uTdMVllqp8sJdXvkl0i2duPtjG2EUjn7TgW+AR0tuxiJTMwh3X7Y/I5PALa2JO1x
 3boMM0fPaeZvXhWGFLHGkvGZPUkodRg0Yn5SgGvVNb28EE+G4VMgqceHUb5iq71/72EMIz7dG
 JMx4H6eWoWYghCg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 09.11.23 um 22:02 schrieb Umang Jain:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> With the vc-sm-cma driver we can support zero copy of buffers between
> the kernel and VPU. Add this support to mmal-vchiq.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../staging/vc04_services/vchiq-mmal/Kconfig  |  1 +
>   .../vc04_services/vchiq-mmal/mmal-common.h    |  4 +
>   .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 84 +++++++++++++++++--
>   .../vc04_services/vchiq-mmal/mmal-vchiq.h     |  1 +
>   4 files changed, 83 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/Kconfig b/drivers/staging/vc04_services/vchiq-mmal/Kconfig
> index c99525a0bb45..a7c1a7bf516e 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/Kconfig
> +++ b/drivers/staging/vc04_services/vchiq-mmal/Kconfig
> @@ -1,6 +1,7 @@
>   config BCM2835_VCHIQ_MMAL
>   	tristate "BCM2835 MMAL VCHIQ service"
>   	depends on BCM2835_VCHIQ
> +	select BCM_VC_SM_CMA

i think we need more explanation in the commit message of the relation 
between these both modules.

On the one side BCM_VC_SM_CMA should be a driver, but it's not a driver 
for a specific hardware. It looks like more an extension of VCHIQ MMAL 
or does other (maybe not yet imported) vc04 driver make also use of this.

My question is: is BCM_VC_SM_CMA a real member on the VCHIQ bus and why?

Best regards
