Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79942780DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377669AbjHRONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377652AbjHROMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:12:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B9D30F6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:12:41 -0700 (PDT)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 03F3D3FAA5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692367960;
        bh=s0q3HaxL/YFdL22o+r4tOlZiSRwNRkwNXgdQ3e/hBrs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=lMd3T8pMpd/Tuo8RRnE6zHC98yapqVir43nMazVz2alyDERoReU/5odgUwcaUYBE1
         1XwLCyzAQl7BXyir7AaTeqV8iCfHQ36/kx5+qoUFUnh0Z+YjeOBR+S7uJ0r8ACBGLb
         G8R2dcNO7ncgm4m8xTT6qlQqxiS43shx+xp6w+mAiRrN5ynwPLWClb5885q6MDAwjX
         YzDn/XKQjbp7xJk9csxqi45Ca9fpP3zk9ljkN4NLgumAlWeg2WAcj65s7wJvxgE5IV
         M6gCnWw+ukDDm7wn5SxT259z/p/a68uxQ0yYrlAO0AdZl0Y4JLVXa6HTAo2S2pRAj6
         2AtDM6xgH8SSg==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-565aee6e925so1244997a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692367958; x=1692972758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0q3HaxL/YFdL22o+r4tOlZiSRwNRkwNXgdQ3e/hBrs=;
        b=Mu70T4Dlu5EnmDLnVOcoFUiu9YB0s8AvDlXIloFNGDetVuyHH8lxNPE9heDXUje4uW
         W9LA/rnByIxUnk54IlSEg63jdUMlxRxjbA3cfSEZMFdc8pLYWP9TkDL7WGkaN0HOoiRh
         M8AfHR5CD5mKg8m/S6KdijjFp/XpGyN+v+ZOPv4D+MQCj7A9nmntsIwU0u3jsZBeZIOQ
         +BdYGJxV7Cg6JAKbVXwKiBga2xUsUx4ImCS2OOgwRX4YYSwnz7SHL9g8wA1gj1232hND
         UetNFLeHpV9f1M5O9mc8Ms17hFAppHDwa/Rs50imXuFWsrvqfqeKOoFMOZ5CxcrU/GgW
         Z0Dg==
X-Gm-Message-State: AOJu0Yw0w+e1pAiRkrvpD34UJKEZZ40d+KzquZ2qiLqoB3YkWCj/xzTh
        lzV/xq+TIL3rGfWn2fsU00+WZyDFkkA4VJ8ylpy0jyKxA2sOtKNBoX2/CMQ3Cmg1yeAllIuoHIb
        C2Ft/7wbKf5j8wCSTQv9HWY3OOc5RbBOHz5LRYiedP/hmlwt2+8cGNAMB2g==
X-Received: by 2002:a17:90a:c287:b0:26b:2e08:a5b3 with SMTP id f7-20020a17090ac28700b0026b2e08a5b3mr2519376pjt.34.1692367958388;
        Fri, 18 Aug 2023 07:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXhkm9RtOaa/xkyFHsIiSyqcHHZM1TvdVeesK8hEIt3vspHa/4YdzWGXHqKj/HIPC4Y5Cdevbys1wn9TNk92o=
X-Received: by 2002:a17:90a:c287:b0:26b:2e08:a5b3 with SMTP id
 f7-20020a17090ac28700b0026b2e08a5b3mr2519335pjt.34.1692367957744; Fri, 18 Aug
 2023 07:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230817093305.212821-1-kai.heng.feng@canonical.com>
 <cab8a29b-816c-41c7-8d2a-418f787e406e@rowland.harvard.edu>
 <59898e32-f2ea-4df7-947b-3d74835ff9b7@rowland.harvard.edu>
 <CAAd53p5pxGfS0y260NsMF+m_Ota+d1ZKbtdq4dfM5s+T1z14bw@mail.gmail.com> <b08553d7-017e-477c-b18e-8564fe88646b@rowland.harvard.edu>
In-Reply-To: <b08553d7-017e-477c-b18e-8564fe88646b@rowland.harvard.edu>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 18 Aug 2023 22:12:25 +0800
Message-ID: <CAAd53p5EJG=gUOt48mk=o2QdMjoR-FgQqkt80BQX8f8uph4MVg@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:08=E2=80=AFAM Alan Stern <stern@rowland.harvard.=
edu> wrote:
>
> On Fri, Aug 18, 2023 at 08:01:54AM +0800, Kai-Heng Feng wrote:
> > On Thu, Aug 17, 2023 at 10:22=E2=80=AFPM Alan Stern <stern@rowland.harv=
ard.edu> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 10:07:37AM -0400, Alan Stern wrote:
> > > > On Thu, Aug 17, 2023 at 05:33:05PM +0800, Kai-Heng Feng wrote:
> > > > > HP ProOne 440 G10 AIO sometimes cannot suspend as xHCI wakes up t=
he
> > > > > system:
> > > > > [  445.814574] hub 2-0:1.0: hub_suspend
> > > > > [  445.814652] usb usb2: bus suspend, wakeup 0
> > > > > [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id=
 11, portsc: 0x202a0
> > > >
> > > > What is the meaning of the 0x202a0 bits?  What caused this wakeup?
> > >
> > > And more to the point, given that the previous line says "wakeup 0", =
why
> > > should any port change event cause a wakeup?
> >
> > I think the controller and roothub have to deal with the interrupt
> > about disconnecting regardless of the remote wakeup setting.
>
> This seems to contradict what you wrote in an earlier email:

Nothing is contradicting, what I mentioned is the wakeup of USB
touchpanel, not the controller or root hub.

>
> > > If remote wakeup isn't enabled then the do_wakeup variable will be 0,
> > > so your patch wouldn't make any difference.  The question is what
> > > happens when remote wakeup _is_ enabled.
> >
> > Nothing happens either per my testing.
> >
> > For USB keyboard, the remote wakeup is enabled, unplugging it when
> > suspend is suspended doesn't wake the system up, despite of PORT_WKDISC=
_E being set.
> > Plugging it back doesn't wake the system up either, despite of PORT_WKC=
ONN_E.
>
> You appear to be saying that when wakeup is disabled, unplugging a
> device will wake up the system -- but when wakeup is enabled, unplugging
> a device will not wake up the system!

No, what I was saying is that when PORT_WKCONN_E and PORT_WKDISC_E are
set, plugging/unplugging USB doesn't wake up the system from suspended
state.
What it really does for this case is to hinder the suspending process.

>
> Is that really what you meant?  It doesn't make sense.  Probably means
> there's a bug in the HCD.
>
> The point I'm trying to get at is that if wakeups are disabled for both
> the host controller and the root hub then _nothing_ should generate an
> interrupt or wakeup request.  Not pressing a key, not unplugging a
> device... nothing.  But if wakeup _is_ enabled for both the controller
> and the root hub, then any of those actions should generate an interrupt
> and wake up the system.

Like above, the wakeup I mentioned is on the USB touchpanel itself,
not on the controller and roothub.
There's no IRQ generated when controller's wakeup is disabled.

>
> If wakeup is enabled for the host controller but not for the root hub,
> then unplugging a device from the root hub should not generate a wakeup
> request or an interrupt.  But things like pressing a key on a
> wakeup-enabled keyboard should.  (In other words, the root hub shouldn't
> generate any wakeup requests on its own but it should relay wakeup
> requests that it receives from downstream devices.)  However, it's
> understandable if the system doesn't behave properly in this case since
> it's kind of an odd situation.

Do you mean when the system is suspended, or system is still suspending?
The issue only happens when the system is suspending.

Kai-Heng

>
> Alan Stern
