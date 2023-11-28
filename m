Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CE07FC577
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjK1Ubz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjK1Ubx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:31:53 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C111988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:31:59 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7b359dad0e7so10656139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701203519; x=1701808319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XKy/giFFBzRIyzsC6NU3QO7zkRURqbCQ/tW1YwEn6Y=;
        b=SiwLo2O0OhSmKDYpHILB9ohM2R3qBHSzWMgVUb7M2dWwniXNSGgCcmuJcoGePpAOeG
         S0fFFAjutdIyjJMXXNv6nA+njDrO2oOZpZ2AeUu1tFLc7QqUfMBrMDW58fbvePNvlnnC
         jXJwF/SOE3oeGUX/e21onWUce0Q/bin7331Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701203519; x=1701808319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XKy/giFFBzRIyzsC6NU3QO7zkRURqbCQ/tW1YwEn6Y=;
        b=YeP3PjCd260YJ9X3Zjo68FTdn3zcHpoyGfHh8Fe/BOz4i5LomqAGsi0kjG083ejdz6
         upKN1oByATOS/5Dsdjk1qM+fUM2BS9EklGrpps2caU8xhOZbOn/hQNqkpm0e5xwLxl7A
         EPVAx5BuDHhuCyYm/5ZnU77t8Hbvk8PAqNaqTM10D0Z8FVgirGerSNgpoapgt4LLfk0n
         Y/Pg+04DY5oi9VTda/F4LEmRGix1MxFMNmN+suj5mkoWsr+941r1i3iSIMR4rLylRXZf
         0hm7Qbag4be4KvtYQu/x8DwLoqSaVivA7gedKVif5oarAJ/ALJl1u2+Pg22ew1sy9Cae
         PKgw==
X-Gm-Message-State: AOJu0YwwPR+AkZF+80dil8EyO17QBvwfblWWttfzl8N1XS2Zvsk+2ozD
        W9RRxbz+QQPAJLhZy/buqwbX2Q==
X-Google-Smtp-Source: AGHT+IFna264rM5zePA54oe3gS4wTFePNviMXEcNhpU5WbPBZPcIwYZstfSmI2NMsYQlR27ceiOn8Q==
X-Received: by 2002:a05:6602:2e0f:b0:792:6068:dcc8 with SMTP id o15-20020a0566022e0f00b007926068dcc8mr20561718iow.2.1701203519002;
        Tue, 28 Nov 2023 12:31:59 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id q1-20020a056638238100b004596858b397sm3103355jat.7.2023.11.28.12.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 12:31:58 -0800 (PST)
Message-ID: <c9c09012-9df8-406b-a299-1310d9c626b2@linuxfoundation.org>
Date:   Tue, 28 Nov 2023 13:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usbip: Don't submit special requests twice
Content-Language: en-US
To:     Simon Holesch <simon@holesch.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231128000955.119735-1-simon@holesch.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231128000955.119735-1-simon@holesch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 17:08, Simon Holesch wrote:
> Skip submitting URBs, when identical requests were already sent in
> tweak_special_requests(). Instead call the completion handler directly
> to return the result of the URB.
> 

Sounds reasonable. What happens when a tweak_* routine does nothing
or returns an error.

tweak_reset_device_cmd() returns 0 when it can't get the device lock
and after calling usb_reset_device().

tweak_set_interface_cmd() and tweak_clear_halt_cmd() return the value
the usb_* routine they call. Don't these cases be handled as well?

thanks,
-- Shuah
