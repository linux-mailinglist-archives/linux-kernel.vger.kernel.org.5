Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72967C4F90
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjJKKGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjJKKGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:06:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47BEAF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:06:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d58b3efbso5854221f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697018773; x=1697623573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fub0OLah+ZMrfmMWsVbsLKTM47lsXgX5eYB01m9XKeg=;
        b=lNcMUYxSa29cIYJBrzq/qq9ttz3a931rjwd1IbHtGxgKOfE1jzieGw8fRmQU3jImwN
         uh9yHYhOhrgHkd87r8bzxPeWKXdys5+w592YKb+ZEAZMUvix3szbkrntlv6LKkhRgh5j
         0BKCcwi9BQKEFAtTy7LxduhVBjNtHs/AeKM+HLK0jQUsI/tTzj+ZXRaxsx+7xNmafhCi
         SBcmABTzi8qb3hxQj9j9YSRzd3ssRwVuL8IbZ+FJWrer6Ia4QDCfgybNvGqeDF6Bee3g
         RE/nM0+kWU1EqgKwaUG2G1tEs+4nG1uTQ6lL7683k2ONPKxJQvMMJb6oIqzpNhKz74MV
         yCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697018773; x=1697623573;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fub0OLah+ZMrfmMWsVbsLKTM47lsXgX5eYB01m9XKeg=;
        b=F/QVOA0Zoy93vlfI2dcmWYtwiiq1am+TFAauMUBaojPy5APdQBEKKOff08+g6YkL/U
         /J5wCxXWYC1m0FRLcmxjb82CLsbjveZhwGGK4rgQVRV8ndYX6QqooXYnjVlCsYA7g4MG
         ceAdiJrYJ3lSLpATFU3KDLt5La3J6Ry7w+eLJQ3Q6UackSuh8uhQA8lFvNLx56+RnKle
         op6gAsVENsohLsrykGCO5G0NTumlKK7we2LM5eU0phNUG6RIvlEXD3v7p3HRdD1Aub7i
         Xk4YqYq/cdtEC4pA18j0ly7jwDBClo0tIxo4xcvpLU1D54+eFq8d76OqKxT0kyMn/+rQ
         XhXw==
X-Gm-Message-State: AOJu0YxDhOaIpKnZTasmvGjP1x9lgnwAfoWyfimpzqrJZoK1cLk2X+yy
        4qq/Na6pW5QXvcFF/GTdVGN0XQ==
X-Google-Smtp-Source: AGHT+IGt3zAFGhPUYx7XidslsZDz+pqj1w2FqJtNDcptwK+tW2l0dBINQjidP+IuFvFen9VS1DII3Q==
X-Received: by 2002:a5d:67c9:0:b0:321:5211:8e20 with SMTP id n9-20020a5d67c9000000b0032152118e20mr17369654wrw.59.1697018773010;
        Wed, 11 Oct 2023 03:06:13 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b00323293bd023sm15155625wro.6.2023.10.11.03.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 03:06:12 -0700 (PDT)
Message-ID: <abf17440-bddf-4289-a951-bb3fd3951be1@linaro.org>
Date:   Wed, 11 Oct 2023 11:06:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     quic_luoj@quicinc.com
Cc:     agross@kernel.org, andersson@kernel.org, catalin.marinas@arm.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, quic_srichara@quicinc.com,
        robh+dt@kernel.org, sboyd@kernel.org, will@kernel.org
References: <20230923112105.18102-4-quic_luoj@quicinc.com>
Subject: Re: [PATCH v9 3/4] clk: qcom: common: commonize qcom_cc_really_probe
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230923112105.18102-4-quic_luoj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # Lenovo x13s
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
