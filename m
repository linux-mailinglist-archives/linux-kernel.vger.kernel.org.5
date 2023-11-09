Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5B27E6BCF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjKIN6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKIN6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:58:06 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770652D77
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:58:04 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40839807e82so5627205e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 05:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699538283; x=1700143083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbosBewO6sn8YQ6qsTc+eHOzmL2IQ1+JtifimKJRbp8=;
        b=pR9Ny5mGS+dZdVHmvxPKbMMkTCBMbDJsnQJxpJ9ZUVTJQEo7ftzPIS8mHwZnsWfmYP
         6Fip9YSnYikDZNDRuaz7ZmmvYPzI8Ce+/dZPXTye+2JSPdWNlF4QLsSKNyq8ee+vEHJ1
         Q+ZUy8DEWxWyeggZuA8FhjpRGkOaRep12+Eib1ZZKvA3P69C14Voe+OL6fV5jItejECO
         aQhW4H+FdAntxMpT7l/s+d6AwYfLhRxp23dcPODgjMCIQtPLp4YUAdow0eo/P8FxLvi4
         h0QU57EPjDrYF0aXf0NqObEc1s+Yi/0MaOgShjBTTVzsxnrlcZ5xXqnSAEGS+kCqcxVH
         Gr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699538283; x=1700143083;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbosBewO6sn8YQ6qsTc+eHOzmL2IQ1+JtifimKJRbp8=;
        b=Odnye9b9OG8rli8iMy1xDhL9s4uX2DUcAfqry/QQcr/eySv8R6y8wlWMKG184WyE/a
         tu6zbEmO9tM7lXjXGcS22ylWZOJ44KyW0lShmIj/DnYrP6OkkhG5y9BMSG3rT0zsrXIB
         d8iHxZvf/DhE1yMLe4LIsnryubg5QfqSQ8FrFVXi6v6B3p5iykevcC47u1UG5NbCgJjS
         wVI+xXYZlS4HCPBnYx3ucOPH+eE+wvXJlckPsQruQsaV3L8tgie6PvTzPSr3R8tjO0L1
         v7nk1d3ZRzcfXg76r4vBtURsI6u2712BGTtsqQwW6MRmhsttFQVYjQiGOYZfUlBXM0/B
         mL4w==
X-Gm-Message-State: AOJu0YzWVWYalPqhSPNkz7txfi/u5OpTDIzmANog+BqwF6D8d5qEc/0o
        IsfTCOglheslxH868GTbJrrUkQ==
X-Google-Smtp-Source: AGHT+IF1UNg9lqHDFjFhxuqcIqTN1ABswd71CmIMUjOHWfOJBv+DeHRKi2Y/T8fea7smmbNiLIU8Dg==
X-Received: by 2002:a05:600c:5008:b0:405:358c:ba74 with SMTP id n8-20020a05600c500800b00405358cba74mr10749655wmr.0.1699538282673;
        Thu, 09 Nov 2023 05:58:02 -0800 (PST)
Received: from [10.66.66.2] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b004077219aed5sm2225410wms.6.2023.11.09.05.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 05:58:02 -0800 (PST)
Message-ID: <fcf81479-6137-4290-8c71-5a72d7ff5398@linaro.org>
Date:   Thu, 9 Nov 2023 14:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] phy: qcom-qmp-pcie: Add support to keep refclk
 always on
Content-Language: en-US
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
References: <20231107-refclk_always_on-v2-0-de23962fc4b3@quicinc.com>
 <8a12ccba-908d-405a-8fcb-411d50a66ebe@linaro.org>
 <65d2bba9-b04c-f91b-100a-ffb07e9b615a@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <65d2bba9-b04c-f91b-100a-ffb07e9b615a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/23 10:32, Krishna Chaitanya Chundru wrote:
> 
> On 11/8/2023 3:27 AM, Konrad Dybcio wrote:
>>
>>
>> On 11/7/23 13:26, Krishna chaitanya chundru wrote:
>>> This series adds support to provide refclk to endpoint even in low
>>> power states.
>>>
>>> Due to some platform specific issues with CLKREQ signal, it is not being
>>> propagated to the host and as host doesn't know the clkreq signal host is
>>> not sending refclk. Due to this endpoint is seeing linkdown and going
>>> to bad state.
>>> To avoid those ref clk should be provided always to the endpoint. The
>>> issue is coming only when ep intiates the L1.1 or L1.2 exit and clkreq
>>> is not being propagated properly to the host.
>> I'm gonna sound like a broken record, but:
>>
>> How much power does this consume? Would it matter if we kept this
>> clock always-on for all platforms with this version of the phy?
>>
>> Konrad
> 
> We see about 22mw extra power consumption with refclk always on.
> 
> We can't keep this property always on as there is impact on power consumption.
Ooeheh, that's not far away from a low-clocked efficiency CPU core..

Thanks for checking!

Konrad
