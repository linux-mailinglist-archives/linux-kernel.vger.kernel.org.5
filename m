Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6AE78309B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjHUTAS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 15:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjHUTAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:00:17 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51D12B71;
        Mon, 21 Aug 2023 11:59:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a4dab8172so261069b3a.0;
        Mon, 21 Aug 2023 11:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692644279; x=1693249079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0ILDH/g5WvpuVuWafhgCHGmQa9G1Jkqjs3DU2lv7hI=;
        b=ZXrbOjuDsApwJg/nBrd8K9+e56pE+qxNzDvpRYOANTb3czuqx5vmWLd7S1YYfnGwM9
         5/J2SWAFQmkaDC3NmxVl5zsPhg7A74m2qDCYeeA+MnayXrRcWcL+utRPs/D/jAQorapm
         EOdFxV/UTiABHWM7kGVwTJ9fQwPpEAvJHiHre8TDM69z7pjRbJ8oUPqxJSkkIh2IRi/j
         hpMsRiEpESE5qMmHOauQQSUbOdhUTJnHKb6+ENZCgRoxdK68qPr7fnZ4PbpdaY4tsK9p
         UgEHKkpL552j+9e6qeadBsTHPgJVg7yCaQemLDsA1OalR8PkzDVD86wh/tg7OJ3rshUR
         ousA==
X-Gm-Message-State: AOJu0YyvRfMovvuxoFqPre9PwWR/IDsCRF7sUkzhl/ryNv9mmQ/aEDa4
        +BsZGvgXymZ11BHVVdPwvwJwRrRNSLlBODVo8Qunuiv2
X-Google-Smtp-Source: AGHT+IG5QmTTwNd/TxKRz4vs+mqranVuKoVwuCjOaErEOA0TL30BQvSHU0yrS3wU/9Td45bZbzjxqUg+7d9IUQ0Fz/Y=
X-Received: by 2002:a4a:d9c7:0:b0:563:3b56:5dc1 with SMTP id
 l7-20020a4ad9c7000000b005633b565dc1mr7153280oou.0.1692643774581; Mon, 21 Aug
 2023 11:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com> <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
 <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com> <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
 <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com> <CAJZ5v0jEcD_1+jHfAk9eN0YYJFbDZN2rZ97KHyH2-w6EqRN9+g@mail.gmail.com>
 <43b65307-bc3f-4014-9bf8-a96c6ed15d9b@amd.com> <CAJZ5v0g+uVZwoOr-2W19Ux9u-D=WiY=-dtcQZwYU0Ov_GE5d=w@mail.gmail.com>
 <CAJZ5v0g_DyQAnSuigBc-f0UNmW0mo=0yMadES+0NhphJs_k+cw@mail.gmail.com> <9d491dfe-13d8-4072-a90b-5f68107fcf95@amd.com>
In-Reply-To: <9d491dfe-13d8-4072-a90b-5f68107fcf95@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 20:49:23 +0200
Message-ID: <CAJZ5v0jxKwtHM3vhtw44TW5=J916XvXSeP3DyNLcJDo+eTSRHw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 8:44 PM Yazen Ghannam <yazen.ghannam@amd.com> wrote:
>
> On 8/21/23 2:01 PM, Rafael J. Wysocki wrote:
> > On Mon, Aug 21, 2023 at 7:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>
> >> On Mon, Aug 21, 2023 at 7:35 PM Limonciello, Mario
> >> <mario.limonciello@amd.com> wrote:
> >>>
> >>>
> >>>
> >>> On 8/21/2023 12:29 PM, Rafael J. Wysocki wrote:
> >>>> On Mon, Aug 21, 2023 at 7:17 PM Limonciello, Mario
> >>>> <mario.limonciello@amd.com> wrote:
> >>>>>
> >>>>> On 8/21/2023 12:12 PM, Rafael J. Wysocki wrote:
> >>>>> <snip>
> >>>>>>> I was just talking to some colleagues about PHAT recently as well.
> >>>>>>>
> >>>>>>> The use case that jumps out is "system randomly rebooted while I was
> >>>>>>> doing XYZ".  You don't know what happened, but you keep using your
> >>>>>>> system.  Then it happens again.
> >>>>>>>
> >>>>>>> If the reason for the random reboot is captured to dmesg you can cross
> >>>>>>> reference your journal from the next boot after any random reboot and
> >>>>>>> get the reason for it.  If a user reports this to a Gitlab issue tracker
> >>>>>>> or Bugzilla it can be helpful in establishing a pattern.
> >>>>>>>
> >>>>>>>>> The below location may be appropriate in that case:
> >>>>>>>>> /sys/firmware/acpi/
> >>>>>>>>
> >>>>>>>> Yes, it may. >
> >>>>>>>>> We already have FPDT and BGRT being exported from there.
> >>>>>>>>
> >>>>>>>> In fact, all of the ACPI tables can be retrieved verbatim from
> >>>>>>>> /sys/firmware/acpi/tables/ already, so why exactly do you want the
> >>>>>>>> kernel to parse PHAT in particular?
> >>>>>>>>
> >>>>>>>
> >>>>>>> It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having
> >>>>>>> something internal to the kernel "automatically" parsing it and saving
> >>>>>>> information to a place like the kernel log that is already captured by
> >>>>>>> existing userspace tools I think is "more" useful.
> >>>>>>
> >>>>>> What existing user space tools do you mean?  Is there anything already
> >>>>>> making use of the kernel's PHAT output?
> >>>>>>
> >>>>>
> >>>>> I was meaning things like systemd already capture the kernel long
> >>>>> ringbuffer.  If you save stuff like this into the kernel log, it's going
> >>>>> to be indexed and easier to grep for boots that had it.
> >>>>>
> >>>>>> And why can't user space simply parse PHAT by itself?
> >>>>>>   > There are multiple ACPI tables that could be dumped into the kernel
> >>>>>> log, but they aren't.  Guess why.
> >>>>>
> >>>>> Right; there's not reason it can't be done by userspace directly.
> >>>>>
> >>>>> Another way to approach this problem could be to modify tools that
> >>>>> excavate records from a reboot to also get PHAT.  For example
> >>>>> systemd-pstore will get any kernel panics from the previous boot from
> >>>>> the EFI pstore and put them into /var/lib/systemd/pstore.
> >>>>>
> >>>>> No reason that couldn't be done automatically for PHAT too.
> >>>>
> >>>> I'm not sure about the connection between the PHAT dump in the kernel
> >>>> log and pstore.
> >>>>
> >>>> The PHAT dump would be from the time before the failure, so it is
> >>>> unclear to me how useful it can be for diagnosing it.  However, after
> >>>> a reboot one should be able to retrieve PHAT data from the table
> >>>> directly and that may include some information regarding the failure.
> >>>
> >>> Right so the thought is that at bootup you get the last entry from PHAT
> >>> and save that into the log.
> >>>
> >>> Let's say you have 3 boots:
> >>> X - Triggered a random reboot
> >>> Y - Cleanly shut down
> >>> Z - Boot after a clean shut down
> >>>
> >>> So on boot Y you would have in your logs the reason that boot X rebooted.
> >>
> >> Yes, and the same can be retrieved from the PHAT directly from user
> >> space at that time, can't it?
> >>
> >>> On boot Z you would see something about how boot Y's reason.
> >>>
> >>>>
> >>>> With pstore, the assumption is that there will be some information
> >>>> relevant for diagnosing the failure in the kernel buffer, but I'm not
> >>>> sure how the PHAT dump from before the failure can help here?
> >>>
> >>> Alone it's not useful.
> >>> I had figured if you can put it together with other data it's useful.
> >>> For example if you had some thermal data in the logs showing which
> >>> component overheated or if you looked at pstore and found a NULL pointer
> >>> dereference.
> >>
> >> IIUC, the current PHAT content can be useful.  The PHAT content from
> >> boot X (before the failure) which is what will be there in pstore
> >> after the random reboot, is of limited value AFAICS.
> >
> > To be more precise, I don't see why the kernel needs to be made a
> > man-in-the-middle between the firmware which is the source of the
> > information and user space that consumes it.
>
> I think that's a fair point.
>
> Is there a preferred set of tools that can be updated?

I think you need to talk to distro people about this.

> If not, would it make sense to develop a set of common kernel tools for
> this?

Yes, it would, but please see above in the first place.

> In my experience, it seems many folks use tools from their vendors or
> custom tools.

This observation matches my own experience.
