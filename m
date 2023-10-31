Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD7B7DD179
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345115AbjJaQXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344962AbjJaQXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:23:07 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1897E6;
        Tue, 31 Oct 2023 09:23:04 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4a87f9a3961so2287782e0c.3;
        Tue, 31 Oct 2023 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698769384; x=1699374184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Viz+yUdLN1JEfalt4qIZeTKl9r578vLGgK7vNHIriW8=;
        b=nFxU+zzAajczk5UXP78YUkdyHsKhBZBMzccv1a5LKpER1spbgjaBiSvjx0Sdww0Mhv
         UN70Td3ZoDKTBfPRwf5HNnXt4dL1qSNSv7BQmLWsi+N8VrYAG3vDVAVnBslcBFJ1+aJo
         zhIZ9ZC2B8dRwzhkwxV2H5C2Jja0eAhWfuQaR2zXjipu+7xl5pg/1xgbEGRpPDw+9b9j
         C+KA5ed3HCi6Pywzh1lCtvqgclX93Ssq0YCaJ+c4CaghKiykRl/6JvAwnBWq7kqk3lJD
         5wadqjOAuDid5U6ZGaaZ5HsinpCkF7c5vkCACextAzUZH9N5hU3d3QWIa0Wlc5s9QZCL
         aqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698769384; x=1699374184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Viz+yUdLN1JEfalt4qIZeTKl9r578vLGgK7vNHIriW8=;
        b=WtdzbXmp5w6JZ4KYyVNxtOviWME1GE1B1d7we+4cxmifzRHxk8vgWDMfDBkK0oLUm1
         i9FH7qo7uXbpNh/lGIV+JxpUMLrP8delS3uAQSH4bKbQCiEwQk53tzi6svb7+HqAp28O
         iTDKfnDqO5fsouH0hIWHiZuhNS0g4ek1cJWYL7pjS2AsY/gcp6cxC19GOXBo7qxG2ZKn
         JnyefbyDQ3/Uz861U9s7kQp8NoaS1f9EW5uKTZ2dIjUe6hajeyUv21zFopekF4GYik5M
         XLMVHH1q4MEdED6TOvR7eMsP1RQev0z2qS0qP8KotxcDPbJ4Gyy8FJfrZbWa/WQZ6yma
         5JdQ==
X-Gm-Message-State: AOJu0YwuxN4KdWKyXAWtizmLGV9dHTufk4YhFn9QtqIhBe2tiebPbwfO
        lyc5e26hAvx83o/hrDmfgzo=
X-Google-Smtp-Source: AGHT+IEovgvdJCj1PYtGFMwu40uFff2U4ceQSmi2WoDx1wENq+Fc3VXLD3k05TI8EVyPhLxJ6grNGA==
X-Received: by 2002:a1f:2f57:0:b0:49b:289a:cc3f with SMTP id v84-20020a1f2f57000000b0049b289acc3fmr11555572vkv.3.1698769383823;
        Tue, 31 Oct 2023 09:23:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w15-20020a056214012f00b0065d1380dd17sm651816qvs.61.2023.10.31.09.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 09:23:03 -0700 (PDT)
Message-ID: <5b265563-9677-44ad-92bc-96bb3b09aa82@gmail.com>
Date:   Tue, 31 Oct 2023 09:23:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf>
 <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030230906.s5feepjcvgbg5e7v@skbuf>
 <494a8bb7-7ca1-40bd-b3a7-babeadfd88a0@lunn.ch>
 <CACRpkdZ8A-Yz-8itXzaBuLHfFLpmwGyg2gUqyNMpx3NbjR+KPA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CACRpkdZ8A-Yz-8itXzaBuLHfFLpmwGyg2gUqyNMpx3NbjR+KPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 07:06, Linus Walleij wrote:
> On Tue, Oct 31, 2023 at 1:37 AM Andrew Lunn <andrew@lunn.ch> wrote:
>> On Tue, Oct 31, 2023 at 01:09:06AM +0200, Vladimir Oltean wrote:
>>> On Mon, Oct 30, 2023 at 11:57:33PM +0100, Linus Walleij wrote:
>>>> This of course make no sense, since the padding function should do nothing
>>>> when the packet is bigger than 60 bytes.
>>>
>>> Indeed, this of course makes no sense. Ping doesn't work, or ARP doesn't
>>> work? Could you add a static ARP entry for the 192.168.1.137 IP address?
>>
>> Probably the ARP, since they are short packets and probably need the
>> padding.
> 
> It seems correct: the reason ping stops working is not that the ping
> isn't reaching the host, I can see the pin request on tcpdumps.
> 
> The reason is that the host has no idea where to send the reply.
> Because it's not getting any ARP replies.
> 
> And that is probably because the ARP replies are short and needs
> padding to ETH_ZLEN.
> 
> I notice the code is probably borrowed from tag_brcm.c which does
> exactly the same thing (ETH_ZLEN + tag). It comes with this
> explanation:
> 
>         /* The Ethernet switch we are interfaced with needs packets to
> be at
>           * least 64 bytes (including FCS) otherwise they will be
> discarded when
>           * they enter the switch port logic. When Broadcom tags are
> enabled, we
>           * need to make sure that packets are at least 68 bytes
>           * (including FCS and tag) because the length verification is
> done after
>           * the Broadcom tag is stripped off the ingress packet.
>           *
>           * Let dsa_slave_xmit() free the SKB
>           */
> 
> The switch fabric is dropping smaller packets when CPU tags
> (DSA tags) are enabled.
> 
> So is the padding to ETH_ZLEN OK or should is happen elsewhere?

This is OK IMHO because you may not always have knowledge of which 
Ethernet MAC the switch is interfaced with, and with the tagger code, 
you have a central location to address them all.

The padding should ideally be done by the Ethernet MAC, even better when 
the HW can do it on its own (as it should), because whether there is a 
switch or not, no link partner should accept runt packets (some might 
but this is not standard).
-- 
Florian

