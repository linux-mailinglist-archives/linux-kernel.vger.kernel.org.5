Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12622776D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjHJBIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjHJBIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:08:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869D1999
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:08:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbea147034so3119815e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 18:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1691629713; x=1692234513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dwdA3Zr+R2bGdEWxZwzwGAY2lYGpyk/qFXJGcC6N0A=;
        b=fWasfAcv1m8PS1DG7hUIQt8RYpMmd/mXjPbH0GpdWsrcD/dge+rY8/yHbL21NJdWhJ
         9bJhqhQt2igSccSPghjCbkO+OmQM91oyejRxa5Yw3cPJBzXPEuMS4TC97kMJB0kgox4X
         x1GMTKtx6PG+Mvni0sSuW0GwK/MwjGMSek+X5WpGH697y/WNNTEHrVmgF643WjI8Iw3s
         PT7eXZjncDrIRcttmg8ITsqBKJSlz+TCMS9l5bhnVKjAOhdlkeDO3YU3OBlkK4Iv6ZDL
         rgDJDK+ycd1N8kKApF1ArGrctb4Tracf7J5+hGiSbVqWGIdNwLKaHxd/TVs5RBjWubWf
         DVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691629713; x=1692234513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dwdA3Zr+R2bGdEWxZwzwGAY2lYGpyk/qFXJGcC6N0A=;
        b=f/ZOD7LaYG8z/LqihaoFGpKWBZPONrAMDER+bVWNgMQ8pytWI6yVa9nwpAhXxFq2Pe
         3P1QGamsLrW0gGDDF3mVQ6hIRohHks+IFg5cmdFEdWbwBpi1EQ06UPJOIvfudhovzjbK
         6ZfbAQjHXDuvgQ0WipYUS4E9PLjJCY57ekhp9mcM9NdHzbR55WwrQAl0gOZnrzsBUU11
         WOoIpG+IJFOsTD3WUl1v3oF8GovcIjFttS6uOVSTZFuC1nN7iQDPLtZ6tXi8KSbV+IMH
         uXBMuoucixVPZ54PNe2T7d5JUnH+hWbUtufENh/qZBCdqz9DtfKWsi1VpVnJAD25ec+c
         VxZA==
X-Gm-Message-State: AOJu0Yyqpi0CxwN96JGGGwItUa+sKFeDHoEw57QyQeDt9cHTqdLlASpn
        vn6QM2pUg9JY3XObvvPezHnj2CQ8ahMR3xu6zCiYdQ==
X-Google-Smtp-Source: AGHT+IEj1nZhEq/mioKX7QscS6c6OHPusSrGINounBpgZhrzj5fuWXJ0XzaB3w1O4BUghN8VXxKh9+bL8HURRRReqz8=
X-Received: by 2002:a1c:7904:0:b0:3fe:2c52:2b78 with SMTP id
 l4-20020a1c7904000000b003fe2c522b78mr541203wme.36.1691629713216; Wed, 09 Aug
 2023 18:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <5712331.DvuYhMxLoT@kreacher> <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
 <002201d9ca0c$27606f70$76214e50$@telus.net> <CAJZ5v0gYsH9EKgCO_LESuvd0dcOJLgPrWeN=6V-bY4gq-w1oyA@mail.gmail.com>
 <CAAYoRsWfMTX_ifNG5w9LS50OcPx87yJHg_PSvROoQJJ605eJEA@mail.gmail.com>
In-Reply-To: <CAAYoRsWfMTX_ifNG5w9LS50OcPx87yJHg_PSvROoQJJ605eJEA@mail.gmail.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Wed, 9 Aug 2023 18:08:25 -0700
Message-ID: <CAAYoRsUSu-1-maYVTDh1oLWtaGa2cBTjKbEZvm08DSMhK+Nc8Q@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Please bear with me. As you know I have many tests
that search over a wide range of operating conditions
looking for areas to focus on in more detail.

On Tue, Aug 8, 2023 at 3:40=E2=80=AFPM Doug Smythies <dsmythies@telus.net> =
wrote:
> On Tue, Aug 8, 2023 at 9:43=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> > On Tue, Aug 8, 2023 at 5:22=E2=80=AFPM Doug Smythies <dsmythies@telus.n=
et> wrote:
> > > On 2023.08.03 14:33 Rafael wrote:
> > > > On Thu, Aug 3, 2023 at 11:12=E2=80=AFPM Rafael J. Wysocki <rjw@rjwy=
socki.net> wrote:
> > > >>
> > > >> Hi Folks,
> > > >>
> > > >> This is the second iteration of:
> > > >>
> > > >> https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
> > > >>
> > > >> with an additional patch.
> > > >>
> > > >> There are some small modifications of patch [1/3] and the new
> > > >> patch causes governor statistics to play a role in deciding whethe=
r
> > > >> or not to stop the scheduler tick.
> > > >>
> > > >> Testing would be much appreciated!
> > > >
> > > > For convenience, this series is now available in the following git =
branch:
> > > >
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > > > pm-cpuidle-teo
> > >
> > > Hi Rafael,
> > >
> > > Thank you for the git branch link.
> > >
> > > I did some testing:
>
>
> ... deleted ...
>
> > > Test 2: 6 core ping pong sweep:
> > >
> > > Pass a token between 6 CPUs on 6 different cores.
> > > Do a variable amount of work at each stop.
> > >
> > > Purpose: To utilize the midrange idle states
> > > and observe the transitions from between use of
> > > idle states.
> > >
> > > Results: There is some instability in the results
> > > in the early stages.
> > > For unknown reasons, the rjw governor sometimes works
> > > slower and at lower power. The condition is not 100%
> > > repeatable.
> > >
> > > Overall teo completed the test fastest (54.9 minutes)
> > > Followed by menu (56.2 minutes), then rjw (56.7 minutes),
> > > then ladder (58.4 minutes). teo is faster throughout the
> > > latter stages of the test, but at the cost of more power.
> > > The differences seem to be in the transition from idle
> > > state 1 to idle state 2 usage.
>
> the magnitude of the later stages differences are significant.
>
> ... deleted ...
>
> > Thanks a lot for doing this work, much appreciated!
> >
> > > Conclusions: Overall, I am not seeing a compelling reason to
> > > proceed with this patch set.
> >
> > On the other hand, if there is a separate compelling reason to do
> > that, it doesn't appear to lead to a major regression.
>
> Agreed.
>
> Just for additional information, a 6 core dwell test was run.
> The test conditions were cherry picked for dramatic effect:
>
> teo: average: 1162.13 uSec/loop ; Std dev: 0.38
> ryw: average: 1266.45 uSec/loop ; Std dev: 6.53 ; +9%
>
> teo: average: 29.98 watts
> rjw: average: 30.30 watts
> (the same within thermal experimental error)
>
> Details (power and idle stats over the 45 minute test period):
> http://smythies.com/~doug/linux/idle/teo-util2/6-13568-147097/perf/

Okay, so while differences in the sometimes selection of a deeper
idle state might be detrimental to latency sensitive workflow such as
above, it is an overwhelming benefit to periodic workflows:

Test 8: low load periodic workflow.

There is an enormous range of work/sleep frequencies and loads
to pick from. There was no cherry picking for this test.

The only criteria is that the periodic fixed packet of work is
completed before the start of the next period.

Test 8 A: 1 load at about 3% and 347 Hz work/sleep frequency:
teo average processor package power: 16.38 watts
rjw average processor package power: 4.29 watts
or 73.8% improvement!!!!!

Test 8 B: 2 loads at about 3% and 347 Hz work/sleep frequency:
teo average processor package power: 18.35 watts
rjw average processor package power: 6.67 watts
or 63.7% improvement!!!!!
