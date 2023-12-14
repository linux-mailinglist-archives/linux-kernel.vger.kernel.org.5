Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAD3812F84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444181AbjLNL4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444112AbjLNL4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:56:50 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A60F5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:56:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1f5cb80a91so926435066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702555015; x=1703159815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAk80z6Wt05yIdKe/JUV2jKGr0/LddtdEgIiGSIGHB0=;
        b=m4wzcdz4b86y/KQi5sBprpr6ZaGEUwim/LYRl2aNAeSzTvt0BmD3c+bRMLDRY+jS2g
         rsm85cvbLE0zI4z62rXvlHHbY3zA25wMvxe7bdvEaHT6PHG36ERtOKBFmV1GyvOuzGlQ
         9W2LSp0fysWgaVcGUKfsuUIgIwP2hC7T3/gYZTgpIkvq9DAkRcBsfraAB4hvsLBq/KGh
         zrtPLyvZtiL6cVqJMjhjb/YdRm+hCzpzfpWW+zYZ18BujsAF1kMcur4GbohgTHWXrkJW
         Z5HoKfvYmUCQ2hZNwFhydKwq4rY52XLbcer3lazgx3cSixxcuEIUTFTYZOEQ5APx2Lc0
         T+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555015; x=1703159815;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAk80z6Wt05yIdKe/JUV2jKGr0/LddtdEgIiGSIGHB0=;
        b=F9HKpJp0np3bvATSrE6+R3MAaOydDuuyiJ4vNgoR0WXKwlfu0ixLKbCZJ8tdDZz0X1
         U4PhB+rj+uW3xCN4flyUEfT2ybCRGKHJTuKrJoyqT89dIPI7jstv3kdstdlvgBes85vv
         az/XqfdB9AUM40OKNVfC8INuPm9MwfsXv7s2RdxmhosHaNAJrtRFScX/i3O5ySSIFtOJ
         q2CEGifPkMbrq2l8lyCg648SuBFuJFFk0tDzYjceGaS0mvfGtDHLL4pv8aY/Q95UIzvt
         Q91omcY0euD+ybBYJT5KKT1UhQq2jJ2aDrm2CGyjpBYm5CqeE5c+tg0bZ0yFvPgk6xxz
         D9/Q==
X-Gm-Message-State: AOJu0Yz4LeuZOD23WSCoNeuvAGzjPNIsB6J1TfFLN1KmPrtjedu9P17b
        4Wmery7O2xhBbvBDjUxBREy7RQ==
X-Google-Smtp-Source: AGHT+IG04raSt18SerEL5MEH+ZXjlehHlJvrIcana0QxzLp5r3cYEDmugmu8Xxf6a73Kvv8JqmsWHQ==
X-Received: by 2002:a17:906:11d7:b0:a1f:5dd9:2177 with SMTP id o23-20020a17090611d700b00a1f5dd92177mr2751162eja.149.1702555015139;
        Thu, 14 Dec 2023 03:56:55 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id qo4-20020a170907874400b00a1933a57960sm9111324ejc.22.2023.12.14.03.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 03:56:54 -0800 (PST)
Message-ID: <35e310fc-24ef-4af6-9d8d-52bb80914cec@tuxon.dev>
Date:   Thu, 14 Dec 2023 13:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/21] net: ravb: Add suspend to RAM and
 runtime PM support for RZ/G3S
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, geert+renesas@glider.be
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.12.2023 13:45, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> This series adds suspend to RAM and runtime PM support for Ethernet
> IP available on the RZ/G3S (R9A08G045) SoC.
> 
> As there are IP versions that switch to module standby when disabling
> the clocks, and because of module standby IP switches to reset and
> the register content is lost, to be able to have runtime PM supported
> for all IP variants, the configuration operations were moved all to
> ravb_open()/ravb_close() letting the ravb_probe() and ravb_remove()
> to deal with resource parsing and allocation/free.
> 
> The ethtool and IOCTL APIs that could have been run asyncronously
> were adapted to return if the interface is down. As explained in
> each individual commits description, this should be harmless.
> 
> Along with it, the series contains preparatory cleanups.
> 
> The series has been tested on the boards with the following device trees:
> - r8a7742-iwg21d-q7.dts
> - r8a774a1-hihope-rzg2m-ex.dts 
> - r9a07g043u11-smarc-rzg2ul.dts
> - r9a07g054l2-smarc-rzv2l.dts
> - r9a07g044l2-smarc-rzg2l.dts

And also (I forgot to mention):
- r9a08g045s33-smarc.dts (RZ/G3S).

> 
> Patches are based on series at [1].
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v2:
> - rework the driver (mainly, ravb_open() contains now only resource
>   allocation and parsing leaving the settings to ravb_open(); ravb_remove()
>   has been adapted accordingly) to be able to use runtime PM for all
>   IP variants; due to this number of patches increased
> - adjust previous series to review comments
> - collected tags
> - populated driver's own runtime PM ops with enable/disable of reference
>   clock
> 
> [1] https://lore.kernel.org/all/20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com/
> 
> Claudiu Beznea (21):
>   net: ravb: Let IP-specific receive function to interrogate descriptors
>   net: ravb: Rely on PM domain to enable gptp_clk
>   net: ravb: Make reset controller support mandatory
>   net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and
>     pm_ptr()
>   net: ravb: Use tabs instead of spaces
>   net: ravb: Assert/de-assert reset on suspend/resume
>   net: ravb: Move reference clock enable/disable on runtime PM APIs
>   net: ravb: Move the IRQs get and request in the probe function
>   net: ravb: Split GTI computation and set operations
>   net: ravb: Move delay mode set in the driver's ndo_open API
>   net: ravb: Move DBAT configuration to the driver's ndo_open API
>   net: ravb: Move ptp initialization in the driver's ndo_open API for
>     ccc_gac platorms
>   net: ravb: Set config mode in ndo_open and reset mode in ndo_close
>   net: ravb: Simplify ravb_suspend()
>   net: ravb: Simplify ravb_resume()
>   net: ravb: Keep the reverse order of operations in ravb_close()
>   net: ravb: Keep clock request operations grouped together
>   net: ravb: Return cached statistics if the interface is down
>   net: ravb: Do not set promiscuous mode if the interface is down
>   net: ravb: Do not apply RX CSUM settings to hardware if the interface
>     is down
>   net: ravb: Add runtime PM support
> 
>  drivers/net/ethernet/renesas/ravb.h      |   2 +
>  drivers/net/ethernet/renesas/ravb_main.c | 783 ++++++++++++-----------
>  2 files changed, 417 insertions(+), 368 deletions(-)
> 
