Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80167E6D05
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbjKIPOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjKIPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:14:04 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CD92D62
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:14:02 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40838915cecso6931745e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 07:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699542840; x=1700147640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngW2H67nvbIil9Jd4FOLYMiZuCHl7MW2vB4VxmLrw94=;
        b=D/cbWeWyNFEBZgDtQGXEselP1HuQmIV16NxRx2IQN3lsMuTWTHgfcTpETP3rXoI8sP
         hljlmn9holU4YYOY/LVMURM+jqESfWxC5c27yKX6V+uXmiidCwD9S5vKH1GmZxxvN3e2
         so3OZN4gxQ9cGzFk9FOtwqxaKCn6+aB+cdQLqo+Lt06Z8/Muyf9IKfpeQ2uV9yt0WSiM
         TTquk5NNN+OZlfgawXuAgbZoaJEgWEKH0P4wZKk+g3o+N2Yve/ovQf4RyhdJpzzj1nR0
         sNiFhBpPxeal3IPsZu1XF15SXLTE7mlvRFYC7Ifyof1fsdbeMT+Rgrk8anVMxtWoOHCr
         g9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699542840; x=1700147640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngW2H67nvbIil9Jd4FOLYMiZuCHl7MW2vB4VxmLrw94=;
        b=aT+XzRK9YE1Nc/ibLmO1JEOoYlx0Yp576RBM+AS4borALFNbGlQt4NN/fqb7bE/gVh
         iHBGuTcMp46umzcOQkwHnbubQo4pK+L3x1uhfwHX+M+Jzx2GkEsPXH25as8TJ5HtaxHv
         7hl1pKoOam6Mk+wtMbt/obPF8RjU95YLwSt0p0mLObH1tOc9kv3amCKkjzrfgnx7HqEU
         9ojUEwYS6J92cScVBoXtvmG8T4gLR2/OSTNhySCRgakIythlP01vzP7zdPJ379CjBsr7
         T5eV6uHCFrLjhrPUWjWzeRyyDXdVnzFKj+hn/QoakhODvJCJiPUnmm0pZnzt8N8sZzJp
         /czw==
X-Gm-Message-State: AOJu0Yya5QQUTKibKyqUo75UjU5hTNkX+Wak8g7VtMiZv/zmJAGoOL/U
        tE6Unkf81zLZxX4/+VnepteacA==
X-Google-Smtp-Source: AGHT+IHO8LoMMy2ZV8wNcw352FFV308MNE/rSe7GnvAe6vm0+bXvfQNvz5jUBAOsn9dTb3l5eqNmtA==
X-Received: by 2002:a05:600c:3b8b:b0:401:b6f6:d8fd with SMTP id n11-20020a05600c3b8b00b00401b6f6d8fdmr4409042wms.6.1699542840519;
        Thu, 09 Nov 2023 07:14:00 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bcb02000000b004068e09a70bsm2329709wmj.31.2023.11.09.07.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 07:13:59 -0800 (PST)
Message-ID: <e80d4026-a525-48ef-b53a-f1276dd316e6@linaro.org>
Date:   Thu, 9 Nov 2023 15:13:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] media: qcom: camss: Add sc8280xp resource details
Content-Language: en-US
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
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <3e0958a9-4d1e-4d1b-a914-5da154caa11f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 13:44, Konrad Dybcio wrote:
>> +        .clock_rate = { { 0 },
>> +                { 0 },
>> +                { 19200000, 80000000, 80000000, 80000000, 80000000},
>> +                { 19200000, 150000000, 266666667, 320000000, 
>> 400000000, 480000000 },
>> +                { 400000000, 558000000, 637000000, 760000000 },
>> +                { 0 }, },
> Not the case here!

I agree with you in principle, the checking for the frequency shouldn't 
rely on if (freq[x]) however in this case - we are doing aggregate 
initialisation of a fixed size array and the compiler should save us 
from ourselves.

./test
index 19200000 = 0
index 80000000 = 4
index 80000000 = 8
index 80000000 = 12
index 80000000 = 16
index 0 = 20
index 0 = 24
index 0 = 28
index 0 = 32
index 0 = 36
index 0 = 40
index 0 = 44
index 0 = 48
index 0 = 52
index 0 = 56
index 0 = 60
index 0 = 64

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

However this code only works at the moment by happenstance not by design 
so, I will drop something separate to this series to remediate.

---
bod
