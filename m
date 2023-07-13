Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8311752AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjGMT17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjGMT14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:27:56 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62702680
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:27:55 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7748ca56133so8522739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689276475; x=1691868475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CT+qxyWxH2Nu0Qyc+YNIBn3InMKp5DAfdBZzQUEWfjU=;
        b=Jw5thO+ua0QoDHT/Rm2ETk1oZ5ujR/YQmbuwlDg5mVpx9hVM3XflNQ6mkxOW1dxE0r
         5zl+FLgt5+zt+rddyD0z5zKkgoblqNNLUG/yBEaMZjVcChgvp6QC42joyMJ16eaj2b0q
         YfUoXpXCrw9C1nBn4yasxJ9uZj9d9T32rF+N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689276475; x=1691868475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CT+qxyWxH2Nu0Qyc+YNIBn3InMKp5DAfdBZzQUEWfjU=;
        b=K7LT7pfFwwaqDU1iH0BNM8e7/wk+01xVfPomMub9jq97bCrzb/p04PlnhEreKrYqIh
         e7iMFpv6WXMTYKgzNKuZIRzX+Dbd7u1TjS0QVs4RfooYDFFY+3PuNTyT9Kcyg1qUEqqC
         uJr1q63XwfCcwrB3VZOzZDuL2jlNrdr386tZgZvkboKtGAly+fjSnzQ+8YjMz+Z5q0fO
         R7BIjPLcyU/j6E7WZm4RMM4ah60pBnEF9O0ncN45jzbGFtdf17z3PQUSyd74KE3Wo6JW
         grM3p1abPwQJu34z4t8D7m7fN7TK7XWIJ2V6p6wJLyBJPe1TdtE08SSuDobwABru7f27
         83tw==
X-Gm-Message-State: ABy/qLZHB+JoZTzL2BPQ0xW7mz39JUpTBka33uMhYRP6oSeLRl4QgC8g
        kyZ1mbbF1v7+OK3Hp5PQz8Xf7eKw2pMNNyWXg1D2HA==
X-Google-Smtp-Source: APBJJlHf4fpd1ux32VW16o6j4JmXV0jq7T34xCB/Wzg40SA1j7NPQD7qa+nbsLs5mmBlWJvQBe7lnA==
X-Received: by 2002:a6b:8d10:0:b0:780:cde6:3e22 with SMTP id p16-20020a6b8d10000000b00780cde63e22mr2664092iod.0.1689276475057;
        Thu, 13 Jul 2023 12:27:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d6-20020a02a486000000b0042b0ce92dddsm2008246jam.161.2023.07.13.12.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 12:27:54 -0700 (PDT)
Message-ID: <fa2e9dab-9bb0-8532-e716-28fae25a955b@linuxfoundation.org>
Date:   Thu, 13 Jul 2023 13:27:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2] selftests/input: add tests for the EVIOCSCLOCKID ioctl
Content-Language: en-US
To:     Dana Elfassy <delfassy@redhat.com>, shuah@kernel.org,
        eballetbo@kernel.org, usama.anjum@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230703094722.909348-1-dangel101@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230703094722.909348-1-dangel101@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 03:47, Dana Elfassy wrote:
> This patch introduces tests for the EVIOCSCLOCKID ioctl, for full
> coverage of the different clkids
> 
> Signed-off-by: Dana Elfassy <dangel101@gmail.com>

Thanks for the patch. Signed-of-by doesn't match the from
email. Please fix that and resend - please add Reviewed-by
tags to the resend

thanks,
-- Shuah
