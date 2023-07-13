Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3747517FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjGMFVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjGMFVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCA92114;
        Wed, 12 Jul 2023 22:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4EA61A17;
        Thu, 13 Jul 2023 05:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D6FC433C8;
        Thu, 13 Jul 2023 05:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689225696;
        bh=wQyN/phaMAVOufua/AruswFV26dN3USZ1Q3/Ucif1mA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hwpk+OKSW6E3452BnVFbO2AWkzxQJJLV+ONr+xTPIjLIzuKalVaFMxWF/CKKfpjKU
         bk1+eQpIS139fe2KkkwWXtqct7iu30cY2yj775yhuQY/CRyY0NC3BplUUiKZdX29Wn
         5ECNjy78cmEVX8vTFRq3Ff8kzdamfdkJV8oHSe61T5B1EPLZ+EMuFEgk/VXYqM0Szg
         BABdEpyK9CatPJMdo7X1m5Qk5qO8AXokY3ayWZjpUqgR3pnx9mAVKaXMn5goHGk7yt
         iy4qR+JDPx7L9rnYm+kCulQwSC2nOXGDbtds2LNbCXLcflYkywa1/qcnlqb1x8Mxxh
         6C+ma5mH7MEZw==
Date:   Thu, 13 Jul 2023 07:21:28 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Enrico Mioso <mrkiko.rs@gmail.com>,
        Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?B?xYF1a2Fzeg==?= Stelmach <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Joseph Tartaro <joseph.tartaro@ioactive.com>
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
Message-ID: <20230713072128.4f4bd9cd@coco.lan>
In-Reply-To: <2023070430-fragment-remember-2fdd@gregkh>
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
        <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr>
        <ZKM5nbDnKnFZLOlY@rivendell>
        <2023070430-fragment-remember-2fdd@gregkh>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 4 Jul 2023 07:47:31 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Mon, Jul 03, 2023 at 11:11:57PM +0200, Enrico Mioso wrote:
> > Hi all!!
> > 
> > I think the rndis_host USB driver might emit a warning in the dmesg, but disabling the driver wouldn't be a good idea.
> > The TP-Link MR6400 V1 LTE modem and also some ZTE modems integrated in routers do use this protocol.
> > 
> > We may also distinguish between these cases and devices you might plug in - as they pose different risk levels.  
> 
> Again, you have to fully trust the other side of an RNDIS connection,
> any hints on how to have the kernel determine that?

Kernel may not know but the user does.

See, when doing a security risk assessment, one needs to evaluate the
risks, the costs to implement mitigation issues, and the measures that
will be taken. Sometimes, the measure is to just accept the risk, as
either the chances to actually happen on a particular scenario is 
very unlikely, and/or the costs to mitigate are too high.

In any case, it should not be up to Kernel developers to do risk
assessment, as this has to be checked case by case.

For instance I usually disable several the security options on my
slow test devices, as the risk to run untrusted code on them
while I'm testing a new Kernel I just built is close to zero
and doesn't pay off the the extra hours I'll be wasting otherwise.

In the specific case of untrusted USB devices, the risk of having 
USB untrusted sticks connected to my desktop machine is very low, 
and if a criminal breaks into my house to be close enough to plug an
USB device, I would have a lot more to be concerned than just my PC.

Granted, the risk is higher on laptops and mobile devices, but
still it might be acceptable on some use cases.

Maybe a compromise would be to add a modprobe parameter and/or
a Kconfig option to allow enabling RDNIS host and RDNIS gadget
support at the security options to let the user select what 
kind of risks he's willing to take.

Thanks,
Mauro
