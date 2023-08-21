Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C234782FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjHUSB0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjHUSBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:01:24 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6435410E;
        Mon, 21 Aug 2023 11:01:22 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-570e8bee8b5so95150eaf.1;
        Mon, 21 Aug 2023 11:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692640881; x=1693245681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zc91g1a8FoBY3gjHfeyJpdlO2I8RukIqWCieLy4eWH8=;
        b=eKKTYxw7GS4nSMFaKCoMj4RDtsPei7xmowCXWox8+5LJsDcBsaXlygSf70OYkT7kWH
         JiFuAQpNFaMrX8+AyRJILq8KIrTZch3KrqhxXVLQB2Ex2omDmEj97RRABVM3tMCIfFc/
         1LFIUeahsplRz8AL05X1QXveK6B1wJsIaAyxgYX+pDc8shUclfRhQY7+q1XHpJLcUbYf
         2V/e63JyL2Ql14JokFuKah24oSyjsnlsE4dYtVFXDASWZMYJFl9YB9CHizcgLHshiL4e
         8O6yE+IQPpjbJ3RpZtP8Vkygaia1doWblmOKfmBFlhfjD8rU8VGBhC9o4NI+Im+J/JM4
         5mRQ==
X-Gm-Message-State: AOJu0Yxmxdrry2gUJ1v5FGIIVVNuDUqXXQ8vgIvk2VHfDdKANRZ1F+Z0
        AyW/Eoc/LTMAmqvghs4IOEcBbn1puaOz+Rn9GtM=
X-Google-Smtp-Source: AGHT+IGkh7HF/fFBnjMb9o4VkqYCXvd27Bb90KntAtWHirSf4EcwRu5nEcj7Ohai8m2NwmPX+7J1GundMNcCr7wFo0Y=
X-Received: by 2002:a4a:e882:0:b0:570:d852:f77f with SMTP id
 g2-20020a4ae882000000b00570d852f77fmr2942230ooe.1.1692640881531; Mon, 21 Aug
 2023 11:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com> <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
 <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com> <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
 <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com> <CAJZ5v0jEcD_1+jHfAk9eN0YYJFbDZN2rZ97KHyH2-w6EqRN9+g@mail.gmail.com>
 <43b65307-bc3f-4014-9bf8-a96c6ed15d9b@amd.com> <CAJZ5v0g+uVZwoOr-2W19Ux9u-D=WiY=-dtcQZwYU0Ov_GE5d=w@mail.gmail.com>
In-Reply-To: <CAJZ5v0g+uVZwoOr-2W19Ux9u-D=WiY=-dtcQZwYU0Ov_GE5d=w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 20:01:05 +0200
Message-ID: <CAJZ5v0g_DyQAnSuigBc-f0UNmW0mo=0yMadES+0NhphJs_k+cw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Avadhut Naik <avadnaik@amd.com>,
        "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org
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

On Mon, Aug 21, 2023 at 7:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Aug 21, 2023 at 7:35 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
> >
> >
> >
> > On 8/21/2023 12:29 PM, Rafael J. Wysocki wrote:
> > > On Mon, Aug 21, 2023 at 7:17 PM Limonciello, Mario
> > > <mario.limonciello@amd.com> wrote:
> > >>
> > >> On 8/21/2023 12:12 PM, Rafael J. Wysocki wrote:
> > >> <snip>
> > >>>> I was just talking to some colleagues about PHAT recently as well.
> > >>>>
> > >>>> The use case that jumps out is "system randomly rebooted while I was
> > >>>> doing XYZ".  You don't know what happened, but you keep using your
> > >>>> system.  Then it happens again.
> > >>>>
> > >>>> If the reason for the random reboot is captured to dmesg you can cross
> > >>>> reference your journal from the next boot after any random reboot and
> > >>>> get the reason for it.  If a user reports this to a Gitlab issue tracker
> > >>>> or Bugzilla it can be helpful in establishing a pattern.
> > >>>>
> > >>>>>> The below location may be appropriate in that case:
> > >>>>>> /sys/firmware/acpi/
> > >>>>>
> > >>>>> Yes, it may. >
> > >>>>>> We already have FPDT and BGRT being exported from there.
> > >>>>>
> > >>>>> In fact, all of the ACPI tables can be retrieved verbatim from
> > >>>>> /sys/firmware/acpi/tables/ already, so why exactly do you want the
> > >>>>> kernel to parse PHAT in particular?
> > >>>>>
> > >>>>
> > >>>> It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having
> > >>>> something internal to the kernel "automatically" parsing it and saving
> > >>>> information to a place like the kernel log that is already captured by
> > >>>> existing userspace tools I think is "more" useful.
> > >>>
> > >>> What existing user space tools do you mean?  Is there anything already
> > >>> making use of the kernel's PHAT output?
> > >>>
> > >>
> > >> I was meaning things like systemd already capture the kernel long
> > >> ringbuffer.  If you save stuff like this into the kernel log, it's going
> > >> to be indexed and easier to grep for boots that had it.
> > >>
> > >>> And why can't user space simply parse PHAT by itself?
> > >>>   > There are multiple ACPI tables that could be dumped into the kernel
> > >>> log, but they aren't.  Guess why.
> > >>
> > >> Right; there's not reason it can't be done by userspace directly.
> > >>
> > >> Another way to approach this problem could be to modify tools that
> > >> excavate records from a reboot to also get PHAT.  For example
> > >> systemd-pstore will get any kernel panics from the previous boot from
> > >> the EFI pstore and put them into /var/lib/systemd/pstore.
> > >>
> > >> No reason that couldn't be done automatically for PHAT too.
> > >
> > > I'm not sure about the connection between the PHAT dump in the kernel
> > > log and pstore.
> > >
> > > The PHAT dump would be from the time before the failure, so it is
> > > unclear to me how useful it can be for diagnosing it.  However, after
> > > a reboot one should be able to retrieve PHAT data from the table
> > > directly and that may include some information regarding the failure.
> >
> > Right so the thought is that at bootup you get the last entry from PHAT
> > and save that into the log.
> >
> > Let's say you have 3 boots:
> > X - Triggered a random reboot
> > Y - Cleanly shut down
> > Z - Boot after a clean shut down
> >
> > So on boot Y you would have in your logs the reason that boot X rebooted.
>
> Yes, and the same can be retrieved from the PHAT directly from user
> space at that time, can't it?
>
> > On boot Z you would see something about how boot Y's reason.
> >
> > >
> > > With pstore, the assumption is that there will be some information
> > > relevant for diagnosing the failure in the kernel buffer, but I'm not
> > > sure how the PHAT dump from before the failure can help here?
> >
> > Alone it's not useful.
> > I had figured if you can put it together with other data it's useful.
> > For example if you had some thermal data in the logs showing which
> > component overheated or if you looked at pstore and found a NULL pointer
> > dereference.
>
> IIUC, the current PHAT content can be useful.  The PHAT content from
> boot X (before the failure) which is what will be there in pstore
> after the random reboot, is of limited value AFAICS.

To be more precise, I don't see why the kernel needs to be made a
man-in-the-middle between the firmware which is the source of the
information and user space that consumes it.
