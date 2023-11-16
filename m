Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879167EE08B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbjKPMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345138AbjKPMQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:16:33 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EEAB4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:16:29 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-40859c464daso5807025e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700136988; x=1700741788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7ycO51ysX1rSvVh6kgMekK9dYTtGQCoY0CbDQh513c=;
        b=pGJfwTbNZ9Se+hycjpkik/g1Hw3wzPutdVQYfV9UL+xlTtL9g3tKgosGATTWWEL2wp
         YvTniZfAP5CSZs9X9pBc1wOLNNpOsptgQtWsDZbr03D3XOXC3XLCq9YHRF//tYIdGtpB
         Lzc3Hnn3bYxT0p4klm2nLv5QF50vcIIYBvGxEnPy2QzaXJEZka19nUGtAOw0xT6IRa6M
         HYg195UTEZzuxCYEJYwvF7YspjKQYA79S/svAZ5RjgF4mdb8tUUzms7WzB4D6XGJzG6P
         hY7IpeZZ2VtQ5RSQQS+01t2feYU3RIpCPdXpBvk+UUUQxmUjMotPThwKc5dnc4j6sSMS
         d4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700136988; x=1700741788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7ycO51ysX1rSvVh6kgMekK9dYTtGQCoY0CbDQh513c=;
        b=ZCy9Qkn7ZhGhVZbeoUOb0qmKgXnYwbw0Ryw5EroejDbbFsJviWR1kKngmkGt1elNJn
         IHSt8hbelKUSAwjsN6KGBYfBkCj7wOKSvCmeAUjchxLE1G4s9pAyjdDU5DSgkObscAG3
         ed+zR9H7Et/UsvYG9a5hjJ3Om9+Dy7JDQj8xmsUpd5wliQ96Iv1O5h7s5urtIeFElc43
         yY8MwpCFNAZ2c3Ztk2SIwb9ipr4RTxGhK2nCYjAga3k/EKDMQjD+H9qFSvDoAzP0ONx5
         VGPFelJ0CVPOcEOagicRzu+bHiN49ZTvtn/uwBJf4mCIXv5OtDF81mIwU4ohLCVdg5zK
         U2Ow==
X-Gm-Message-State: AOJu0YxfL3Ta6HcqzNsL3gB15WqqEx2Roiqp7C0bpIbCwhv37gJh+rFU
        3oSHWio4zClO5OldNqBu67JRgQ==
X-Google-Smtp-Source: AGHT+IFczhZ8Qo9sXrqLwhZ/L63pvjx7kQ9JsWQDfDDyGP9Jbz6AyVEpdhwlDmQ1fNHduFTOS173uA==
X-Received: by 2002:a05:600c:350f:b0:405:49aa:d578 with SMTP id h15-20020a05600c350f00b0040549aad578mr12632382wmq.37.1700136988143;
        Thu, 16 Nov 2023 04:16:28 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b003fee567235bsm3501665wmo.1.2023.11.16.04.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 04:16:27 -0800 (PST)
Message-ID: <e264cc5e-6d28-4a15-8ee0-07be2d1508fa@linaro.org>
Date:   Thu, 16 Nov 2023 12:16:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 0/4] Add sc8280xp CAMCC bindings and driver
Content-Language: en-US
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231026105345.3376-1-bryan.odonoghue@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231026105345.3376-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 11:53, Bryan O'Donoghue wrote:
> v4-resend:
> - Remove erroneous "--in-reply-to" from git send-email
> 
> v4:
> - Resend of v3.2 addendum as v4 for tooling purposes
> 
> Link: https://lore.kernel.org/linux-arm-msm/20231024093919.226050-1-bryan.odonoghue@linaro.org/
> Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/qcom-linux-clk-for-6.7-camcc-sc8280xp-v4

Ping.

This currently blocks the example in the yaml here

-> 
https://lore.kernel.org/lkml/20231110-b4-camss-sc8280xp-v5-1-7f4947cc59c8@linaro.org/T/

Which in turn blocks

-> 
https://lore.kernel.org/lkml/20231012113100.3656480-1-bryan.odonoghue@linaro.org/

---
bod

