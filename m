Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81F18004B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjLAH1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAH1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:27:47 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38810FD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:27:54 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9d3aad61fso15603601fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701415672; x=1702020472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ3cEhIwJldU+t/AvrqvGUp1wrVf7bknATO/F0zRAHk=;
        b=I143AL/YyHEtsIa3DaB7AckgULxv1O67HGmm1zAZMvK5m4x8nfCgVqHN9iwlXjdGYD
         8iwyyoRS0PP5T9+eXOhZ8hRhQWtHT49vhEa0CtMTaUNuat0qHDYq0V29T9kEKk4/gKqR
         SVaftU59ubup6C2nby5kVA9+U1AymIPfCrQUXLkk8shZYzcsmClalCFSuueKa27kXVpj
         TDzmZMco7pI+a7RhG2W3BfLOgoDjD8MWaEjoAA0s9FCcSuXRhZ/8ktdxlmxkJ5JGorDF
         c72at7EjLS4xUSieSlB8fWirkZS5coRkSEhnS4CAMjqV27qLnVKRk1C9cWwh0FULeNCI
         j9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701415672; x=1702020472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQ3cEhIwJldU+t/AvrqvGUp1wrVf7bknATO/F0zRAHk=;
        b=kNr8HsAzSv5fs7UIzSpLMhxXUrNTpLB62D/PpbM3LsxlZHEQalFUvlZK8TMb4EFAQl
         Pjkhgbd+1QlSoG2IGTP1C6CPhwtREs+GxB7JYaLdQEKxEiNp7xN37p9iBKQRFFp84E5U
         DfsktwjZy5je8UgFcu3rBZ2uvGS55pf7jIupgmcrwqEm2byPfSX1FEwHHb7m88BHKQwd
         awCrxC6qCCWKNdWNSUBoIM96arE4H2RcCKD3aIf/vA6kqNQqeZJFlpTSe4w2zrxAw1iM
         KMZ1OrfTGqzTdYXrNkmiQr2vUOfI1cbP+AKUHRMGa/RM8lNOznHnBG+xhyS1Y/eFBk6l
         0t2A==
X-Gm-Message-State: AOJu0YxjxDm8kALmxlHzAljyaUAbKhltGObWkcmp89B1B5t4HxJYMP0b
        grDYOHUZVAB0+b2Er5y4iCs+K05hnh17ySgvRAQ=
X-Google-Smtp-Source: AGHT+IEYoAMBmLU+d9my/hCpwCArvVC6JwbPg+xDtU2/YLKlKCATRwx7qNlO3KFbK/ZGCvJgL6pOfEpRQxAWpe0+x8Y=
X-Received: by 2002:a2e:b0f6:0:b0:2c9:d872:e7a1 with SMTP id
 h22-20020a2eb0f6000000b002c9d872e7a1mr495191ljl.88.1701415671816; Thu, 30 Nov
 2023 23:27:51 -0800 (PST)
MIME-Version: 1.0
References: <20231127130754.3affb908@gandalf.local.home> <20231130094130.GA12116@didi-ThinkCentre-M930t-N000>
 <20231130120036.5EpZn4eo@linutronix.de>
In-Reply-To: <20231130120036.5EpZn4eo@linutronix.de>
From:   Yuanhan Zhang <zyhtheonly@gmail.com>
Date:   Fri, 1 Dec 2023 15:27:39 +0800
Message-ID: <CAEQmJ=gh8fdPiBZPo72wwwr8UWo9BDF8cG1aUS5jFsn1itXOAg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/cputime: exclude ktimers threads in irqtime_account_irq
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, zyhtheonly@yeah.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian, thanks for your reply.

Sebastian Andrzej Siewior <bigeasy@linutronix.de> =E4=BA=8E2023=E5=B9=B411=
=E6=9C=8830=E6=97=A5=E5=91=A8=E5=9B=9B 20:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2023-11-30 17:41:47 [+0800], tiozhang wrote:
> > In CONFIG_PREEMPT_RT kernel, ktimers also calls __do_softirq,
> > so when accounting CPUTIME_SOFTIRQ, ktimers need to be excluded
> > as well as ksoftirqd.
> > Also add this_cpu_ktimers to keep consistency with this_cpu_ksoftirqd.
>
> I'm still not sure what the benefit here is. It says align with
> ksoftirqd but why? Why don't we account softirq time for ksoftirqd (and
> should continue to do so for ktimersd)?

That is my miss. When CONFIG_IRQ_TIME_ACCOUNTING is enabled,
ksoftirqd is counted elsewhere (where ktimers should also be aligned).
Please review my later patch v3.

>
> ktimers runs almost all the time in softirq context. So does every
> force-threaded interrupt. Should we exclude them, too?

For force-threaded interrupt, it counts on CPUTIME_SYSTEM
instead of CPUTIME_IRQ nor CPUTIME_SOFTIRQ.
To me, it does not quite make sense, I'm also thinking of sending a patch
of this, but IMHO it should not be considered in this patch...

>
> Sebastian
