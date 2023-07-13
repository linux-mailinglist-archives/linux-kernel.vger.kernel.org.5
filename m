Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB5752813
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjGMQKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGMQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:10:28 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DDF2729
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:10:24 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id ca18e2360f4ac-780c89d1998so9029239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689264624; x=1689869424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6kF5J9L8hSVht0LDbW0wdyFD464/aZLfOhvZndOBrM=;
        b=Asd4eg8dXHApU/P9YlIq2nWXTq0m6JoYa03PiZm2oVayPoJl3KIUjhHeDkMkZpCzK1
         0VGJn7uZghpTMvZtqI4dgxsNADJ2/bDMPbYkfW6UFffLoLgW/2q5yNfHMl3Tg2sSS6Jv
         nJQKJOE9BSnMjGfI2qA3wRjsUt5Vx/02Z1zXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689264624; x=1689869424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6kF5J9L8hSVht0LDbW0wdyFD464/aZLfOhvZndOBrM=;
        b=fd1eYK+++gz47V4Im7U+VmvWGBX1306/IFnQAb72+gQl9R73jtQIIJ64qev45sni8a
         fTbeqUzWJhxgGxNsozVuA5eJj4k9uqlga24SK3xSntdLhwQIAsYpnDVK4qxZUBVIKfH1
         mI96l8mNEWx0Odxp2DVCf96KlTqiaQm8ekGD4+RucJqahgULdaTXQ0k8qkX8eYWR71tc
         S/ry+n8EGFC/mCm0aG13LOveRgqiFx4KyJ+xuCj5/B2GSAnTAOwVoPEJQcEOzdpae3to
         rFc0tBCHpMtSOuER6JpqWlMJUEUuiXlH1PyS5aJ/FlTvbo8oNxyLUsWrpDtiWAMm5Z49
         1yvA==
X-Gm-Message-State: ABy/qLZtXrY+TpaoyrerDfZR2aZCi2p0nxJCrEdmcfDY//sdU5ZtyeD9
        KpvPysD0Tjr4jOKOLxspTwWAqA==
X-Google-Smtp-Source: APBJJlHmZi6lPPKB4F1buWNz4UD+UISqbXEIMU4OCfSwBw3LUO99fP9RYXgNY7+i2bAvahU4qiebqg==
X-Received: by 2002:a05:6602:3ce:b0:780:c6bb:ad8d with SMTP id g14-20020a05660203ce00b00780c6bbad8dmr2408456iov.0.1689264624024;
        Thu, 13 Jul 2023 09:10:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z16-20020a6b5c10000000b0076373f90e46sm2032223ioh.33.2023.07.13.09.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 09:10:23 -0700 (PDT)
Message-ID: <758cff83-7307-8bed-8c13-fd747a106396@linuxfoundation.org>
Date:   Thu, 13 Jul 2023 10:10:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Documentation: mm/memfd: vm.memfd_noexec
Content-Language: en-US
To:     jeffxu@chromium.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230629232501.4157671-1-jeffxu@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230629232501.4157671-1-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 17:25, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> Add documentation for sysctl vm.memfd_noexec
> 
> Link:https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
> Reported-by: Dominique Martinet <asmadeus@codewreck.org>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>   Documentation/admin-guide/sysctl/vm.rst | 29 +++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 

Looks goo to me. Kees and Andrew might have comments on the
specifics.

thanks,
-- Shuah

