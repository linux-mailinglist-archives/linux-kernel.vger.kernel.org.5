Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD061810C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjLMIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjLMIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:23:51 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD27DDC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:23:57 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d9f514f796so4008281a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702455837; x=1703060637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qCVNOaLr4tkihNZ++QhY5TPWTKHDR7VGtdB5p3rXeI0=;
        b=BcgpAodwa6Sw0xgYnPeu2UmtxKDvHxDat3EYUTX2IbW9Qg8+qNBZew8AAUZ8vL609j
         645Sd1ookwkoPQMfiSZonEJNydsDA31zNNT7RRSNBDukvjPIGaV2yOfoO9KY4pKwx+a2
         Ha8Na4C2TmGceV3b6XPycpHsvm6jd26QzWaqjntP2NNxmRorsYPsmGdJXyi6NXJh22le
         HWWWINJ/UrrN5omcfygLvshr4oqQafrXQkXo/kh0P4NCK08TFKYVebtGLI8Avik7dRp6
         1e1QRUZTkRIPps7PRZ37WjY8Ugzk1ubX1AW4ulRYkVa1eCOpKOiDVOMy8AoQ2IMUnnA2
         tdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702455837; x=1703060637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCVNOaLr4tkihNZ++QhY5TPWTKHDR7VGtdB5p3rXeI0=;
        b=GNApfmaLEh0+E3ihI+g7wqZDE62qmdnq4kJCsGjOZHs42tHtQutW6q1P2LQAw99j60
         XIYewmthnGQ+TZPY/DWPRbBPpbVucr+8XBbq6pGt5jvVmN0v52tx+Q2Xw6BXdlPrOd0r
         OrJrJM/PURCuRDVKAebiXQjdks7OV1lREMOnwj9nvfuFgM57qpUW9awPctOBDM/6F8qp
         aEuH8hlsJ858PzFTN43xnVnIonR26R5w3muuJBB6fmys29FwaqvM6o3QdnEcoUYLJqRJ
         CDHwBpMFD8VbYKr6jt0pl/8C82n6L9Da7Xrbk9YclNbpSeYlbkjaM5+XbPlKNLddve7c
         +uEw==
X-Gm-Message-State: AOJu0YznJQo575AY3Qvrwm8nGU+oaLFAELjZL2HPnXgQikmRzHS7Q0Dc
        6hEGRaMA1NVb99NMyT4nl3zbD4YzAGkdRO2HBWfKGQ==
X-Google-Smtp-Source: AGHT+IFtBbBSvzY5hSlu4dtbJ4TNc7NME/tgTGJaWaPy49+lqB43MeUBdXLoPalaL/2QXdILyB90YHZs1EnDGkzGjkY=
X-Received: by 2002:a9d:6d02:0:b0:6d9:e7d8:a4c7 with SMTP id
 o2-20020a9d6d02000000b006d9e7d8a4c7mr8247396otp.73.1702455837076; Wed, 13 Dec
 2023 00:23:57 -0800 (PST)
MIME-Version: 1.0
References: <202312101719+0800-wangjinchao@xfusion.com> <CAKfTPtCMOPVhjpLW3Y3fb4=rfYnAKzYeDmdMCRHjPzZdXYjVxg@mail.gmail.com>
 <ZXlXXaGUsiH14pUb@fedora>
In-Reply-To: <ZXlXXaGUsiH14pUb@fedora>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 13 Dec 2023 09:23:46 +0100
Message-ID: <CAKfTPtDCSQg_Nwh5osRVL0TEzvNZjrUmg_KsVmJySjV_XnOHzw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: merge same code in enqueue_task_fair
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 at 08:04, Wang Jinchao <wangjinchao@xfusion.com> wrote:
>
> On Mon, Dec 11, 2023 at 04:23:52PM +0100, Vincent Guittot wrote:
> > On Sun, 10 Dec 2023 at 10:22, WangJinchao <wangjinchao@xfusion.com> wrote:
> > >
> > > 1. The code below is duplicated in two for loops and need to be
> > >    consolidated
> > > 2. Fix the bug where a se's on_rq is true but its parent is not
> >
> > Could you clarify which bug you want to fix ?
> Taking into account the additional information provided by Tim,
> this is not a bug. Therefore, this patch is merely a logical
> simplification.

If there is no bug why changing it ?

The duplication is done in order to have the same pattern in :
enqueue_task_fair
dequeue_task_fair
throttle_cfs_rq
unthrottle_cfs_rq

so there is no need to change it

>
> I will send out a v2 and update the description in it.
