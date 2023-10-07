Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722627BC7D6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343939AbjJGMvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343929AbjJGMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:51:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01FCB6
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:51:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so27244395e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696683078; x=1697287878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvT6SDn6XOTMM7WN3V9Qer8S4PTe9uPFURCibPnQCSE=;
        b=ZuJMIs1Hc7oNXCUr9iyFyEP34sGd6DX3TWi+6E7mK2w6iXGx7p8NkqFlJHkq+hE/F7
         1PFvAhDmHk6aTp+hbV2qzby+lkT66UWMsMwh6jGrPGnL8n5cBBoJT2tfOAoWPU9Svd9I
         zWHjXOuWfJMVKTsaDcEvD4KDjjJubsQvWomZQLLFcqWwbHjqR5S7PShkWNagyNZOI2YW
         DfOZlawJgf9UP7TtdvEBQaqmdzKKSu52kPn4JN9qbGqIv36Gg+ncY7+JbwbYUtEEoupk
         0IAanaVyipj2EB355869+lPRtEmO+Udu3oFElgQlWdXszpCGmLqdrBluCdUAqtpVsKNy
         Q/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696683078; x=1697287878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvT6SDn6XOTMM7WN3V9Qer8S4PTe9uPFURCibPnQCSE=;
        b=n6XO4qX0l2p1uSJTV/40t1AUS474amu4LDuGl4vFLhOjWz4KwiQd2LfQvjN00CplTQ
         zY+o28Z0kAKqblndBwrfHbsf5TnrZZAuSqxUb049PGuKSdok1EswO6vTnazI3lgWAcC3
         h7IjQ+NexDZsVnzQqXxpz+Vn79IYqq3m+T2zsbe23b8obzqTk/Jnlgk55myvvZvaoxaS
         nEsIBtZevJoJ4XwXfCuIYaJ3pvu8FBJ+aENccDSn5s4gBi6xA8m8rs4YPl0bsdSAsLTf
         iDJr+wx+Bq1PkjXhe0WJtchVrlOmSU/BAgKlzyUGWUd4r/+4JGvegGEYbS9D8mfirbEu
         8tFw==
X-Gm-Message-State: AOJu0YyzuG/6mZrFbO8ipH/4GhvT/gNiJ+Gt5bA9pYTMrxku8OcfOyRj
        IGcMGBCLU24jXD+Xtacwk+Ttfw==
X-Google-Smtp-Source: AGHT+IFPVNcTiGWX1DJytlquK2kkJt6EJB9eK4ST5TT+6DPRGc9InfXTGto/Cfmad8KqxPyOgfdaOw==
X-Received: by 2002:a1c:7914:0:b0:401:1b58:72f7 with SMTP id l20-20020a1c7914000000b004011b5872f7mr9782629wme.38.1696683077724;
        Sat, 07 Oct 2023 05:51:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae93:531e:11ce:c83d? ([2a05:6e02:1041:c10:ae93:531e:11ce:c83d])
        by smtp.googlemail.com with ESMTPSA id z19-20020a7bc7d3000000b0040641a9d49bsm6052434wmk.17.2023.10.07.05.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 05:51:17 -0700 (PDT)
Message-ID: <f74a029d-39be-4deb-bc4f-a1bc1e401082@linaro.org>
Date:   Sat, 7 Oct 2023 14:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] thermal: Remove Amit Kucheria from MAINTAINERS
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>
References: <5725069.DvuYhMxLoT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5725069.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2023 13:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v2] thermal: Remove Amit Kucheria from MAINTAINERS
> 
> Amit Kucheria has not been participating in kernel development in any
> way or form for quite some time, so it is not useful to list him as a
> designated reviewer for the thermal subsystem or as the thermal zone DT
> binding maintainer.
> 
> Remove him from the THERMAL entry in MAINTAINERS and list Daniel Lezcano
> as the new thermal zone DT binding maintainer.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

