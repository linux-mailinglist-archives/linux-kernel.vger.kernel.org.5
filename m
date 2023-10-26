Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327717D818E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbjJZLKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:10:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C01AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:10:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c503da4fd6so11555371fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698318603; x=1698923403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFDGqzAkT9v30DUvgbeN8oVGeAg1rb9jZ6McermBiCw=;
        b=ExLY4rq5Qoss1JJ+oipAZHjbh8s68dSRRA41Itglw5ciSDYFm+o5qTf0sa3bQzETui
         i9UcMAZRxnQ4OtDMCfi1umkuQm7aCv05PATPYMx45SN3A8sX/tVzQTxEgpBHULL8JIGh
         3Us3pb+Sl0xLFISXP6Qr/5gJDZsfGrpmZKNFEVLsyQOYURMe+ujy9eiUh2edmWLXeKe8
         SSxfZYsCqHPEA7oWkStGKKnbQxspPqnNdGbhIP2wDMYLkSw3mDTXOymP02X5k6ZmRZzk
         eLMBmvzJvmMIWAIL74arisCUiyL8svMrIV+DM4MuHlrt6498Eekd+5aXyCpv9MKx6Rsr
         mpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698318603; x=1698923403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFDGqzAkT9v30DUvgbeN8oVGeAg1rb9jZ6McermBiCw=;
        b=YqQoW76pGCuV5iUvCUUStKhHzfQ80PcPczmAQay3fAjYEo5ILwpf33mNXjxKeXnDPi
         xj0sRfSztTn29wFMK3wrDH06NKDbiyeM1s25Z57WtBf80owsoy4MR52FsiYKcLpfdNjj
         lBa3YZ+7vfVPXwu5n1yA1vwhrF2B2EbbWAqbIzYI/jVyQ8/FMOUJoeYWh28s834C/vpE
         7A5J7hWVh00cNI+TLEkRc6MBXdJY00Don86GQqWIqYfK6e52rZr18JShGD3LHjkfPY+e
         0pWbq+J4u/MmvjxSbmcyZgDGnnZ4CE+f9oJ21FtG7v96oH0pT1NyfVB6rqGp3S47Ouzg
         xGRA==
X-Gm-Message-State: AOJu0Yyo37N10N3351kAyq3BNzWlAdKPy1x0ruX8hu0bMKz6zPAnFs1P
        qlpsGA3YtqkvkCVo6rIm81TQsQ==
X-Google-Smtp-Source: AGHT+IGZ7Bx52xZjwNOsaoIwxTO6OODdxBXVzVwSUitUkgzo3/Zs2ma5n6Xswx3q77LV4oLmE5LW9g==
X-Received: by 2002:ac2:44a5:0:b0:503:7fc:8afe with SMTP id c5-20020ac244a5000000b0050307fc8afemr12673901lfm.1.1698318603147;
        Thu, 26 Oct 2023 04:10:03 -0700 (PDT)
Received: from [172.30.204.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u15-20020a05651220cf00b00507abbaeb22sm2984919lfr.301.2023.10.26.04.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 04:10:02 -0700 (PDT)
Message-ID: <fb0647b5-67c4-4558-ac41-ee2b21446ee2@linaro.org>
Date:   Thu, 26 Oct 2023 13:10:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] PCI: epf-mhi: Add support for SA8775P
Content-Language: en-US
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-phy@lists.infradead.org
References: <1697715430-30820-1-git-send-email-quic_msarkar@quicinc.com>
 <1697715430-30820-5-git-send-email-quic_msarkar@quicinc.com>
 <20231025075603.GD3648@thinkpad>
 <610b0621-b140-ee9b-c450-0fec6862c4fc@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <610b0621-b140-ee9b-c450-0fec6862c4fc@quicinc.com>
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



On 10/26/23 07:30, Mrinmay Sarkar wrote:
> 
> On 10/25/2023 1:26 PM, Manivannan Sadhasivam wrote:
>> On Thu, Oct 19, 2023 at 05:07:09PM +0530, Mrinmay Sarkar wrote:
>>> Add support for Qualcomm Snapdragon SA8775P SoC to the EPF driver.
>>> SA8775P has the PID (0x0306) and supports HDMA. Currently, it has
>> Is the PID fixed? I thought you just want to reuse the SDXxx PID in the
>> meantime.
>>
>> - Mani
> 
> The PID for SA8775p EP is not decided yet. So using 0x0306 PID meantime.
If it's not decided, why should it go upstream then? Would that
not break the hosts' expectations when the EP device is updated?

Konrad
