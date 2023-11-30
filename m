Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9000A7FFE10
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377059AbjK3Vy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377029AbjK3Vy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:54:56 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3895010DE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:55:03 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b393fd9419so7923339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701381302; x=1701986102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e04FJ5HkCxCNtwu/2sZDSNmWApJID/B0pVuXmiOybLU=;
        b=bI3/0Z3yaFfg5mTTaeGPIiomTbMIBAzd3d7/DmcnfgXjHaKsbBmovLVqVUy2jkE6vz
         qDvBLlqOfsJS0X26huoYtKHKcGtvTPR1RMVMGqIBzAnzBKo9JV7vpsEi9yBEueH8Dq0E
         ylsYWQzAixpHefuc3Un9UqFiCDePhK5LxTeEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381302; x=1701986102;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e04FJ5HkCxCNtwu/2sZDSNmWApJID/B0pVuXmiOybLU=;
        b=r/0Tumrc4d6BP+rAvIGKgOqVDLveez3mF2nX+0r3rqUr3uq3/W55s9wAa2SOVqT7kP
         NELeu8jrRGFetaL6ps+/aJkjn/36RUuJsrm0G96IanHL/1t6sKW2075/nzPpygMXExtc
         4iXMeXcKUZKbE0W27jpsj2hD2UALGg27p90KfjX2uAXzUdR+JvjuRummOT0wbQzNhx1V
         5uVzla4SX6zOq5RIVaroKrHUbA1DCwo+64UknDOG06a4IqWagftDOPv0aev5TwvnPLHj
         UEvDPPvehq89R6UXsudtLSfGlQBdMlffHip3RlOtVxyF9FKfvDKvTjxAMAsJ16IkeAHt
         yg1A==
X-Gm-Message-State: AOJu0Yzsh+CaK0/FaaHi/6//ltU1Bycp4NfUJ/WoaVIlWNbff/VmGO9E
        qnUnGH7po5ThlS/cc86sk9NEeA==
X-Google-Smtp-Source: AGHT+IHzdE0Pvg+4VyN4syVAt13mooU7RiUg8cDjPxDm8LSTAz93fMDB2rm9Jmm9vXmZS8r0gn3ayQ==
X-Received: by 2002:a05:6e02:4a8:b0:35d:39b1:6282 with SMTP id e8-20020a056e0204a800b0035d39b16282mr4330767ils.1.1701381302597;
        Thu, 30 Nov 2023 13:55:02 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id n7-20020a92dd07000000b0035d4633cf5dsm325408ilm.61.2023.11.30.13.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 13:55:02 -0800 (PST)
Message-ID: <329c848f-fa31-4902-9519-da771da0fd4a@linuxfoundation.org>
Date:   Thu, 30 Nov 2023 14:55:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] kselftest/vDSO: Output formatting cleanups for
 vdso_test_abi
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 03:45, Mark Brown wrote:
> These patches update the output of the vdso_test_abi test program to
> bring it into line with expected KTAP usage, the main one being the
> first patch which ensures we log distinct test names for each reported
> result making it much easier for automated systems to track the status
> of the tests.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Mark Brown (3):
>        kselftest/vDSO: Make test name reporting for vdso_abi_test tooling friendly
>        kselftest/vDSO: Fix message formatting for clock_id logging
>        kselftest/vDSO: Use ksft_print_msg() rather than printf in vdso_test_abi
> 
>   tools/testing/selftests/vDSO/vdso_test_abi.c | 72 +++++++++++++++-------------
>   1 file changed, 39 insertions(+), 33 deletions(-)
> ---
> base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
> change-id: 20231122-kselftest-vdso-test-name-44fcc7e16a38
> 
> Best regards,

Thank you. Applied to linux-kselftest next for Linux 6.8-rc1

thanks,
-- Shuah
