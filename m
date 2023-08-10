Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77457777E41
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjHJQ2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbjHJQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:27:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E2B2133
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:27:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so9571725e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1691684876; x=1692289676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDhyTyA9Om29miQRZWUIhK0p43w+QxRqlw1Arvt4/Rc=;
        b=C4zc3vKY1Wh4sB+gBuFT57OSA5VZlNBzxcA2KbTQo3kI+4u3JyaaGPUkMU3rdTGUMm
         chBriyzhco92wPj36k89U2dN7ZXeeUSutDgaIv6Wt8bzxmW/P3FTNo9xOIf5k9Mx6DkB
         seNdgFQywP1Y43XuzgAto0I/pM1pBA8S7yZuBkZQ2tWRkdk+VQvAwLDbFT6N9/eBJ6lf
         fxLchL3gXlRvYWSFSyKw4ez/pyWnrphg0pLwxj0Zk0j09GSOaSkwz5mp9X2usbdoULYk
         7kCGc0hdj8HwFDmbPjaf3I9oHrAiFumgWdMnOW5rLaImvXUbvsPf/8NDTXZwNG4ohrxP
         1jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684876; x=1692289676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDhyTyA9Om29miQRZWUIhK0p43w+QxRqlw1Arvt4/Rc=;
        b=Xqn1TSH0b7Hfv5T0nvklMWUXGyANo8i0PWwD3RWl3usPud1P9DWIYMiZd+Okj98mns
         ixdEebGijcB2/YmJtv7E43tcSlud4EDH5nZ9cz0iSBh+UqDjCmAxyyieBEHIL1ZJJsNA
         jg1DC7qGSwe4GzVH6rP+tR4vkXOT/g9QyzAPc7tbS5/ZUgqlpvHq7C4ifmvNSk6PXpMi
         iZzKYtUz0HHsJVzfiznh3NHPfkAgZnXWrUct3tjw11K7ZBMhY//o53yyZOWIytXbjzqR
         jdmGn2UvrKQpyEH3NMHl/m8507DOVdwe8rreJwm+CeHo6YSniC4EXqgfdmZNeD7pF1CV
         yJUg==
X-Gm-Message-State: AOJu0YxIKQfh8ERTp2bUN7IO0n9z9Bfwj88X8XmLV+xnwqxeH+C9QdOW
        JxYr32qjsBebNyYlgh1J3y1XxtZLUbFk66+QLwatfQ==
X-Google-Smtp-Source: AGHT+IFyuIb2AD7Ejck4VeBeTNmnUQpPLAnQmgs2fKujYzPNz7k3gRNRwhxHjz9rdjzEd1vSjULh4aI3gHKTo8ZLcDY=
X-Received: by 2002:a05:600c:d7:b0:3fb:b5dc:dab1 with SMTP id
 u23-20020a05600c00d700b003fbb5dcdab1mr2371296wmm.39.1691684876297; Thu, 10
 Aug 2023 09:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <5708364.DvuYhMxLoT@kreacher> <CAJZ5v0hNZLvt+bJLvvibmk3dw_u5XnYNS020r7QLWLiiWLZSgQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hNZLvt+bJLvvibmk3dw_u5XnYNS020r7QLWLiiWLZSgQ@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Thu, 10 Aug 2023 09:27:47 -0700
Message-ID: <CAAYoRsVHFLpQ91DqUZygZETsYC31rhmgFru=19C-veXSH+dy5w@mail.gmail.com>
Subject: Re: [RFT] [PATCH v1] cpuidle: menu: Skip tick_nohz_get_sleep_length()
 call in some cases
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 11:16=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> On Wed, Aug 9, 2023 at 4:53=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Because the cost of calling tick_nohz_get_sleep_length() may increase
> > in the future, reorder the code in menu_select() so it first uses the
> > statistics to determine the expected idle duration.  If that value is
> > higher than RESIDENCY_THRESHOLD_NS, tick_nohz_get_sleep_length() will
> > be called to obtain the time till the closest timer and refine the
> > idle duration prediction if necessary.
> >
> > This causes the governor to always take the full overhead of
> > get_typical_interval() with the assumption that the cost will be
> > amortized by skipping the tick_nohz_get_sleep_length() call in the
> > cases when the predicted idle duration is relatively very small.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
... deleted...
>
> This patch is now present in the git branch at
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  pm-cpuidle-gov
>
> along with the previous teo governor changes.

Hi Rafael,

Thanks for the branch and adding it to the previous 6.5-rc4 code,
as now I can re-use the menu baseline tests already done.

My test computer boots by default to use the teo idle governor.
When I change to the menu governor, my system becomes
unresponsive and I have to re-boot.

Is anyone else having this difficulty?

... Doug
