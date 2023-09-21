Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84617AA455
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjIUWGm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 18:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjIUWGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:06:23 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDACBEFC9;
        Thu, 21 Sep 2023 11:15:33 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3a9e89fa553so80787b6e.1;
        Thu, 21 Sep 2023 11:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320071; x=1695924871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+whoeEGg+5oxemZIerh1uHW1xW1HG0aWiiwA9/Cfc8=;
        b=Ix+6LaZzkACc40ptgkr2bZa3uM2VClSBxZUx6AOmwuv6drzD1JyX4Q9U52NX6Pn80G
         bi5QYqFpPd0dD1kQizWdwbkFkk8+EmS4h1+1p81Wn298sgqyWfVTWW8Wdvbf8/ag64E6
         I7IhsvWUOzuCaYYieyUEXDgLyr0U8+YyfnE6cN79IXE/QVChCyLsSl2SYojheV/42Ksu
         8gjiQ0JjcNYImuvEk9ABZwGx/LYbq+7QKoomLXq+dnFna+vPzjALs6GiCnzdFqnZkcYP
         7+MX29RW5P1CUrBVX2pbMeWLTZc6bdZfNJuqbtfrQneOHnrxvqubjla43EaiGcvk2edO
         KGmQ==
X-Gm-Message-State: AOJu0Yza36dsFgsD7OaWj47NnBXckK27jyYQLeOq83J8uc57GZuah+Og
        WDbWmmR2PK+G5fOSJZOAnbtvXuNg/VoaQ2V0ny8V1Mog
X-Google-Smtp-Source: AGHT+IEsPvHniz+pyj39xbdxilNtva4bYOPahCcIyYvCqPdiDYDI6h+YOcOn/CICy+Wj9/GzLdL85HgrwEurKX7yP/c=
X-Received: by 2002:a05:6820:12e:b0:56e:94ed:c098 with SMTP id
 i14-20020a056820012e00b0056e94edc098mr5102215ood.0.1695289015606; Thu, 21 Sep
 2023 02:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230920185153.613706-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0jLms5iUM8CXDWNCPcXSQgLv9_XJzqx9RwReqGGUKFL_Q@mail.gmail.com> <51b3a2f115b2392557331442460c2a52432f399d.camel@linux.intel.com>
In-Reply-To: <51b3a2f115b2392557331442460c2a52432f399d.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Sep 2023 11:36:43 +0200
Message-ID: <CAJZ5v0hjYnsD=uiMVT5q_ausqOoqoFTpWN2cdrwdofdXgCd78Q@mail.gmail.com>
Subject: Re: [PATCH linux-next] thermal: int340x: processor_thermal: Ack all
 PCI interrupts
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 9:29 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2023-09-20 at 21:21 +0200, Rafael J. Wysocki wrote:
> > On Wed, Sep 20, 2023 at 8:52 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > All interrupts from the processor thermal PCI device requires ACK.
> > > This
> > > is done by writing 0x01 at offset 0xDC in the config space. This is
> > > already done for the thereshold interrupt. Extend this for the
> > > workload
> > > hint interrupt.
> > >
> > > Signed-off-by: Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com>
> >
> > Is this a fix for one of the commits in linux-next?  If so, which
> > one?
> This is on top of workload hints patches.  I marked linux-next as they
> are not in mainline kernel.
>
> This can alternatively merged to
> e682b86211a1 thermal: int340x: Handle workload hint interrupts
>
> But not sure how to mark the commit id as they will change.

As a rule, commits in my linux-next branch don't change (they
sometimes change, but that is not a common case), so you can use the
current one.  If it changes, I'll update the tag accordingly.

I'm going to add a Fixes: tag pointing to the above commit to it.

Thanks!
