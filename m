Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF0751A43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjGMHsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjGMHsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:48:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07454210C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:48:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94ea38c90ccso13485866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689234507; x=1691826507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ndfusz0Ew/9H13cssvGl1gKVP/EEjfBAeT0WImx1s0A=;
        b=r86uCzU4iB9lwWfEiS3ussRwFswjnDBQ/4gqjlxMOjWzH0Qb0gutW0d7sO2ZClx3MH
         Nkp/hMES+SBk6ONcS1O+oiwR0ZN+EzAamjTpQFa/bshMv7toMl/kUNL/z63avF85f4ME
         O4o3FlENc8fFDD4ZG3sz9B5G76S8gxgZjFvrkZrmiovm5aSXG6XVi9sFOiUEs+MqD7ZJ
         kqgVth3NRWPaw3H2HIBCCu6I5GWSylphAhgs+ocJ7yPS76THPgJPKR34X4iJ/E3x9cvG
         N224oIuLyaf1+59M8Dh5tNjslYce4MXpAHz39f10gPtS7v8HuWfrVbUowBm5bIop0fX6
         N0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689234507; x=1691826507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ndfusz0Ew/9H13cssvGl1gKVP/EEjfBAeT0WImx1s0A=;
        b=RDnACOx+Za4XBGPdoA0Nz5WReLzZNcH/a8jC91JFJ+fjgS2jazrNAAcczbhYCK+Qsz
         OQsCeRLwv8QjRYdrgZh3xHIaF03y6aR6e7ijDfLXv2LDEqRdmxcWvya1T6ep0KtrD61/
         x5GjX/Ai7whLg0dDIidvxcSvD1/VQ1Cjl3q4QmcDkA2drf8u+g5vZiW4azvZE5GD+UHL
         CXQx/L7LMMSpEUu21jMs6jiZ+bclOOWBOTHnvy6u9dVRSMU9AwznELFYzkKyV9YvgmJB
         gfwhbhiBDirBQKhdRtXJBTMd2mWEWnuQOYb5lXu0fAiNjWHMaTPXLe2goi/6LjcxhNbA
         ReTg==
X-Gm-Message-State: ABy/qLaoSBraSqdVu9NmnY1e5wusP15LNbTSgk9KrMZgM136KI8xQMhg
        2/9vDqxKtgQ6MHV6Pk2cVmo=
X-Google-Smtp-Source: APBJJlEs0yP+8wV22mQSkfnFKKtblVhfWleoA3i5vfhb5PjHGzu5pzzz4JLYc7xq8e4txGbm5yHuPw==
X-Received: by 2002:a17:906:738c:b0:993:eed1:8f0 with SMTP id f12-20020a170906738c00b00993eed108f0mr589227ejl.3.1689234507219;
        Thu, 13 Jul 2023 00:48:27 -0700 (PDT)
Received: from [10.10.19.213] ([178.160.196.94])
        by smtp.gmail.com with ESMTPSA id b21-20020a1709065e5500b009934855d8f1sm3607892eju.34.2023.07.13.00.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 00:48:27 -0700 (PDT)
Message-ID: <07697618-de3b-a27a-4dfe-f9d99c42c219@gmail.com>
Date:   Thu, 13 Jul 2023 11:48:14 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ALSA: pcmtest: Extend error injection, decrease buffer
 filling overhead
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230712191325.8791-1-ivan.orlov0322@gmail.com>
 <87351sgxgr.wl-tiwai@suse.de>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <87351sgxgr.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 10:03, Takashi Iwai wrote:
> On Wed, 12 Jul 2023 21:13:25 +0200,
> Ivan Orlov wrote:
>>
>> Extend 'pcmtest' virtual driver with 'open' callback error injection
>> functionality, as it already can inject errors into other PCM callbacks.
>>
>> Fix the driver to use already defined variables where it is possible.
>>
>> Additionally, decrease the buffer filling overhead with conditional
>> reminder calculation in the 'inc_buf_pos' inline function.
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Please avoid mixing different changes in a single patch.
> 
> This patch does three completely different things, and they should be
> split.
> 
> - New inject_open_err parameter
> - Optimization of inc_buf_pos()
> - Optimization of check_buf_block_ni() and fill_block_pattern_n()
> 
> The latter two could be put in a single patch as minor optimizations,
> but the introduction of a new option doesn't fit with the rest.
> 
> 
> thanks,
> 
> Takashi

Hi Takashi,

Thank you for the review. I'll split the patch and send the changes again.

Kind regards,
Ivan Orlov
