Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2367DFA2A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377300AbjKBSnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377207AbjKBSnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:43:31 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7987128;
        Thu,  2 Nov 2023 11:43:28 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a86b6391e9so15332427b3.0;
        Thu, 02 Nov 2023 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698950608; x=1699555408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3OCUKIJblthjBAmG3vt22DDyNrmU9MlYinLfZ0K7Xs=;
        b=b6Rpl/+9pbDKsIkHONmDhCUAgzXGp2bbE1fEyseaqzBjEubY2BQpFpFYzdBQef3/2z
         DU1IP2hIQa42iuHDR0HMa4hgYeqigYGY32fi2akAqjXNxvQ0amgeDbAb+o4xi8wJFN7H
         TMgD2/BMvygwi8bZ01b7G1RG9Xcwms6GQHtLtPT7KBMM63XZlPave7+v6W7dVC4P7Gvx
         YU8B5JV3SqXVYPjh/vzCIRrv2RgJR2OQft6LQqEkq3Y4f/aisjJO7Cdwt2akN1A6o54M
         xxE2ZPE6BTvrzUIDWHUMdKN5Q6Y1sXhbGVr0JAwQodTFDrQ2OoEQcBHFTohdpKVPs8ev
         NOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698950608; x=1699555408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3OCUKIJblthjBAmG3vt22DDyNrmU9MlYinLfZ0K7Xs=;
        b=KDVqr5/oiXZnis6A5zUc1VgaCTYYtllXtp6b0NKMokoeuOmHwLxNY4I/SD7UI4MhIU
         udQY+bL+tS35rTn4QsUe6CSUTctX5Opok1hzEj/d+XYHMSHq796VzS2txuUBV3WMKr13
         yzpvC30MGeZqp1drPStgNC/4MJ6g9ZHu1ajDzv8x8Cdlz1I5N7VVd9+KASD55WIOcM7f
         FvKvK7j5XPvlaDeFhH8iPpTH3hr16IVFkS9YTF5gIuZxXhtmfnXClYtcI84wHCMiijje
         adTyMKvyK1o9Yzdpy77jH+HXxj5CGItZA8OpY5cso39FnNDuktg3ohoA16DJgjM9NFNx
         hdig==
X-Gm-Message-State: AOJu0YxnIYm1H9SdaqmJnoz8Kijw/P5x526+BOEQZmOfjlALFuHtH2Wf
        6lcVtPamFYDfyEawqRGMpZM=
X-Google-Smtp-Source: AGHT+IHcn+D7Mz9xrTHEz8hxFzaHe+Xzq2rCHcr2HsELphZUue1M+Zu+ivtlx9djqs8B693fXUCn7w==
X-Received: by 2002:a81:a115:0:b0:5a7:af86:8d3b with SMTP id y21-20020a81a115000000b005a7af868d3bmr575857ywg.37.1698950608056;
        Thu, 02 Nov 2023 11:43:28 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t10-20020a0cea2a000000b0065b1f90ff8csm1671qvp.40.2023.11.02.11.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 11:43:27 -0700 (PDT)
Message-ID: <ff7e60bf-13c9-44fe-b9e0-0f1ef4904745@gmail.com>
Date:   Thu, 2 Nov 2023 11:43:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
 <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com>
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

On 11/1/23 13:18, Linus Walleij wrote:
> On Tue, Oct 31, 2023 at 11:45 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> It was reported that the "LuCI" web UI was not working properly
>> with a device using the RTL8366RB switch. Disabling the egress
>> port tagging code made the switch work again, but this is not
>> a good solution as we want to be able to direct traffic to a
>> certain port.
> 
> Luiz is not seeing this on his ethernet controller so:
> 
> pw-bot: cr
> 
> (I've seen Vladmir do this, I don't know what it means, but seems
> to be how to hold back patches.)

Looking at drivers/net/ethernet/cortina/gemini.c, should not we account 
for when the MAC is used as a conduit and include the right amount of 
"MTU" bytes? Something like this (compile tested only):

diff --git a/drivers/net/ethernet/cortina/gemini.c 
b/drivers/net/ethernet/cortina/gemini.c
index 5423fe26b4ef..5143f3734c3b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -36,6 +36,7 @@
  #include <linux/ethtool.h>
  #include <linux/tcp.h>
  #include <linux/u64_stats_sync.h>
+#include <net/dsa.h>

  #include <linux/in.h>
  #include <linux/ip.h>
@@ -1151,6 +1152,13 @@ static int gmac_map_tx_bufs(struct net_device 
*netdev, struct sk_buff *skb,
         if (skb->protocol == htons(ETH_P_8021Q))
                 mtu += VLAN_HLEN;

+#if IS_ENABLED(CONFIG_NET_DSA)
+       if (netdev_uses_dsa(netdev)) {
+               const struct dsa_device_ops *ops = 
skb->dev->dsa_ptr->tag_ops;
+               mtu += ops->needed_headroom;
+       }
+#endif
+
         word1 = skb->len;
         word3 = SOF_BIT;

Also, as a separate check, might be worth annotating the various 
descriptor words with __le32 and appropriate le32_to_cpu() and 
cpu_to_le32() accessors for each of those fields.
-- 
Florian

