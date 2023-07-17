Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF7D755913
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGQBff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGQBfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:35:32 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5453E56
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 18:35:27 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 323343F71A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689557726;
        bh=gGX3xQTmz9PWaJDMnjtJtvUca5GVPZygjRmu/4e6C1s=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=FAuxEsjLh5BgfYyqiHcEax3SwDg5XW1vpnT6uGpibzWrkU6J75vZ4Ow0cgArNYtpe
         iU18V7UJreLJwsJ13992nIFbobVDdyIT0hsS8dcVvJKFIGPutiGa4XGG909Jdp6pFr
         LdNWxEhoyAmK3qv1iXPEUvbs9Ypb/deIABXZl0jfXiFnr0cewOjII8eV1bKTGZthkw
         vhAFQzC670DjndpnvFUgZB/FEGeGa4IxAjJq/Ie2+BzJnk+fQ5dlnyM3uyWAMK9plD
         ehJopd/gZblWSgI5KpJp9EPFQmxtiKWFqjYAOzT3xQrgTV6rzWfIR4QMyaWeJtk1Xj
         IZxLCzjrJ8s5w==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-55fe85f4d84so458335a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 18:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689557723; x=1692149723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGX3xQTmz9PWaJDMnjtJtvUca5GVPZygjRmu/4e6C1s=;
        b=jmA8pyB03K+IjMETEibOap3y+57RhSbLc347iOX/IVqAmFJ3ueraR3hCz0o0HaUC9c
         VbYkEVs36dgrj+rTjuodfD2R4J1KHN7eDalXpMndKqw6XsDI9CPkWI8IX2DaUsGMyUE9
         O0H7OG5EnVP/tg/TN+8UNs8K+u+ScvVhK9USNLyD/PF1yg75UpNqMccfxby5mpOH3Djg
         HhtwQIODJcqhoFfwdcLnxBKELsNnI9jqsc/S33Jb3jALWrrkc4WBiu48Lmwn9zmZwpCb
         V7hXvaR2/5HBxeOAAB8mvq6VK+HDdWST90hbCyPY/wJir1LUV/xfF1o0vNqCGnQgXRSw
         f1sg==
X-Gm-Message-State: ABy/qLakqHrFDAd8D9exi6FRuandePzFWgOtsuOfNNuqb+dVB1FrouDn
        XVt0T0x7aUAen2LeNIjSnxt3vBwamTGw2iiBJ2Mhybq1C1ExBcylg0C0ZKBD8ZIRgWU8g1dbxR8
        WhJWQlHHMPz/65MOWPkXf2VaR2BDtgKjlSm9LE4LZzd7RW7AX495mf5O1cCpHck0QNw==
X-Received: by 2002:a17:90a:d3c9:b0:263:1e6c:16f4 with SMTP id d9-20020a17090ad3c900b002631e6c16f4mr11269478pjw.20.1689557723448;
        Sun, 16 Jul 2023 18:35:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxobN/f+m1aPkY9v/WlPtbaNRAt7AlZSB2boqi8H0Y2IutKniynY/ksoUsJno+//N8asRnNj58+SstNFfPxqk=
X-Received: by 2002:a17:90a:d3c9:b0:263:1e6c:16f4 with SMTP id
 d9-20020a17090ad3c900b002631e6c16f4mr11269473pjw.20.1689557723158; Sun, 16
 Jul 2023 18:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230704074506.2304939-1-kai.heng.feng@canonical.com>
 <CAJZ5v0jwO1NJ_x2t3RV-kYDmVY9UtyexznCSZMAmQ-gK4dWCmA@mail.gmail.com>
 <f5a4f802-d6a1-050e-ec70-701048ab1a2f@redhat.com> <CAAd53p5nkE+QdxJwF_mEsNiEHvRwg+4D7yP77H6CDrMWPOX_zQ@mail.gmail.com>
 <615d1d62-514b-0cf4-9725-b899b06ecbc3@redhat.com>
In-Reply-To: <615d1d62-514b-0cf4-9725-b899b06ecbc3@redhat.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 17 Jul 2023 09:35:11 +0800
Message-ID: <CAAd53p42b5+U2U3-grJp41h1XQbu5Q-3VrN+ggXTG7Mr8J_YcQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Invoke _PS0 at boot for ACPI video
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, Jul 10, 2023 at 8:54=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
[snipped]
> > Or put all ACPI devices to D0 at boot?
> > According to the BIOS folks that's what Windows does.
> > This way we can drop acpi_device_fix_up_power* helpers altogether.
>
> Doing that will leave any devices for which we lack a driver at D0 for ev=
er,
> so that IMHO is not a good idea.
>
> I guess calling acpi_device_fix_up_power_extended(device) from the
> ACPI-video code, so that the connector sub-objects are put in D0 is
> somewhat ok. Although I would prefer to see you first try to do
> the same thing from the i915 driver instead.

I was told by vendor that the same design is used on AMD based laptops too.
So I think putting this in ACPI-video is a better approach.

>
> If we do end up doing this from the acpi-video code please add
> a comment above the call why this is done; and as Rafael mentioned
> the commit msg needs to better explain things too.

Sure.

Kai-Heng

>
> Regards,
>
> Hans
>
>
>
> >
> >>
> >> Also can you provide some more info on the hw on which this is being s=
een:
> >>
> >> 1. What GPU(s) is/are being used
> >
> > Intel GFX.
> >
> > AFAIK AMD based laptops also require this fixup too.
> >
> >> 2. If there is a mux for hybrid gfx in which mode is the mux set ?
> >
> > No. This happens to mux-less and dGPU-less laptops.
> >
> >> 3. Wjich method is used to control the brightness (which backlight-cla=
ss-devices show up under /sys/class/backlight) ?
> >
> > intel_backlight.
> >
> >>
> >> And can you add this info to the commit msg for the next version of th=
e patch ?
> >
> > Sure.
> > Can putting all devices to D0 be considered too? It's a better
> > solution for the long wrong.
> >
> > Kai-Heng
> >
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >>
> >>
> >>>
> >>> And yes, Linux doesn't put all of the ACPI devices into D0 during
> >>> initialization, but the above commit has a little to do with that.
> >>>
> >>>> For now explicitly call _PS0 for ACPI video to workaround the issue.
> >>>
> >>> This is not what the patch is doing.
> >>>
> >>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>>> ---
> >>>>  drivers/acpi/acpi_video.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> >>>> index 62f4364e4460..793259bd18c8 100644
> >>>> --- a/drivers/acpi/acpi_video.c
> >>>> +++ b/drivers/acpi/acpi_video.c
> >>>> @@ -2027,6 +2027,8 @@ static int acpi_video_bus_add(struct acpi_devi=
ce *device)
> >>>>         if (error)
> >>>>                 goto err_put_video;
> >>>>
> >>>> +       acpi_device_fix_up_power_extended(device);
> >>>> +
> >>>
> >>> I would like to know what Hans thinks about this.
> >>>
> >>>>         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
> >>>>                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
> >>>>                video->flags.multihead ? "yes" : "no",
> >>>> --
> >>>
> >>
> >
>
