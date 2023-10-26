Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A930C7D8839
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjJZSYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjJZSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:24:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CAD1A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:24:03 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cbf47fa563so10786085ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698344643; x=1698949443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnqsda22G2Qc0lGiVQrWJUyVTt/ZCgCquZzH6q8sR6Q=;
        b=aXwRswM0UTgyyGEBlwepDTGSKCcWOhIQLqf+uO4ICVZ19R5785Vlc9Hb4P3TnuMkJM
         D/d0f88gS1Yiq0habu7kxVxXD5JKeUPlc4PnkBPOm636IYh1uuFXL7XxL+vTxM3vla85
         J8hCm6BmANpHg5zvtY53dysVYUSkWgcUzWXvyrx8lB6kollX9LatUVIQBaqlRN+Ue2M/
         0wu8fL+MTQ7pT6PZ5RkoFBw/R/nwyQETe0fBHGHIY/HSsTG+XARTBUAKnUolDOgxiGWQ
         tQExlyvEld0TC+IZfFEZczQ01gTFbfJHkDRA0XK0QGzpxlRK9qU8vQZYL/diuOkPY6RX
         P/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698344643; x=1698949443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnqsda22G2Qc0lGiVQrWJUyVTt/ZCgCquZzH6q8sR6Q=;
        b=SrgP8bQXLLdo+LCI3sJr6lwzhe3W5nUvVggWXYszGcNVXKnzbrMCwbYYzUi0GYOhhc
         Pg5JNVn1awRm9CWcbYuXVlaLO6KcEL66e4EKhlPugZ68EHVHHJRIr3grJZtQ+d6mF4PO
         SJ4X0PuAv5in+RtHJDFYnvAeziJ6LXi1FP+JtjEnN/T6kF7h33s1/OLfGkrZ76CwIV+7
         mR8hw8PoVzlHS16jjtwl3Yk3l3W9X8p7IDSfW/59Jrorfq3Cp5vx43Ukt/R/gF1uVbTJ
         Z00v7NmDM0HwtPeX/8+i4/VGmkwsAGFcW+BuhsG802WyYEadWeaPHFGJ0kE/42Vod3Rw
         7U9w==
X-Gm-Message-State: AOJu0Yz5lHXBJ5g4X7VkUIjPoq6fwFC2EzGF7ynbbOnWtl2bbD+XVU58
        eOzftInyfNrWNVHZkrcDB/1IzdWB27QU1TMNlgg=
X-Google-Smtp-Source: AGHT+IE+o7QR+l7tubrg3r769ZTbF/CKg3EvU6ErUXxmnp6IHl6gjoGlzIV2tfNSbzZtYIWwQ0wHVArrwvqQGig+NkY=
X-Received: by 2002:a17:90b:4389:b0:27c:edd5:6137 with SMTP id
 in9-20020a17090b438900b0027cedd56137mr311202pjb.25.1698344643160; Thu, 26 Oct
 2023 11:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231013031040.152282-1-aford173@gmail.com> <7e16351f-4d70-4451-b3c7-1dadfa41f20b@kontron.de>
In-Reply-To: <7e16351f-4d70-4451-b3c7-1dadfa41f20b@kontron.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 26 Oct 2023 13:23:51 -0500
Message-ID: <CAHCN7xKhbvaVnz1FFc_GX1xFN25ctS2aRDs0ZwY0MazqVgjxFA@mail.gmail.com>
Subject: Re: [RFC] drm: bridge: samsung-dsim: Recalculate timings when
 rounding HFP up
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     dri-devel@lists.freedesktop.org, marex@denx.de,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 1:12=E2=80=AFPM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Hi Adam,
>
> On 13.10.23 05:10, Adam Ford wrote:
> > When using video sync pulses, the HFP, HBP, and HSA are divided between
> > the available lanes if there is more than one lane.  For certain
> > timings and lane configurations, the HFP may not be evenly divisible
> > and it gets rounded down which can cause certain resolutions and
> > refresh rates to not sync.
> >
> > ie. 720p60 on some monitors show hss of 1390 and hdisplay of 1280.  Thi=
s
> > yields an HFP of 110. When taking the HFP of 110 divides along 4 lanes,
> > the result is 27.5 which rounds down to 27 and causes some monitors not
> > to sync.
> >
> > The solultion is to round HFP up by finding the remainder of HFP /
> > the number of lanes and increasing the hsync_start, hsync_end, and
> > htotal to compensate when there is a remainder.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> > This adds support for 720p60 in the i.MX8M Plus.
> >
> > NXP uses a look-up table in their downstream code to accomplish this.
> > Using this calculation, the driver can adjust without the need for a
> > complicated table and should be flexible for different timings and
> > resolutions depending on the monitor.
> >
> > I don't have a DSI analyzer, and this appears to only work on
> > i.MX8M Plus but not Mini and Nano for some reason, despite their
> > having a similar DSI bridge.
>
> I just want to report that I have tested this patch (on top of current
> linux-next) on our Kontron BL i.MX8MM board with the ADV7535 bridge and
> I don't see any change when trying the 30 different modes the monitor
> reports as supported. 18 of those work and 12 don't work.

Thanks for testing this.   I didn't see any regressions on my Mini or
Nano either, but I did see the 720p60 now works on i.MX8M Plus (but
not on Mini/Nano).  I am not sure why, and I don't have a DSI
analyzer.

>
> So at least there is no negative impact in this case.

At least nothing broke.  :-)

>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL
> i.MX8MM with HDMI monitor

I'll add your T-b when I post it again.
>
> Thanks
> Frieder
