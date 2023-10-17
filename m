Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5917CC91B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjJQQv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQQv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:51:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C9BA4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:51:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406609df1a6so55985265e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697561514; x=1698166314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T90E1Wgo5rWvBAOANvbZnM/quFOrnnCVJrCKaT/SFF0=;
        b=K15BRGSdsWHCDzkTfVkk7KRa5DD9nZJohfAHig98ARlKuzRqsoi4ag0oHZT12vsYFf
         WuiEME5J5LfxnwxWBtUDekFvTXp8iYaFancdDcKYADeqUDWVDhhGlfC1UAWwOt/P1AH1
         FHfx/3oNTx/wnLIyjuQXcJJKsw9Jb5IyMpC/PRPNRoa9ACr2jKCtbSE5up4u1yX46Cx4
         DqW0Zf+NzxrENOmnxJIoqDV1/rrNs1iZ8wjXHNGjBBS4TgJX6p68t2Z+Uvn0kGz09hC1
         rizShJXJZxPmflP0aFht6wvEFe4sKYpyFVnxY1H7djz6kbWy57SFbsgUMAccgt4Zfo03
         YRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561514; x=1698166314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T90E1Wgo5rWvBAOANvbZnM/quFOrnnCVJrCKaT/SFF0=;
        b=H3ba6s05KRoalqB6nKUlFHXi8F+bvDkviPr5Bi8lxhiFqcuHpaZieCOVFWJv7HFZij
         4JHT7PRzye/sQmhYRSE5QY2IuxqVrh4wgyASm7Vyh/Zmr2ZRhd4Gp/34AGI3Ji+naAAg
         sPlzxNG9I53OfPSpQC6bICaJNr50NTkL8OGw0w7vih6bx67Ati7ywliVCWTuny8j3O6K
         3z8nEtysSbzS5yk+gsnBF12os44cq1+wzTbpxjEwCI4ZAOTQuTd/dTtc5qad+Pd6bLX/
         BZDwNcHFwfJKZ1nqriE0C8adYcqm4xwpfsevxMWVyN5yAJpf46tf12v/+TVEUH1hUGVu
         lXFA==
X-Gm-Message-State: AOJu0YzO0NSKyn61LVLDrVpBBw+mJcJJwduX43ehyqOREYsl+w8aIinF
        LX416htcQwcA7bfpB1QJGBtAH+x+Ki4f6XD1c1w=
X-Google-Smtp-Source: AGHT+IG2uqMJ3zfBEsleTdC4Zn3/o7Z7c/N8IeB4K/K4UHdchlfbiFeX0SCahOLq97VTr+FIEy9qyw==
X-Received: by 2002:a5d:4842:0:b0:32d:a211:798a with SMTP id n2-20020a5d4842000000b0032da211798amr2109528wrs.6.1697561514400;
        Tue, 17 Oct 2023 09:51:54 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d66c1000000b0032dbf99bf4fsm148613wrw.89.2023.10.17.09.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:51:54 -0700 (PDT)
Message-ID: <a4211fc4-a16f-4493-9ca0-9f50c673081c@linaro.org>
Date:   Tue, 17 Oct 2023 18:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-acer-a1-724: Add notification
 LED
Content-Language: en-US
To:     Raymond Hackley <raymondhackley@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20231017125848.84311-1-raymondhackley@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231017125848.84311-1-raymondhackley@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/23 15:00, Raymond Hackley wrote:
> Acer Iconia Talk S A1-724 uses KTD2026 LED driver. However, there is
> no blue LED on it.
what

that's probably $0.00002 saved..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
