Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880C1774E70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjHHWkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjHHWka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:40:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7283FD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:40:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so26271355e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1691534425; x=1692139225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJo8nt11OCBKuqTlTpu5VTObD5ZsUjmsy92WhmmdOec=;
        b=cCjA9EG6m70q0VGl/RD20/OW2nTebL71nTqk6ZiylT/c37qMPgWEqxn5ysCo6bRjBn
         K5WewJhFxjwPbLPAh6mOBdFKnkYaiGoLWnvAihHW5Jy8eNE9+WtL2jzW/K07w4zbek3w
         HSzHJ1amP81CyEcvLjCmNmgpS52OIarcn92HyveP9KqJm5mdl8ob5SSlz9QWO8+LLT04
         M+TbuDIF6xueBOcMSVSXD6ofUUebKvp1IK86tASXkXfAidwG1c14o7e+nO5c190lIQ8A
         QMPSYlx5iQ+gjZEmzM1PmHya3s3Jbs7BHV99Eh4fc188WiswJciEoBRDmcvX5igsKbfa
         0Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691534425; x=1692139225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJo8nt11OCBKuqTlTpu5VTObD5ZsUjmsy92WhmmdOec=;
        b=NsTM5kD0n0vGLuzogS1Zkc+s+oq5y07EKhTwLGbFLX/F7+K/pml3nyx3vqmkZA7Opi
         kJBj2oi/etXF3VmzFpSA3bA0HV3NDqyO3lXt4+saDpjY2Whl3x/i6be5iH/67VBrEAVY
         3aPP4sJYl5y3NGxT8RQeOxLkmX4mOqy2FH/j9enKJjb+UnqXstHXODH9QDwnq72okW/n
         xMsjNZPAZxe/4dBJqDkgR5e8LZP/dNpSCCfQHOihdtt6ZMva4ruILbRl2WEYxHCJkUvl
         r51NAE1yhvWzE0e58pIi0M+6tnkiTv9NpEraiUq/EsgTXCsZ+8Qi8HIAtuY2rK8VyYUU
         yu8A==
X-Gm-Message-State: AOJu0YxK2eMxkn94gzeB0VbyPyK4eRD+yF4ogHVfCpJvYWKGLCyoM6vN
        JdPAHTx9F4dN6isbban39OCXWzZS3K/hQz0t0Pl/XQ==
X-Google-Smtp-Source: AGHT+IEjlWawgFkdf0Xhkq6GGvL3nukyc461amc9Vjo5LV3iCG24uOLo7jKaNpiQ1uxBTt3vOQ+2uIm3wQELyQgMvFY=
X-Received: by 2002:a05:600c:2210:b0:3f7:e3dd:8a47 with SMTP id
 z16-20020a05600c221000b003f7e3dd8a47mr824634wml.11.1691534424801; Tue, 08 Aug
 2023 15:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <5712331.DvuYhMxLoT@kreacher> <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
 <002201d9ca0c$27606f70$76214e50$@telus.net> <CAJZ5v0gYsH9EKgCO_LESuvd0dcOJLgPrWeN=6V-bY4gq-w1oyA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gYsH9EKgCO_LESuvd0dcOJLgPrWeN=6V-bY4gq-w1oyA@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Tue, 8 Aug 2023 15:40:17 -0700
Message-ID: <CAAYoRsWfMTX_ifNG5w9LS50OcPx87yJHg_PSvROoQJJ605eJEA@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers
 unconditionally every time
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 9:43=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
> On Tue, Aug 8, 2023 at 5:22=E2=80=AFPM Doug Smythies <dsmythies@telus.net=
> wrote:
> > On 2023.08.03 14:33 Rafael wrote:
> > > On Thu, Aug 3, 2023 at 11:12=E2=80=AFPM Rafael J. Wysocki <rjw@rjwyso=
cki.net> wrote:
> > >>
> > >> Hi Folks,
> > >>
> > >> This is the second iteration of:
> > >>
> > >> https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
> > >>
> > >> with an additional patch.
> > >>
> > >> There are some small modifications of patch [1/3] and the new
> > >> patch causes governor statistics to play a role in deciding whether
> > >> or not to stop the scheduler tick.
> > >>
> > >> Testing would be much appreciated!
> > >
> > > For convenience, this series is now available in the following git br=
anch:
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > > pm-cpuidle-teo
> >
> > Hi Rafael,
> >
> > Thank you for the git branch link.
> >
> > I did some testing:


... deleted ...

> > Test 2: 6 core ping pong sweep:
> >
> > Pass a token between 6 CPUs on 6 different cores.
> > Do a variable amount of work at each stop.
> >
> > Purpose: To utilize the midrange idle states
> > and observe the transitions from between use of
> > idle states.
> >
> > Results: There is some instability in the results
> > in the early stages.
> > For unknown reasons, the rjw governor sometimes works
> > slower and at lower power. The condition is not 100%
> > repeatable.
> >
> > Overall teo completed the test fastest (54.9 minutes)
> > Followed by menu (56.2 minutes), then rjw (56.7 minutes),
> > then ladder (58.4 minutes). teo is faster throughout the
> > latter stages of the test, but at the cost of more power.
> > The differences seem to be in the transition from idle
> > state 1 to idle state 2 usage.

the magnitude of the later stages differences are significant.

... deleted ...

> Thanks a lot for doing this work, much appreciated!
>
> > Conclusions: Overall, I am not seeing a compelling reason to
> > proceed with this patch set.
>
> On the other hand, if there is a separate compelling reason to do
> that, it doesn't appear to lead to a major regression.

Agreed.

Just for additional information, a 6 core dwell test was run.
The test conditions were cherry picked for dramatic effect:

teo: average: 1162.13 uSec/loop ; Std dev: 0.38
ryw: average: 1266.45 uSec/loop ; Std dev: 6.53 ; +9%

teo: average: 29.98 watts
rjw: average: 30.30 watts
(the same within thermal experimental error)

Details (power and idle stats over the 45 minute test period):
http://smythies.com/~doug/linux/idle/teo-util2/6-13568-147097/perf/
