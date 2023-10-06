Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF77BC0FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjJFVL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjJFVLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:11:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05ABF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:11:53 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c28e35752cso32007271fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696626711; x=1697231511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mtIQs92L5Wk31EKsK+xNGb3G5c+wYVuR2u3blviMog=;
        b=B7KXEkt6AyrIk0OInRo//f+sg/9srl1ZG5JccOyRtqzaI1f/c1HiOY5bQvl3exFeH1
         JChygW7zVaR2Nf7GSfqrp1ztjgjapHhO5gA/BYO1+IINXfKcjC1MzQ4LmLJEm3lBRjVs
         0uca2C9oX5H8zan4/EAHUrMwuerO3DHZGyHBFC85ir9r+i4b0HgnKgFvGqP2vJc3lS4Z
         A7LSVoosnL0UrNutidggocZaTt/ZydYdD4sh5OgCjGpL7wf+NwC8hpcf+iVeP9Ra0erO
         ey1FKu+INclI6f0mxH5SM9wLmaobXItyya0gaTQ3CnBUK/39MwJg3IrXdcZwUgZF17vo
         a/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696626711; x=1697231511;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mtIQs92L5Wk31EKsK+xNGb3G5c+wYVuR2u3blviMog=;
        b=ESlbzNy+A39wc5t2wbX5BDCh48TZpgjcBnPT7rUjJG6iTknxlyqfd+1g5z6NbW+aWR
         RTxWAVJGcenP/r8qIM00yXbGHktuKgnObaBXQFbYKBNTzLwuTL5EH1dElHm4rEw/GpYH
         UP7BEPt2sQOgZ5K6vMvLLMUVxQZZhLtZoIi/wzOf1B7XMdUrZq/fbXyBucf3HcGn/cho
         nNCknxKHdlfIg2Nl9uxA11XkWkPgl0DzfpPLWKCB3OSLuex+8mspeu5ue+jovNoMtw/j
         BwR2s6EkGZZEyeW6+oCytPsezUKUMBd+1MMUxrVsrAyIWRRd3nfJcPnj8MQleVwGqIyu
         K3tA==
X-Gm-Message-State: AOJu0Yzf0D+I3ZtwjU7BlDfqa4RjtjYmPWTtVUU9tmOf8vO5Z11t7Gn5
        etcIMAnAY7UDn4VhwMcSNCJzmg==
X-Google-Smtp-Source: AGHT+IFL69SO2l1xyAyTIwulLcXZAuAdP65Ry6oh3AErOFZHRz3jQ3SObXxmcFkmLuqMsktrVDPfUQ==
X-Received: by 2002:a05:6512:34c8:b0:503:3913:c2c9 with SMTP id w8-20020a05651234c800b005033913c2c9mr7265743lfr.40.1696626711118;
        Fri, 06 Oct 2023 14:11:51 -0700 (PDT)
Received: from [192.168.200.140] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id l21-20020ac24315000000b00500a4679148sm440802lfh.20.2023.10.06.14.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 14:11:50 -0700 (PDT)
Message-ID: <9b78cab5-d72f-469a-816d-6b3f86aecada@linaro.org>
Date:   Fri, 6 Oct 2023 23:11:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] regulator: core: Disable unused regulators with
 unknown status
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
 <20231004-reg-smd-unused-v1-1-5d682493d555@kernkonzept.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231004-reg-smd-unused-v1-1-5d682493d555@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.10.2023 16:17, Stephan Gerhold wrote:
> Some regulator drivers do not provide a way to check if the regulator is
> currently enabled or not. That does not necessarily mean that the
> regulator is always-on. For example, the regulators managed by the RPM
> firmware on Qualcomm platforms can be either on or off during boot but
> the initial state is not known. To sync the state the regulator should
> get either explicitly enabled or explicitly disabled.
> 
> Enabling all regulators unconditionally is not safe, because we might
> not know which voltages are safe. The devices supplied by those
> regulators might also require a special power-up sequence where the
> regulators are turned on in a certain order or with specific delay.
> 
> Disabling all unused regulators is safer. If the regulator is already
> off it will just stay that way. If the regulator is on, disabling it
> explicitly allows the firmware to turn it off for reduced power
> consumption.
> 
> The regulator core already has functionality for disabling unused
> regulators. However, at the moment it assumes that all regulators where
> the .is_enabled() callback fails are actually off. There is no way to
> return a special value for the "unknown" state to explicitly ask for
> disabling those regulators.
> 
> Some drivers (e.g. qcom-rpmh-regulator.c) return -EINVAL for the case
> where the initial status is unknown. Use that return code to assume the
> initial status is unknown and try to explicitly disable the regulator
> in that case.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
> Instead of -EINVAL we could also use a different return code to indicate
> the initial status is unknown. Or maybe there is some other option that
> would be easier? This is working for me but I'm sending it as RFC to get
> more feedback. :)
-EOPNOTSUPP for "doesn't support getting is_enabled state"?

I think this looks really good.. And will definitely help finding
power hogs!

At the cost of breaking booting with broken DTs. But as the name by
which I referred to them suggests, this was never really destined to
work..

Konrad
