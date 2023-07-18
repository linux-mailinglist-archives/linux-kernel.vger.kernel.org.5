Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C3F75753E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjGRHXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjGRHXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:23:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED1A10DF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:23:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51f7fb9a944so7531380a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689665015; x=1692257015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSCltwnxHWzRk7Y0cpNIDArzz5ZlpHqXZ9iMuTI+OfI=;
        b=J3Au4Ibv4sJBTBwp5hff3IG5hjiz2HQ7R60pq1w96sXSgKgHSZpCbiEmYh6VYt5D//
         v26B4j5tRf+TzLdiXvmJDEN3otxqD4+DAiNx/xPqmiFQL5YSo6+brxkxz2Dck6rHgJQr
         Ds7UajxieXovAmZ3F8+tXxuIVvSJmCJwmOyuWsB9hllCx5+FnwCAw/V160TW6/jxow10
         NLu3hFA076fFgR9o4HOQHjlMmOVkCpmnYLsU6QYLGwiFiMWvxB5Hj7CVIkri3TsR8Kbq
         Es8YHHxXEG9wVEnlKvyrYNLXSxMVsytHlGceVn//iPMy5GMgu6U4hqhSxY6S5ikrI45H
         0yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665015; x=1692257015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSCltwnxHWzRk7Y0cpNIDArzz5ZlpHqXZ9iMuTI+OfI=;
        b=bFUaWle6rL5l45mjq/2kFWxTHJ4QSOwulbDc/RXIZiI/08eRF39OsG4ytMIqCPlRMh
         DkxhCSNhiHnB/yIcsbExJVqDYfcSBZI5sgh9slBYpG/D5zdypthotR7fD3kUn2nhn4r9
         0pMp4vcOFBchLWixmiy+bfl29W9RF/o4cTvT/4t6CFqFBb2e3hO66eGo555ZXavomooD
         nKF4hfD4zPil2vOBoDrLFAKGHgeiysO1Zb2TXm7hasN38x0PvO//RXk8ANxv7Nvnb4s7
         ZyD3Mg4KcAqqAUYvDAEOsVWyAaKigjO3IOi3ecNW1fzLopCoAg0IY6mUjW5T1SBgEr4A
         Y8yw==
X-Gm-Message-State: ABy/qLbSK+P+eDL9QXEvmgrsgLPNQA1srvhdd6wM63QRknWPtazXEOn5
        kqc1KPnIPQvJQGAINbmQ+55Ryg==
X-Google-Smtp-Source: APBJJlEJWK3IpPoAF1MaJSbNIxYudv8k8QIAIToUGUIbAOix+a6dif5mC+LwN0ZJE9o3qJu2NgnD3w==
X-Received: by 2002:aa7:cd52:0:b0:51e:3558:5eb6 with SMTP id v18-20020aa7cd52000000b0051e35585eb6mr12997197edw.3.1689665015019;
        Tue, 18 Jul 2023 00:23:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n3-20020aa7c683000000b005219864c7cfsm776223edq.39.2023.07.18.00.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:23:34 -0700 (PDT)
Message-ID: <91725f89-f3fe-7879-1346-e4cd2eb8d2e9@linaro.org>
Date:   Tue, 18 Jul 2023 09:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add description for new hwmon
 driver hs3001
Content-Language: en-US
To:     Andre Werner <werneazc@gmail.com>, jdelvare@suse.com,
        linux@roeck-us.net, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
References: <20230718070114.3871-1-andre.werner@systec-electronic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718070114.3871-1-andre.werner@systec-electronic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 09:01, Andre Werner wrote:
> This is the initial description.
> 
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> 
> v1: Using separate dt-binding hs300x.yaml
> v2: Reviewer recommends documentation of driver dt-binding in
> trivial-devices.yaml because the driver has no special properties
> to describe.

BTW, you already sent v2, so this is v3. Please version your patches
correctly.

Best regards,
Krzysztof

