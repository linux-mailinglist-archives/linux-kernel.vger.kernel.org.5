Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8E078E0C4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbjH3UfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbjH3UfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:35:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B031D59F6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:34:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-997c4107d62so5974566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693427595; x=1694032395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYTTCqSEdcIJyTpZVB7E2UPb3ND2QCQc334nWhMiy+U=;
        b=H+6xO556ena0tiF4yzx3ATTvBPH1QqzlfG0ZAgnhelTXVzbptMOlh/zciocpQ/znlq
         mWtYK0j6XI4xsItZlswpYOmqaoKyrvM6G1HP5YFoo0dv6EJz94SzYyYvv7rVinAHuG2u
         wgz71HOxUGFLP+Il4+MhkyIgQCwD+bokY5TLw7dBDBrNgACGL47Awf42IFjCSOlxlPdX
         W2SZHQ9FlPU34Ar148nOR2mrF8bXtnGcUwsRdZ4UjWEphDyGLi24PVZ2kKdKjAgOTQfc
         IaF62j0+m3UL9uZ+I5kBPebwkXCRmcmTy4MJ8OXQT+z5XYc1469xQVxfvxbnnLyBn3Bf
         HFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427595; x=1694032395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYTTCqSEdcIJyTpZVB7E2UPb3ND2QCQc334nWhMiy+U=;
        b=KSVnojEdbBCRFM6GvdATzPENmd0eYmAdfcYvA5rx2wKDjTabZKJ7YrxQ9/MhBmdgJ4
         deB0VuWeA/4fVsGGl6VdjI4t/pHh5p1B715cs7JntRFNzn5ho04DG1jQMyJIgI7L2Hbc
         Fbdhdb1+HAin7fhVjPD6Ui6BlnLscjBc+FeoGwTwT9C74ladFsHBBTU/sVllvzI++0jW
         5sliyjWjnePOZ6hhPE7XNBldwHFgMosrgjCsYSA8ZI3bK/SpwYrVT4Nsc/aZJL+37/XQ
         goiPtKUHj1XtV7i8ePdF3ZoG+yt8+SF3kiHUzE0zhU0yUiM7U6fFhjXBlCKoGMsw4/Aw
         Nu6g==
X-Gm-Message-State: AOJu0Yyq98W+WIEExrJjh8Vr1ro9VHVzj12C4OXIq3rsUN7pcW2AOFIq
        BGvj/TBaw8brgPY+lwsZ5NNwku5fB9s=
X-Google-Smtp-Source: AGHT+IFzSmlz/pwFX2xKSsV9ocT+amX0DS7F7b+ZBL9KRK2TYYC6CbpN4ABojmsIoe3uWCcOwyiEOA==
X-Received: by 2002:a17:906:3287:b0:9a1:ddb9:6550 with SMTP id 7-20020a170906328700b009a1ddb96550mr2321538ejw.52.1693425258622;
        Wed, 30 Aug 2023 12:54:18 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b8a0:2d00:e558:bad6:b660:31e3? (dynamic-2a01-0c23-b8a0-2d00-e558-bad6-b660-31e3.c23.pool.telefonica.de. [2a01:c23:b8a0:2d00:e558:bad6:b660:31e3])
        by smtp.googlemail.com with ESMTPSA id v9-20020a170906488900b0099cc36c4681sm7530926ejq.157.2023.08.30.12.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 12:54:18 -0700 (PDT)
Message-ID: <2e31f088-72e5-6a15-4210-2a721c422d1d@gmail.com>
Date:   Wed, 30 Aug 2023 21:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [Intel-gfx] WQ_UNBOUND warning since recent workqueue refactoring
Content-Language: en-US
To:     imre.deak@intel.com, Tejun Heo <tj@kernel.org>
Cc:     intel-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <f7e21caa-e98d-e5b5-932a-fe12d27fde9b@gmail.com>
 <ZO-BkaGuVCgdr3wc@slm.duckdns.org> <ZO+Q0Oaw/1GkDx6T@ideak-desk.fi.intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <ZO+Q0Oaw/1GkDx6T@ideak-desk.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2023 20:56, Imre Deak wrote:
> On Wed, Aug 30, 2023 at 07:51:13AM -1000, Tejun Heo wrote:
> Hi,
> 
>> Hello,
>>
>> (cc'ing i915 folks)
>>
>> On Wed, Aug 30, 2023 at 04:57:42PM +0200, Heiner Kallweit wrote:
>>> Recently I started to see the following warning on linux-next and presumably
>>> this may be related to the refactoring of the workqueue core code.
>>>
>>> [   56.900223] workqueue: output_poll_execute [drm_kms_helper] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
>>> [   56.923226] workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
>>> [   97.860430] workqueue: output_poll_execute [drm_kms_helper] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
>>> [   97.884453] workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
>>>
>>> Adding WQ_UNBOUND to these queues didn't change the behavior.
>>
>> That should have made them go away as the code path isn't active at all for
>> WQ_UNBOUND workqueues. Can you please double check?
>>
>>> Maybe relevant: I run the affected system headless.
>>
>> i915 folks, workqueue recently added debug warnings which trigger when a
>> per-cpu work item hogs the CPU for too long - 10ms in this case. This is
>> problematic because such work item can stall other per-cpu work items.
>>
>> * Is it expected for the above two work functions to occupy the CPU for over
>>   10ms repeatedly?
> 
> No, this shouldn't happen.
> 
> I assume it happens in
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> 
> after cfd48ad8c4a9 ("drm/i915: Fix HPD polling, reenabling the output poll work as needed")
> 
> which could result in the above problem.
> 
> Could you give a try to
> https://lore.kernel.org/all/20230809104307.1218058-1-imre.deak@intel.com/
> 
> and if that doesn't help provide more information/logs, by opening a
> ticket at:
> https://gitlab.freedesktop.org/drm/intel/-/issues/new
> 
Done
https://gitlab.freedesktop.org/drm/intel/-/issues/9245

> Thanks,
> Imre
> 
>> * If so, can we make them use an unbound workqueue instead?
>>
>> Thanks.
>>
>> -- 
>> tejun

