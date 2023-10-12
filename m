Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB07C7156
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379324AbjJLPYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347274AbjJLPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:24:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298E5C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:24:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so11366175e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697124242; x=1697729042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=We1PipUaRJ2GmRv7NyqA8SqBPMWku7fp5p2NGcKu6y8=;
        b=ajGpRcEtYpHcL/8N/myAF5/Jndhkzr85EAjL8k5M3hiW/C6VlmFOIW77msi2f98Xgg
         FQQv+cPv1ZH3KySqW2LWPzz2JMthb0rw2B4wFGyPV0i+OJ/fgF0u3VYjXzcrTFMAL5jx
         y4kbDpSk/8lDFjZCIH6vlyAzhp0VFCWXgt2zSZ92GzuI2wecJ6WXAmYKP5jkDZtCmZm/
         djJDkE9A5p2QYcSbCG+3Al1xkoU4S7Wd+3AEde772zUjqpXrR7k7AkyphRQetLrUPvd6
         IUOfoxjvBBGwhW2uToLjKC4KdX6ss0vSdFhtS/mWCLisMH2uGPqd7WAk+TTu/tJO5tsb
         R10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124242; x=1697729042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=We1PipUaRJ2GmRv7NyqA8SqBPMWku7fp5p2NGcKu6y8=;
        b=Hh8UcYhO8YCF8l6KoAPbWFU+xNTkURZculrx9iFf+xMiX2mc1IIWKJsTY75gfA+2kS
         Ygk0dm1y5wrKxLWlX6/BmXSlzXIAQwDkmptnt0647AtxWMdT/W+dV8oU1E8L2jJjrzY1
         lkxt07PVXGXlgBL4Rypm1OQc0DcxTpgXt2dc57KUywnvW3zKDDfjBXK+AKrbP3lPzliI
         vmcF4xNEuHTRYHSc/E92zlOmJ5UG5NFfuGAtJo+MUAU3yyHAb/0oKflLZ81Qb96e1wy0
         vQ17HiO222DOqTjgbONWo4TdFvmWF6UQaRD2sWTeSnQEc2tlvOqcAeW7axyyYH+pscSc
         kwrA==
X-Gm-Message-State: AOJu0YxXV3Muc7GDic0BDVM83MI+biQFF48qJ1TRbo62G2JLuEyw+gxP
        iWAZj/4chlbAxNHat6NM3gJPhA==
X-Google-Smtp-Source: AGHT+IGaTzOx/6hybNBs9W8g0AcuD4Z+IJKW3BY68R2VfyDSeURDOB+dCGHwpPdaNmhmzzqe6VG29Q==
X-Received: by 2002:a1c:4c13:0:b0:406:7d74:a29b with SMTP id z19-20020a1c4c13000000b004067d74a29bmr21127609wmf.13.1697124242353;
        Thu, 12 Oct 2023 08:24:02 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id q19-20020a1cf313000000b00405bbfd5d16sm119132wmq.7.2023.10.12.08.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:24:01 -0700 (PDT)
Message-ID: <d248e126-2b0e-4f9a-adf4-94740dc472da@linaro.org>
Date:   Thu, 12 Oct 2023 17:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] thermal: gov_step_wise: Fold
 update_passive_instance() into its caller
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <13365827.uLZWGnKmhe@kreacher> <9177552.CDJkKcVGEf@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9177552.CDJkKcVGEf@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 19:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Fold update_passive_instance() into thermal_zone_trip_update() that is
> its only caller so as to make the code in question easeir to follow.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

