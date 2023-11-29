Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672107FD5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjK2LgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjK2LgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:36:01 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316FDAF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:36:04 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-285949d46d0so626553a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701257763; x=1701862563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9OBYyY4nBMAYAz8e+bb3aa3xhNJxkYAhCvxiXZwzyQ=;
        b=BIdZM3j91Rgbs6aHxUShLzokmWF1OkkRs0ehU1IkWCrm3riF9lixkphld5m9f/uHLh
         GewYN0HAIR4T8veEm20rJ5sXN2/8EbZPz3nG4gD7Ew/2LGBIRZvF4VjA6UXAM0Tm/PdM
         msWdn/1j/wrQHZy3CBJRSibY7px6c0DIuLD7YC8S/GKFv4M0u5vTOkLWfEgSRLTefjXf
         WUpqoGZWCfuTE6WBsRRjGZBEbE04h9hP98oa1B+SU0ndgwX4ekj4VC8jqoft0++EcaOO
         H5muJLavi7G5A5c7ZaKWz3RFwP2c2cMJG6yC1Q8gX9+GSPbw7Xkz8WegQlbqNddMVgP2
         m2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701257763; x=1701862563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y9OBYyY4nBMAYAz8e+bb3aa3xhNJxkYAhCvxiXZwzyQ=;
        b=lYFa+qJIXOuGrHjEsNUmyOkrowywxKFX2ocS6D1wOBsKfRve0VQOv+6VpfaoElNId8
         ozAdQvxm37ug/DgsANAp8dR/EFQu4l8tPlwRQ4f+9ACFBLxkslEMqg16oM4ZXrekzycT
         rqzWGm1SMj1eG5lGb9oh4fYQsGcBkKsysKwoh8Oi3e84XKyLZEaOebU4MhdXAaFWbLei
         5+j8hEqL/FnwSE6XA9xOWMtWZwRpQZoUSCRiuaWSIODEfidfuRTlt4PZkFRH9gKg8J7V
         7tiW4s5SpvRoK7uWMorKjFERHpd0LB79DTI4+jI2rsxB5ps0c+fjn/rrMt0HJu86KwWq
         C3Mw==
X-Gm-Message-State: AOJu0Yx1oo6VPZxev37tOxIDS7577Z+6FhFfwcGem1eS4QXOVwPQkKd1
        FkRNqGmkw3dZNGuaon1rrPY=
X-Google-Smtp-Source: AGHT+IEHRy/EmqfgTscLaPtPGCriZFoVv6yt0POAIeMijnTMFzPI+sEfQCJmy4EeoQFFPdtWATIi6g==
X-Received: by 2002:a17:90b:19c9:b0:280:a4a1:5d03 with SMTP id nm9-20020a17090b19c900b00280a4a15d03mr31797175pjb.4.1701257763607;
        Wed, 29 Nov 2023 03:36:03 -0800 (PST)
Received: from [10.23.169.155] (014136099212.ctinets.com. [14.136.99.212])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b001cfb4d36eb1sm8354023plk.215.2023.11.29.03.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 03:36:03 -0800 (PST)
Message-ID: <1226de2e-7930-440e-9a27-b6f0c138c433@gmail.com>
Date:   Wed, 29 Nov 2023 19:35:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Core Scheduling unnecessary force idle?
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tang <tangsong8264@gmail.com>
References: <76d535f6-f92c-4564-aafa-290042cf76a9@gmail.com>
 <20231129101710.GB30650@noisy.programming.kicks-ass.net>
From:   Benjamin Tang <tangsong8264@gmail.com>
In-Reply-To: <20231129101710.GB30650@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general scenarios, the number of tagged tasks should be less.

Is it feasible to maintain the leftmost untagged node?

在 2023/11/29 下午6:17, Peter Zijlstra 写道:
> On Wed, Nov 29, 2023 at 04:53:35PM +0800, Benjamin Tang wrote:
>> When I'm reading the code related to "core scheduling", I have a question.
>>
>> Say the RQs in a particular core look like this:
>> Let CFS1 and CFS4 be 2 untagged CFS tasks.
>> Let CFS2 and CFS3 be 2 untagged CFS tasks.
>>
>>           rq0                      rq1
>>      CFS1(no tag)     CFS3(tagged)
>>      CFS2(tagged)    CFS4(no tag)
>>
>> Say schedule() runs on rq0. In the core-wide pick logic, if I'm not
>> mistaken,
>> the end result of the selection will be (say prio(CFS1) > prio(CFS3)):
>>
>>           rq0                 rq1
>>      CFS1(no tag)    IDLE
>>
>> Why not consider trying to find untagged tasks for rq1 here?
>> Is it because it seems less fair, or are there other considerations?
>>
>> I would be very grateful if someone could give me some suggestions.
>> Thanks!
> Because it's expensive to unconditionally track the untagged tasks. I
> suppose it could be fixed by iterating the task-set when we
> enable/disable core-scheduling, but that's going to be somewhat painful.
>
> A work-around would be to always tag everything, eg. have an explicit
> 'rest' tag.
