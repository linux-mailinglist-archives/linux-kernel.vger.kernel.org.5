Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65C57E5232
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbjKHIwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjKHIwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:52:09 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098CC170F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:51:43 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6ce37683cf6so3961870a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 00:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699433502; x=1700038302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPnUSXZSuFsVDyxEjkbmOaLUrQp90gv12AHBoiXvvgk=;
        b=h3Yiz0NdawrqKrspxjVfpOeChlD0fXLIO/2VujQoWnHEW0tZa4tgRfRmWe9FFmTrXJ
         gSel3absClZ7/CyxVxOvowBPmvG7TtCtZLjcpwd/oKPRepIjbVBxAqyyQnW1Exawcb7E
         xk9BrpM4agfwWJCqPsJqiRJLeGwgbMt9SCPvhDnTyXKH89oGCSV/9ulSOVaMIyDO/W1x
         u8QcqFnQ5iGL9DhC3VSkbCm/xe/f13X9T3WdrJCtIAookzKGDp7xpXWBlU2vydsFo+QR
         UXg3iiJW08UwZUTzXl0Te2gYJfMnYc+CziysYmckMTaiTXtWFWKwRLsPZOuhLSmByej8
         OGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699433502; x=1700038302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPnUSXZSuFsVDyxEjkbmOaLUrQp90gv12AHBoiXvvgk=;
        b=LmarXxj3o+LsQ6NAiNdDzII28m3xKmee6HqdIRf7cfeWXE4Ns2qQ8ONYpccstyV6Rh
         ip1OGRotlRqt8/WHsC9FPtk6HmofqH3njze+C6X0XDLLHgHssAdLiVcsOvtxwcg22H2q
         cgWgIoZpCCry23WHY0gx+QqmBYcxvnc3FHlioqliSTBhJZ63fsHFB5qPV7I5MWxQxjTP
         kA1ls2fjcs5xjt7xyf4UXm0njQ0XcRn40qVD3U7sA03T+4Uqo6mr9zteOaHFl5IIwW1S
         SuSjxKM3ZtguJ9Pj3t9J2OtGmjwoTLtzovsNHR7GnAaQ2oHTjPOZjfZ29tnoZz25j+rK
         ioiA==
X-Gm-Message-State: AOJu0YwwekKY4LukhTuyWUr1Flv8lNfEOe5dylHV1PkGT9pzmMPD5aPo
        61jmgWYw+s/9kVULHkdecAnbMA==
X-Google-Smtp-Source: AGHT+IEGCm4Lxktzfn6pIMapfG4JXoFXiNnAi45UGeekdFw737LxG7HKddI8fCg14nQhQ6GxujrfPA==
X-Received: by 2002:a05:6870:1782:b0:1f0:811a:4027 with SMTP id r2-20020a056870178200b001f0811a4027mr1382275oae.8.1699433502220;
        Wed, 08 Nov 2023 00:51:42 -0800 (PST)
Received: from [10.84.153.152] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d11-20020a63fd0b000000b005b82611378bsm2680657pgh.52.2023.11.08.00.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 00:51:41 -0800 (PST)
Message-ID: <917f6c3f-33b6-4161-af30-f8bbd99a8720@bytedance.com>
Date:   Wed, 8 Nov 2023 16:51:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 2/4] sched/eevdf: Sort the rbtree by virtual deadline
Content-Language: en-US
To:     Benjamin Segall <bsegall@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Barry Song <21cnbao@gmail.com>, Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
 <20231107090510.71322-3-wuyun.abel@bytedance.com>
 <xm26h6lxuovd.fsf@google.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <xm26h6lxuovd.fsf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 7:26 AM, Benjamin Segall Wrote:
> Abel Wu <wuyun.abel@bytedance.com> writes:
> 
>> Sort the task timeline by virtual deadline and keep the min_vruntime
>> in the augmented tree, so we can avoid doubling the worst case cost
>> and make full use of the cached leftmost node to enable O(1) fastpath
>> picking in next patch.
>>
>> This patch also cleans up the unused max_vruntime() and adjusts pos
>> for some functions.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
> 
> I've run this through my tester and it agrees that it does fulfil the
> EEVDF pick (though this implementation is trivial enough that that's
> fairly obvious just by reading the code, which is a nice bonus upgrade).
> 
> And it makes sense that this would help for performance, and the
> fastpath seems likely to trigger most of the time for even better
> results.

Thanks, Benjamin!
