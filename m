Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA380B573
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjLIRQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjLIRQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:16:53 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D8510DA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:16:58 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1b6524f24fso92347466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702142217; x=1702747017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C0iaRScDWRdOL6VuGlkfkdUquvKPIfgyBFrg9jM7oZI=;
        b=bh/dDyHFJOXERgL2YRx3Bjuy0uQh30LejNTp1m04C2GDb3CHMMOzaNrjxO7SF3o3uP
         VLiQFNJS5MRCqEjdT5ftDDjROQa52IqOlF00ycnp/MwPHvI88iHRSiOnjQInewIfeX84
         EwCu/54SrnR67gNDtkulJivx3ASDPhEeXqBb6TEtNx1KBXegGWSNkoiylpy7nnDivald
         btGkgc1G3GW+08Kf/j1Yz+wNG6kc+TR/owI0XkRWe2b80KiBuqjOCU6CchvzIGDT2NFq
         Qq5iU4R+TyiUjJOJWo3zVrCVeWvpb2zxlPLIxefb8CbZYAbaimK29LMZazSBvhM5Ax0/
         fD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702142217; x=1702747017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C0iaRScDWRdOL6VuGlkfkdUquvKPIfgyBFrg9jM7oZI=;
        b=bAATKBCozth/0YEOX30T138/O1UidNqUAvDpm7K3pTrl/4pSHMWn1vdAjrhzYI7A+o
         miAp7Cf1Wndvu6O4qWVns8VCm7e2Tq6IYIt0/Wr+d8qZu4hcN8V3eHvOeoGYV6M5x7La
         Lzmn5CDNn6fdyFteiA6NfXKsAVKP0klYt8QfPlA914DvdctpAc75tm/QrlrKIma/idz1
         CSJ4BU9xeJfxBGld7XFE2NN3uruMaU2Cu3HdLLTCNGn7dIEV0Br5y0IcpRloiPQfB+4r
         APUr2Z63gIm59po2RH4LRRD9cnVKirjk3Tb21sllDTjgftvAADjaATFDlD7LbbVMDjgJ
         UiNA==
X-Gm-Message-State: AOJu0YzRuBxZNl3s8v0xEtr/Atvp2QgUrfXURopVSWVmC+mPzXiXUy1N
        uRM7hxpak3Lk/l3UgkndWsI=
X-Google-Smtp-Source: AGHT+IGlgbz4xf/enP2HGJJ/RAHMI8BHNFqCOz1xUlkE4B63mvlzDQdOytvAIjDjQJLY29LgIloX0g==
X-Received: by 2002:a17:907:c207:b0:a18:96e3:ae2a with SMTP id ti7-20020a170907c20700b00a1896e3ae2amr1913831ejc.5.1702142216961;
        Sat, 09 Dec 2023 09:16:56 -0800 (PST)
Received: from [192.168.0.103] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id vc11-20020a170907d08b00b00a1ce58e9fc7sm2415251ejc.64.2023.12.09.09.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 09:16:56 -0800 (PST)
Message-ID: <fec3284b-ee1d-4c53-8f01-76ab209584b8@gmail.com>
Date:   Sat, 9 Dec 2023 18:16:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] staging: rtl8192e: patch series renames (5) different
 variables
Content-Language: en-US
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231208015536.21013-1-garyrookard@fastmail.org>
 <493fe783-46b3-4da7-b0d9-01425e6adf2a@gmail.com>
 <87y1e4dy2g.fsf@fastmail.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <87y1e4dy2g.fsf@fastmail.org>
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

On 12/8/23 22:56, Gary Rookard wrote:
> 
> Philipp Hortmann <philipp.g.hortmann@gmail.com> writes:
> 
>> On 12/8/23 02:55, Gary Rookard wrote:
>>> Hi,
>>> This patch series renames 5 different variables with the checkpatch
>>> coding style issue, Avoid CamelCase.
>>> Patch 1/5) renamed variable bCurShortGI40MHz
>>> Patch 2/5) renamed variable bcurShortGI20MHz
>>> Patch 3/5) renamed variable CCKOFDMRate
>>> Patch 4/5) renamed variable HTIOTActIsCCDFsync
>>> Patch 5/5) renamed variable IOTPeer
>>> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
>>> Gary Rookard (5):
>>>     staging: rtl8192e: renamed variable bCurShortGI40MHz
>>>     staging: rtl8192e: renamed variable bCurShortGI20MHz
>>>     staging: rtl8192e: renamed variable CCKOFDMRate
>>>     staging: rtl8192e: renamed variable HTIOTActIsCCDFsync
>>>     staging: rtl8192e: renamed variable IOTPeer
>>>    .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 +-
>>>    drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 22 +++----
>>>    drivers/staging/rtl8192e/rtl819x_HT.h         |  6 +-
>>>    drivers/staging/rtl8192e/rtl819x_HTProc.c     | 58 +++++++++----------
>>>    drivers/staging/rtl8192e/rtllib_tx.c          |  4 +-
>>>    5 files changed, 47 insertions(+), 47 deletions(-)
>>>
>>
>>
>> Please use present-tense as outlined here:
>> https://kernelnewbies.org/PatchPhilosophy
>> So rename instead of renamed
>>
>> Please use a more unique Subject for your coverletter.
>> It often cannot cover everything. But more unique is better.
>>
>>
>>
>> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> 
> Okay, "rename" it be, instead of me thinking in the past simple tense,
> of "renamed".
> 
> As for the coverletter(s)...repetition a big problem.
> 
> There's not much in the way of uniqueness that can be added...regretfully
> Tagging the Subject line with a numeric value is possible and
> should deviate the coverletter(s) enough so they don't "appear the same".
> e.g. staging: rtl8192e: this patch series (1) blah blah blah...
> e.g. staging: rtl8192e: this patch series (2) blah blah blah...
> e.g. staging: rtl8192e: this patch series (3)  "    "    "
> 
> Regards,
> Gary
> 

Hi Gary

Here is a proposal:
[PATCH 0/5] staging: rtl8192e: Rename variable bCurShortGI40MHz and further

That will give a pretty good recognizable name.

Thanks for your support.

Bye Philipp
