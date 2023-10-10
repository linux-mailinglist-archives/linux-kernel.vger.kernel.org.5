Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA437BFE33
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjJJNnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjJJNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:42:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60151BF3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:40:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so72226541fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696945235; x=1697550035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxximMkoWGQA+uzz71VUStaHnVSe2K/WIUNaeHglvcc=;
        b=LqV+ZEePymX0b2CYVfcmrvRnvP85Ofakx8Pjdst4wUPz3S7lkMC6GuMgPueHipAj9a
         Qa9B3UvKidAUN2IURc/nGqPKVs5RbVDHBoSPhBNoLm3KCd7VtE3ULkXt/vRZoawa3hKr
         31OY5msVJ6FfyljsiancWRyaP7M+wddn5OZWmnjx2prezuxh26Tyf8EgyhDe9DvCLEVb
         6B5D70vp9NrGEYHWu1gNmUu+gcIScZqaB3q+2IsnOJ6D6TdB+i2EgvOdwcDcHPDutkxq
         V2RKJlt9s6/lgG98fRRHM9e7uALhf9Pz6x8u0q8bzxmADpnhNuLrgEdPSObPSELn9pZT
         NwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696945235; x=1697550035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxximMkoWGQA+uzz71VUStaHnVSe2K/WIUNaeHglvcc=;
        b=NKxzPTarlB9Xd0J6a3thFIaaGcpc46kbZxPoAjWbN44cCnDTpxAiFCgShxzHBxqWYc
         cwH6jFSsBH1+8dMfkbP5SYxM860fnV9wgHkrsKCg9NSrdJvm11WHNMwjhFQHgs7kFKfJ
         zVor5DCk3C/1f8z7qpilspobHziHXnBRSoCtqyIEnx/2GNJscioRq13Ov5q/JHhGzMdC
         YpdXjB+aZjirZuLvO+qQRbK1LVA/poctyr0uk0V9xcACEvqpm/0HTxpjYO8BXzI8vo5S
         Y0tteruvWP/SsWOQT7IyZgRLOnOLuG2SJ3pt/aHuTDQyBkQGcqEoDU5T6qAbPCQPUSOu
         0lXQ==
X-Gm-Message-State: AOJu0YzVvlZdItPEcCA4kRvLCchIPOdh9W+5pw07Tt6jItYRqjDyuIr5
        RYFn99GvwPU94IH5NOZsqn7IUQ==
X-Google-Smtp-Source: AGHT+IF6lr0SvRheFgchDQzYQqCJnSx8Bi6IESHLFO+fVACAqFpnSaNlGIZF0isBSwL9absMNKdW/Q==
X-Received: by 2002:a2e:9a84:0:b0:2c2:8e57:24a7 with SMTP id p4-20020a2e9a84000000b002c28e5724a7mr16879591lji.21.1696945234817;
        Tue, 10 Oct 2023 06:40:34 -0700 (PDT)
Received: from [172.30.204.192] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y9-20020a2e3209000000b002b9b9fd0f92sm2348720ljy.105.2023.10.10.06.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 06:40:34 -0700 (PDT)
Message-ID: <e255dcbd-6342-49e6-9bfe-17a47b2a3c8a@linaro.org>
Date:   Tue, 10 Oct 2023 15:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] ARM: dts: qcom: ipq8064: Add CPU OPP table
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
References: <20230930102218.229613-1-robimarko@gmail.com>
 <20230930102218.229613-4-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230930102218.229613-4-robimarko@gmail.com>
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



On 9/30/23 12:21, Robert Marko wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> Add CPU OPP table for IPQ8062, IPQ8064 and IPQ8065 SoC.
> Use opp-supported-hw binding to correctly enable and disable the
> frequency as IPQ8062 supports up to 1.0Ghz, IPQ8064 supports up to
> 1.4GHz with 1.2GHz as an additional frequency and IPQ8065 supports
> 1.7GHZ but doesn't have 1.2GHZ frequency and has to be disabled.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
Christian/Robert, can you provide a downstream source for this?

Konrad
