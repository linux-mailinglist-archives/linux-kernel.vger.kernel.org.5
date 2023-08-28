Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7D78B48A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjH1Pey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjH1Pes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:34:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF63EA8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:34:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c6cd238e0so2766739f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693236884; x=1693841684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONKM10Wmc3NrfrZ+9H0DuQyG8/OjRH71zbSgD3QHX3k=;
        b=kcUS+UEHkA3KajEFjsPuuj7eleSPye8oZm9O+fA7GNfU/eG20PDEQHEWNiu9apYeEI
         Hdj3QqOPaIQXQQ26TyfmGRV9wAXCPbmO/OvfezX/HQhM7FhqSRkQyXL5pYPnq8hP21Js
         4DZAbcs986ghZqYr5OtcIb2/7wj65fAZkDEN8TPKd3yusx0BsY+7tFmUam6Dle1xk+56
         qIO8u1NI5U06W4kbW9oIzhbGVpFxTgRcztudRD1mFY+L0du39ZbQc2qIbfiy+w4GlNU9
         IZxrw2+iNKexGtKbT3oYW30dngZMU1n6OwlNXSc49PJ273U3NyFGF373RYzVSZDrJSZn
         dEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693236884; x=1693841684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONKM10Wmc3NrfrZ+9H0DuQyG8/OjRH71zbSgD3QHX3k=;
        b=aAac2k9IMU/t9b2VRCGQTaIIOWibi/S6nWv9JgF8FOo/4C5sFKwRTmnKqhJfr05if8
         dvEUhFkzuujDRzNu9bQBhC1J6hxw4FwAnKbWL0UpOQwK3OjCtRwNqb0Ag6xLV/3SRjrN
         ei8q/FI2+ldoLaEuYZUaxNAfLZ2SecCjhgG9Aos2kXS2SSlx26i9T6I41xbNLefqB1Ze
         cD/JBZD19rVZpqpt5In0qsDHwC5gihEQSvFvGbgQiFsFq1DxXClNJAp+QDJ/v17aPyKW
         MjxoYHyWgjwjSgTQAf0T78pzI7ABjXfgieFKU1dHAeb1cnHuDj9L3wg1K2dipOjFt88z
         zDNw==
X-Gm-Message-State: AOJu0Yy4KnriyT5IPQkmB13zkoeIcoySItH72gthkltlwpjODumATA2+
        EtpkYZwoTo2xLlbQ8BSD1ddZKjU2mUrrXq4gUSI=
X-Google-Smtp-Source: AGHT+IH06t7aqZTIv+J+ouKvEaxICnWCrVM2DQhFTEFAypp/UEMw7EcorLIgH59N6d9pBifiywVpGw==
X-Received: by 2002:adf:e849:0:b0:317:a499:72c8 with SMTP id d9-20020adfe849000000b00317a49972c8mr17274656wrn.1.1693236884282;
        Mon, 28 Aug 2023 08:34:44 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c028c00b003feef5b0bb7sm11120746wmk.40.2023.08.28.08.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 08:34:43 -0700 (PDT)
Message-ID: <b4545982-af6c-5460-d662-36b0eb80bb4e@linaro.org>
Date:   Mon, 28 Aug 2023 16:34:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 15/15] media: qcom: camss: Comment CSID dt_id field
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-16-bryan.odonoghue@linaro.org>
 <4929aa72-a134-4eeb-850e-46d9255c011b@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <4929aa72-a134-4eeb-850e-46d9255c011b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2023 11:18, Konrad Dybcio wrote:
>> +		/*
>> +		 * A value caled 'CID' gets generated internal to CAMSS logic
>> +		 * which is a concatenation of [vc:6 | dt_id:2] hence we reuse
>> +		 * the least significant two bits of the VC to 'stuff' the CID value.
>> +		 */
>>   		u8 dt_id = vc;
> And where are you discarding the non-2-lsb?

At the assignment of dt_id

vc:6
dt_id:2

=>

cid:8 = [vc:6 | dt_id:2]
vc == 00110110
cid = [110110 | 10]

I have no more information what CID is or how the bitfield is populated 
than I have already indicated in the comment/commit log.

---
bod
