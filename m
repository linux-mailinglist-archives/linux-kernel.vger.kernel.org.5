Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFB80DAC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344513AbjLKTWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjLKTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:22:11 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9582E9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:22:16 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c68c8009eso1039293a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702322535; x=1702927335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15LJJIC+ZvEXcFWs9wkEalc+mlbTT7lJo9MkOjhcNVM=;
        b=PYNJY063QqiACduHl2moz9DVilOrYml2yjnc0obZUVliTtN7+W2oGpOICbiEu/adTq
         Q9ScOS4f812vtvwuTIhy1dK15DnmUadsdmNcukD6Kfd8fihnaHL+1N75pNNdqyUgLuSk
         wiTOlh6kLxY1y3gAs2Vgio8SglMFCPvMBv7+Chq4/XGo8K2lDalg5ROzX3bCHYs367v9
         XxyoG+HI4kTidM5yHozTytKBH0PpV/kRT0k8ffu1uRx3f/zyE5NymVgEQCrwpuKQGomi
         Px0o9EOMmwjF9HB5CKAs5ZArnSY9l435WAJZrm0cVLv+XgUtvjN5+3qfZ6ZtORzvNHYq
         4vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702322535; x=1702927335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15LJJIC+ZvEXcFWs9wkEalc+mlbTT7lJo9MkOjhcNVM=;
        b=NOUzfXzg5v76Aa8nR+87VBHBHUgt7BFGuptyje2X0sM/IzxB9Q6IZyUj5p+tZuMToa
         vOwhqGePyx3xZJaGtGNu6fGsbl4zvqeeNITx8Bb/HuOxItijGSJn/ReMYJ8WK2/qKBdS
         FxvFIlC47CwA97f01/joUwemKxrD0xcOqkMdgeaaUm6LTVXAXqVq2lt+RdqdOegMjyx4
         3Tq5CIIqukkcqKdjqXq5JgehZhStHE1MAbj/+/BG5mI89DvtRTlzCDhoMvwgDIw4zx+O
         oE7eqZ4Nzf9kjINRQGx3sY07AkOtFGq/zH6wFU+zh2CSPYK0KozO1lkKPW7Rf4KMzGQh
         Y/OQ==
X-Gm-Message-State: AOJu0YySPLlM1292qNFYAyfldlxtBmT6MfI+R88VRuk9DwQ6kHw/LqFc
        Dsr+vyX+UPcZJJRib4zg1rI=
X-Google-Smtp-Source: AGHT+IHAI7rQoezDclA4XVHFQFZgJbm6UcBdAk2QaAzvwkh+2+JWiShIuR0bCPSZGvGl1GTnvsGEOQ==
X-Received: by 2002:a17:907:8b8a:b0:a1d:5c34:2ce7 with SMTP id tb10-20020a1709078b8a00b00a1d5c342ce7mr5372808ejc.6.1702322535130;
        Mon, 11 Dec 2023 11:22:15 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id vv8-20020a170907a68800b00a1d2b0d4500sm5210981ejc.168.2023.12.11.11.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 11:22:14 -0800 (PST)
Message-ID: <20793387-da59-4192-bb86-b20aeb127a65@gmail.com>
Date:   Mon, 11 Dec 2023 20:22:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Staging: rtl8192e: Remove variable bFirstSeg
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Tree Davies <tdavies@darkphysics.net>
Cc:     gregkh@linuxfoundation.org, anjan@momi.ca,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231210193705.2131807-1-tdavies@darkphysics.net>
 <20231210193705.2131807-2-tdavies@darkphysics.net>
 <2cdb678d-b784-411e-8913-eb7666e08ccc@suswa.mountain>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <2cdb678d-b784-411e-8913-eb7666e08ccc@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 09:37, Dan Carpenter wrote:
> On Sun, Dec 10, 2023 at 11:37:02AM -0800, Tree Davies wrote:
>> Remove variable bFirstSeg as it is defined but never used.
>>
>> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
>> ---
>>   drivers/staging/rtl8192e/rtllib.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
>> index 0a8c44e497f5..c0a24826cd3b 100644
>> --- a/drivers/staging/rtl8192e/rtllib.h
>> +++ b/drivers/staging/rtl8192e/rtllib.h
>> @@ -103,7 +103,6 @@ struct cb_desc {
>>   	/* Tx Desc Related flags (8-9) */
>>   	u8 bLastIniPkt:1;
>>   	u8 bCmdOrInit:1;
>> -	u8 bFirstSeg:1;
>>   	u8 bLastSeg:1;
>>   	u8 bEncrypt:1;
>>   	u8 tx_dis_rate_fallback:1;
> 
> I don't think you can remove these.  They're part of the protocol for
> talking to the firmware.
> 
> regards,
> dan carpenter
> 

Hi Dan,

thanks for your response.

struct cb_desc is used in conjunction with this line:
struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + 8);
from skbuff.h:
	/*
	 * This is the control buffer. It is free to use for every
	 * layer. Please put your private variables there. If you
	 * want to keep them across layers you have to do a skb_clone()
	 * first. This is owned by whoever has the skb queued ATM.
	 */
	char			cb[48] __aligned(8);

I think it has to do with the sku buffer and can be changed.

Here a test:
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git diff
diff --git a/drivers/staging/rtl8192e/rtllib.h 
b/drivers/staging/rtl8192e/rtllib.h
index cc9070f39004..f29efc605ba9 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -100,6 +100,7 @@ static inline void *netdev_priv_rsl(struct 
net_device *dev)
  /* defined for skb cb field */
  /* At most 28 byte */
  struct cb_desc {
+       u8 ph_temp[7];
         /* Tx Desc Related flags (8-9) */
         u8 bLastIniPkt:1;
         u8 bCmdOrInit:1;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c 
b/drivers/staging/rtl8192e/rtllib_softmac.c
index ee527ba5d1a8..93292fc3faaf 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -189,6 +189,9 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, 
struct rtllib_device *ieee)
         struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + 8);

         spin_lock_irqsave(&ieee->lock, flags);
+       printk("Setting tcb_desc !!!\n");
+       tcb_desc->ph_temp[0] = 0xAA;
+       tcb_desc->ph_temp[6] = 0xAA;

         /* called with 2nd param 0, no mgmt lock required */
         rtllib_sta_wakeup(ieee, 0);

Here the log:
[ 9024.740612] rtl819xE 0000:03:00.0: Adapter(8192 PCI-E) is found - 
DeviceID=8192
[ 9025.773658] Setting tcb_desc !!!
[ 9025.773783] Setting tcb_desc !!!
[ 9025.797635] Setting tcb_desc !!!
[ 9025.797701] Setting tcb_desc !!!
[ 9025.849687] Setting tcb_desc !!!
[ 9025.849743] Setting tcb_desc !!!
[ 9025.977703] Setting tcb_desc !!!
[ 9025.977740] Setting tcb_desc !!!
[ 9026.105693] Setting tcb_desc !!!

Performance as expected OK.

Please reconsider your decision?

Thanks

Bye Philipp



