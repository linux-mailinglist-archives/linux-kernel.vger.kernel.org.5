Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5931A7B1FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjI1OqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1OqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:46:19 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B9E180;
        Thu, 28 Sep 2023 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
        In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=mRqhWMIMcGuvyFgNpvTVrYcSiIxSRbOQ0ouvdqRZILs=; b=XiqIRxPYnpAo2sfITfIEUqafxd
        cjdvaUDYFEbJUZriPNSmHqwWzxKACw8HZBiZeT2uusVp30pN6f8AMuDarmvegbrPaB4AejY6aHV2P
        B7ZS03wjXKqeqMr1JDhYaNihI+GdNLNWCNfYpRtu5H/MnWr1i/i7LLJd+HzgggD8+mdgqvG7HD5J9
        3aUzpecuqYRaeF2h0WyJa/I9bSjoxHAfE+zZ+6I+x/x40RNIsZpV1Qjwk6um9VGm6kATE2gekVBOi
        YbUbG9uQuWHFHtEmBPmr4oa1x3kOBnvjUV50gvd+yI+/lW38YFzLljKzFHKoDm24kWqD9Foso497B
        0jK3PSEg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <esben@geanix.com>)
        id 1qlsHN-000BGU-Fc; Thu, 28 Sep 2023 16:46:13 +0200
Received: from [185.17.218.86] (helo=localhost)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <esben@geanix.com>)
        id 1qlsHM-0002Zw-PQ; Thu, 28 Sep 2023 16:46:12 +0200
From:   esben@geanix.com
To:     Harini Katakam <harini.katakam@amd.com>
Cc:     <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jsc@umbraculum.org>,
        <christophe.jaillet@wanadoo.fr>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH net-next] MAINTAINERS: Add an obsolete entry for LL
 TEMAC driver
In-Reply-To: <20230920115047.31345-1-harini.katakam@amd.com> (Harini Katakam's
        message of "Wed, 20 Sep 2023 17:20:47 +0530")
References: <20230920115047.31345-1-harini.katakam@amd.com>
Date:   Thu, 28 Sep 2023 16:46:12 +0200
Message-ID: <878r8qxsnf.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27045/Thu Sep 28 09:39:25 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Harini Katakam <harini.katakam@amd.com> writes:

> LL TEMAC IP is no longer supported. Hence add an entry marking the
> driver as obsolete.

Ok. But while that might mean that no new designs should use LL TEMAC
IP, why do we need to declare the driver for it obsolete?

Existing designs using LL TEMAC IP might need to upgrade Linux kernel
also.

/Esben

>
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> ---
> This is an old driver with no bindings doc and hence the maintainers
> entry does not contain a link to documentation.
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3dde038545d8..820a7817f02f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23696,6 +23696,11 @@ F:	Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
>  F:	drivers/gpio/gpio-xilinx.c
>  F:	drivers/gpio/gpio-zynq.c
>  
> +XILINX LL TEMAC ETHERNET DRIVER
> +L:	netdev@vger.kernel.org
> +S:	Obsolete
> +F:	drivers/net/ethernet/xilinx/ll_temac*
> +
>  XILINX PWM DRIVER
>  M:	Sean Anderson <sean.anderson@seco.com>
>  S:	Maintained
