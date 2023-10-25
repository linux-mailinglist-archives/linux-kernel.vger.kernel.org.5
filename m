Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B107D65E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjJYI4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjJYI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:56:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69154185
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:56:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507ac66a969so7206675e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698224191; x=1698828991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcWDpz6RiebILDq0MkRy3/6J4V7vqmXqPyZ0jkm/G3U=;
        b=gzQpDUt+LhTYuB83RhcDhHITcJjaBGxZMj12pqjGU0M/q/1EsJDBG7YFvo4bHejD3H
         iSMfInT+AYNXcx7z/V4i1ZG6oFjacRWI/d17Fhek1uGOlOSjdVchbPCeoGY48nHRrtRj
         uSnNiPz91kxq1oqO3zr0RtaZH7rfuCCqcYfq3UE6yK2OK/jPxIcOjkLvo4XwNqbIb4g6
         MAN38g8Z4Eyp7W7Hh+g8yGgx4XIlHA8ymsbWq4Hly+gkZQ8XQ65cxi8vUsUYf8AqYtVQ
         onFZ6uyqzJANlpQxt4MYXrAxfczzCwI+fmZelDqOitSIzp83Ix+pskiOiyJMeMoLzgHI
         Teyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224191; x=1698828991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcWDpz6RiebILDq0MkRy3/6J4V7vqmXqPyZ0jkm/G3U=;
        b=OnqwnEIDZ55glJ02hgwyBdJZTWbvROooplWDRr8RiJ/YfQwVrC7ltA40FeHp33c5KO
         ctIp3sG1AvPhKRpSff6zylf76pBMLfj2J8QIfrZPqb8P7q/OIb3rrbrpWKzeAEOXEuEd
         VpjMIT04cAjAzEqRyBLI9UUiYSY/7q/JxQfWLj26EGvpA2R+9AitABNO20EhtT846P8K
         tPBwI+bon+BQXjtL5f9PP2zDgrMdaIdvtSI2pvahZWfTCQBLby8iwGvoWuXaM3hLgKqH
         TzQ9PCzIexouys+PKtFe86ScEUsHmkcAhLCoEhRQ7RdymP7dF7BeMRGiD6sP8PfEYNX+
         l0/Q==
X-Gm-Message-State: AOJu0YzICauXk7/QELGTTcPFNf27fxF45ur0/Uiprf4Xzj77G4bYIB9P
        KszYnpU8W4JQXZSfstlzj6HU8w==
X-Google-Smtp-Source: AGHT+IFcsjDaRKHtNQkrRrpzaJTXYCgCXDLm2TWDrR2cEO93ECaEjWZjYH7DVg020p+sK7+GfwmO6Q==
X-Received: by 2002:a05:6512:2825:b0:508:1690:d825 with SMTP id cf37-20020a056512282500b005081690d825mr1167879lfb.21.1698224191151;
        Wed, 25 Oct 2023 01:56:31 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id e7-20020a05651236c700b00507a3b0eb34sm2468030lfs.264.2023.10.25.01.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 01:56:30 -0700 (PDT)
Message-ID: <a42a913d-b0b1-4645-9f60-0163bc93fc85@linaro.org>
Date:   Wed, 25 Oct 2023 10:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: socinfo: Add SM8650 SoC ID
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231025-topic-sm8650-upstream-socinfo-v1-1-6776a5183fa0@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-socinfo-v1-1-6776a5183fa0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 09:31, Neil Armstrong wrote:
> Add SoC Info support for the SM8650 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
