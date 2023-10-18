Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5647CD294
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 05:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjJRDQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 23:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRDQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 23:16:26 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F1FC;
        Tue, 17 Oct 2023 20:16:25 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77774120c6eso91953685a.2;
        Tue, 17 Oct 2023 20:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697598984; x=1698203784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIp2RLOAcqFx00rkPR5HeZvSV49G7fFYfRT94xyZEGI=;
        b=eNv10mp3IghWzhLL2h3+pEuNE6zjRAqkBrgD3cWeQZyZkNScLcsCGdqUxz88KKE+ru
         hR3lz6M1ksOYrZSjoIkfvECC8RhhltKEF5XGMg73X5nhqV8hU7NFrCKNTkc1tR1vV2kW
         ocumSPlnEQKt3xFoEIuclypNXN/7j4amG2Rz8wa+PyHEk6MRamezMesBjuPybLQ2hbuG
         JqqoDHR544/N5gdiajsHvCuB9ey1xnshQI84+l/jjUKWqZZaa6KTMxSXH5M3REazIMj+
         YScp1huyDlHYxlFPxMS7ncB/Ymsm+vOse1mJZXpGgw19qQjlj4JZmuby/6gKKYIE/iLQ
         MQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697598984; x=1698203784;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIp2RLOAcqFx00rkPR5HeZvSV49G7fFYfRT94xyZEGI=;
        b=DmPUItuhJZocWVnks1HJbW1Y4ouclFDbthI1VIfZvJhSkB84v9yv29K/ufC4LY9l07
         md+xfqy2tTAsX+r+07CU3t+ZreofnquuYGMMDO4nEoGTc3lwevkOK6l0L4wIS5f9Fk1S
         alql678k9WeTurM8l276IV87terg1UuLbAvlVW9xh/Gm7hiQ9+bCrI2hlexzQEZ97aUD
         zQAaFkyTw40YKwfGXMTdgkrUj1/Vexkw57FyLJPbjh1RC0u+MnLwB+4HCg1431XJn9nm
         u/L6fRWUa9MnfSHUxcr8gTm1O8PdGxvZQGMvkxDEkuGjWFiKr/VNjuFXI5KkaYmaOgaM
         X1Dw==
X-Gm-Message-State: AOJu0YzNExI8VGAxfRFUyiTlZxNCHW36M0NeXzMrO8xddGv3ww56cXTe
        gNTRPaS7yPQjDKshDvkA0Pw=
X-Google-Smtp-Source: AGHT+IHpjjCwmmAnmZkIF00SeJ3rMEQbk9ykQ7ElHnUryr96SNgD5Gu1F9kgZnH7CFrRnWE1iMMkmA==
X-Received: by 2002:a05:620a:1d81:b0:775:806d:5389 with SMTP id pj1-20020a05620a1d8100b00775806d5389mr4029805qkn.70.1697598983977;
        Tue, 17 Oct 2023 20:16:23 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id ts12-20020a05620a3d8c00b0076cdc3b5beasm1165104qkn.86.2023.10.17.20.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 20:16:21 -0700 (PDT)
Message-ID: <127d957f-0af5-4a6b-9c06-003750daaf9c@gmail.com>
Date:   Tue, 17 Oct 2023 20:16:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: dsa: Use conduit and user terms
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
References: <20231016164742.264613-1-florian.fainelli@broadcom.com>
 <20231016164742.264613-1-florian.fainelli@broadcom.com>
 <20231016164742.264613-2-florian.fainelli@broadcom.com>
 <20231016164742.264613-2-florian.fainelli@broadcom.com>
 <20231017100328.qmwi2dnqay7syoki@skbuf>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231017100328.qmwi2dnqay7syoki@skbuf>
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



On 10/17/2023 3:03 AM, Vladimir Oltean wrote:
> On Mon, Oct 16, 2023 at 09:47:41AM -0700, Florian Fainelli wrote:
>> Use more inclusive terms throughout the DSA subsystem by moving away
>> from "master" which is replaced by "conduit" and "slave" which is
>> replaced by "user". No functional changes.
>>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Note that you left the following unconverted:

Bah, thanks, sent a v5 with those additions. Thank you!
-- 
Florian
