Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1FB806F99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378051AbjLFMXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjLFMXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:23:23 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA87D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:23:27 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bfd7be487so3609822e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701865405; x=1702470205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/DzoPfWTSCdQs7IBgaNCNhvytcrfnmBWz8SmUAIpH50=;
        b=ggWffWZZE8syarCQnPoiLlt+LrdjL73MRmMimlOv0gfzxcfnHaPNTGVUqWTKlLhqkl
         VTOirlZ3uf8vDkiMiIBoe9QHCs1WrBH+8653noE6NHcmoPdQExaMHp2i2ohn6UkhFxCu
         pG+tIqmhkwU3FU7PNBMG3OC2bwwfLlEjE3SY76OgrRreYZYnmvAbaXuJC+jjWDMp5wV9
         NLVhl4p1ZDRN9GskyKCVjBV+4iZPq3hU8C5ZNY8YJv+A4PkNeQaAJzj9gS+0KCOUAQei
         1NXTvYDmpcmdOumS4oVz6TepYoFpYdEIAlY53Bfct36VzurKVYqKwxC4AOjcqBJ+DFPW
         fsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701865405; x=1702470205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/DzoPfWTSCdQs7IBgaNCNhvytcrfnmBWz8SmUAIpH50=;
        b=WXoX4tzzG5CwJroI1urnvuJ6G+Wps0ITzzlzr2mqmkybBNnazfq7TNXpO8XFv6PnJo
         EuprCsXQeSWVstApogG0pgSwY/VbHwHwtVNc4DIGpMQPArDOoCKeqA1XkbwVahSLyhI8
         WlwFds8HU3lZRlbw+/XaM28mKciZ7ntUIEmuI6nSeRSeJlEaqcvf6o2rS6dqlXJUb0wy
         hUj/Q8taolPLE3RZ3ds+834muQHoXvxqFEiOXXRRHMIN4kCJMvx0QXJ7+Caquo2XoCeU
         emn/QtKONMhmIkQ+tDzn964UoEiN6Y3Mgac55EaS7cEH4BNOyIJ1BTtpVbxkgJULvt69
         yHXg==
X-Gm-Message-State: AOJu0YxVBZoPCJ/0iknhDGi2i38n0e3bcBAdEMbQ0VpLfuQWtu6pJHIX
        OD9xI42UOxaFAlOI6Dg85KGYWGGGYsMYIYxwPbFIUA==
X-Google-Smtp-Source: AGHT+IEHcut6JD7Iz6Iiz3DWN0UgHPNJrxzg3ZHmF7UW6BWBbcPknaYhXwQQ+JjJMy0hNTFAHMQ9Ig==
X-Received: by 2002:a05:6512:3986:b0:50c:bbb:e3ce with SMTP id j6-20020a056512398600b0050c0bbbe3cemr614570lfu.112.1701865405360;
        Wed, 06 Dec 2023 04:23:25 -0800 (PST)
Received: from [172.30.205.186] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z19-20020a056512309300b0050bfc6dbb8asm755053lfd.302.2023.12.06.04.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 04:23:25 -0800 (PST)
Message-ID: <e8fdf6ca-488a-4ccf-99d9-ffa753d35067@linaro.org>
Date:   Wed, 6 Dec 2023 13:23:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: stats: Express AOSS QMP module dependency
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20231205-qcom_stats-aoss_qmp-dependency-v1-1-8dabe1b5c32a@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231205-qcom_stats-aoss_qmp-dependency-v1-1-8dabe1b5c32a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/23 05:38, Bjorn Andersson wrote:
> In the case that the Qualcomm Sleep stats driver is builtin and the AOSS
> QMP driver is built as a module, neither the implementation nor the stub
> functions are available during linking, resulting in the following
> errors:
> 
>    qcom_stats.c:(.text+0x33c): undefined reference to `qmp_send'
>    qcom_stats.c:(.text+0x8a0): undefined reference to `qmp_get'
> 
> Resolve this by expressing the dependency between the two modules.
> 
> Fixes: e84e61bdb97c ("soc: qcom: stats: Add DDR sleep stats")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/linux-arm-msm/202312061258.nAVYPFq2-lkp@intel.com/
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
