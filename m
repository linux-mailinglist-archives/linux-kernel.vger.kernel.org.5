Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA4B812FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572999AbjLNMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572978AbjLNMXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:23:41 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7446711B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:23:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6d26dabc560so63527b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702556603; x=1703161403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rs1Z6ikTJBs80pmW9mo6L5GeJM722tcA3lmeh1E5sKg=;
        b=TTlLgdnOLMr5vEES3IAN0dP/ZiUkh+4bm19FC9mClvN2aX+ccFP3ORkJ9sHPYkAnq/
         DkkZ92/slrv1QjhjBIf6ptPWkcpDQZZ35yw3usnnT0dGEU3pfDrAm8k1zlnr5kc1PaCT
         8ZcOyj4Q1EHyTYjZF1aEeX1RoaGazPrsRTI6CJpyHPFx/xbRiTaaRqE3IcQxbmha6Jyr
         BSDqIaC2OY8x+T07wHPBrE2UhFaLmivmP0KZ1MRh9m4BcCSKma46S5fK8XDX2J4CpHkW
         RiFAgoro1kjgoYXLLz70naMccwfwaxHjFEWe9d+5mOG8PW44ftlFDsqRA0m2opKKa40H
         LGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556603; x=1703161403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rs1Z6ikTJBs80pmW9mo6L5GeJM722tcA3lmeh1E5sKg=;
        b=flrMbKk1HE96TpvSSTUsJ4UKVe7FYVAmPrHXuxWvQThzAUXxbfpFIHgA9KfHzRkj/4
         7nykFSYz9qYB3QtVzo0qZPu0xmnuinQgSZZ95OJ0IsNP06MBhNj1ab772OaMBG8yI4wk
         8fxbBcWRtm8yp/+SsQ/LZ+qnRZUVhOMg92lVQQdB9sdqv7FA5j3z+FoN6YheIgU+I5U4
         rAtsZ2wZ2kZ7oJuWCw3Js5vd7Yjpu+pRGe46qQVKupabAVx5eS6TpJWI6whAiy3kcmhj
         JFtsitMGczb1cPwxP5kR/4g7JYgmx/WVT1e1jwHychuv3HXujC0nF+DfySivdoXGN0Lg
         F6DA==
X-Gm-Message-State: AOJu0YwHcOH35D7wVpWwc7K8vOCaGzlEVoZMxC9VBF9Wegjnj7zWfFGl
        JvkiXwjbeY10k+dmeUKjEKgrxA==
X-Google-Smtp-Source: AGHT+IFts1fBWEazxw2LWyZiXm04LxweFxLnQZr8BdAkbzl7cqld5hTTHgt1sKAu8dATF3bnnuin0A==
X-Received: by 2002:a05:6a20:158b:b0:190:1246:7d23 with SMTP id h11-20020a056a20158b00b0019012467d23mr12853669pzj.55.1702556602835;
        Thu, 14 Dec 2023 04:23:22 -0800 (PST)
Received: from [10.254.92.96] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a199700b0028afd8b1e0bsm2009452pji.57.2023.12.14.04.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 04:23:22 -0800 (PST)
Message-ID: <83099016-f609-4ac0-94ab-909ac9c96582@bytedance.com>
Date:   Thu, 14 Dec 2023 20:21:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] sched/fair: remove next_buddy_marked
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
References: <202312141319+0800-wangjinchao@xfusion.com>
 <CAKfTPtCrBvyxJzeRDARFjbU8P5BYW27So7gYE4FPWBDC0=HL3Q@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAKfTPtCrBvyxJzeRDARFjbU8P5BYW27So7gYE4FPWBDC0=HL3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/23 4:18 PM, Vincent Guittot Wrote:
> On Thu, 14 Dec 2023 at 06:20, Wang Jinchao <wangjinchao@xfusion.com> wrote:
>>
>> Remove unused `next_buddy_marked` in `check_preempt_wakeup_fair`
>>
> 
> Fixes: 5e963f2bd465 ("sched/fair: Commit to EEVDF")

After this commit @pse preempts curr without being the NEXT_BUDDY, but
IMHO it should be, so how about this?

@@ -8259,8 +8259,11 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
         /*
          * XXX pick_eevdf(cfs_rq) != se ?
          */
-       if (pick_eevdf(cfs_rq) == pse)
+       if (pick_eevdf(cfs_rq) == pse) {
+               if (!next_buddy_marked)
+                       set_next_buddy(pse);
                 goto preempt;
+       }

         return;

which will align with before.
