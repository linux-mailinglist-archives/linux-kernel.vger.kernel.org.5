Return-Path: <linux-kernel+bounces-17210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5563B8249E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7921C229A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3A2C6A0;
	Thu,  4 Jan 2024 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV7yl2Il"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B42C699
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a279ce3aab9so114822466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704401847; x=1705006647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vvXcTwEAZALu1hwQZOSPIUmEbe0txJKdEjQHOPyvDLw=;
        b=FV7yl2Ils4TaYlgJ5vtH7YNOGe7p+0SVaMyDGXYh2YmZ/MCOPf0KD/0DIF5+OA4eoI
         zIib1yQg8gg9eedUFn8uS7DzJ3m7I7x610KZvLxwex1/VooH3z75z04SZFkI8WZzlcBm
         JjG58NrskckZm2akTiKQNE0XNt/11udzkOwL677S093iKhWGAL1HdAibnVCDFdWXNRyZ
         +gL4sX8ydKvTXUPWO2BjVfg/yoGOzi8wcrdlywfXwi5z9JrbsXHvAiA80cufDQiqJyDp
         QCx1/tnKFJbI7MZi0aqSzp/cly4BwaG76R5yL4lcCaflo8GDBr4peX2x3LmcASIRD73C
         dKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704401847; x=1705006647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvXcTwEAZALu1hwQZOSPIUmEbe0txJKdEjQHOPyvDLw=;
        b=hZkRuk6xz8LtmQFmlyr1GL2185PIeVrK2NRPqmONE6SKB3LZVLfy68YXnQlsCl3zMa
         rQbX4SAoDxgzRRVR+QFc+R5+rH5JCMZaxGgnpBc5FSe+c5twAvjNsc4JenYiqhloLmo0
         AqWMvF6HDHtO2S4DwYShV9eIZzkW6xYnfQwSSxPj3cwcFIc7gEHxkOfqxFOHB2iyiy90
         brg67l3J9oQxo6JciO9Opot8UDo26y/8aIbTezkkPO5esN5HvjAIClLDL9Yid0WHsfJl
         rZovxJD3emrl1DGrHiuslP8g803noqaAcLrcbQ+4Ojj7ZcKwUiG/oH81BR+je6zP6XKE
         EnvQ==
X-Gm-Message-State: AOJu0Yyt4r7HjRJrxBFDri9xDmnzl+7RVE3hykkzAQ/MIRW/mKmcOBKt
	U092XjpYw6HAdQFmtM9Opj5HwdRecAG1u2LTZetvKh8n
X-Google-Smtp-Source: AGHT+IGAdzQYZjuJzmE6y+1Bb22WF9EcRTCKzvT270yYTRlDJusTttSykGloMI1CdsWcopfxh7pRhn6DBbsNtNP1Se0=
X-Received: by 2002:a17:906:c28c:b0:a27:a34e:bcd with SMTP id
 r12-20020a170906c28c00b00a27a34e0bcdmr225146ejz.157.1704401846524; Thu, 04
 Jan 2024 12:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9txBXQR8YsaU2fO1frcGBP6HKTF473Rqae_hwT_yY-dRrg@mail.gmail.com>
 <CAHk-=wg26tNyaOE5jAcEg1t_zK37mHXqJN9nzmYDA3dN_WO5kw@mail.gmail.com>
In-Reply-To: <CAHk-=wg26tNyaOE5jAcEg1t_zK37mHXqJN9nzmYDA3dN_WO5kw@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 5 Jan 2024 06:57:14 +1000
Message-ID: <CAPM=9tyMgtWxXHnJGOpxtbkq5rGwUzovxwcJADrowwrwvkUoww@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 04:50, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 3 Jan 2024 at 18:30, Dave Airlie <airlied@gmail.com> wrote:
> >
> > These were from over the holiday period, mainly i915, a couple of
> > qaic, bridge and an mgag200.
> >
> > I have a set of nouveau fixes that I'll send after this, that might be
> > too rich for you at this point.
> >
> > I expect there might also be some more regular fixes before 6.8, but
> > they should be minor.
>
> I'm assuming you're just confused about the numbering, and meant 6.7
> here and in the subject line.
>
> This seems to be too small of a pull to be an early pull request for
> the 6.8 merge window.

Indeed this is for 6.7 holiday brain hasn't lifted yet, sorry for noise.

Dave.

