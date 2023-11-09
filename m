Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD07E6B3E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjKINct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjKINcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:32:47 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696A930D1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:32:45 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507962561adso1148324e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 05:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699536763; x=1700141563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZ70LYAYE9xQrDLEMVJLJF6eR1PCaiutjX/36P8JvJE=;
        b=Ze5365LLA1UY+kykLgiQS1kfMukCLjwMxzIu/yLWWCdCvoSPyny/iGnSC5bdSH4Y8B
         RlXn36XqrTiXT34/OsdH9WlKEp5lo+bAqPXMIo0OqV1RXO0noeBinzubGSmg56/SGtkW
         phXBEe+zhwJgckapgjMzCv7j4Hyoel49itRNQT4yQVUGvpayYgij8TwJzvShyACuF7SF
         ccDDme6khnhUZsiL7yT7+Xwx2ppDr9nUmFxM7SCoEJxoyZ86T4eUKWkwwf3nLmESnEih
         Oze4EYovh4enBQgFMhebz7NYoJ3XrVf9httSc205TujVyE9xYXCz2rZeDHXw3N+EnOZ4
         YQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699536763; x=1700141563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZ70LYAYE9xQrDLEMVJLJF6eR1PCaiutjX/36P8JvJE=;
        b=rUyeRb12XMYCDLT9/IGbjrjRt/qasnMX81c0KFCcQsbZo0r/BT+q3GnmJahmPcMZSh
         Lq8g+0A/fSfrgb07Z/pUj5ocSyG4v8u8kOKTEHIz3UHAOSlEJnDkNZ2+YCVklNuP7Wl3
         IBVgm1aVuEX0edQHE7b3dQP8grIXwVwHZ7TFoYg2s7qowT5BHArHymgcchizwRJvO6Z9
         R+uw25xmCui0pbauwLL7N9Yv7Ui22wiGnL6m3N4G73GkgN3i+UdAsLLsypDVsatxDhnH
         txwLUddp3d4rh51heDGeQHf0+1OXjZv/TEesQzBrmkyUU4uE75XFow76v9FA9F8L/zor
         xXyQ==
X-Gm-Message-State: AOJu0Yw9AMCvoAlkeBPYGBKYqObFRfL3VNwo0qZpuzI8QcEDvlv3ND4x
        1Dk/BHu+oTkFKV7zVBkjuUZZCw==
X-Google-Smtp-Source: AGHT+IHC3LcqD5UK3SBl8IfD15Q1HWMFZopZvCjS0WqaNSQXQeVCGjyalRlm1cFSxUGAHStE05i5PQ==
X-Received: by 2002:ac2:5637:0:b0:507:a0d7:bd19 with SMTP id b23-20020ac25637000000b00507a0d7bd19mr1435455lff.13.1699536763675;
        Thu, 09 Nov 2023 05:32:43 -0800 (PST)
Received: from [10.66.66.2] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d640d000000b0032d96dd703bsm7425418wru.70.2023.11.09.05.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 05:32:42 -0800 (PST)
Message-ID: <ac253acc-ae03-460a-b982-0a9f780ddb5a@linaro.org>
Date:   Thu, 9 Nov 2023 14:32:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] media: qcom: camss: Add sc8280xp support
Content-Language: en-US
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
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231109-b4-camss-sc8280xp-v4-0-58a58bc200f9@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231109-b4-camss-sc8280xp-v4-0-58a58bc200f9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/23 12:30, Bryan O'Donoghue wrote:
> V4:
> - Drops all _src clocks and _SRC indexes in series.
>    True enough the CAMCC driver has all of the appropriate SET_PARENT flags
>    so there's no need to represent _src clocks. - Konrad
Thanks, and if you have any manhours left, doing so for the
already-supported SoCs would be great as well..

Konrad
