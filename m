Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C670576D70D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjHBSpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjHBSp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:45:28 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627EA213D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:45:25 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CAD41868BC;
        Wed,  2 Aug 2023 20:45:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1691001923;
        bh=HkVsvctANfjqtRCNkMupEsziCBW5UjbjHe7T2eo0Uag=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WcktwjYhIDrk+RAb0/adNBVtIPfJ93HpDGKHxWcyqyGHOeEgIDCpGZxiLbqEKu82P
         U4rRrIq5V63WOH8SHETWlFSvj3KPMZ1hccdP16Lv4JEEesc0LxIu0yZ7twcQbZM1/a
         e/TK/JSEVSR+0bQkfRzJO7jON0LnzLBcPeD9Z+2Epr6yAgSWwI5ykeS90J/GgJ+LXF
         CrO6fOKaIfeeuHRDwCN6U0HonjP/DjqDjnyNYrWvHFvde/yLl4j50yv5PTtzDPhRCU
         dSDe+KXWdRAEQtcI1PnJi55I1oGBqc8PZQjc2j1XrtmbhLr/uQaWGAwEbMJQOQRS5M
         L0WonwG52DIww==
Message-ID: <c5597c50-d41c-9f7e-fb85-4e4a1bc29f15@denx.de>
Date:   Wed, 2 Aug 2023 20:45:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
 <5cf0e3fa-f66d-06c4-cfda-c48efd8c6508@linaro.org>
 <bf95af44-2510-1835-dec9-183144de8413@denx.de>
 <CAA8EJppp_ZJr-DcoZGd1GZmWuo=AECNS+X9zx0dNB4Edn8M2zg@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAA8EJppp_ZJr-DcoZGd1GZmWuo=AECNS+X9zx0dNB4Edn8M2zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 20:16, Dmitry Baryshkov wrote:
> On Wed, 2 Aug 2023 at 20:34, Marek Vasut <marex@denx.de> wrote:
>>
>> On 8/2/23 15:38, Dmitry Baryshkov wrote:
>>> On 02/08/2023 11:52, Neil Armstrong wrote:
>>>> This reverts commit [1] to fix display regression on the Dragonboard 845c
>>>> (SDM845) devboard.
>>>>
>>>> There's a mismatch on the real action of the following flags:
>>>> - MIPI_DSI_MODE_VIDEO_NO_HSA
>>>> - MIPI_DSI_MODE_VIDEO_NO_HFP
>>>> - MIPI_DSI_MODE_VIDEO_NO_HBP
>>>> which leads to a non-working display on qcom platforms.
>>>>
>>>> [1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and
>>>> EOT packet")
>>>>
>>>> Cc: Marek Vasut <marex@denx.de>
>>>> Cc: Robert Foss <rfoss@kernel.org>
>>>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>>>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>> Fixes: 8ddce13ae69 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA
>>>> and EOT packet")
>>>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>>>> Link:
>>>> https://lore.kernel.org/r/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #fix db845c
>>>
>>> The boards broken by [1] are used in production by different parties
>>> since 5.10, breaking them doesn't seem more acceptable than breaking the
>>> new out-of-tree iMX8m hardware.
>>
>> The MX8M is also in-tree, so this does not apply.
> 
> v6.5-rc4:
> 
> $ git grep lontium,lt9611 | grep -v 9611uxc
> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:$id:
> http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:
>      - lontium,lt9611
> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:
>        compatible = "lontium,lt9611";
> arch/arm64/boot/dts/qcom/sdm845-db845c.dts: compatible = "lontium,lt9611";
> drivers/gpu/drm/bridge/lontium-lt9611.c: { "lontium,lt9611", 0 },
> drivers/gpu/drm/bridge/lontium-lt9611.c: { .compatible = "lontium,lt9611" },
> 
> next-20230802:
> 
> $ git grep lontium,lt9611 | grep -v 9611uxc
> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:$id:
> http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:
>      - lontium,lt9611
> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:
>        compatible = "lontium,lt9611";
> arch/arm64/boot/dts/qcom/sdm845-db845c.dts: compatible = "lontium,lt9611";
> drivers/gpu/drm/bridge/lontium-lt9611.c: { "lontium,lt9611", 0 },
> drivers/gpu/drm/bridge/lontium-lt9611.c: { .compatible = "lontium,lt9611" },
> 
> Your device is not in the tree. Your commit broke existing users.

These devices are in tree:
arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dts
arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts

The LT9211 and LT9611 are both expansion modules handled by DTOs and 
bound to the DSIM (which is also in tree).

> Can we please end the argument, land the fix (this revert) for 6.5 and
> work on the solution for 6.6 or 6.7?

I would much prefer a solution which does not break my existing use 
case. It is still not even clear whether the problem really is on MX8M 
side at all, or whether it is QCOM misinterpreting flags. I cannot debug 
the later, since I have no access to that platform, nor its documentation.
