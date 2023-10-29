Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631947DAED6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjJ2Wld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJ2Wlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:41:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60DDC2;
        Sun, 29 Oct 2023 15:41:28 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.143.101])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E600166072BB;
        Sun, 29 Oct 2023 22:41:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698619287;
        bh=0moYwqGPpKpcCgWCZCbmjb3SQL9UUK8AXxSzTD9M6EM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GAp2S5LeolDNT0oMnIU1XOERBBbWg8wPe66a2v7uBCjT0XEL2uOR/xK2jM76GBNkZ
         g5e8MN3Pt/i8oENbgyJip/7sswIfxUCXn6Wf8pQPBuWG4ooO+Xwwg7SxnSXhjTR8Bj
         7Gehm8n2sgo2owH/pQiU4GNiOwJ0NV02FY6al52pwfxMy2bvUEJLGYgGmmyh6YsYmn
         6S7/LpukLMtkMX2I25Aq/nj4WJiDUYBxGEX9+rYfeu6ED1sW483Hfh/3UvoGp8rMu8
         UagKsbwJ2EUikHgocGXGOchFcKp/R5ps4nE8Lm2T+ymGrnlu0EH04pHnvNsCiq15Tz
         v/DIB0SxCyOKg==
Message-ID: <f05839c0-7a78-4616-bedc-6a876b7f4bb3@collabora.com>
Date:   Mon, 30 Oct 2023 00:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] riscv: dts: starfive: visionfive-v1: Enable gmac
 and setup phy
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-12-cristian.ciocaltea@collabora.com>
 <f379a507-c3c1-4872-9e4f-f521b86f44d4@lunn.ch>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <f379a507-c3c1-4872-9e4f-f521b86f44d4@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/23 20:45, Andrew Lunn wrote:
> On Sun, Oct 29, 2023 at 06:27:11AM +0200, Cristian Ciocaltea wrote:
>> The StarFive VisionFive V1 SBC has a Motorcomm YT8521 PHY supporting
>> RGMII-ID, but requires manual adjustment of the RX internal delay to
>> work properly.
>>
>> The default RX delay provided by the driver is 1.95 ns, which proves to
>> be too high. Applying a 50% reduction seems to mitigate the issue.
> 
> I'm not so happy this cannot be explained. You are potentially heading
> into horrible backwards compatibility problems with old DT blobs and
> new kernels once this is explained and fixed.

It seems the visionfive-v2 board also required setting some delays, but
unfortunately no details were provided:

0104340a67b1 ("riscv: dts: starfive: visionfive 2: Add configuration of
mac and phy")

Thanks,
Cristian
