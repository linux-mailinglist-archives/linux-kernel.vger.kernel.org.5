Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5948D7FFD93
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376923AbjK3Vew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjK3Vev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:34:51 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD6E10D9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:34:57 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7b05e65e784so7581839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701380097; x=1701984897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUf1IZM80yx5I/uYhbQ2wqUvHfjUSNuMsT/QakbGtJk=;
        b=BbaHP0t6Q0EnZEAP60r7SyEh/nB1VN1zWjzn4e8LNzABmWqjvg9VsJODEz+iPwV+rx
         X2kzlFiU+vZAawfy++qAFgfV0/x/NE5Y4Gyh59PWURmaYAvzFoZ5vbIROYh6yEObLx1k
         vK8bM0PsvAyLOrjroV44UE8sUUfLPV7ARnSgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380097; x=1701984897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUf1IZM80yx5I/uYhbQ2wqUvHfjUSNuMsT/QakbGtJk=;
        b=rcbjWt0dRqjaeHADqTNFGEHCccFoUpa4FZbA8pQkq/VHEnqjk6nXR16m8BGVwEKNTa
         HocwodmODDVQkPOiZ8GyJ3+EmnRdwnP1Yx0rG5cMh8B5bzinhbBDyW1V1xltwWf7jLO6
         VIGsK2/eqwx4gCI3Ct0Q7QDymRjIBLvRrJ/AduiqVLHd/vI5wMvP4Jqw9rtP2uSVaY1S
         7BXlYaLEvKpRjLJ8YKNAULGvdMka8hnD4aoffqdrHJWf9OIuAyX9Aw5cnVPS3nB6DKuG
         o3Gx5SqIaiW49FUZCAbzlrGzS6E/YS+adSM7rLzXX6hMETb/Ro/8Lt5xNdBI9I4WYLWr
         5oJg==
X-Gm-Message-State: AOJu0Yxo7fTnPw/OiyUvv9uMaYBA6qmqn+xDZAuRQbgc8cjcFox0z6u/
        EaoJDVnvqXHjVGrWaBWZRa2nJA==
X-Google-Smtp-Source: AGHT+IF4F3xQmJZ6+UhUcyzvSzVJ0VgieGSd6DoK5uGwTAG7adkjYZew6KUU27lXIsxCnovm0RJJ1Q==
X-Received: by 2002:a92:ce8c:0:b0:35c:7b32:241f with SMTP id r12-20020a92ce8c000000b0035c7b32241fmr17946580ilo.2.1701380096997;
        Thu, 30 Nov 2023 13:34:56 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id i9-20020a056e020ec900b0035aeaed5112sm609123ilk.84.2023.11.30.13.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 13:34:56 -0800 (PST)
Message-ID: <57c7feb8-9529-460d-af4e-db4591177f9f@linuxfoundation.org>
Date:   Thu, 30 Nov 2023 14:34:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/breakpoints: Fix format specifier in
 ksft_print_msg in step_after_suspend_test.c
Content-Language: en-US
To:     angquan yu <angquan21@gmail.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231128214854.60362-1-angquan21@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231128214854.60362-1-angquan21@gmail.com>
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

On 11/28/23 14:48, angquan yu wrote:
> From: angquan yu <angquan21@gmail.com>
> 
> In the function 'tools/testing/selftests/breakpoints/run_test' within
> step_after_suspend_test.c, the ksft_print_msg function call incorrectly
> used '$s' as a format specifier. This commit corrects this typo to use the
> proper '%s' format specifier, ensuring the error message from
> waitpid() is correctly displayed.
> 
> The issue manifested as a compilation warning (too many arguments
> for format [-Wformat-extra-args]), potentially obscuring actual
> runtime errors and complicating debugging processes.
> 
> This fix enhances the clarity of error messages during test failures
> and ensures compliance with standard C format string conventions.
> 
> Signed-off-by: angquan yu <angquan21@gmail.com>

Thank you for the fix. Applied to linux-kselftest next for Linux 6.8-rc1

thanks,
-- Shuah

