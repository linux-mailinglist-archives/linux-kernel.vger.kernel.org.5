Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C9C7F5C61
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344669AbjKWKeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWKd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:33:58 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23C91B6;
        Thu, 23 Nov 2023 02:34:04 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab11so1013218a12.1;
        Thu, 23 Nov 2023 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700735643; x=1701340443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iKQtp18JQp0c7NBbEbV2rdtJ3WRW+N/V6u+CJnl4oQQ=;
        b=mhf24aQtwm9yCORnHXcU9aHiAuz7m8dPidrjXq/5o9spnKZXN9gtUXEQhgf8kYEV4e
         jBjUcjA1zyf9MHyokUFLN6sIkYSpmZ5MPT25OUzp4pPa6Pw4IgDwdRmYGrkyW4DAo1r9
         yxRdSpKcUREuKlaMYnERFSTCKxApBAkMazo4P2LKAF6aVnfglwla18IRF9ACRLb/vNVb
         Am+JnObtAu3xgMNUoxZrgi53ixuMu96OT11vVOSUdyQmglaP3VLlz6fi214mQK3WduIn
         LlpmafGqym/BSa1rMzHif2NVdnDgJr938Oblh5fhYuWBsLx4cTTQ5Fdpo179wLt8rU3w
         /rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700735643; x=1701340443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKQtp18JQp0c7NBbEbV2rdtJ3WRW+N/V6u+CJnl4oQQ=;
        b=LNAxinuu3+7YpLOoSqdGJT0TDJXVOFNibQN9U8JEHsGm1sl79vm+ne5LIe77TZf46D
         W2VxbnyXcngNFL3yw3pVCN4QeV98LgSNcPkbTMiYmDJOtBbZM3EmANw9GQYROqUwRLq8
         8J6Aq/xA7dQsMqviApnHjtGiHzic+frc1yAnhBcAj6UPz6sQ8fXen3udzwS9/GMPw8mB
         vl2HjXtsSPJifXJ7pXNmCGhaD2LeYEAQCHbQUtDw8D2BK/s3Onsa07K72yRuTUPGcGea
         wCdoBjZFnFephi42l8yjZ3COybpVyQQfA2wliUApW1GYr9MTl4V5GpVKYHkb9ryxhnbK
         C8FQ==
X-Gm-Message-State: AOJu0YymBK28BD+vzxFikC1vF70JyHBNG0KzKgRD9nFKubol72W+OfND
        e4OVHn6NMQ6VOzj5cVId0BY=
X-Google-Smtp-Source: AGHT+IHsuDtDlKW8ZHcAOngvbmoPlDZUP/co7CvQCsWrOLYZqFMmlR3FfRJVAUEecENHdbKTPiLqwA==
X-Received: by 2002:a05:6402:705:b0:548:656c:5371 with SMTP id w5-20020a056402070500b00548656c5371mr2365856edx.16.1700735643164;
        Thu, 23 Nov 2023 02:34:03 -0800 (PST)
Received: from gmail.com (1F2EF67D.nat.pool.telekom.hu. [31.46.246.125])
        by smtp.gmail.com with ESMTPSA id d9-20020a50fe89000000b00544f8271b5fsm490373edt.8.2023.11.23.02.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 02:34:02 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 23 Nov 2023 11:34:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, qyousef@layalina.io,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Subject: Re: [PATCH v4 2/2] sched/schedutil: Rework iowait boost
Message-ID: <ZV8qmKccdVeVhVt9@gmail.com>
References: <20231122133904.446032-1-vincent.guittot@linaro.org>
 <20231122133904.446032-3-vincent.guittot@linaro.org>
 <CAJZ5v0iBO9LUs7xJKF0w1sOTM2ted5KxK4idwyCjBReyEYw+mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iBO9LUs7xJKF0w1sOTM2ted5KxK4idwyCjBReyEYw+mw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Wed, Nov 22, 2023 at 2:39 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Use the max value that has already been computed inside sugov_get_util()
> > to cap the iowait boost and remove dependency with uclamp_rq_util_with()
> > which is not used anymore.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> Or if you want me to pick up this series, please let me know.

I picked this series up into the scheduler tree, as there's quite a few 
changes to the main interface with sched/core.c and sched/sched.h here.

Thanks,

	Ingo
