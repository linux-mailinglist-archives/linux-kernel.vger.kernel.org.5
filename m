Return-Path: <linux-kernel+bounces-102999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F9187B99A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92517B22FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A196BB5D;
	Thu, 14 Mar 2024 08:47:01 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B219EEC4;
	Thu, 14 Mar 2024 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406020; cv=none; b=g1CG9dKytOfL65yrvVDPjCIQubTCmxan3HqNGY2nWout6pYpVT35PZodvPnfF53xPtloUVZG4nJbB5CJbdpBwxakd0JhlVbYM8rwdxURNmFz8Ifdk6X0EaSaShU9EboMApbXipiahYg5d5tsFBxZMpIuxnQ21rw1/YLRG/CMamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406020; c=relaxed/simple;
	bh=mKnXsAYI/ss6So+dYUUb9dxOs5fiv9fvLAbLCbmFzQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjC46u83R250HqErQY8Ly90MPTWOIFWldBjQgbAH7TXkDvEegRzghHtSvBfYTMY6utm8Zk6X+3FTNDM4oRkNXdwsP6n3KjDRffNxLcxDx/4wx5YNoJJRxOUf3HSCHZCdW0kP2m8hTCOsDazDPOO4rwG4d2yRxtczw9hoclP/5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60cbcd04de8so5725167b3.0;
        Thu, 14 Mar 2024 01:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710406016; x=1711010816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLvvkZZSnU/+qpYBQ9xpyqIF6dQN8CEsk8TVZPYIpAY=;
        b=oiXyVIhTOT+EGV4cgoURN2h1E09axt8b2aj9WQCUCmOUlUvD6h5/u/n4wbXs1hArxA
         11bM+ZC0ri+93++JID4DjxOBhln+LfuoXbyusReClOiuGFBU/8nSzzPKxqRnb53Fue4J
         KvvdF1z0hYAUTGlRinAa9ooQVWW95K2kvndIvLxuCxpPYsooRKaCZBWG/sCzBp22zJqG
         mmvkFjA+emrkzr74FbTuzhHXxEWOQpc/7xmjHWLldWq0WQbRBcc2KtynrXrcRTwOL/Bx
         nxcO0xJ44rH89oqRO7+O4V+RS2rrR7fVc0YpnB5zM9zsGz9HTskQbXt5afylyCEIkgrm
         ZxQg==
X-Forwarded-Encrypted: i=1; AJvYcCW5EHBCM6Rl3MzVdjTvGXqHS6Piz7A/ex9SgYc1l+VBpv2vpsgNAPqIO2Bt+05sEmgfuDzWlHn5gHshG30/iojKtuwFCMmMuIapygSmNRMOf34pEuM+N6/hRIhayfxmyahznbC6psfGYA==
X-Gm-Message-State: AOJu0YwP2ESNsbGGsixc2DWKOKHfvaxRsCNng9SjGl8ZojUWUaOdvSJg
	VKN3Ln4d7zGKkayUJHAhSrmdRpMwL/V0Q9lgg9ltHPfp7hLQRVRHK9JpUW+As1o=
X-Google-Smtp-Source: AGHT+IEbkSEuxdj2jhI+pcLJtEiouubeYMGB423cDYGnYQHsR3x1tEXlPjPuHtWo1Cg5pJD/GtbKNA==
X-Received: by 2002:a81:c849:0:b0:60a:4cba:ada1 with SMTP id k9-20020a81c849000000b0060a4cbaada1mr3570104ywl.7.1710406016273;
        Thu, 14 Mar 2024 01:46:56 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id h194-20020a816ccb000000b00609f3bbec15sm186532ywc.110.2024.03.14.01.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 01:46:55 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a0a54869bso6650177b3.1;
        Thu, 14 Mar 2024 01:46:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrgbgPyxJQvenh2j6OZKYhvFxsENZHWD3AWYXBcaYzn5hMTzAMe4sTvcV3DTlrALOim/X+dYusg9paIT3U4CobWZCTaaugqm3+J0qZrhz/zgEIjH8nMKGCe0qQXsSDhWha7ZyMFsRPdg==
X-Received: by 2002:a81:ac5b:0:b0:60a:181f:16d8 with SMTP id
 z27-20020a81ac5b000000b0060a181f16d8mr3334352ywj.5.1710406015279; Thu, 14 Mar
 2024 01:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224052436.3552333-1-saravanak@google.com>
 <CAMuHMdWhm1WaX3X3P7tyB+e-rX=iwkwm8LxE3=gfHzJ1umhsFg@mail.gmail.com> <CAGETcx_g5fdeSibDv8C2S4WpVekMvCQ9srwR3BwCzCU2z3kk-g@mail.gmail.com>
In-Reply-To: <CAGETcx_g5fdeSibDv8C2S4WpVekMvCQ9srwR3BwCzCU2z3kk-g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 09:46:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV-P9nt1htpn-+jicUMA_JsOpf6mszajP9qORNweicLLw@mail.gmail.com>
Message-ID: <CAMuHMdV-P9nt1htpn-+jicUMA_JsOpf6mszajP9qORNweicLLw@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Thu, Mar 14, 2024 at 2:48=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
> On Thu, Feb 29, 2024 at 2:11=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Sat, Feb 24, 2024 at 6:25=E2=80=AFAM Saravana Kannan <saravanak@goog=
le.com> wrote:
> > > Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improv=
e
> > > finding the supplier of a remote-endpoint property") due to a last mi=
nute
> > > incorrect edit of "index !=3D0" into "!index". This patch fixes it to=
 be
> > > "index > 0" to match the comment right next to it.
> > >
> > > Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
> > > Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of a=
 remote-endpoint property")
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1304,7 +1304,7 @@ static struct device_node *parse_remote_endpoin=
t(struct device_node *np,
> > >                                                  int index)
> > >  {
> > >         /* Return NULL for index > 0 to signify end of remote-endpoin=
ts. */
> > > -       if (!index || strcmp(prop_name, "remote-endpoint"))
> > > +       if (index > 0 || strcmp(prop_name, "remote-endpoint"))
> > >                 return NULL;
> > >
> > >         return of_graph_get_remote_port_parent(np);
> > > --
> > > 2.44.0.rc0.258.g7320e95886-goog
> >
> > After this, the "Fixed dependency cycle" messages I reported to be
> > gone in [1] are back.
> >
> > In fact, they are slightly different, and there are now even more of th=
em:
> >
> > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef7000/ports/port@1/endpoint@0
> > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef6000/ports/port@1/endpoint@0
> > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef5000/ports/port@1/endpoint@0
> > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef4000/ports/port@1/endpoint@0
> > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef3000/ports/port@1/endpoint@0
> > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef2000/ports/port@1/endpoint@0
> > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef1000/ports/port@1/endpoint@0
> > -platform fea80000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef0000/ports/port@1/endpoint@0
> > -platform feaa0000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef3000/ports/port@1/endpoint@2
> > -platform feaa0000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef2000/ports/port@1/endpoint@2
> > -platform feaa0000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef1000/ports/port@1/endpoint@2
> > -platform feaa0000.csi2: Fixed dependency cycle(s) with
> > /soc/video@e6ef0000/ports/port@1/endpoint@2
> > -platform fead0000.hdmi: Fixed dependency cycle(s) with
> > /soc/sound@ec500000/ports/port@1/endpoint
> > -platform feae0000.hdmi: Fixed dependency cycle(s) with
> > /soc/sound@ec500000/ports/port@2/endpoint
> > -platform feb00000.display: Fixed dependency cycle(s) with
> > /soc/hdmi@feae0000/ports/port@0/endpoint
> > -platform feb00000.display: Fixed dependency cycle(s) with
> > /soc/hdmi@fead0000/ports/port@0/endpoint
> > -platform hdmi0-out: Fixed dependency cycle(s) with
> > /soc/hdmi@fead0000/ports/port@1/endpoint
> > -platform hdmi1-out: Fixed dependency cycle(s) with
> > /soc/hdmi@feae0000/ports/port@1/endpoint
> > -platform vga-encoder: Fixed dependency cycle(s) with /vga/port/endpoin=
t
> > -platform vga-encoder: Fixed dependency cycle(s) with
> > /soc/display@feb00000/ports/port@0/endpoint
> > +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@feaa=
0000
> > +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@feaa=
0000
> > +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@feaa=
0000
> > +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@feaa=
0000
> > +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef4000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef5000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef6000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef7000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@feae=
0000
> > +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fead=
0000
> > +platform ec500000.sound: Fixed dependency cycle(s) with
> > /soc/i2c@e6510000/codec@10
> > +platform e6ef7000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef6000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef5000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef4000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fea8=
0000
> > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
7000
> > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
6000
> > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
5000
> > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
4000
> > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
3000
> > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
2000
> > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
1000
> > +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
0000
> > +platform fea80000.csi2: Fixed dependency cycle(s) with
> > /soc/i2c@e66d8000/video-receiver@70
> > +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@feaa=
0000
> > +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@feaa=
0000
> > +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@feaa=
0000
> > +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@feaa=
0000
> > +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
3000
> > +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
2000
> > +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
1000
> > +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef=
0000
> > +platform feaa0000.csi2: Fixed dependency cycle(s) with
> > /soc/i2c@e66d8000/video-receiver@70
> > +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fead=
0000
> > +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/sound@ec50=
0000
> > +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/display@fe=
b00000
> > +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@feae=
0000
> > +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/sound@ec50=
0000
> > +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/display@fe=
b00000
> > +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/display@fe=
b00000
> > +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/display@fe=
b00000
> > +platform feb00000.display: Fixed dependency cycle(s) with /soc/hdmi@fe=
ae0000
> > +platform feb00000.display: Fixed dependency cycle(s) with /soc/hdmi@fe=
ad0000
> > +platform cvbs-in: Fixed dependency cycle(s) with
> > /soc/i2c@e66d8000/video-receiver@70
> > +platform hdmi-in: Fixed dependency cycle(s) with
> > /soc/i2c@e66d8000/video-receiver@70
> > +platform fead0000.hdmi: Fixed dependency cycle(s) with /hdmi0-out
> > +platform hdmi0-out: Fixed dependency cycle(s) with /soc/hdmi@fead0000
> > +platform feae0000.hdmi: Fixed dependency cycle(s) with /hdmi1-out
> > +platform hdmi1-out: Fixed dependency cycle(s) with /soc/hdmi@feae0000
> > +platform vga: Fixed dependency cycle(s) with /vga-encoder
> > +platform feb00000.display: Fixed dependency cycle(s) with /vga-encoder
> > +platform vga-encoder: Fixed dependency cycle(s) with /vga
> > +platform vga-encoder: Fixed dependency cycle(s) with /soc/display@feb0=
0000
> >
> > -i2c 2-0010: Fixed dependency cycle(s) with
> > /soc/sound@ec500000/ports/port@0/endpoint
> > +platform ec500000.sound: Fixed dependency cycle(s) with
> > /soc/i2c@e6510000/codec@10
> >
> > -i2c 4-0070: Fixed dependency cycle(s) with
> > /soc/csi2@fea80000/ports/port@0/endpoint
> > -i2c 4-0070: Fixed dependency cycle(s) with
> > /soc/csi2@feaa0000/ports/port@0/endpoint
> > -i2c 4-0070: Fixed dependency cycle(s) with /hdmi-in/port/endpoint
> > -i2c 4-0070: Fixed dependency cycle(s) with /cvbs-in/port/endpoint
> > +platform feaa0000.csi2: Fixed dependency cycle(s) with
> > /soc/i2c@e66d8000/video-receiver@70
> > +platform fea80000.csi2: Fixed dependency cycle(s) with
> > /soc/i2c@e66d8000/video-receiver@70
> > +i2c 4-0070: Fixed dependency cycle(s) with /soc/csi2@fea80000
> > +i2c 4-0070: Fixed dependency cycle(s) with /soc/csi2@feaa0000
> >
> > I guess all of that is expected?
>
> Hi Geert,
>
> Greg has picked up my "post-init-providers" series in his driver core.

You mean https://lore.kernel.org/all/20240305050458.1400667-2-saravanak@goo=
gle.com/?

> Once you pull that in, you should be able to use the
> post-init-providers property to break these cycles. Basically treat it
> like any other supplier binding, but use it to mark the link in the
> cycle that's not real. For the remote-endpoints case, you need to list
> property at the device level. Not the endpoint, port or ports nodes.
>
> Once you add this property, you should see an increase in the number
> of device links that are present after all device probing is done.
> Also, a bunch of existing device links should get converted from
> sync_state_only device links to normal managed device links. Meaning,
> the sync_state_only file under those /class/devlink/<device-link-x>/
> folder should change from "1" to "0".
>
> If that's what you see and it works, then go ahead and send out a
> patch so that the boards you care about have a more
> deterministic/stable probe/suspend/resume ordering.

You mean we have to add additional properties to the DTS?
What about compatibility with old DTBs?

Where are the DT bindings for "post-init-providers"?
I see it was part of earlier submissions, but I cannot find any evidence
they have ever been accepted by the DT maintainers?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

