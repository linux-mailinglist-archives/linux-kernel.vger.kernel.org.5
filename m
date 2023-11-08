Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235A17E5304
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344004AbjKHKGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHKGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:06:21 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E101723
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:06:19 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77a453eb01cso436284185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699437979; x=1700042779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rr7gS752VmDAnEEC2uCNu6BHcbWN9XZEmhatGiJJf1A=;
        b=oWFkTutFxvQq6N86TQjSF5P/JEESnp0OXvRK+kS4lbEIQcoNBum9JQT1+l2DHKmYc7
         iUlY8QqpuWk1bst4hsNbgFo0fNVfuzdDW56NZXL64Fr1nm5lKANcKOtQe58/RH6sILIn
         x5d3rQExSc3wvwzteygysIb3M8sD6IYUAQmSMCZIWPWUrsWq4Tol/vws/KkumnGhphOw
         dsaEI9GUW5kpykmWu/F69yrVUlVcb1r+nfxni1T1VS251ioWmZa5k+PfAfaxPjx1Nfia
         rvC0JjQnyEmo9WPfCz/vuRF92bbKABSc+8B2SmoJz2jpkBVa0VeSSa+8zo2x28ONVJKm
         YYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699437979; x=1700042779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rr7gS752VmDAnEEC2uCNu6BHcbWN9XZEmhatGiJJf1A=;
        b=DfMKQBT1HJOl6Cey2Ekg81CwS4KC0MjD6MqTxUajvbZc+llrwuyPtbIceCe9anypHA
         VNrFz6z4vQU54KRQOg4+VHVYiP1rNZqDpplBoj5omHwZYO+pbS7Li+2o3WNcIk1VrUjV
         x2ZgKUAzHCvJOg41dyhwI0dfSJIKcFfPY6G93m4qkDjNOlYfBHhn4/huFVSMfVqktVnB
         AjKpPYlb3ydbomwELFj3uftGjmw1aWHhPOQZpD08w3ZffVjhcl/ndM923F9luzBXwvI7
         nS4uduJfb+A704HSL8jq9wBGDMpH9rcqjzXJm6rL3AHjTng0HDLN4ZVicQc768ZMeofF
         VCVA==
X-Gm-Message-State: AOJu0YzvPVWjeIFyCbO4pUuDxVh9XCbzF1ob6lKmuFxeNg3FdVWnan8z
        D9YBc6VQ600RdZuBLScSnmDs23mJB78xKiIbH+izfA==
X-Google-Smtp-Source: AGHT+IGx7lgqtx9S/oyIp/5xMeMdu5UbG0dUZcFvMTcnc6s3J0nohJbZResltcIJRIscBeM3h7M0qQ==
X-Received: by 2002:a05:620a:4055:b0:77b:9a8c:b0b5 with SMTP id i21-20020a05620a405500b0077b9a8cb0b5mr1278087qko.57.1699437978763;
        Wed, 08 Nov 2023 02:06:18 -0800 (PST)
Received: from [172.30.205.23] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w2-20020a05620a0e8200b007789a3499casm858664qkm.115.2023.11.08.02.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 02:06:18 -0800 (PST)
Message-ID: <8f7db00f-aae0-43d9-bd6a-47374a91d546@linaro.org>
Date:   Wed, 8 Nov 2023 11:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: Add LPG LED device description
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_huliu@quicinc.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_fenglinw@quicinc.com,
        quic_uchheda@quicinc.com, kamalw@qti.qualcomm.com
References: <20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com>
 <CAA8EJpogiYXVPCNXSu+kq29nbn1uxGDAYMn9+qk8CwDz0bfyjg@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpogiYXVPCNXSu+kq29nbn1uxGDAYMn9+qk8CwDz0bfyjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/23 07:59, Dmitry Baryshkov wrote:
> On Wed, 8 Nov 2023 at 08:05, Hui Liu via B4 Relay
> <devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>>
>> From: Hui Liu <quic_huliu@quicinc.com>
>>
>> Add LPG LED device description.
> 
> No. You are not adding "LPG LED device description". You are adding
> definition for three LEDs.
> 
>>
>> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
>> ---
Aside from Dmitry's valid comments, the subject is wrong.

ARM points to arch/arm/ (arm32) and you're missing the name of
the file that you're modifying. Check the git log for that file
to get a grasp of it.

Konrad
