Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1CD78317E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjHUTQ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHUTQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:16:25 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD2127;
        Mon, 21 Aug 2023 12:16:23 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-56e9b517f85so481127eaf.0;
        Mon, 21 Aug 2023 12:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692645383; x=1693250183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wesEcQczhil1rTgJt8VpxwEYXmS1Bydkl0eNAbgbhGE=;
        b=QCHozjueCtVOFAu9SuaQncZx9cBvrJviYrJUrTGjs6WJ3NsMMinPqzoyl+weMYnk+7
         waSdY2jfm9U+W83nZs+PHxMsAvHqJ0NK0mK9447kaC1Rg6ZgzD7dtMkk6EfQ0IfNurez
         PTGrLokRc8+xRax/PvlOVRr5KIhEQFX24n1EeSCJNj9V9rdZudKfqTLSoJ6s2lcLzZIP
         O2jroavAaHVX0IfA123iaA1GMMzMfjPUdlZ8MT5/hL7a8b+BjUPlbTypDp5fAwMsl7Ac
         xPVB3pmSWvkRhMRDDClBlQu/RSI+A7N9a2mDggqELnJX8ceEfQFODrVx5BwcnHRT9HbE
         773w==
X-Gm-Message-State: AOJu0Yx7ZBBwufKkMOdmkPpHz0wyYlcNh488IpTPNU/wDfcFMh8f1mRa
        tNnFKGoqwpeoVxCPB9+L8e+2hmtwf77aCsz60P4=
X-Google-Smtp-Source: AGHT+IHE5qN9ZXM13J716vKGllHEZCGy9qaghFoPXWUs4zNKfFI7y0AoKs0MIZQfS5ai3gWBw/qyFIccPAXZD7rd92c=
X-Received: by 2002:a4a:bc85:0:b0:560:b01a:653d with SMTP id
 m5-20020a4abc85000000b00560b01a653dmr7084604oop.0.1692645382732; Mon, 21 Aug
 2023 12:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com> <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
 <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com> <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
 <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com> <CAJZ5v0jEcD_1+jHfAk9eN0YYJFbDZN2rZ97KHyH2-w6EqRN9+g@mail.gmail.com>
 <43b65307-bc3f-4014-9bf8-a96c6ed15d9b@amd.com> <CAJZ5v0g+uVZwoOr-2W19Ux9u-D=WiY=-dtcQZwYU0Ov_GE5d=w@mail.gmail.com>
 <CAJZ5v0g_DyQAnSuigBc-f0UNmW0mo=0yMadES+0NhphJs_k+cw@mail.gmail.com>
 <9d491dfe-13d8-4072-a90b-5f68107fcf95@amd.com> <CAJZ5v0jxKwtHM3vhtw44TW5=J916XvXSeP3DyNLcJDo+eTSRHw@mail.gmail.com>
 <fbc0b21d-33e6-4c32-bc34-3fbfe5e99b1f@amd.com>
In-Reply-To: <fbc0b21d-33e6-4c32-bc34-3fbfe5e99b1f@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 21:16:11 +0200
Message-ID: <CAJZ5v0i-=kfBPp2oW-40mNSAFnOzTEeey0EhDUsN6qNU+QY4Ug@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Avadhut Naik <avadnaik@amd.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 9:02 PM Yazen Ghannam <yazen.ghannam@amd.com> wrote:
>
> On 8/21/23 2:49 PM, Rafael J. Wysocki wrote:
> > On Mon, Aug 21, 2023 at 8:44 PM Yazen Ghannam <yazen.ghannam@amd.com> wrote:
> >>
> >> On 8/21/23 2:01 PM, Rafael J. Wysocki wrote:
> >>> On Mon, Aug 21, 2023 at 7:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>>
> >>>> On Mon, Aug 21, 2023 at 7:35 PM Limonciello, Mario
> >>>> <mario.limonciello@amd.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 8/21/2023 12:29 PM, Rafael J. Wysocki wrote:
> >>>>>> On Mon, Aug 21, 2023 at 7:17 PM Limonciello, Mario
> >>>>>> <mario.limonciello@amd.com> wrote:
> >>>>>>>
> >>>>>>> On 8/21/2023 12:12 PM, Rafael J. Wysocki wrote:
> >>>>>>> <snip>
> >>>>>>>>> I was just talking to some colleagues about PHAT recently as well.
> >>>>>>>>>
> >>>>>>>>> The use case that jumps out is "system randomly rebooted while I was
> >>>>>>>>> doing XYZ".  You don't know what happened, but you keep using your
> >>>>>>>>> system.  Then it happens again.
> >>>>>>>>>
> >>>>>>>>> If the reason for the random reboot is captured to dmesg you can cross
> >>>>>>>>> reference your journal from the next boot after any random reboot and
> >>>>>>>>> get the reason for it.  If a user reports this to a Gitlab issue tracker
> >>>>>>>>> or Bugzilla it can be helpful in establishing a pattern.
> >>>>>>>>>
> >>>>>>>>>>> The below location may be appropriate in that case:
> >>>>>>>>>>> /sys/firmware/acpi/
> >>>>>>>>>>
> >>>>>>>>>> Yes, it may. >
> >>>>>>>>>>> We already have FPDT and BGRT being exported from there.
> >>>>>>>>>>
> >>>>>>>>>> In fact, all of the ACPI tables can be retrieved verbatim from
> >>>>>>>>>> /sys/firmware/acpi/tables/ already, so why exactly do you want the
> >>>>>>>>>> kernel to parse PHAT in particular?
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having
> >>>>>>>>> something internal to the kernel "automatically" parsing it and saving
> >>>>>>>>> information to a place like the kernel log that is already captured by
> >>>>>>>>> existing userspace tools I think is "more" useful.
> >>>>>>>>
> >>>>>>>> What existing user space tools do you mean?  Is there anything already
> >>>>>>>> making use of the kernel's PHAT output?
> >>>>>>>>
> >>>>>>>
> >>>>>>> I was meaning things like systemd already capture the kernel long
> >>>>>>> ringbuffer.  If you save stuff like this into the kernel log, it's going
> >>>>>>> to be indexed and easier to grep for boots that had it.
> >>>>>>>
> >>>>>>>> And why can't user space simply parse PHAT by itself?
> >>>>>>>>   > There are multiple ACPI tables that could be dumped into the kernel
> >>>>>>>> log, but they aren't.  Guess why.
> >>>>>>>
> >>>>>>> Right; there's not reason it can't be done by userspace directly.
> >>>>>>>
> >>>>>>> Another way to approach this problem could be to modify tools that
> >>>>>>> excavate records from a reboot to also get PHAT.  For example
> >>>>>>> systemd-pstore will get any kernel panics from the previous boot from
> >>>>>>> the EFI pstore and put them into /var/lib/systemd/pstore.
> >>>>>>>
> >>>>>>> No reason that couldn't be done automatically for PHAT too.
> >>>>>>
> >>>>>> I'm not sure about the connection between the PHAT dump in the kernel
> >>>>>> log and pstore.
> >>>>>>
> >>>>>> The PHAT dump would be from the time before the failure, so it is
> >>>>>> unclear to me how useful it can be for diagnosing it.  However, after
> >>>>>> a reboot one should be able to retrieve PHAT data from the table
> >>>>>> directly and that may include some information regarding the failure.
> >>>>>
> >>>>> Right so the thought is that at bootup you get the last entry from PHAT
> >>>>> and save that into the log.
> >>>>>
> >>>>> Let's say you have 3 boots:
> >>>>> X - Triggered a random reboot
> >>>>> Y - Cleanly shut down
> >>>>> Z - Boot after a clean shut down
> >>>>>
> >>>>> So on boot Y you would have in your logs the reason that boot X rebooted.
> >>>>
> >>>> Yes, and the same can be retrieved from the PHAT directly from user
> >>>> space at that time, can't it?
> >>>>
> >>>>> On boot Z you would see something about how boot Y's reason.
> >>>>>
> >>>>>>
> >>>>>> With pstore, the assumption is that there will be some information
> >>>>>> relevant for diagnosing the failure in the kernel buffer, but I'm not
> >>>>>> sure how the PHAT dump from before the failure can help here?
> >>>>>
> >>>>> Alone it's not useful.
> >>>>> I had figured if you can put it together with other data it's useful.
> >>>>> For example if you had some thermal data in the logs showing which
> >>>>> component overheated or if you looked at pstore and found a NULL pointer
> >>>>> dereference.
> >>>>
> >>>> IIUC, the current PHAT content can be useful.  The PHAT content from
> >>>> boot X (before the failure) which is what will be there in pstore
> >>>> after the random reboot, is of limited value AFAICS.
> >>>
> >>> To be more precise, I don't see why the kernel needs to be made a
> >>> man-in-the-middle between the firmware which is the source of the
> >>> information and user space that consumes it.
> >>
> >> I think that's a fair point.
> >>
> >> Is there a preferred set of tools that can be updated?
> >
> > I think you need to talk to distro people about this.
> >
> >> If not, would it make sense to develop a set of common kernel tools for
> >> this?
> >
> > Yes, it would, but please see above in the first place.
> >
> >> In my experience, it seems many folks use tools from their vendors or
> >> custom tools.
> >
> > This observation matches my own experience.
>
> For the sake of discussion, and from a kernel developer's point of view,
> should the tools be part of a separate project? Or should the tools be
> part of the kernel tree like perf, etc.? Assuming that this needs to
> start from scratch and not extending an existing project.

It can be both in principle, but from the practical standpoint it is
more likely to get all of the people to use the same set of tools if
they are included into the kernel source tree.
