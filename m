Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37156770A92
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjHDVJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjHDVJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:09:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DEC59CD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:08:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso23648005e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691183306; x=1691788106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kj2SGXNF0EqeeVeoYwK5y3aZysneTeIb9th8Kuq+mhY=;
        b=E1Cy/WEHaEha8d+Ohtah69I6RVmp8L5ptLA0IiipoIluxOTCmomYfgkBPhrEpaGh+O
         +eARTThKIZbypwnslQY4PULzaW7RUd1W7GksgeY8jDrWDnVYqHNu+LVAtOeEV6TjZXYA
         dql5q3gXuCQ/woNRviPMqK5fmQ+zLiiI+abmTHawOeZj07XgoIfPypW2/ukZn6XvtZGq
         BUM2Uh8CJcAOB3lSI+j4oY8LW8wUBWlAY7qoYbUj8X2dXYyv6n2HZte9PjdnI8x2+opR
         Wzn8IXLg128chYyzShGv6DJ7KOWd+eqWQrpffFYfRDkcz2sNTPBR/SZsMntODgL1eCMI
         6F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691183306; x=1691788106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kj2SGXNF0EqeeVeoYwK5y3aZysneTeIb9th8Kuq+mhY=;
        b=VsK3RklLWMeL/9oaCaWRjSpNC6Flz3rwXgpJELjK5hzjj352iVB41KbGlqTwj0WWP5
         GTBuQdkreWG/ZDKVCAQZ/txltvIX5Nkpq0L9OsLwXIP/H16JhnOlJbXL+ixlpPM0EcLO
         TZyB7rOplxBj+RJETPoDE6ZsZsBvTm1AsUQIbBxkSbMxgvZeAdSaKbIP3DCQJhItnCIK
         LHK+TlwzxvfMmLKg84w5XXn91asW8VD2wK7JlqpKkAMQgAaMbDaAn96WwGw86VfWXCti
         ZrjSDDckquLTHKqIjCv0rABEdlwwMbLFjzTZC7/vMJWu77dzMy+Ns7QseLzKF5QkPYxm
         2xjw==
X-Gm-Message-State: AOJu0YzuZCXyewCajc+9uoCW+AIOO1DU7CkxVhxumY8IcuFE4hRUyxg5
        qGucIlSfivgjooR7zF6UH5Ehcw==
X-Google-Smtp-Source: AGHT+IFQCcB2ipMAuu0rfEtAXc1muyB4wSJjh0E43Tb1boJ2ic6TEYz8V5IdggCsR0SC8BPaN8bllA==
X-Received: by 2002:a1c:cc08:0:b0:3fe:1c05:3c8f with SMTP id h8-20020a1ccc08000000b003fe1c053c8fmr2195292wmb.35.1691183306137;
        Fri, 04 Aug 2023 14:08:26 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c215400b003fe263dab33sm3268918wml.9.2023.08.04.14.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 14:08:25 -0700 (PDT)
Message-ID: <8997bb22-e132-0870-7fe7-cca0258ae660@linaro.org>
Date:   Fri, 4 Aug 2023 22:08:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/6] media: venus: core: Add SM8350 resource struct
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-5-8c8bbe1983a5@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230731-topic-8280_venus-v1-5-8c8bbe1983a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 21:09, Konrad Dybcio wrote:
> +	.freq_tbl = sm8250_freq_table,
> +	.freq_tbl_size = ARRAY_SIZE(sm8250_freq_table),
> +	.reg_tbl = sm8350_reg_preset,
> +	.reg_tbl_size = ARRAY_SIZE(sm8350_reg_preset),
> +	.bw_tbl_enc = sm8250_bw_table_enc,
> +	.bw_tbl_enc_size = ARRAY_SIZE(sm8250_bw_table_enc),
> +	.bw_tbl_dec = sm8250_bw_table_dec,
> +	.bw_tbl_dec_size = ARRAY_SIZE(sm8250_bw_table_dec),

The very same freq and bandwidth tables ?

---
bod
