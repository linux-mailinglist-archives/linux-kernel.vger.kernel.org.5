Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F15D7EC4E8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbjKOOQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344159AbjKOOQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:16:19 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D2FE6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:16:16 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32f737deedfso4258735f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700057773; x=1700662573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBcMwoRIYgF7VaZgnHonAhLO4GBcpIaX6rYlfahtvy4=;
        b=D0+z8kmC1IQws8+I4rD2ln/A6dI39UgDLzsIfBiPycrrWmwRRNyKrka+cyO+PO8xFg
         y+u+K7sYIJSBXceRVPlrRmErzZpWs+DmJssyryxPMknj1nDk8g7paz83c0/Sa4y0brKt
         omFtnFa8fOOlUf5iVqBbZXsLWWVtcU+geQ+3nd0cox1kClfKniy7lAgKjvnpSh141ieB
         1vE+LUUe93Hakw1dUq5AHRz1uTsy4BHofxvSyPdIfz8wnVFxzPRRIxcsagXgDs5Fnq/H
         RG7mZgFzoaT4mnD1i+5lv4GowtpGl9/GjGJTlIvx9wuCHaYYQOQICgrxhYe+i3s6tqDE
         7OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057773; x=1700662573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBcMwoRIYgF7VaZgnHonAhLO4GBcpIaX6rYlfahtvy4=;
        b=XmfQArCzh0gBjBJ7XONlly0Fm5q+yMkmv5oTD4tv9VHjvr9pwxwiuolhCGK7djBekD
         Wl/2ezKGA6lDQMociT2CBjViFfJkOE1PLBHKFmVsOLGgBo4+s7gFZByY6uU5BIx/v2i7
         G+7ehsSPHoNpYXnX3Sk9gB5nw5KOloaB+SZD7bqjgdbPJe7B024pDRv+nhh8fX/uLWe6
         +9P4xVqYPfBYFNcJe1ZC/NUZnrj06/ToMWlCRqafObdRiBWzyYSYCxEh85IMCaVz1z5/
         4XegeprT3DpdMveRqAdICjCMUmw4adYLLpxfXs7QYAG63ymxztWD1cSRtYJzS0oC1aWR
         EEaQ==
X-Gm-Message-State: AOJu0YxFtbiEd/waFGgROlezUs/KVQt9HPDrvPFamLrh2pZEzvqY/+LH
        W1hmb9zDFfUhRwjRvCPvCdrpxw==
X-Google-Smtp-Source: AGHT+IHvijU7pyOmo0swcg34eZbJxraA9K0BAbfHw5NkUncOdyQJ0MA3ElGKy7jpzCrcHPoaz3gtuQ==
X-Received: by 2002:a5d:47ce:0:b0:32f:8248:e00 with SMTP id o14-20020a5d47ce000000b0032f82480e00mr10840801wrc.51.1700057773587;
        Wed, 15 Nov 2023 06:16:13 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id dl3-20020a0560000b8300b0032f79e55eb8sm10659407wrb.16.2023.11.15.06.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 06:16:12 -0800 (PST)
Message-ID: <5cd19f5e-baa6-47da-8730-fe0ddedff364@linaro.org>
Date:   Wed, 15 Nov 2023 14:16:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add QUP5 I2C node
Content-Language: en-US
To:     Legale Legale <legale.legale@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CACDmYyf4hxbuw+cpKqEDnqmHpS9yPXuE5MPD5_XZ3hjmYuViUQ@mail.gmail.com>
 <a3e35d3b-906a-4540-924c-0103cf32efa4@linaro.org>
 <CACDmYydnLQd0n9ACnTQ6P4wYf38eMzokyHrF7r6LisG4oTFtyg@mail.gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CACDmYydnLQd0n9ACnTQ6P4wYf38eMzokyHrF7r6LisG4oTFtyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2023 13:58, Legale Legale wrote:
> + reg = <0x078ba000 0x600>;

This still doesn't look right.

---
bod
