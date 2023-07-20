Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A281775A62C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGTGSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjGTGR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:17:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6DF2115
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:17:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52176fdad9dso570169a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689833871; x=1692425871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qMbEIAGEmSCr9GEUb2WgyAYulDvpm3IyXUtdPprmrA=;
        b=ek55b0caiiFJP/P+T7uTJx8tiGG4WH21B7V0Q6dVTJR+wegukc/G7Rf01r3yRwUv0C
         F6eBLgypzJIkvZMT1jIIHY0kJkx94QIF+bjGEmtCFHgcXVGhD0soVVFH4RQz/u9PDBjA
         w2qJOvhwmx7aynACkrYzdG7VDvifuxfyAHazp60Ny+UJsWZGthgIXgUw5rEMX+MAzHc7
         aXU96roQGt0vZurTatFmi5XuRq0ng4bliRkcqW1SsOEYePS6VsFRWTCTbAEoprmOZMIY
         7jEHgCjIhg+z5BBUOYu9nX5e90fXS26wxiNV2DGEvLKUU06+FN6uSTnNAWTe4fSaX/7o
         5aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689833871; x=1692425871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qMbEIAGEmSCr9GEUb2WgyAYulDvpm3IyXUtdPprmrA=;
        b=RzEzG9C+VC2AYzGka2Zol6owBVzl/OKiWm3g1Ntm/ey7sld1zFl50va48f8cNjn2nw
         6mdvN0vpgBu3B03NYYK55xhAeQNfvABaw79u2z+MbHBW5m+4Chjc38pa0X5a3gJODPWJ
         fovGZoYUR+sr3Ye3JDg/MLvMoeKCj0Bc2TXmfTqROdpenm3nKSKeWThKS6n8xiNc8oNn
         etRKVUV8HhOMbU+A+3bSfave0gF32wG7iEmYjVPEFdPuUSaVdw/EwggcTzuqGFSzNUVC
         klkYRlbGnWzNxK39AerFxDiOY69mIJskA6fWvI00RWZcAS6H/WBKeXdgpPgEmZ2SskIr
         PKVA==
X-Gm-Message-State: ABy/qLYVdDRrtNm7EzyH/dLCHTWzp3Wg2yOj497ggECYzY9me9iz2YBE
        e9LuH410kbi7ufUZUvP1BxvGYw==
X-Google-Smtp-Source: APBJJlEkdm92MM7BkSSd4ckerjHjOqQNmjO4MFFqBjG59Vise3NVYmLk8X5P3s/TSXWFRG/uwFznQg==
X-Received: by 2002:a50:ed96:0:b0:521:7a5e:ab1e with SMTP id h22-20020a50ed96000000b005217a5eab1emr4205824edr.21.1689833871230;
        Wed, 19 Jul 2023 23:17:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ca2-20020aa7cd62000000b0051e0ea53eaasm261321edb.97.2023.07.19.23.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 23:17:50 -0700 (PDT)
Message-ID: <b0993a11-6589-2fcd-3487-2e6eb68e18e4@linaro.org>
Date:   Thu, 20 Jul 2023 08:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] Add support for PECI Nuvoton
Content-Language: en-US
To:     Iwona Winiarska <iwona.winiarska@intel.com>,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230719220853.1029316-1-iwona.winiarska@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719220853.1029316-1-iwona.winiarska@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 00:08, Iwona Winiarska wrote:
> Hi!
> 
> The series adds support for PECI on Nuvoton-based BMC boards.
> It is based on patches that were sent by Tomer Maimon from
> Nuvoton [1].
> Similar to Aspeed driver, unused (as in, default values were used in
> all of the available DTS files) vendor-specific properties were
> removed.
> If there is a use-case for such properties, they can be added in
> a separate series.
> 
> Thank you Tomer for testing this series on Nuvoton hardware.
> 
> Thanks
> -Iwona
> 
> [1] https://lore.kernel.org/openbmc/CAP6Zq1jnbQ8k9VEyf9WgVq5DRrEzf5V6kaYP30S7g9BV9jKtaQ@mail.gmail.com/
> 

This is not v1 but v3 or v4. Please provide proper changelog and versioning.

Best regards,
Krzysztof

