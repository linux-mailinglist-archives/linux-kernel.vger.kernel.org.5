Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F387BC114
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjJFVU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjJFVUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:20:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BFDBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:20:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c6052422acso17195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696627254; x=1697232054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BZRgIGFg6lrUN9pglRmXEYe1by1YmD9hFDYRcGyMRWM=;
        b=j7fF7mFceD6RgxzGOFhwq7fWZq+X1wz3sjlsKGI7HZ+deWRJlIe36bcwmeCCL7Zyw5
         pwMcNeVDZm1O9VQEl5y5/5Lc4mssRQVKDqcuAGJy/0qYY1ohzuVb6OFgenfcoMdTiiXX
         rsGALM96Z9J77syyJ7sWwL+/knlvhbhNh9Go2BDUTChJZo5qkeUan50wXB9divFj9s/U
         uK7nisnz6l58QRM9t8Uz65/vROWH1UZVOlXwXWWcta4ODlAygzBOfHtHn0dTlO6Z4c7o
         VJ9PJyPz5wJnSNbn/0zt/i01bxwavvzULIUGrz6sAJpNjQocpj/u7iV//CTM3LbGtiXK
         v9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627254; x=1697232054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZRgIGFg6lrUN9pglRmXEYe1by1YmD9hFDYRcGyMRWM=;
        b=uVWu9eqjBsCsiICapiVqJ4AC9ermOGnYi7tZyR2lgIPw/Ec5O+Pl0LrMfufn7nRmIQ
         HUKaNvZjZcQ+nQeYCdyBb1XHjyfVg+Ieko7QPECligrJqhC9FTzxd82zqmGNUlken0Ph
         zbwTX2gujKRguOM2XRlu9OSMiS5fWlXp1cuL3qGOG3Pubux4x4XFQK01x7z1H5CcWx1L
         mMmt+oY5eaaVpfQf/rcQadlqklqXEDkRqZBFbWlNeZYkR9CjjH0F5VdOnosPW1eoB4xO
         3BxdAIWQ3qxuAsXnU0xKXbC6Dk3RewZmCaXkHpv4caExQfNf6Gdz+00oK+MXR7BTgZgx
         MSCw==
X-Gm-Message-State: AOJu0YxF4NM99HDn9WKWog+p3vgHTE5Mi/ojp6xHpmLdtNMgaR83JwC+
        D3Anr7Ievmc2CE3ckPTGc7Ty1lbnX6IZGei7HlR/gQ==
X-Google-Smtp-Source: AGHT+IFRXnwR6+2izIzyd4/tJlEcGO7lkAPGqEz8k5mxPrZ0LnKvdCzE6En1ZR9p/UpNPrwh1Z7tKglSCNugUDVsp9E=
X-Received: by 2002:a17:902:ea03:b0:1c8:9a60:388b with SMTP id
 s3-20020a170902ea0300b001c89a60388bmr74493plg.27.1696627253422; Fri, 06 Oct
 2023 14:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231005161727.1855004-1-joel@joelfernandes.org> <98d06022-accd-a1df-7608-dcd6689b44ec@linux.vnet.ibm.com>
In-Reply-To: <98d06022-accd-a1df-7608-dcd6689b44ec@linux.vnet.ibm.com>
From:   Vineeth Pillai <vineethrp@google.com>
Date:   Fri, 6 Oct 2023 17:20:41 -0400
Message-ID: <CA+HDTgSnab1eTWkFX-E9Yjvd8R3Apw4PyqbBHnYYg246Va1zYA@mail.gmail.com>
Subject: Re: [PATCH RFC] sched/fair: Avoid unnecessary IPIs for ILB
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Hsin Yi <hsinyi@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shrikanth,

> Hi Joel/Vineeth.
>
> Its an interesting patch.
>
> Gave this patch a try on powerpc system with 96 CPU. (12 cores SMT8)
> Was debugging an issue where ILB count goes up significantly at a specific
> busy CPU count. Haven't yet found out why. Its WIP. Was curious if this patch
> would address that issue.
>
Increased SCHED_SOFTIRQ was another problem that we noticed and we
have a separate fix for that in the chromeos tree. We were planning to
send the patch after a bit more testing. You could try the patch and
see if it solves the problem that you are seeing:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/918f229ba2ff720f5dfae4768469acbb6ea39fe2

Thanks
