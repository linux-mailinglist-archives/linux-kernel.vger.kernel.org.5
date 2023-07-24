Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC075F35E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGXKd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjGXKdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:33:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D9BA1;
        Mon, 24 Jul 2023 03:33:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1bb84194bf3so8729545ad.3;
        Mon, 24 Jul 2023 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690194780; x=1690799580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=duKCTUo6uZr1U/LxkiT4+vpi8gaVx03a2TgE1Rb/EMk=;
        b=Yhm1fyyX3GnUDk9+Zn1dpn23iKNmHhLJmkM5tLwlHXNVgLM1o+lJ4MAvr9JwZarVn+
         b70xRy1/LYBqxxMgFzUub1KiX9vp4V2wT0cFk1BUDd2/kIn5PfUwYqc7z9dQZMNLzizg
         zY3j0P22uG+Dafwu8HVTF8joN/PT6V4GyavnNbx/bqgXbhxsDCn+sT6eLYgqjnhjT8Vh
         k+1dTcDf5qS6BntDmXKBdrAQgWhBGb5Z8IMSDXG1Uhw3rghivk0Fs3Cu+4o6JI5kyINd
         /R3ytQS48PvqI76bpwYSkaEfhG0ps7R4tckBgT4OBuWyLRRXXfc4MeMDiV7AXf3Ckdj3
         AYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690194780; x=1690799580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duKCTUo6uZr1U/LxkiT4+vpi8gaVx03a2TgE1Rb/EMk=;
        b=MmAu68hp2uMNRBm8YxxKyCqNZaqVAOXzxmhXPeKF2DGLdghpVQqHWm/qLv4U40c91W
         b6T4qaol6fSiOkv3bcTWEeiZHGwkq5NdEcFvIIzkZyI8O+xX5mOnm3ARrYa8AelzV28l
         pJPi62N7Om+qjBess62xzITNkzFSXUXjUlWfaFsyOnsBymodzXdFaEvR98b6BpxJWbBl
         vzlQZmufzqFaOE/nw+1RH29HYSH+k2GdITFXSBX/Wmk6ysPldEbCWFHCQ13cuwyjb1cT
         Wqxl5pJQhDTU2VxZNEGRre3Y+0e2pXusJxoI1OPeesBRxmRK5WC20YMFUpvOYSA6Vb4z
         dZfw==
X-Gm-Message-State: ABy/qLbnDMORwStg2Joc2ruN3uhGJp7NZpRqX485AwUYukQADP6UhKvn
        xHxF0TFs3NWFmnKG3wHpoh43rsJwFS+fCRDk
X-Google-Smtp-Source: APBJJlGrKt3zkOiWepq4i4IAbPTxtDH8/JyPrOZx2+maV+P8MrqnQLpyCpG7JQ9z2u+4E2a8sPf1uQ==
X-Received: by 2002:a17:903:190:b0:1b3:b3c5:1d1f with SMTP id z16-20020a170903019000b001b3b3c51d1fmr11583180plg.8.1690194779910;
        Mon, 24 Jul 2023 03:32:59 -0700 (PDT)
Received: from [172.23.111.174] ([113.251.5.100])
        by smtp.gmail.com with ESMTPSA id p21-20020a170902ead500b001b8af7f632asm760680pld.176.2023.07.24.03.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 03:32:59 -0700 (PDT)
Message-ID: <8c8c02c2-0aee-af91-deda-bdfea325477d@gmail.com>
Date:   Mon, 24 Jul 2023 18:32:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND 0/6] docs/zh_TW: update zh_TW's documentation from
 an ascensive aspect
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230720132729.1821-1-src.res.211@gmail.com>
 <87bkg5dp6x.fsf@meer.lwn.net>
Content-Language: en-US
From:   Hu Haowen <src.res.211@gmail.com>
In-Reply-To: <87bkg5dp6x.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/22 03:44, Jonathan Corbet wrote:
> Hu Haowen <src.res.211@gmail.com> writes:
> 
>> Update zh_TW's documentation concentrating on the following aspects:
>>
>>      * The file tree structure changes of the main documentation;
>>      * Some changes and ideas from zh_CN translation;
>>      * Removal for several obsoleted contents within the zh_TW translation
>>        or those which are not exising anymore in the main documentation.
>>      * Replacements for some incorrect words and phrases in traditional
>>        Chinese or those which are odd within their context being hard for
>>        readers to comprehend.
>>
>> Hu Haowen (6):
>>    docs/zh_TW: update admin-guide
>>    docs/zh_TW: update arch
>>    docs/zh_TW: update cpu-freq
>>    docs/zh_TW: update filesystems
>>    docs/zh_TW: update process
>>    docs/zh_TW: turn zh_CN's folder references and headers into zh_TW's
>>      ones
> 
> So b4 doesn't like this one:
> 
>> WARNING: Message contains suspicious unicode control characters!
>>           Subject: [PATCH RESEND 5/6] docs/zh_TW: update process
>>              Line: +﻿.. SPDX-License-Identifier: GPL-2.0
>>              -------^
>>              Char: ZERO WIDTH NO-BREAK SPACE (0xfeff)
>>           If you are sure about this, rerun with the right flag to allow.
>> AM FAILED
>>
> 
> Could you resend, please, without the funky control characters?
> 

Fixed in patch v2:
 
https://lore.kernel.org/lkml/20230724041715.20050-1-src.res.211@gmail.com/

Thanks,
Hu Haowen

> Thanks,
> 
> jon
