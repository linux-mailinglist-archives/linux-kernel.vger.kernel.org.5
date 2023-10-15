Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB5B7C9AD2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjJOSmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 14:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOSmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 14:42:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E08AB;
        Sun, 15 Oct 2023 11:42:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9bf0bee9f2fso38807466b.1;
        Sun, 15 Oct 2023 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697395323; x=1698000123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqtpH20wflaioGvES9J8NH5ppY7AwDBKbQOe+1udiSg=;
        b=eWuILn9UcVf3e/U9LwZxb1m1EN+Bf6mk8T03Iu3i2upfzE+Az7S/uj9wYlIbmyngUu
         XJCnlp0Fo19S6qk96g6c2Bh+Ex0HF8e9cPSBcqogrACKgBDFEEAeI+OG5w3F1eMLQZ06
         WiM2RfGllv7H12SzUN2yQ2e+JoHPdO46Hi9zyv/Th4IjxO8PUC+QWRBhnrZF1Xn9Qlh0
         jTgdQNAiflnoMqMuAQ+uGF+idmf8VkiPuXfgr6mpNF1wANIiHoW2ZADEG1YrO4ey3Wkq
         vFBRkDe0mKpnCGZHUBtUSuEmBkTGkWe5Z8EL4Syef2v+6gGv7o1gWWMCUFoF2R//7bb+
         BE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697395323; x=1698000123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqtpH20wflaioGvES9J8NH5ppY7AwDBKbQOe+1udiSg=;
        b=JSILALsrTtvAvMHQ1g/loGZUqQmYg0Xw8Txk+KhMXd6EuLABEapDQgOufB78ZdOQZM
         cGA0r22yDf4SWKHZABWhlbgy+0GErWkE4Gf8+RKt4svY1MiMcpYroy3i8bQl1B7kNUWL
         BH7bhw3hnvwhy3NCnxAV2qbeLVRiNCzpHUk/6ZwBIEqB70eA5qdz9WMsY2zxcuwlqFXX
         iLojIMpafz6ShVrU04q0Gkqtit9miCJNk7Z0nDiFFwD440LnBve+8ShTbrA9KbE6DXAr
         roTMqSaav5TuWJQroJGsYmjjaMU4l25Yx6f0JUkuBU2JAkCcz5MhmccX6SL7/EiZx/ji
         n59Q==
X-Gm-Message-State: AOJu0YxW77um6PraBP+MGjrts/AzWUgMCfRVGcFUB64ZWCBc7n5k1H/3
        FldPY07Vo9VEJOf8xOGQQRY=
X-Google-Smtp-Source: AGHT+IHNaW6WWeWoA+ixNKPIZiaPZY/LmCPKta4SIuS41L9rhTiHm3rRf9wxlI/K+SAfdEX0xtYFSw==
X-Received: by 2002:a17:907:6d1a:b0:9be:8de2:a56c with SMTP id sa26-20020a1709076d1a00b009be8de2a56cmr3832751ejc.0.1697395323004;
        Sun, 15 Oct 2023 11:42:03 -0700 (PDT)
Received: from [192.168.0.103] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id mr8-20020a170907828800b009adc5802d08sm2591566ejc.190.2023.10.15.11.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 11:42:02 -0700 (PDT)
Message-ID: <08e266b5-cc6f-4428-bb50-11122a174e94@gmail.com>
Date:   Sun, 15 Oct 2023 20:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
To:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jakub Kicinski <kuba@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "David S . Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
References: <20231010155444.858483-1-arnd@kernel.org>
 <e93e4008-65c5-4f1d-812a-64b48f0513a2@gmail.com>
 <c8f43e1b-aed1-4b45-ba7c-d896ff66dfa7@app.fastmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <c8f43e1b-aed1-4b45-ba7c-d896ff66dfa7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 17:36, Arnd Bergmann wrote:
> At the moment, I'd suggest focusing on the drivers that still use wext 
> (git grep -w iw_handler_def drivers), if we can show that rtl8192e, 
> rtl8712 or ks7010 have been broken for a while, removing those would 
> help with removing wext altogether.


Hi,

__rtl8192e__
this hardware is available on ebay 13 times.
ping statistics:
1191 packets transmitted, 1191 received, 0% packet loss, time 1192169ms
rtt min/avg/max/mdev = 0.633/2.184/74.792/3.157 ms
maximum download 12,5 MByte/s

__rtl8712__
stick packard bell AW-NU120
ping statistics:
678 packets transmitted, 652 received, 3.83481% packet loss, time 678287ms
rtt min/avg/max/mdev = 0.943/4.835/231.435/17.900 ms
maximum download 12,5 MByte/s

I would like to remove the private functions as the "wireless tools" 
package is deprecated. The following functions are available:
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ iwpriv wlan0
wlan0     Available private ioctls :
           read32           (8BE0) : set   1 int   & get   0
           write32          (8BE1) : set   1 int   & get   0
           driver_ext       (8BE2) : set   0       & get   0
           mp_ioctl         (8BE3) : set   0       & get   0
           apinfo           (8BE4) : set   1 int   & get   0
           setpid           (8BE5) : set   1 int   & get   0
           wps_start        (8BE6) : set   1 int   & get   0
           chplan           (8BE7) : set   1 int   & get   0

What do you think about this?

Thanks

Bye Philipp
