Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEE47BDCB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376494AbjJIMqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346553AbjJIMqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:46:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043B293;
        Mon,  9 Oct 2023 05:46:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405524e6768so43557275e9.2;
        Mon, 09 Oct 2023 05:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696855603; x=1697460403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46YmJF0NCAJOq27FzOxAehU5zeb/ItCo7qFVBmNntgE=;
        b=U0idYfHZhmJ1BL6J8aUyNRKpgG92BmTZ3297EOLw0DVrO9vx1jlwzk+colJtvkGsMU
         hakEXYmQSLp7dwPu/+XcvvHimS5zMkbSElgoKsWvxsLPADX26LpCIgRQd5mpNpMy/JQd
         jUcXdjwB0rYFl6BloMh0pQVzmkyu1PKbFug10vKWOVDxIL3xGYK14A7bSxk4uxm8AKRs
         IDrvwhiHodwZ2omQhLa//P340EIZPXyUXeb+cURP+CkmVMIRd8Wsq1AbgV9ac/o/5NIn
         Rp0GhAnluSI3dul8iHmzteTJMWI0ohwG1m0N7OxngIt0kAMW6YG4YxibPHi/bwfSPioi
         ddew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696855603; x=1697460403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46YmJF0NCAJOq27FzOxAehU5zeb/ItCo7qFVBmNntgE=;
        b=oOlxfpExucEpqOTlnSbwBGM2mmIJLkMcRPDXvmXjEh6/u8l+wpDmJYo7zfaGf8bMW2
         uZyh4Gwo9M1QLckFQ/4pW7hmxCLJF2DvGjbEPH0yFVOiuCRMM8RZz7+M3nLnBXuei4J6
         AgcbsfSkPf7rv/oNj59iJE40sZH16Bkv2/FN79O5SBRKL2xXgI7sF8iEShaL4aN8tcJG
         Hzm++4RRiSMRqULu4AvFhkPLX2/V/tRxhni+ePcDWFnAYg2gASbpmDz3SpxXx1japvDa
         DtT14vZyrfyoz324Vj15tgloo/8vK0tnGQP7S82m5XygeQtGpon551wYUi6cbWGSWKDm
         dzWQ==
X-Gm-Message-State: AOJu0Yyq+LQ9cayLpI6241UMz76xMKunQVXSDWyxAEZy8rDsXYjDibFL
        ArP+f4KJRhmsldB9KZW5Y1Usf6jlPElUKg==
X-Google-Smtp-Source: AGHT+IFHKObOZreEa2lhEy26Zw5w3xizdKPFB5KSHgUs7mXxo0KcjUbN/Du2Ci/oP8LOrpKffCEM9g==
X-Received: by 2002:a7b:c5c9:0:b0:403:272:4414 with SMTP id n9-20020a7bc5c9000000b0040302724414mr13535879wmk.0.1696855603106;
        Mon, 09 Oct 2023 05:46:43 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id c11-20020a7bc84b000000b0040648217f4fsm13400617wml.39.2023.10.09.05.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 05:46:42 -0700 (PDT)
Message-ID: <0eb8750d-79c5-4508-ac36-7f91bc8cbaf9@gmail.com>
Date:   Mon, 9 Oct 2023 14:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 5.10 13/22] drm/amdgpu: install stub fence into
 potential unused fence pointers
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Bryan Jennings <bryjen423@gmail.com>
Cc:     sashal@kernel.org, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, olvaffe@gmail.com,
        amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
        stable@vger.kernel.org, Lang.Yu@amd.com, christian.koenig@amd.com
References: <2023083119-phoney-ascend-d4ec@gregkh>
 <d32d6919-47cf-4ddc-955a-0759088220ae@gmail.com>
 <2023100750-unraveled-propeller-3697@gregkh>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <2023100750-unraveled-propeller-3697@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.10.23 um 11:50 schrieb Greg KH:
> On Sun, Sep 10, 2023 at 03:43:01PM -0500, Bryan Jennings wrote:
>> This is also causing log spam on 5.15.  It was included in 5.15.128 as
>> commit 4921792e04f2125b5eadef9dbe9417a8354c7eff.  I encountered this and
>> found https://gitlab.freedesktop.org/drm/amd/-/issues/2820 while researching
>> the problem.
> Confused, what should we do here?

If this patch was backported to even more older kernels then please 
revert that immediately!

This patch was part of a new feature and can only work correctly with a 
bunch of prerequisites. If you don't have those prerequisites in your 
branch then it might actually cause random memory corruptions through 
device DMA.

And we should probably talk about why this patch was automatically 
selected for backporting in the first place? There is no mention that 
this is a fix or should be backported in the commit message or patch 
itself whatsoever.

Without the WARN_ON() which started to spam the logs that could have 
gone south pretty quickly. Random data corruption without any indicator 
what's causing it is not really funny.

Regards,
Christian.
