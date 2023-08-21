Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1002C782FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbjHUSEf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 14:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjHUSEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:04:34 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D1AE2;
        Mon, 21 Aug 2023 11:04:32 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-570b3ebb3faso147989eaf.0;
        Mon, 21 Aug 2023 11:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692641072; x=1693245872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M78u1Ku4Wprqrr+yu8Zq3Jo1uL097o01+2aPILzdQes=;
        b=ebshWIQJ7BG2g0Om6YvL94eDgmwglQ1ys5AFhLRG0kqQO+y/TEspN3G4ykM1Nv2Cwa
         QHhbQp65GZ4Rh90z1BqfmlncIlqySUC4ItDhaDdNX6tgYSvV0o2fQoA6/LxzAlLa1QRW
         Z0tYGhoXzc7gga1DX4kPtXguQ74661qQkQwcU71PhbNDUv4DNVypkp2W2IlN1ijmOTP5
         WCto6pX301uhCUXj2lpIE0xuLnQIq5sHqIPJxvgGJER+3BXUkkdYUi1CZ/9RQ9kJWBxa
         TYDMkkMDOBsEhg818/esx4T2Chw3zeAv2cu0DFqCU/Fn0azrUX5HcbEkysvwGxX59HBM
         9HxQ==
X-Gm-Message-State: AOJu0Yy+5UTyQCli2Hucmf6mm710YO4z4qO0hb3uBUyKDjCCvzmN5eYH
        4FCGTaP+K5heqOFKdOXtH0dwvi7sk+NR4TTwc+I=
X-Google-Smtp-Source: AGHT+IGriSyaO7e1GqZ1sMMDIEdFIzb3BShwOO9nJmLrEy8whuO2kvVjDruA2jU8RWEdVIcZkpNNgkFijtGO3nrzHao=
X-Received: by 2002:a4a:da10:0:b0:56e:6532:467a with SMTP id
 e16-20020a4ada10000000b0056e6532467amr6491685oou.1.1692641071980; Mon, 21 Aug
 2023 11:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com> <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
 <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com> <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
 <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com> <CAJZ5v0jEcD_1+jHfAk9eN0YYJFbDZN2rZ97KHyH2-w6EqRN9+g@mail.gmail.com>
 <43b65307-bc3f-4014-9bf8-a96c6ed15d9b@amd.com> <CAJZ5v0g+uVZwoOr-2W19Ux9u-D=WiY=-dtcQZwYU0Ov_GE5d=w@mail.gmail.com>
 <3b2ff277-c310-4fa7-96e3-e2962477663d@amd.com>
In-Reply-To: <3b2ff277-c310-4fa7-96e3-e2962477663d@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 20:04:16 +0200
Message-ID: <CAJZ5v0jPgNsQ+=c9Du=oksP-cpdtsRBc08DY8ekX-TOv=JP-pw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Avadhut Naik <avadnaik@amd.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 8:00 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
>
> On 8/21/2023 12:52 PM, Rafael J. Wysocki wrote:
> > On Mon, Aug 21, 2023 at 7:35 PM Limonciello, Mario
> > <mario.limonciello@amd.com> wrote:
> >>
> >>
> >>
> >> On 8/21/2023 12:29 PM, Rafael J. Wysocki wrote:
> >>> On Mon, Aug 21, 2023 at 7:17 PM Limonciello, Mario
> >>> <mario.limonciello@amd.com> wrote:
> >>>>
> >>>> On 8/21/2023 12:12 PM, Rafael J. Wysocki wrote:
> >>>> <snip>
> >>>>>> I was just talking to some colleagues about PHAT recently as well.
> >>>>>>
> >>>>>> The use case that jumps out is "system randomly rebooted while I was
> >>>>>> doing XYZ".  You don't know what happened, but you keep using your
> >>>>>> system.  Then it happens again.
> >>>>>>
> >>>>>> If the reason for the random reboot is captured to dmesg you can cross
> >>>>>> reference your journal from the next boot after any random reboot and
> >>>>>> get the reason for it.  If a user reports this to a Gitlab issue tracker
> >>>>>> or Bugzilla it can be helpful in establishing a pattern.
> >>>>>>
> >>>>>>>> The below location may be appropriate in that case:
> >>>>>>>> /sys/firmware/acpi/
> >>>>>>>
> >>>>>>> Yes, it may. >
> >>>>>>>> We already have FPDT and BGRT being exported from there.
> >>>>>>>
> >>>>>>> In fact, all of the ACPI tables can be retrieved verbatim from
> >>>>>>> /sys/firmware/acpi/tables/ already, so why exactly do you want the
> >>>>>>> kernel to parse PHAT in particular?
> >>>>>>>
> >>>>>>
> >>>>>> It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having
> >>>>>> something internal to the kernel "automatically" parsing it and saving
> >>>>>> information to a place like the kernel log that is already captured by
> >>>>>> existing userspace tools I think is "more" useful.
> >>>>>
> >>>>> What existing user space tools do you mean?  Is there anything already
> >>>>> making use of the kernel's PHAT output?
> >>>>>
> >>>>
> >>>> I was meaning things like systemd already capture the kernel long
> >>>> ringbuffer.  If you save stuff like this into the kernel log, it's going
> >>>> to be indexed and easier to grep for boots that had it.
> >>>>
> >>>>> And why can't user space simply parse PHAT by itself?
> >>>>>    > There are multiple ACPI tables that could be dumped into the kernel
> >>>>> log, but they aren't.  Guess why.
> >>>>
> >>>> Right; there's not reason it can't be done by userspace directly.
> >>>>
> >>>> Another way to approach this problem could be to modify tools that
> >>>> excavate records from a reboot to also get PHAT.  For example
> >>>> systemd-pstore will get any kernel panics from the previous boot from
> >>>> the EFI pstore and put them into /var/lib/systemd/pstore.
> >>>>
> >>>> No reason that couldn't be done automatically for PHAT too.
> >>>
> >>> I'm not sure about the connection between the PHAT dump in the kernel
> >>> log and pstore.
> >>>
> >>> The PHAT dump would be from the time before the failure, so it is
> >>> unclear to me how useful it can be for diagnosing it.  However, after
> >>> a reboot one should be able to retrieve PHAT data from the table
> >>> directly and that may include some information regarding the failure.
> >>
> >> Right so the thought is that at bootup you get the last entry from PHAT
> >> and save that into the log.
> >>
> >> Let's say you have 3 boots:
> >> X - Triggered a random reboot
> >> Y - Cleanly shut down
> >> Z - Boot after a clean shut down
> >>
> >> So on boot Y you would have in your logs the reason that boot X rebooted.
> >
> > Yes, and the same can be retrieved from the PHAT directly from user
> > space at that time, can't it?
>
> Yes it can.
>
> >
> >> On boot Z you would see something about how boot Y's reason.
> >>
> >>>
> >>> With pstore, the assumption is that there will be some information
> >>> relevant for diagnosing the failure in the kernel buffer, but I'm not
> >>> sure how the PHAT dump from before the failure can help here?
> >>
> >> Alone it's not useful.
> >> I had figured if you can put it together with other data it's useful.
> >> For example if you had some thermal data in the logs showing which
> >> component overheated or if you looked at pstore and found a NULL pointer
> >> dereference.
> >
> > IIUC, the current PHAT content can be useful.  The PHAT content from
> > boot X (before the failure) which is what will be there in pstore
> > after the random reboot, is of limited value AFAICS.
>
> Right, you would need to have the pstore logs from your bad boot and
> then the dmesg from your current (good) boot to get the info.  And
> you're right at that point you could just run a userspace tool that gets
> the info instead.

And it will get the information from the source without any (arguably
redundant) intermediate processing (which may introduce noise into
it).

> I don't think any of this is necessary in the kernel, I just am
> describing the use case.
>
> FWIW on the patch series IMO I think that the boots that don't show
> useful unexpected things (power button, cold boot, warm boot, cold
> reset) shouldn't be INFO either.  I think these should default to debug,
> and just the unexpected ones should show up.

I would still prefer user space to deal with this as it sees fit.
