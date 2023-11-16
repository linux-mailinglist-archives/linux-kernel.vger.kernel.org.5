Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D700B7EE145
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbjKPNP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjKPNPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:15:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB7CE;
        Thu, 16 Nov 2023 05:15:52 -0800 (PST)
Received: from [100.116.17.117] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4C9A56607346;
        Thu, 16 Nov 2023 13:15:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700140550;
        bh=FheqyWG5oYvdCs8XtH6cmP60r9uz+9KnrY6VzNg5O78=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=dm27RZPNxmcmHyvomtwlEgtdO2kSvRTcyqGzL8VH0w8o5o0vVlJOZ2j5Nz0H06egL
         djXzOYk/C3/Tdp+XcYP9FRTbNQ3Nepoe08B/Jc8SforDRhp1DYbfu46Th2xQV8DjO+
         FQFujPBoHELizF0oDJcFBzjD5q7fJgJpdkHZlQ+A2rHcURp+zwJALeZi9yVia4Qlvw
         Jf/NwAaaod2Wz2DgOKw7N0DOR6pNuu1hDKCk7PngXmB8d4hPw8ZOKgQYuqQ+E2ueH1
         SbIg8i5QjI0C7kevhMN5N6XYzG6navy0j9hPV15fj25yq8yrIOJfsDgPqlafTQt16T
         CyXa6LEC5tR0g==
Message-ID: <cb6597be-2185-45ad-aa47-c6804ff68c85@collabora.com>
Date:   Thu, 16 Nov 2023 15:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] [UNTESTED] riscv: dts: starfive:
 beaglev-starlight: Enable gmac
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
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
 <20231029042712.520010-13-cristian.ciocaltea@collabora.com>
 <f253b50a-a0ac-40c6-b13d-013de7bac407@lunn.ch>
 <233a45e1-15ac-40da-badf-dee2d3d60777@collabora.com>
In-Reply-To: <233a45e1-15ac-40da-badf-dee2d3d60777@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/23 00:53, Cristian Ciocaltea wrote:
> On 10/29/23 20:46, Andrew Lunn wrote:
>> On Sun, Oct 29, 2023 at 06:27:12AM +0200, Cristian Ciocaltea wrote:
>>> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
>>> RGMII-ID.
>>>
>>> TODO: Verify if manual adjustment of the RX internal delay is needed. If
>>> yes, add the mdio & phy sub-nodes.
>>
>> Please could you try to get this tested. It might shed some light on
>> what is going on here, since it is a different PHY.
> 
> Actually, this is the main reason I added the patch. I don't have access
> to this board, so it would be great if we could get some help with testing.

@Emil, @Conor: Any idea who might help us with a quick test on the
BeagleV Starlight board?

Thanks,
Cristian
