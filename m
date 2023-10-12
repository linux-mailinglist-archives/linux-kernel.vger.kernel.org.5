Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206297C786D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442861AbjJLVPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442682AbjJLVPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:15:09 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0489D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:15:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4066692ad35so15301205e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697145307; x=1697750107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXj2JrQj56sgWsNLBX3n0JJqicUacQ5S9A/AXrcip2E=;
        b=TXpzMrw+jjofLXYR1SeP8AWuHL2wWVhNj19yQmFhoBs6dxOBcklzh/DroXZFyMZjau
         X8lLBJvXulcN1o4zp9sPyr/SUoWmnyCxT/d0oA9DPtgVbDCKorxG+ZnxmjX6F631YM63
         5KzZeSku0b+738/RtYBew7mI/3JiShGaHNUFJm52T4ip+32soZl6V17JAvq/vHtXmzDp
         ybWNQvNe1Q7tgJDUSJSAVMde7ADUs8isSCwqgdnFCm+hJaWMxSn3qM3vD9GTqHbqESLv
         wUGv/RZbKZ79h8/WLBFySv23c1W0uQi3VptTLx6QAuKyynVyd89srAL+hHKsJsv/SbBw
         fjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697145307; x=1697750107;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXj2JrQj56sgWsNLBX3n0JJqicUacQ5S9A/AXrcip2E=;
        b=sedCiT3krm887oMpjvHoUSdAavxrl2ZBXebHtUvekYSlHhRPscKmiDP633pkHAngqb
         qPP+7J4Szk5zh3RB7TLycFZDcixxmNMLn3UmDypB+D1YQSPQt6N1pCwWEMsjg9UJxp3q
         P4f9XA5s0/m/Tc9PfAhANytVDpGC7MrtXaKJMRL0bgu2RbfIfTYAmf/kS3M98DTB8W8i
         qM/y/k4nO8EgqvKm6wFxIegN2sMoE5ZxQHyEkNkviahOLnAZ8PmPFaP+EuzxSzVuN6l5
         jhkGHpdmz3WE70tQ7s3ZY8J4ls/5EwtUtsvPuoidpbzjqDmT5hXTtlf4CW4xvsiNB2XL
         4UKg==
X-Gm-Message-State: AOJu0YxJtbTX1dg/w33Rqx/iWStmRSfC7HIRi8zymGrqm4x0svS78+IO
        4n4yQGBS9jIbwhzSrddmwqNAbA==
X-Google-Smtp-Source: AGHT+IHzvIxR4s5jjJ4TBL6sFjqX8qfM2TNzRyoAL30WuuFBiuKX6R3ZIcDp2KOD8leDEtJD0bLmQg==
X-Received: by 2002:a05:600c:684:b0:406:8496:bd8c with SMTP id a4-20020a05600c068400b004068496bd8cmr21767568wmn.20.1697145306267;
        Thu, 12 Oct 2023 14:15:06 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id l25-20020a7bc459000000b004054dcbf92asm779383wmi.20.2023.10.12.14.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 14:15:05 -0700 (PDT)
Message-ID: <519c78b8-55b4-4774-92b2-ae3dece9bf09@linaro.org>
Date:   Thu, 12 Oct 2023 23:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] thermal: trip: Simplify computing trip indices
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <5734364.DvuYhMxLoT@kreacher> <4882956.31r3eYUQgx@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4882956.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 20:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> A trip index can be computed right away as a difference between the
> value of a trip pointer pointing to the given trip object and the
> start of the trips[] table in the given thermal zone, so change
> thermal_zone_trip_id() accordingly.
> 
> No intentional functional impact (except for some speedup).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

