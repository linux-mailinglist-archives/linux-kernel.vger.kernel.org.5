Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE67C01DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjJJQlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjJJQln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:41:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45449D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:41:41 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so70272061fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696956100; x=1697560900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eXnEfxjvluj2ls7P91GLCGn8R1ORvibeOsisML1eFU=;
        b=NjdDDmyBTCjygBZJAU+NRwRzl3ex6HJG9YfrfrTpOYoShqxdPuZtOqtlmxin+mbOJ3
         u4fFmpaTvK8xF11J3mTcfcw133QmdBBryJoDVYRZ8G6P5DWiLLpYwfu+2wp/DuybIxiQ
         YVLoGoQtW8eMQVJ4eTl/kizr1DnWqa9iLdWpwvQHw99Xxj2hOzFB+7H4C65pFmAS/4qo
         KnzQYJe2EJsybQQ/Y7Fk2d/oQmL0mD1PhQdx+1p4EXCIVTpTL2JMlJeCiWrZkkHApHzY
         sut2SG5fl20NC0Fg2fCHYZ9v1khyrylm95+ZifXftj3hYvddu5VIG4Dja0GyQfzribKb
         DdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696956100; x=1697560900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eXnEfxjvluj2ls7P91GLCGn8R1ORvibeOsisML1eFU=;
        b=RoAFwkXd7QRFbxaAeHqxBXYonWjjxtua8WYUmTyS1AzPPJePnLz6Rwy9evWXwUctvp
         vP1CigWm3tpI7VymaGReKwawpxppzLvd4x5afywBCe6DH/qmFxg+6H+GXvk3Pr1sU/bX
         rRelcfneHZHVoVyih0MhJQEk17JcVsoUxcKn4yurCjZevnLHlDepTldOA+o/OQE31kJC
         Fwk4ZDv5k9PzrW62ORxRDLU2fyzagqMGrHhuERj8rYO6WQU/SlJRoIE6kfJ9UCJeQa6t
         08v403dv/WEwdaD/od4PU+MVGqqKPUjG5uhqx9tASAdWU5V7G/g1yBgsbtY+V7lgcG4b
         NQeQ==
X-Gm-Message-State: AOJu0YzNvs/wbDr/moctCpoQ8yTOQDZzckBUQHawg4uMdzfHe81AO6r4
        qfBzNffqsdS9cFMPTkYREkHi1Q==
X-Google-Smtp-Source: AGHT+IHOV7TgUKuKP3wlsPK+xePcD91eowpwyzmYcOf3UNIyI6vjz4PdeVrDSdYUNwTDPfkjwi7i9A==
X-Received: by 2002:ac2:5dd0:0:b0:506:926c:9b0d with SMTP id x16-20020ac25dd0000000b00506926c9b0dmr7597643lfq.20.1696956100067;
        Tue, 10 Oct 2023 09:41:40 -0700 (PDT)
Received: from [172.30.204.182] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y10-20020ac2420a000000b004fe2a7a2ee2sm1866668lfh.160.2023.10.10.09.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 09:41:39 -0700 (PDT)
Message-ID: <855e5504-0571-4f8c-9644-21ceb40e1132@linaro.org>
Date:   Tue, 10 Oct 2023 18:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 3/4] ufs: ufs-qcom: Add per-cpu PM QoS vote support for
 ufs
Content-Language: en-US
To:     Maramaina Naresh <quic_mnaresh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com
References: <1696952947-18062-1-git-send-email-quic_mnaresh@quicinc.com>
 <1696952947-18062-4-git-send-email-quic_mnaresh@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1696952947-18062-4-git-send-email-quic_mnaresh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 17:49, Maramaina Naresh wrote:
> PM QoS per-cpu framework provides performance requirements for each cpu.
> 
> The per-cpu PM QoS framework will provide the corresponding interface to
> collect the resume_latency request of the specified device and provide
> it to the runtime PM. When suspending the device, it will consider this
> requirement and decide whether to suspend the device.
> 
> Voting will follow below sequence.
> 1. Vote for maximum latency S32_MAX in driver init.
> 2. Schedule a vote of PERF when a transfer request is received.
> 3. Update the vote to S32_MAX during clock gating.
> 
> Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
> Signed-off-by: Maramaina Naresh <quic_mnaresh@quicinc.com>
> ---
Is this the same patch as 2/4?

Konrad
