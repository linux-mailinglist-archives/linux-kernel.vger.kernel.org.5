Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4777EFF4A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjKRLfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjKRLfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:35:38 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014FC10D0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:35:33 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4079ed65582so2346015e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 03:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700307332; x=1700912132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44TB2Q4xVBrawfbtki6oGL++4vEDUXWgPnAMX9eIRIg=;
        b=Jusyyr7hwHGPh9Eo1RMQt6rniM3X+ZgjMxeHleJ6HktP5HCmHw282YIBd09Kef7z65
         eGqjPT0ILbew6vUEuZ6MVLeyIYqJ9ndnLWz7fik4TV+0X6wpGiYeOIeRJD2JuE/63FNT
         QDVpgODvagQP3xe+SNltqWIgiTfeMza9bJA/KkvK5ej4S//KonOhddrWj7sg+/vobVce
         i/pKRQZ26ZlJvg7hWwoP3XY2+5FdQtXl1dN8/p1oBMT/LecgH4wrOE0K+ZiEBjbzjefZ
         J7fJq46LLTyJMku0U9olkjgA7KrB4+6QdKm+xX37gDDEqcohLiOAvckndUTqe92V1hdN
         MMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700307332; x=1700912132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44TB2Q4xVBrawfbtki6oGL++4vEDUXWgPnAMX9eIRIg=;
        b=sxrwwYb5+MwPB0fISonbKHQ+wW+y702TFCsLs96xcHynXvA7pFZMUwQVfdWDzuEZmA
         6DdMhJb9SvwfvBl7QmRYD4Pzhc6feCTHRM/gFJqZc84s3swC2eU9D8WGs968rreZotYp
         Qhr3GiITt1su0YBxT2p2XsHrbiWsqSZ5DBmECm/IKbBFTPItw6h+F3RNh9O+UWc9lwV2
         zWYtvScXTp7h1JDOn2O6gLkIi+qZuLTGkGXaEs+qwup8/VUkUbgJqNylnw/DeoIsRTRG
         1JccI06RgQfAYxrd31z+dnunMFCuBHbOsW1CJXHoGF1xUP+syxSio8bTQQzVW3YNZkcR
         26eA==
X-Gm-Message-State: AOJu0Yw+H0O7LG9v0l8qkmvtVK5KzNgtFHcmz+kyyYAnIzcahopJBfzM
        BCEVKqXvSTVJejzwFSUTPqgFOA==
X-Google-Smtp-Source: AGHT+IH45WnOTljmI1rzZoyBuGD11rEpJzz1WSRqMnUWf3O1tSvVnk0jrE9ZNWS/nxCHkc+DlvJ/lA==
X-Received: by 2002:a05:600c:5487:b0:40a:43eb:b752 with SMTP id iv7-20020a05600c548700b0040a43ebb752mr1805937wmb.34.1700307332257;
        Sat, 18 Nov 2023 03:35:32 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d4604000000b0032fbd0c7d04sm5101992wrq.55.2023.11.18.03.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 03:35:31 -0800 (PST)
Message-ID: <57c9b7e8-bb0e-4d31-adeb-19a83137c082@linaro.org>
Date:   Sat, 18 Nov 2023 11:35:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] media: qcom: camss: Move VFE power-domain
 specifics into vfe.c
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231103-b4-camss-named-power-domains-v4-0-33a905359dbc@linaro.org>
 <20231103-b4-camss-named-power-domains-v4-4-33a905359dbc@linaro.org>
 <0fbef967-62db-4c5f-8108-2c545c53a39e@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <0fbef967-62db-4c5f-8108-2c545c53a39e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2023 00:32, Konrad Dybcio wrote:
>> +	/* count the # of VFEs which have flagged power-domain */
> [...]
> 
> Personal peeve, but this comment seems a bit excessive

Well, to me this code "does stuff" that isn't terribly obvious. It took 
a while to understand the Gordian knot so its worthwhile documenting it 
inline until we can use named pds to make it all go away forever.

> 
>> +	for (vfepd_num = i = 0; i < camss->vfe_total_num; i++) {
>> +		if (res->vfe_res[i].has_pd)
>> +			vfepd_num++;
>> +	}
>>   
>> -	camss->genpd_link = devm_kmalloc_array(dev, camss->genpd_num,
>> -					       sizeof(*camss->genpd_link),
>> -					       GFP_KERNEL);
>> -	if (!camss->genpd_link)
>> -		return -ENOMEM;
>> +	/*
>> +	 * If the number of power-domains is greater than the number of VFEs
>> +	 * then the additional power-domain is for the entire CAMSS block the
>> +	 * 'top' power-domain.
> the last 3 words seem out of place


> 
>> +	 */
>> +	if (camss->genpd_num <= vfepd_num)
>> +		return 0;
> if (!(camss->genpd_num > vfepd_num))
> 
> would probably be easier to follow given your comment above

Sure, if its easier to read/understand for you, then it is probably so 
for others.

I will V5 this.

---
bod
