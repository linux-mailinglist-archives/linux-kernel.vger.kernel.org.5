Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365C978B5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjH1RBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjH1RBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:01:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E08E1B1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:01:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so444064566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693242073; x=1693846873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDl32jJjszuVVMG76jjK9jHJCUbyMcB/0j3qE3qQgvE=;
        b=BE5cYmqsrzBI4oNggqYBdCuKBDJGyXKPblmSLEfwXZMkBJ8wTv+CZB5qMgfVB6pNtV
         syR+Xeb74pmOtPnZn9JtrTAY/ske9jOMMNY0TFaOk1fKlvHc3EK9nEd1A22a6153rdqo
         15AcRo9vJqXyi0SVH5KPCZdoYaHQY6eH6bzxqQ0hYLX+qN4fsfKRxM5aLujPC8Ms3++R
         Fy7lS+VP4+t8JSGmJAHsB9pD0EaksxmMm8jMf/63DVpTQ5QI4DZ0YmjdqO/9ypP/JnnR
         s2K/9kus0ArjoLrVTQ9kdnmPEmOlSrxFjaO8NK8XsFdnc+NwEDp4nRT8uJUHki1ZARPq
         0BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242073; x=1693846873;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDl32jJjszuVVMG76jjK9jHJCUbyMcB/0j3qE3qQgvE=;
        b=idfJUbArxaKCC563NKOb5OKd82jXKbi3FncTjJIXtrkM2IIzzJpFUue/xpf0rWDR92
         cv//BH0KMTk0drRL0kcZiXRcTypEpfjEssdPAlqZPfS2EgBVI6tPbvKD0F7NGl8WCqVu
         ZzFVfh5L8hGL6TuaCFhNjadPJ0zSHnWecsV4MWh2qWBw3dlinY3e3qmqIq4W5lWKtGPm
         MvvHwQYPjrMD9I/ofKgLGxPwLv4c+8NMW+OLyEZwaTofKp3nBsFCpaDp31L4J9ioOlOh
         ze41LUaOQKhdV3O0I3bNOe/yE9o8wkkFy3recJwqpW3FwOl+RhuHFHj3KGD0J+3qAQvr
         PfZQ==
X-Gm-Message-State: AOJu0YwSvPmPd0isLSbHK9pPla5O0irg1bBTAwkhYGmmK6FPgIs4Hfp0
        vyXtvehvkc0yXqwn1n3mrr3rjw==
X-Google-Smtp-Source: AGHT+IEq2EPjr+zpoA7thVAZ2hP39XCel/awQo4OdHftziqA+uTonj00WvkOIKOLqyPVFOl/6m/Phw==
X-Received: by 2002:a17:906:5199:b0:9a1:b705:75d1 with SMTP id y25-20020a170906519900b009a1b70575d1mr14747805ejk.51.1693242073550;
        Mon, 28 Aug 2023 10:01:13 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090626d600b00993159ce075sm4861905ejc.210.2023.08.28.10.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 10:01:12 -0700 (PDT)
Message-ID: <85e13939-a3cd-b2db-7b7c-a6c09f2c253c@linaro.org>
Date:   Mon, 28 Aug 2023 19:01:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: mips: loongson: Add LS1B demo board
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230825124115.1177577-1-keguang.zhang@gmail.com>
 <2856de1b-36cd-1d56-734a-401def967870@linaro.org>
 <20230828150903.GA499616-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230828150903.GA499616-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 17:09, Rob Herring wrote:
> On Fri, Aug 25, 2023 at 02:45:41PM +0200, Krzysztof Kozlowski wrote:
>> On 25/08/2023 14:41, Keguang Zhang wrote:
>>> Add compatible for LS1B demo board.
>>
>> Where is the user of this binding? We do not add bindings without users.
> 
> Maybe board compatibles should be an exception? They are rarely/never 
> used by the kernel so the only user will be a board dts. I'm not sure we 
> care about having every board upstream.

If someone keeps DTS out of the kernel, then they could keep the binding
patch there as well.

Boards upstream are the same useful as some drivers - allow others to
play with it and investigate.

Best regards,
Krzysztof

