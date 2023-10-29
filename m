Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9751E7DB18D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjJ2XsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjJ2Xr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:47:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C5FD75;
        Sun, 29 Oct 2023 16:35:20 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.143.101])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE1E86606F9A;
        Sun, 29 Oct 2023 23:35:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698622519;
        bh=MTCi2I9f4ISCBGs2/Fbga3HK8s3ZEp9YzqbtdDcEFuA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E8YqVXFqTKOb1b7+V+LvVodpgloKNhOi/cvEi6BPPS05bV806a0qSmpHGA//N3snW
         h99teObkzlP/UFwAKAFDk9Nk8YCnqRNsEwoz2CN5Rsz/xZx7qxxDU+MnPU99ernPYA
         qEGXl+IYNDpATcKw1tbJeqffsMuMAd6omfTp3+MCNL7mmmkWf1/A/3L9JRX5eVfdTQ
         JonkmqtldtU5gK/6FKezwzsNBda3DWs0J0gxEoBAJDXLwyo1vO6ZcNftj1XXfll6PA
         kW+TEy+Z0LEQweOfGiqxPYeyOUsDCnTxbFLxy+5EnLQV/skyhiNO95EHGcV8RU1FUG
         yDP1+OLtXJmdg==
Message-ID: <7eab89f4-bfd0-441c-8b02-aa9d0f0cdace@collabora.com>
Date:   Mon, 30 Oct 2023 01:35:14 +0200
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
 <f05839c0-7a78-4616-bedc-6a876b7f4bb3@collabora.com>
 <e837e707-5b01-4b7b-8362-0dc62883fdba@lunn.ch>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <e837e707-5b01-4b7b-8362-0dc62883fdba@lunn.ch>
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

On 10/30/23 00:50, Andrew Lunn wrote:
> On Mon, Oct 30, 2023 at 12:41:23AM +0200, Cristian Ciocaltea wrote:
>> On 10/29/23 20:45, Andrew Lunn wrote:
>>> On Sun, Oct 29, 2023 at 06:27:11AM +0200, Cristian Ciocaltea wrote:
>>>> The StarFive VisionFive V1 SBC has a Motorcomm YT8521 PHY supporting
>>>> RGMII-ID, but requires manual adjustment of the RX internal delay to
>>>> work properly.
>>>>
>>>> The default RX delay provided by the driver is 1.95 ns, which proves to
>>>> be too high. Applying a 50% reduction seems to mitigate the issue.
>>>
>>> I'm not so happy this cannot be explained. You are potentially heading
>>> into horrible backwards compatibility problems with old DT blobs and
>>> new kernels once this is explained and fixed.
>>
>> It seems the visionfive-v2 board also required setting some delays, but
>> unfortunately no details were provided:
>>
>> 0104340a67b1 ("riscv: dts: starfive: visionfive 2: Add configuration of
>> mac and phy")
> 
> That board also uses a YT8531 PHY. Its possible this is somehow to do
> with the PHY. Which is why testing with the Microchip PHY is
> important. That should answer the question is it a SoC or a PHY
> problem.

There is also YT8531S, which looks compatible with YT8521, but YT8531
seems to be a bit different. Regardless of what VisionFive v2 is using,
it would be indeed interesting to find out how the Microchip PHY behaves
in this context.

Regards,
Cristian
