Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1FA79EB29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbjIMOcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjIMOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:32:07 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C42D91
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:32:03 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-77a62a84855so253848639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694615523; x=1695220323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqgDDzNtE6w1rLrq8J0xrGYXFeCdamm0HmTJvs6piH8=;
        b=f3TpU/JO6Jpk5SO9SKgbNDK+9CyO970naLQ5sTF3s4N91dU11vYKw6c+y66qXQJyGQ
         PyCxa3RHTkHm4VyOg99wp5WY9Ha+5YjVBnQGnD4vbU+yDIJ2e8yKqU4x/XZRlbMkzT+a
         ptTslkH/waMv2K7RYxRFK/SEUx6GXMAHJz6n/7JsjKTWk9G8z9X2CMXx/UQi0SLisS6E
         qVuG8ahAfHbxUuxxkTGLTMOnr7/weLLSHwTG23cZnflYGhIidlypwtTQ4yGeYdrqerSx
         VQyHrYLQP1g7pqKOfE/wipwAUgb1IKEUOy8o8It9/4PPPUY5BRJY0h0HNDm2GQiVog1P
         jlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694615523; x=1695220323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqgDDzNtE6w1rLrq8J0xrGYXFeCdamm0HmTJvs6piH8=;
        b=UzBeyJ73gzUBCDRKZnQ+HgUHG15Q9LYJOsz5QG0oL0sV/I1AYZohdDyBAhaBqDMfWs
         0oA2Upys/6kpfBa7cDGnPS84oRflQzGmdYFrmP3Zx/uCbDN71FOkbPXJicNS5bl9PNDk
         0WZnUzjQan908MPbjFY3GbD1Jv6fOibD6i3qUIxTTKXAID7NNbSmzmHKVLEcO4qCvhXL
         b1845KDkidS1G4ZbkO7Qv/i6kzTQK8sjLdVV9q2pq23JnNpA7rIWhvrpUWGPKZ7wYHN4
         ubTo/DrH4mV1tH7b18J1BNddTw0QcwJEYRBEjceyR6n8W25+Dt4oV3UAOATMDNXRfm9d
         un4w==
X-Gm-Message-State: AOJu0YxbsSNWrCxQdmEeYQtSwJlizF+oFiMINzMsR8vvZb+hPS9HZRig
        bj4CnClF0+46Zsa2vXMFp5wYfoohv+cupuFSbsXZyQ==
X-Google-Smtp-Source: AGHT+IHfEEXOoKhLdrH8b1tTs1KfMp8PpBs1Xt00EljE3u14EM7FKJzjMW7xqNmjCVRFZwAngB/zsuauiLr7B/lVDSU=
X-Received: by 2002:a5d:8513:0:b0:790:a13d:d63a with SMTP id
 q19-20020a5d8513000000b00790a13dd63amr2911131ion.6.1694615522601; Wed, 13 Sep
 2023 07:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <CABCjUKBXPLNaBjELHqz=Oke_JsxXLQauTWrsNmTp3KToW3-9MQ@mail.gmail.com>
In-Reply-To: <CABCjUKBXPLNaBjELHqz=Oke_JsxXLQauTWrsNmTp3KToW3-9MQ@mail.gmail.com>
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Wed, 13 Sep 2023 23:31:49 +0900
Message-ID: <CABCjUKCRXeT2eExm6+y7cZCX4yEbj5MbjFnCHv4xvRPL5ce13g@mail.gmail.com>
Subject: Re: NOHZ interaction between IPI-less kick_ilb() and nohz_csd_func().
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I forgot to also add Vincent...)

On Wed, Sep 13, 2023 at 9:49=E2=80=AFPM Suleiman Souhlal <suleiman@google.c=
om> wrote:
>
> Hello,
>
> I noticed that on x86 machines that have MWAIT, with NOHZ, when the
> kernel decides to kick the idle load balance on another CPU in
> kick_ilb(), there's an optimization that makes it avoid using an IPI
> and instead exploit the fact that the remote CPU is MWAITing on the
> thread_info flags, by just setting TIF_NEED_RESCHED, in
> call_function_single_prep_ipi().
> However, on the remote CPU, in nohz_csd_func(), we end up not raising
> the sched softirq due to NEED_RESCHED being set, so the ILB doesn't
> end up getting done.
>
> Is this intended?
>
> Thanks,
> -- Suleiman
