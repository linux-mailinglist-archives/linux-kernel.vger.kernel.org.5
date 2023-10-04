Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E587B8DC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbjJDUCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243758AbjJDUCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:02:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D76A6;
        Wed,  4 Oct 2023 13:02:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-278f0f565e2so126070a91.2;
        Wed, 04 Oct 2023 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696449740; x=1697054540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lViTZGeslAR3HH6nZnXNd+YPuTFlBg8vmEqhx4ntz6U=;
        b=RFCvSqO/svfR0IRK0gmSmZWKEwzYO33lqVnqLCnsCm8bX+EvsXYchOEqrOJIc9X/hD
         Vr5hlwDIcHZdA3wDRTQunlZFJxR2GgLBK/fcB+yBbCmiT/QsJ51JvZZ5+Vb/3b8ZgxYN
         l1S6VAfcJG6LkZ8t9Myl6iyC/ZOIybZoBLZawl1z+O5N/iDtBtmpzihXmk1hfX8W4sqB
         gtRCxEYgbtaY1nVAx0TSmrna3riUnk9GB/KEmXSO+2dhw07kyGlr8nTVmV4EWbSqGNlk
         ZpqC0zp5DBwUo/eY/7I0To2IBbNYcNouJbxaS3ZlMXPIJDOVbTgihL19yf2ekKtPn+d2
         HAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696449740; x=1697054540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lViTZGeslAR3HH6nZnXNd+YPuTFlBg8vmEqhx4ntz6U=;
        b=udKF3eoFD3OhdLfNjMJpFnWoeig1Zc96YNmHgH/Kk0Wb44iNiBc8v6IcH3mPMF/kv7
         JWjqdCwryIuA3sgoC+Kr75glpmmoEH/Z4gty5u1CiNpReujrlZqtouhOIqMwAcZuaWAt
         HBQCOdQhsmwczAYZ1kKfyHxFerZ0ipVOZnZ0chN9GZVr1a0kRWAzCbSkXse3LqP7SUO4
         W+y12tymKhocr5hKbQ32te6iN1CIIqGSAJ4RQVW7QEhOrGstjR+SHBpXJuTvHlmpLQCC
         KM7L9SbLTxA3+Q6FO0Dq3hP8iCDvNeFZbcYrYA/0He0k6NjEVZMpPifm+k7Bs7GcqPKb
         rJXQ==
X-Gm-Message-State: AOJu0Yz/08vNibSoT1JF5sSRZTwTsB6RSSn9ElNspczuloYYWG+sAPIb
        eDGEm+rxK4wJ0CebSsP5pXo=
X-Google-Smtp-Source: AGHT+IG3o64nUPHAwC60H3gzYDZ+c/fjAAyUBLrUyhNbzkOMfOGcH6oAP3CcBeeiqQ3BMXf5M2FbTQ==
X-Received: by 2002:a17:90b:207:b0:263:ebab:a152 with SMTP id fy7-20020a17090b020700b00263ebaba152mr3052339pjb.19.1696449740193;
        Wed, 04 Oct 2023 13:02:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id cf11-20020a17090aebcb00b00276bde3b8cesm1977942pjb.15.2023.10.04.13.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:02:19 -0700 (PDT)
Message-ID: <b1f64c44-0d1c-480e-a272-fb017e7d8673@gmail.com>
Date:   Wed, 4 Oct 2023 13:02:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: microchip: lan743x : bidirectional throughuput
 improvement
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        andrew@lunn.ch
References: <20230927111623.9966-1-vishvambarpanth.s@microchip.com>
 <20231004122016.76b403f0@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231004122016.76b403f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 12:20, Jakub Kicinski wrote:
> On Wed, 27 Sep 2023 16:46:23 +0530 Vishvambar Panth S wrote:
>> The LAN743x/PCI11xxx DMA descriptors are always 4 dwords long, but the
>> device supports placing the descriptors in memory back to back or
>> reserving space in between them using its DMA_DESCRIPTOR_SPACE (DSPACE)
>> configurable hardware setting. Currently DSPACE is unnecessarily set to
>> match the host's L1 cache line size, resulting in space reserved in
>> between descriptors in most platforms and causing a suboptimal behavior
>> (single PCIe Mem transaction per descriptor). By changing the setting
>> to DSPACE=16 many descriptors can be packed in a single PCIe Mem
>> transaction resulting in a massive performance improvement in
>> bidirectional tests without any negative effects.
>> Tested and verified improvements on x64 PC and several ARM platforms
>> (typical data below)
> 
> Nobody complained for 5 years, and it's not a regression.
> Let's not treat this as a fix, please repost without the Fixes tag for
> net-next.

As a driver maintainer, you may want to provide some guarantees to your 
end users/customers that from stable version X.Y.Z the performance 
issues have been fixed. Performance improvements are definitively border 
line in terms of being considered as bug fixes though.
-- 
Florian

