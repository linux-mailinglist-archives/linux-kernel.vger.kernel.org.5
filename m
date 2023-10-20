Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5447D0ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376493AbjJTIqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376472AbjJTIqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:46:37 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12D6D45
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XRg9DsEl/nt3hnyWShdIe+EcbDJwslBOsvtJkyHufJc=; b=qAOpso6duiZS4eu3AJOQdn0bvQ
        eR7ySX2GH559HKGh/wqcf0D09sr5Cvj6GwxiwVEMic9bsfPR+p4ALp5326ZDAgoe18M3SRrxGQXiI
        lt/N7SxguJyflcefIeWLzmII2185n4EA+qQkrR9n7RgcQq+ojGK9O39o5fnKndGBlYEnWFvNPlyqO
        Squ5Qhb+Dp4EZBWPTRV3ye2tST0cX6lWYnrjL2wNZftR91sqzHY3uK2pTGFrcITkZ6AWNTGzqfTpt
        Yg1OHFLdcFZXpwP9bcSx7Y2nzledvgVBnZv/dXLMlfyA20kTGVkS7TI6qA9iBObjm8xHeV4fYGitr
        sHCF6p6A==;
Received: from [192.168.1.4] (port=21399 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qtl9F-0000z6-2F;
        Fri, 20 Oct 2023 10:46:25 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 20 Oct 2023 10:46:25 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <olteanv@gmail.com>
CC:     <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>,
        <ante.knezic@helmholz.de>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <edumazet@google.com>, <f.fainelli@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <marex@denx.de>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next v3 2/2] net:dsa:microchip: add property to select
Date:   Fri, 20 Oct 2023 10:46:20 +0200
Message-ID: <20231020084620.4603-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231019165409.5sgkyvxsidrrptgh@skbuf>
References: <20231019165409.5sgkyvxsidrrptgh@skbuf>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 19:54:09 +0300, Vladimir Oltean wrote:

> So user ports and CPU ports meet at ksz8_port_setup() from different
> call paths, but I think it's strange to continue this coding pattern for
> port stuff that's not common between user ports and CPU ports. For that
> reason, the placement of the existing ksz8795_cpu_interface_select() is
> also weird, when it could have been directly placed under
> ksz8_config_cpu_port(), and it would have not confusingly shared a code
> path with user ports.
> 
> Could you please add a dedicated ksz88x3_config_rmii_clk(), called
> directly from ksz8_config_cpu_port()? It can have this as first step:
> 
> 	if (!ksz_is_ksz88x3(dev))
> 		return 0;
> 
> and then the rest of the code can have a single level of indentation,
> which would look much more natural.

Ok, will do. I am guessing I should leave the existing 
ksz8795_cpu_interface_select() as it is?
