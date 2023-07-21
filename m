Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F61475D60B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjGUU6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGUU6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:58:06 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7251FD2;
        Fri, 21 Jul 2023 13:58:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E47C3733;
        Fri, 21 Jul 2023 20:58:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E47C3733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689973086; bh=0S0lXqmQ10UyA193KMaPIpP1eAySzNFpPG8iYMqQCSI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=tPC2ADnCieaEyaT11qFoKkac2of2YpKO4FSePRzj0CchxroTzXONm/lZJrpkxlYLu
         3r9//cN/l2u2YWDH1HcCOGsGElGilKcpQRMLXyDHjMj53xfqct1Ug2GAiIjdVCebjy
         /vvs1laQ7CMCaL7flspY2EBE0wH/J4r7otr6ydb7ToMoTvvqJT+DKIUgpcOOd7SxzO
         DyUyjDPVBMS0qY2lwefHrzXyiVutexXVp8Ph2y70dTEAV7v4M6+XkHl1buOhp7CbO6
         5p5TiODc2pJY0HSwZQuWSVj8DlzUTW+gYVdvbh18qGImcYcfozQ9TtchDviHrFb6PH
         tYWbxxV5xzK+Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] docs: consolidate peripheral interfaces
In-Reply-To: <20230715165759.74901-1-costa.shul@redhat.com>
References: <20230715165759.74901-1-costa.shul@redhat.com>
Date:   Fri, 21 Jul 2023 14:58:05 -0600
Message-ID: <874jlxc78i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> to make the page more organized as requested
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  Documentation/subsystem-apis.rst | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
> index 90a0535a932a..7b086c89e2be 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -48,6 +48,17 @@ Networking interfaces
>     isdn/index
>     mhi/index
>  
> +Peripheral interfaces
> +----------------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   usb/index
> +   PCI/index
> +   hwmon/index
> +   leds/index
> +
>  Storage interfaces
>  ------------------
>  
> @@ -70,19 +81,15 @@ Storage interfaces
>     fpga/index
>     i2c/index
>     iio/index
> -   leds/index
>     pcmcia/index
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

So this one seems a bit less well thought out.  How are you defining
"peripheral interface"?  How is it that PCI qualifies but, say, PCMCIA
does not?  In a real sense, most of our interfaces deal with peripherals
in one way or another.

Were you thinking maybe of "bus interfaces"?  If so, a somewhat
different selection would be indicated.

Thanks,

jon
