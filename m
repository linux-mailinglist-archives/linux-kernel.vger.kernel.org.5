Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1627C5274
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjJKLu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjJKLu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:50:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84348F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:50:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c62d61dc96so43281375ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697025004; x=1697629804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jXMPoHtqd/Hx6fmqzikg66SSiek1hyl8J8uZ94eBkM=;
        b=MlMVuK9l7ZchBCdcVeYq02hScRLv77WoJSIsU6f5kw0TpCul/0wKQGN6VTV82eZUXU
         QHHaq6ExGub6eUD0OXZK1ZI9Ced5do382vChI0CwvL0u9ajCKyqm17weKASdAQhmwE1u
         ksH9S9nxFiUp54yfpm/y49LrdpSz/HGdXq5RN0AImu/NLB3RbVlfixgeK3IO0cAjr7lC
         0EShU8CGjR2HWTXlLQ4+FzsMZpEZ3uAFde59ImSR4Gc8bruMySsDjNw1a323GVkmzKDP
         v2v+EwUw++hSr6KHqHUPh9K1V/gOpqQ/nMJSYF5lLugU57tFi+Krs+sdAUggQ9UjU/QR
         GJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697025004; x=1697629804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jXMPoHtqd/Hx6fmqzikg66SSiek1hyl8J8uZ94eBkM=;
        b=lTjVkh6XmYG6TGvIvZGDoW8CkziPPkNSODUDN/OlGgIZDVjOssCWBV1Vtzzg1JDB6g
         Bo5OGEhDDfjjd/xpHRTssUTGcUOjTJ6LEEsvPISW1Qbfnvpsbhxj0iuZCSbi2RirMTrn
         6wVGJl4yepvvVXLT6slHbP+jeoO1vepbmGNZB/akRoBwav04aueKq3zVXTuQddohPZPf
         9Ckkl7ctBBJ59drbfAloDn6zrqSIRRobk02HAcW9GAECe6hzD9lMblQuC6PtGuvQNuQJ
         Dw5b1pXc7H+JWKxJIZVipCnqEl8BYHhEP/0s4+gxPwJ+zVN6kXnSIcLfaUAcSzZyyYvr
         aRwA==
X-Gm-Message-State: AOJu0YwyfcgilhpI1zAwEgKRvYu1cPu0iouN/hlCigtd9cisVWb0/T/s
        +7xWBVMWNx8bmYb2enj2U/t+cQ==
X-Google-Smtp-Source: AGHT+IEDCqXJj3YOhgBFw9VpCN1j9W+/kcrhhPe3h0VKXOEk8qhAXQDlXRw7da3dwnXFhyKLZaiHdQ==
X-Received: by 2002:a17:903:32cf:b0:1c9:c3eb:6557 with SMTP id i15-20020a17090332cf00b001c9c3eb6557mr3824638plr.0.1697025004127;
        Wed, 11 Oct 2023 04:50:04 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902c18300b001a5fccab02dsm13752060pld.177.2023.10.11.04.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 04:50:02 -0700 (PDT)
Message-ID: <bdddc6f5-5e17-445b-bd86-dc14a8d17866@bytedance.com>
Date:   Wed, 11 Oct 2023 19:49:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 05/15] sched/fair: Implement an EEVDF like policy
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Segall <bsegall@google.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
References: <20230531115839.089944915@infradead.org>
 <20230531124603.931005524@infradead.org> <xm265y3sodyo.fsf@google.com>
 <a54a4ccb-9d56-4686-93b6-e9bbbe01f625@bytedance.com>
 <20231011073317.GJ14330@noisy.programming.kicks-ass.net>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231011073317.GJ14330@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 3:33 PM, Peter Zijlstra Wrote:
> On Wed, Oct 11, 2023 at 12:14:30PM +0800, Abel Wu wrote:
> 
>> there are cases worthy of breaking the 'eligible' rule.
> 
> See the discussion with Youssef, if we weaken the eligible rule you get
> horrific interference because you end up placing new tasks around the
> 0-lag point.

I have just begun studying the EEVDF scheduler, and obviously there
are lots of things to catch up with :)

At a quick glance at Youssef's first reply, I'm sure that's exactly
the same as I thought about, the EVDF. The intention behind is w/o
eligibility the task_timeline can be organized by deadline rather
than vruntime, hence task selection can be done in O(1) while the
min_vruntime can be updated through augmented rbtree.

Anyway, I will learn from your discussion with Youssef first, thanks
for providing the info!

Best,
	Abel
