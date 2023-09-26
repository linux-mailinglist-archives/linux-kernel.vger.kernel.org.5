Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC27AEB7D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjIZLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIZLbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:31:03 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E134FC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:30:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40535597f01so85306865e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695727853; x=1696332653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZ8NWxX3XZ8O0amBBB9fjrfirMGFwy+I6ljBSmFsWZ8=;
        b=O+p4iHf+mYTPSokCOVLWZBbouNEqzZvpLJUSYs//oCs2QjVgSUYhKIxmOgFCJGfJ1e
         x9QKfVdnXAAKSNSuIuiajKbL6ypvqMstZHiS9aQXMSKeP3FGoP+POmr1Cgv5VCnd9z1P
         JWogQISp57s4HqnMv5/Vlt32qN0yIKsi7OMx6W0EvrHw/VILe0dykwTaal8Wm86e1fy8
         JtBnCZaHdSDD/fETAWftJI1Yz+ayZXP9nCVfCuPNoDdQsUQMVKifLx4YaMCbNGRZB3RE
         n1KFhOZ/P/p3CItvup0JEwFmKAQWzMD7RFGW74LLM7dIpx6zm2YekiF0Jv312MRPYub1
         dDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727853; x=1696332653;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ8NWxX3XZ8O0amBBB9fjrfirMGFwy+I6ljBSmFsWZ8=;
        b=udUpL0BwmlEoMWuHRyEyb5q+8hSffYLo8sCVxdl/7fVNzwY9jbHZPTI7fRqT+MLMYQ
         0X+laFNBGqr3t3pZIDQRWAme3I5B9a5yen71gXZQcIrpRVjYCtqdzdMbwxPhaQVwaLZZ
         x6Tu4ZEo3/MUMSUM4LOvwEHi47oAXPiCP2v2KYUIe+D5Vs/Uq+JMyc0vVbAJkcYv76Pt
         qxAMyGwldTsRgB6nvIkMIdqDLQ5kmd02bR/8eIHe0WF1W44QKuqcAinF3r/UDxvgce40
         KQQrptUstvmJSB/fNPaog9PSh1sbJ5XsPZVfX4FifVtWuekifQpWPr4GK4RmHHQjz+Ov
         ay6Q==
X-Gm-Message-State: AOJu0YwMEyS+ZumpuRoGAjGMy5kCCAqxrIFK8T0ZLnh6q8XM/ubrYRrK
        KjiyU7ChtG2mylvH2VVUaYBwCw==
X-Google-Smtp-Source: AGHT+IFI9K3AxHawduGMPqjVMpMA9N0DyVZyAB8v27F5UVumfSRQyiThJ7rvhwgT6V4mmVLgMuR3LA==
X-Received: by 2002:a7b:cc85:0:b0:402:ee9e:ed98 with SMTP id p5-20020a7bcc85000000b00402ee9eed98mr8069517wma.34.1695727852468;
        Tue, 26 Sep 2023 04:30:52 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id z9-20020a05600c114900b004058e6379d8sm6210637wmz.23.2023.09.26.04.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 04:30:52 -0700 (PDT)
Message-ID: <e3dd5e8c-7bdd-8ff5-5f47-3e3b09f2d97c@linaro.org>
Date:   Tue, 26 Sep 2023 13:30:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 6/9] ACPI: thermal: Untangle initialization and updates
 of the passive trip
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5708760.DvuYhMxLoT@kreacher> <1942063.PYKUYFuaPT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1942063.PYKUYFuaPT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 20:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Separate the code needed to update the passive trip (in a response to a
> notification from the platform firmware) as well as to initialize it
> from the code that is only necessary for its initialization and cleanly
> divide it into functions that each carry out a specific action.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

