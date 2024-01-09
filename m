Return-Path: <linux-kernel+bounces-21310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E483828D66
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BAB1C2391C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD9F3D39A;
	Tue,  9 Jan 2024 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQuoBpjn"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1433A1AF;
	Tue,  9 Jan 2024 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-20400d5b54eso2252532fac.1;
        Tue, 09 Jan 2024 11:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704828538; x=1705433338; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fvSkB8NcbH6dCf0f6q6mmenWoRpDu3bkcddPRwNi4/Q=;
        b=hQuoBpjn5fBYdyA4ubB+sgYUhsyFLpUAux38BczzN7e3BrKOpK3QaO06xeE1uzyPxf
         je5B3ywhHP6uqRWR2ql+z+pZFsHjNjcr0msAcSMLyjwLwh++tN1wFI1S2GB07++wrQEa
         CCMx1uQ9gesj9RoDjHSM5OidqobiBrfEhjYIWw+aIP2GUBWceVqEmmh+diwLZfctJW6e
         oPIL5gSaIkXI35LMJG2oCP6yc1FgLdSrWbqBWONc8RDbfvn56upb/K6j8jMoQbQ2dEQ4
         IoMkPbfyjRTTom2CQUQWH/vWAj6tJpq/XpCruorcJ79cZoSQ2Iq+S9o6AQ1dNlvn4ywB
         XZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704828538; x=1705433338;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvSkB8NcbH6dCf0f6q6mmenWoRpDu3bkcddPRwNi4/Q=;
        b=C4q9zhMWNzHrgQjgprHOPwCOxkNlhiSQBDjVau7Gy8cw3svlRqFNfB69QDq0U1gOik
         LQJ4yOO0+Czq68XrlG6xr5iX/0uLvPRc2b8N9HYl6FmFLVkPnyRqfzoFuIEcTFcpyhtb
         d/4e+vsZl/36Qe3kGuVh0DS8CjwsdfU9og6gtHwdUshLeb5E2TzhKuk1geJECx9Jysqt
         WrymjoM22OQeKT8zwMtTce1u3wwtWPDYpLf3Dmtb94yedXV9Wr7MPQLU48favzI4OumN
         hTnLx/Va3dThjvJrp/K7DV9k5YXkBHyn5aewYaIG1YVPyyt0x/na/bq3Tm9/D7t+ZIu4
         rIuA==
X-Gm-Message-State: AOJu0YxVe+9n1mBhYo2WsfnNfdVFp83kzYVTYoFN8AFfEQOREV7nQuCu
	4bPRAS1hbU2T0E+TSgP1UuI=
X-Google-Smtp-Source: AGHT+IGFird2agEMQv/48+wpoPiULmWbtUHqrMLdGGWWdHYj7BlplRfptc67RPtPQPgsGTSfM2TYQA==
X-Received: by 2002:a05:6870:5e4c:b0:1fa:1f3e:b8a7 with SMTP id ne12-20020a0568705e4c00b001fa1f3eb8a7mr6865965oac.20.1704828537642;
        Tue, 09 Jan 2024 11:28:57 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:1135:ca4a:123c:5e53])
        by smtp.gmail.com with ESMTPSA id m185-20020a6326c2000000b005bd627c05c3sm1978266pgm.19.2024.01.09.11.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:28:57 -0800 (PST)
Date: Tue, 9 Jan 2024 11:28:54 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@chromium.org>
Cc: linux-input@vger.kernel.org, Jonathan Denose <jdenose@google.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>,
	Takashi Iwai <tiwai@suse.de>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add quirk for Lenovo ThinkPad T14 Gen 1
Message-ID: <ZZ2eduF_h7lcBrSL@google.com>
References: <20230925163313.1.I55bfb5880d6755094a995d3ae44c13810ae98be4@changeid>
 <ZWF76ALANQwP_9b1@google.com>
 <CALNJtpUHHaq6g0wSuyaNBxtOE9kt6vDzdAGGu6j=JJdJmerDWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALNJtpUHHaq6g0wSuyaNBxtOE9kt6vDzdAGGu6j=JJdJmerDWQ@mail.gmail.com>

Hi Jonathan,

On Mon, Nov 27, 2023 at 10:38:57AM -0600, Jonathan Denose wrote:
> Hi Dmitry
> 
> On Fri, Nov 24, 2023 at 10:45 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Jonathan,
> >
> > On Mon, Sep 25, 2023 at 04:33:20PM -0500, Jonathan Denose wrote:
> > > The ThinkPad T14 Gen 1 touchpad works fine except that clicking
> > > and dragging by tapping the touchpad or depressing the touchpad
> > > do not work. Disabling PNP for controller setting discovery enables
> > > click and drag without negatively impacting other touchpad features.
> >
> > I would like to understand more on how enabling PnP discovery for i8042
> > affects the touchpad. Do you see it using different interrupt or IO
> > ports? What protocol does the touchpad use with/without PnP? If the
> > protocol is the same, do you see difference in the ranges (pressure,
> > etc) reported by the device?
> >
> > Thanks.
> >
> > --
> > Dmitry
> 
> Without PnP discovery the touchpad is using the SynPS/2 protocol, with
> PnP discovery, the touchpad is using the rmi4 protocol. Since the
> protocols are different, so are the ranges but let me know if you
> still want to see them.

Thank you for this information. So it is not PnP discovery that appears
harmful in your case, but rather that legacy PS/2 mode appears to be
working better than RMI4 for the device in question.

I will note that the original enablement of RMI4 for T14 was done by
Hans in [1]. Later T14 with AMD were added to the list of devices that
should use RMI4 [2], however this was reverted in [3].

Could you please tell me what exact device you are dealing with? What's
it ACPI ID?

[1] https://lore.kernel.org/all/20201005114919.371592-1-hdegoede@redhat.com/
[2] https://lore.kernel.org/r/20220318113949.32722-1-snafu109@gmail.com
[3] https://lore.kernel.org/r/20220920193936.8709-1-markpearson@lenovo.com

Thanks.

-- 
Dmitry

