Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B847C4D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbjJKIbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjJKIbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:31:01 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429F4A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:30:38 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5812eaed1eeso1371752eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697013037; x=1697617837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXUNV0ujQSLE2qvD9KPcPTpmkRZtdqskCOFXDdWDov4=;
        b=EPLS26YSEhCoWSvtFoQnhL+tNDROcwhYKXyIpvHxjUzWvb+xTX31Odj1/cgxfNe+4k
         StcNwZ0pgba/et5THkLI9nbloAm2piGEUca8bgf4XR0ggjJ/dG5QDftlHr49LutLZNOL
         Oa1+N1ckewuT1U4HSDwznVbGyYpiDw3+vRI7KYcH4hn75BWjMVwpUrcFSKZ0pnYsMqKu
         hupMUIwURrMtldSSIWAdLJsi+M0FaBwU3CmV2HNpnmUe79An8Zyu70QSCyuUt90s8osl
         GJyJxA3DjDThzOEQN63r5Pd5QPnoC+EB7J2f9nbUVwzontrsDhHIHpDPNPOB0x+t1PIs
         GRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697013037; x=1697617837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXUNV0ujQSLE2qvD9KPcPTpmkRZtdqskCOFXDdWDov4=;
        b=QRdZbXLrvWiUXsve5QQvSBilMnhmxFIFhqN9nKYS8CnbS6Uu3cTijRiQUxNIb4f0Fp
         XJHFi7YYkITN2bRT+Ld+17rbZytVBBP5j6cqhX9QxEuuqUdnmrGz0DFSrw41DtWzjSYD
         AqhnfrEKNijPBi3DIRv1u1J4VjO5EmYbUaVy564RHCVApD+yPFNHMtB44NU4SCQN/TcY
         8P0SnsjASoPKpZM/sp0I/yCjEx9rqb7V9jdlTgm99OAf0Y/8pznFpY36qkQrWq91yDXW
         Jln8Yi8GJ/xIr/6EJF1FDlgpyk9o6Hk7uH60vn3gKV9rOIOq76vJI6EkihhxpeSkZSir
         WCYg==
X-Gm-Message-State: AOJu0YwqYfVV0W9veFtzs8vMCIHAdY0gjFPCLXIujJG+Og7DfwfDlvXb
        4enJjrwBjrmZ23vI3B3Mn49Oxw==
X-Google-Smtp-Source: AGHT+IEnReR/IaHjXbz/+32O1iKTLaZhsq3RIRBueDldlWv0/NdJuStpE6Mc1cvGy7RpdO5WXFYFQw==
X-Received: by 2002:a05:6358:988d:b0:14c:704b:d19f with SMTP id q13-20020a056358988d00b0014c704bd19fmr15511969rwa.3.1697013037515;
        Wed, 11 Oct 2023 01:30:37 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id r5-20020a62e405000000b006933b69f7afsm9540407pfh.42.2023.10.11.01.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 01:30:36 -0700 (PDT)
Message-ID: <3156c8fe-5488-4044-8282-79495bf89f6d@bytedance.com>
Date:   Wed, 11 Oct 2023 16:30:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 01/15] sched/fair: Add avg_vruntime
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
References: <20230531115839.089944915@infradead.org>
 <20230531124603.654144274@infradead.org>
 <75adcb1a-c02f-4d7c-bd9c-ab4f403af3e8@bytedance.com>
 <20231011073001.GI14330@noisy.programming.kicks-ass.net>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231011073001.GI14330@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 3:30 PM, Peter Zijlstra Wrote:
> On Wed, Oct 11, 2023 at 12:15:28PM +0800, Abel Wu wrote:
>> On 5/31/23 7:58 PM, Peter Zijlstra wrote:
>>> +/*
>>> + * Compute virtual time from the per-task service numbers:
>>> + *
>>> + * Fair schedulers conserve lag:
>>> + *
>>> + *   \Sum lag_i = 0
>>> + *
>>> + * Where lag_i is given by:
>>> + *
>>> + *   lag_i = S - s_i = w_i * (V - v_i)
>>
>> Since the ideal service time S is task-specific, should this be:
>>
>> 	lag_i = S_i - s_i = w_i * (V - v_i)
> 
> It is not, S is the same for all tasks. Remember, the base form is a
> differential equation and all tasks progress at the same time at dt/w_i
> while S progresses at dt/W.

IIUC it's V progresses at dt/W and is same for all tasks, not S which is
measured in real time (V*w_i).
