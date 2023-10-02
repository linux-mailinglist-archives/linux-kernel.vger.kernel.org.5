Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585F97B504C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbjJBK2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjJBK2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:28:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53643EE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:28:17 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c1807f3400so36464711fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696242495; x=1696847295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9uiHFCMzLlJe5x4a/5rmxmhTkPKOnSgYN/+M4Z494U=;
        b=MVSKxw//4l4FwnaPHIDIlsZIbwPjXgHVNTCaZ22IfTskD3ul+7o93Ls9F2d6JFY6Gm
         UTq5wiT1nT9jrqWaExrzSf6KmNsG6+KIcKQUC4Vgyc7zhoEPdj9vXCkEX0NOTjMKP068
         xEhmf5mo3s+hYFRH5b8DkF0aOK5FxT4WFxO1NEU09e9TgRElvifaQlqiHnb78cJRCfAU
         n/UB6PSw1PTMdCoV4uWXxgPG860JJkl9pqRQw8p4uBfKMtZ79UlquwB9Iy+bjIJIx4YQ
         KuvSV1raKIsVZ6rVNX9oRhh1ezRAQUOloJ7lCkYawLJ45kkpGqMT77prC/rGaYAlDCBY
         WmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696242495; x=1696847295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9uiHFCMzLlJe5x4a/5rmxmhTkPKOnSgYN/+M4Z494U=;
        b=ev9vlz/qRlc3ULMeQCHNL/HX24A8PGdGZEKyvqzzjKItHb6sS+pRn4tUHxIAN8gJCi
         Uidg8XEN8Ux/fWS5KPNx291hQt0P9y9LK1zW16u1VZYikZ4Jj+x0HPEXgTT2EN5qDzo9
         u0miOz007542zdKIDFHb524U4EpFoirtC9wXHrY8m5twJePbAgJnUiZeD7KppPYpjDcG
         E1wNhjji5dPduti/Ll+5uZn9g73kCey/+a7th/U/zRUxn2a4PoKYiIRhX1/H8132Hpcg
         PMto7ZlURocD7lB2tamHKWn7E4/wqCavSaY++6bLWsjKpntowzmLS6Tn1EydmdBFwO6Z
         TJJg==
X-Gm-Message-State: AOJu0Yz0xZOVd6Yk9BfwSzLFcQ3hILluyJ2+Rpsp9UMVi39YBi1lgR+/
        8EmEBBpE45vBnS2G6xOAImlHlA==
X-Google-Smtp-Source: AGHT+IFW0+gwOlLqYNeZ7mETu3Pd+ABKNdjIkutZF+3SdjfoqKiO6ARmXcfuf4v6kQQrsTNkCCKXZA==
X-Received: by 2002:a2e:9956:0:b0:2c1:7e15:dca6 with SMTP id r22-20020a2e9956000000b002c17e15dca6mr9135945ljj.0.1696242495619;
        Mon, 02 Oct 2023 03:28:15 -0700 (PDT)
Received: from [172.30.204.164] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u9-20020a2e9b09000000b002bff98b3080sm5123147lji.60.2023.10.02.03.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 03:28:15 -0700 (PDT)
Message-ID: <175c4782-94a7-c1f5-16d2-2df117a4b5dd@linaro.org>
Date:   Mon, 2 Oct 2023 12:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm8550-qrd: add orientation gpio
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20231002-topic-sm8550-upstream-type-c-orientation-v2-0-125410d3ff95@linaro.org>
 <20231002-topic-sm8550-upstream-type-c-orientation-v2-4-125410d3ff95@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231002-topic-sm8550-upstream-type-c-orientation-v2-4-125410d3ff95@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/2/23 12:20, Neil Armstrong wrote:
> Specify orientation GPIO to the PMIC GLINK node.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
w/ fixed commit msg


Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
