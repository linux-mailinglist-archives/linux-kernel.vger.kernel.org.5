Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D117EDAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344759AbjKPEsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjKPEsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:48:20 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0CBB4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:48:17 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7c011e113so4359927b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700110097; x=1700714897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13rdwJ771LtcOAeAW0HFHXiZFoyFfBWatO4Mat4LLXo=;
        b=fDm7aHX5xVNZ/oUsXIflaXqHfyiODd3dgGzekczKoaLJDQu56ov6Yhs2cl8VGHyh+k
         dduEhVrsxU4r9WIeeevI9EQe9f9jveyBj9Ji2VBJqTL/y5V5ZPkc7iL8AUArQcqO60BJ
         3bO2QL9i/MjBEcjLkGrwIj4l/6MC/xWJuITonpSAyOlTh4GItxDBGfh0C5OxkxW47mQC
         9nWgqAnrZHlDZOSK2aKN2qaHC0mha7ZTxHiaW2szQrBHi4vlx3f6DwL7X2GoyPPz4vNu
         l+s4S8dOtHgNz1sRIPY4YP3hdyipAvGo53fZONZb8ch75vX8pOeCLkUD4gC5AhByiuy7
         h1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700110097; x=1700714897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13rdwJ771LtcOAeAW0HFHXiZFoyFfBWatO4Mat4LLXo=;
        b=t/B5HyQnjKPpXuVWH31xoBHEZX6t7j1v70UnSs8watY0uQWN/Rn93QnTMGU+dyzXb5
         qbWtSh0LPJaQHRYpxDsfrgKDB+eUYAizTl+Sy6wKjvhtgomP0CHUmEi5uJel+AwBwmnv
         ozrGamdipIW0g03vI6quSVvxnQYgYIN8/WUJICx84vJFoROuJ63PL1+kyET9F/ruwQjw
         ATDVDfdOiUBPKTSEegwL6+fmrh254CFSSzjy/JLX223t1A0i2CJU15XWua3BNZCgdKSO
         ta+YzzRTjRrl3tt75JFgVhaYnGjuTmE/aQwstxhccMTCwThI/Us8/kwNtqo+VPpKOch0
         x9Jw==
X-Gm-Message-State: AOJu0YzJAWa4fq2BXq0+qw3n80UOb+tBjIuMBnS9OWPs5M7yupYm9mtP
        mSUhB63UsuiMtOM1bdLE1PJDWA==
X-Google-Smtp-Source: AGHT+IF3RMVpvOU5tLgqXHd3hVeATw0M2fvNoMGcZCOzbKdLroECEZov1Gxp3yf0UzO4pw+CreQtIQ==
X-Received: by 2002:a81:8984:0:b0:5a9:30c3:c664 with SMTP id z126-20020a818984000000b005a930c3c664mr12430342ywf.19.1700110096775;
        Wed, 15 Nov 2023 20:48:16 -0800 (PST)
Received: from [10.254.46.51] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id n19-20020a62e513000000b006c60b150383sm3731924pff.12.2023.11.15.20.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 20:48:16 -0800 (PST)
Message-ID: <23cebdf8-1a51-481e-a8c2-e17021099e05@bytedance.com>
Date:   Thu, 16 Nov 2023 12:48:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
Content-Language: en-US
To:     Yiwei Lin <s921975628@gmail.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Benjamin Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
 <20231107090510.71322-2-wuyun.abel@bytedance.com>
 <da42f1d7-adfe-485e-987e-3e8dae78b4c2@gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <da42f1d7-adfe-485e-987e-3e8dae78b4c2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 11:36 PM, Yiwei Lin Wrote:
> 
>> @@ -3712,8 +3811,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>>       enqueue_load_avg(cfs_rq, se);
>>       if (se->on_rq) {
>>           update_load_add(&cfs_rq->load, se->load.weight);
>> -        if (cfs_rq->curr != se)
>> -            avg_vruntime_add(cfs_rq, se);
>> +        if (!curr) {
>> +            /*
>> +             * The entity's vruntime has been adjusted, so let's check
>> +             * whether the rq-wide min_vruntime needs updated too. Since
>> +             * the calculations above require stable min_vruntime rather
>> +             * than up-to-date one, we do the update at the end of the
>> +             * reweight process.
>> +             */
>> +            __enqueue_entity(cfs_rq, se);
>> +            update_min_vruntime(cfs_rq);
>> +        }
>>       }
>>   }
> Sorry if I am asking stupid question...... It looks like reweight_entity() may have chance to change the weight of cfs_rq->curr entity, but we'll never update_min_vruntime() when reweighting it. Is there any reason that we can skip the update_min_vruntime() for this case?

No, you are right!

Thanks!
	Abel
