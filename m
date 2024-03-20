Return-Path: <linux-kernel+bounces-108863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A580088110F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A81D1F21B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E4B3EA9B;
	Wed, 20 Mar 2024 11:33:51 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6833D984;
	Wed, 20 Mar 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934431; cv=none; b=krGkB8PMItBPPH5U45+tP1xU9e8Ggafkg/0yOaUq71x1WF6+po4K18S9011UG/fBq8/PLV3SB1hIb0K9i6B+PulDCbRlQzsWtiFmBJOE+DIRiK6zjy1MMSTNe+oUSoz8Y1pm5Cv92EwnQYZT59h2jsgNgk/SIHP5HEkI6fF9G/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934431; c=relaxed/simple;
	bh=TM83wFJ2guz+/lEd7su3mafeUQuopsAVbb4NPytC03I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jV4JBMvok6ZGnCQ5HWVNuX6thXq2X0V9aVReYh1gpqOQUI/aMHMFEELEjUETuuQuzUCWGDjbQxG6CcFhiNyIrcEkUf92+kLtIzgNnTggG2T4DyET335EQ/SjptVAzuxvh9SNzEHUJuk7iJ7xmzTNsB7kWH1VhgZ010vWWjRsahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60a057b6601so65333277b3.2;
        Wed, 20 Mar 2024 04:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710934428; x=1711539228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SF8arMhnBafDCLx4QC8exH3xhVUS30LSGL4oZz18twc=;
        b=O84MG1gKLPW3GXl5s5QAyK6FVv2cgW85noX/lbYBCmyk9eCF04qlfmc9H9sXuBcw41
         qy3lHcC7GgsvbIVcAhCJojO1rXOsRM6Y69sbRDsYEEbKAwlPiEJ+Ci44KI9jA6ChjDQx
         NgguWqVyOlXoEy75gXWma4bVQ/bIFARUoCD/8/+c/cWicIsX8uFzTxJ7nlDW/TNfu4lS
         IhtncB8qUpYYa2azRG2ELAziTxYSsHsqYcEcOtEF6I2GabtkQLzMt5XYhkH8LjjItaXJ
         xo5aUQxT+qHTa3y4WUbjbAvsOtd5CxaKVK4lk//dJwcfV36dRzgxfPl5ETIWCf5zwXSj
         RSBg==
X-Forwarded-Encrypted: i=1; AJvYcCXoiJQOrtr7WTMKAEiNJvGIbcOSlTSTRoVw1it7QLfF9zguqFF0cgn0IKnLT5lM0s0ZEW7Ijd11iMza9xt3h012v3x6w7VeE2Df2G865Vhu4puKvA9/3MwthMTK5ruXa9pQXvCApdEKQXhXQ3ZD2picdSHB00D/wTDJJVse9V36b2P456uxwkkuOkQ=
X-Gm-Message-State: AOJu0Yxjbl57ayzn3jhiaNV43NeVjanObNi4XY9Z/IFWvkOzX/2+HmwJ
	47TzOjtt8SInlmNMKlclu1A44UsxPtafsEdmDXjSQjPqQc1K8S5H3L0ZJecS5aY=
X-Google-Smtp-Source: AGHT+IHxdcT3Vlq+G7b0AuOJ9BLn2cXROpmW03r7w+b2v9Phge8aSwlWx7KJIkp5FKZuXm164yUFRg==
X-Received: by 2002:a25:8407:0:b0:dcb:fa70:c09 with SMTP id u7-20020a258407000000b00dcbfa700c09mr1222639ybk.28.1710934427893;
        Wed, 20 Mar 2024 04:33:47 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id v139-20020a252f91000000b00dcbbea79ffcsm2639213ybv.42.2024.03.20.04.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 04:33:47 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60a3c48e70fso71565767b3.1;
        Wed, 20 Mar 2024 04:33:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/WzYEFbV+Pst+iyHF+ECcqswfLxmQZyTWYcp1EYhgoLAFxXwGFAuQ6MMUq4AI/AVgzeGgfjvEVOvxeUHlp/oG5JR06YLVgGpBF72TA/vW8Nr2x42HM01gQMCi+vPxlU98mdRGsNnnOrAXpOUeLeCo3BAb3sJbHUS4TvhxfFgI1meZHElX8aUhdig=
X-Received: by 2002:a81:9ace:0:b0:610:f5ca:8ac with SMTP id
 r197-20020a819ace000000b00610f5ca08acmr1288531ywg.11.1710934427270; Wed, 20
 Mar 2024 04:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320082831.9666-1-paul.barker.ct@bp.renesas.com> <20240320082831.9666-2-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240320082831.9666-2-paul.barker.ct@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 12:33:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX1iJVc1CzwE6P6-Fng8HeHwL8Eq3c_HQCMc=FoVqwJ=Q@mail.gmail.com>
Message-ID: <CAMuHMdX1iJVc1CzwE6P6-Fng8HeHwL8Eq3c_HQCMc=FoVqwJ=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: renesas: r9a07g044: Mark resets array as const
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 9:28=E2=80=AFAM Paul Barker
<paul.barker.ct@bp.renesas.com> wrote:
> The r9a07g044_resets array describes the reset signals in this SoC and
> does not change at runtime.
>
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.10.

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

