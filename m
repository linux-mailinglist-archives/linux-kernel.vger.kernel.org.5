Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F07A695C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjISRFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISRFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:05:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC5D7;
        Tue, 19 Sep 2023 10:04:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c44c0f9138so28082775ad.2;
        Tue, 19 Sep 2023 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695143096; x=1695747896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymB1vpWDIEsj0dISNOGxOvNmoKKYpCcM0k00MCmJgzM=;
        b=dCxnxDrH6n2tkJE0u8n5Zd27nN9k31pLyFhzgZng2n/R93MN6bCCMbgoG0P2TDwcij
         Zpp2Ne4b4ESx5W6vRTJFnznQyH9j5xmrA3BGeaullmP52Aek1NTltotppZ5X/UhyE0UU
         sI+T6TsEoBKL9drmJPIek6I76jp/wh2KJcuPNESWR92e5Z/qUaQkvPTyLji3fuHreM2u
         fUSeDm8tqKcJ0P3w6S8bLXfQBSYGd0oTOloWO06yXm+Mey8vL39lGnp7N4pK7tqcBAEp
         mQ3dtYN8jtgLZ3xfoKRq08WVAAABWFKiDB/cB0eqKhwtz8B8lNMABj/dMqNAWOdfdJ/z
         g7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695143096; x=1695747896;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymB1vpWDIEsj0dISNOGxOvNmoKKYpCcM0k00MCmJgzM=;
        b=k+Uiykiuz8MU0cOuOdiiCgK/hmVWRDQDO+c3NLR2x2a7KA3zki4nv6dAOV0JmaiZMj
         O1/nOvm7jIY7S6SdrVKcrAaN+egQ7AGLBBKKkHRLMdR9YqdpS7+YY+VkZ102AJWHboF3
         eM4KYxDTqLyZMpLMztfG9YAknnqULYFk+FC52p2IpwK5ZS2rzrGjRd4f79iK3GoMAjc8
         Y4d22JfkGal59sR88RGRPnFEElLu6x+caPsbI7l1M73iCedx1d3GKGvya6vRAkh7T1fk
         qeSU/NGeI626AyXI6PmgcM1kq+kAufWz7B0GecDFU0EX0ucjCeiEFaO+FudjyGM0MSMs
         S/Fw==
X-Gm-Message-State: AOJu0YybMPD/8hnft4inBFP8h9qvbpR0RRXjwrYSkMg3xHCO9KrCD7gl
        HzuopIUqjLN+Rxo4J0Hlna8=
X-Google-Smtp-Source: AGHT+IHvVdsCWwBld0YImAyIG1jut3CJ0vsAnZ/1jRvl0OSzvomhpR4Gs4MANc0ZASe8EDWaNgDPJQ==
X-Received: by 2002:a17:902:6ac7:b0:1c0:aca0:8c44 with SMTP id i7-20020a1709026ac700b001c0aca08c44mr27484plt.19.1695143095954;
        Tue, 19 Sep 2023 10:04:55 -0700 (PDT)
Received: from [192.168.31.134] ([117.243.68.251])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902ac8700b001bc59cd718asm5324045plr.278.2023.09.19.10.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 10:04:55 -0700 (PDT)
Message-ID: <83bcc70f-2265-0d89-5865-1dc7bdd69be5@gmail.com>
Date:   Tue, 19 Sep 2023 22:34:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] thermal: imx8mm_thermal: Fix function pointer declaration
 by adding identifier name
Content-Language: en-US
To:     rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230917083443.3220-1-bragathemanick0908@gmail.com>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <20230917083443.3220-1-bragathemanick0908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/09/23 14:04, Bragatheswaran Manickavel wrote:

 >Added identifier names to respective definitions for fix
 >warnings reported by checkpatch.pl
 >
 >WARNING: function definition argument 'void *' should also have an 
identifier name
 >WARNING: function definition argument 'int *' should also have an 
identifier name
 >Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
 >---
 > drivers/thermal/imx8mm_thermal.c | 2 +-
 > 1 file changed, 1 insertion(+), 1 deletion(-)
 >
 >diff --git a/drivers/thermal/imx8mm_thermal.c 
b/drivers/thermal/imx8mm_thermal.c
 >index 14111ccf6e4c..5dc6c18f12df 100644
 >--- a/drivers/thermal/imx8mm_thermal.c
 >+++ b/drivers/thermal/imx8mm_thermal.c
 >@@ -78,7 +78,7 @@
 > struct thermal_soc_data {
 >     u32 num_sensors;
 >     u32 version;
 >-    int (*get_temp)(void *, int *);
 >+    int (*get_temp)(void *data, int *temp);
 > };
 >
 > struct tmu_sensor {

Gentle remainder
