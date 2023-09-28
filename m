Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4387B2759
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjI1VVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1VVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:21:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C8F3;
        Thu, 28 Sep 2023 14:21:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-406556f9bf9so6987405e9.2;
        Thu, 28 Sep 2023 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695936107; x=1696540907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0/p0hrV7HMXh+PeTO1O/PGw077nI1vZCXtYcGdxaoE=;
        b=D7tKgRpH5Sm916uWbgpNkeADi6tQ8Se/WD86+YHPYXPCve+ZfsvGS4tJ8LU8Mt802g
         MqqMDUwq/Ej9lwtLlnvzX8i+Ovws1aJaf/AG/x5A3My9gisQQhDkBXxCjk0j3f7FB6bR
         05llhAQmbbEX5F+1o+pVN0BH8nDyyuG4A2Wp1AJ5PubHItKuHabMEnWXA3An7J55yMzO
         h5UO0gXGQwkRpPgsjXV8WWxPIpYasV1Zyfs6ofruOm4vb3Yu2atULGrpkaRzVzROzYZr
         99T+SVsmfLj6ZbT8bjERdMlctlSnKSylbTP4P9x4lvMYSkhls1iY5xVUZv863eYPH4R/
         MtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695936107; x=1696540907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0/p0hrV7HMXh+PeTO1O/PGw077nI1vZCXtYcGdxaoE=;
        b=fM+Qme5AEsXhBkvG/YixB14cySFOEjnSaK8g2u06hMkC4cnNFz3wGPt86R3seXIVpa
         yFH/LUBJe2kxXPtSR+Ti71fr21Qn0L8+ipFBlre1EOXG8TndG82Uc1iU7zaMh1+WLMEu
         BZF87ddm138jB+FvS9tkrt1QsaiCBFFwJ269yoKbijQRzMDTe7byaCblTyNX58MDongv
         05DjIAohRs1loqDOKDRQlJfc2U00Zp1ulE9jZSCDNTG7A3VWLynMv4NJsCbqMLWDzvDl
         +e8KDTbfbf3QxGj8lHYIGTQYWWmOidgtA1pcSV7nEnLcVZpQBddv/cS9RyTSKDoQQmSp
         smMw==
X-Gm-Message-State: AOJu0YzbX6ZbQTxpDpDSczqt64z/Ayt0L6t6vFhkms5/EJ3+bcsDALGl
        J/I7AdMZ4EJxXxcW3HTkf8U=
X-Google-Smtp-Source: AGHT+IHCm/cVDzmcLqSYGL8hEzkMvTLRKE+mq+9vzN+ssp1D2ZX4sTLVN3bR2KJIbPN2nKb1N2KJLA==
X-Received: by 2002:adf:ce91:0:b0:31f:f8c1:f43c with SMTP id r17-20020adfce91000000b0031ff8c1f43cmr2242808wrn.41.1695936106826;
        Thu, 28 Sep 2023 14:21:46 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id bx9-20020a0564020b4900b0053404772535sm6282978edb.81.2023.09.28.14.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:21:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 28 Sep 2023 23:21:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org
Subject: Re: [tip: sched/core] sched/rt: Make rt_rq->pushable_tasks updates
 drive rto_mask
Message-ID: <ZRXuZmjU2tP8ETP5@gmail.com>
References: <20230811112044.3302588-1-vschneid@redhat.com>
 <169563211069.27769.17070510461354463740.tip-bot2@tip-bot2>
 <20230925101127.GB31921@noisy.programming.kicks-ass.net>
 <xhsmh1qemv3x7.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh1qemv3x7.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <vschneid@redhat.com> wrote:

> > sched/deadline.c has something very similar, does that need updating 
> > too?
> 
> Hm I think so yes:
> - push_dl_task() is an obvious noop if the pushable tree is empty
> - pull_dl_task() can be kicked if !rq->dl.overloaded, which similarly to rt
>   is driven by nr_migratory but could be boiled down to having pushable
>   tasks (due to the nr_cpus_allowed > 1 constraint).
> 
> Lemme poke at it.

For reference, the matching DL change now lives in tip:sched/core as:

   177f608a4c82 ("sched/deadline: Make dl_rq->pushable_dl_tasks update drive dl_rq->overloaded")

Thanks,

	Ingo
