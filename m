Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4E78E7D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbjHaIYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjHaIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:24:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BA1EE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:24:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a0856b4fdso628893a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693470254; x=1694075054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kmpo1/ErAHRRqxKFhgv6iSgqtQSjZz+OJOiOrDM7OvQ=;
        b=YUK8IYF+CYJf+HyE3ZrsBW47/IGXq7aQ01KoaR0Ol9h7f48lEHcQBsp8leuyi/Jcbg
         Z2oiCKD8rHgWcE5RFQaqF7P8S93duxDI8IyG3nhAEVa/UoVccpxJ10Y+MhxxonrMZZ/B
         uwKOQBvDIqz7FsRPKyjtLu9+EA5WD9yjZJgdTXMwVu/+kWaEl+Gq4FkegEtZs8IRWzr7
         5VUFABLSBO6MDcQKq8+49Y31O1uZm1NBQJziTNo/Ifg0NJmS8lZGygzmsyjcthra2COS
         MWkIXkldxbFF2t4Nc2m0AOI5yBtkCRy5aj/F+C6RCkZLBbzjNBUVSjzL4J3zo/QSfrSG
         GP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693470254; x=1694075054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmpo1/ErAHRRqxKFhgv6iSgqtQSjZz+OJOiOrDM7OvQ=;
        b=NaHtSGhwXuvG+YHOzY+b5shiaheqCWizrdBGnFmkMghnemzhBf+Hi+gqWabmc8uHqB
         2myiqInWRmKoKyYamDKCVr2lbJIUyRmDnUIMgrP0iQW35uuLx0IS1d+w9r21+2YvWFaB
         lrtIniEsfLMXhh6iVtr6R/qjER31wSxwAl2n+iX4uPDylVV8j7+J1h/icIk02zsU56Ls
         PR7fU/OWitzuvnByKRnJfCyqcEPbhw46Wku4oL1wiepTerfV2BJuLp8PszPJbWNgacLe
         dgqoQXupZlNkSK75gvO+rFjAf4XsyyP5ZMCog8i90MrsHx7AocSgtyfeJhz7mwLevdxD
         ylag==
X-Gm-Message-State: AOJu0YzMfgIj9GdrEBXAhLf/qe6dKkSW8DGG+T3p2U7P6JYWp6lg8R80
        cwfx4xv7ERoGWW9ynU2x8VJP7w==
X-Google-Smtp-Source: AGHT+IFC6xfxPRgUfLtGedyZXqC05BG1xy/YxKr4UUXAaDLlICsPHcoybdw/EPDQJJEMqrpv7WMyCQ==
X-Received: by 2002:a05:6402:38e:b0:523:4b9d:a80f with SMTP id o14-20020a056402038e00b005234b9da80fmr3182758edv.15.1693470254683;
        Thu, 31 Aug 2023 01:24:14 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id d4-20020a50ea84000000b00521d2f7459fsm509736edo.49.2023.08.31.01.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 01:24:13 -0700 (PDT)
Message-ID: <8fa0874a-1a4e-3e4b-cb14-fae67f757401@linaro.org>
Date:   Thu, 31 Aug 2023 10:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V6 0/5] Add camera clock controller support for SM8550
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230707035744.22245-1-quic_jkona@quicinc.com>
 <484fad11-b44a-0383-c34b-5ae30cd24bb9@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <484fad11-b44a-0383-c34b-5ae30cd24bb9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2023 10:20, Jagadeesh Kona wrote:
> 
> 
> On 7/7/2023 9:27 AM, Jagadeesh Kona wrote:
>> Add bindings, driver and devicetree node for camera clock controller on
>> SM8550.
>>
>> Changes in v6:
>>   - Updated parent map and frequency table of cam_cc_xo_clk_src to use
>>     active only source P_BI_TCXO_AO instead of P_BI_TCXO
>>
>> Changes in v5:
>>   - Added clk_lucid_ole_pll_configure() to configure lucid ole PLL's
>>   - Used module_platform_driver() instead of subsys_initcall()
>>   - Fixed overloading .l config with CAL_L and RINGOSC_CAL_L fields
>>
>> Changes in v4:
>>   - Dropped the extra patches added in v2, since the review comments on
>>     v3 recommended an alternate solution
>>
>> Changes in v3:
>>   - Squashed 2 extra patches added in v2 into single patch as per review
>>     comments
>>
>> Changes in v2:
>>   - Took care of review comments from v1
>>       + Removed new YAML file and reused SM8450 CAMCC YAML file for SM8550
>>       + Sorted the PLL names in proper order
>>       + Updated all PLL configurations to lower case hex
>>       + Reused evo ops instead of adding new ops for ole pll
>>       + Moved few clocks to separate patch to fix patch too long error
>>       + Padded non-zero address part to 8 hex digits in DT change
>>   - Added 2 extra patches updating .l config value across chipsets to
>>     include CAL_L and RINGOSC_CAL_L fields and removed setting CAL_L
>>     field explicitly in clk_lucid_evo_pll_configure().
>>
>> v1:
>>    - Initial CAMCC changes for SM8550
>>
>> Previous series:
>> v5 - https://patchwork.kernel.org/project/linux-clk/list/?series=759863
>> v4 - https://patchwork.kernel.org/project/linux-clk/list/?series=755683
>> v3 - https://patchwork.kernel.org/project/linux-clk/list/?series=753150
>> v2 - https://patchwork.kernel.org/project/linux-clk/list/?series=751058
>> v1 - https://patchwork.kernel.org/project/linux-clk/list/?series=749294
>>
>> Jagadeesh Kona (5):
>>    dt-bindings: clock: qcom: Add SM8550 camera clock controller
>>    clk: qcom: clk-alpha-pll: Add support for lucid ole pll configure
>>    clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
>>    clk: qcom: camcc-sm8550: Add support for qdss, sleep and xo clocks
>>    arm64: dts: qcom: sm8550: Add camera clock controller
>>
>>   .../bindings/clock/qcom,sm8450-camcc.yaml     |    8 +-
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi          |   15 +
>>   drivers/clk/qcom/Kconfig                      |    7 +
>>   drivers/clk/qcom/Makefile                     |    1 +
>>   drivers/clk/qcom/camcc-sm8550.c               | 3564 +++++++++++++++++
>>   drivers/clk/qcom/clk-alpha-pll.c              |   29 +
>>   drivers/clk/qcom/clk-alpha-pll.h              |    2 +
>>   include/dt-bindings/clock/qcom,sm8550-camcc.h |  187 +
>>   8 files changed, 3811 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/clk/qcom/camcc-sm8550.c
>>   create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h
>>
> 
> Hi Bjorn,
> 
> All patches in this series are in reviewed state, could you please help 
> to pick this series in the next release? Thanks!

We are in merge window, so please refrain from simple pings for
patchsets which are not fixes.

Best regards,
Krzysztof

