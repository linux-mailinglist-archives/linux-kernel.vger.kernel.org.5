Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36137D1E9F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjJUR2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjJUR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:28:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E44E5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:28:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d849cc152so1482494f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697909301; x=1698514101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5lqhGvcnMlsbzoqzAuSUnuytpJr6ezeGC98RUo/Y8M=;
        b=HnLgMqO4nIg7UyzG6fWBNZuPAs+/OVTmLKyUoohpGZIMddbYsR0uxxWJamOD5dibmS
         2adXJTY3mYyhk/KRKEfuZiFsdCmQXGgBiw4GhIl5JXsqqn6l2iJJ8ba8hLObP32eRDJ7
         267xdUcVPj0e/1yGWiNqXqiHJGaA+O2vKBvbmjSrEI1FL0jlPOphFquGwUEDFDhTQJ6o
         eRq8DutgGAIFUw0/QkVMxlN7cjOCtDj6NHKl91G4OCmPoHj0YlLubMRYZkftDuYQeRcU
         ElyszEL+PoKplyCi6EfBiuF+OwurKtq5tqbJTurr5s3zr/dut/V6i/Jy06fXEXluhkh7
         Y1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697909301; x=1698514101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5lqhGvcnMlsbzoqzAuSUnuytpJr6ezeGC98RUo/Y8M=;
        b=Gz39Ghji8y+AXW28mO5Ec2YS44vrGqRNhKDC7lwTkWPWPndoW7inXgNug5mfbe8UEV
         3g89csz8jwpWRAxVFzNHzI6KlWpdVoS7aofJhwZPcc4DwgY55ej+1uWvhAH5hmfh5wY7
         pvi5rSjIutCd/mmqUyxnbTv8v5OPwA/RY9wWuccBaThArbqg95wrn/iR3eE5VO3m8VRG
         4nT0t4bw3MvJ7UcO43hKhkr3mN8B5UVFRddi0T9HtcG/JOOe+3Jhw7dguWwReGoDkJJ+
         wd7EQuyu+U6tFUqfqHaID5aWpuVLuRtBybgaY0RTXzCTlu5XnztiYXL0GPJiUtBAQ2p5
         f9Tg==
X-Gm-Message-State: AOJu0YwCOZB322cP68Ja6dnkoKr+ilcxpOTNryz5ENMcSEAOVWpiW8le
        I/LCCaY8Y1T59OK/BESG3QILzQ==
X-Google-Smtp-Source: AGHT+IGmBUU+684kwVhndOfmDIGujj1nA7C2Fw/RKXv7J2J5mZk1LxUM0RklCTrSkbBAfLVSS44XSw==
X-Received: by 2002:a5d:58d2:0:b0:32d:9b30:9a76 with SMTP id o18-20020a5d58d2000000b0032d9b309a76mr3225813wrf.47.1697909301368;
        Sat, 21 Oct 2023 10:28:21 -0700 (PDT)
Received: from [10.66.66.3] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id k13-20020a5d628d000000b0032daf848f68sm4060262wru.59.2023.10.21.10.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:28:21 -0700 (PDT)
Message-ID: <8f01ff1a-1af0-4684-a69d-6eb6c79d2e58@linaro.org>
Date:   Sat, 21 Oct 2023 19:28:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: gcc-ipq6018: add QUP6 I2C clock
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
References: <20231021115545.229060-1-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231021115545.229060-1-robimarko@gmail.com>
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



On 10/21/23 13:55, Robert Marko wrote:
> QUP6 I2C clock is listed in the dt bindings but it was never included in
> the GCC driver.
> So lets add support for it, it is marked as criticial as it is used by RPM
> to communicate to the external PMIC over I2C so this clock must not be
> disabled.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
