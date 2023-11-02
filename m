Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B497DFC57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377454AbjKBWZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjKBWZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:25:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8962B138;
        Thu,  2 Nov 2023 15:24:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc330e8f58so11963785ad.3;
        Thu, 02 Nov 2023 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698963899; x=1699568699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vavql0gOFP7X20anq8HgeOWwM7lJhURUerirAcwtVGo=;
        b=YwADAbxmqXBvi0Wo5VZPwjvzTo+pdp4JYRplxlYOZvVyNTBL3vXP0XGdLq4zGY0Uht
         qQLGsOkGEw6gDW2y9TehusI/tnIvAUw030DEfEZ7O33sAtb3ABctodrawihYddZWGUTz
         fT8wbqhLWFycwBmUfgME3nrMgdq8uQ5CsW+kdHshe2Si6qidyIu4kiiouq1dy3yd67C1
         BwlhFR/hAIsl+bNcON3FXwNTJ9vW0Bep3mPSYWBYUn7EqD458mBb2e8LJ7u1NO7jo747
         dM+tBibNa8+HJcW51xBQR0CTJf3CEUEdn4imCpWDRB21GBIaSXZ/J+ojBF+Dyi/xBsZ+
         7wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698963899; x=1699568699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vavql0gOFP7X20anq8HgeOWwM7lJhURUerirAcwtVGo=;
        b=ffiKe38bMy7cglcIdo+378EhLxe3WeEd+nATlgwVCUzignF/VErz9RfrymQ/L4ufOm
         C2nhC9WDR3G0H9SGaAiXJYLHGYULg02iIXy0JZGTQrO536EkBuZtul6fmpgS0ScBzpYn
         lzFlKlwkFcOsHUtrb/vhhGWaAthkAEOrxo7uw0KujegiEviiKiC7wJMJMaRl1jtabD6e
         EHF4aulc/FpCs+uuN/8TWTFztF1ipQF+4BN7lOW5eowgEyJMDMJ1tgQl4ADAdOyEefrQ
         Iq9lh8Ii4msZ9E/zXDspbBoE6X0Rn0a8pPuInZhM9QoNRJXJuLsvF+TzxFscugWamprd
         Ojjg==
X-Gm-Message-State: AOJu0YxEkBBCQsqq4ZvKVgjrGD0odNAo3CLfREeOxa60imujtP+Z9Zf9
        lmopCtEzQziXAYQw1wYrbho=
X-Google-Smtp-Source: AGHT+IFoMRruO2yiPqOkXbSx+uBINdCWa6XJIOyhpha02qPLV8SR+dUdejRCQDNQMB9PEdbgEbVeJw==
X-Received: by 2002:a17:902:f687:b0:1cc:4a23:c5fc with SMTP id l7-20020a170902f68700b001cc4a23c5fcmr14195864plg.2.1698963898858;
        Thu, 02 Nov 2023 15:24:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t12-20020a1709028c8c00b001c444106bcasm191875plo.46.2023.11.02.15.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 15:24:58 -0700 (PDT)
Message-ID: <05fbf600-027c-45b6-8f09-a3c03dde025c@gmail.com>
Date:   Thu, 2 Nov 2023 15:24:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
 <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com>
 <ff7e60bf-13c9-44fe-b9e0-0f1ef4904745@gmail.com>
 <CACRpkdY2UiFyTvF=zuk-rSZBi+yH6cP-QRkegMgc3wf=9JD_Wg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CACRpkdY2UiFyTvF=zuk-rSZBi+yH6cP-QRkegMgc3wf=9JD_Wg@mail.gmail.com>
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

On 11/2/23 15:09, Linus Walleij wrote:
> On Thu, Nov 2, 2023 at 7:43 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>> Looking at drivers/net/ethernet/cortina/gemini.c, should not we account
>> for when the MAC is used as a conduit and include the right amount of
>> "MTU" bytes? Something like this (compile tested only):
> 
> The DSA core already fixes this by adding the tag size to the MTU
> of the conduit interface, so netdev->mtu is already 1504 for this
> switch.
> 
> I found other oddities though so I'm digging into the driver!

Yes indeed, I forgot about that, never mind :)
-- 
Florian

