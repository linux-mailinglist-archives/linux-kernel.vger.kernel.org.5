Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD7078D9CA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbjH3SeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245497AbjH3PVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:21:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67399E8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:21:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso6675565e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1693408895; x=1694013695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3CtT48jPlJIgusYzTnrLdg/99F2+CEON4UsLWqQKko=;
        b=PTndykky8SKmMRVa5wJO30iumxi4Lb2OpAoYzFfYTFpw9ZubZSzfnYBymf8lUNhyJW
         zqttAdCC9VCrk6umAHFliAGPuDCVO/Q2XHr/CQkec0nRASvTS5sUsLqISy9hxSfLcwt0
         F0ymHP8oCZy2B+D2066kMSYpXh9+69CW5dbTF4ooShZNT39pDe8xoiy2FjT6tjMlUdvH
         tXXXcVM6zEuqEP199hVWNNskvjrBeUcoeZ0QQzE0Jq6Eh3XsXnaPUhzbwvy4QeFIh3tB
         aH18EJrY/Yng2ykQ8rFJIeTzw/JTo6AF4/o16Tfuwy0zUW7qm4aIGKR1eq+ZFNzcbeLk
         uA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408895; x=1694013695;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3CtT48jPlJIgusYzTnrLdg/99F2+CEON4UsLWqQKko=;
        b=LRy47eRaGHE3iD98R3CvTRdZY+f2VQaaOQeuqrm/r9Tio7C45jR0OczH7ou4BztbwE
         IzSgmVbO6gZ/fIhdNedlEoX02v/ieNe3Yc/pa2NPcZKv0B508SQJvZrJZQFZSY1UJtZ7
         f0nmZfRUX3R+47HfgnLUxSJTIKhOFUDyvHSFiLM+z5++eqfIcmzdvJS760/vtzxD9V8C
         lJEXHHOqKwjtGYmk3kdVPeBiRQRxNRPkZfrT3e0N7zP48K4QYs/yJdF3Lw5Mc7lOyKn4
         YwM8IemJfOV1yt91DvIJti0BVaUrLzPQ+GnCxmoEfxSbUQ6nUfCKxS8gYQNEurpdYMup
         81oA==
X-Gm-Message-State: AOJu0YyjwdgeEDCj/laK46e3Gr0ayRpqgiwpF039LsE/iMHyVn4Joxh/
        zud/VXCMaNMMhBOCH1l5rAas0A==
X-Google-Smtp-Source: AGHT+IEzQMej866IzE8FCkgk6gCxfjVeFksIip5jMrjrfICUSVE6k6l/gLx7wW7sFI65pTLcljpopg==
X-Received: by 2002:a7b:cb90:0:b0:3ff:516b:5c4c with SMTP id m16-20020a7bcb90000000b003ff516b5c4cmr2126478wmi.18.1693408894839;
        Wed, 30 Aug 2023 08:21:34 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:ab9c:c93c:ba9e:7ca? ([2a02:8011:e80c:0:ab9c:c93c:ba9e:7ca])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c299300b003fe539b83f2sm2556800wmd.42.2023.08.30.08.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:21:34 -0700 (PDT)
Message-ID: <2195c267-619e-4877-af5e-48ef56b81d4c@isovalent.com>
Date:   Wed, 30 Aug 2023 16:21:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix invalid escape sequence warnings
Content-Language: en-GB
To:     Vishal Chourasia <vishalc@linux.ibm.com>
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        netdev@vger.kernel.org, sachinp@linux.ibm.com, sdf@google.com,
        song@kernel.org, srikar@linux.vnet.ibm.com, yhs@fb.com
References: <e640e5f2-381c-4f65-40b9-c2e3e94696f9@linux.ibm.com>
 <20230829074931.2511204-1-vishalc@linux.ibm.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230829074931.2511204-1-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 08:49, Vishal Chourasia wrote:
> The script bpf_doc.py generates multiple SyntaxWarnings related to invalid
> escape sequences when executed with Python 3.12. These warnings do not appear in
> Python 3.10 and 3.11 and do not affect the kernel build, which completes
> successfully.
> 
> This patch resolves these SyntaxWarnings by converting the relevant string
> literals to raw strings or by escaping backslashes. This ensures that
> backslashes are interpreted as literal characters, eliminating the warnings.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thanks! I observed that this patch fixes warnings reported by pyright in
my editor. I've also validated that the generated files (helpers man
page, syscall man page, bpf_helper_defs.h) remain unchanged.

Tested-by: Quentin Monnet <quentin@isovalent.com>

