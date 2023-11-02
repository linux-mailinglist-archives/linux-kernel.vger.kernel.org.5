Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42FC7DF439
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376646AbjKBNp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376610AbjKBNpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:45:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF45212E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 06:45:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo1495397a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 06:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698932746; x=1699537546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUcfPgQH1UWULWd4u1rfSI/DVi5ZQyAJ60XsJjsMiCE=;
        b=HL5oo8LuCoa/Vxk2ZBeC6LaA7r9nfXlbtLXUecfcwPeFFk/urV5Ql/Lgm3837EAG+2
         MOxQAtaYx2UNay24eeUUmpZ0xfv3bhErspiUI8Wv/oihDjEkKon+Z1HfeUtY5vn78uJd
         u1Mdc0d78kvE1n5DsCKpG5TDj3k7l6Z5s6bPHXwPUHFt7Y3CZD/Dn7iDPHiBuZx70tjQ
         /iuhvnPwPax5YOswkWTOPa+f7rwtoykx1BWgqHMVKT20QxCJJPuXebmXVcP706WmzZuA
         Uo4xHd+g9nayHeDoiDL75V3yKOChB1LhPMmYFKE6ystS6Cm144Y5W/5FJJcbUP6nnZDW
         /Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932746; x=1699537546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LUcfPgQH1UWULWd4u1rfSI/DVi5ZQyAJ60XsJjsMiCE=;
        b=wv9MFH9OaZH69yZIScq/KmNab1iusLpSn4ZadEh2imLNuE3wmsRaQqsq51FqtMSZQx
         smrM3JN9XDpnSnUdd9hGDGcVMw9zoL63Fukkh8yq9vtSJ4uqYNGcv2IzKsrRVozKLGAL
         1V8lcaeAW/Qidll3XKMTR5SO/I9BjeEQephPJumrxTknvoTWoxugjAl4UICR+xLvWXIt
         iM6LUeVcZdwbwOHoDCAXB+J3Fllh/Hjdrb+kn9EDtNZLlSNf1UF4PLvJxylbQZAICj5p
         WTry6bkEg6iKuwtP5HHaLuw2/rLgpq7AVfghAODMloeLyktAQPEgKx8U34CJlmfkoJZg
         uHXw==
X-Gm-Message-State: AOJu0Yz8LaSgpYseJSfSAWsJUh1DfDd8298+5C2mKbd8kIhoclibdf53
        9rDRcIO4E5rggtFVZe9/MA1DIw==
X-Google-Smtp-Source: AGHT+IFZgOGw8+m3lyLjHxEHIO9L9vSCBqrsVZmFEzIqrumUDq6R67hsXwXlNZ91ruD7llEVEVllyw==
X-Received: by 2002:a50:9b42:0:b0:543:55d2:df2d with SMTP id a2-20020a509b42000000b0054355d2df2dmr5954672edj.41.1698932746058;
        Thu, 02 Nov 2023 06:45:46 -0700 (PDT)
Received: from [192.168.1.118] (abyj199.neoplus.adsl.tpnet.pl. [83.9.29.199])
        by smtp.gmail.com with ESMTPSA id u23-20020a056402111700b00543597cd190sm2339127edv.47.2023.11.02.06.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 06:45:45 -0700 (PDT)
Message-ID: <e95642ea-14de-8ec5-11bf-1218426a23aa@linaro.org>
Date:   Thu, 2 Nov 2023 14:45:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 5/6] media: qcom: camss: Add sc8280xp support
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org,
        matti.lehtimaki@gmail.com, grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231102-b4-camss-sc8280xp-v1-0-9996f4bcb8f4@linaro.org>
 <20231102-b4-camss-sc8280xp-v1-5-9996f4bcb8f4@linaro.org>
 <9f088cfc-7b01-524c-1900-5acee6919ec4@linaro.org>
 <d26a975b-7a66-46db-af1f-685273f64faf@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <d26a975b-7a66-46db-af1f-685273f64faf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2023 14:38, Bryan O'Donoghue wrote:
> On 02/11/2023 13:35, Konrad Dybcio wrote:
>>> +static int vfe_bpl_align(struct vfe_device *vfe)
>>> +{
>>> +    int ret = 8;
>> return the value directly
> 
> What's the motive for this comment ?
stack size
> 
> ---
> bod
