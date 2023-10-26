Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FECA7D891F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbjJZTqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjJZTqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:46:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EAA1B9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:46:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507c1936fd5so2783923e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 12:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698349596; x=1698954396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jowQ11rUSpjVGyVsG2uzn3kgeh+2aiSTzmMO92O6Apw=;
        b=WFz+R3+i2HwpbhhtQ5TGU2kyH2vrdkoAU5KjG6FBfp3eJQ7upmS20eHynyuUa6p4wN
         4RGoqHYHhGZ5IdLEdG++E7uC7GEXnKNbnNkE436Zuq/CZHRqJhXAhfPLpTDPieguiVSW
         BWsUM2XnPMvwzyOFuCOlVLyUIND8TJlgH1mNygl2CtnhMkHpbVH5oNWU1qz9gk1zyPtE
         WwWo9YYQbdiVoSmJtnIdJcN3tfFD5sQpEeZtETPgCPTmJB4sPtBCyAGdyM7tHDhNvL6x
         5fnTWFnXPz2mw7T4TTHAbZ0Y0+PGVT4o3dc4Z65d4ScmiKgN6Jcz8iosxgc0fSP4ngnh
         4bTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698349596; x=1698954396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jowQ11rUSpjVGyVsG2uzn3kgeh+2aiSTzmMO92O6Apw=;
        b=aXB6N2U+7GUomyfQwftDjaP/N+wc3XIle/1mMzd+lsmu/MaaFSCYMzN6vY/AQ2B9W6
         cfcgGZ5eLahS+vlgR9XDJAY7Xl/riXRhmxm4vcvOka6w8RhFQmTSs4h7Q7hc8TGKQAws
         umfybmtA5d3AJTyFajgP/IwrKs6fY1mnGwoiefTbUyBAX43ZC4YQa7fyXOVbmhWE03n3
         jHB1937DlGzU9LJmsYrgRAGy3WIH3kIxDWap9nJINKmaL2s1k65u6GiaMlUC4KduKUGJ
         iJR3NooaIGO65AqSPeIx+RKUqyBQDFOr4cAW+MDPcjCuFFE6gGlPQo7q8mFlyai1IFn2
         4D6g==
X-Gm-Message-State: AOJu0YxseC8omc6ubF1R5i/ba1dehBMfKu5Xz6nDjaJxioaU7XtWrQku
        bmTUQGEKF3GeNcuWuCvdWty9cA==
X-Google-Smtp-Source: AGHT+IEAXIVB5mbCR7PclkPeND1uvH3i5XJyIYmeyAfsCHXbf4KIgbyJXZJAdtdgFvw2zUI9zMphKg==
X-Received: by 2002:ac2:5ecd:0:b0:507:96fd:e4a9 with SMTP id d13-20020ac25ecd000000b0050796fde4a9mr220274lfq.29.1698349596178;
        Thu, 26 Oct 2023 12:46:36 -0700 (PDT)
Received: from [172.30.204.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512315000b00507b1b8cef8sm3118728lfi.253.2023.10.26.12.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 12:46:35 -0700 (PDT)
Message-ID: <aeaabcc9-0a7b-4325-851a-09383160ad0d@linaro.org>
Date:   Thu, 26 Oct 2023 21:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: Add USB3 and PHY support on
 SDX75
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dmitry.baryshkov@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1696327472-21776-1-git-send-email-quic_rohiagar@quicinc.com>
 <1696327472-21776-3-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1696327472-21776-3-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/23 12:04, Rohit Agarwal wrote:
> Add devicetree nodes for enabling USB3 controller, Qcom QMP PHY and
> HS PHY on SDX75.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
