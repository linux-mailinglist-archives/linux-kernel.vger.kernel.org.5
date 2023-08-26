Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C47E789685
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjHZMIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjHZMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:08:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534BEE58
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 05:08:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fef56f7222so16358035e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693051715; x=1693656515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2M0LggccXcC6gesR9wGYa54V5Vi7FH9LbdxYWxiiFI=;
        b=Ura6oAW04VdSQq3nXSnF7cU8IW3prS1IUsfYkKAZhqbU1cupnuqI6Sag7d8FNlrJiH
         rBvhb19wa8532PT9bsBGvP5onxk6EtxHuF5wO/s40lOad1q/0SjejIN83H4xIPAtaucr
         3bm0y1nDvItEPB9ZC96rcvXUVghYAVJAwzbT7Y1CKeJbu4CppLA4h+/xobfSgomp1kSh
         NbGURKvWQPqwubOWJlGI/sF/5YZtq8ACIr9ZnovyAGdtr6s2AoIX3qbHQn6USr0VuU+6
         8gEj5OVyOfkJuPU3owDEomrOVHdYMc95zmfTi6jSc7/xo7EWKvcle+s0S6GXPDxBDFEJ
         22ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693051715; x=1693656515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2M0LggccXcC6gesR9wGYa54V5Vi7FH9LbdxYWxiiFI=;
        b=TL3n7lAFJpE326OiMMSOO3w47ep/JWMzWtOfStSB73gQlTXyNfulFx1Zi6/OiK5hEg
         d5c2z3c2rSuRPo5khfe5NotStpF76u/aIGD0gOviKqh5BJBcgOcekr75tKbSy8OaiOgo
         fwGnX1EcMWhZLleTWDI2Wx/iLfs8/fenAVxYmkrpG082gedWOCiWHtT3KNh7SAPMRa0g
         ItZo/lwxB6a1k6qB/6qHfTfvtOAak6Qgc+4IBOmJ1XwIJqDKrFzaqRmJQ1YkDsG+1zUT
         NsL7eypZoBvtumLRBmInECyr1PzX13yEK4gWYcvplY9RzBMpA4sRbPiMHxktkIyj7Nt0
         5A/A==
X-Gm-Message-State: AOJu0YxM449KXiXwkGOzGlTo+9IMpMKhbOIyQ1muVGiGicX1vhxPYDas
        +J1IWnF4zdyU4W4BOFhXwRswcA==
X-Google-Smtp-Source: AGHT+IH2RwTO1noQFnuQ7W5+q9IDm34GkEp2JGnt5ApsvegNezpS219duVDvY1tprhWw8v7b2Nja3Q==
X-Received: by 2002:a7b:cd87:0:b0:3fb:8284:35b0 with SMTP id y7-20020a7bcd87000000b003fb828435b0mr15839017wmj.30.1693051714877;
        Sat, 26 Aug 2023 05:08:34 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s11-20020a1cf20b000000b003fe1a092925sm4781644wmc.19.2023.08.26.05.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 05:08:34 -0700 (PDT)
Message-ID: <5714055d-84b9-f60b-ed58-77d86722d71e@linaro.org>
Date:   Sat, 26 Aug 2023 13:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 12/15] media: qcom: camss: Fix support for setting
 CSIPHY clock name csiphyX
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-13-bryan.odonoghue@linaro.org>
 <6f381a9e-9aac-4a3a-814e-26a230026d66@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <6f381a9e-9aac-4a3a-814e-26a230026d66@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2023 11:13, Konrad Dybcio wrote:
> On 23.08.2023 12:44, Bryan O'Donoghue wrote:
>> Several of our upstream and soon-to-be upstream SoC CAMSS dtsi declare
>> csiphyX as opposed to the older clock name csiX_phy.
> This only reinforces my point about adding like csiphy_clks or so
> 
> Konrad

I really don't understand your point. Could you please restate it ?

---
bod
