Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1635975FBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjGXQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGXQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:16:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D0410C8;
        Mon, 24 Jul 2023 09:16:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 51478359;
        Mon, 24 Jul 2023 16:16:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 51478359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690215400; bh=scfRRVcgHg3+xFerWctqO866z/nYyLkDjxVImmUT9+E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dGVm8AzNNAXDX9gt7Owxg2uCLTdDjfEknoSzLkarJsP4rdpulGMG/o07hGhxMzhfT
         iOXsti8Ct+oVfqpYckMBmZFVgTfDRHnn8nkCTr69q2jcBdUH4/uMyeQmY1cgL6QUaN
         RBA3XtUkKqOdGJk5mzMG1GpCy7UNcFWPFvRX+js16iB14HeJLdgUdxeKs0uXHeTtbz
         TsQDgW2+P2PQpJo4SDkorcOYGM878feWhafVD+uNeuAZU0eJcT1vHnMQmAX0mGiVjj
         d7FmK0jdshJu+0rxhoYNsWGshlFuZtXoLvIAyEfpCsRi5dCn5LVruwunrGwltH6szy
         xvn+nEnJ+oFEg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: Re: [PATCH v2 2/3] docs: consolidate peripheral interfaces
In-Reply-To: <20230722113253.1545231-1-costa.shul@redhat.com>
References: <874jlxc78i.fsf@meer.lwn.net>
 <20230722113253.1545231-1-costa.shul@redhat.com>
Date:   Mon, 24 Jul 2023 10:16:38 -0600
Message-ID: <87r0oxb7yx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> to make page Subsystems APIs more organized as requested
>
> Changes:
> v2: added pcmcia and subtitle
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>
> ---
>
> Alternative consolidation of buses look more challenging.
> Here are too many buses, so them should be split again.
> Many of buses are specific for only x86 or only embedded computers.
> Is SCSI generic bus or storage bus?
> ---
>  Documentation/subsystem-apis.rst | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
> index 90a0535a932a..5ace1c434977 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -48,6 +48,20 @@ Networking interfaces
>     isdn/index
>     mhi/index
>  
> +Peripheral interfaces
> +----------------------
> +
> +except specific networking and storage interfaces
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   usb/index
> +   PCI/index
> +   hwmon/index
> +   leds/index
> +   pcmcia/index
> +
>  Storage interfaces
>  ------------------
>  
> @@ -70,19 +84,14 @@ Storage interfaces
>     fpga/index
>     i2c/index
>     iio/index
> -   leds/index
> -   pcmcia/index
>     spi/index
>     w1/index
>     watchdog/index
>     virt/index
> -   hwmon/index
>     accel/index
>     security/index
>     crypto/index
>     bpf/index
> -   usb/index
> -   PCI/index
>     misc-devices/index
>     peci/index
>     wmi/index

I'm sorry, but I feel like you've missed the point here - adding PCMCIA
doesn't really address my concern at all.  What is a "peripheral
interface", and how does USB qualify but, say, SPI does not?  I feel
like we have stopped adding clarity at this point.

A lot of this documentation needs a closer look to think about how it
fits into our model.  As a quick example (and an example only), the LED
documentation would appear to be properly placed in the userspace-api
guide, not in this grab-bag section.  Just shuffling it around in the
file doesn't help address problems like that, unfortunately.

Thanks,

jon
