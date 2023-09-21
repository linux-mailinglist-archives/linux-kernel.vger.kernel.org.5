Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECE17A9EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjIUUOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjIUUNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:13:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83123FEAA1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:13:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-503012f4e71so3038987e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695323632; x=1695928432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXv2swyixrrXvv0zGvrj0+c4WbYkAz74mw7u1eEONl8=;
        b=UnsvEVNvPOzDaYap1N0ht8Ttyx99Tuo0mw7lDizBmjJgsezUig9nYX1cgglSABr/rh
         rSQv2ZvBASr3AgEngN7yTaqjtUjZyDDgA730JNstHGKkGkYUrrT5NebmMB8aYmt8Wnx3
         39WJmsrY6wqzul3P5ass+oJG4X35iu5JiGDouCp89owhyFGlL+WqKQDhNt2zW+jmeAbb
         W2pNosbXzlQoItqmVsXZBJ/eldGM/Uud+Vggs46pTCjdDPHiTXBKMg11lkt2Ex83/V+l
         FX9XQbh7K6pSLfXNUTGU1y8oX3yiSwFD3NcnNsSYshUszyongC+3s1ReB7ob3cDESUlW
         3bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323632; x=1695928432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXv2swyixrrXvv0zGvrj0+c4WbYkAz74mw7u1eEONl8=;
        b=WPRUHjv1Ggk8FXFhq7L0+2YV4KGQ1bdNsn6x77YQWwtYOfLN/9FilfVyUpY5L4S0wY
         El5KpGXJTRkfe/hzZPfYL5KfRvQjFdEd4/0wKSHiBxWTwFCIfFfObYKvZQyZxlvBvR38
         6Xy0K7AhPcJg9FAMHtCHMb7OtZvizorN05DcOS/Q0Zr3kUqkoBtrc7QiP+VVdeRxvFgc
         xSnPxikMq41aegHvZWJ4zr5f+5aFpZImM0VUhtMTtJJeOnEHfwfFhQgffXTWK83T1/xr
         zEx2+pnbnV9zPY9ZCIOWZlBVdBDhUdtJYtDwSC5c8EhfZ4wlxLWHLTbPfiiE+n2p0Reg
         lcwg==
X-Gm-Message-State: AOJu0YyxEMOZOhJ0P3U5SLJ2+kbywvBXPLG328P4fmyjuFcNHh4RLUlj
        t/JTH1X5uimE0Vtr6SrHV/44xCRiSs8rkaTa8RPD5w==
X-Google-Smtp-Source: AGHT+IF33ZszVwsMibxsoJczJ31Md6SkIWFl+NgIPjyaeu55oxkozMwjQ2+h4m7DsUHVeCJrMeMh0Q==
X-Received: by 2002:a50:ec83:0:b0:531:1f3b:cb47 with SMTP id e3-20020a50ec83000000b005311f3bcb47mr7302479edr.0.1695279710178;
        Thu, 21 Sep 2023 00:01:50 -0700 (PDT)
Received: from [172.20.15.189] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id m26-20020a056402051a00b00532d2b5126bsm389571edv.94.2023.09.21.00.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:01:49 -0700 (PDT)
Message-ID: <8f24963f-a016-3095-29da-a2fcae5ec9eb@linaro.org>
Date:   Thu, 21 Sep 2023 09:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] drm/msm/dpu: Fix SC7280 PP length
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230921-topic-7280_dpu-v1-0-6912a97183d5@linaro.org>
 <20230921-topic-7280_dpu-v1-1-6912a97183d5@linaro.org>
 <3b23270c-ec89-2177-8252-6ccaf58d37ac@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <3b23270c-ec89-2177-8252-6ccaf58d37ac@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/23 01:41, Abhinav Kumar wrote:
> 
> 
> On 9/20/2023 3:46 PM, Konrad Dybcio wrote:
>> Commit 194347df5844 ("drm/msm/dpu: inline DSC_BLK and DSC_BLK_1_2
>> macros") unrolled a macro incorrectly. Fix that.
>>
> 
> No, its correct from what i can tell.
> 
> Before inlining it was using PP_BLK_DITHER macro and not PP_BLK.
> 
> PP_BLK_DITHER has a len of 0 and not 0xd4.
> 
> Hence I cannot see whats wrong here.
Right, I misread the thing..

Konrad
