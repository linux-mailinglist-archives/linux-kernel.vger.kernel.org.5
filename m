Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07687D8139
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbjJZKw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJZKw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:52:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE1818D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:52:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40859c464daso6249945e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1698317543; x=1698922343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wcf0XYPF/4Pt1WTkCKmw6RYdqKYjvunGflDfl8xXWCk=;
        b=cN611ao+9KSkXr+6EiE8PStPFjXFddtJYJAXEFCesRkZ3x+A2CCpfyMjymw7KDygy4
         gkM0kG5JR/mbLJ+h37ByfIXSaQ6bqFvICTtHc6xY282rZcXDnn1UW9MrYljyE/YNk7KZ
         HI/lzWpzQlrBn5H2fNByWW+6zs6iZjssjybssoG4f2CEds4cJSfG1R7r3ipDRubaAxQX
         S3w9GnaamCyh5QAba0RTzOGx6giU8C6NogGTlk0/7fykTjFJ1o+69nRYLLWvKetG0rtH
         ilJkwVWoY4eznvAJYZwrum4rgcNZixzE3EJF8PR70g7Gx1HzSKumhosauJdHOZ1SStiT
         OxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698317543; x=1698922343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcf0XYPF/4Pt1WTkCKmw6RYdqKYjvunGflDfl8xXWCk=;
        b=GUzwo5liHyKosGFgv7ZyEaHtvkeyhXnYve4jzo9s4S4jIGhgLIQi9tcKKFGaw/atu1
         spw6AwHjIG+B84nkIUuz6D6iQ5ufSGNdtmQjjUsA/9bmgblnpuq1piXakAz/+gZGesHP
         C3CCZTVs+2v9D/Rmt6YegpUWxQj5kGASFvphjECHtxoOCMJSHmjmizHDUTorAT5x6S46
         dZ2dw8Vs+a5o/TI8ugsU3oPg8dqRSYcMEAGHDudZaE0/Nxr3JxmDGPkZ8JyZKdYmhpNY
         8+/7tHh8LviM1S78vzlQoXNhp7Td3QHSx/7SljpSs1YrYDSuMKy2XFFGBzsB1/XdVQ+b
         jq9w==
X-Gm-Message-State: AOJu0YxeYV38n+GbPG+8AflZkiW6LLDl+Yf6s6ocm908d9wBr+gs1+27
        ZX/jULnWF24NkoJUozWIWHD0Iwy5zlzqIpVppRw=
X-Google-Smtp-Source: AGHT+IHNO8PwBg8++FTkP/gdxqiLLTOhI2787Z+RbXvW3hrzEuZDY6YEtNSQwiQJufCzPG2uzKwZKA==
X-Received: by 2002:a05:600c:4ec6:b0:408:54be:d961 with SMTP id g6-20020a05600c4ec600b0040854bed961mr13988868wmq.35.1698317542986;
        Thu, 26 Oct 2023 03:52:22 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id t10-20020a1c770a000000b0040775fd5bf9sm2229477wmi.0.2023.10.26.03.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 03:52:22 -0700 (PDT)
Message-ID: <1fcebf80-e059-449d-b889-17ca84b4fc5a@nexus-software.ie>
Date:   Thu, 26 Oct 2023 11:52:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Add sc8280xp CAMCC bindings and driver
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aef93a48cf270d5078ccdc39d95113a4.sboyd@kernel.org>
 <20231026101343.3300-1-bryan.odonoghue@linaro.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20231026101343.3300-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 11:13, Bryan O'Donoghue wrote:
> v4:
> - Resend of v3.2 addendum as v4 for tooling purposes
> 
> Link: https://lore.kernel.org/linux-arm-msm/20231024093919.226050-1-bryan.odonoghue@linaro.org/
> Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/qcom-linux-clk-for-6.7-camcc-sc8280xp-v4

Ah - I had an "--in-reply-to" in this.

I will resend without

