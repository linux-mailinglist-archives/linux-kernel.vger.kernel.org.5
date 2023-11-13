Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBAC7E9FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjKMP0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjKMP0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:26:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E5D67;
        Mon, 13 Nov 2023 07:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1699889146; x=1700493946; i=wahrenst@gmx.net;
        bh=UaTkE+gIGf0+LiU/avljmlD97MWAncuv8YHPsJJltSA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=FJmhXb4KL0grVyoqcJxUmmaILmtJXCc57uKJLopXCoKc/W6aOtjt9pGuoj99+P4H
         EAMOVDf2b6fAUA5UXipg5aGP8f+uMGbNdnBoTdeEjXpVm+ouX4NVJ/akGvKWbpDEF
         1hWNoIMuL5y/Eq0jUGUFlnew/WCJ8AB4mz4CJKSDpol4nzuJzWAitRSRLscohZREK
         KWJynNedOg4Zblfti+/2z8FdpIIrpr9+rlJHlFHZIcPvHonemNxI25TDMO8WMqUDy
         y8YkYr/HKHzLNd1BWBS54efw+kbt+SggdP9b7bNFix3eiXetpYuRVejGVqDNcBBXN
         evhVmU1c8sWVeb5xIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1rdoB71RD1-00cNng; Mon, 13
 Nov 2023 16:25:46 +0100
Message-ID: <d4db520c-23fa-42df-8dba-d04ad672cc25@gmx.net>
Date:   Mon, 13 Nov 2023 16:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fixup! staging: vc04_services: bcm2835-isp: Add a more
 complex ISP processing component
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
References: <20231109210309.638594-11-umang.jain@ideasonboard.com>
 <20231113140755.425365-1-umang.jain@ideasonboard.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231113140755.425365-1-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vay9cggrkfXJzEFHAmUrI4SvirzpneVMdYN3zbwhioT+3u43hp4
 8wXn8H8oOqTWkms1MGsXoicsP1dKYHdu0LH3KaFNVWu9RyjhfPMrkYL2ss3at9/cOWkd5AC
 WWjkQbixRxxoNamh37MfCQfFNSEV8EMLU8Dcx6uov8H31ZAJP5zSqyq9pjKC/hzQUjl63NQ
 axPCcY5zOZYL0xNujvLXw==
UI-OutboundReport: notjunk:1;M01:P0:nDNYlxOwpfs=;jHHFSeh7yqVw7LQo7GSJX6yC2F6
 JZHM5oh1i0TLAydruRcgaIZta6Axz5z/sJuoYHqbNYO1cMJpOEdZTq4dojSPkPYpyoIbV34dq
 O68qfENsRZhZH2hKpsnpyzIhiHcSxhu7w+PsziUbs/Y+XZdaSxCov7NRjWJQaqvViBA/OEbR/
 94BXxjF2jac3GoyzwZRQLuEnQD6ZFjONzxZ7FUMyuRFKrC1F6v9e8SLFgIUBaHqSjFG4qbdZl
 kSamxSKWZmUFwCCp/f39H3axVu+W+Fg6hgVJlp68U3IfzMOSG3gRLfUDyHcBcbDK/6sXATv+a
 EteoyCCkZC9SzXEZmqpnC3UIPRBzANhDsSgDv6iQ+J21sKjWycJzj79k3O+qjQcmmY54WzZo0
 r01dWr1eAilGa71TzWYF2KfztBgOyh3B+JKI3FFZ6JWfGANglp5mqMsu08KjiJZZ9G6ZANmjA
 D16AxC52PirP8vtNOkFvnQF4jPV0lW4p36Q6sA5/E/iUJxlxA/ROw3A6E07JT4ZWl6cAK5gjr
 BuDKI04GnNrS2VAQ8CYSxH07wksMdBfrL1cKy9wXg3IpztBz36JcqP1h8Q/ZjNM4fS7qxJAzp
 lZsKJ5KvXvDq05v7zzMrHuKc3FLSVhEUuWjKPxndH/ZZqiw1BkI4ngJP12SMf5V9sxURNcqXM
 XRGxpNoRK9NKsXeWHAchN8qRffunUAc5YQO2Q1di6ISDY2FJkLuB5QB1zL2TD8AGFoUe9rrXh
 t+rW6dyM4+bfNnUkebyi2chwVPpchnUDABvJ8wsEKfvkdflz3PbebfyKpcjDwBlSImURWI0d/
 bSJMo6goSXcImKXw5yvIHzPbuvVJHx7GkfLyhejJFfQf8d1iizFEA9M7NlDEO5p/h0UekCeH8
 aIGNiMWL+kJcJO9KRcXTdmM67P8lCeDLVCeyX1Mj0nK2g6CGoddCQinzIzKDFTK/8fqbC0D++
 R5cJ/cG5XXukpXg9XbAJ4Uy8YIY=
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

Hi Umang,

Am 13.11.23 um 15:07 schrieb Umang Jain:
> Setup DMA Mask
> ---
> I realised while (re)creating the test branches (sent in reply to the co=
ver
> letter), I missed to squash this hunk in
> "staging: vc04_services: bcm2835-isp: Add a more complex ISP processing =
component"
> before sending out the series.
>
> Sending it as a fixup! for now.
sorry, but i lost track of all your vchiq patch series. Usually a
commiter shouldn't send multiple series to a list at the same time. This
is very hard to review / test.

An expected review time for a patch series should be 2 weeks, especially
such big series like bcm2835-isp.

For this specific case, it would be better to reply to your own patch
and mention this mistake and fix. It's clear that we need a V3 of the
bcm2835-isp, so in this series the fix should be finally included.

I didn't had the time for the big series, but sending more patches
doesn't make me faster ...

Regards
Stefan
> ---
>   .../staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c    | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.=
c b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
> index 316d35d5f19d..4a23f9feb6e4 100644
> --- a/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
> +++ b/drivers/staging/vc04_services/bcm2835-isp/bcm2835-v4l2-isp.c
> @@ -1774,6 +1774,12 @@ static int bcm2835_isp_probe(struct vchiq_device =
*device)
>   	unsigned int i;
>   	int ret;
>
> +	ret =3D dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(&device->dev, "dma_set_mask_and_coherent failed: %d\n", ret);
> +		return ret;
> +	}
> +
>   	bcm2835_isp_instances =3D devm_kzalloc(&device->dev,
>   					     sizeof(bcm2835_isp_instances) *
>   						      BCM2835_ISP_NUM_INSTANCES,

