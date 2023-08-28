Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6489F78B87A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjH1Tez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjH1Teb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:34:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F49188
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:34:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so4817092a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693251266; x=1693856066;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2coO1h012/oKjichr/wIa11w8Pbfe2OzSpP2nef9GgQ=;
        b=jjNxcPpKqgHSNUm/qblIO2MCLRET1PFeOPng3VWSGaJGXfrIEBHooMtQgmoD+gMOAQ
         KXuInjpAFMJBKtJ1rRsrWDJWQGyN6D2efjJcDd5J+Iqr5LdvZHow+I8UJpbiU84y8V4M
         4ZIhALkZy9Tm+4NEUKhTUjmwP9FPQUeedCRGb6fSSb/esWN+09G1a//5YzyZZtXA5ro+
         w5hhyuJ1tO4jmaoHoJLF9pM9ccsSkh0m3jy3btuMV6/7WECej/sjZz5ibKoynvftWoeC
         S3U7ErSe04OFr1bQ0xBGuTrg60w0WIh8VSl4zgGZI45EvHWuMJDfWHUQFWxURoQIGWuc
         bmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693251266; x=1693856066;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2coO1h012/oKjichr/wIa11w8Pbfe2OzSpP2nef9GgQ=;
        b=KuiEjn84Uvr2RFDfhaBEAuNk5FM+s4m4+c5uigt6D8dLqiAW88fsVRhMUkflsDq6el
         7rxkhMywtNO04lsw8QcA0wowNmIg5EAuQ7JMeYnHb8CA4qs1jyOpQTPN1fei/+Oc1zPX
         JHMgymX8N/Yo2hDTyp3p+aMtVPlte9BKXf2HjjgPQnoVRO74nys0Lrei4OOzli58uwU3
         vQ5ZDFUWP5CCj+woK58EluscjU+CS56TqSCQNwUtfyGdR3nFwyGOGOZn5B/ZgrEZKu2J
         m7fKzQR0jrwxUrl9YrifIft6tXRnZeNP13yCuIqaDKOJahdGTgF2mXIFEfkAy8fDrs7Q
         Jncg==
X-Gm-Message-State: AOJu0YwIHczmfJ6EaK6OSRgIBoeeMIsgYfjBgm9gPcezNi/mjO+UB7y9
        /OeWRxZbomllNnKMIBtEQ33lSRpub/fj/mSwooU=
X-Google-Smtp-Source: AGHT+IFWdt05+lelrHt3ly0RYGyDoWzb5bDDXZMDKF9y6ivOHq267LiJCFqK9wIyj5FoIv5nrMBGQw==
X-Received: by 2002:a05:6402:398:b0:523:2e30:aaee with SMTP id o24-20020a056402039800b005232e30aaeemr18513536edv.32.1693251265893;
        Mon, 28 Aug 2023 12:34:25 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id o7-20020a056402038700b0052565298bedsm4741436edv.34.2023.08.28.12.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:34:25 -0700 (PDT)
Message-ID: <867ec3f0-1a43-8d1f-1475-363fc660ab60@linaro.org>
Date:   Mon, 28 Aug 2023 21:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 7/7] arm64: dts: qcom: ipq5018: Add thermal zones
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-8-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693250307-8910-8-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 21:18, Sricharan Ramabadhran wrote:
> IPQ5018 has 4 thermal sensors (zones). With the
> critical temperature being 120'C and action is to reboot.
> Adding all the 4 zones here.
> 

Not much benefit of having it separate patch... You added the
thermal-sensor for this purpose.

Best regards,
Krzysztof

