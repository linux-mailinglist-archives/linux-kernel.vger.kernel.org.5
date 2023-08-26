Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E30778988A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjHZSAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 14:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjHZSA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 14:00:29 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08242E7B;
        Sat, 26 Aug 2023 11:00:27 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5007616b756so3060854e87.3;
        Sat, 26 Aug 2023 11:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693072825; x=1693677625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfldtvrAuJXHHb5YdlTT28beoBEStiZCLf3yLGm9mkM=;
        b=iPu09IxGnTVqgbGdNDpfZQgG/Dxwin0diibhPciaUC9AmqL8s4CCU4ITM3VSKJ1hNx
         jHTHKSwvhgNTL6JH4OsgVpFInD0Kx0vqqu3RmWJBbsdgtM2yukMXiuhnhrbtr8l33cuM
         Y1Yx2o1Bt8JIp8lErK2auD5QpLrxZkMOgChEVMZq3uwyEO6hh7H8GBA5jXZEwM8VXM+P
         G8t4M5TVcYHBU6n7nAjQ8wHM/oJ5Q3vSxeISCyzZFfuIoIf2ygpLWmUlcrzv/WToZe94
         1zeG0ouAxxiy+BBjg0EfnFCXdvupIljHrJrAo/rdDc2zSipsgx69Em85P3R9fYVwk5f3
         79ZQ==
X-Gm-Message-State: AOJu0Yyw4ghFaF2JHYhr1bM0pnrwE4dE0Py+JbnkdSsgv824XtLAi52N
        w8EJ3ue57nKBQyIV6/nuZFz5plyaw5cBBA==
X-Google-Smtp-Source: AGHT+IH1WOvT0NGceHmGAKCM7QAa3fhBuR37Tm/+KdIWvwvD6FLGCpXWO46SHSa1W672f1U0zEmHtw==
X-Received: by 2002:a19:6d1b:0:b0:4fe:1e69:c37b with SMTP id i27-20020a196d1b000000b004fe1e69c37bmr14503959lfc.10.1693072825001;
        Sat, 26 Aug 2023 11:00:25 -0700 (PDT)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709060c0600b0099d45ed589csm2434635ejf.125.2023.08.26.11.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 11:00:24 -0700 (PDT)
Message-ID: <3c286d68-b1be-41c0-ad72-544a1a60a3c1@linux.com>
Date:   Sat, 26 Aug 2023 19:00:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/6] dt-bindings: power: add Amlogic T7 power domains
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230824055930.2576849-1-xianwei.zhao@amlogic.com>
 <20230824055930.2576849-5-xianwei.zhao@amlogic.com>
 <20230824-easiest-donated-6c0fed4e88f0@spud>
From:   Lucas Tanure <tanure@linux.com>
In-Reply-To: <20230824-easiest-donated-6c0fed4e88f0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24-08-2023 16:07, Conor Dooley wrote:
> On Thu, Aug 24, 2023 at 01:59:28PM +0800, Xianwei Zhao wrote:
>> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>
>>
>> Add devicetree binding document and related header file for
>> Amlogic T7 secure power domains.
>>
>> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
Tested with Vim4 and all works fine.

Tested-by: Lucas Tanure <tanure@linux.com>

