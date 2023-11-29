Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931CA7FE38E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjK2WsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2WsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:48:02 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947BCF4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:48:08 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77dd4952308so25471185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701298086; x=1701902886; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wuev4zb80Ov60ZVj1spuY8t1xp8xmjlvL54C02XOAGI=;
        b=eqVj5SNO8e21bNsuAyfF23gTW0qohOPojsKAkbPmNR2+zgfENNBmciIHS1tX+7gahf
         n4J/dH1FCN8tr2ZuMtIp6eccNm8MTFcbQ7Y0EPv/Ew/1F4FAPy5uMpzaVrnNuPoA7pcw
         /YrUPTn0S5nKF7QWuRQttcfpf+M0GYLO8jSCYRqxzu+mzJoOys2thK/ZcNupZlbsJCJT
         nER/7GQqEVe/ORd8z+sa4UhMqO5MOXr5bOmLQ/iptXb6oRPp7Yrzh5pisjEPt2wgNSkK
         CODPTWo/roXqyiD4NQeRxrZnWHtbNrSGr///q5Ojkd4vQGpg6xFaw8ga4LRDOrmHkryz
         Df4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701298086; x=1701902886;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wuev4zb80Ov60ZVj1spuY8t1xp8xmjlvL54C02XOAGI=;
        b=xSjJpwFcpN/mZdszZWzgmcLVxUQB+LX368rPPSGjnnXHnaHt67RS5M6kRIcU/qqQFI
         C0dKGMst3wvxnifJ03Dzes41lH/4NtBDKb2a3xsx89wHTUipwnBN3Q7XbPjUKmoS2sPR
         xottIlaUDdSxlu3KQfxGy+QvIMBvoPf1tzlPyK4t4/8vqQjNc1F2ju7+xVl+qJqs2nKQ
         o+aAEWABaR0xj98mjuqLCR5n/W8OHvubiCQl5I7eINdA2u5M5vG/OOJyLPaIWTh6lLni
         aApDpDyhvNdxM32zGGQCRKTqt0p7tbYTG4IHc+ZISbxOK6GYW8Vg0dov2Omz6NQq1zcz
         1eJw==
X-Gm-Message-State: AOJu0YxyTC1G7PzR72CXnnFh52jxLU7Qmuu90Smv/KTHdFuyEuOjr1iM
        ParVM72A7NGbCzVAp5we2iesuH+NJYs=
X-Google-Smtp-Source: AGHT+IEb5EwGEUxR8zD9cpH/oyYNe0zJ1XUGBrXDLycUzZDkj8sJyA6G8Z6K0FBQITGldBo2hK8EbQ==
X-Received: by 2002:a05:620a:1725:b0:77d:855d:1b09 with SMTP id az37-20020a05620a172500b0077d855d1b09mr28851392qkb.0.1701298085468;
        Wed, 29 Nov 2023 14:48:05 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bj27-20020a05620a191b00b0077d660ac1b6sm5767414qkb.21.2023.11.29.14.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 14:48:04 -0800 (PST)
Message-ID: <cfc3aa17-0f1b-4ffc-b848-33baa51b1196@gmail.com>
Date:   Wed, 29 Nov 2023 14:48:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: No care given to GDB scripts..
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It is quite clear that there are zero cares being given to making sure 
that GDB scripts continue to work after making changes to core kernel 
code, and why would you, because you probably did not know those 
existed, but they do and they are used, and useful.

A recent example that was fixed by Kuan-Ying is this:

and now of course, "lx-interupts" also stopped working altogether after 
this change:

https://lore.kernel.org/r/20230519134902.1495562-4-sdonthineni@nvidia.com

and who knows what else I could not test that is also broken.

We really need to find a better way to stop breaking GDB scripts, they 
break way too often to be even remotely usable, and this is really sad.

It is also quite clear that we do not have enough continuous integration 
and regression testing to ensure those breakages are caught ahead of time...

</rant>
-- 
Florian
