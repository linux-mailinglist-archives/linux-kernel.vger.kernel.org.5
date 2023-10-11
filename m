Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58C7C5580
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346913AbjJKNcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjJKNcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:32:50 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5862E92
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=K8IhnPI5raIUV9hC/d6lDvsl5QLHRFjU6dDeluRm1ZA=; b=jaL57E9Pn8vK3lef7INuctcakJ
        2lIoiBK0tJujXp/3pbrmqMAfA3sh7O3vCmME2Y+tCbAstx6R98o3sEWAveXqpmCAC01yh03OtOja5
        keoH/NBwzvntOCAJ+06GQnA36CRec44orjkRtxL93I/bWvkmjG766FH61HWDXOkxFDI9Tl6DWasWf
        NEspwUGVzbhUS0cMyU4WhQW9LVFx5AfBnnVcxsjzF9c+qBQpw+v322GtstJ4gAtJAnpD9lUzHA7Im
        cD+tptvWnk1zxfLPmCr1Rax/tdbxcKJGW8yQBdUg8nE9YviqLXQhAadKPrDsg8K1y1XEcAPtSODOi
        G/xFW8ug==;
Received: from [192.168.1.4] (port=11583 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qqZK3-0004Rn-2n;
        Wed, 11 Oct 2023 15:32:23 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 11 Oct 2023 15:32:23 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <andrew@lunn.ch>
CC:     <UNGLinuxDriver@microchip.com>, <ante.knezic@helmholz.de>,
        <conor+dt@kernel.org>, <davem@davemloft.net>,
        <devicetree@vger.kernel.org>, <edumazet@google.com>,
        <f.fainelli@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <marex@denx.de>,
        <netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <woojung.huh@microchip.com>
Subject: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
Date:   Wed, 11 Oct 2023 15:32:23 +0200
Message-ID: <20231011133223.29174-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <5348ffc3-a514-4d61-85f9-56910aa94d44@lunn.ch>
References: <5348ffc3-a514-4d61-85f9-56910aa94d44@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 15:57:34 +0200 Anrew Lunn wrote:
>On Tue, Oct 10, 2023 at 03:41:39PM +0200, Ante Knezic wrote:
>> On Tue, 10 Oct 2023 15:25:44 +0200, Andrew Lunn wrote:
>> >> +  microchip,rmii-clk-internal:
>> >> +    $ref: /schemas/types.yaml#/definitions/flag
>> >> +    description:
>> >> +      Set if the RMII reference clock should be provided internally. Applies only
>> >> +      to KSZ88X3 devices.
>> >
>> >It would be good to define what happens when
>> >microchip,rmii-clk-internal is not present. Looking at the code, you
>> >leave it unchanged. Is that what we want, or do we want to force it to
>> >external?
>> >
>> >	Andrew
>> 
>> Default register setting is to use external RMII clock (which is btw only 
>> available option for other KSZ devices - as far as I am aware) so I guess 
>> theres no need to force it to external clock?
>
>We just need to watch out for a bootloader setting it. Or is it really
>guaranteed to be false, because the DSA driver always does a device reset,
>removing all existing configuration?
>
>I prefer it is unambiguously documented what not having the property
>means.
>
>	Andrew

The bootloader case might be a issue if the reset-gpio property is not defined
for the switch. In this case we should probably enforce the value either way.
I will do the changes and repost.

Thanks for feedback,
Ante
