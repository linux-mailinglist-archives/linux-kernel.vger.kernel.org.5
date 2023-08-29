Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7578BFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjH2Hws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjH2Hw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:52:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B92C2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:52:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c136ee106so523082666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693295542; x=1693900342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWjuujeDinRbCkOfIRF80LwrLIijm1Mqo0R2aVGpfPc=;
        b=gx6YzkeHOufvsODbcb7b3q4eRcAulTXbQtE/5R5JjdkEtHks+MTI2jXylnsUcgRwuu
         K1FFXRU8cDF21erJidbFH1q9DDh8e8fM3xUbsR0NwLJ/FARxLTMqYtJey72QiXmxRhMC
         TQhc3Hi4b+gLK2KYklP1vIsGV+1z+KFphVt+QSKd8lI3BSC2SGeMC1nm/aV+JXh7bbAa
         n/i6bGNLKwr+5N5q2mSa9cxCyRqnvtiBzQhxcHMId7e2qhSoVhfCINfSLIJvcesKQsDa
         ptd8cPRmO5wuiXal/lFewTyVCcmzWAUjEOK0SEucYHtqgtsZ/3JwwueBygZHpMCEJERt
         lXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693295542; x=1693900342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWjuujeDinRbCkOfIRF80LwrLIijm1Mqo0R2aVGpfPc=;
        b=SPX6Mz5ee4p8B98+51wt7oP48lbd6nya15i+GWiwxrWp3I4cezcD5/IWM6mTqWz6Nc
         Cru/8xgI7s/a1l6pZsYJD6cg8wblomoCFEmj5yJScVpCdKE2Djbqxowx7N3jFQbbz63a
         UacWkU2ia6eo76JENBPi+nJC11L1/1RutJwd19OOjI/dlxbtlNdybaQPiObY/N5iLipW
         dS/yVF9IQYaRpp1Jw57Jn7C+fhkpwRClKeJMYnhYua3lY8DNJWxHpvJ4OiH6lmWcNyLd
         geL/ryKuXXiU67gCUmH1NIeA4OPeSDPusxjNS+Ph5m9I7uiYZekuKwB3M863GWuGAtvO
         Mp7g==
X-Gm-Message-State: AOJu0Yyb1n0niWpPDKISUqkfzLtvdFmFGnBDUqhgTpKLoX+EvStH9Jvd
        SndplkexKaCcFaTwwXcto8ZtQQ==
X-Google-Smtp-Source: AGHT+IFkwshq/PUTlh3A2vkwD69EMY4biooOkCcqwUxrX7p3Fx1FRoc9A8ydpg6UxHuS92fhiocm7Q==
X-Received: by 2002:a17:906:cc4e:b0:9a1:bccc:ef5f with SMTP id mm14-20020a170906cc4e00b009a1bcccef5fmr14751984ejb.53.1693295541862;
        Tue, 29 Aug 2023 00:52:21 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090626c500b009929d998abcsm5622761ejc.209.2023.08.29.00.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 00:52:21 -0700 (PDT)
Message-ID: <82e26380-d531-40f5-da79-6c4719385c8b@linaro.org>
Date:   Tue, 29 Aug 2023 09:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 02/11] firmware: qcom-scm: order includes alphabetically
Content-Language: en-US
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-3-bartosz.golaszewski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230828192507.117334-3-bartosz.golaszewski@linaro.org>
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

On 28/08/2023 21:24, Bartosz Golaszewski wrote:
> For easier maintenance order the included headers in qcom_scm.c
> alphabetically.

I assume they are all needed.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

