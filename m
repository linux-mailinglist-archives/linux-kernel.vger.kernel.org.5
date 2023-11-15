Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED43D7EC921
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjKORB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKORBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:01:24 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD47A181
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:01:20 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c6b30acacdso91542071fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700067679; x=1700672479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nr6vuhfPEics7daBdGQpqD1rLR5BjzbdvN+08xBD+q8=;
        b=QGvruKs4/M2s/JEMLUSmTOepfGU3iE5Uw63UVoqWT/82bWcG5zyzxUGtek61VTtFdj
         5mZe254Corp/AUkNPano3h5LgmVJTbLniLw5+1u7bYsQmxx3jag4sY+tf4qFhxteMZH7
         4ocYm2OWASR9xzIYDVjlSLDMh6OMjIwmCJk2u4lA9nppVXCRH4m9UENmWsVjWD2r24lt
         rcdH2uJJp/eTXa+Zn8YkXAurhaRA2nCUIoWaN+32JCJE6f8oMcl11Kw3TXgySHnU33yo
         QYaURXUkVo2NN2xNcN2PMMXfitjyrXKbE+nJT7hNlO2FHTWZy4i3+EztemSj+JfY03wS
         rTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067679; x=1700672479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nr6vuhfPEics7daBdGQpqD1rLR5BjzbdvN+08xBD+q8=;
        b=SM3uV9faAw/Ax6vtfkhsOcz3HEVXPOUhIiCQvsEhRU7qH4UwllorOWCV70fy1PkS4c
         NZTw5aRoA0djK6SykRfr1bL4AZMxVvBo1aDIL4/UUlKAXPltjnUx2+XPwoosfPlRtpzZ
         1u1HCe+pIxjzByIMq5KKEU8h75k0Ky6Uvgn8O9iyRnLopfMArPDokYWVf4jA4NhNi5W7
         ttWBl9U1RIV2Xc7NC1r7eiSU/nzUkQfimNJ9RCzGtT9BWbplgfEvh41XGeC14ZgiRSs8
         S0dSGN0QwLTe7VMA1AO7hrWKWwYDQsA4k1lbujwrNVPCQr387qS3lkL97Y7wO9ZsF/fB
         JY0Q==
X-Gm-Message-State: AOJu0YwYfWV3I86lVQHmUFE0kX+bE+F8lggj50zmZhz5W257PKO7Xf/9
        f0ctICt5E/3axdKlNa8sn7dSAQ==
X-Google-Smtp-Source: AGHT+IEPUYkKyHBiFfTLuh8TKtrGvK9xxvJ/BsN6m2FxavNOkoOEWZwhNsaG6LdlbntqkUILzUlnCw==
X-Received: by 2002:a05:651c:1a24:b0:2c5:2eaa:5397 with SMTP id by36-20020a05651c1a2400b002c52eaa5397mr5131497ljb.11.1700067679053;
        Wed, 15 Nov 2023 09:01:19 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h24-20020a2eb0f8000000b002c00da5c522sm1716220ljl.78.2023.11.15.09.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 09:01:18 -0800 (PST)
Message-ID: <cb4131d1-534d-4412-a562-fb26edfea0d1@linaro.org>
Date:   Wed, 15 Nov 2023 18:01:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] net: mdio: ipq4019: add qca8084 configurations
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>, Luo Jie <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
        robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-9-quic_luoj@quicinc.com>
 <a1954855-f82d-434b-afd1-aa05c7a1b39b@lunn.ch>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a1954855-f82d-434b-afd1-aa05c7a1b39b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/23 17:20, Andrew Lunn wrote:
> On Wed, Nov 15, 2023 at 11:25:14AM +0800, Luo Jie wrote:
>> The PHY & PCS clocks need to be enabled and the reset
>> sequence needs to be completed to make qca8084 PHY
>> probeable by MDIO bus.
> 
> Is all this guaranteed to be the same between different boards?
No, this looks like a total subsystem overreach, these should be
taken care of from within clk framework and consumed with the clk
APIs.

Konrad
