Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A47DCA64
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbjJaKIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjJaKH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:07:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7814EA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:07:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507bd19eac8so7841267e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698746875; x=1699351675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eQttKOvr5i/jpnS/yPQ5Rv08gclTUqcCJH1d+hHQS8=;
        b=HXhYCNiYJ0ylwdRnxgw7KQjyCDoceMqLw6cK0lx3hzlOAB36/T0wJ7VNdqyekICZak
         4Ge/wLsEOo1CX83hGBgF7iaAhpJjidk+HxgQ24aIlu6GeSZDqXyHPgZQFVN3Yi9P17tp
         wbZaUlLHeRJC2lPA8v68/NrVEXI9WhXpgd9CKuGBb6a62fzh3Fme+H2enGOCpLNQxPIb
         M2MbwCnZImeTC9YTHOrVzfYhBX0zIZ6ixePjvMg2OAfkf9t6DB+q770j58zCMEn8HOcY
         MfJJAeLyK3BzQJ2XGJ2PUC3CmK5aP1euFgitybXSrpcz+UVdS5nRX/R4TfRLgMX/dwy2
         Gigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698746875; x=1699351675;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eQttKOvr5i/jpnS/yPQ5Rv08gclTUqcCJH1d+hHQS8=;
        b=eD3IW9kBgCZVAkwYJMs4utGtXyAJpbOLBN1c9HtKUecvfe9AJW04uTeBQfOMbdsl2k
         mGaHlUFoj6mhuAO3UQxDtWO2XzPL+NiboDge8E+dqyYVRj7OAXq1T/Q7pu6QDxQu+SE3
         s4WbkD5MT5yXuLeIEXGypyrQGqQfIMLTvC+qY3uSMfpDcnQgl282Z9KQwxSPBrOkPdGc
         U657U3EcDD5NaJSEHKcNPh8wHRNWxFCI3W8ka/sBFqTg6yrSY8pBBay0tOQKBZgOOexy
         vCxZam651IiJi2TjjZk2jaW1T8hYJIbDkETBQ0D8pjFkNPFELKYVs50hlUHcUUzv5vIp
         77ww==
X-Gm-Message-State: AOJu0Yzgg7g1ZXt2aAgOH3cx7p6uSRnr62aSgUSP2PLvv8/Hvd89b/Xd
        s7nZvvEYTK+4Rl8Ykez7cMIhZQ==
X-Google-Smtp-Source: AGHT+IHROWO4oSUuDcfvzwEyvGX2GNEZCqIHiIHz0kxo51uGf1ijHaz2b9KgClFRCS6guqKkCSFlGQ==
X-Received: by 2002:a19:5209:0:b0:507:975f:1df6 with SMTP id m9-20020a195209000000b00507975f1df6mr8283380lfb.14.1698746875035;
        Tue, 31 Oct 2023 03:07:55 -0700 (PDT)
Received: from [192.168.143.96] (178235177091.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.91])
        by smtp.gmail.com with ESMTPSA id i21-20020a056512341500b00507a0098421sm165357lfr.181.2023.10.31.03.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 03:07:54 -0700 (PDT)
Message-ID: <9e76cfc8-c062-4692-bed7-6d30e8628587@linaro.org>
Date:   Tue, 31 Oct 2023 11:07:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/3] OPP: Level zero is valid
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
References: <cover.1698661048.git.viresh.kumar@linaro.org>
 <36de122e568dcba371d3581e5f936243b405a874.1698661048.git.viresh.kumar@linaro.org>
 <3d686b62-13a2-4107-86ff-d9753cb177fb@linaro.org>
 <20231031052627.3xuryhy3o4rk5nb2@vireshk-i7>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231031052627.3xuryhy3o4rk5nb2@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.2023 06:26, Viresh Kumar wrote:
> On 30-10-23, 19:47, Konrad Dybcio wrote:
>> On 30.10.2023 11:24, Viresh Kumar wrote:
>>> The level zero can be used by some OPPs to drop performance state vote
>>> for the device. It is perfectly fine to allow the same.
>>>
>>> _set_opp_level() considers it as an invalid value currently and returns
>>> early.
> 
>> So, currently if the device is PM-enabled, but OPP requirements are lifted,
> 
> How exactly are the OPP requirements lifted ?
> 
> By calling dev_pm_opp_set_opp(dev, NULL) ?
> 
> This will work fine even without this commit.
Ok!

> 
>> is the API currently internally stuck at the last non-zero level?
>>
>> Just trying to understand if this could fix some silent issues
> 
> Also the issue I am trying to solve here came in existence only during the 6.7
> merge window and doesn't affect the genpds linked via required-opps. And this
> commit will soon be merged.
Ack, thanks

Konrad
