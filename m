Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2520F802F5D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjLDJyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjLDJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:54:33 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADB3B2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 01:54:40 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c6734e0c22so279902a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 01:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701683679; x=1702288479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hUsWs1Nvk+Jou3+4Sjpg4bycXQIYoHKO7jqfrQ8ZCms=;
        b=IJAWxRAeXQBOaGQ6v2MVvGZ69vDURHh/b6sxUxyVbBOt/1vyLdZwRTlgTS3mM6+GOt
         Km1udSbP1wZpcLSAAikAyDuJNS932uQlrzdCRbx1IjDa5VbwhyAl27tpzJ1CTPx8P6rN
         lWecl5nTpsEjGnvBniujmo4hB3SNHXJyPejb//WIzokHXrLRLwHmz7bBDh7F1JvrVr8K
         1p56/rf/L9IaEBeENDjQ95DKFweFDCXsD6y7mRRlXooyTw0B7DT3WY4JoP/RtBNgkp34
         lcKoHpPRUFOanq4T6uJ5vb1RgDnrpLQvFx/oy7lcJjasU/qglbpgXxQPr6glxTrkng5t
         KTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701683679; x=1702288479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUsWs1Nvk+Jou3+4Sjpg4bycXQIYoHKO7jqfrQ8ZCms=;
        b=s6YCVc+sJZ+IeFjzaMH3NDpiXcTmdh2cgUsZdL9HnTuC5uEQvQcQa8PJoVYpEXgutC
         R6MDIK2OXMj0pLVWcMBYGeQwze90X7ton5d1xWSimAvwR9MJ4VHOBh50R3L7BcFYgtUl
         3yhj1n6zpXGSrShHOLt57U8NfSrMzrE8ypcmGK4eXmvyjtYEuLBTxmxsKFU/rNCEGC5W
         GiEfL2R/6TbcVuAc1EMNdc+Sm7iqt9npGfVa67HvpZBdBJRTGZ63AyHAKq/oqesSPoss
         BhB5QvBvZifygLzWmRHla3/zOtf98L2F1GXPTDrh/PL51rPHBAmRBBwQ6P/xyArDqIQN
         O2gQ==
X-Gm-Message-State: AOJu0Yx+nmrbcvmCdv2xUlu5wzLLitV0WF9f7HXrCbiptzpcoGrQm4BL
        QODun7a1OwjVbd6WFwCmrxNRjqJYfq7CBJPlTfDlxw==
X-Google-Smtp-Source: AGHT+IHPMq8cYQ67dLAceR4HoLFnxH0xvjOES1gCYUV17Diouoj2bI+S/BdXbWsamChxOsIk3L3g7vT6yVsJX4MYsU8=
X-Received: by 2002:a17:90a:e7c2:b0:285:92c6:cc26 with SMTP id
 kb2-20020a17090ae7c200b0028592c6cc26mr1026221pjb.40.1701683679503; Mon, 04
 Dec 2023 01:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20231201161652.1241695-1-vincent.guittot@linaro.org>
 <20231201161652.1241695-3-vincent.guittot@linaro.org> <20231202233812.cq2nodia3estdexy@airbuntu>
In-Reply-To: <20231202233812.cq2nodia3estdexy@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 4 Dec 2023 10:54:28 +0100
Message-ID: <CAKfTPtBcF=sL6O17Vq-zCwqp48LNN46oTG=Drs5=MEh=gbuxPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Simplify util_est
To:     Qais Yousef <qyousef@layalina.io>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        corbet@lwn.net, alexs@kernel.org, siyanteng@loongson.cn,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        lukasz.luba@arm.com, hongyan.xia2@arm.com, yizhou.tang@shopee.com
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

On Sun, 3 Dec 2023 at 00:38, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 12/01/23 17:16, Vincent Guittot wrote:
>
> >  /*
> >   * The load/runnable/util_avg accumulates an infinite geometric series
> >   * (see __update_load_avg_cfs_rq() in kernel/sched/pelt.c).
> > @@ -505,9 +469,20 @@ struct sched_avg {
> >       unsigned long                   load_avg;
> >       unsigned long                   runnable_avg;
> >       unsigned long                   util_avg;
> > -     struct util_est                 util_est;
> > +     unsigned int                    util_est;
> >  } ____cacheline_aligned;
>
> unsigned long would be better?

I thought about changing it to unsigned long but I prefered to keep
using the same type as before for the ewma as we don't need to extend
it
