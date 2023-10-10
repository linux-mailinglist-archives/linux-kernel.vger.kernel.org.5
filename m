Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2600F7C01D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjJJQkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjJJQkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:40:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EB8B8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:39:58 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso67394071fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696955996; x=1697560796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBAWc80HIYF1UAoqOKYikAPW+Uj9N8HcMer/MGjoSq4=;
        b=O3dZx92wbkcZ/v+95ZVefI43nPdOoc0hZBmeq15+R+NYyNdzKdDcEhInkIhnVHwmKj
         uruCQXZ6P1Otknv7KcjmVFLP2Px0deynmmctID+sATPcpyp6GvbYpnCRQ2fcJgS6v3vL
         /Z9z6LJ+3XLUsiiowjDOvKXAXYzVqMBJ/7iDwRbNcEB157/h8GuxQyC/Gz6FqRhXqjUl
         GLOzLMgI3d+pBSavhmqy1zBQrgIsXlR9hGStVge4gm4uqkXU4v7lTIuy6G3Sqwp8T3uu
         7lVbl/4A1A25WuFWUUIKsYX6l56igC3wIN711RyY1r+s/Irhq11w3srUGfar47ea69DW
         Lw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696955996; x=1697560796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBAWc80HIYF1UAoqOKYikAPW+Uj9N8HcMer/MGjoSq4=;
        b=bBvzxy5fSaESlYVK2HpsnRrDx4vSbLkLcUbANJ5ol8/V/iOzZ7H/17shf1lOY5j3pF
         /wtTpEx78NHU/12UoqWpewMPhMvRTvB/gCRcuMHGrUvnuC+kaDpXRMf/7NffWoxM4AKX
         DlgI8bLIOMoOJ+xlRfvS8Upj9RKUY4MP4E4FgVfNQk43kkGb7t9O5rABzqcns8uAz96F
         2BcBR7kNDACG9/346c/Tw2A6oyshKwnCrbavHeFVexmsZnwuF3v7ifUYa2Dt9ywJuGJ+
         xCYLwuy+2imt26c1aJxv1nEbqgVXEh2R7A8y+rFl1ZrftY0Ya0WcVGhKomVRF1h7vnDA
         ajgg==
X-Gm-Message-State: AOJu0Yz4MS17PWbpy2HWYV3c5ikKYYNMkHvGugQQqRzVDtxQJbhQKBgN
        vv2TNsulu6pK3y0/1d2Xh46GLg==
X-Google-Smtp-Source: AGHT+IFVDTHjOPqqbq5QIlF4ISYN6N4U+VKelAKaTIDnpNQ0UzQcS+aDmvycqldIVjgvzih4drSCwA==
X-Received: by 2002:a2e:9d50:0:b0:2c0:18b8:9656 with SMTP id y16-20020a2e9d50000000b002c018b89656mr13708968ljj.24.1696955996606;
        Tue, 10 Oct 2023 09:39:56 -0700 (PDT)
Received: from [172.30.204.182] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e9f46000000b002b9358f5088sm2482543ljk.53.2023.10.10.09.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 09:39:56 -0700 (PDT)
Message-ID: <81e4c504-fad4-4cbf-b17e-a8b9f323f1c2@linaro.org>
Date:   Tue, 10 Oct 2023 18:39:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8550: Add download mode support
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1696954157-16327-1-git-send-email-quic_mojha@quicinc.com>
 <1696954157-16327-3-git-send-email-quic_mojha@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1696954157-16327-3-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 18:09, Mukesh Ojha wrote:
> Refer TCSR phandle from scm node, so that it can be used by
> SCM driver for setting download mode.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
Please improve the commit message, like in 2/3

Konrad
