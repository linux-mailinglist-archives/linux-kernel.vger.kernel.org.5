Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4098D80ED8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346426AbjLLN3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjLLN3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:29:14 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8589483
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:29:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso36360875e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702387759; x=1702992559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOStVxKY4YCNHIjdcsC+mJnYNDfKkMJb33FNSgTV1+U=;
        b=VdTrhFuprTXp7NaCFkWb83mpO4/OPdS8qyCdI1Gw7Hs/KjNeqWPVOfFz8Ef+4tkPNU
         YBEvHUvk6wBwpw9XIuEk/zaJSiQg+NWh/bg+K/YrYLp5kAt2zlRgExBVUh72mE75rCN7
         9282ytY3fvPA5NOb1XwdQVxOOmNLmbkgzRpnbw/LdPPbloDOHuYQESUlpgRGoxS/Par4
         cLbUAAnFmgCEPkDMgrYvQsNQtQPAdX2ljzhOzshAGo1+zm/zNeaYrrQknZXz4OYup10g
         DlGMkH9IlS3D2k/19kWL3iEykNldRVWANVD5uX3/D+PbPDXw2kcTsPeXJ9d2YpWD/X9z
         CkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387759; x=1702992559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOStVxKY4YCNHIjdcsC+mJnYNDfKkMJb33FNSgTV1+U=;
        b=vORwMOeMHlrRricscBA87O9DxRZtRYE2ZJyx/dOVKMtGpVMHcZ2oFUTaF2iALoH4Ke
         IdkVwimGy3onlFG84o2FjGrC9beeOmZXVhj9V9WoApdIjNHVzQ9/Jv7tgg6F1vcLkCl8
         TetlIOHZAtzFkIRUhRJgWgMwxai/i2lO6s1YqW9SfPzOOlFDt2/PYbiecUWG/QeN/BE4
         jEdm3/mhv73x0cgnFitvS48vypZQBgoindl2BKx1CivbKLaJX/biGpx/OfOLcDRx+L0T
         qr6/p/7Zrj+yzKhw0f+fTo63oGTTtMOJyRBONbUIBQYfuyg+SZE9OVOloKjWELX7Zt3z
         Om4Q==
X-Gm-Message-State: AOJu0Yz7O409lghj+r/kTk7VV4n1wurXC9WkImnbVwbsMr2vz9n/Fr1q
        zrVtZrssDBtbpJND3iibO6S4RhMEHOWEbY36oIlWXA==
X-Google-Smtp-Source: AGHT+IGDzG8G/MLny4p0Z41xzd5zRruVe2LE88yw60iRB7odU7mU/s3I7Az8fWV/1EeDPawrX7neRA==
X-Received: by 2002:a7b:ce87:0:b0:40c:36e7:ee67 with SMTP id q7-20020a7bce87000000b0040c36e7ee67mr2199340wmj.202.1702387758933;
        Tue, 12 Dec 2023 05:29:18 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600c450b00b0040c495b1c90sm6191363wmo.11.2023.12.12.05.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:29:18 -0800 (PST)
Date:   Tue, 12 Dec 2023 13:29:17 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Christian Loehle <christian.loehle@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20231212132917.h2h5ves3ob24i5wt@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <739492e4-b9a3-4c55-82e6-60b02d489c5f@arm.com>
 <20231212123401.xmggng7dtxvdxqj6@airbuntu>
 <63cf5c75-6bd3-41c9-ac5e-518750874f8e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63cf5c75-6bd3-41c9-ac5e-518750874f8e@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 13:09, Christian Loehle wrote:

> > Arm was working on a way to help convert it to per-task. See Lukasz email.
> 
> I guess that would be me now :)

Ah, sorry haven't noticed the email address :-)

> Apart from considering per-task I'd like to get a reasonable scope for the
> feature designed anyway.

Beside the iowait boost is completely ignored at migration. There's the desire
to disable it for some tasks. Not every task's io performance is important to
honour. Being able to control this via cgroup would be helpful so it can enable
disable it for background tasks for example. Generally controlling the default
behavior could be useful too.

> If you want to play around with this too, I have recently added --thinkcycles
> parameter to fio, you will have to build it from source though as it hasn't seen
> a release since.

Thanks. Might reach out if I needed this

> > Your tick is 10ms?! sugov_iowait_reset() should return false then. I see now,
> > we undo the boost in sugov_iowait_apply().
> 
> Again, just to emphasize, the disabling of iowait boost then does not come from
> sugov_iowait_reset, but sugov_iowait_apply, which will be called in dequeue regardless
> in your patch, plus you're lowering the rate_limit_us, which right now acts as
> a 'iowait boost protection' for your patch, if that makes sense.

Maybe I should have redited my reply. I meant that I can see now how we can end
up undoing the boost in sugov_iowait_apply() under the conditions you pointed
out. So yep, I can see the problem.


Thanks!

--
Qais Yousef
