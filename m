Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4942B7A8E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjITV2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjITV2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:28:15 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD24AC6;
        Wed, 20 Sep 2023 14:28:09 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34fc881e09bso871075ab.2;
        Wed, 20 Sep 2023 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695245289; x=1695850089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhZr7XjcT0X2QYa+khDqj+sffAHbjsR+ohS+RJ8dCLg=;
        b=ks3gZSw7WOK/jgaY7mYqyVNVOPDmd+nFYJyHRN3ryAS4cgY7l0R5YJ55xnZAF7uU5a
         OsOwDu7qIqqa3gcEj0Rb1BqQnmrIV7At3DK99ecwH2eAFDchwo2FZTeGtQjLhHn1i1kg
         ZnP0mN06+w/aj6pkQssis0qEx9WHQy+SgYdIWcuBYgFkg/aGSU05Z7qaQH3PAqSWVevR
         qJ2JdTTOO/YSpV23fOVpzp25I/v4elOw43KPFAe9zrRqRpGa9aO4WSrXVNQKBKPyOuEc
         veAqrJVnHSai4TBcpVwPC0ZA7EVShFRZGO8aSVW3p8Q3inUM/JPGKtY0LJ93Y03Baw7K
         6hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245289; x=1695850089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zhZr7XjcT0X2QYa+khDqj+sffAHbjsR+ohS+RJ8dCLg=;
        b=mT77SlYuFiyeuuhqwyleqVJL7PnkMZWzLJgl650ZRtKeNGIl331ZArsn60zZmjuyY7
         1sNPAGyupk82nRWmbGAvOq6y4TQLfFwORr+MQok7/gAmgidm909POLSn3zgUMWz2Tne6
         kAqhmddrkhVFwcRG7HTTotSgDa9oNhsxEgCPAHFxOASHTBO41mewcwleGS/VkuERc7ca
         +T9k7oKeqbUOHSGr2mfXq/z9u7urqxDLP+krCPAUg+gvBKLM+UFLRph0CqSCkeKncQpd
         gzns3FT+J6TXrj/uF4bN1YU5de03/pmebcMfZW8RD7SnXC3UYdvsJA92O2V9HAhe3naV
         PYVg==
X-Gm-Message-State: AOJu0Yz1OECBSne/mr7ZfYrx50LlAOgz8xfPmuBG04/DJXE1FYO6K/bz
        2is668IK4+1+7qu0bZVVhsNmvL6ZI6EVqA==
X-Google-Smtp-Source: AGHT+IEKn+RRSyJ7Tm9O9pl8f/uL+D/7bP3OcnoQxLDN7tkrURK2brualWCoB2JKacZaWdorMLL5Tw==
X-Received: by 2002:a05:6e02:1b06:b0:349:36e1:10fb with SMTP id i6-20020a056e021b0600b0034936e110fbmr4867998ilv.18.1695245289107;
        Wed, 20 Sep 2023 14:28:09 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c22-20020a637256000000b005705b322b3esm10089058pgn.70.2023.09.20.14.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:28:08 -0700 (PDT)
Message-ID: <81cdff2f-8689-9e91-c0aa-e4df796fccb2@gmail.com>
Date:   Wed, 20 Sep 2023 14:28:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/6] MIPS: AR7: remove platform
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-7-wsa+renesas@sang-engineering.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920201035.3445-7-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 13:10, Wolfram Sang wrote:
> After a discussion about removing VLYNQ support from the Kernel, it was
> concluded that its only user, the AR7 platform can go [1]. Even OpenWRT
> has removed support because these devices are "stuck with 3.18" [2].
> 
> [1] https://lore.kernel.org/r/3395161f-2543-46f0-83d9-b918800305e1@gmail.com
> [2] https://openwrt.org/docs/techref/targets/ar7
> 
> Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

