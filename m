Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F42187F51A0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjKVU20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKVU2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:28:24 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1041199
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:28:20 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5079f6efd64so151126e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700684899; x=1701289699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XCWCbaXqCkkqjJ8AwyXFWRYVY/K8tyc8oCsxMFcMiSs=;
        b=xESFGW1DGpXx+TIZLC8HVHOihkDdqhGua9BtlJQO8FHh0cNbXMmdB7nZe3MzJAG9j8
         G34PzW8LF+Jb1vEFW/yW+6hNvp/nxZp2JEjZ6zK2u2+yrksXPwqN4VpF9pFCFPKUY5xQ
         DV1cn7zsf9lZoiOXPdxURrIKcqwSbjfu1k38qqHu1gwSWV851RsEa2Cdhr2G5yQU5SrV
         j2vmuMWHqE3yXHc1wK4kWpRUmCccv5YIr0XuLn7oSpnwZnCawrL1GX3b4RgwCKtfwVcX
         otm0dnUcbTm7Sci+NUJinOg2ltVty6SinLLHk8ZsPE0BsECafUftkqQ0eD8duiCAD++Q
         bVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684899; x=1701289699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCWCbaXqCkkqjJ8AwyXFWRYVY/K8tyc8oCsxMFcMiSs=;
        b=JoUSKNcNdaegbQUuWzyb7Lhe/g/qay7ILrIWcwmz2NYi2SmepqL+Nk0gyrmDQ9/VMt
         EPU9TjSYNBgmaMwpCuJPbKe8VusAXNFJbd2Hd4j+dKJUkpygdmHCy7lxC81n3Eapk79F
         uvcx1+ptdSBtLk6SnhNvr9/AAbO2hCWsLumlmXl17XJ34BwonAgj2nvsvHS+IUcddAC/
         Tmg6YI0Vrjov724FaN+v+bT2Ee/ZCqLszeIamgINasZLFw1ulvmiEq6GkiiHT1W/Nhi+
         I/bZmp3gMoZEb56InhttJwih75dQSpt5OYTwlp7DRjCC4fpF231ueiE4MDE/MnxkiX8P
         93Xw==
X-Gm-Message-State: AOJu0YysHbZHQuFOsiij1B9nYnGrluwH7pTstpfFPFzl4unqf8L7O1ig
        uqnbdLng1hltJUg9GCs/A2rSFQ==
X-Google-Smtp-Source: AGHT+IGbae21R7XvRQhLLldvzkRHXG+FoNK4XFelxko3lLb2Ef3rlCohoCMoEmrQDSkEeuOqkLptbg==
X-Received: by 2002:a19:654b:0:b0:50a:9f42:9ceb with SMTP id c11-20020a19654b000000b0050a9f429cebmr2429983lfj.34.1700684899012;
        Wed, 22 Nov 2023 12:28:19 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id bp7-20020a056512158700b0050aa49aed34sm1683542lfb.29.2023.11.22.12.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:28:18 -0800 (PST)
Message-ID: <f76637f9-8242-4258-932e-b879145a5cfd@linaro.org>
Date:   Wed, 22 Nov 2023 21:28:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/msm/adreno: Add support for SM7150 SoC machine
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Danila Tikhonov <danila@jiaxyga.com>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch,
        johan+linaro@kernel.org, andersson@kernel.org,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230926174243.161422-1-danila@jiaxyga.com>
 <20230926174243.161422-2-danila@jiaxyga.com>
 <42a1d0ab-4e8d-461d-bb2c-977a793e52b2@linaro.org>
 <1695755445.902336096@f165.i.mail.ru>
 <84e63b82-4fef-416b-8dbe-3838ad788824@linaro.org>
 <c684d0a7-3336-48e3-9d2b-5c92f9132550@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <c684d0a7-3336-48e3-9d2b-5c92f9132550@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/23 16:32, Dmitry Baryshkov wrote:
> On 26/09/2023 23:03, Konrad Dybcio wrote:
>> On 26.09.2023 21:10, Danila Tikhonov wrote:
>>>
>>> I think you mean by name downstream dt - sdmmagpie-gpu.dtsi
>>>
>>> You can see the forked version of the mainline here:
>>> https://github.com/sm7150-mainline/linux/blob/next/arch/arm64/boot/dts/qcom/sm7150.dtsi
>>>
>>> All fdt that we got here, if it is useful for you:
>>> https://github.com/sm7150-mainline/downstream-fdt
>>>
>>> Best wishes, Danila
>> Taking a look at downstream, atoll.dtsi (SC7180) includes
>> sdmmagpie-gpu.dtsi.
>>
>> Bottom line is, they share the speed bins, so it should be
>> fine to just extend the existing entry.
> 
> But then atoll.dtsi rewrites speed bins and pwrlevel bins. So they are not shared.
+Akhil

could you please check internally?

Konrad
