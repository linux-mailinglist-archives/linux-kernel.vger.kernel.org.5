Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDCC7B6D87
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjJCP5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjJCP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:57:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE45A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:57:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405524e6768so10841335e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696348635; x=1696953435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4ci3PGm2LPgLVtRlA44jOoVtYu71qTPmz8qC5gmhz4=;
        b=nnevNyOyD7fOj0X/cLRdrEf69etCVnC0xjF6vTrNuURucHw7KzmgunlYciE/+MSydk
         Pq7FHIwlKsNQYECfpgfqXhio7O+dngy6DCjkYSfn4RP2ZabZY089oSYGKDwjeScTKpoi
         cIvy41ZDLWWIbauJiMY7Ea9hCECOm/QUyKSnXZeSFtk+Z3q7F8frBi+QTp0AieN1iy9k
         5a11MYSXOIjhskUvkAmXYxWDn2Zkn6WitU3mWWXqXqBvH/1KDmypI9+g0G2KbftrMNlV
         Oawubbl65ASNRJIdao5oW+LwjaC4r7kApxNoqSL+3ZYZuwCW/Hc8ZNlM1GnV4DrKpd0e
         6t6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348635; x=1696953435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4ci3PGm2LPgLVtRlA44jOoVtYu71qTPmz8qC5gmhz4=;
        b=xBb1xJ/TKmjuQVg0tWKH9RXr3De/3oJezZeZpzAygSuqAv9/gHkpp1vSosAhLeHbOQ
         wMdnigXIvg4cBi1Ftq35Q8W/9a0B0btrUGChlnwQgY84XO2UR4RUq1K+0P5ugmZKVvce
         Tz75j9nz0Ec5mKBEZZOqntRhsr0MihS+DLiKJgKNvSCCvbnqsZ9VMf6+6Ry9k1mLg3XE
         BAOKRg6tQXRwKcFeoGItxwLXaMdvEqoxwwgteU0InTMPGkAm7EF871JTY8JDNgooejbG
         dEA3yy4N/GQQ+ZduerXSC/xRSdQWaS2lsdZeg0wcj7oU36TIxXUmgH2+Slg7gUQcq5Bc
         s5+Q==
X-Gm-Message-State: AOJu0YwkCF78F0zYY5JMuxQ3FfGYFFIhcGlBbsyQjaFvoBKKb8Rhyhi8
        DNwIz6qcsTQFE6ZaqdC0qdxcRzBdO00K0D5qMUXZPw==
X-Google-Smtp-Source: AGHT+IEFJi5eQZLDZbHuP8V3eVbhyktNfPfTMEhybWz6RcKN42IxH4JbcBGARfmxvNdpB/suD8I8Qg==
X-Received: by 2002:a05:600c:2199:b0:401:bf56:8ba6 with SMTP id e25-20020a05600c219900b00401bf568ba6mr11984354wme.28.1696348634720;
        Tue, 03 Oct 2023 08:57:14 -0700 (PDT)
Received: from [192.168.1.8] (host-2-99-112-229.as13285.net. [2.99.112.229])
        by smtp.gmail.com with ESMTPSA id i5-20020adffdc5000000b0031fb91f23e9sm1885885wrs.43.2023.10.03.08.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 08:57:14 -0700 (PDT)
Message-ID: <dee25d93-28a0-40ee-9ab8-f86c89428dbd@linaro.org>
Date:   Tue, 3 Oct 2023 16:57:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] mfd: qcom-spmi-pmic: fix revid implementation
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231003152927.15000-1-johan+linaro@kernel.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231003152927.15000-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/10/2023 16:29, Johan Hovold wrote:
> The Qualcomm SPMI PMIC revid implementation is broken in multiple ways
> that can lead to resource leaks and crashes. This series reworks the
> implementation so that can be used safely.
> 
> Included is also a rename of the SPMI device lookup helper which can
> hopefully help prevent similar leaks from being reintroduced.
> 
> Johan

This is.. definitely a major improvement. Thanks for cleaning up my mess

fwiw
Acked-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> 
> Johan Hovold (5):
>   mfd: qcom-spmi-pmic: fix reference leaks in revid helper
>   mfd: qcom-spmi-pmic: fix revid implementation
>   mfd: qcom-spmi-pmic: switch to EXPORT_SYMBOL_GPL()
>   spmi: document spmi_device_from_of() refcounting
>   spmi: rename spmi device lookup helper
> 
>  drivers/mfd/qcom-spmi-pmic.c | 103 +++++++++++++++++++++++++----------
>  drivers/spmi/spmi.c          |   9 ++-
>  include/linux/spmi.h         |   2 +-
>  3 files changed, 80 insertions(+), 34 deletions(-)
> 

-- 
// Caleb (they/them)
