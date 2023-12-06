Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C51806FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378072AbjLFM2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjLFM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:28:34 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4398
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:28:40 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1db6816177so70891266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701865719; x=1702470519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bGOyXBc8VpYXUIzqop1SwzGsMBqr5Cx6QC/TSPQu1wg=;
        b=NQ4mEUVHOg0m0nHeWw9lS+377zGiZRay6YJ91WsONO5FknLQD4Sda86lXfuLhrmT9D
         ENwEfcami6RJo/G0G24C0GzYmVa4U6iC6NpCnYfQiQG+XC81fY5yQiSqx1AmYdNW959T
         2W2n0i7UOijaHUYOt/5WlGPjVuI5XVCWFkHHQV1VRWLQ7+XyWLQuNJVE7o5s4WTIo35b
         PRziR+J5EGxsAC1zg+gum1Y69IIH4zwpCWqDJgLkAhBmhslYm9xkbCeV0n9R2M+5pmmr
         z2CP/nfaJRv7uRVOR4MwIM8/MnWLdciK6/xyD9qbA0SwCPZnKvGzlRRWwVLp1b1m7jWA
         aJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701865719; x=1702470519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGOyXBc8VpYXUIzqop1SwzGsMBqr5Cx6QC/TSPQu1wg=;
        b=CqxfawcppJQltb4myrjO48b2UXU9XtprESjaylciV8NPcgx2VReR4L3ETUbjwAvj2q
         u/EdLrzVOMVqctYyHJVfwB4JI8ioMKHSptFrCxWIDi3NG1jWLOy6ivhKhFoGABRi/XFp
         93MuGh5ztK7L7zdTvCm+aNXpFgpFD8WXEmyggZ43+qAhfET78duWu8tyv38alkF4tC/d
         6OV7eRqc6mxoKIAz4N7aAWVHqAb3xXB+qrFz9CQRTvIuu71CbQxPmyQUBG5PNei2ohDo
         FwppbwjMmO/YF13qLIF+zshRTtjHgzxkB5xu1EULeMCiP0Pf7oUP6AyTsi9XVnFOykxQ
         cbaA==
X-Gm-Message-State: AOJu0YyZcil3aOgNcgfi0WRhPoZ3zXFVKc9kdSdj3lEfXcJjj08Ex1pK
        nQ8YTjmsfvpDg7kyf/TsRsgFnQ==
X-Google-Smtp-Source: AGHT+IFO3C/Pc5x7AswNh/M8nngpoQqbv98xjwdSP/J2C+mcuKgVmSNZUHtS3ujBIgbkR9VMTamsgg==
X-Received: by 2002:a17:906:7497:b0:a08:1224:abd6 with SMTP id e23-20020a170906749700b00a081224abd6mr529383ejl.3.1701865718694;
        Wed, 06 Dec 2023 04:28:38 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:366d:ca8f:f3af:381? (2001-1c06-2302-5600-366d-ca8f-f3af-0381.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:366d:ca8f:f3af:381])
        by smtp.gmail.com with ESMTPSA id ef10-20020a17090697ca00b00a1b6ec7a88asm4358000ejb.113.2023.12.06.04.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 04:28:38 -0800 (PST)
Message-ID: <a25394b4-438b-43da-93ef-043620b6128d@linaro.org>
Date:   Wed, 6 Dec 2023 13:28:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] media: qcom: camss: Add support for named
 power-domains
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        laurent.pinchart@ideasonboard.com, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123-b4-camss-named-power-domains-v6-0-3ec2fd9e8e36@linaro.org>
 <20231123-b4-camss-named-power-domains-v6-5-3ec2fd9e8e36@linaro.org>
 <43621420-2482-4634-9c3e-1a3278481540@xs4all.nl>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <43621420-2482-4634-9c3e-1a3278481540@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 12:35, Hans Verkuil wrote:
>> +	if (IS_ERR_OR_NULL(camss->genpd)) {
>>   		ret = PTR_ERR(camss->genpd);
> I get this smatch warning here:
> 
> drivers/media/platform/qcom/camss/camss.c:1555 camss_configure_pd() warn: passing zero to 'PTR_ERR'
> 
> I'm not really sure what the intent is here.
> 
> If the fix is small, then I can change it myself, otherwise I need an updated patch.
> 
> Regards,
> 
> 	Hans

Update sent
