Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1CD7FE94B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbjK3GnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjK3GnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:43:06 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4B1A3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:43:12 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-286406ae852so61506a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701326592; x=1701931392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Aia1H4GaSF980C1Y4zjWyXbrOYL7Cpo2RsR530hsng=;
        b=dhMf/ssidhuyKw6IegXIQABd6dF8DMy8s1VTFPOdDKXxNbd8iq3XVfI0aaqJ1jLxww
         gau/oiLBZUtJVCgaXd1Gp7UKklQhPD7v5Z7WxlLBEu9KwOKzBVF7BSZoK2exHR4TPYTj
         AgFBofU/683fLa/RK34NrSYBqCQKVuc/YYztrZjiCLBibxDs87MTtPaQKc8xysGvysvd
         VP/cxdNiIt++QSkL8/W6urWMsk7n2+E9OY22G5DO3maemso0vhBdcbr1BSyyGumlInkO
         OBRbXoSnrWKGz0+bVGAGCc5/DzhMrjmZn9e/ifqKYZXT9ZwLR1F/9cz2K8uQgt06f8zp
         1JJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701326592; x=1701931392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Aia1H4GaSF980C1Y4zjWyXbrOYL7Cpo2RsR530hsng=;
        b=BBGUNyH1DGM26efiL1goHhPPi3DTM+E4SMyWhaMgCmLRSG16hiXD1ClsEN1jeZn4z1
         pc55J2ealfjG2/DimDiR8beslAlKaLmTv4ksujr1gJFjhF/5J9Rg78nnQjHcfmRnuOhy
         5G2flLytnyJZqx8KYEZafYNoJbrlewFqxhsTlSb4iV9pp0+EL5xbVMOd4iVomswz2d3z
         NhrroTAHu4z07/maRlKeuJW+OSq/oQJdvbRPiBbcvNV48afaOh6hs2rFMHhBmmt1q4cP
         0LBlRA+S/1VjoMh1mKsyv57Hpp7WrHzZdCovqxn3ShaQ38Fy7zuLu4M17Yw8E0M3Z6mj
         32+g==
X-Gm-Message-State: AOJu0YznWWCNuZ1aRX2GLWIAoMwCA8Ix2sBP1s3nFzxvaQe5yeW7HRAA
        c5CrlVG6o5AhrY0iFvy5+0XWQzfglDIKYKbeNns=
X-Google-Smtp-Source: AGHT+IFcL9XOULKlQunh1Dwzx98zjt54BswiakctFApLupEwiI3d0gC0rUABAmCAAP0MCs+Xoy37R+4bMTGypJMXJ9U=
X-Received: by 2002:a17:90b:17c5:b0:285:9f17:2613 with SMTP id
 me5-20020a17090b17c500b002859f172613mr20287349pjb.27.1701326592119; Wed, 29
 Nov 2023 22:43:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1700548379.git.yu.c.chen@intel.com> <35e612eb2851693a52f7ed1ff9be5bc24011136f.1700548379.git.yu.c.chen@intel.com>
 <3dd5ae53-a914-bfd1-285e-e206ba0c58bd@linux.ibm.com>
In-Reply-To: <3dd5ae53-a914-bfd1-285e-e206ba0c58bd@linux.ibm.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Thu, 30 Nov 2023 14:43:00 +0800
Message-ID: <CADjb_WTFrPAgf5h1af4GuMFJ8UrDjzCPb_K+SZFo5s80xcniVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sched/fair: do not scribble cache-hot CPU in select_idle_cpu()
To:     Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc:     Chen Yu <yu.c.chen@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Madadi,

On Thu, Nov 30, 2023 at 1:26=E2=80=AFAM Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
>
> Hi Chen Yu,
>
[snip...]

>
> As per my understanding, if the task which tagged a particular CPU as cac=
he hot has woken up before
> the cache_hot_timeout, we still don't allow that task to run on that part=
icular CPU. Is this correct?
>

Not exactly. When we reached select_idle_cpu(), we have already
checked if the wakee's previous CPU
is idle or not in select_idle_sibling(), if it is idle, we don't check
the cache-hot tag and return the wakee's
previous CPU directly in select_idle_sibling().

thanks,
Chenyu

> If correct, then why don't we let the task to select the CPU if it's the =
one that tagged it?
>
> Thanks and Regards
> Madadi Vineeth Reddy
