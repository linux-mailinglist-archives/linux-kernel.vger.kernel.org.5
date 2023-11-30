Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C37FEC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjK3KKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjK3KKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:10:01 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB93C10E6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:10:05 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54b89582efeso738016a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701339004; x=1701943804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E1qjU5JXu1SHQD4xQGaPaJAhFMnpcUVxymDQSxAyOzQ=;
        b=ijqEs8zAxhdFfTdawN2jKrK8GLI781pRySgTvoSLBVLTg6jZHc+9DfB1oDBBO0aDKU
         Wm9TUbSEqBONj7+AaW84roR0XUXu93yf+YqsHlohY8gTomUC7OgVzZeTXaBaAnoSDSwn
         vBG1FjE9Srt7g7tBJGUfeiokyeAvWGb+ZoFpBLVa4acSlbFFR0LMQOgSl1WdiRrHJivA
         cla/4eYW3uizS/TT7R+ERbJ2rY9iCZXS1lVYvHC3tp4+rUEGygQBR64tf+LklGjirXGy
         brhz3qjQLPqI0pRmt2FhpEIfHjoWqW+346erYLLMYbIjdo/M9MQXJXmbPoBasSUfmCeH
         OeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701339004; x=1701943804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1qjU5JXu1SHQD4xQGaPaJAhFMnpcUVxymDQSxAyOzQ=;
        b=oDqRpYlQ9FpcASUQ0/r7wZXepF+B//+wNWTWnmzUmAglaK4WkId78VK2ZH1O6790uW
         glkqsHZixb2JFt/ZXCjydxuQM3Ye08+j66fh/oZ6vdBPOKvCKLMxjdr1IdkZpTHVtKmY
         zsgXBIQvBklE2x7cCBZ3TFKUrNvtWDpNUCFHshVT7Ek99YxJ6TjV2inVY5EpUnmfvBxH
         nf9uD/L5UOKiuBKK6r3z565XXjS3TY/EGOtPvinINxXZpGM3b7qDMWvZiCOK2D/BB/AR
         MueGlYa2jxtmY0pbwTf+UcqRhj2DtfgpLH+mPt6ZXCu36AGbNPKlg8eFIYqOsJgV+GAz
         hQHw==
X-Gm-Message-State: AOJu0Yzmn+2mV2SC/gEc60fyo3tQ4mMIBbU+a83TsXUXf5ka5GxVoNp3
        3YGpSFzfLo62w99n1pF3e80QSg==
X-Google-Smtp-Source: AGHT+IF/jgdSK4dsxLW+CHiaLQG7uE1vQq6/j3ab/pmaLpRz4Scp96/aZfQSgXqDVz21yXWypQxVVw==
X-Received: by 2002:a17:906:73c7:b0:a17:d319:df11 with SMTP id n7-20020a17090673c700b00a17d319df11mr2272934ejl.59.1701339004233;
        Thu, 30 Nov 2023 02:10:04 -0800 (PST)
Received: from [192.168.209.83] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id r21-20020a170906281500b009fca9f39e98sm504965ejc.26.2023.11.30.02.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 02:10:03 -0800 (PST)
Message-ID: <a9c2532a-eaa6-4019-8ce9-5a58b1b720b2@linaro.org>
Date:   Thu, 30 Nov 2023 11:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, quic_shazhuss@quicinc.com,
        quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com>
 <1700577493-18538-2-git-send-email-quic_msarkar@quicinc.com>
 <20231130052116.GA3043@thinkpad>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231130052116.GA3043@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.2023 06:21, Manivannan Sadhasivam wrote:
> On Tue, Nov 21, 2023 at 08:08:11PM +0530, Mrinmay Sarkar wrote:
>> In a multiprocessor system cache snooping maintains the consistency
>> of caches. Snooping logic is disabled from HW on this platform.
>> Cache coherency doesn’t work without enabling this logic.
>>
>> 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
>> platform. Assign no_snoop_override flag into struct qcom_pcie_cfg and
>> set it true in cfg_1_34_0 and enable cache snooping if this particular
>> flag is true.
>>
> 
> I just happen to check the internal register details of other platforms and I
> see this PCIE_PARF_NO_SNOOP_OVERIDE register with the reset value of 0x0. So
> going by the logic of this patch, this register needs to be configured for other
> platforms as well to enable cache coherency, but it seems like not the case as
> we never did and all are working fine (so far no issues reported).

Guess we know that already [1]

The question is whether this override is necessary, or the default
internal state is OK on other platforms

Konrad

[1] https://lore.kernel.org/linux-arm-msm/cb4324aa-8035-ce6e-94ef-a31ed070225c@quicinc.com/
