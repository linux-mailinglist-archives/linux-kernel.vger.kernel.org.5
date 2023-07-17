Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A17755B60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGQGQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGQGQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:16:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2851B0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:16:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9939fbb7191so849565966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689574596; x=1692166596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2entuFfzv06LWf7ZDQbfS5AMpEjfwXM5BlDm2xKGsjc=;
        b=Mw4RODoz4BE+XD5UXyudGlD1SjvpGTrtDS8Nlbz+8NMBgF1UAU+2YZMkj1sMSOHEV3
         GKMh0FA7PCBGky8bkHzM5/mR55EH3QCQ5ONqhxJOMhxt2/suCeuPdEnWeJeYyGLD7qvK
         ZduxDYWE8Z19fVC0qOlAIrsK2xE0OpGTX8DGKkfIP/ItdOn4u3+KbSlf87J3yA9r6+2B
         GE8mcWp+yb/tzcp3cbeD7uqszVS+SvOIKDzf4hmhLisnDWzUzcIK5qr84QRrGofJkUgb
         sih9Gfhuus0H0+/OdLiN2EQG/DR/0nsvyDk2iIB11GcGtWi9s3Pto1Qjth+4WK5x7fiR
         U90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689574596; x=1692166596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2entuFfzv06LWf7ZDQbfS5AMpEjfwXM5BlDm2xKGsjc=;
        b=I3rO567zR3BRc43YoJQIvs/HbRds4ca0re5yPDKknRA+g+3wTMyzqJVmCCZHi0+FVR
         hSZpZN8Da82yIkv6y4Q992vazowy5xgUI63kebuWTP6/eXkew0zOKlb2ew3STOWmlMEc
         0Y/M5lpN4LdQGMo7a9vCy7Z7f3dhAD7sRpF8d64lWA3xaN0GtZXeoFg4XYes0xeEQmpi
         NVdcNCt5uldPh8slIGdg7pTl/u/PFNamTqA7g4iDralNYd2KfdWXT9y9cZ4JEDIgSYlg
         ZSFKpp6g55uioWxG4Gb2oMsnovGMzc0uEddSj0BaiiWHsdjDe88AvVrXpRBxvBGE00BO
         Fo+A==
X-Gm-Message-State: ABy/qLZuGCrxcG6l8+TE04E86soygGuf82ZEQmu3NKlIun7kx1IqTQGJ
        PtxVHZZOyrctLBWA1qpH08NpQA==
X-Google-Smtp-Source: APBJJlFSRSJ3eceIL2mLhLg4cLl56txNob5VQD1I3l8rZT/MOUjVg+APcNTJdIk8JLaOzJPhmg4Gwg==
X-Received: by 2002:a17:906:68c9:b0:989:450:e565 with SMTP id y9-20020a17090668c900b009890450e565mr9927308ejr.23.1689574595927;
        Sun, 16 Jul 2023 23:16:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qt11-20020a170906eceb00b00997c1d125fasm1416803ejb.170.2023.07.16.23.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 23:16:35 -0700 (PDT)
Message-ID: <f5ff9616-c71c-f71e-ce4a-7b9fa7055bb4@linaro.org>
Date:   Mon, 17 Jul 2023 08:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Content-Language: en-US
To:     huaqian.li@siemens.com, wim@linux-watchdog.org, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717040723.1306374-1-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 06:07, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> The watchdog hardware of TI AM65X platform does not support
> WDIOF_CARDRESET feature, add a reserved memory to save the watchdog
> reset cause, to know if the board reboot is due to a watchdog reset.
> 
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
> Changes in v4:
> - Fix the coding style.
> - Add usage note for the reserved memory.
> - Link to v3:
>   https://lore.kernel.org/linux-watchdog/20230713095127.1230109-1-huaqian.li@siemens.com

Much more changed. You added example in the bindings which no one asked
for. Then you added multiple fake review tags to all the patches.

Best regards,
Krzysztof

