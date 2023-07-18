Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF97E757D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjGRN1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjGRN05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:26:57 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321B4115
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:26:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so85989791fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689686813; x=1692278813;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X351sQi39be8sn4PlHccv90k4MIZd0LiXL0VSGtBHBY=;
        b=adJhQH40wflwylgBTMYmEPSJkmIONKLfo15lmAlYJzmuhVeO4CyqoC7B1qW4LV40k/
         HDjLi4LR75pWs+6h0Pd3dpPXgdSmzIZL7ak28XNUiOPLzuAZcOaupsUP4hDLM+HfI1o7
         umfVNXKZ/mxWdCQs0Vo1TLURs0AVTkSQ+YqVfVTuyzLiMHhcPcqQ3mQ75eAYPEjp6Tdu
         3mPgp8KcKhJlDZvqNEdQa+mgSr/ztCj2HyZpZKhm3fRecUPRRp5cQwEVBsm+14N78GBh
         3par62gIFQHgmwOfCEB1UmaV1B660TOxPrFDMOwYFVrqnedANBjVoOk0Yv35wcjrjha9
         YcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689686813; x=1692278813;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X351sQi39be8sn4PlHccv90k4MIZd0LiXL0VSGtBHBY=;
        b=gg/q6tPCRH5nhwZAxAeVutojReXnz5rlty0POzuR3cgs6AIsJDRyM9V6znNWZPuEVI
         5i0MngPF1+OOnkD/IGA3+DGdmmnlaFOpm+p0/JwDEU7EhFdwQ4hJvv/RoCW53klJTC8p
         p1HKN/c5LOdnLoXcZv7k4T44ihDqOsOb0hXwZERlU+ZG37r8tjjUDX1U7StqcaTWD6XP
         xBijjayHQjXtASho8RQlF1G5ZyryFvQ/rr3MWg31UBBxfUVCjA+DoxnmYEq86WeycClk
         xs569xSb5B60VT4wmVq94xw9Lse9qcec301AZS7himydIHf4tOMSxa0U9kWRpvqN3P4H
         yQiw==
X-Gm-Message-State: ABy/qLZHrpBQ5ZtIpTtnA5oKWQNZoBP57KBs/X4VmO2SIwAwFxf2fO7+
        zsDNOSinTuP5JyqnK+LyvRKsrQ==
X-Google-Smtp-Source: APBJJlEczm4Ia0tmozpV/Ndhe/taLPhM8dIYFd5Y9BGUB8zs6mFY/pZkwVudwwt68ESVWD+C2ohjMA==
X-Received: by 2002:a2e:3315:0:b0:2b6:f1ad:d535 with SMTP id d21-20020a2e3315000000b002b6f1add535mr10337890ljc.14.1689686813365;
        Tue, 18 Jul 2023 06:26:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id s7-20020a2e98c7000000b002b840f283a7sm494752ljj.36.2023.07.18.06.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 06:26:53 -0700 (PDT)
Message-ID: <33a26241-026a-9466-5dd6-e3202b29f57c@linaro.org>
Date:   Tue, 18 Jul 2023 15:26:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-3-27784d27a4f4@linaro.org>
 <ZLaRtrH85v4kpSvb@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH 03/15] clk: qcom: gcc-sm6375: Unregister critical clocks
In-Reply-To: <ZLaRtrH85v4kpSvb@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.2023 15:20, Johan Hovold wrote:
> On Mon, Jul 17, 2023 at 05:19:10PM +0200, Konrad Dybcio wrote:
>> Some clocks need to be always-on, but we don't really do anything
>> with them, other than calling enable() once and telling Linux they're
>> enabled.
>>
>> Unregister them to save a couple of bytes and, perhaps more
>> importantly, allow for runtime suspend of the clock controller device,
>> as CLK_IS_CRITICAL prevents the latter.
> 
> But this doesn't sound right. How can you disable a controller which
> still has clocks enabled?
> 
> Shouldn't instead these clocks be modelled properly so that they are
> only enabled when actually needed?
Hm.. We do have clk_branch2_aon_ops, but something still needs to
toggle these clocks.

I *think* we could leave a permanent vote in probe() without breaking
runtime pm! I'll give it a spin bit later..

Konrad
