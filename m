Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4D7DC9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJaJrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:47:01 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7A4DA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:46:57 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xlKmq2Nre68frxlKnqKvCp; Tue, 31 Oct 2023 10:46:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698745614;
        bh=zSJ2fHyj4ub3HQ+xTvg2C+89BzyjfVFV9HNzabEf0Ow=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=pItzdUQ1tmeLPjEvh9MNVJD8b0CkSTjpqFevmmeUzr30hh8dnRYaJY4mjDCPLYLG0
         wB2Hj8zoRvx96zrr5HdERAcjlChmfOSDKzYnofh3BIls0h8ocW/EYgqHMWyS/+v3Iu
         vunddG/NBhfTpkB64eWkI2rK6HNnPaQboOhJ5/gvoO82lJZ6FWwZ9EyzT3IkFml/JW
         riuMjV0hukAld3YpQAuCvmMKKWTen3KQQQHJ3gWeE8LwbvzKrbn9fn6T/yIcJM955/
         eMXN14wiaAZZ2Xr08ZTqXuT09NbrcdS3TadbLHctg82XTRV+lX8Go1DKh+pUxE3uwP
         /33clZvCJMJfw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 31 Oct 2023 10:46:54 +0100
X-ME-IP: 86.243.2.178
Message-ID: <79231ec3-8da1-4c73-8f5b-efa445e6c35d@wanadoo.fr>
Date:   Tue, 31 Oct 2023 10:46:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] media: rockchip: Add a driver for Rockchip's
 camera interface
Content-Language: fr, en-GB
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com,
        michael.riesch@wolfvision.net
References: <cover.1698666612.git.mehdi.djait@bootlin.com>
 <f7367726eb077d43446c83591ecbf9acbc77ef5f.1698666612.git.mehdi.djait@bootlin.com>
 <ad346052-ec62-4d68-903e-fccd7ad989bd@wanadoo.fr>
 <ZUDKAB+zQYS9aLpB@pc-70.home>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZUDKAB+zQYS9aLpB@pc-70.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 31/10/2023 à 10:33, Mehdi Djait a écrit :
> Hello Christophe,
> 
> On Mon, Oct 30, 2023 at 01:47:17PM +0100, Christophe JAILLET wrote:
>>> +	/* Create & register platform subdev. */
>>> +	ret = cif_register_stream_vdev(cif_dev);
>>> +	if (ret < 0)
>>> +		goto err_unreg_media_dev;
>>> +
>>> +	ret = cif_subdev_notifier(cif_dev);
>>> +	if (ret < 0) {
>>> +		v4l2_err(&cif_dev->v4l2_dev,
>>> +			 "Failed to register subdev notifier(%d)\n", ret);
>>> +		cif_unregister_stream_vdev(cif_dev);
>>> +		goto err_unreg_media_dev;
>>
>> Should there be another label with cif_unregister_stream_vdev(cif_dev); if
>> an error occurs here?
>>
>> CJ
> 
> cif_subdev_notifier() is the last function call in the probe with error
> handling. So it will undo the last successful register:
> cif_register_stream_vdev and use the goto to unregister the rest.

Ah, I didn't see the cif_unregister_stream_vdev() call here.
Sorry for the noise.

> 
> I can add a label err_unreg_stream_vdev but it will be only used in the
> error handling of cif_subdev_notifier() and I don't see the benefit.

The main benefit is to be more consistent in the way the error path is 
written, and to be more future proof.

CJ
> 
> --
> Kind Regards
> Mehdi Djait
> 
>>> +	}
>>> +
>>> +	cif_set_default_format(cif_dev);
>>> +	pm_runtime_enable(&pdev->dev);
>>> +
>>> +	return 0;
>>> +
>>> +err_unreg_media_dev:
>>> +	media_device_unregister(&cif_dev->media_dev);
>>> +err_unreg_v4l2_dev:
>>> +	v4l2_device_unregister(&cif_dev->v4l2_dev);
>>> +	return ret;
>>> +}
> 

