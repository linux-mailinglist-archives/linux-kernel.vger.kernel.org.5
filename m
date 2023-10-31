Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420077DCC26
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbjJaLvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbjJaLv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:51:29 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D612497
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:51:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso80098531fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698753085; x=1699357885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xoj9/ij8m858XjrbOdMB2crd33LEaY3jn3If3kUbcVs=;
        b=fi+aVKRgaMaF3UTLh5ISVRHZpOxOCbZ6efH1tb2NEqB62Mc3vCUgY43jBgkx8jYTI7
         mK95RnfFBIDT8CNvY8iqf5QI7+KBMBAAEdTEt/hoXI76zQV1FPhyT55JvpMYdp9GYG4b
         BgB55DjAyaiykl1wTReSHoFCcLaRjusLwulDMndHMnh+4yMy5bT127jqKXg0qaseLuJR
         hqPRxA5MfuIcFArGg3YvtT3wvOFh9S8P79zcPY3og9C1OuihqR9wpxlw/5LiJuAGn0FF
         xbF8ngT5XP2sBOxjd7uO3fH4PRpPR+Gqp3aijtiPzy96B2g0lcmwTk5HOAm25k4dGvuO
         8j2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698753085; x=1699357885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xoj9/ij8m858XjrbOdMB2crd33LEaY3jn3If3kUbcVs=;
        b=nRZct2rQ6k0A/qicxd4S2DBeRrS4kXo8fwL/Xs5ZemwSANi8g57VnE4o7VLBt5lsBs
         k+D+HSf3oYk9rt2eiy6TJS+biQJaW63KaWfg54OPZhOYT0Tqi4O1u7/dVhYvntXKL4bb
         vWBwQpwKY20+CNNVunvISxSpAv2wY3i8ZJRKF4ejcJ4v4LSsngsUBc2j9Jhvd9LYvC54
         5jrc6pF9nnVTn0nLVJUyBe0ztDW6pdQgm5JoJe5eDDClc7l10Z3lvAFzmf+bmhr7nTf7
         sP6/jTXry4l4Lhq+Xf/eqf500NZFIwvDT0GhTvkWt+ge4HkyC+M22TKHnozweByF/3ls
         YuPQ==
X-Gm-Message-State: AOJu0Yxu3GWAx9MYK5oXXjToiZyKlogxAdcJPs96OfEC6ufvj8eAG/+P
        iS4hcgTlFIjItXx8RlPL78z9Dah5abi7rFJt1a9S0A==
X-Google-Smtp-Source: AGHT+IHJ7EFZOihOlaPo2qU0G4n9/e621K7RIjJs3vOMXyjdMR/1KhhfTxs1sTlY1MqS7Elnc7NFjA==
X-Received: by 2002:a2e:998a:0:b0:2c5:1602:53f6 with SMTP id w10-20020a2e998a000000b002c5160253f6mr9966933lji.34.1698753085110;
        Tue, 31 Oct 2023 04:51:25 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d688c000000b00323287186aasm1345282wru.32.2023.10.31.04.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 04:51:24 -0700 (PDT)
Message-ID: <180d9180-2b1c-43ac-8e5d-20f0ee92b762@linaro.org>
Date:   Tue, 31 Oct 2023 11:51:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] media: qcom: camss: Move VFE power-domain
 specifics into vfe.c
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, rfoss@kernel.org,
        todor.too@gmail.com, andersson@kernel.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
 <20231026155042.551731-5-bryan.odonoghue@linaro.org>
 <d3faea2a-cc28-434c-ac10-3dd55561674f@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <d3faea2a-cc28-434c-ac10-3dd55561674f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 10:54, Konrad Dybcio wrote:
>> +	/*
>> +	 * If the number of power-domains is greather than the number of VFEs
> greater

Nice.

I just found codepsell

codespell /tmp/somedir/*
/tmp/somedir/0004-media-qcom-camss-move-vfe-power-domain-specifics-into-vfe-c.eml:29: 
Embeddeding ==> Embedding
/tmp/somedir/0004-media-qcom-camss-move-vfe-power-domain-specifics-into-vfe-c.eml:133: 
greather ==> greater
/tmp/somedir/0005-media-qcom-camss-add-support-for-named-power-domains.eml:28: 
declration ==> declaration


---
bod
