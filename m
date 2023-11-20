Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12767F0EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjKTJQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjKTJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:16:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B704FB8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:16:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso14202265e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700471801; x=1701076601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jj/JcJ1w6jMcLWugwriCsGtGF1LS8H53xH/+54K8aDE=;
        b=gBzXWcIEgBGOKdQjXLAf2xyieH+hH8D8ZHygyUC58emY944uWneG+dqpYgL/0MKlae
         13zyty7q38MPRxtp0/PcFCIShCXO7kJ/xQiJKfJTrYn1VA6I/SXlguGZzv3f2rDlVNhE
         Y+4NvwcOjvHbs7tHn0+iQLwdYyJqsMdmz9b/qSKETvXcCeVrZRsCwJA90a3qM8MWUgmh
         O/uWHVT5E9foH/dicSCxeOQp+Scy04Bun8vGH9mdS4OxGa8NwXfhCGfOMKBWHRiBfsO4
         x1wLdf6UonAR6E9Jeo11v879u8370eFHnkuhE674VuBFj8FdKAE57/0o+JVIlT4nyrrr
         P3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700471801; x=1701076601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj/JcJ1w6jMcLWugwriCsGtGF1LS8H53xH/+54K8aDE=;
        b=cr9HnRmkCSkB55YdLWcdMQch4iejAxAyF3decWVNXq9UyzJRaRXECLo2Iw4cP8Vbk4
         IwHHBs3NxqvH+kKpFyvZ/E83VKbCX3ab8EDFxQfjwTeGqgk4JIeSvp9vsU9CWHbSyyO7
         mkMWnijKm2EtegomisOhCPKQNwMc4cUUPFpkAr4A95AxGJwxXXsNkT7bRYE3Mpb0PMpI
         KJwyRjeyCVCunLXiQM2NRcm4qjZ8xzFwSMpgUGYYZKJxXiAMk0JIQLiLQc8AB/tyt07/
         uA/utyh6WZQc385vAoCQNUGDimIOJFaA3Kdws+d695xdFG9Ly2vhzDhazA8gsjf8aPDj
         xAaA==
X-Gm-Message-State: AOJu0YxGzIRgwUDEOy9g8+s1by5S2D/NkLuK+MSH8SmTf2toOA7gUjfR
        efoLybLf/tbG0oiVH4++6TpVaA==
X-Google-Smtp-Source: AGHT+IFmNtoBSEfrBJtehmlEhkIThZNICwsUjDwLzD9OxRFoGO87Aq+aIatfgr+R8+E6/ugqWeowNw==
X-Received: by 2002:a05:600c:450a:b0:408:386b:1916 with SMTP id t10-20020a05600c450a00b00408386b1916mr5031688wmo.8.1700471801204;
        Mon, 20 Nov 2023 01:16:41 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b004094e565e71sm12752063wmo.23.2023.11.20.01.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 01:16:40 -0800 (PST)
Message-ID: <57cb53ea-f49c-475c-9523-9b2b3d4b59e3@tuxon.dev>
Date:   Mon, 20 Nov 2023 11:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add IRQ support for ethernet PHY on SAM9X60 boards
Content-Language: en-US
To:     Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     cristian.birsan@microchip.com
References: <20231109131149.46397-1-mihai.sain@microchip.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20231109131149.46397-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.11.2023 15:11, Mihai Sain wrote:
> Add IRQ support for ethernet PHY on SAM9X60-Curiosity board.
> Add IRQ support for ethernet PHY on SAM9X60-EK board.
> 
> Mihai Sain (2):
>   ARM: dts: at91: sam9x60_curiosity: Add IRQ support for ethernet PHY
>   ARM: dts: at91: sam9x60ek: Add IRQ support for ethernet PHY
> 
>  arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts | 3 +++
>  arch/arm/boot/dts/microchip/at91-sam9x60ek.dts         | 3 +++
>  2 files changed, 6 insertions(+)
> 

Applied to at91-dt, thanks!

Please note that I've changed the commits' titles as follows:

s/ARM: dts: at91/ARM: dts: microchip/g

to cope with the new microchip directory for DTSes. Please let me know if
you consider there are any issues with this.

Thank you,
Claudiu Beznea
