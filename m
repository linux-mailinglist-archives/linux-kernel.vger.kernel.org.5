Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489D77591F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGSJsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGSJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:48:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C9E106
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:48:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992b27e1c55so861458866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689760098; x=1692352098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sU3jr0AJabwf5kYoiJEatfT5ArWDG6nYpAUewcG/2K4=;
        b=oK2efTw4dP6roLEX+cx4lAXPUNFfMmRKMbVRXP0o938WQvLvi6t8XW9ZAaz/vYK5B6
         v+gTjjb9V5l3SRKzwGSCz8OJyGsWTKBJySV3e67r0kLJ+ZVg5zY/pistNFw9h7puYHM5
         g4U95DutrAb++k9YBjB/gt304h1wUpLtIiT/922MkIjo43viNgOf5iUiX7WgialSl1Nv
         /tG1OW5QkB5pZ8zGoIqP81szdrcAJ/oIUsaxgtThpzFHyhxnqj77XRBBmd/+RUthft7C
         CZO4vOppKCsBJTNeaDLGk0Um8lAoGNtXnwBUCIWLZSumiwy13Tp+i6UPUq57gsmZxZKO
         YXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689760098; x=1692352098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sU3jr0AJabwf5kYoiJEatfT5ArWDG6nYpAUewcG/2K4=;
        b=G3jrDyoyahonaW26zmG9EjuE3/t461ApJv1HEopIf7B89U/TcjrrM0SgrLwkodv+8v
         eVu9rafG2FaGX6TrIn55zURvzgFlqcfaebxPRmlK7j+ywXuOg28PXSY2nHGnh83FZzzD
         9ZwBfHFsFERHP/uuPbyEUm8HrMZRwE0Rk7a1hyB/BkSFQ3FBfGjyju5MAcOTO/9x3bGF
         zCjHDif4Q3CsSjazgiP6v6YlNRQ9HJ8ON13MZX9diN9Tc8iiVwA1ZyachW8pWTKV9alZ
         bGUdn20PN7ESLR40G+CtE5/z/I9wS5vrRlEJXhv0XSoipC+JnWTZqMxl/vIeoGfJAyxD
         8OAw==
X-Gm-Message-State: ABy/qLZgVC+ZgqDtxgDbxKZ8dKHnS7YNSyCV6N0oX42Vp1yuAULqZO5m
        F7p1oBJ6q7l0RViPllp4zqyhhg==
X-Google-Smtp-Source: APBJJlGlpi3msRNnmPAwQD2bynHkjap3lHKsvINLHTSLefZOMWDv13SZAB29wBHQBWBtz8h90Ovv5Q==
X-Received: by 2002:a17:907:2da7:b0:993:d1b6:61cc with SMTP id gt39-20020a1709072da700b00993d1b661ccmr1996059ejc.44.1689760098480;
        Wed, 19 Jul 2023 02:48:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b0099364d9f0e9sm2104502ejd.102.2023.07.19.02.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 02:48:18 -0700 (PDT)
Message-ID: <34274b22-29e2-09ea-e955-f00704ce87c7@linaro.org>
Date:   Wed, 19 Jul 2023 11:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j721s2: Add overlay to enable
 main CPSW2G with GESI
Content-Language: en-US
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, afd@ti.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20230710094328.1359377-1-s-vadapalli@ti.com>
 <20230710094328.1359377-3-s-vadapalli@ti.com>
 <24fa9784-7781-7259-d53a-a76a017198f1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <24fa9784-7781-7259-d53a-a76a017198f1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 11:45, Ravi Gunasekaran wrote:
> 
> 
> On 7/10/23 3:13 PM, Siddharth Vadapalli wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> The MAIN CPSW2G instance of CPSW on J721S2 SoC can be enabled with the GESI
>> Expansion Board connected to the J7 Common-Proc-Board. Use the overlay
>> to enable this.
>>

Trim your replies.

Best regards,
Krzysztof

