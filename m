Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D8E809584
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjLGWlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjLGWlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:41:02 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CC2170F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:41:08 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ce33234fd7so964347b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 14:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701988868; x=1702593668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWwtPSuJ4EcoYc0K8T+hlW+rYGdha5aHVzCoAjzsYOI=;
        b=laTgJrFNtg49Gzjdh9o6OuuZXExkyAkxvD8m8vPwwa/l8uLGKYJHC/phAh8fkXJVix
         aIZBgFSWyg9pHoEmSdXg5FlIpd/IvE6pUi239MgKsXqx9RbYOYN3yiwRV6jksIiMHwDz
         MOU291Hq1OGTTM6pgMnd8s0d8Lm/mSQ6YWYMfhayxhn5PYFfecgR0z25foGhNlffOtPc
         l/b3xbCuMDCkrdUsstlua4afuZbR0rQe6G3xYUwCZ1QhuAfR2LFWAG6rSIwHcBhG+B3I
         YXRccbz9wPKyBwd9ceIdv/pwdUceWjn7RlHGWGqdu7TAHacQ8+f3Znm0Lr0hLoiWVBUp
         fOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701988868; x=1702593668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWwtPSuJ4EcoYc0K8T+hlW+rYGdha5aHVzCoAjzsYOI=;
        b=PeF6HMFJSiSJskZt4O+sSmPwjlMaznthwhljEmAMK3fRsNq1n8jbdpfPRoyY0t19p8
         yHSY3wtS6QAWYARn/gGNHG9Bf/JNJY6DUr+lKeugi+8fmZP2Sj/BYeOlwBtKuOBKFw7v
         ZJ1AVQySlZ4azrv3fnIKdSqcR/iJI7N1iVS2ugZZCPIfa9hj/dIVLKf6dhYB+7drNcGw
         6ONb7z5MejtpuMcExn3capl1MzZQFnyWjzSg0ICwvAQ2YOGS549SgBgYZBIlruDTigIK
         ZUNNJ99a8CMp8QH/NwOy9iXneqDKmQJe5goRuZmcKUqcdvhBzbLkx7BjFpVF/aY6QEQL
         B4TQ==
X-Gm-Message-State: AOJu0YyhOu4/MowRL/SgH24DhJGJIL+R1fBoWXe6oYT/80d5jzUzWrqn
        zT8p+MwRNk6FrwWKxrN/JW8=
X-Google-Smtp-Source: AGHT+IE9XaDZDNAUL1akhCPfx9OlDdLiDvkRIFHb5YqrrbCEAhJa6yX7Gb7gvAm75kQSPeyeUAciGQ==
X-Received: by 2002:a05:6a21:a5a4:b0:181:ed8b:4823 with SMTP id gd36-20020a056a21a5a400b00181ed8b4823mr3537546pzc.43.1701988867842;
        Thu, 07 Dec 2023 14:41:07 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id t20-20020a056a00139400b006cd88728572sm282054pfg.211.2023.12.07.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:41:07 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 7 Dec 2023 12:41:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Gianfranco Dutka <gianfranco.dutka@arista.com>,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at
 runtime
Message-ID: <ZXJKAnrRjBUmKx1V@slm.duckdns.org>
References: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
 <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc'ing Waiman)

On Thu, Dec 07, 2023 at 05:32:15PM +0100, Vincent Guittot wrote:
> Hi Gianfranco,
> 
> + Adding all scheduler maintainers and few other people that are
> working on similar things
> 
> On Thu, 7 Dec 2023 at 16:07, Gianfranco Dutka
> <gianfranco.dutka@arista.com> wrote:
...
> > I'm a bit new to kernel development but I had a question with respect to the kernel parameters: isolcpus, nohz_full, and rcu_nocbs.
> >
> > Basically the question is this, am I able to modify the three parameters I mentioned above at runtime after the kernel has already started/booted? Doing some reading online it seems that it’s not possible but I wanted to double check with the maintainers if there wasn’t some sort of change in the works that might make it possible. If not, what would be required to make the change after boot-time through some kind of patch or something like that? Would that be something that might be valuable upstream?
> 
> It's not possible but you can achieve something close with cgroup
> although you will still have some housekeeping activities happening in
> your partition.

FWIW, Waiman has been improving both the usability and level of isolation
with cpuset, so it should be better now.

Thanks.

-- 
tejun
