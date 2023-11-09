Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D585D7E6D12
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjKIPPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjKIPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:15:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3354635A5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:15:39 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso6626535e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 07:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699542937; x=1700147737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNzU0830D43H2VXQRT2Ex372KHUEc4BXST5kikj6r14=;
        b=t5tnuqEIeRifPxgCvuu/PMFVdf0LSv5h/G8np3dYWTgfdz8ynyMtJmcnCxNVPLqsyW
         vftT4UDkjOALX8GhJCGQfslzENj8Q67sqJNds7PIbpXvcFA+LVfa4lOgYZWBVH65lGQ9
         MEukpur6H2+6kR147rLAZhobfFiasukuuZzl44wHmbr3QT89qXFF7AvD8XAN50Bc5EWd
         ZS4Wmij3Av3EA5FyGl4sQljbh76IByg/VdSAPlQiP3GnKQ9yRaHOtT/fDvjF0ejn5tEn
         MJKRmy8HM2ZGkxw5R9UB0gQpH+fu45vZ3jYU5k8C3EfKV9W2CL6l90PFPKQDxTRed99c
         9TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699542937; x=1700147737;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNzU0830D43H2VXQRT2Ex372KHUEc4BXST5kikj6r14=;
        b=Xwm3nP5cyBcQ43vQP/KOAsXwcVc8XD+SmoiWGlxL9m7P7NNPVY2dtFCpDAXgn0TOZa
         2oZ3OyZ/f5Z+wl+QPt7r7IrqlCahKXeUj8rKtWKen2oLTGouEk+jN3lt6W1ZltDj8dhf
         qFt5vGcDbNp5aQWp52Sut/y9c9UfTlXz8hHUeW1KnpLoh608C7FhzbKkXaH1nrYooUtP
         68HH0LnLV5RxBgQNR4P1IuSBpuKDtJnt+QV/sTGhpPTp3iVoVCqarjisf7MpHi/fYTae
         3KWifQtFYBMQkuDVxu6IkPpEKGg3H1mrAk/txfA+TZudfPNHDfakgK1S8tD75GF8xKY6
         kkAg==
X-Gm-Message-State: AOJu0YzeKqiwuqK7wmROIydx/zGg2p5SHaru47+pqVdUJ0lKDlM1ph2Y
        HW4H+OoIFykRJyNippfQJQbO9g==
X-Google-Smtp-Source: AGHT+IHLq/kcnLWmV7fbCwPCWFLGE6/07PY/z6miJPuXuiqHqYElIVqLGIrKDC7b/qdLyTL6Q5JkqQ==
X-Received: by 2002:a05:600c:5103:b0:408:403a:34dc with SMTP id o3-20020a05600c510300b00408403a34dcmr4829978wms.37.1699542937574;
        Thu, 09 Nov 2023 07:15:37 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bcb02000000b004068e09a70bsm2329709wmj.31.2023.11.09.07.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 07:15:37 -0800 (PST)
Message-ID: <4aaa25fb-de9a-4d7f-9316-ef83c27f4b42@linaro.org>
Date:   Thu, 9 Nov 2023 15:15:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] media: qcom: camss: Add sc8280xp resource details
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, vincent.knecht@mailoo.org,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231109-b4-camss-sc8280xp-v4-0-58a58bc200f9@linaro.org>
 <20231109-b4-camss-sc8280xp-v4-4-58a58bc200f9@linaro.org>
 <3e0958a9-4d1e-4d1b-a914-5da154caa11f@linaro.org>
 <e80d4026-a525-48ef-b53a-f1276dd316e6@linaro.org>
In-Reply-To: <e80d4026-a525-48ef-b53a-f1276dd316e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 15:13, Bryan O'Donoghue wrote:
> printf("index %d = %d\n", clock_rate[0][i]);

Doh !

But you get the idea

deckard@sagittarius-a:~/Development/qualcomm/qlt-kernel$ cat test.c
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CAMSS_RES_MAX 17

unsigned int clock_rate[CAMSS_RES_MAX][CAMSS_RES_MAX] = {
	{ 19200000, 80000000, 80000000, 80000000, 80000000},
};

int main (int argc, char *argv[])
{
	int i;

	for (i = 0; i < CAMSS_RES_MAX; i++) {
		printf("index %d = %d\n", clock_rate[0][i]);
	}

	return 0;
}
deckard@sagittarius-a:~/Development/qualcomm/qlt-kernel$ vim test.c 
drivers/media/platform/qcom/camss/camss.h
2 files to edit
deckard@sagittarius-a:~/Development/qualcomm/qlt-kernel$ gcc -o test test.c
deckard@sagittarius-a:~/Development/qualcomm/qlt-kernel$ ./test
index 0 = 19200000
index 1 = 80000000
index 2 = 80000000
index 3 = 80000000
index 4 = 80000000
index 5 = 0
index 6 = 0
index 7 = 0
index 8 = 0
index 9 = 0
index 10 = 0
index 11 = 0
index 12 = 0
index 13 = 0
index 14 = 0
index 15 = 0
index 16 = 0

