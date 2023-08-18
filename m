Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32B3780DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377547AbjHROUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377302AbjHROTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:19:44 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3383C3E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:19:42 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E670D3F0E1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692368380;
        bh=FbIF9YWH2Ax4exXDmRKQyOkt2cFtN9oFzE7/pzCFnRE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=CJybtPK0SQy0N9jysZ0ufHvTE7z23otxadFkOXtOZ9E5Oww2eRbCz3dgyG4kTpRCB
         ykBiC9S5dUsTTWxCW5FVaXR2ip2zgDadUn7W0wE8kLs7ASUpMEsRATNJr9HBgY0nKG
         0Ac8HdYB8o2mnBDVxIshJytyNw5l0hQHwoebsKrRBDQRzU5osRMuYeXTeGPmCauYma
         a1SFD/mI0b43qY2Tj/630JMNJOkEwi6PBddCIJMGz0aHxCbPbJ3q7HLW5QRHSO8cpP
         UEUvpwBLYGGbIdpMnx7tfZPIQgFbYe7AC1HCd05DcAzHDkcJNTXQmDpBk1x/jJ2ntU
         Wh/ywZLydF8LA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26d43d10ce5so1022213a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692368379; x=1692973179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbIF9YWH2Ax4exXDmRKQyOkt2cFtN9oFzE7/pzCFnRE=;
        b=jo9RZD5IeDsqDEQa07hdJkVBNxAqfg8LgwOxym7G2/W5YQlJRTX/mb5bHo67SDTQXr
         1PqRn9aLuhkeQmEr9zaLwihQ2Ab/6zP5magpvPtFIc0QLyXASS4+B8Xz7Ow4Wiw+5kq+
         /gvoOv1DFjcgn1EknfAouMBf7BnD+8hvGd++5L+nwvfB97Qiv+Jn5tY+yj35KV93mPN+
         xcTwG9uglPmtGIsRydnHmMdogdE5QUQ1eWogGkG1ekuhw0rLt7/m92oOw4DxWOQn6OZP
         oxptfpH+1NiXrcaQ6e8MpiG6XprynqVDU692dK2+q/+2M4XqleAXUxjgNpxSmw5JlOJY
         dDWQ==
X-Gm-Message-State: AOJu0Yysfc0XZtESb78RY1i8Z82443hB4OkWmGRceEMTMGxGQvf37cTU
        M1DgsnE0+CljKZlg9vCLvKb1bxEANX6oSWuHZPIKgLTdGSlyrkhxq9j/C8Fx504vSoOBJD+LWch
        aUF85u1DgAkkCh0t4ht6YBjUwHNszAvYliGoEQ0KI7/2gshTX+VoJBHLLXA==
X-Received: by 2002:a17:90b:3101:b0:26b:4c08:cc32 with SMTP id gc1-20020a17090b310100b0026b4c08cc32mr2754968pjb.25.1692368379540;
        Fri, 18 Aug 2023 07:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7Qa2XckECZ20M9V/NTv1M6iDutryH5oK8v4aA6relY+I0jb+/jzXvyju62tG5CmfZjfHJou75cWWwK7yKRXA=
X-Received: by 2002:a17:90b:3101:b0:26b:4c08:cc32 with SMTP id
 gc1-20020a17090b310100b0026b4c08cc32mr2754949pjb.25.1692368379237; Fri, 18
 Aug 2023 07:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230817093305.212821-1-kai.heng.feng@canonical.com>
 <cab8a29b-816c-41c7-8d2a-418f787e406e@rowland.harvard.edu>
 <CAAd53p7HZk5tTvT=dhSk01KSW4W3vCi+hY8aFYRoFzxs8YiiYA@mail.gmail.com> <dc4f5de7-43f1-4dc2-9a2f-39846b4b7cc3@rowland.harvard.edu>
In-Reply-To: <dc4f5de7-43f1-4dc2-9a2f-39846b4b7cc3@rowland.harvard.edu>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 18 Aug 2023 22:19:27 +0800
Message-ID: <CAAd53p5BGyZi--GbeRtffv7OhWEtKvME4Q_RjC6p9BYVLc9f_w@mail.gmail.com>
Subject: Re: [PATCH] xhci: Disable connect, disconnect and over-current wakeup
 on system suspend
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:19=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Fri, Aug 18, 2023 at 08:00:39AM +0800, Kai-Heng Feng wrote:
> > On Thu, Aug 17, 2023 at 10:07=E2=80=AFPM Alan Stern <stern@rowland.harv=
ard.edu> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 05:33:05PM +0800, Kai-Heng Feng wrote:
> > > > The system is designed to let display and touchpanel share the same
> > > > power source, so when the display becomes off, the USB touchpanel a=
lso
> > > > lost its power and disconnect itself from USB bus. That doesn't pla=
y
> > > > well when most Desktop Environment lock and turnoff the display rig=
ht
> > > > before entering system suspend.
> > >
> > > I don't see why that should cause any trouble.  The display gets lock=
ed
> > > and turned off, the touchpanel disconnects from the USB bus, and then
> > > the system goes into suspend.  Why would there be a wakeup signal at
> > > this point?
> >
> > The disconnecting can happens during the system suspend process, so
> > the suspend process is aborted.
>
> Maybe these systems need to add a little delay when the display is
> turned off, in order to give the touchpanel time to disconnect before
> the system suspend begins.

Unfortunately the hardware can't be changed.

>
> > > > So for system-wide suspend, also disable connect, disconnect and
> > > > over-current wakeup to prevent spurious wakeup.
> > >
> > > Whether to disable these things is part of the userspace policy.  The
> > > kernel should not make the decision; the user does by enabling or
> > > disabling wakeups.
> >
> > The power/wakeup is already disabled.
>
> In that case the root hub should not generate a wakeup request in
> response to the touchpanel disconnecting.

Here's the wakeup setting when the issue happens:
controller - wakeup enabled
root hub: wakeup disabled
touchpanel: wakeup disabled

>
> > The disconnecting event is from roothub and if roothub wakeup is
> > disabled, other USB devices lose the ability to wake the system up
> > from system suspend.
>
> That shouldn't happen either.  Disabling wakeup on the root hub should
> not prevent the root hub from relaying wakeup requests it receives from
> downstream devices.  It should merely prevent the root hub from
> generating its own wakeup requests for connects, disconnects, and
> over-current events.

Sorry, it was meant to be the xHCI controller. The didn't make the
difference clear.

>
> It sounds like the xhci root-hub code isn't doing the right thing, at
> least, not on your systems.

I still don't fully understand why removing PORT_WAKE_BITS is not
right in this case.

Kai-Heng

>
> Alan Stern
