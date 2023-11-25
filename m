Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7228D7F8D08
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjKYSTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjKYSTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:19:01 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D83127;
        Sat, 25 Nov 2023 10:19:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a049d19b63bso406974266b.2;
        Sat, 25 Nov 2023 10:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700936347; x=1701541147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7k58q2qLgt0L82bnrgY8gEZUngYxW8tKGSCtes7Hdw=;
        b=Asjp31luFCGEXA/imGtppkaLezXzVj2SaAd7FIy3+EafTYc3D2th12lKCYjNSFY1IC
         RUwhfGtnZbQjww/Ir5cvnoIvCFZNPicqJbEC8llfA+jLNp7nA6rb61rCaeDrqT5NJUjX
         IQytK6nQFu8EOtaIkKhDiQ8zmwCknElwSOmdXUHUu4N5jeWcLnZW6+/zL4mnpjXvmsNi
         4AJ7pr7hIybvqEAPZVfvv4vL/canZob5RYt0taUW8Ctd5nISldo2aMguUVWDNnQtRD73
         xqQ5G0Jh4NO/J+JRQyvG4Ge/Teb9aQ4rw8U+iOEQ5hG6iPwUH1MvFK3Im8gz4JB7fbgJ
         nMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700936347; x=1701541147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7k58q2qLgt0L82bnrgY8gEZUngYxW8tKGSCtes7Hdw=;
        b=o2F4uefU4xi11UiRFghhw4W2m91X5LomthHOrBfC6NvAvI7TCtN0ALTivhlgCJsX50
         H9aFTe9qm/yT+RKVLkspDh2CRQD9zs4cbIpl2VZzN8Kp7qiZaLl5eWQBGM0lal8gu84P
         AHtNA/f6RdpRa8jFdcHX6Z2a7ON3X/A18/EoNSluObyjIP5/6T6j+PbSaqI83Vm4f73M
         k9dQRrZ7Ww2nmeJB2mhbqtOB73We7ykrb3f4AUQxRHi1kB4JOsVk4vZleaV8a/DJcwDL
         Na2amo8VJFK6dXLDA+NZZePsBktJ4wXSHjaDEksHdHMRmXi01JbGy259C/GlhW3lFTQw
         4lWQ==
X-Gm-Message-State: AOJu0Yw3cxtqFtPqCrnK/uiNMcu1cYA04suNsU8YWHxlVr/jjM0WX/KB
        GvEsT3UtUUIU+QP9X1LlzPfwZ2XVVl8=
X-Google-Smtp-Source: AGHT+IHhF09ceAuQ9hnAC7Ellunc3oKMWLVYOkVv0L2i+8sqUDSUaX5IpQSVyHHGXmIqhTF6Li+o9Q==
X-Received: by 2002:a17:906:4699:b0:a02:3380:b79a with SMTP id a25-20020a170906469900b00a023380b79amr5527094ejr.23.1700936346560;
        Sat, 25 Nov 2023 10:19:06 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id q17-20020a170906145100b00a0949d4f66fsm2414924ejc.54.2023.11.25.10.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 10:19:05 -0800 (PST)
Message-ID: <d8c1681a-da7b-43c3-8ea1-6f6ba6a3677d@gmail.com>
Date:   Sat, 25 Nov 2023 20:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: rtl8xxxu: fix LED control code of RTL8192FU
To:     Zenm Chen <zenmchen@gmail.com>
Cc:     Jes.Sorensen@gmail.com, kvalo@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        pkshih@realtek.com
References: <20230912112709.22456-1-zenmchen@gmail.com>
 <20230914034015.1987-1-zenmchen@gmail.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20230914034015.1987-1-zenmchen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 06:40, Zenm Chen wrote:
> Ping-Ke Shih <pkshih@realtek.com> wrote:
>>
>> I suppose this would not be a brute force if you can use register definitions
>> I provided by v1. 
>>
> 
> Thanks for the help, now I know how to make use of these definations.

Hello!

Currently the status of your patch is "Changes Requested":
https://patchwork.kernel.org/project/linux-wireless/patch/20230912112709.22456-1-zenmchen@gmail.com/

Perhaps your patch will be accepted if you remove that comment:
"The value 0x0303 is obtained by brute force."

