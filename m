Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18737D2B46
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjJWH1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjJWH1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:27:35 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A633E6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DRz54Zp5sd6COe1CQZ2vLOKmpOEpvMJkuysqr9IECXg=; b=TtwU/HLFuJuTb5U6KzlUE1rTTv
        mIA/F0hyliKQ8qMk+pmJPo0a0d4MzDyDsCyTWWCduboAKs/wdHWD7hrlJDmo03ZzZnV8KS1cKQFiS
        98C8KzT3BPskecl0hBblVAlGqWU7xYCQBC9NLJVIoLGgvriwZSl2Bg1AppYIMu6eVs1Ya/ixk0joz
        Ei8D5BBrrNB3kFgr67qzXZO6cQidt2FybSA7q8qFAoOUK/Iw3CHT4J5uxeoAxL4MrWDC+aZUfpCHf
        l6FpMGveniJGoSqBTwGoJxMDtdk0i976zWU9B7+a6bp/l61Qjmh+OlMWPsz4Vm553e/try+m7hhs8
        WkJg8yOg==;
Received: from [192.168.1.4] (port=47838 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qupL7-0002sJ-21;
        Mon, 23 Oct 2023 09:27:05 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 23 Oct 2023 09:27:05 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <olteanv@gmail.com>
CC:     <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
        <ante.knezic@helmholz.de>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <edumazet@google.com>, <f.fainelli@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <marex@denx.de>,
        <netdev@vger.kernel.org>, <o.rempel@pengutronix.de>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Date:   Mon, 23 Oct 2023 09:27:00 +0200
Message-ID: <20231023072700.17060-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231020143759.eknrcfbztrc543mm@skbuf>
References: <20231020143759.eknrcfbztrc543mm@skbuf>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 17:37:59 +0300, Vladimir Oltean wrote:

> Sorry, I didn't realize on v3 that you didn't completely apply my
> feedback on v2. Can "microchip,rmii-clk-internal" be a port device tree
> property? You have indeed moved its parsing to port code, but it is
> still located directly under the switch node in the device tree.
> 
> I'm thinking that if this property was also applicable to other switches
> with multiple RMII ports, the setting would be per port rather than global.

As far as I am aware only the KSZ8863 and KSZ8873 have this property available,
but the biggger issue might be in scaling this to port property as the register
"Forward Invalid VID Frame and Host Mode" where the setting is applied is
located under "Advanced Control Registers" section which is actually global at
least looking from the switch point of view. Usually port properties are more
applicable when registers in question are located under "Port Registers" section.
This is somewhat similar to for example enabling the tail tag mode which is 
again used only by the port 3 interface and is control from "Global Control 1"
register.
With this in mind - if you still believe we should move this to port dt 
property, then should we forbid setting the property for any other port other 
than port 3, and can/should this be enforced by the dt schema?



