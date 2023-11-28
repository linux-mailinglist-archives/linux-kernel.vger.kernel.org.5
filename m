Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876BD7FC95E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376556AbjK1WUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376685AbjK1WUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:20:45 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECB719A6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:20:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b2a85c99bso7970495e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701210050; x=1701814850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRvAv5IYh+L+f8RPVNKnR2nzMz01vR6z5LweeBPSxso=;
        b=e09yQ7OHhuQSFamU2RI2szg+QC1ATCDLwNnPKekt8IijXKTaaQu0I5dzClCvR7ZqTk
         Sa3hoJBVdVeNimby+BuUtQIyTFWgLv1TK7Tsk2cp7aeXbR2/7bWBsbCvaUgRVcPcgQRE
         G4UwpLwqhKmKhJActFlfNRJI2j78SsEf+T7JfT3o4hrLdmN8AJ3DixlDPRhFwyzL1Z0R
         pOVOVzkmigO35UjFGZvqNV5klqQokpDhqJPo2IXZ3MyCTz+n66pvOJdsDDdOzukQdH6s
         9TGYKgCRfO6/HeOWpJzqbluE5RHnEqYN2B4qkn+aO61/QRYS3adXIdPkgRRKPIJGi1GS
         SdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701210050; x=1701814850;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRvAv5IYh+L+f8RPVNKnR2nzMz01vR6z5LweeBPSxso=;
        b=Qxbxajy/j4PEbHcGoiFmG3UeABFp/7CuZIvXwFRABJUXOM84mt0ae+6VzB6T5CnUvl
         N01ii1Z4NRb1u3NYgvQn+NCro/Cn8AUC1mrEv9MQhFHROZZH4Y9XTvSb0R7yJVyP9MaB
         Oli/S8XCZuiGvXcrspBLLjnr8ewVrgCkRpxxC8p8CwShIx0I/RFQ4y100TefEw1fhlLl
         xMupJFJYtSgjHI5K5HdGzebH886gEKlTUOvB/MAkSgVWZ8Mmd7umikkvY596LQ3rhNmG
         pE239a9nevrvlMiSPi1cQ+shU2T+/Qi+vKVrb3/JTLezrGkq77ZlO9w0jOxJe2XOFd9Z
         87Lg==
X-Gm-Message-State: AOJu0Yy3tsZ47cYvZHexoxD//jRP4FSZwS49D7Bx7HkeMTn6+4ncNpT7
        j0zKBvS3eLTwE/fGQgdv8K911oTMQrk=
X-Google-Smtp-Source: AGHT+IGbiQyKPPiP2jdk8NX4rLPKY9dmORw57Bfs1HS1Y+VH0y+v23BPROR1AjPnZfVXoyxS04aIlA==
X-Received: by 2002:a05:600c:8512:b0:405:358c:ba75 with SMTP id gw18-20020a05600c851200b00405358cba75mr11489436wmb.0.1701210049729;
        Tue, 28 Nov 2023 14:20:49 -0800 (PST)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b0040b347d90d0sm19436693wmq.12.2023.11.28.14.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 14:20:49 -0800 (PST)
Message-ID: <51bd23f2-034a-4e28-b275-99c1392ee43a@gmail.com>
Date:   Tue, 28 Nov 2023 23:20:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] staging: rtl8192e: Remove action block acknowledgment
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1701202700.git.philipp.g.hortmann@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1701202700.git.philipp.g.hortmann@gmail.com>
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

On 11/28/23 21:43, Philipp Hortmann wrote:
> AP are learning very quickly that rtl8192e driver is handling block
> acknowledgment (BA) not as expected.
> The log of the driver is showing the following output:
> rtl819xE 0000:03:00.0 wlan0: received DELBA while QOS or HT is not supported(0, 1)
> Then AP are giving up.
> 
> Tested with rtl8192e (WLL6130-D99) in Mode n (12.5 MB/s)
> Transferred this patch over wlan connection of rtl8192e.
> 
> Philipp Hortmann (6):
>    staging: rtl8192e: Remove action block acknowledgment
>    staging: rtl8192e: Remove unused function rtllib_rx_ADDBAReq()
>    staging: rtl8192e: Remove unused function rtllib_send_ADDBARsp()
>    staging: rtl8192e: Remove unused function
>      rtllib_FlushRxTsPendingPkts()
>    staging: rtl8192e: Remove unused function rtllib_rx_ADDBARsp()
>    staging: rtl8192e: Remove unused function rtllib_rx_DELBA()
> 
>   drivers/staging/rtl8192e/rtl819x_BAProc.c | 262 ----------------------
>   drivers/staging/rtl8192e/rtllib.h         |   6 +-
>   drivers/staging/rtl8192e/rtllib_rx.c      |  33 ---
>   drivers/staging/rtl8192e/rtllib_softmac.c |  30 ---
>   4 files changed, 1 insertion(+), 330 deletions(-)
> 

Hi Greg,

please ignore this patch series. It creates a performance issue....

Sorry for the noise in the mailing list.

Bye Philipp
