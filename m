Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C0F7A87E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjITPHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjITPHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:07:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D33B9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:07:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50317080342so5798474e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695222460; x=1695827260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsZ7Wlr1yiQfcQ493EQPRMkRXBsuRukyL+6eZElb+dQ=;
        b=zg1/6j9t1zZl+y2q0XUVLSweq/4BhIBza6hxrKLWd3yHhkkcBtXLUTUl41WvWr8XNc
         lbzLgF7UghRQPsOKSJEeXIa1JeJ/PxWZh+Szq6BeK5KuYtKuCvw7iAlFCZRBBZurPp1z
         cWraYIpgDm4P9Np32zNevsjwppdmxL0spTmcMI3xl05kC3C7fNsXYhfSiNoeH/iWs0Zm
         1p0LaEmM7iaVHzexI5pLc8CfIxXVplihSzwfGCYZdcaGLbhCwZDlN4hFU/0icYgyzMgh
         OsKlviHxaL2ur5AKauGEsjf0pDBk8OlQ61J34J8zdoe8WrdTX6rEdKMW0Hfsmgz/3RjT
         YiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695222460; x=1695827260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsZ7Wlr1yiQfcQ493EQPRMkRXBsuRukyL+6eZElb+dQ=;
        b=cogMgMCupXddw/cviA8B0rfdfkjmPD4v3QnzGWEOy2frWvIyMZ6zXSJ3YHlUqTgQNb
         wm5trQlZqS7QJg6iYdkzkhiUYyLZDt9+F6Fj1oLicLWG/v1KrmHCXFo+LlaPx5E535Cy
         iBO83llgb/Bxj7VTx0Tu5QBJ4GF/sgdZ6uUOzWqpge5spBEPf2ALcDQ4HkieXZ2QfZvg
         O8j4CjTtoaoQjzY/L55M++EwnbhMHHA7uB+BNqlEdq+XBpcP47qZcYVNppeM+YISX25F
         uVXhXuL4HjhMUYACLSdclRIFGH8GI1mKxBUpTvpTa/Rs9brPtEnaj22Gmnw09u0wCHHk
         ya/Q==
X-Gm-Message-State: AOJu0Yz84JUypB0/5sTAXhQXMPXYnODhdAM9iIK1pBj6DEnW6rufNAub
        lmQYFFwGVSdEwv29Lm6htBOFJA==
X-Google-Smtp-Source: AGHT+IEH1H8yEO26SQB7+ldxq/TedHeDDispfgHnSqbgz2f8e+eP++uMAspDgHun80RyE0gxnLZpHg==
X-Received: by 2002:a19:2d51:0:b0:500:ac0b:8d58 with SMTP id t17-20020a192d51000000b00500ac0b8d58mr2239158lft.18.1695222459729;
        Wed, 20 Sep 2023 08:07:39 -0700 (PDT)
Received: from [172.20.86.172] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id by6-20020a0564021b0600b0052a198d8a4dsm8951387edb.52.2023.09.20.08.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 08:07:39 -0700 (PDT)
Message-ID: <d782e49a-cc69-06c5-ac0b-4efbdd1f0903@linaro.org>
Date:   Wed, 20 Sep 2023 17:07:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: qcm6490: Add device-tree for
 Fairphone 5
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
 <20230919-fp5-initial-v2-7-14bb7cedadf5@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230919-fp5-initial-v2-7-14bb7cedadf5@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/23 14:46, Luca Weiss wrote:
> Add device tree for the Fairphone 5 smartphone which is based on
> the QCM6490 SoC.
> 
> Supported features are, as of now:
> * Bluetooth
> * Debug UART
> * Display via simplefb
> * Flash/torch LED
> * Flip cover sensor
> * Power & volume buttons
> * RTC
> * SD card
> * USB
> * Various plumbing like regulators, i2c, spi, etc
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


