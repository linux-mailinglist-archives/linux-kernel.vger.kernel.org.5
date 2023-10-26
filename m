Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB27D818B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344779AbjJZLHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344777AbjJZLHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:07:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9EF1B1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:07:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507ad511315so1099173e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698318458; x=1698923258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nz+wA04FPf6lhenNUiyQXPpaKAqsi4awJDETCh+1Qs0=;
        b=dZnjCiGdQqNkBuAn1Q0191p1Eo7f+mrEUHVNbMnHCt82xp4rbpKVNDBcEm9JG+b3Om
         fP0CnWcWzN3wBcSp7hBYTcKY6OCHbgiUqatyoRFG0MH/GrSDP1CzwOceiRgIiWbB9kYg
         mcnz3llS/AJ0/uz77m2OCD98QZDPidv++MARMbhb2m8qR1ijuswrmVRzBXmAgPy1f26h
         +KUmCt791qmD1R3f7S4g2tPnz8dkrCiquNgqGsoJpyG89eifD2nYDY/asxrZK+C3Q/Th
         n2ji46w3dpF+oBc465QgdCDKxzQsEhtUMRmvhQCxIf/WOr8tIfQcXsn/x99Y+BjfwFU7
         ++Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698318458; x=1698923258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nz+wA04FPf6lhenNUiyQXPpaKAqsi4awJDETCh+1Qs0=;
        b=S39COIhQri2+1p1WJMYM5DLPspKYHZRiPuXJS1j70y8k4ATRszyimiyDF0lxCyuT11
         QoJq5VDKh7fx0zakI20bS2IWGHG68ugax/hV8wM0A4B6/QHFPe5/HObSfwg60Mj2cgkR
         Eep8VTc6+yJdmLqxETUbrxF52N4d4iPJrCbCuYwX+WBkCnVzpReGCMllPzlIzr7UrocC
         ZUFS+1V5C3pd7rYYClirV2XWe4SXc4JzONsMQ/DNs7H3wYL75fe/N+R59PDGCMYCTa/L
         qU1ramDRJ3p2vo3G4N1LJRut9lkm8ZINzvXfttu6JuBhAHL19J1PvAq+Fhp4qhgtMXTg
         4tIw==
X-Gm-Message-State: AOJu0Yx1WrhgotThAiMMc+6Pwv5hZPjQ94CtO+o0ULL2NKQYxqRtiI4g
        bAoggqcWlAyf9nziVh8Q34YHXg==
X-Google-Smtp-Source: AGHT+IG4jLAcGNTYqekXkUs1H6Lj4A7OmRy+1PEC3vBfbnyzxVeHpULor2PTFDDoJRlwQ98aINnPiA==
X-Received: by 2002:a19:760d:0:b0:507:99fe:28f3 with SMTP id c13-20020a19760d000000b0050799fe28f3mr12617130lff.34.1698318458678;
        Thu, 26 Oct 2023 04:07:38 -0700 (PDT)
Received: from [172.30.204.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q9-20020a056512210900b005079691360csm2978277lfr.49.2023.10.26.04.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 04:07:38 -0700 (PDT)
Message-ID: <17a61f24-3af2-4749-881e-2fbe5275b6c8@linaro.org>
Date:   Thu, 26 Oct 2023 13:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] clk: qcom: rpmh: Add support for SC8380XP rpmh clocks
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
References: <20231025133320.4720-1-quic_sibis@quicinc.com>
 <20231025133320.4720-5-quic_sibis@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025133320.4720-5-quic_sibis@quicinc.com>
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



On 10/25/23 15:33, Sibi Sankar wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Adds the RPMH clocks present in SC8380XP SoC
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
