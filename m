Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F1D7FE86B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjK3Etp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjK3Etm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:49:42 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176EBD6C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:49:48 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77d72aeae3bso24650385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701319787; x=1701924587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiY7JrExGjhh09B2RGlnzWLBuqSMBLOCY8tQo4g0thI=;
        b=cSuAR4MZL0mbD4psh/NzyRIF9h4USg96CWmWeidwyTkz8pS8r43zGQPtpe3Sh586Xw
         bPvno/UqJpRuxqo70niKAfQuY797wjNtEHyWYrZLqLNFA7wndFDzePYAU4rD0rVFmGjs
         L4MggeS3l48NAIWoisIvhvz5YvppKiNqXch2TS2IcaliM2raQJRFDsSRw5W/B4k2MnV1
         7KAoYjprbF5e5Xi7E/qhwt9Y+dhh97+KZ7natCGta0yUDPs/auCHAhAQ+DUeehkRTt78
         BepDbMCRyy/8svYtlYxvQU/krwm/2bh5wai3xI2XQpiCw/TOhNoCpAWwCBZP14jHsgHt
         fVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701319787; x=1701924587;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiY7JrExGjhh09B2RGlnzWLBuqSMBLOCY8tQo4g0thI=;
        b=On/M6qbmNYPbOW/5gMiOt3JEKDy1zD9n0veovCFYJSBmaZG64GG7ZdMXrU2tCgeKmY
         Vgf10VsMTJd9wZ6NProfvKRZJ8JHPUc1iR+2rfBPAVlGXRlpX8GEu6Pf7S6avDaR434o
         hXiCrJaNhY1pjMKuCf7gCQdMt0PCxYsNdrfrQzzy58Y+bMXaxPFHkkn3/QGGyy2it7WP
         FMQRLDlfH10KE3KLwVIdq3Wovs3JOHMyD993tMYZEWcy4ii9Iz+SD6q+zAWg4NBX3PFm
         cbgytR7q+GKEcoK+Kgz/nqs8nf3UhOJUJJvhB6ddkiB0txOL9v0LnrVobUmsL87AiP6h
         S6jw==
X-Gm-Message-State: AOJu0Yz+RGMGrxXyc79L2cAkgOMrkPBCTC+k0s+bhBohancDs36J8NVU
        Q8p+Erv2sUrMfpHoiKnyg1Q=
X-Google-Smtp-Source: AGHT+IFc+UjJPA3gLluAa1WdukvQe4ag89Lcs5OhODOYKQLEU1dEyv3VZIvQf2MRvALWih92hn256A==
X-Received: by 2002:a05:620a:2988:b0:77d:cee7:993c with SMTP id r8-20020a05620a298800b0077dcee7993cmr3997843qkp.45.1701319787072;
        Wed, 29 Nov 2023 20:49:47 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id x13-20020ae9e90d000000b0077d71d46887sm142915qkf.112.2023.11.29.20.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 20:49:46 -0800 (PST)
Message-ID: <cad25481-776b-4c67-a87e-916e311536e2@gmail.com>
Date:   Wed, 29 Nov 2023 20:49:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No care given to GDB scripts..
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <cfc3aa17-0f1b-4ffc-b848-33baa51b1196@gmail.com>
 <20231129150629.0a82efbfc1494972e4e4f8cb@linux-foundation.org>
 <25a5e810-1e57-4a59-ae82-cb2c7d28a116@gmail.com>
 <20231129170254.e7ca4c866b521c291e88395e@linux-foundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231129170254.e7ca4c866b521c291e88395e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/2023 5:02 PM, Andrew Morton wrote:
> On Wed, 29 Nov 2023 16:23:55 -0800 Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
>>> Is there any way of scripting the scripts so we can have some sort of
>>> automated testing down under tools/testing/selftests/?
>>
>> That might be a bit difficult to do as this would mean that we can self
>> debug and introspect using gdb the live kernel. Testing using QEMU is
>> definitively doable however. Of course, I just found another script that
>> broke (device.py)!
> 
> Oh.  That sounds quite the exercise in the context of tools/selftests.
> 
> One can of course just fire up gdb against the vmlinux elf file and
> play around, but I assume this won't permit a useful amount of the
> scripts to be exercised.
> 
> Suppose someone has set up qemu or whatever and has attached gdb to it.
> Could we provide that person with a script or a canned set of commands
> which exercise the gdb scripts to a useful extent?  So rather than
> attempting automated testing under the seltests umbrella, we provide
> less skilled individuals with the means to easily and quickly check for
> regressions.  I'd expect that such a toolset would be particularly
> helpful for regression testing the scripts across all the supported
> architectures?

Yes it would, let me play with what GDB and QEMU can do and see if this 
can be somewhat automated.

Thanks!
-- 
Florian
