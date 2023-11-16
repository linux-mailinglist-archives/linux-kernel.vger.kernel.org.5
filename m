Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16E67EE3E2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjKPPG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345239AbjKPPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:06:27 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B990CB4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:06:23 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507962561adso1363984e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700147182; x=1700751982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfwIFk5NqNT3cPJD53cWq63VgBJ0vjZVxcUueV9o4MI=;
        b=CbLyqY5rWFv5Vb8uyDDtRcgrwEAHOWh8nqwGbQ8hwj32yvmtTmQBchBdzWo+/p8G7r
         AnRhbbg4Rf9zYIL58FTXTG40J7043PPtLP+pXSBQ79tlG19Dr04/oy7QpqrBnLVjte00
         aLuRbPfjpTzhbsNVLnz5jYI5aHXe/uZrps/0afi3Ay88YRFH+hMFgZlKRZKI36yQNW0v
         ysnUCNlkw109KJiRUTxrbOL9rzR4SyVXRWqi++8CWpuad/0SnZvOYLdtznvnZAw1bKci
         oMGuzkOo+FGW/xNjxgykoGueb43foiMZtFUJXAWuVJiB9JnfmD+HOUWv2US507qA+ZqB
         AnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700147182; x=1700751982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfwIFk5NqNT3cPJD53cWq63VgBJ0vjZVxcUueV9o4MI=;
        b=YbnOeQHh+njV9VnRBS3S0jqtAA2vw+le64kvw2sj2FgTf1HJOemY9V9/omk6v3tes2
         0ASi7MT2Gj4bOICd7c9R93n9xyyAqzCImW6A1CrVqToWQ75P8uSIkqz4CORV3Qe98fFB
         /by8a3RO77gmCR2G5XariXwPVOJ1sykdGj04xmw6PUWljChvg9SeTA1pJdnkHYp67zH1
         JY027pGR0vM3c0zFSvhk/7AD+Hl7kquEGIbjVisd0fovnLMcKNgRqsX4zw4ZkiyusI7T
         ilMn7Mea0iJCOVNRWOPkOb+Ld9Gy9r6z3xlbKiO9lJHLf8PQeCxmD/iCVvfMnj/dLPHL
         cxCQ==
X-Gm-Message-State: AOJu0Yyk/i0RZCZ4teomKCnHP40KJXYDjnaqxrrXhNTPdJUHnZgrBDJh
        XRkP9oxuej5OQAv/JoKT7uD7rw==
X-Google-Smtp-Source: AGHT+IEepac8C10E1992NN/gCMkLpKp9QW1/jwFDmH1G02vwWWWjDwQxY/mED3fLO5r8K8b3BTMS1g==
X-Received: by 2002:a05:6512:73:b0:507:a5e2:7c57 with SMTP id i19-20020a056512007300b00507a5e27c57mr11031404lfo.18.1700147181941;
        Thu, 16 Nov 2023 07:06:21 -0800 (PST)
Received: from [172.30.204.128] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b13-20020ac247ed000000b0050a3e7e718dsm19556lfp.189.2023.11.16.07.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:06:21 -0800 (PST)
Message-ID: <934f5047-c012-459b-89c9-9c5da742a183@linaro.org>
Date:   Thu, 16 Nov 2023 16:06:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: qdu1000: Add ECPRI clock
 controller
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231106103027.3988871-1-quic_imrashai@quicinc.com>
 <20231106103027.3988871-5-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231106103027.3988871-5-quic_imrashai@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/23 11:30, Imran Shaik wrote:
> Add device node for ECPRI clock controller on qcom QDU1000
> and QRU1000 SoCs.
> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
