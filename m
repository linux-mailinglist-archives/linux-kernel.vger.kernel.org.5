Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAFF7EE3B8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbjKPPCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345401AbjKPPCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:02:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C7319D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:01:58 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507a62d4788so1315409e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700146916; x=1700751716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxqVH86X4cuXfvt9WZn0ecdmtgufJGOQ8mS6FlCKTTg=;
        b=TT3WIvoXl8t285/yu51geQxnaBFYUWy4rblGHXf271XRY+dn5okGopwRi1PeOF5V1G
         aqyuoS2szYDu/LvI20MKoLvrUtUK2sZzBIseA1U/C29nL1Tpn1pElR2gPrDAfuoKJtdc
         w/4RhrT/lV7b9nGcxP6Xzkc7Vhw7dTrnkVMZkMvcdPPJjm7Ah6r09L0yHaGrBxtWBmAr
         vftGr75080x3uW2Izb/oeNYz66B6No4NiE9vaLLI7oSSYNfA+EQSsB005iGlzbOBQUaW
         AAzewtRBjdi1A7jxQY9BRwZxpCvzvNdWkX7vGqZHjZZ9j9flItF/EGCkqCnq8QraspFl
         rbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146916; x=1700751716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zxqVH86X4cuXfvt9WZn0ecdmtgufJGOQ8mS6FlCKTTg=;
        b=iux8uO9khmGeyjpegLkiaVS31J02+WUWZal8IIZhm2JQth1l4yp36P6LS5dQO1BeM9
         geb0vDbvhyTCVailhQusILpN5MTKgrBgBQGZ6QWceHx5ct5oj97fn9FB1S9/G1K2aDQg
         s24R1hvzZh0XXfvOovJaYD40FsMDxuw9CHQ9oAfdpNma589Y7x/zDQNrlgJ1OOSp63QY
         d9yMVCgPiPdPH+0igDk7lzjzA/4psLj0v5uvCGqNERzRN5zmmjZ6F+IdM/azqCXfJqvt
         J4rEGYi6R+MLRAEF1aoHgQLn7PHc5kwwX7Hds0jPGl19UORkveoxbu85U5QPa9RJ8xvk
         0a4w==
X-Gm-Message-State: AOJu0YxWqE/R/ZgvY6dmPR9/Fs2FS+DE3Y4J4wf3a4JkKY7ND/ksRneW
        bhk+UdwZT7UKOpOSG271zjaCJw==
X-Google-Smtp-Source: AGHT+IE7vexAqvYBpf5qKBNAy2mXPg26r4KlHbQTKyhkH8y2DOhxq89FAIPla6UrhtxGpzhE1S6ZbQ==
X-Received: by 2002:ac2:4426:0:b0:509:fc7:8853 with SMTP id w6-20020ac24426000000b005090fc78853mr10278293lfl.12.1700146916542;
        Thu, 16 Nov 2023 07:01:56 -0800 (PST)
Received: from [172.30.204.128] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i7-20020a0565123e0700b00509471d41besm18062lfv.211.2023.11.16.07.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:01:55 -0800 (PST)
Message-ID: <e8dc01a1-f3fd-4c23-9607-62a199b6a2bb@linaro.org>
Date:   Thu, 16 Nov 2023 16:01:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/4] clk: qcom: Add ECPRICC driver support for QDU1000
 and QRU1000
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231106103027.3988871-1-quic_imrashai@quicinc.com>
 <20231106103027.3988871-4-quic_imrashai@quicinc.com>
 <CAA8EJpoGLCfrWQ5r8cOcqyWmF2ZTTqPxFy_HVzPC-A-dCiV48A@mail.gmail.com>
 <8a1ce949-204a-1c22-c554-67b31379eb7c@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8a1ce949-204a-1c22-c554-67b31379eb7c@quicinc.com>
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



On 11/10/23 09:34, Imran Shaik wrote:
> 
> 
> On 11/6/2023 6:34 PM, Dmitry Baryshkov wrote:
>> On Mon, 6 Nov 2023 at 12:32, Imran Shaik <quic_imrashai@quicinc.com> wrote:
>>>
>>> Add ECPRI Clock Controller (ECPRICC) support for QDU1000 and QRU1000 SoCs.
>>
>> After reading this series I have one main question. What is ECPRI?
>> You've never expanded this acronym.
>>
> 
> This is a clock controller for eCPRI Specification V2.0 Common Public Radio Interface.
This should be under description: in bindings

Konrad
