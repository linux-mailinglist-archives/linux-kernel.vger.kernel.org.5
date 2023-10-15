Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960177C97D1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 06:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjJOEAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 00:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjJOEAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 00:00:30 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54698DC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 21:00:26 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-577fff1cae6so2352635a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 21:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697342426; x=1697947226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzO4BqlPO7qDmEdeQReZNA+4qs9vum2qt+JfzQGEZSI=;
        b=Y1S+MeNiZEUvHZ8Q0ktJrTII/ZpYTt/xVL3ztOICGYij7iu/O0nf31PNwg/AGzwJ1w
         QZBsBlxJL8X71xmTuzypzCjahbf6SspkAWog9FBNzm8QFbpwID9jTcp8FqKhOa/QF5dP
         cnRIPNjWwJlalYp0PbLcN565BIT3nY9EoxNUnGs7INKNygpj8SuGr+39cbeshL/P8kpk
         3r8OlVS8t5fKLjL5k671el3tuBxb6ki0fXP6kydK6wed0FH4saPBCCZI2Dkhuo1qI2+Q
         tE3RrFusDAC4Lc/L09cGxQZAaEFZ5Ft1irEuhRWhZn1IIpUOHSgTA03orAQIEJzQHSpS
         4ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697342426; x=1697947226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzO4BqlPO7qDmEdeQReZNA+4qs9vum2qt+JfzQGEZSI=;
        b=ffqL+JURSsa57AX2taJXUaApYYWgopXGLgWUiQIburqrAoEZFA1Ol0DOiWlIGuybjU
         Ahn69NMw6x9bMGwS+OprYRArvVVJFgiaZNtivf80vTXPB+iTgIm6iv0qn6cPI1wFFWhP
         Pe2pAUPanQ+xBi7nkscvxFDijzSB489RHN9oAVa+tpvcGOIeCGxL/ILHeL4op9wyOC6j
         QaiSXe1kPBzK1iRzU6CWf7i8WyraXMbBwfHKH8oVvi380/lT7UDN7O9OuRzjDDqcskwQ
         m571RxJ9R3D6A/AoF+dGTooi7xGcl0za1NviLPPi6hfy+Y+lWkyYnWv1iRRvkRa4Rl3K
         YBaw==
X-Gm-Message-State: AOJu0YyqnEK1kUNjT/oD1+D8j1bJYEXoXv0G3I3EoF8gcJ0K1UlCujxf
        BObbQ3O9fgLdQ6TUR2TrVo2wjbhtA9oMDHtDAcmzOg==
X-Google-Smtp-Source: AGHT+IENIyXuZvVQEb1c9JRKIDTyTcixWzrs+mdKGzh6VX0i9HeDX6JW7W6SwgDg2IJ/5YjezZPsnwa1SSHIzoeQCFw=
X-Received: by 2002:a17:903:41d0:b0:1bc:4415:3c1 with SMTP id
 u16-20020a17090341d000b001bc441503c1mr6507153ple.7.1697342425521; Sat, 14 Oct
 2023 21:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231014031709.1900370-1-badhri@google.com> <636e2ace-30cb-4d05-b67f-7047f6fad2a9@roeck-us.net>
In-Reply-To: <636e2ace-30cb-4d05-b67f-7047f6fad2a9@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Sat, 14 Oct 2023 20:59:48 -0700
Message-ID: <CAPTae5+omQJRcNZ5V8+3rRe6WZ0r1nG_w9Q-AMsqnKBOWkw2tg@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Check for sink pdp op current only
 for pd
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        kyletso@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdbabiera@google.com,
        amitsd@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 4:59=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Sat, Oct 14, 2023 at 03:17:09AM +0000, Badhri Jagan Sridharan wrote:
> > TCPM checks for sink caps operational current even when PD is disabled.
> > This incorrectly sets tcpm_set_charge() when PD is disabled.
> > Check for sink caps only when PD is disabled.
>                                       ^^^^^^^^
>
> enabled ?

Ah yes ! Fixed in V2. Reworded the commit title as well.

Thanks,
Badhri

>
>
> >
> > [   97.572342] Start toggling
> > [   97.578949] CC1: 0 -> 0, CC2: 0 -> 0 [state TOGGLING, polarity 0, di=
sconnected]
> > [   99.571648] CC1: 0 -> 0, CC2: 0 -> 4 [state TOGGLING, polarity 0, co=
nnected]
> > [   99.571658] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> > [   99.571673] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ =
170 ms [rev3 NONE_AMS]
> > [   99.741778] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 1=
70 ms]
> > [   99.789283] CC1: 0 -> 0, CC2: 4 -> 5 [state SNK_DEBOUNCED, polarity =
0, connected]
> > [   99.789306] state change SNK_DEBOUNCED -> SNK_DEBOUNCED [rev3 NONE_A=
MS]
> > [   99.903584] VBUS on
> > [   99.903591] state change SNK_DEBOUNCED -> SNK_ATTACHED [rev3 NONE_AM=
S]
> > [   99.903600] polarity 1
> > [   99.910155] enable vbus discharge ret:0
> > [   99.910160] Requesting mux state 1, usb-role 2, orientation 2
> > [   99.946791] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
> > [   99.946798] state change SNK_STARTUP -> SNK_DISCOVERY [rev3 NONE_AMS=
]
> > [   99.946800] Setting voltage/current limit 5000 mV 500 mA
> > [   99.946803] vbus=3D0 charge:=3D1
> > [  100.027139] state change SNK_DISCOVERY -> SNK_READY [rev3 NONE_AMS]
> > [  100.027145] Setting voltage/current limit 5000 mV 3000 mA
> > [  100.466830] VBUS on
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 34fde9ec08a3 ("FROMGIT: usb: typec: tcpm: not sink vbus if opera=
tional current is 0mA")
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcp=
m.c
> > index 6e843c511b85..994493481c24 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -4268,7 +4268,8 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >                               current_lim =3D PD_P_SNK_STDBY_MW / 5;
> >                       tcpm_set_current_limit(port, current_lim, 5000);
> >                       /* Not sink vbus if operational current is 0mA */
> > -                     tcpm_set_charge(port, !!pdo_max_current(port->snk=
_pdo[0]));
> > +                     tcpm_set_charge(port, port->pd_supported ?
> > +                                     !!pdo_max_current(port->snk_pdo[0=
]) : true);
> >
> >                       if (!port->pd_supported)
> >                               tcpm_set_state(port, SNK_READY, 0);
> >
> > base-commit: 1034cc423f1b4a7a9a56d310ca980fcd2753e11d
> > --
> > 2.42.0.655.g421f12c284-goog
> >
