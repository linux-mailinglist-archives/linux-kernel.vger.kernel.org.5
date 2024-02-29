Return-Path: <linux-kernel+bounces-87651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 410A686D6F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEBD287938
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD333C6BF;
	Thu, 29 Feb 2024 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ctmgOwin"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5016FF32
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246751; cv=none; b=ZPe8nlTSJzePVxb8G14kjnbYRe+cvLt99yXA9q4M2eM0Hr6VSyxJIMm/No3ZQpgJ6eZMksxAuwH3ORqmCTdkIrzMG2UNNyCHE7pmtHHQPnZVx1Jp6M1xeRa47u59jLIZXn5YBBaXgE+H7u6GHp4xPmJM8/55NVpZ3jv1gaTc6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246751; c=relaxed/simple;
	bh=KBmLNxg+vTsphdgCGsyZVLdR0GdbPxP8Op44bt5I+K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4gx8OkEEr8zNMfd9ZLGVVlPqMfeu9a3ERkeq1W2IRuhMOdxHaw5JFH5u/MZy5ZGYEWHqQr6veKsVONhVXdCmVKEtDVSGQKLEgdndV2Oqi4FAQOQgk9J0qYCvZhHAX+AcpBFTrHNlbeOC03bMsr5PxiwoxTvNpEO4nTu1K3ukiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctmgOwin; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42e6939d34fso143171cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709246749; x=1709851549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUPSf0nK67iLiZTGgeeD62efhwdo8oz6h15V6Q4x0lw=;
        b=ctmgOwina/dJQ/FJncBGTVMqCpGPSxVvASS+w3p+57J03LZaywcEbXYMCYoHtgFRoj
         LU2jkWW4qsNVOYTggnoIGA5FRBXbU7kAhjZMHxF9yRakflCZXqsWtL1CdmWCwIpvn8Fs
         Vd84d7l/1uT6wmzaKFh5mwqIgymo7O7hQcgMX9BKklyjqk0QZY9ri8/1xInVB7cgr33i
         E952jg2zReIso/wNNdjEkY5igvZ540QIgDPPTqFN0EqnCkJa0//I4HqY8iUscoKxvyEd
         PnnSn9aupFhW2BL+l7rtJT18aYrq/+oUmQZjt2jGWuvYBrjJKEYjQLHGlJGIZ+oDK8MX
         b7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709246749; x=1709851549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUPSf0nK67iLiZTGgeeD62efhwdo8oz6h15V6Q4x0lw=;
        b=syvYZzjxHPHg/SOuHFuKvyqSqv4DxMrh2O7iV3qrM7akzPxy5pv5Nw3PmS8oJ8szBq
         oNxPxa+hFDjOylqWGrCQNGy0S0tDXzHzxa6Mm9j038BxkHOi0ZelDGURrTVx6UvZazBc
         5/6SSHkx1O2YBfVPBCpjkO7AlXaZ3GrC6j5r2vwYEacm+muxgtOQJgXkxXzUoY22dy/+
         2mUub7UM9vOKaFUWCWsIklD8XjaBTwdX5RGto1rxvVkxFkE97sByGkyePHycQSWWylfw
         /fEyM8uBtWjYQCaXnXZvLQ361jc1bxPxjtjh7tvj09/lNpIwFlVfSdT9d9bpCdgxgUoO
         parg==
X-Forwarded-Encrypted: i=1; AJvYcCW9ssEHSnnYSJeDzJu3N8ZgTXr0FxWADZhvszrmc+na+1yAHdSCjby6EaVJSTw+QEFEf2OO43WoLLcwmorT2pJGU+gtdgVrtQSA7K/F
X-Gm-Message-State: AOJu0YwuXrpKndKpajXT5dHSxuCyt5tvUzK6FvkTHZwS5M2/PZ4PkCTV
	j2ZUMi5bg2hAjCjaSVsW6uJzNUgR2LHcZ2LiHNrH2iwsa/wb/lxzZ9lRo4/ObBIi2JYc4GLLyxH
	t5ginkG+/KbHUamtNJVXK/d7VVddMC+6xOpki
X-Google-Smtp-Source: AGHT+IHt0KuDRvp6qL+OBBAeaMe/OchgiMztSjbX1YYLWcBgHKP54Bv/HKsBhKh2n4I3mvWB4dGR4nk4xqso96y0Jb0=
X-Received: by 2002:ac8:5894:0:b0:42e:bbd5:d11b with SMTP id
 t20-20020ac85894000000b0042ebbd5d11bmr87736qta.2.1709246748752; Thu, 29 Feb
 2024 14:45:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224052436.3552333-1-saravanak@google.com> <CAMuHMdWhm1WaX3X3P7tyB+e-rX=iwkwm8LxE3=gfHzJ1umhsFg@mail.gmail.com>
In-Reply-To: <CAMuHMdWhm1WaX3X3P7tyB+e-rX=iwkwm8LxE3=gfHzJ1umhsFg@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 29 Feb 2024 14:45:10 -0800
Message-ID: <CAGETcx-sZXeSxgtYMvgbR4GEpSo2g7hDH1KshEoqZBHf9C42fw@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:11=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Saravana,
>
> On Sat, Feb 24, 2024 at 6:25=E2=80=AFAM Saravana Kannan <saravanak@google=
com> wrote:
> > Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improve
> > finding the supplier of a remote-endpoint property") due to a last minu=
te
> > incorrect edit of "index !=3D0" into "!index". This patch fixes it to b=
e
> > "index > 0" to match the comment right next to it.
> >
> > Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
> > Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of a r=
emote-endpoint property")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Thanks for your patch!
>
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1304,7 +1304,7 @@ static struct device_node *parse_remote_endpoint(=
struct device_node *np,
> >                                                  int index)
> >  {
> >         /* Return NULL for index > 0 to signify end of remote-endpoints=
 */
> > -       if (!index || strcmp(prop_name, "remote-endpoint"))
> > +       if (index > 0 || strcmp(prop_name, "remote-endpoint"))
> >                 return NULL;
> >
> >         return of_graph_get_remote_port_parent(np);
> > --
> > 2.44.0.rc0.258.g7320e95886-goog
>
> After this, the "Fixed dependency cycle" messages I reported to be
> gone in [1] are back.
>
> In fact, they are slightly different, and there are now even more of them=
:
>
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef7000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef6000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef5000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef4000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef3000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef2000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef1000/ports/port@1/endpoint@0
> -platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef0000/ports/port@1/endpoint@0
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef3000/ports/port@1/endpoint@2
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef2000/ports/port@1/endpoint@2
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef1000/ports/port@1/endpoint@2
> -platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/video@e6ef0000/ports/port@1/endpoint@2
> -platform fead0000.hdmi: Fixed dependency cycle(s) with
> /soc/sound@ec500000/ports/port@1/endpoint
> -platform feae0000.hdmi: Fixed dependency cycle(s) with
> /soc/sound@ec500000/ports/port@2/endpoint
> -platform feb00000.display: Fixed dependency cycle(s) with
> /soc/hdmi@feae0000/ports/port@0/endpoint
> -platform feb00000.display: Fixed dependency cycle(s) with
> /soc/hdmi@fead0000/ports/port@0/endpoint
> -platform hdmi0-out: Fixed dependency cycle(s) with
> /soc/hdmi@fead0000/ports/port@1/endpoint
> -platform hdmi1-out: Fixed dependency cycle(s) with
> /soc/hdmi@feae0000/ports/port@1/endpoint
> -platform vga-encoder: Fixed dependency cycle(s) with /vga/port/endpoint
> -platform vga-encoder: Fixed dependency cycle(s) with
> /soc/display@feb00000/ports/port@0/endpoint
> +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef4000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef5000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef6000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef7000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@feae00=
00
> +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fead00=
00
> +platform ec500000.sound: Fixed dependency cycle(s) with
> /soc/i2c@e6510000/codec@10
> +platform e6ef7000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef6000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef5000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef4000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fea800=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef70=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef60=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef50=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef40=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef30=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef20=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef10=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef00=
00
> +platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@feaa00=
00
> +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef30=
00
> +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef20=
00
> +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef10=
00
> +platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef00=
00
> +platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fead00=
00
> +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/sound@ec5000=
00
> +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb0=
0000
> +platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@feae00=
00
> +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/sound@ec5000=
00
> +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb0=
0000
> +platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb0=
0000
> +platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb0=
0000
> +platform feb00000.display: Fixed dependency cycle(s) with /soc/hdmi@feae=
0000
> +platform feb00000.display: Fixed dependency cycle(s) with /soc/hdmi@fead=
0000
> +platform cvbs-in: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +platform hdmi-in: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +platform fead0000.hdmi: Fixed dependency cycle(s) with /hdmi0-out
> +platform hdmi0-out: Fixed dependency cycle(s) with /soc/hdmi@fead0000
> +platform feae0000.hdmi: Fixed dependency cycle(s) with /hdmi1-out
> +platform hdmi1-out: Fixed dependency cycle(s) with /soc/hdmi@feae0000
> +platform vga: Fixed dependency cycle(s) with /vga-encoder
> +platform feb00000.display: Fixed dependency cycle(s) with /vga-encoder
> +platform vga-encoder: Fixed dependency cycle(s) with /vga
> +platform vga-encoder: Fixed dependency cycle(s) with /soc/display@feb000=
00
>
> -i2c 2-0010: Fixed dependency cycle(s) with
> /soc/sound@ec500000/ports/port@0/endpoint
> +platform ec500000.sound: Fixed dependency cycle(s) with
> /soc/i2c@e6510000/codec@10
>
> -i2c 4-0070: Fixed dependency cycle(s) with
> /soc/csi2@fea80000/ports/port@0/endpoint
> -i2c 4-0070: Fixed dependency cycle(s) with
> /soc/csi2@feaa0000/ports/port@0/endpoint
> -i2c 4-0070: Fixed dependency cycle(s) with /hdmi-in/port/endpoint
> -i2c 4-0070: Fixed dependency cycle(s) with /cvbs-in/port/endpoint
> +platform feaa0000.csi2: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +platform fea80000.csi2: Fixed dependency cycle(s) with
> /soc/i2c@e66d8000/video-receiver@70
> +i2c 4-0070: Fixed dependency cycle(s) with /soc/csi2@fea80000
> +i2c 4-0070: Fixed dependency cycle(s) with /soc/csi2@feaa0000
>
> I guess all of that is expected?

I'm assuming all of these cycles are between devices that use
remote-endpoint/port(s)? If so, yes, these are all expected. It's just
logging things more accurately now.

Once post-init-providers lands, you can use that property to break the
cycles and also allow a better probe/suspend/resume ordering between
these devices.

-Saravana

> [1] https://lore.kernel.org/all/CAMuHMdVon3mdivZQ0O6D4+va0nGBrUQbDp23bEq6=
61QD=3D4t7+g@mail.gmail.com/
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

