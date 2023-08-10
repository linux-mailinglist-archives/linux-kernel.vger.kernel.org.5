Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883827777D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHJMFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjHJMFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:05:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1B1268E;
        Thu, 10 Aug 2023 05:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E05465585;
        Thu, 10 Aug 2023 12:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F02C433B7;
        Thu, 10 Aug 2023 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691669144;
        bh=i0cmE0TIm+1MbdD3rP69KYhR9J0vOVc6iWr6PA13760=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hCW+BTVsmjd8dw6pq6If2YoFA1KdhSimtg+FZaT3zqKerq6Qhkw1Ly+60YkzEaETs
         DTK9yrde5/cAxjoRtAcf1f3azCGEv2haaST6qJNFA/UZhYnptKLJ3za2GvunrNCGSm
         YPHGc7cTL3SY9D7a0yj1w0OHQUWelRf//khk2CT7l4RB6xKy+eFvgM2of4RDzJ+X4c
         HSI0pmZF9xQqYDDjKGuB0hPTK3OHF+klMws3GDB/qTbuFThxNyxroohXnJPajnIapg
         6Dc9tHQYI8HP34AI77YhG4DP9QZrnpc6cvbxoNdlfdNtq4J9F/3ekSsPP7NW9fwf0a
         4tqlBwiAhgDwg==
Message-ID: <1b05b4ae-00e7-0f90-9c63-7da8797bdb6a@kernel.org>
Date:   Thu, 10 Aug 2023 15:05:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/5] net: ti: icss-iep: Add IEP driver
Content-Language: en-US
To:     Md Danish Anwar <a0501179@ti.com>, Andrew Davis <afd@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230809114906.21866-1-danishanwar@ti.com>
 <20230809114906.21866-4-danishanwar@ti.com>
 <b43ee5ca-2aab-445a-e24b-cbc95f9186ea@ti.com>
 <c7ddb12d-ae18-5fc2-9729-c88ea73b21d7@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <c7ddb12d-ae18-5fc2-9729-c88ea73b21d7@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/2023 14:50, Md Danish Anwar wrote:
> Hi Andrew,
> 
> On 09/08/23 8:30 pm, Andrew Davis wrote:
>> On 8/9/23 6:49 AM, MD Danish Anwar wrote:
>>> From: Roger Quadros <rogerq@ti.com>
>>>
>>> Add a driver for Industrial Ethernet Peripheral (IEP) block of PRUSS to
>>> support timestamping of ethernet packets and thus support PTP and PPS
>>> for PRU ethernet ports.
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>   drivers/net/ethernet/ti/Kconfig          |  12 +
>>>   drivers/net/ethernet/ti/Makefile         |   1 +
>>>   drivers/net/ethernet/ti/icssg/icss_iep.c | 935 +++++++++++++++++++++++
>>>   drivers/net/ethernet/ti/icssg/icss_iep.h |  38 +
>>>   4 files changed, 986 insertions(+)
>>>   create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.c
>>>   create mode 100644 drivers/net/ethernet/ti/icssg/icss_iep.h
>>>
>>> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
>>> index 63e510b6860f..88b5b1b47779 100644
>>> --- a/drivers/net/ethernet/ti/Kconfig
>>> +++ b/drivers/net/ethernet/ti/Kconfig
>>> @@ -186,6 +186,7 @@ config CPMAC
>>>   config TI_ICSSG_PRUETH
>>>       tristate "TI Gigabit PRU Ethernet driver"
>>>       select PHYLIB
>>> +    select TI_ICSS_IEP
>>
>> Why not save selecting this until you add its use in the ICSSG_PRUETH driver in
>> the next patch.
>>
> 
> The next patch is only adding changes to icssg-prueth .c /.h files. This patch
> is adding changes to Kconfig and the Makefile. To keep it that way selecting
> this is added in this patch. No worries, I will move this to next patch.
> 
>> [...]
>>
>>> +
>>> +static u32 icss_iep_readl(struct icss_iep *iep, int reg)
>>> +{
>>> +    return readl(iep->base + iep->plat_data->reg_offs[reg]);
>>> +}
>>
>> Do these one line functions really add anything? Actually why
>> not use the regmap you have here.
> 
> These one line functions are not really adding anything but they are acting as
> a wrapper around readl /writel and providing some sort of encapsulation as
> directly calling readl will result in a little complicated code.
> 
> /* WIth One line function */
> ts_lo = icss_iep_readl(iep, ICSS_IEP_COUNT_REG0);
> 
> /* Without one line function */
> ts_lo = readl(iep->base, iep->plat_data->reg_offs[ICSS_IEP_COUNT_REG0]);
> 
> Previously regmap was used in this driver. But in older commit [1] in
> 5.10-ti-linux-kernel (Before I picked the driver for upstream) it got changed
> to readl / writel stating that regmap_read / write is too slow. IEP is time
> sensitive and needs faster read and write, probably because of this they
> changed it.

This is true. Can you please pick the exact reasoning mentioned there
and put it as a comment where you use read/writel() instead of regmap()
so we don't forget this and accidentally switch it back to regmap()
in the future.

I think this is only required for read/write to the IEP count register and
SYNC_CTRL_REG when doing gettime/settime.

-- 
cheers,
-roger
