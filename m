Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DEF7D370A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjJWMmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjJWMmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:42:00 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEC4E6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=19oFcHzo1e5daXEGUEKghD5VwAYxzu7JVMuNLspUkBw=; b=Cddk9alK8HHAdFhm8z1E6Sa+MP
        I6chVeR1x3xklZggtvYorkFOhy2rxfvTfjsPvWl0SAUtGOjaU/wYvM1rOR/CSp3JpmdpuM6H+4wpJ
        9bdWnJJNGJL3oBoz/8HOOhtHqdkaES3RgqnOHIMHcZjwwgE13qKGcgM3A9pJg3JlVZ9hnYdnvNzXE
        lFumpaZEZXlDtwvzyzG2Ql+jxhx0i7AHSMy50xv1VRsKTj1RFSs8uUatkgR5VZzcj4xHAbbbXMbyl
        hXCoVVq55OqDILuYt+wKu+7+U26u+++K6TOJoymL2Oy8CJMGNfiH+9vS2uU8SqbPLwBPkw3zVIjD4
        O5sBdIig==;
Received: from [192.168.1.4] (port=23007 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1quuFR-0000wl-0e;
        Mon, 23 Oct 2023 14:41:33 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 23 Oct 2023 14:41:32 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <o.rempel@pengutronix.de>
CC:     <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
        <ante.knezic@helmholz.de>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <edumazet@google.com>, <f.fainelli@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <marex@denx.de>,
        <netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Date:   Mon, 23 Oct 2023 14:41:30 +0200
Message-ID: <20231023124130.3158-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231023114916.GC3787187@pengutronix.de>
References: <20231023114916.GC3787187@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 13:49:16 +0200, Oleksij Rempel wrote:

> In case of KSZ8873 we seems to have something like:
> 
> Switch MAC<-.
>             |
>   PLL -> clk sel -> REFCLKO
>             \-----< REFCLKI
> 
> Clock select in this case is controlled by Register 198 (0xC6).
> 
> In case of KSZ9897 we probably have something like:
> 
> Switch MAC<-.
>             |
>   PLL -> clk sel -> REFCLKO
>             \--x--< REFCLKI
>                |
>             Gate REFCLKI if REFCLKO is used.
> 
> In both cases:
> - KSZ8873, Setting bit3 in Register 198 (0xC6) will control use of clk
>   select
> - KSZ9897, setting bit2 in Register 0xN301, will controll use of clk
>   select and probably gate REFCLKI.
> 
> So far, it looks very similar to me and it is usually handled by
> phy-mode rmii vs revrmii. Correct?

Thats correct I guess with one important point: default setting for KSZ88X3 is
not to gate back to REFCLKI, while KSZ9897 will (correct me if I am wrong) 
automatically gate to REFCLKI and does not have the ability to gate/not-to-gate
REFCLKO to REFCLKI with any register setting. Thats more-less what this patch
is all about. Something that is automatically active (and can not be changed
during run-time?) on KSZ9897 needs to be manually configured on KSZ88X3.

> So, the main question is still, do we need this kind of configuration
> per port or it is enough to have it per switch?

Thats something on which more experienced developers/maintainers may have more
to say, my impression is that its somewhat specific to KSZ88X3 to have this
option available and the location of the register itself also makes a point on
its own. I may be wrong about this of course.

> For some reasons KSZ8863MLL datasheet provides RMII clock select
> configuration for two ports (port 1 and 3)
> https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ8863MLL-FLL-RLL-Data-Sheet-00002335C.pdf
> May be there are variants with two RMIIs?

As you noticed KSZ8863 provides configuration for port1 as well, but I was not
able to find any reference to what it may actually select. The product
identification system for ksz8863 does not mention devices with 2 RMII
interfaces. The KSZ8873 has this bit set to "Reserved" so I can't really
tell whats going on there...

> Something similar but with multiple RMII interfaces seems to be
> supported by KSZ8864CNX:
> https://eu.mouser.com/datasheet/2/268/00002229A-1082534.pdf
> 

As well as these datasheets are sometimes muddled and difficult to get a grasp of
by looking at the KSZ8873 datasheet it seems to me that it can select between
"clock" (default) and "normal" mode, which is something similar to the 
rmii-clk-internal property of KSZ88X3 devices, however this mode of operation 
seems to be selectable only at boot time by strap pins (see description of 
Register 12 (Global Control 10).

> And all KSZ9xxx series seems to handle it per port as well.

I guess you are refering to register 87 (RMII Management Control Register)?
But this only selects whether to enable clock output on RXC pin?


