Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BAA7CE974
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjJRUyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJRUyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:54:38 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2659B111
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:54:36 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4194d89a6dfso49211251cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662475; x=1698267275;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eoAkC1pqR3QoMJnOT+1jk5b1+BimOfnwp0kc0DMON+c=;
        b=N+jMSvfXqJfvo4HjpsjQb9hBXxr3ZirsPUYohjVg8vzK18EVHlC/d2AgsPhRjUDw2c
         mDa9+FuaCj8aASpI0UihKvWhOp/ERhQSv12IeFu4RnVDolBySotPEPLitRIGDh9at9CL
         1BdhAhPC9B94SowirnLi6Lt4szDdk0+bzhcbv5lMsT0ErLld+ckMnl26fWN7GVIfmWuY
         g3UExKRHSInk5BOx/MfmuhpV5w7VI0GAlbtmr0sJYbSDstBzYudtV8+RRFvxK4rt1rOm
         pnwfo4yA0WsDjMaozXMTK/W1bKBkjUSD+Or8Ke4cpGZf3ISvIODY3C26JEIoaotE1HpD
         02LA==
X-Gm-Message-State: AOJu0YyYcDJvWiNPeBnV3q69KFnEHKppV4ZBMv75Ggd9tAmJTcia7dYZ
        F8x0EicsZriWi/YlRKzQBsOMfPJHVn06FV9y
X-Google-Smtp-Source: AGHT+IEZdlJEsZHxhOHiRvxHq9A0M60/+a4+7bU8bz/zc9o+nIbTendEsGY+SP5tTsydkg1BeghnaA==
X-Received: by 2002:a05:622a:101:b0:41c:b94a:98ac with SMTP id u1-20020a05622a010100b0041cb94a98acmr454576qtw.57.1697662474935;
        Wed, 18 Oct 2023 13:54:34 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id g5-20020ac85805000000b004181a8a3e2dsm228862qtg.41.2023.10.18.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:54:34 -0700 (PDT)
Date:   Wed, 18 Oct 2023 15:54:31 -0500
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@meta.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        youssefesmat@google.com, greg.marsden@oracle.com,
        willy@infradead.org, andrea.righi@canonical.com,
        andrealmeid@igalia.com, changwoo@igalia.com, gpiccoli@igalia.com,
        tj@kernel.org, colin.i.king@gmail.com, ast@kernel.org,
        julia.lawall@inria.fr, himadrispandya@gmail.com,
        redha.gouicem@rwth-aachen.de, admin@ptr1337.dev,
        lucjan.lucjanov@gmail.com
Subject: Sched Ext slack channel / office hours
Message-ID: <20231018205431.GA4176@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URI_TRY_3LD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

The first RFC patch set [0] for sched_ext was sent to the upstream list
almost one year ago, with three more revisions of the series having been
sent upstream since. In that time, a number of individuals, companies,
and organizations have begun to use and experiment with sched_ext. We
want to make it easier to collaborate, so we’ve decided to set up a
weekly office hours call, and create a Slack channel [1] that folks can
join to ask questions, discuss features, etc.

[0]: https://lore.kernel.org/lkml/20221130082313.3241517-1-tj@kernel.org/
[1]: https://join.slack.com/t/schedextworkspace/shared_invite/zt-24c4on3sk-sHlozdLfCZBODfwU6t6dbw

The Slack channel can be joined via the link in [1]. For office hours,
we’ll start with 10:00 PDT / 17:00 UTC on Mondays (likely starting the
week of 10/30), but we can change the time if it’s inconvenient for too
many folks. The calls will likely take place through Slack, so you’ll
have to join the Slack channel if you want to participate in the office
hours calls. As a friendly reminder, you can access the sched_ext
repository at [2].

[2]: https://github.com/sched-ext/sched_ext

Thanks,
David
