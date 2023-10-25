Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8147D692A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343648AbjJYKmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjJYKlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:41:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA0C2132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:41:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32daeed7771so3627143f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698230464; x=1698835264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqLHQAQrHM/M2kTrKhBh9HGRbsUA7pR4vaPa6cf8SFI=;
        b=nujG/Npmy9RCh3WBxRUfIOxpj8VHpT+UpKjx3Z5dwV49d+tOsBoKlFWHQkai7jIlZ9
         Mc5LA5OvTBEtZiiSXgrxeS3OtsmZrLbUf9ru+ULOWxforehaVHuoJame+TrvLtBTCLj6
         QA0aQYwlI2Q9PfVIWsW3QmA0BvtdTp2beMKpMIKfXxMJIvdPWh9GBvrWRpjXlMRa1w4h
         YM0TDzBsvyXxK/bILqnwwyPd+V1nKfjJRV4atTX5hUg4qBydzlQnADifl9Y4Yt81Kiaz
         ym1fWfhmSs9Tpx+Z7VpzZ9PJVUZKCS2voY+iEZfCaiQXVCUbXeIhbylp78IHidZRFH77
         MF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698230464; x=1698835264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqLHQAQrHM/M2kTrKhBh9HGRbsUA7pR4vaPa6cf8SFI=;
        b=Vh+FjVfgLRYvC1mWhiP2EIC/43baHp0APjN8kwDh/5+7acfPu1bI7kk4a7IsgkQK6D
         btIFLLnRkdghVITdTGv6bP2kWrbEuy1dqB2wifmfvh53A+C6s+tV16ns2dni9CAWStbZ
         P93GLRyCR7mlK+LrtblFsqux0HAmSw2JEfOZPf9R7P5QoXYBWrGakVfIsYbpZVDYJi8H
         dKFhSJ8pMX/I4LuAdo2MWdDOZqxBGsfRKPN713uYMhqAb/ETBK7WCr0rb+tWKAjMVjRc
         b6iVWqERpM11JeAbOy6xS1XHpa+ft+6JzBgThARsy43EI0pDXl4s3R2nML6ge/tJIr77
         diiA==
X-Gm-Message-State: AOJu0Ywpmbu/nFf//cmnjwLVp4/pp4RizA9RInQbAlLO6jUoa49OMw1b
        PYsdxljMnN/w4kuXINPuQHXfLQ==
X-Google-Smtp-Source: AGHT+IGbgihuQ/EiX8V6PwAWankvS1PFInq14SxWoRxwUzvZJhd0hVtY4eL2KwcWTqI5fiUn+cOJTA==
X-Received: by 2002:adf:fc09:0:b0:323:10b8:543e with SMTP id i9-20020adffc09000000b0032310b8543emr10450680wrr.49.1698230464478;
        Wed, 25 Oct 2023 03:41:04 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id f7-20020adff587000000b0031fb91f23e9sm11788220wro.43.2023.10.25.03.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 03:41:04 -0700 (PDT)
Message-ID: <532572c1-c4ed-4b46-8d30-32698bcd930f@linaro.org>
Date:   Wed, 25 Oct 2023 11:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] media: qcom: camss: Convert to per-VFE pointer for
 power-domain linkages
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231024224255.754779-1-bryan.odonoghue@linaro.org>
 <20231024224255.754779-2-bryan.odonoghue@linaro.org>
 <75c4a105-b925-4d6a-8c42-38f3ab32a7ca@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <75c4a105-b925-4d6a-8c42-38f3ab32a7ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 10:16, Konrad Dybcio wrote:
>> @@ -653,11 +653,11 @@ static int vfe_pm_domain_on(struct vfe_device *vfe)
>>       if (id >= camss->res->vfe_num)
>>           return 0;
>> -    camss->genpd_link[id] = device_link_add(camss->dev, 
>> camss->genpd[id],
>> -                        DL_FLAG_STATELESS |
>> -                        DL_FLAG_PM_RUNTIME |
>> -                        DL_FLAG_RPM_ACTIVE);
> Good opportunity to inilne vfe->id and get rid of a local var!

Yeah no objection to that, this is a progressive patchset so the index 
goes away in 1 or 2 patches later in the series anyway.

---
bod
