Return-Path: <linux-kernel+bounces-14135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 282E082183C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F531F21F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB064693;
	Tue,  2 Jan 2024 08:16:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD44431
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e7f0bf46a2so73363927b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 00:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704183395; x=1704788195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vG6YMET/rAdhYaAa0Ujzpcr2MAAod3ZbBY1wyg426ig=;
        b=ixRKADhhs3AQJPiM+rSeDRGhx26d9JNgONPKe4vY7xK3ndKDZ9OCLj/Fv0s7KrrqYv
         yAWO3rA+hQsreT0XEugRWuAPQNQGtwMMDulqSYOyhORl3dUN8pe1PNKzP3/s5iMjDDTn
         Y40bjwK2P8bHZaT4yrf1d4Wg3cwFgjSQFpyjqO/k0or6cot5wGKWByum3XDyV4ASBwPV
         I5wlNiCs7pKPIWvocs64SbDGCeiAH23/dP/pQ6x7lkP0im6jwFWCoIjgymVkkmX4PGgr
         v4pinE2qVjrw2qPNdEavXjSL1gE6BHZWeMiwK9vuOhyOSV6bMG3XLEsQpUj434j/MIXj
         sD9A==
X-Gm-Message-State: AOJu0Yxj3yQrgW+JmIWEmN4t4peehIHttfZqWDRlztJHHWL2US5CNcEZ
	tMpk5LZvR6e4tk1H/Fk/nzOxZb9baAx/gg==
X-Google-Smtp-Source: AGHT+IH4+CXrr/i0sVSbw0nR9NrUEixVMoH1fdThFcvDd9cDYwyYFdetwm3igJJFoq57bp7rgYC1tA==
X-Received: by 2002:a81:df0a:0:b0:5e8:c696:a756 with SMTP id c10-20020a81df0a000000b005e8c696a756mr10641467ywn.102.1704183394968;
        Tue, 02 Jan 2024 00:16:34 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id z4-20020a0df004000000b005e8fa7114dbsm11949523ywe.71.2024.01.02.00.16.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 00:16:34 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5edf3780534so40064347b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 00:16:34 -0800 (PST)
X-Received: by 2002:a81:df0a:0:b0:5e8:c696:a756 with SMTP id
 c10-20020a81df0a000000b005e8c696a756mr10641455ywn.102.1704183394483; Tue, 02
 Jan 2024 00:16:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2023121940-enlarged-editor-c9a8@gregkh>
In-Reply-To: <2023121940-enlarged-editor-c9a8@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2024 09:16:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWHnfwcdXrD6JrcdfxEop1oeMyN3hrvf+iEJQi-xM7pmw@mail.gmail.com>
Message-ID: <CAMuHMdWHnfwcdXrD6JrcdfxEop1oeMyN3hrvf+iEJQi-xM7pmw@mail.gmail.com>
Subject: Re: [PATCH] nubus: make nubus_bus_type static and constant
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: fthain@linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the nubus_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>
> It's also never used outside of drivers/nubus/bus.c so make it static
> and don't export it as no one is using it.
>
> Cc: Finn Thain <fthain@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.8 branch.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

