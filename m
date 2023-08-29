Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB7778CC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbjH2TDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbjH2TCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:02:55 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D468CC2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:02:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401bdff4cb4so36357285e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693335769; x=1693940569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QepnuxL293gVcyDcigzBZ45rSffhEERtdEcF3Lml4M=;
        b=n7QtNemntMulS9dS6Qjd1fS8SdkmsnjThaEFRYi/Y2Tuo8Dec1q3H5oHU0O85XS788
         zNRMEU9JUWgSPscYLCGQtMi44MTtbFU1dnKui8VBa2pzTeKScvl0OTyvqXAEp31BC+SI
         VxHrQu0Nm6XZjy2VMrugqcuOUjoHS0/iPTCOmEwW8p6nSLUs+Q/cBNEkXujCSDdsB6h+
         0R9jCLMltpujAc1Pzw96oCvVswKlIeQA1nOBWnq/firFfSi5DF685ziTfjqkH0n9QFyL
         aaJm0Mrfo0nTm8cfSsdeCx5xeLsuvqx9Lpt5JMXdLp9O6HHncEUsFzNGt5U18KNc5Lkn
         xL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335769; x=1693940569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QepnuxL293gVcyDcigzBZ45rSffhEERtdEcF3Lml4M=;
        b=Iacm8uKxYf99PH0aNCB99gDhNO1Rv2GPqHseZpzxbzrKde0uEn7+yMra7qi2j6DeAa
         JkYFtbVFwd7TdGeP+YVVbElXOGVetSXJ3RVDyH5IZOrLZOztcmE+1rOLOy5WYXyiQFJz
         Czd33hMj/gKa49rM9eOh4ztho/3Gfbmbh+pietbmpqjpCB6nQSQk4eNaogSN4Rmo6s/t
         rVXtz2xO0RlqSGOpXr1eQzcZplz+1HhbmVlmNzHHupyentjMDiiHWbCDfEyIYGQaH9of
         fJHOcsiYI6uo6eBxJcGgRD0yA1GLlIWK6MVDClWzV1HYEedvJ0fmR3/f9MkjZpojRgvJ
         bRQw==
X-Gm-Message-State: AOJu0YwRAamgs2uQjHBqHzQFtwwVNJGGGiGHQS+09r3mjruqwQbC7y3l
        7qccOu70Pa85AriptftSiVs=
X-Google-Smtp-Source: AGHT+IFs8vi/ChzQA4+I0wsM8s4ZoqGY3Ja2KPMp6Q8qxtJDpdZ/ElcDzmbLMiG7t8lENB80RHh9DQ==
X-Received: by 2002:adf:f08d:0:b0:317:df4f:4b97 with SMTP id n13-20020adff08d000000b00317df4f4b97mr9892wro.7.1693335768395;
        Tue, 29 Aug 2023 12:02:48 -0700 (PDT)
Received: from gmail.com (1F2EF3C0.nat.pool.telekom.hu. [31.46.243.192])
        by smtp.gmail.com with ESMTPSA id l11-20020adff48b000000b0031c3ee933b5sm14444906wro.108.2023.08.29.12.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:02:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 29 Aug 2023 21:02:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Costa Shulyupin <costa.shul@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: add kernel-doc for set_cpus_allowed_ptr
Message-ID: <ZO5A0WUcdjmMn7nQ@gmail.com>
References: <20230829082551.2661290-1-costa.shul@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829082551.2661290-1-costa.shul@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Costa Shulyupin <costa.shul@redhat.com> wrote:

> This is an exported symbol, so it should have kernel-doc.
> Add a note to very similar function do_set_cpus_allowed
> to avoid confusion and misuse.
> ---
>  include/linux/sched.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

I've added your Signed-off-by tag:

	Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

please let me know if that is in error.

Thanks,

	Ingo
