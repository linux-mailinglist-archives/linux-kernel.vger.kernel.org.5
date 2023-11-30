Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF67FFD9A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376934AbjK3VgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjK3VgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:36:05 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB8510D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:36:11 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b359dad0e7so17287039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701380171; x=1701984971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fp9VwMviLQPX+3MgbIIB9b/GRHCxnV7F0fIl1aHZ/II=;
        b=Ojgf22BKf0uNQ8mI1jxosdZFX/3I3k8OAhrRpA61aZ9uxabFApYxdLm9MCbnx/neM5
         b9WW9+nmijBj+emHoaAmFxo2Ot+HjmtHIhlT18QLPzvqKJcCrfY7RrOzRPIzD2De9mLB
         gRNIGChrJ3Zn4Evvb9ao8bjfqPGYA3Ta0wRxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380171; x=1701984971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp9VwMviLQPX+3MgbIIB9b/GRHCxnV7F0fIl1aHZ/II=;
        b=SICpIVL86jFgJEIp15sN8Nmkb9cLSc4+dgeUiQhhbJ88kdVAbEBvZLIlGtJ6LfIQ7Z
         3cvFScAPku/oT/x3YI46NRkIu/v29fJ7lINdNajOuINp6KO3WTqArqZucta/g7xdElIm
         ajgJNsfM6yjGnYT5r88FeHnR8Tnv1hCfR4BeZtUzr0LVk2E8Ceich2EyTjGUWjQDn1L5
         XD5UiTqUljiE4X/uhvYsKLcqHUZLXmv8THHhHTZ6izC80fecH2E7NVERN0bpYD+onRyw
         Ba9XuFhfNjE1ppq1e2qsUNmMX8eDtxnjU7tFGuMSs3gaQq+nCkN4McRYwuHAXWcsRR9F
         1Ruw==
X-Gm-Message-State: AOJu0YyZiVoe7ygcGqZLMeUMcrDiCL8oVkd3Sqeg+YcfVg9I1IFPIkoH
        NnKSnBMfmQfpIDiIcYSXkWw43peHHX148s/iRKo=
X-Google-Smtp-Source: AGHT+IFAje2WETdYrzqFGUkr/49oxBQQwP5VhDCh8321mO5Pj1w3J8co5z+7nxeYC4a/pt7umT+5aA==
X-Received: by 2002:a05:6e02:1b05:b0:35d:f2b:4992 with SMTP id i5-20020a056e021b0500b0035d0f2b4992mr3016222ilv.0.1701380171001;
        Thu, 30 Nov 2023 13:36:11 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id i9-20020a056e020ec900b0035aeaed5112sm609123ilk.84.2023.11.30.13.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 13:36:10 -0800 (PST)
Message-ID: <89e0378d-f03d-42ef-9495-ada312dd5139@linuxfoundation.org>
Date:   Thu, 30 Nov 2023 14:36:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:breakpoints: Fix Format String Warning in
 breakpoint_test
Content-Language: en-US
To:     angquan yu <angquan21@gmail.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231129035726.6273-1-angquan21@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231129035726.6273-1-angquan21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 20:57, angquan yu wrote:
> From: angquan yu <angquan21@gmail.com>
> 
> This commit resolves a compiler warning regardingthe
> use of non-literal format strings in breakpoint_test.c.
> 
> The functions `ksft_test_result_pass` and `ksft_test_result_fail`
> were previously called with a variable `msg` directly, which could
> potentially lead to format string vulnerabilities.
> 
> Changes made:
> - Modified the calls to `ksft_test_result_pass` and `ksft_test_result_fail`
> by adding a "%s" format specifier. This explicitly declares `msg` as a
> string argument, adhering to safer coding practices and resolving
> the compiler warning.
> 
> This change does not affect the functional behavior of the code but ensures
> better code safety and compliance with recommended C programming standards.
> 
> The previous warning is "breakpoint_test.c:287:17:
> warning: format not a string literal and no format arguments
> [-Wformat-security]
>    287 |                 ksft_test_result_pass(msg);
>        |                 ^~~~~~~~~~~~~~~~~~~~~
> breakpoint_test.c:289:17: warning: format not a string literal
> and no format arguments [-Wformat-security]
>    289 |                 ksft_test_result_fail(msg);
>        |    "
> 
> Signed-off-by: angquan yu <angquan21@gmail.com>

Thank you foe the fix. Applied to linux-kselftest next Linux 6.8-rc1

thanks,
-- Shuah

