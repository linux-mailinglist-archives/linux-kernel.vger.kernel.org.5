Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF397D21B2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 09:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjJVHro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJVHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 03:47:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C37F4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 00:47:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507f63fcbf6so131904e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697960857; x=1698565657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EMvpJh0VDsbsM5SOLOEYs5sCE72VwDjjpNXErS0zPo=;
        b=OlBExOGMz0Yx8J1RamAH1AzUb0O2bkkk/bOQFVY9LOrj7+iJ5YsrJew7xRbBGfJWTJ
         F0xB2wyg1DKQc/kGCyCH7Do2+6hAobOkkzE90YWYSZaEF5diLk3I89nLwJDxwro3BOQt
         OgQBG7TJ0NzuQfIl5ttQjDa8pNi5G/Mck0yw+iH40Qou335yW5nRd9d0tETmsc6sS2di
         Sl0uHyvxBXx/1YcL4JhrcHeRJzptO2qzSRrj5qcA53cuZ/XXAMbOf4JaWwfCSS1gGKBv
         MLFBLsfuMFL64avHJCQ4HV2Mo3qmjAJBQ+QEevooUC7ryaOMAOpRIAl+AGJmHL0Ryvt0
         XLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697960857; x=1698565657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EMvpJh0VDsbsM5SOLOEYs5sCE72VwDjjpNXErS0zPo=;
        b=iXI/W6HlCFzcR1vf1pdHSM9E4OzRko7pzd4nbbBFuBhANAuvtlkuaLN6rPwMEka4jJ
         Mqzlz4A4s53wLvjxuWlammVttP6S7PfwlUXtuflWCBDw+tyPh0vzNPFEgYMrTMuzkfVc
         9wQ+swVpq3yKNyN8OaC7tDSBrdEsh3adCxgWgakCHLrgwkRM+7AbX5ezp34kvvLroFxw
         U9D6BubbRpV1tEY/BFHT4PWg8gvIfONOqtcauGvl4FYQz7cpeCOAdXA4IDi/xR3S+Rqo
         UlIX3uYGgO0Fdi+R+ZI7rLs4VXNcI1+kuaLgUtmDDzTel+TiyQIZRhCwMgLfLbIjnsKb
         ybSw==
X-Gm-Message-State: AOJu0YzVrDRZZDX+4MmKBX8wFE30koLBHAaNs0o36RZRz0FoFXEYyKwL
        IGR975M3/N5fezyoKf5W80E=
X-Google-Smtp-Source: AGHT+IEKqrm0VQMSa6yXVdiNx6SW44iEegXrbLulsxSuaW+bxQVebWyuLQ23+ToKszH4iEOuXuMKXQ==
X-Received: by 2002:a05:6512:e95:b0:503:2dcd:30ed with SMTP id bi21-20020a0565120e9500b005032dcd30edmr4258900lfb.0.1697960857142;
        Sun, 22 Oct 2023 00:47:37 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906bc5000b009b95b46bbd1sm4680320ejv.133.2023.10.22.00.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 00:47:36 -0700 (PDT)
Message-ID: <070529f5-b0ff-4cbb-af3e-28984616a821@gmail.com>
Date:   Sun, 22 Oct 2023 09:47:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: rtl8192e: renamed variable IsHTHalfNmodeAPs
To:     Gary Rookard <garyrookard@fastmail.org>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231021224051.7443-1-garyrookard@fastmail.org>
 <1f47714b-4362-47cc-a83c-190b666f748f@gmail.com>
 <aa578599-cd87-4c3a-8040-03ab065d8482@app.fastmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <aa578599-cd87-4c3a-8040-03ab065d8482@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/23 09:32, Gary Rookard wrote:
> Sorry, but I do both compile and checkpatch, but they seem to be 
> failing, don't
> know why yet. I've been using make M=drivers/staging/rtl8192e after a 
> complete
> kernel build at make -j3, I'm changing it to Make drivers/staging as a 
> matter of recourse.
> gcc version 13.2.1 20230826 (Gentoo 13.2.1_p20230826 p7)
> 
> I use checkpatch unflaged on the patch, never a problem before...
> 
> On Sun, Oct 22, 2023, at 2:48 AM, Philipp Hortmann wrote:
>> On 10/22/23 00:40, Gary Rookard wrote:
>> > Renamed from Pascal/CamelCase to Snake case the variable
>> > IsHTHalfNmodeAPs, IsHTHalfNmodeAPs -> is_ht_half_nmode_aps. Linux 
>> kernel
>> > coding style (cleanup) checkpatch Avoid CamelCase. Driver rtl8192e
>> > compiles. Signed-off-by: Gary Rookard <garyrookard@fastmail.org 
>> <mailto:garyrookard@fastmail.org>> ---
>> > drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
>> > drivers/staging/rtl8192e/rtllib.h | 2 +-
>> > drivers/staging/rtl8192e/rtllib_softmac.c | 2 +- 3 files changed, 3
>> > insertions(+), 3 deletions(-)
>>
>> Hi,
>>
>> I assume that now I cannot apply this patch anymore because the previous
>> one is missing.
>>
>> I propose to make a patch series out of the send in patches.
>> Please do a compile test and and use checkpatch.
>>
>> Please include in the version change at which version what changed.
>>
>> Thanks for your support.
>>
>> Bye Philipp
>>
> 

Hi Gary,

please use:
make -C . M=drivers/staging/rtl8192e

I am using checkpatch as described here:
https://kernelnewbies.org/FirstKernelPatch
"Git post-commit hooks"

Please always reply with Bottom Posting. You used top posting which is 
not liked by the community and maintainer.

Bye Philipp
