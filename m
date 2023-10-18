Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29BF7CDB64
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjJRMPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjJRMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:15:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3791120
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:15:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso14096196a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697631336; x=1698236136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zumtdsyrV0KBvO2wFodhcV/rBtBqoWg9M0cTr5PzyXA=;
        b=g8VeTgBYJdDhTUTAA2UQc/ty0HYWrT7PQW6rk525d8f+6vFPhOrghEA8SbGyyS36NU
         dfGXpdrPtHJq6jzgQdlKYD396t4/V2JKaWYVq8Cy70msw6yAmequ70U/XZ0zvCbDoDxI
         PRzimICuyWwoRIh7i7QsYKPWbwI0XfPV8mtEKQKhbFRO2nimA7+txQqu3gQ+nJpfs468
         iJEhpop7swr/cj+x4ar07CnvKceXVIz55hipsqFC503G2ItsA+bZ03hn5dmfETf7g7c5
         JOTy1rDSqDT0HR85/GQteFrnW5UJuEYBVC4bU5Njl1QNohTDEC8J+5+BEVfhuNUidWoY
         dyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631336; x=1698236136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zumtdsyrV0KBvO2wFodhcV/rBtBqoWg9M0cTr5PzyXA=;
        b=b2DzmoYah29wOt567ebkvQPDyoTo9P04uHMlXB+zRp/W7Kt8mtOwIP56VywQvy6cSy
         meC58ijOL/l5J9BXqcGEpJwyZfiV5sZ62+XptwvE80wHLSiixew1451RFFkoQXKKBDiw
         0wbeTNqNfPTZs4N7dTp8k0VYtH4TLtJjRQguXyIegLS9+GiJboVoRI+ViN78nwcWC1hy
         iOBmNjyZp2P1MqmjUvPiKXAg/a6U5KhU7JBW9GYzaGQsAN8JyK6vdTM08AoMAEsiy63g
         3jbJckCLgnHG/xzC6rlRVe1yKNiZNRZ0o2h3xLOQNIr7XJfw9tx7rq2ZG8EHgjnrtThE
         wuIw==
X-Gm-Message-State: AOJu0YxbUSOdWnIylO0t2ik/9OTpKfStCDfzhks40aW5NXVWBC27aUfL
        XnFCEZYMGgRqbyxWI+3jBTo=
X-Google-Smtp-Source: AGHT+IH0HvFqfheKv+WofU1LkdbDPRso+zxik2t2zrnfQm5dWDR8pAoRRzPE/gdx9HPSOWeJYOlBpg==
X-Received: by 2002:a05:6402:1a52:b0:530:8fdb:39c8 with SMTP id bf18-20020a0564021a5200b005308fdb39c8mr4120870edb.15.1697631336270;
        Wed, 18 Oct 2023 05:15:36 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id cb12-20020a0564020b6c00b0053ebf32da31sm2728578edb.57.2023.10.18.05.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:15:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 14:15:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: topology: =?utf-8?Q?Rem?=
 =?utf-8?B?b3ZlIHVubmVjZXNzYXJ5IOKAmDDigJk=?= values from nr_levels
Message-ID: <ZS/MZXfUlWyaAar8@gmail.com>
References: <20231017062006.10879-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017062006.10879-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Li kunyu <kunyu@nfschina.com> wrote:

> nr_levels is assigned first, so it does not need to initialize the
> assignment.

In C there's no such thing as "initializing the assignment"...

Please write sensible changelogs that demonstrate an understanding of these 
principles.

Thanks,

	Ingo
