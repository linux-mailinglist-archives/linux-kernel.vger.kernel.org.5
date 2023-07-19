Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0414A75A088
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGSVY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGSVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:24:56 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F96A1FC1;
        Wed, 19 Jul 2023 14:24:55 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b9ee68396fso87275a34.1;
        Wed, 19 Jul 2023 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689801894; x=1692393894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OC9W/ru4ocR8OvYAbG2O3wH3VOR2zqO7MLlyAgcM980=;
        b=eD7b5CxrRZkV5OXvF04u31ymhFVj3gEF8Oljj+1gr7TQ5H41M6um3Eqk6dCZ2pDh01
         GD4w6OfiAsEn8HA3NoiWlm8hwTSgBkMaMApv4MwHj45a0a7+Cd6yt1kg41kvmm/wv3+7
         42HlVjNTgOTOvJrXjgtdkH8bnIfTXgX/zYNgICO+DvqzC+CwkGUNtKcs/7q8aIlHfp8D
         Am8PHZI2eR8FMfEbJhRwyTfOxeZLxLRzz0gpDboMlPnNex8pg6I5eZ6bSfu2ou5XQQFc
         8HUUwPy5srfiwx1mEWJFmcnv9mKDb0/ybcPepKihAxalrgt7wEF3NprlhHXkddxfKmAj
         jC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689801894; x=1692393894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OC9W/ru4ocR8OvYAbG2O3wH3VOR2zqO7MLlyAgcM980=;
        b=Y7k6QVByPAqqbfF0EOPDjtv1Z1TC9PBtxIIdlzLc0GFfGdNytqw5BB0/XicNZYn42z
         cyYFf72uzbY2lc3md7daoldP/TODm8bGiT/jPfyVUYg05ONh0kbIo+MCamVxMkhqT1fu
         7sJHwM+xuW4pVNPrxAYq/1TIxpNR5Kw6GEf2hyBzDJCrjSwXF1LJb5MVKl5N/CBlTTCo
         R08JKqUIQfP1jAcQEi2yWqQsn6L95NWBySM2axori3YkI9aHu/Qfbe85aEy5vaD+3p+Y
         eGu9ZGBLdZ749UD3wSALOkt4dAa13jX6OtvEwVw8baaopHQGaFjuBCnWSPDgDZbsqxhw
         GE4g==
X-Gm-Message-State: ABy/qLb6BDMLb6AXb8HtIrDUbtb+xsniqIoD1Twkq6Zd0sc+vcs6VZ9D
        6K8HZ7GCabdcWSYJ42RFpfdFDPIBnWs=
X-Google-Smtp-Source: APBJJlEfQbxbs2VPpvjhzCs0W0/1n62SCeVFO3BsnpwT2bdxEdZxIco5qwQIAqxW1av8u8C5GqbaqQ==
X-Received: by 2002:a9d:7b4c:0:b0:6b9:5b04:8cb0 with SMTP id f12-20020a9d7b4c000000b006b95b048cb0mr970558oto.9.1689801894113;
        Wed, 19 Jul 2023 14:24:54 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id q18-20020a9d6652000000b006b9b0a08fdasm2106327otm.59.2023.07.19.14.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 14:24:53 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <d29c7e51-deff-c82f-81d4-8322b0c28d22@lwfinger.net>
Date:   Wed, 19 Jul 2023 16:24:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Crash in VirtualBox virtual machines running kernel 6.5
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <ab3a70e9-60ed-0f13-e3d4-8866eaccc8c1@lwfinger.net>
 <202307190823.086EFD42D9@keescook> <202307190835.752D710D@keescook>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <202307190835.752D710D@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 10:36, Kees Cook wrote:
> Okay, please try:
> 
> diff --git a/fs/vboxsf/shfl_hostintf.h b/fs/vboxsf/shfl_hostintf.h
> index aca829062c12..902fe3224453 100644
> --- a/fs/vboxsf/shfl_hostintf.h
> +++ b/fs/vboxsf/shfl_hostintf.h
> @@ -68,12 +68,11 @@ struct shfl_string {
>   
>   	/** UTF-8 or UTF-16 string. Nul terminated. */
>   	union {
> -		u8 utf8[2];
> -		u16 utf16[1];
> -		u16 ucs2[1]; /* misnomer, use utf16. */
> +		DECLARE_FLEX_ARRAY(u8, utf8);
> +		DECLARE_FLEX_ARRAY(u16, utf16);
>   	} string;
>   };
> -VMMDEV_ASSERT_SIZE(shfl_string, 6);
> +VMMDEV_ASSERT_SIZE(shfl_string, 4);
>   
>   /* The size of shfl_string w/o the string part. */
>   #define SHFLSTRING_HEADER_SIZE  4
> 
> 
> The size assert doesn't seem to be used anywhere else, but I can do a
> more careful binary analysis later today...''

Kees,

The testing was harder than I expected. My standard kernel would not load the 
system disk on the VM, thus I had to build one using my distros configuration. 
It is really painful to wait for all those drivers to build, but I figured that 
might be faster than trying to find the incorrect parameter.

I can finally report that vboxsf no longer generated a BUG. It is getting 
farther, but I am not done yet. It now generates a line that says "Unknown 
parameter tag" and then hangs. I have not tracked that down yet.

I was not aware of the DECLARE_FLEX_ARRAY() macro. I had considered removing the 
union and creating a simple string[] declaration, but I do not mess with file 
systems, and decided to let the experts handle it.

I will let you know what I find about that unknown parameter. It probably is 
coming from VirtualBox.

Thanks,

Larry
