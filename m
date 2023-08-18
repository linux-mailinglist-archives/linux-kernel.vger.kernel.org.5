Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8657B781090
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378707AbjHRQlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378718AbjHRQk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:40:29 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9F64214
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:40:26 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4036bd4fff1so3351cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692376825; x=1692981625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4YFOG4Qd9uP6QTu6UezljxVYm3PwfDbTE0QdsVPNOk=;
        b=ixigeK9by6HxolqSYH4KmBo1UUpq42IoZ0JsUrC4F1woTE54lSCO3lx8VNhc57vof3
         w/0yS6aK3HjLnxqduLqHcxNBnjSOZ0kASuO1uUvIR9ZoCCluvIOLJRpu1dVk/gCnN2Qw
         3qa64jveDTQ9xH7G0KMf3k4hrX8t0t+cHBUw37JclEdojeJBujAkcYF40lxNZY1sNywr
         R7Aq92rls+dU3L4CTPpsgqSyQWKg+oxM8BQz72hF6jhP8KLiao/A2GG+5ahCThOr59W7
         5nM0ke6P7VQFqhP2TXHjHHXcEffY3Hup7mCfXJ5vcbSG6RAZjd7UCgGpl9hl+WWp/uaC
         HiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376825; x=1692981625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4YFOG4Qd9uP6QTu6UezljxVYm3PwfDbTE0QdsVPNOk=;
        b=ClISYl2yfnwKiKV0Tf/R1mq9zpi5BepDQJ2rrAztRejg0g9mrLF8LtIPcUOqdGY1Kg
         eLQdQnTF8G/xJ1pNCLwatk1YfiVBMBw7cs5mE/nR+IkDqJCRkWEdl1Ch22u5DIA2G/Ph
         yx7fkV3uGsYQyAMaSFOJUtvdhIOG69RbfFXI0pxXqTblzVgLB94dU4PtLiUbXboulSeL
         sDGr4Gt9bTQMpTheNnvRNqIVoopiv+pyJQxxk1p0mBpGRpwpVV3Rhl31rphSAsu4Q6PQ
         R/23d564bOBP4yt/8gOUUWtpjn6i3bagroJKM2flJGKC3K5eEap9q0KvkSwpDkUqAymx
         JNCQ==
X-Gm-Message-State: AOJu0YyzVw1VMWbd6QQu1ouZ8A6EQTi6V/wg/BCHuXcV6+1HqhI3qL4a
        4cxRjik9Sp48rtC2LqS22KSqP8dtBNjHJx6wgrcUOS89T7xCs4OSFnY=
X-Google-Smtp-Source: AGHT+IGIJdd7GLSwZ0l/GxeKks9BNdEOGgLqobqU6GPDgmdHCVd3AbXgp/dGTaCquapUO658Eitnn9inouGk5UlEmQA=
X-Received: by 2002:a05:622a:110d:b0:410:88c6:cf16 with SMTP id
 e13-20020a05622a110d00b0041088c6cf16mr32978qty.22.1692376825156; Fri, 18 Aug
 2023 09:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814112421.5a2fa4f6@kernel.org> <20230817131612.M_wwTr7m@linutronix.de>
 <CAO3-Pbo7q6Y-xzP=3f58Y3MyWT2Vruy6UhKiam2=mAKArxgMag@mail.gmail.com>
 <20230818145734.OgLYhPh1@linutronix.de> <20230818092111.5d86e351@kernel.org>
In-Reply-To: <20230818092111.5d86e351@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 18 Aug 2023 18:40:13 +0200
Message-ID: <CANn89iKAR_i7_P5oTnhywyqCr_V7doskhckM_HiO+q0ao2gJUw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Yan Zhai <yan@cloudflare.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 6:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 18 Aug 2023 16:57:34 +0200 Sebastian Andrzej Siewior wrote:
> > As of now Jakub isn't eager to have it and my testing/ convincing is
> > quite limited. If nobody else yells that something like that would be
> > helpful I would simply go and convince PeterZ/tglx to apply 2/2 of this
> > series.
>
> As tempting as code removal would be, we can still try to explore the
> option of letting backlog processing run in threads - as an opt-in on
> normal kernels and force it on RT?

+1

Patch 1/2 as presented is really scary, we would need to test it
extensively on various platforms.

>
> But it would be good to wait ~2 weeks before moving forward, if you
> don't mind, various core folks keep taking vacations..
