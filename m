Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81EF7898E8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjHZUDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHZUDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:03:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECA171A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:03:37 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so18228345e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1693080216; x=1693685016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqmsXyBXLKTX7YSUl6ubXeaJvBb1JLujfg2gQY+T8kQ=;
        b=XObVo1VkEqTsXyk+iSehitWNmBUxqRASbuXlbavh6mGE0N5dc3Qj1M500Do2QsfwVF
         F2j9t74wYJwgPHXYPgyk+jMQLbTyY4lA+f+mmsw6jZ+cqB32kcs8qygg1SAHs5zcds3D
         RZCfT/Ox2G9NgxVuvTtIE8LoKEpRAOlCHGfE7MUBDcn0qBO2qoRPUeaWdmMvD6ZMvhSw
         QCQANAmbw9SwKjtCdXnwJHqlDDXc881RgMtUQbn0OZ6tq1ozgKVWoaed35piyO+ykd9v
         kBqXypfabThDEcvxIeifGByRxnVABKrkHc4gpwylO9mYJqxta+8cWgJy/BT46MPsvM6o
         xEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693080216; x=1693685016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqmsXyBXLKTX7YSUl6ubXeaJvBb1JLujfg2gQY+T8kQ=;
        b=HvUgNUCzXYlPJRz1y7Tp5Dgv0R6RIxQiGGnQR5Rj++AfZfQFM47SQyb0jxoGR6pMgj
         oxf5HmO0gT/1Afm7ibXz5XsTaG/i4QYBU1xR8gm5+/oQzQzPoyguwVbLNuSrcFcW90sU
         NVSOYurwKbvkBusIKaYXptNYaby4WzktEJtk6/ZxnPt6cJHgD3/zr3QiUj5/p9H7F91y
         HTUZOzVcNfmvSKHN/0hTsEmhVhn0nb4HltdH95nHDLx/pdVNMGi7QUBrFk/cOwFEh4v/
         1ovo3qvMTGBaPy3aXsN7qY4ZddijBMH0JpY7kKwvNL48f6mVfLdfnQ4Ln3JRFViC+4Jj
         zTUw==
X-Gm-Message-State: AOJu0YxtQLdI5a9siA2eweGgP8P73IgOoZ2C2KFpg1lnP34ogkLo4N1R
        ptrxlunhIv2hTgcba/hghd1tWw==
X-Google-Smtp-Source: AGHT+IH0uR5usSheRdcsxmVlNmtGXRQ62miiTR01dcC6JQTF96VSXK5kQTWkQm0V1fvmSt8VrGfaCQ==
X-Received: by 2002:a5d:560a:0:b0:317:58e4:e941 with SMTP id l10-20020a5d560a000000b0031758e4e941mr16272289wrv.33.1693080215861;
        Sat, 26 Aug 2023 13:03:35 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6783000000b003180155493esm5655431wru.67.2023.08.26.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 13:03:35 -0700 (PDT)
Date:   Sat, 26 Aug 2023 21:03:33 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 1/4] sched: cpufreq: Rename map_util_perf to
 apply_dvfs_headroom
Message-ID: <20230826200333.beluyc76rmbb5w3o@airbuntu>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-2-qyousef@layalina.io>
 <bc9cd8a3-6bad-3f40-735f-f54b7f3b46b9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc9cd8a3-6bad-3f40-735f-f54b7f3b46b9@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/23 18:38, Dietmar Eggemann wrote:
> On 20/08/2023 23:06, Qais Yousef wrote:
> > We are providing headroom for the utilization to grow until the next
> > decision point to pick the next frequency. Give the function a better
> > name and give it some documentation. It is not really mapping anything.
> 
> Wasn't the original aim to have a counterpart to task scheduler's
> fits_capacity(), i.e. implement a frequency tipping point at 80%?
> 
>   #define fits_capacity(cap, max) ((cap) * 1280 < (max) * 1024)
> 
> 
> (util / max) = 0.8, hence 1.25 for the frequency-invariant case?
> 
> https://lkml.kernel.org/r/11678919.CQLTrQTYxG@vostro.rjw.lan
> 
>   next_freq = 1.25 * max_freq * util / max
> 
>               1,25 *            util  <-- map_util_perf()
> 
> [...]
> 
> Difference is that EAS deals with `util_cfs` and `capacity` whereas
> power (CPUfreq and EM) deals with `util` and `capacity_orig`. And this
> is where `capacity pressure` comes in for EAS (or fair.c).
> 
> In this regard, I'm not sure why we should rename the function?

I don't see any relation between the two to be honest. Both are magical numbers
actually that no longer mean any sense in real world and people modify them in
practice, as you know.

As we brought up the topic in pelt half life and other avenues, this 25% is
a headroom for the util to grow. And this headroom is required for DVFS reasons
as evident by the current definition being in cpufreq.h.

fits_capacity() is about misfit detection - I don't see any relation to
selecting frequency. But voodoo relationship that is based on past
circumstances I don't see holding true as both code and systems have evolved
significantly since then. I think you're trying to make sure we've hit the top
frequency before we force an upmigration early. But this is artificial and not
a real necessity.

Consider for example a single task running on a medium core with a capacity of
750. It has a steady state utilization of 300. Why should it run at 25% higher
OPP which can be one or 2 freq jumps difference? And since the power cost is
not linear, the power difference could be big. Not a cost I'd pay to
artificially coordinate with misfit detection. And how about SMP systems that
don't care about misfit detection? Why should they be tied to this magical 25%
headroom?

Note that DVFS hardware is a lot better nowadays that it is common to see
a reaction time of 500us. So if this 300 task goes through a transition and its
util starts growing again, we'll react to this within 500us; that's barely
a few percents jump compared to the 25% one. I think this is what the headroom
should be about, hence the new name.

I will send the patches to address this issue separately soon enough; they're
almost ready actually. I didn't expect the name of the function to be an issue
here to be honest and thought it is clear a headroom for dvfs reaction time.


Thanks!

--
Qais Yousef
