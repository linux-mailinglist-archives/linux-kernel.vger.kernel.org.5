Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA07C4CC0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjJKINR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjJKINI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:13:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAB8183
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:12:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-406618d0992so63081155e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697011973; x=1697616773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6f9PxZ7NB59nQPPxoemJYzPYh8nDFeCaDnmWpNpHKU=;
        b=HsktuYPFfKtG3ofm6cSE1zIo2kAToTNI3tBpAWpGJB/J8SuObZdn6Qcy2pi80HhsUF
         Bt6ORLMUzumAOhPXMFl8M7C02pK2SNfB4uRHrJVXNs3Qw4NP/OPUQAO7EL6VR2IT9ozb
         IDyh5+9sxvkFU1WCndu6DcMpkQoHrF78QzFmvoqHXktKW8HA28S24pCseWCPLMTCfKKl
         tOIN+4tJEGjRLiHuN+58R0BQ6FoeO9FzOBemHAu0g+eaKRxXNg4YoP6dpl8RQURpsvFL
         ZhRCywU+GIC0hyL15yOvl2VQ3fcJAnMRGS3yMIs+RwBmSg6ypIlpcDK510mavuX/JDaE
         +1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697011973; x=1697616773;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6f9PxZ7NB59nQPPxoemJYzPYh8nDFeCaDnmWpNpHKU=;
        b=K2ZUBtUMDCBD0Y6webZzIlVG3U7aopruAB3M7ekckcqa7jMdnLDxKlwjed/FbgStim
         CBNCPmIgqhl226FrXmApKJJV+rfjkzRchxO5qUYXXe141c8hrQxHPjEVMh15f9x8lsxj
         z5ONEMA1l16l41+EAmHUlbbt1f4hOz7J76NB7gwpBDNuyuMo7ZETT+7njrR5dHduXYCG
         4PzzxzMj5gJi3mNbq1GcjhcKqOI9j3k1Zhwrxdu2D3+ggnnJp2SWNoFPx4ClG+GpW/N0
         B37DhNwk9crvSYCsrtno2pAxLEcjMOKTGuvGU5/zsP6I8q5w3RSVywcT5GY4W+ifagwP
         gVGQ==
X-Gm-Message-State: AOJu0YzAQAkly/XUYI355yQAgEdrz/ZiQ2u2gAzLQLwqNCIoyg7N/V9P
        nmkTLDur03EF0X68mzP5nuM5Lw==
X-Google-Smtp-Source: AGHT+IE8diQCcQt4M7vNPz8Q6bxJ+rhPKeR5+b1BCErucSAs/dp1Y0sv+o1J3rlpoOnSJIwJD/WlqQ==
X-Received: by 2002:a05:600c:2946:b0:405:4daa:6e3d with SMTP id n6-20020a05600c294600b004054daa6e3dmr17784632wmd.39.1697011973220;
        Wed, 11 Oct 2023 01:12:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:de95:eca9:6b1e:b330? ([2a05:6e02:1041:c10:de95:eca9:6b1e:b330])
        by smtp.googlemail.com with ESMTPSA id t14-20020a1c770e000000b004054dcbf92asm15989831wmi.20.2023.10.11.01.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 01:12:52 -0700 (PDT)
Message-ID: <2f8c8511-f358-4c7b-8d07-29f072ee9bdb@linaro.org>
Date:   Wed, 11 Oct 2023 10:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: timer-imx-gpt: fix potential memory leak
Content-Language: en-US
To:     Jacky Bai <ping.bai@nxp.com>, tglx@linutronix.de,
        shawnguo@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231009083922.1942971-1-ping.bai@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231009083922.1942971-1-ping.bai@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

On 09/10/2023 10:39, Jacky Bai wrote:
> Fix coverity Issue CID 250382:  Resource leak (RESOURCE_LEAK).
> Add kfree when error return.
> 
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
In the future, add lkml@ in Cc also. Also the subject has the format:

	clocksource/drivers/<mydriver> : [AZ].*

Applied [with the subject fixed]

Thanks

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

