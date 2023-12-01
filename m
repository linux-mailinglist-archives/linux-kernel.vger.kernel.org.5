Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE9800A77
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378743AbjLAMH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378799AbjLAMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:07:41 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4721E1FC3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:07:30 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50aab20e828so2785626e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 04:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20230601.gappssmtp.com; s=20230601; t=1701432448; x=1702037248; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ld796iPDsS/HIVvP7w7PB/lqEfZHZ7EhyA8gH1ALk3s=;
        b=QI1sgGCTHCMa+ydQJry0cT01FDFopZL4C9WtFa02Y6rzqti4oBPYRpPSN/iIjy/WeN
         DG7CoJ1pHdix7dDAderPbr1hc2AVEKFGOBuB3HK4xrA6/eKoKVOnYr7Sy3R4O/V24b1G
         odAUHXYcK8SJVuHabs5g6L6nyE5eL281A7qhQT+xVQjDXyFcHlFM3+b1P7zc1e3w0ADk
         2ZhlNJyE7MirstQ9iTXjp70MHwpE6KeRD/iZkuPODbtBo2+5XUsQQ4rAxldQ13VDsZrS
         xrCLLYjjcUUHlFxRVGWKVK1QGhyBoNMyY5KmsrjtE9PuJh9F4BJYbQ3Qwe10MWMcW8Zp
         qrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701432448; x=1702037248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ld796iPDsS/HIVvP7w7PB/lqEfZHZ7EhyA8gH1ALk3s=;
        b=XxyxIeqQYxUi8wU2EUda4AhK3lBNhi8rtWT3CjUaL/H56S4n9YFNcwNq6Or/nHQalt
         unvYw4GJw5kFLDEq/A5XFWCGwhHJPUgkihVitIr9v9/2E2P4alTtxiKNHm+uPxvEZkFn
         R1K6CWFbOrRA8Eyuo8ea8Gl/h2xUWqjNfGQZ6B2XwrCIQBAx23oQwV+nMg6AcQ9gxk7R
         Gw/KPka2AlkwN6c1R9CsXajQJJmZSIYIA2zaL2kujqq/k/blsUjkNtTrGRv+KfeSw2Fh
         sEOSlF/nHkFYnrg9SMHTb4owt+0qvht2qr3R9Fa2OuqeywMrJyQzySp09GK68C7bnMo9
         pLww==
X-Gm-Message-State: AOJu0YxYsMHTjON/sQ0nxGN6DO1UnGFwdP6VJKzC2gLVvzwn42nXia12
        U6DZRENiEIQWD6MGDLh2b1WMyA==
X-Google-Smtp-Source: AGHT+IGsrE93liKAZolC8G8WXET7gLNXDHqJNS2z6TcNiio4ZxjrJ/SrX10j4SrUKcRLaazKtoz1vQ==
X-Received: by 2002:a05:6512:48c3:b0:50b:c999:8660 with SMTP id er3-20020a05651248c300b0050bc9998660mr500702lfb.54.1701432448501;
        Fri, 01 Dec 2023 04:07:28 -0800 (PST)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id h40-20020a0565123ca800b0050bc57e1419sm407684lfv.243.2023.12.01.04.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 04:07:27 -0800 (PST)
Date:   Fri, 1 Dec 2023 13:07:26 +0100
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add missing bindings for max96712
Message-ID: <ZWnMfsqUGRCDa3HR@oden.dyn.berto.se>
References: <20231115164127.2790596-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231115164127.2790596-1-niklas.soderlund+renesas@ragnatech.se>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Ping on this patch.

On 2023-11-15 17:41:27 +0100, Niklas Söderlund wrote:
> Add the binding documentation to the entry in the MAINTAINERS file.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c9f868e13b6..ea14bd4198a3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13014,6 +13014,7 @@ MAX96712 QUAD GMSL2 DESERIALIZER DRIVER
>  M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/media/i2c/maxim,max96712.yaml
>  F:	drivers/staging/media/max96712/max96712.c
>  
>  MAX9860 MONO AUDIO VOICE CODEC DRIVER
> -- 
> 2.42.1
> 

-- 
Kind Regards,
Niklas Söderlund
