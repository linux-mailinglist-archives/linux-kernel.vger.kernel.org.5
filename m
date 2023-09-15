Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87B97A1C49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjIOKch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjIOKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:32:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8155730EB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:23:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso243291966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694773400; x=1695378200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZU4AuTd77SCi2z8SlZIHecF6Q/OBga20jXZU+Tyw7RM=;
        b=T+ArXf90tZNK6WJAB/Arf6yieCKcCF0mVThlCkVvgBzgPsSl6Y/1agYxy8iGFUwPaZ
         NeaMIero5ajJK3OD72L2C9rxVpcDMn7CVUc1y/0lb9TrQxIHE5T/Bl0nve5QTzJ2uCmh
         DTVEZxeFsejwAMOaY2ycjJTv7OaniPmTfllcmEfwfR49pGoctK3vN8eXAyzWMw5ioyPM
         2uEbl4iuW2GL+vwJDph5oSzEUDfghLO/XfLpea0Ybq+qYGQ6Sg5NBKasuH92WqUlYgdz
         IQDDOi3FzdVm/HND7pnIl4MVO+NPgp1WHW6ovHZCEov+693P72TDEokX9/jOBhzgM+qW
         55Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694773400; x=1695378200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU4AuTd77SCi2z8SlZIHecF6Q/OBga20jXZU+Tyw7RM=;
        b=oTwczKr2g+xu1ViavazgjSuJi6g+nXqQSLIJBvw5B90+/sLAjuf1F5yb3eIOZKJrdn
         6N18gNMhChx7ZfFMVux6oML/ExnEr0g+jKWFflEEGNGaoI0tZnYTHxZorK8SG6Yx5x46
         h7oCVMC/SfrIezR3lhs2kN14SshXQ2zSPNo4QedgQ5aiZ83XmltIG3zbnsr8go46eIVL
         jA8Bo1ZmnwFg6CVZUrFUZ8XQ1ejBHeHmQRK3P9yEGY3XWppv3PvmE7DETTYCatKULj3w
         aPP0CQ2yzYoN3Gs92H+3Bkhw6mg95W6pl66uWsF3tSMzol3LpsQmlT7RjF12FuIZ4zRz
         X5KQ==
X-Gm-Message-State: AOJu0YwqdoOeCT2Jq7BohNAGLbQH9WzAJSFqQcnkzJ+oLygYYjoXhM0r
        OWHcMrqgyQZGvl8uSiuVSitVZw==
X-Google-Smtp-Source: AGHT+IHd2NUDtrOHeXSqw9jdD6L2t5IYy7aq0QEiscLzMW/L1cneK//YI9eejtz2lfL2eEwyr27C6w==
X-Received: by 2002:a17:906:74d5:b0:99c:5056:4e2e with SMTP id z21-20020a17090674d500b0099c50564e2emr951471ejl.31.1694773399810;
        Fri, 15 Sep 2023 03:23:19 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906831500b009ad87d1be17sm2211358ejx.22.2023.09.15.03.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:23:19 -0700 (PDT)
Message-ID: <a711407d-4419-4b75-99db-b8461b3bbdfe@linaro.org>
Date:   Fri, 15 Sep 2023 11:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: typec: tps6598x: add reset gpio support
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230912-topic-tps6598x_reset-v1-0-78dc0bf61790@wolfvision.net>
 <20230912-topic-tps6598x_reset-v1-1-78dc0bf61790@wolfvision.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230912-topic-tps6598x_reset-v1-1-78dc0bf61790@wolfvision.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 07:50, Javier Carrasco wrote:
> The TPS6598x PD controller provides an active-high hardware reset input
> that reinitializes all device settings. If it is not grounded by
> design, the driver must be able to de-assert it in order to initialize
> the device.
> 
> The PD controller is not ready for registration right after the reset
> de-assertion and a delay must be introduced in that case. According to
> TI, the delay can reach up to 1000 ms [1], which is in line with the
> experimental results obtained with a TPS65987D.
> 
> Add a GPIO descriptor for the reset signal and basic reset management
> for initialization and suspend/resume.
> 
> [1] https://e2e.ti.com/support/power-management-group/power-management/
> f/power-management-forum/1269856/tps65987d-tps65987d-reset-de-assert-
> to-normal-operation/4809389#4809389
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

