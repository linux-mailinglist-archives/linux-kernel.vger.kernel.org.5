Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1226D7DB911
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjJ3Lgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjJ3Lgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:36:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957F3DE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:36:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso3031031b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698665805; x=1699270605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vM7UrmexBzhlrtYGq+WTsMhMVaGhrgekLL9dJWIZR04=;
        b=WjygjN8+r6L5TOkH9+e+SzkruaLaPK1NOXUb1KfiCdmGnGvg2Chlaxe5y7pUrc63jA
         v+nRYtI24eDZNXHElg9+qepzkP8XqJjEph6YCXyYj2t7rE/LehMZt5wGy/vHJ50EaWOU
         lrH17FUgufeDpqwEsVnrkprelB027wPmohQvKNSYOzWb6sztBeveR1sxagFqb+g9J3B9
         Szj2XNgarcGBtks1F3zZpF8w36x02o1e0c3BodB/TQ11tYpxQ63ymPrxXjv2pDbMclwE
         JBsusCo7dm+u46IupsLmHITDlWGlUtHcfB3PZGruJJ32lFzmHIC7iDADtCBvWNBwXs8s
         QrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698665805; x=1699270605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vM7UrmexBzhlrtYGq+WTsMhMVaGhrgekLL9dJWIZR04=;
        b=BU7L4lpdlp0nDCQHXUkC9vBf+YFEndfBIrhPeJv9AzCtslh7RnzuBYy73BHSR9WpVF
         TnBY0SYpjQvRPbuq0zFOiLs23DKL4O5Vz9aP1w7PwZIANM7CEd0oV4zRw6/2uxZWqnPY
         XsiNkJuGPGFgK16wgw4jf476NJagAQHpzPOEyxVucWQinl/jXtm06BiR5m7dunpuTHnE
         j+rWQymJskkZ5pg6JIVLU8/v0V76SA+dRuNcCDO+DPOw80BQv2Uac+n6hSZDE4uvofeF
         h9xJcxG7Pz5/jdpYZeOY07pihrS9hvaRkioe8fF4lnsXWejZQu8GKfnJF/lNExKqAZQU
         EVcA==
X-Gm-Message-State: AOJu0YzA0snEaz+lxQDt49Cm0BJgJIFu6MolMyWhj28Cu29VrAgS/DOP
        0j620vacQOBGirSgKul/f+s=
X-Google-Smtp-Source: AGHT+IHB04Y3v0cpysF5Hffjhog9NL2AkKNDPwW89qQDZuAcCybJS+Ey+vqecfyEm8jG0xY2kLZT+Q==
X-Received: by 2002:a05:6a00:148c:b0:693:43b5:aaf3 with SMTP id v12-20020a056a00148c00b0069343b5aaf3mr12536513pfu.13.1698665804989;
        Mon, 30 Oct 2023 04:36:44 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78652000000b006be484e5b9bsm5725923pfo.58.2023.10.30.04.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 04:36:44 -0700 (PDT)
Message-ID: <3f1fdfa2-e30b-42c6-b290-bb02283b3589@gmail.com>
Date:   Mon, 30 Oct 2023 18:36:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Resend] Fix line Length
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Dorine Tipo <dorine.a.tipo@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Terrell <terrelln@fb.com>,
        Daniel Stone <daniels@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231029144312.5895-1-dorine.a.tipo@gmail.com>
 <alpine.DEB.2.22.394.2310291610030.3136@hadrien> <ZT7v39jG4WTxPYjm@debian.me>
 <alpine.DEB.2.22.394.2310300712310.3533@hadrien>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2310300712310.3533@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2023 13:12, Julia Lawall wrote:
> 
> 
> On Mon, 30 Oct 2023, Bagas Sanjaya wrote:
> 
>> Hi Julia,
>>
>> The submitter touched one of CI scripts for the DRM subsystem. To test
>> this patch, there must be a way to run these scripts locally (which
>> may requires non-trivial setup).
>>
>> Cc'ed DRM maintainers.
> 
> There is a DRM outreachy project.  I think that motivated this patch.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

