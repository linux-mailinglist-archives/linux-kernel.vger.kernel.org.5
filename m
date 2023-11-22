Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727BB7F50F0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjKVTzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKVTzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:55:15 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D31E1B5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:55:11 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso117581e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700682910; x=1701287710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R+ZO+2LtLsspGYjkGSBImBhjSvdf0joesNI/MsWxhYU=;
        b=H4W5S2qLDfK0C88THmVO/HBWw0WcV6beKzujRt3orwlwO73MGoWlalDbHZqjUWENDK
         o0mWZL1I/fi/5jEXvp45GWs9t0FDeJz354gBynJvnPFJ7uKYjnJ6CWvJlpSfRt+7Nrcr
         8YJznNSErfFUc9BJ1t8sn+eYzlZgqrhdqRZoBWc4TKWsSBlp6OFsLNPME8Y//ZTTYddB
         qhcD46HjdNyAvyMknes+kf1W1m7ea16xcwiH48pLHF7KaCTPPYQxf4x4e3EGkFmffLLF
         HMMLeJX+S/Ehv2NF2OufO1kiQkZfv34wlW80Ex2qnJ6PeiLkkRIZ2JgydFj/VoOFkaWU
         E/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700682910; x=1701287710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+ZO+2LtLsspGYjkGSBImBhjSvdf0joesNI/MsWxhYU=;
        b=XN8kDoPpI4l9ZAQ9+Q1hJ9fKsH1F0f8Bx4AXTr7r3QfdF2XDPsUusAfZtV1lsMgF8I
         zXbVn7FpUF0MgaSl9wUO0W823g6Apw+9PODyqsGY6bcRZ1mzpbuooP89kX2No/zI7BR7
         X/gWOHFdMNlJPlS9PJEclwRnu/RwUq142SSd2grpR6cPtSKZ5dQfPUXww7ogJjzQ8zbR
         LWwxbc9KqHki4YoyvJCSszbrFqQp3OjxKAsRHSSqDl04MUjEpF0WYRC6Dhpp4dM488uc
         9o9BpT5mJB5V8zNbDuGf7hhcJfj0yL8oGTJr/ZdA7e9Y8YmhoArCyvVbYJTcIOG2KvW5
         NzJQ==
X-Gm-Message-State: AOJu0YzxuRCQaY4E1CW1oU5jbMWiH0w+ESq8xki0kbAhLIaYYbZvjRsH
        SUN8JTmvRdlpV9BVu3SCdU09Ew==
X-Google-Smtp-Source: AGHT+IEXsR07e3N354iRLZEGIb1Fw8Z0kdwblvjUdqyVTu5ptB1A29nLdcvCVUq3Tng0p0sdTDMH9A==
X-Received: by 2002:ac2:46c6:0:b0:50a:10a6:1448 with SMTP id p6-20020ac246c6000000b0050a10a61448mr2351439lfo.59.1700682909861;
        Wed, 22 Nov 2023 11:55:09 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i20-20020a056512341400b0050aaadffb49sm1327329lfr.140.2023.11.22.11.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 11:55:09 -0800 (PST)
Message-ID: <6e66875a-5cb1-42bc-86e0-b69cf73981c0@linaro.org>
Date:   Wed, 22 Nov 2023 20:55:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] media: qcom: camss: Add support for named
 power-domains
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231118-b4-camss-named-power-domains-v5-0-55eb0f35a30a@linaro.org>
 <20231118-b4-camss-named-power-domains-v5-5-55eb0f35a30a@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231118-b4-camss-named-power-domains-v5-5-55eb0f35a30a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 11/18/23 13:11, Bryan O'Donoghue wrote:
> Right now we use fixed indexes to assign power-domains, with a
> requirement for the TOP GDSC to come last in the list.
> 
> Adding support for named power-domains means the declaration in the dtsi
> can come in any order.
> 
> After this change we continue to support the old indexing - if a SoC
> resource declaration or the in-use dtb doesn't declare power-domain names
> we fall back to the default legacy indexing.
> 
>  From this point on though new SoC additions should contain named
> power-domains, eventually we will drop support for legacy indexing.
> 
> Tested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
So, this commit should be a NOP within this series?

res->pd_name isn't defined anywhere afaics

Konrad
