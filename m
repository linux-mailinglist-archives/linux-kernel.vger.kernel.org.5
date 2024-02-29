Return-Path: <linux-kernel+bounces-86520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7619286C67C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1179B2986E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B986350F;
	Thu, 29 Feb 2024 10:11:57 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ADE6280C;
	Thu, 29 Feb 2024 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201516; cv=none; b=PS0qtYbHaHYk9U9+7aW18QEhxki+HXbACRg8gaRvOE56eiGOe+PAbLGfxtmUDYFtE6bv79Eo6bmKb4uhbsGNX1nJwfQJbJlfHeDfl8ouWaGpAwXeKurlaGA5mNL5sUAYC0af5b5IkdinCPVSrfMZnoxO823H9yRDSoBPKIJVomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201516; c=relaxed/simple;
	bh=GyGUdXIg/byhkhi4PY7TzcTxrUGkdHFdA4AEWVhCBTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7RvnJwNXm2KO9aL9fLJCGw5gJl2QMMEMC0eudJ5I6T7VM7TXYLYfiAXYmeE36ivJiCE1YawIhObtIgj4qH/QRuoyjYY4THirJI4XL9zJCMMGeHOT96805pM9EqNF3detYRsvVNKNOdTn86D7NxiPp2tS9ls1iX3EBEc8wOEV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6093247d1acso7298827b3.0;
        Thu, 29 Feb 2024 02:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709201513; x=1709806313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlayGp3B7LHt3ezElVfSVkqAS1u/HUJTCJbUomcuaEU=;
        b=A0Z0uJysc+8qfqDI9G8hx2OpibdAs6tjTXSIRYLPksWJ3AUXJ/DHuI8lwnjowDkOcM
         ap13mGi7vk6prGbjWOHUSBJQoAWLkaiv/Wi7GAWlTiPo+be6w8biQWl94NdVFpyVtUJO
         AZF6SMopCUwldlixyeScfWsw03NtArV5nqUfTb5Ip0klQr1kxBRWqyArsrQvq8YInDw0
         nruTzOXnYjGba6D9tR/Ym7yRM9KfwqJQw2t1a1D8ydcayGiQIBBiDb03xiMjqgT6TXq9
         oz0yuQy+hcuP6gQkIhNGnOgRj4DktbL5k49CEmwD2Hc+jhRIYU8SCoAvI1subS8QYTSb
         0ciw==
X-Forwarded-Encrypted: i=1; AJvYcCVi2e06KQsiOksWSRplcAGb0YDURKRc6xVRuX7hfPFakHhD0Rer9UxnGT7LBhlH/iy2Ocl9d5jg77emqfO7A0EwJhml9oEmo+isJebV5L79nf6Ooer/1HcmqAR4223Phj1BlFhKYSNn+A==
X-Gm-Message-State: AOJu0YwMLHoQfIcu2XTM/Jth09eJ1lgvYrb+jQ1sVmWY/H7tNTDfWXhz
	RX3kbbPu1VmKA85qOBw+YgGp8a3RHiNyzKUITrDcRq8zx4Y5oIT+Ln5r+cKhfd8=
X-Google-Smtp-Source: AGHT+IHK8Y43Alkij7eS6ZrAWKOBWGQsyNI+1A9kN2pnBs9xLS9XAgK4r8SAOtfojcf1hABaCpXdPw==
X-Received: by 2002:a81:df0f:0:b0:604:a75:4274 with SMTP id c15-20020a81df0f000000b006040a754274mr1866293ywn.51.1709201512718;
        Thu, 29 Feb 2024 02:11:52 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id u125-20020a816083000000b006078f8caa68sm285238ywb.71.2024.02.29.02.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 02:11:52 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so749191276.2;
        Thu, 29 Feb 2024 02:11:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjhsHqla4tJ3TDQa0H6s69GliUxIMNtvIu8USNyYAQxAnXzg/NCEn2Lj3WYN/0TdzU8Q6sYDIFXxxrosDVAM3izDo30RaZGxcflrtEtYnhTZvU/eHyAD5/YXmc+KHmc825Ie9cyanP1A==
X-Received: by 2002:a05:6902:50b:b0:dcf:c6ce:b4ca with SMTP id
 x11-20020a056902050b00b00dcfc6ceb4camr1745346ybs.56.1709201511893; Thu, 29
 Feb 2024 02:11:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224052436.3552333-1-saravanak@google.com>
In-Reply-To: <20240224052436.3552333-1-saravanak@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Feb 2024 11:11:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWhm1WaX3X3P7tyB+e-rX=iwkwm8LxE3=gfHzJ1umhsFg@mail.gmail.com>
Message-ID: <CAMuHMdWhm1WaX3X3P7tyB+e-rX=iwkwm8LxE3=gfHzJ1umhsFg@mail.gmail.com>
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

On Sat, Feb 24, 2024 at 6:25=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
> Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improve
> finding the supplier of a remote-endpoint property") due to a last minute
> incorrect edit of "index !=3D0" into "!index". This patch fixes it to be
> "index > 0" to match the comment right next to it.
>
> Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
> Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of a rem=
ote-endpoint property")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks for your patch!

> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1304,7 +1304,7 @@ static struct device_node *parse_remote_endpoint(st=
ruct device_node *np,
>                                                  int index)
>  {
>         /* Return NULL for index > 0 to signify end of remote-endpoints. =
*/
> -       if (!index || strcmp(prop_name, "remote-endpoint"))
> +       if (index > 0 || strcmp(prop_name, "remote-endpoint"))
>                 return NULL;
>
>         return of_graph_get_remote_port_parent(np);
> --
> 2.44.0.rc0.258.g7320e95886-goog

After this, the "Fixed dependency cycle" messages I reported to be
gone in [1] are back.

In fact, they are slightly different, and there are now even more of them:

-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef7000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef6000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef5000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef4000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef3000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef2000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef1000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef0000/ports/port@1/endpoint@0
-platform feaa0000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef3000/ports/port@1/endpoint@2
-platform feaa0000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef2000/ports/port@1/endpoint@2
-platform feaa0000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef1000/ports/port@1/endpoint@2
-platform feaa0000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef0000/ports/port@1/endpoint@2
-platform fead0000.hdmi: Fixed dependency cycle(s) with
/soc/sound@ec500000/ports/port@1/endpoint
-platform feae0000.hdmi: Fixed dependency cycle(s) with
/soc/sound@ec500000/ports/port@2/endpoint
-platform feb00000.display: Fixed dependency cycle(s) with
/soc/hdmi@feae0000/ports/port@0/endpoint
-platform feb00000.display: Fixed dependency cycle(s) with
/soc/hdmi@fead0000/ports/port@0/endpoint
-platform hdmi0-out: Fixed dependency cycle(s) with
/soc/hdmi@fead0000/ports/port@1/endpoint
-platform hdmi1-out: Fixed dependency cycle(s) with
/soc/hdmi@feae0000/ports/port@1/endpoint
-platform vga-encoder: Fixed dependency cycle(s) with /vga/port/endpoint
-platform vga-encoder: Fixed dependency cycle(s) with
/soc/display@feb00000/ports/port@0/endpoint
+platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@feaa0000
+platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@feaa0000
+platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@feaa0000
+platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@feaa0000
+platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef4000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef5000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef6000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef7000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@feae0000
+platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fead0000
+platform ec500000.sound: Fixed dependency cycle(s) with
/soc/i2c@e6510000/codec@10
+platform e6ef7000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef6000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef5000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef4000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@fea80000
+platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef7000
+platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef6000
+platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef5000
+platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef4000
+platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef3000
+platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef2000
+platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef1000
+platform fea80000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef0000
+platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/i2c@e66d8000/video-receiver@70
+platform e6ef3000.video: Fixed dependency cycle(s) with /soc/csi2@feaa0000
+platform e6ef2000.video: Fixed dependency cycle(s) with /soc/csi2@feaa0000
+platform e6ef1000.video: Fixed dependency cycle(s) with /soc/csi2@feaa0000
+platform e6ef0000.video: Fixed dependency cycle(s) with /soc/csi2@feaa0000
+platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef3000
+platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef2000
+platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef1000
+platform feaa0000.csi2: Fixed dependency cycle(s) with /soc/video@e6ef0000
+platform feaa0000.csi2: Fixed dependency cycle(s) with
/soc/i2c@e66d8000/video-receiver@70
+platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@fead0000
+platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/sound@ec500000
+platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb000=
00
+platform ec500000.sound: Fixed dependency cycle(s) with /soc/hdmi@feae0000
+platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/sound@ec500000
+platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb000=
00
+platform feae0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb000=
00
+platform fead0000.hdmi: Fixed dependency cycle(s) with /soc/display@feb000=
00
+platform feb00000.display: Fixed dependency cycle(s) with /soc/hdmi@feae00=
00
+platform feb00000.display: Fixed dependency cycle(s) with /soc/hdmi@fead00=
00
+platform cvbs-in: Fixed dependency cycle(s) with
/soc/i2c@e66d8000/video-receiver@70
+platform hdmi-in: Fixed dependency cycle(s) with
/soc/i2c@e66d8000/video-receiver@70
+platform fead0000.hdmi: Fixed dependency cycle(s) with /hdmi0-out
+platform hdmi0-out: Fixed dependency cycle(s) with /soc/hdmi@fead0000
+platform feae0000.hdmi: Fixed dependency cycle(s) with /hdmi1-out
+platform hdmi1-out: Fixed dependency cycle(s) with /soc/hdmi@feae0000
+platform vga: Fixed dependency cycle(s) with /vga-encoder
+platform feb00000.display: Fixed dependency cycle(s) with /vga-encoder
+platform vga-encoder: Fixed dependency cycle(s) with /vga
+platform vga-encoder: Fixed dependency cycle(s) with /soc/display@feb00000

-i2c 2-0010: Fixed dependency cycle(s) with
/soc/sound@ec500000/ports/port@0/endpoint
+platform ec500000.sound: Fixed dependency cycle(s) with
/soc/i2c@e6510000/codec@10

-i2c 4-0070: Fixed dependency cycle(s) with
/soc/csi2@fea80000/ports/port@0/endpoint
-i2c 4-0070: Fixed dependency cycle(s) with
/soc/csi2@feaa0000/ports/port@0/endpoint
-i2c 4-0070: Fixed dependency cycle(s) with /hdmi-in/port/endpoint
-i2c 4-0070: Fixed dependency cycle(s) with /cvbs-in/port/endpoint
+platform feaa0000.csi2: Fixed dependency cycle(s) with
/soc/i2c@e66d8000/video-receiver@70
+platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/i2c@e66d8000/video-receiver@70
+i2c 4-0070: Fixed dependency cycle(s) with /soc/csi2@fea80000
+i2c 4-0070: Fixed dependency cycle(s) with /soc/csi2@feaa0000

I guess all of that is expected?

[1] https://lore.kernel.org/all/CAMuHMdVon3mdivZQ0O6D4+va0nGBrUQbDp23bEq661=
QD=3D4t7+g@mail.gmail.com/

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

