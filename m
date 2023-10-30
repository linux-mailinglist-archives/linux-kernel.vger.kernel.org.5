Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC37DB216
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 03:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjJ3CcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 22:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJ3CcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 22:32:16 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F23BE
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 19:32:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2ec9a79bdso2929796b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 19:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698633133; x=1699237933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtRtbmMq9KJMTw6sTU1zuBGrB/yDjOuWLWJULnTmnP8=;
        b=OSxlK/6/kQHnhGXzzT8l9DYrnIGcn6P0r0oWptVdY5pjS66KvcOgOymnITpXg2cIsr
         FNEHiCdmFs2FlE26gEL2fNt3fTE9pWZ9ZqQ4k8rvdyTy0VeJcifWZ4iTyCQhzBYSw1yV
         S0I6yGaQr9nNgWYEct/oxbmrwnIsr6YOqpP5eDR5MdmVIcheKHwagbQfDYNqrU2MJszt
         i9DGa4Im7x1sZxkcfZbd77JDmcSTzFTSaZG2h9FZdPf++Sn1qRttltWwCAn2isdUAtOw
         ZUyj+NRmrOck7wSY07zbQ8rqOqWgvNTGfhcAsM6T3lwcOFrJtGmopykaxAeMeKgmN9HO
         x0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698633133; x=1699237933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BtRtbmMq9KJMTw6sTU1zuBGrB/yDjOuWLWJULnTmnP8=;
        b=D3TczKFAgsi1Bk87SMSzx5DbfkKUO0qgCevERokyNRo29qETMQjVuHcPXPdk4m1Z9c
         oWJpbjqzVnmx4ixXLaiF+o5CMOJaQckWmvcF4mXn2bH3ea0tDkp+/ERpX8iyBnKRxbVG
         kjuZ8ag6oFDol/L/QotsDoKF8Y8OrxTTG1FeohMkYbEd0TERuqb5I92OyTpq7xpHJtVl
         WXyLyvqN4Xia0Xgg2v27XRUC7LTeIoJe3SKpZjAVJv7jJNb7oC9+9bsQ1vbNBhk6IPcy
         hH8WVzBYLKbuePQ9I95Qa7Zwi/bMSAT92upECCFLXe5vqLe+1+eHRvxW3lb31ZY/T8x9
         6HIg==
X-Gm-Message-State: AOJu0YyPnRUsCdL7SuE86uHfpGJUtGcyyNUbieBkc0xDR5h29qcbaDGh
        FXQ7HT0yVVQe9K4mEw52In6/FA==
X-Google-Smtp-Source: AGHT+IETHd7sJFZEOIbrX1KTZbiUrA3SPw0allcn/4MpQFozC278d5wO2CVTLqFJboUPxykO1MphSw==
X-Received: by 2002:a05:6358:7e47:b0:168:d21d:f56f with SMTP id p7-20020a0563587e4700b00168d21df56fmr11153503rwm.20.1698633133166;
        Sun, 29 Oct 2023 19:32:13 -0700 (PDT)
Received: from [10.4.36.6] ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id d4-20020a633604000000b005b929dc2d25sm3894803pga.10.2023.10.29.19.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 19:32:12 -0700 (PDT)
Message-ID: <5cf3d2a8-563e-4fe5-a1a2-7af417bd8043@bytedance.com>
Date:   Mon, 30 Oct 2023 10:32:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH bpf-next v6 2/8] bpf: Introduce css_task open-coded
 iterator kfuncs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
 <20231018061746.111364-3-zhouchuyi@bytedance.com>
 <bf2add1f-a9e4-46ac-b1ac-5b6ad9f0ed86@roeck-us.net>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <bf2add1f-a9e4-46ac-b1ac-5b6ad9f0ed86@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/10/30 01:09, Guenter Roeck 写道:
> On Wed, Oct 18, 2023 at 02:17:40PM +0800, Chuyi Zhou wrote:
>> This patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_css_task in open-coded
>> iterator style. These kfuncs actually wrapps css_task_iter_{start,next,
>> end}. BPF programs can use these kfuncs through bpf_for_each macro for
>> iteration of all tasks under a css.
>>
>> css_task_iter_*() would try to get the global spin-lock *css_set_lock*, so
>> the bpf side has to be careful in where it allows to use this iter.
>> Currently we only allow it in bpf_lsm and bpf iter-s.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> Acked-by: Tejun Heo <tj@kernel.org>
> 
> With this patch in linux-next:
> 
> Building m68k:defconfig ... failed
> --------------
> Error log:
> kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
> kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
>    917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>        |              ^~~~~~~~~~~~~~~~~~~
> kernel/bpf/task_iter.c:917:14: note: each undeclared identifier is reported only once for each function it appears in
> kernel/bpf/task_iter.c:917:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
>    917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> 
> My apologies for the noise if this has already been reported and/or fixed.
> 
> Guenter

Here is the previous discussion link:
https://lore.kernel.org/lkml/20231020132749.1398012-1-arnd@kernel.org/

We can talk this issue on that maillist.

thanks.
