Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1261E78DFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbjH3TM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbjH3GxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:53:11 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D891B1A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:53:07 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bf1f632b8so705758666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693378386; x=1693983186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9pOJN0Q6wkLvMewxsTy82PsqahQrqDIj24ECvJdWCSo=;
        b=hFPOrGSG6AL5SBXwq3saM68KoWP6qmzTIlrRUhkIZiCAhFd0j0qZMLGk++XHS8YnRp
         ad9FAeprO9wlMAJQHLbQBCXJ4eh6hBlJlopnXZ/uG86awguRGOgC7F1HZfjic/mWPSnp
         6t2sHZkEvhhen+BDjtvgocdIJiBH5MRC+7pnzsqSjUcZTy2CPt5/mYC7xBLyzJmI1WAx
         8jpKOckvpWLodIDixV0UI0kHjuCsiE+K9XbYDT3k/VE6mGus2LPwKwpbzRb4BPgDNy34
         rauVepznllVEFvjA1v+lbNT7p4Z9ATbdNSodIfevbfNwMhonpzUkO4XCkC/r0ljVGfBX
         J63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693378386; x=1693983186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pOJN0Q6wkLvMewxsTy82PsqahQrqDIj24ECvJdWCSo=;
        b=jJs6kwA05bwi3wBxkIVlnN7BAPrs5zzJa34WP9onxPJQU4aPleZ0QjLHLJIhfpRHlg
         irA8a2uMIqZHY37uoyZAaxQ7fRJd8Lt9lvDlZ5QN5eJYhSw6H2oChYr7h84u5aFPwJVp
         nvMJGNpLwq1YRfR/R7SU8a66yJXyRtG7Q0zaMkADF54AjSKq9AJf9esyuhPjuBCrA8Jx
         ivxO74oCQMtZE1wd4nj4r/xR1Rkz1Pv3jS5OWoX22/mjYCm9XHH4EfnJBR4SIyr4hcTS
         /AfQ5isjJzcRhBZo2akfo9/nUnwDp3EBcuGqnw5nnjD+rZCPe/LnNd0Ui3kS0cD6ONFN
         3Jsw==
X-Gm-Message-State: AOJu0YyJ+gYmDscEMVEA8dbsf/n/HZtrbyj/gXwpmBLNRMxV/BQkDoZf
        i4rcR0nV1Uf+T9CyT0NovyvpOw==
X-Google-Smtp-Source: AGHT+IH7By/K8X7TFjmuxWQpjwkhFG9OOMBqvVumSGucfH7kiTRm0wx4GZG99lfl8UxbibAn1Rk6Wg==
X-Received: by 2002:a17:907:7750:b0:9a1:9284:11b with SMTP id kx16-20020a170907775000b009a19284011bmr990508ejc.7.1693378386280;
        Tue, 29 Aug 2023 23:53:06 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id d12-20020a170906344c00b00982a92a849asm6833731ejb.91.2023.08.29.23.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 23:53:05 -0700 (PDT)
Message-ID: <90723ba8-c511-f90c-3a1a-3c33215fe27b@linaro.org>
Date:   Wed, 30 Aug 2023 08:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/2] arm64: dts: exynos: Enable USB for E850-96 board
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        JaeHun Jung <jh0801.jung@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825215445.28309-1-semen.protsenko@linaro.org>
 <6fd3a9ab-667d-934b-f1c2-03776be93d4d@linaro.org>
 <CAPLW+4njcwODXoA3Gj=48E-DPOqofcPnJkYMv6yzF5JjyOshDA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPLW+4njcwODXoA3Gj=48E-DPOqofcPnJkYMv6yzF5JjyOshDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 02:44, Sam Protsenko wrote:
> On Sat, Aug 26, 2023 at 1:10 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 25/08/2023 23:54, Sam Protsenko wrote:
>>> This patch series enables USB gadget, USB host and Ethernet support for
>>> E850-96 board. The most major change was done in USB PHY driver, as the
>>> register layout of PHY block in Exynos850 is very different from
>>> Exynos5 one.
>>>
>>> Changes in v2:
>>
>> Thank you for the patch. Looks good.
>> It is too late in the cycle for me to pick it up. I will take it after
>> the merge window.
>>
> 
> Thanks, Krzysztof! So we can expect these to get into v6.6, correct?

No, this is v6.6 merge window and it already started. I will take it
after, thus v6.7.

> Also, I'm trying to keep track of all my patches, so please let me
> know if you are going to apply this series to your trees soon, and
> which exactly (I presume krzk/linux-dt.git/for-next?).

I always send confirmation of applied patches with reference to repo and
commit (although not branch).

Best regards,
Krzysztof

