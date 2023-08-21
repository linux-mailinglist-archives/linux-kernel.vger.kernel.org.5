Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724F4782F68
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjHUR3h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjHUR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:29:36 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652B3F7;
        Mon, 21 Aug 2023 10:29:35 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6bb1133b063so477180a34.1;
        Mon, 21 Aug 2023 10:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692638974; x=1693243774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3P+KuGPlnzKBtHeaQFjgX9CDae4TDYjbyRQRRHmJZe4=;
        b=B+ZbTIb64HEl8KyzEa5QyoW/sduo8tt74rYUOnU05/dLErErJ3x1sh8Twczwb1tVva
         83D+dJ/GZNev37Vvea7Al5hwLgWx9QU0BMAF5nd9egBmWjnwYQ6PCTAsnt78f5dqzZlm
         +ionV8VRdYjKQvSKZH+Rz65a9/Acd5eOeXLpVYK7ru7a5loaEzkAQfBpVUp/U+JqHr+Y
         rkajAmq7W1unqA2bOhKDUnUTVs/1O2vbu27mBty9F619RaHKAUfKIfF9kc4uaDQxovW4
         biHtT0KToWiDPXYX3kq05dKOKWdzRv2inI+oLr2A/hmc3RS9dQAfar2uBG7k8ou8Yd0r
         NbTw==
X-Gm-Message-State: AOJu0YzInsVxuZzzs0VoR9GMf/Qy3+LQKoIAQGKkF8po3ai7+GblgkXp
        sKOzZh/1dVAk8nvKGQeRm8RE/mYyfVbm8io/ZC2NQqKL
X-Google-Smtp-Source: AGHT+IFuHQUwMT7sVlWc3oOfElQLivsquocgbcFnrekyw/q1oXZKv26fQpAHCv0wmBdE12N3jMyPn3+/aqHknMtu3Bk=
X-Received: by 2002:a4a:bc85:0:b0:560:b01a:653d with SMTP id
 m5-20020a4abc85000000b00560b01a653dmr6850257oop.0.1692638974619; Mon, 21 Aug
 2023 10:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com> <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
 <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com> <CAJZ5v0iPRCJLH5bkKyhjUq_tmjmR6R73fhUm3JnKptcm1cn9fQ@mail.gmail.com>
 <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com>
In-Reply-To: <6bc15195-aa26-4e29-b625-74fca84f7a6f@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 19:29:19 +0200
Message-ID: <CAJZ5v0jEcD_1+jHfAk9eN0YYJFbDZN2rZ97KHyH2-w6EqRN9+g@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 7:17 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 8/21/2023 12:12 PM, Rafael J. Wysocki wrote:
> <snip>
> >> I was just talking to some colleagues about PHAT recently as well.
> >>
> >> The use case that jumps out is "system randomly rebooted while I was
> >> doing XYZ".  You don't know what happened, but you keep using your
> >> system.  Then it happens again.
> >>
> >> If the reason for the random reboot is captured to dmesg you can cross
> >> reference your journal from the next boot after any random reboot and
> >> get the reason for it.  If a user reports this to a Gitlab issue tracker
> >> or Bugzilla it can be helpful in establishing a pattern.
> >>
> >>>> The below location may be appropriate in that case:
> >>>> /sys/firmware/acpi/
> >>>
> >>> Yes, it may. >
> >>>> We already have FPDT and BGRT being exported from there.
> >>>
> >>> In fact, all of the ACPI tables can be retrieved verbatim from
> >>> /sys/firmware/acpi/tables/ already, so why exactly do you want the
> >>> kernel to parse PHAT in particular?
> >>>
> >>
> >> It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having
> >> something internal to the kernel "automatically" parsing it and saving
> >> information to a place like the kernel log that is already captured by
> >> existing userspace tools I think is "more" useful.
> >
> > What existing user space tools do you mean?  Is there anything already
> > making use of the kernel's PHAT output?
> >
>
> I was meaning things like systemd already capture the kernel long
> ringbuffer.  If you save stuff like this into the kernel log, it's going
> to be indexed and easier to grep for boots that had it.
>
> > And why can't user space simply parse PHAT by itself?
> >  > There are multiple ACPI tables that could be dumped into the kernel
> > log, but they aren't.  Guess why.
>
> Right; there's not reason it can't be done by userspace directly.
>
> Another way to approach this problem could be to modify tools that
> excavate records from a reboot to also get PHAT.  For example
> systemd-pstore will get any kernel panics from the previous boot from
> the EFI pstore and put them into /var/lib/systemd/pstore.
>
> No reason that couldn't be done automatically for PHAT too.

I'm not sure about the connection between the PHAT dump in the kernel
log and pstore.

The PHAT dump would be from the time before the failure, so it is
unclear to me how useful it can be for diagnosing it.  However, after
a reboot one should be able to retrieve PHAT data from the table
directly and that may include some information regarding the failure.

With pstore, the assumption is that there will be some information
relevant for diagnosing the failure in the kernel buffer, but I'm not
sure how the PHAT dump from before the failure can help here?
